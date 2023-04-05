local Folder = Instance.new("Folder", game.Workspace)
Folder.Name = "waypoints_000"
local part = Instance.new("Part", game.Workspace)
part.Name = "waypoint_000"
part.Position = Vector3.new(1080.58837890625, 376.7653503417969, -405.358001708944)

function getPath()
    local Part
    Part = game.Workspace:FindFirstChild("waypoint_000")
    return Part
end

while true do

    local Destination = getPath()
    local PathfindingService = game:GetService("PathfindingService")
    local LocalPlayer = game.Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()

    local path = PathfindingService:CreatePath({ WaypointSpacing = 1, AgentRadius = 0.1, AgentCanJump = true })
    path:ComputeAsync(Character.HumanoidRootPart.Position, Destination.Position)
    local Waypoints = path:GetWaypoints()

    if path.Status ~= Enum.PathStatus.NoPath then

        Folder:ClearAllChildren()

        for _, Waypoint in pairs(Waypoints) do
            local part = Instance.new("Part")
            part.Size = Vector3.new(1,1,1)
            part.Position = Waypoint.Position
            part.Shape = "Cylinder"
            part.Rotation = Vector3.new(0,0,90)
            part.Material = "SmoothPlastic"
            part.Anchored = true
            part.CanCollide = false
            part.Parent = Folder
        end

        for _, Waypoint in pairs(Waypoints) do
            if Character.HumanoidRootPart.Anchored == false then
                Character.Humanoid:MoveTo(Waypoint.Position)
                Character.Humanoid.MoveToFinished:Wait()
            end
        end
    end
end
