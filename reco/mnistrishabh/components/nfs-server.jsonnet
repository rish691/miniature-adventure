local env = std.extVar("__ksonnet/environments");
local params = std.extVar("__ksonnet/params").components["nfs-server"];


local k = import "k.libsonnet";
local nfs = import "ciscoai/nfs-server/nfs-server.libsonnet";

// updatedParams uses the environment namespace if
// the namespace parameter is not explicitly set
local updatedParams = params {
  namespace: if params.namespace == "null" then env.namespace else params.namespace,
};


local name = params.name;
local namespace = updatedParams.namespace;

std.prune(k.core.v1.list.new([
  nfs.parts.nfsdeployment(name,namespace),
  nfs.parts.nfsservice(name, namespace)
]))
