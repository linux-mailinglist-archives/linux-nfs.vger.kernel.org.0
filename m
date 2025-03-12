Return-Path: <linux-nfs+bounces-10563-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 843BFA5DE25
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 14:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9523A1897CD2
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 13:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A2C24501B;
	Wed, 12 Mar 2025 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YL4F1y/1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E49924293B;
	Wed, 12 Mar 2025 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786612; cv=none; b=o6ZT1Ol0YM4SoehQ05fUMcODS8ZYuq8Id+lEbl3VxAPMytI9Mj54KWvjPeSOIVKHEjSXvFhKN6P0gKXqskUZMFq5p9DlWWmr6OEuPV6gwa1+UsVBQLaIhRrA5d3duKrQmkAI+8Ja5p70NX3fUlPWmEeSQR3DpGlWhwNWqqA921I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786612; c=relaxed/simple;
	bh=y79pXJ4Od+2hvd3+4EHDD+A70nDTedAiKbF4hsrYSbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PGfs/7oMfrjS+4bA7XY8zb3YsgySNLjfluVY7nFdN8STVnU2Ls/hK5k3ZrWCJzSjVn+5q0pQzQdVyXqGahZQjUPNJOfzJoziTao1rPFgk+XrA7HKl54cmlf5TKEnkeRdgZDK8ps/7Sr05QnSyb+m09MYwliCfVBSj/rI3PZpzJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YL4F1y/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D95AC4CEE3;
	Wed, 12 Mar 2025 13:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741786611;
	bh=y79pXJ4Od+2hvd3+4EHDD+A70nDTedAiKbF4hsrYSbI=;
	h=From:Date:Subject:To:Cc:From;
	b=YL4F1y/1IfKdLAcoJTo1QmOjbaGv6Ev/QiZKpgMqMOaPt6ZYDLdpwWMjd9ZXi0DlW
	 V1CmpfoTg1GuDNseOfV63YoYi+I+bzCSkPZhterHaf6PfMAzJ/HHOE1GxBbUv4wR09
	 ZS6U48bpv/VBLlBgo1s8cBv4i0pGYFzdVFS6UrwFDJ4fD/5yotidn+lFEeW648u/v+
	 Itg0+U70DJoiOrdvMJIMoAxvomrMaVehVHdIqoQgWanwBlT81vPrHdidl2c7rCcu1i
	 xY331HY4NT62Pv9HwPPAKkHhk+MoMVsJyVQZ1avUrcbIjNgIqu2FFfQSgENQN3mFIM
	 BgbtAOEcZ1Hkw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 12 Mar 2025 09:36:44 -0400
Subject: [PATCH] sunrpc: add a rpc_clnt shutdown control in debugfs
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-rpc-shutdown-v1-1-cc90d79a71c2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOuN0WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0Mj3aKCZN3ijNKSlPzyPN3kVMsksxRjU0vLlEQloJaCotS0zAqwcdG
 xtbUAKyDmD14AAAA=
X-Change-ID: 20250312-rpc-shutdown-ce9b6d3599da
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Benjamin Coddington <bcodding@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5057; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=y79pXJ4Od+2hvd3+4EHDD+A70nDTedAiKbF4hsrYSbI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn0Y3yumawZjbtmMAMLA9iBl2LpgtfS9hAp5KBE
 VK+7a/f5nOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ9GN8gAKCRAADmhBGVaC
 Fbh0D/9Pcr5ofMyB+vfLAx/Gcsww/YYNgKW0auT4fMdTxkHvZxjjnVAkUsmR7qVCGbnXDUm5qq2
 cIkj3P0JCO8/V9HezNgSnsEUduNKjVu6rZJUz44Gwb9Hppf3HbjtsLFFYmP5/k43Rx1POcU66b9
 nx8lXFioohDYfQ9ouq8w0LCBX8BxQ8dEoteug6CAWZM+DoMw7lqw8obYnJINwtKVv22QQHGDBww
 OOl9FgHowRc+Mp1NA35tnnYARmv397ZkIsHiRKRbhBpKpYdI22afk8wbvb4t+vKKLXTego6WeuB
 dMi9ScK1CToTIYJJC+FqQe1q2OtuJO6n3uh/qUUUi0G15WcmyS7CS4tkhV22MImTR9hWU4bSDJ6
 BRbZT/FfOZhoNul+WWRMFG/5NepRKZOl1+ZaRHlLDscOgH9FsZuhdWgaZj6IISiw15FO2iu/cWj
 BJ5Y56RG5p1L2PAl21FvEHfve+luwGJ6AuYNUj+VgLWa0y8uShNRZ82+HNda2pnh+cbjcSNvihS
 vb1R1NBLv9W6bRXyixUvorgwg4ebKpVnbFOM5fBqmKY/VNibp5Mpcjk1Xt0DAcmAmrp59F51V1z
 O65V0E1YeRv9KbYYY+tzay1nPiL3DM1SxQccrFpgCZ1U78EV7hxchmt4FAEZ0KaD1aup4WKSHFN
 C+XhSETgjhPuOGg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

There have been confirmed reports where a container with an NFS mount
inside it dies abruptly, along with all of its processes, but the NFS
client sticks around and keeps trying to send RPCs after the networking
is gone.

We have a reproducer where if we SIGKILL a container with an NFS mount,
the RPC clients will stick around indefinitely. The orchestrator
does a MNT_DETACH unmount on the NFS mount, and then tears down the
networking while there are still RPCs in flight.

Recently new controls were added[1] that allow shutting down an NFS
mount. That doesn't help here since the mount namespace is detached from
any tasks at this point.

Transplant shutdown_client() to the sunrpc module, and give it a more
distinct name. Add a new debugfs sunrpc/rpc_clnt/*/shutdown knob that
allows the same functionality as the one in /sys/fs/nfs, but at the
rpc_clnt level.

[1]: commit d9615d166c7e ("NFS: add sysfs shutdown knob").

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/sysfs.c               | 19 ++++---------------
 include/linux/sunrpc/sched.h |  1 +
 net/sunrpc/clnt.c            | 12 ++++++++++++
 net/sunrpc/debugfs.c         | 15 +++++++++++++++
 4 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 7b59a40d40c061a41b0fbde91aa006314f02c1fb..c29c5fd639554461bdcd9ff612726194910d85b5 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -217,17 +217,6 @@ void nfs_netns_sysfs_destroy(struct nfs_net *netns)
 	}
 }
 
-static bool shutdown_match_client(const struct rpc_task *task, const void *data)
-{
-	return true;
-}
-
-static void shutdown_client(struct rpc_clnt *clnt)
-{
-	clnt->cl_shutdown = 1;
-	rpc_cancel_tasks(clnt, -EIO, shutdown_match_client, NULL);
-}
-
 static ssize_t
 shutdown_show(struct kobject *kobj, struct kobj_attribute *attr,
 				char *buf)
@@ -258,14 +247,14 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
 		goto out;
 
 	server->flags |= NFS_MOUNT_SHUTDOWN;
-	shutdown_client(server->client);
-	shutdown_client(server->nfs_client->cl_rpcclient);
+	rpc_clnt_shutdown(server->client);
+	rpc_clnt_shutdown(server->nfs_client->cl_rpcclient);
 
 	if (!IS_ERR(server->client_acl))
-		shutdown_client(server->client_acl);
+		rpc_clnt_shutdown(server->client_acl);
 
 	if (server->nlm_host)
-		shutdown_client(server->nlm_host->h_rpcclnt);
+		rpc_clnt_shutdown(server->nlm_host->h_rpcclnt);
 out:
 	return count;
 }
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index eac57914dcf3200c1a6ed39ab030e3fe8b4da3e1..fe7c39a17ce44ec68c0cf057133d0f8e7f0ae797 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -232,6 +232,7 @@ unsigned long	rpc_cancel_tasks(struct rpc_clnt *clnt, int error,
 				 bool (*fnmatch)(const struct rpc_task *,
 						 const void *),
 				 const void *data);
+void		rpc_clnt_shutdown(struct rpc_clnt *clnt);
 void		rpc_execute(struct rpc_task *);
 void		rpc_init_priority_wait_queue(struct rpc_wait_queue *, const char *);
 void		rpc_init_wait_queue(struct rpc_wait_queue *, const char *);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 2fe88ea79a70c134e58abfb03fca230883eddf1f..0028858b12d97e7b45f4c24cfbd761ba2a734b32 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -934,6 +934,18 @@ unsigned long rpc_cancel_tasks(struct rpc_clnt *clnt, int error,
 }
 EXPORT_SYMBOL_GPL(rpc_cancel_tasks);
 
+static bool shutdown_match_client(const struct rpc_task *task, const void *data)
+{
+	return true;
+}
+
+void rpc_clnt_shutdown(struct rpc_clnt *clnt)
+{
+	clnt->cl_shutdown = 1;
+	rpc_cancel_tasks(clnt, -EIO, shutdown_match_client, NULL);
+}
+EXPORT_SYMBOL_GPL(rpc_clnt_shutdown);
+
 static int rpc_clnt_disconnect_xprt(struct rpc_clnt *clnt,
 				    struct rpc_xprt *xprt, void *dummy)
 {
diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index 32417db340de3775c533d0ad683b5b37800d7fe5..4df31dcca2d747db6767c12ddfa29963ed7be204 100644
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@ -145,6 +145,17 @@ static int do_xprt_debugfs(struct rpc_clnt *clnt, struct rpc_xprt *xprt, void *n
 	return 0;
 }
 
+static int
+clnt_shutdown(void *data, u64 value)
+{
+	struct rpc_clnt *clnt = data;
+
+	rpc_clnt_shutdown(clnt);
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(shutdown_fops, NULL, clnt_shutdown, "%llu\n");
+
 void
 rpc_clnt_debugfs_register(struct rpc_clnt *clnt)
 {
@@ -163,6 +174,10 @@ rpc_clnt_debugfs_register(struct rpc_clnt *clnt)
 	debugfs_create_file("tasks", S_IFREG | 0400, clnt->cl_debugfs, clnt,
 			    &tasks_fops);
 
+	/* make shutdown file */
+	debugfs_create_file("shutdown", S_IFREG | 0200, clnt->cl_debugfs, clnt,
+			    &shutdown_fops);
+
 	rpc_clnt_iterate_for_each_xprt(clnt, do_xprt_debugfs, &xprtnum);
 }
 

---
base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
change-id: 20250312-rpc-shutdown-ce9b6d3599da

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


