Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6999E645370
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Dec 2022 06:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiLGFa1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Dec 2022 00:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLGFaZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Dec 2022 00:30:25 -0500
X-Greylist: delayed 381 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Dec 2022 21:30:24 PST
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C2A54B1B
        for <linux-nfs@vger.kernel.org>; Tue,  6 Dec 2022 21:30:24 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.valinux.co.jp (Postfix) with ESMTP id 43010A8F54;
        Wed,  7 Dec 2022 14:24:02 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
        by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wJbbDB7dbabz; Wed,  7 Dec 2022 14:24:02 +0900 (JST)
Received: from brer.quest.tech.valinux.jp (vagw.valinux.co.jp [210.128.90.14])
        by mail.valinux.co.jp (Postfix) with ESMTP id 15FC4A8F4D;
        Wed,  7 Dec 2022 14:24:02 +0900 (JST)
From:   Hiroshi Shimamoto <h-shimamoto@nec.com>
To:     linux-nfs@vger.kernel.org
Cc:     Hiroshi Shimamoto <h-shimamoto@nec.com>,
        minoura makoto <minoura@valinux.co.jp>
Subject: [PATCH] SUNRPC: serialize gss upcalls for the same uid
Date:   Wed,  7 Dec 2022 14:23:41 +0900
Message-Id: <20221207052341.3163040-1-h-shimamoto@nec.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_DUL,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit 9130b8dbc6ac ("SUNRPC: allow for upcalls for the same uid
but different gss service") introduced `auth` argument to
__gss_find_upcall(), but in gss_pipe_downcall() it was left as NULL
since it (and auth->service) was not (yet) determined.

When multiple upcalls with the same uid and different service are
ongoing, it could happen that __gss_find_upcall(), which returns the
first match found in the pipe->in_downcall list, could not find the
correct gss_msg corresponding to the downcall we are looking for due
to two reasons:

- the order of the msgs in pipe->in_downcall and those in pipe->pipe
  (that is, the order of the upcalls sent to rpc.gssd) might be
  different because pipe->lock is dropped between adding one to each
  list.
- rpc.gssd uses threads to write responses, which means we cannot
  guarantee the order of responses.

We could see mount.nfs process hung in D state with multiple mount.nfs
are executed in parallel.  The call trace below is of CentOS 7.9
kernel-3.10.0-1160.24.1.el7.x86_64 but we observed the same hang w/
elrepo kernel-ml-6.0.7-1.el7.

PID: 71258  TASK: ffff91ebd4be0000  CPU: 36  COMMAND: "mount.nfs"
 #0 [ffff9203ca3234f8] __schedule at ffffffffa3b8899f
 #1 [ffff9203ca323580] schedule at ffffffffa3b88eb9
 #2 [ffff9203ca323590] gss_cred_init at ffffffffc0355818 [auth_rpcgss]
 #3 [ffff9203ca323658] rpcauth_lookup_credcache at ffffffffc0421ebc [sunrpc]
 #4 [ffff9203ca3236d8] gss_lookup_cred at ffffffffc0353633 [auth_rpcgss]
 #5 [ffff9203ca3236e8] rpcauth_lookupcred at ffffffffc0421581 [sunrpc]
 #6 [ffff9203ca323740] rpcauth_refreshcred at ffffffffc04223d3 [sunrpc]
 #7 [ffff9203ca3237a0] call_refresh at ffffffffc04103dc [sunrpc]
 #8 [ffff9203ca3237b8] __rpc_execute at ffffffffc041e1c9 [sunrpc]
 #9 [ffff9203ca323820] rpc_execute at ffffffffc0420a48 [sunrpc]

The scenario is like this. Let's say there are two upcalls for
services A and B, A -> B in pipe->in_downcall, B -> A in pipe->pipe.

When rpc.gssd reads pipe to get the upcall msg corresponding to
service B from pipe->pipe and then writes the response, in
gss_pipe_downcall the msg corresponding to service A will be picked
because only uid is used to find the msg and it is before the one for
B in pipe->in_downcall.  And the process waiting for the msg
corresponding to service A will be woken up.

Actual scheduing of that process might be after rpc.gssd processes the
next msg.  In rpc_pipe_generic_upcall it clears msg->errno (for A).
The process is scheduled to see gss_msg->ctx == NULL and
gss_msg->msg.errno == 0, therefore it cannot break the loop in
gss_create_upcall and is never woken up after that.

This patch introduces wait and retry at gss_add_msg() to serialize
when requests with the same uid but different service comes.

Fixes: Commit 9130b8dbc6ac ("SUNRPC: allow for upcalls for the same uid but different gss service")
Signed-off-by: Hiroshi Shimamoto <h-shimamoto@nec.com>
Signed-off-by: minoura makoto <minoura@valinux.co.jp>

---
 net/sunrpc/auth_gss/auth_gss.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 7bb247c51e2f..696f8c22c594 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -296,14 +296,12 @@ gss_release_msg(struct gss_upcall_msg *gss_msg)
 }
 
 static struct gss_upcall_msg *
-__gss_find_upcall(struct rpc_pipe *pipe, kuid_t uid, const struct gss_auth *auth)
+__gss_find_upcall(struct rpc_pipe *pipe, kuid_t uid)
 {
 	struct gss_upcall_msg *pos;
 	list_for_each_entry(pos, &pipe->in_downcall, list) {
 		if (!uid_eq(pos->uid, uid))
 			continue;
-		if (auth && pos->auth->service != auth->service)
-			continue;
 		refcount_inc(&pos->count);
 		return pos;
 	}
@@ -319,14 +317,31 @@ gss_add_msg(struct gss_upcall_msg *gss_msg)
 {
 	struct rpc_pipe *pipe = gss_msg->pipe;
 	struct gss_upcall_msg *old;
+	DEFINE_WAIT(wait);
 
 	spin_lock(&pipe->lock);
-	old = __gss_find_upcall(pipe, gss_msg->uid, gss_msg->auth);
+retry:
+	old = __gss_find_upcall(pipe, gss_msg->uid);
 	if (old == NULL) {
 		refcount_inc(&gss_msg->count);
 		list_add(&gss_msg->list, &pipe->in_downcall);
-	} else
+	} else {
+		if (old->auth->service != gss_msg->auth->service) {
+			prepare_to_wait(&old->waitqueue, &wait, TASK_KILLABLE);
+			spin_unlock(&pipe->lock);
+			if (fatal_signal_pending(current)) {
+				finish_wait(&old->waitqueue, &wait);
+				refcount_dec(&old->count);
+				return ERR_PTR(-ERESTARTSYS);
+			}
+			schedule();
+			finish_wait(&old->waitqueue, &wait);
+			gss_release_msg(old);
+			spin_lock(&pipe->lock);
+			goto retry;
+		}
 		gss_msg = old;
+	}
 	spin_unlock(&pipe->lock);
 	return gss_msg;
 }
@@ -554,6 +569,10 @@ gss_setup_upcall(struct gss_auth *gss_auth, struct rpc_cred *cred)
 	if (IS_ERR(gss_new))
 		return gss_new;
 	gss_msg = gss_add_msg(gss_new);
+	if (IS_ERR(gss_msg)) {
+		gss_release_msg(gss_new);
+		return gss_msg;
+	}
 	if (gss_msg == gss_new) {
 		int res;
 		refcount_inc(&gss_msg->count);
@@ -732,7 +751,7 @@ gss_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 	err = -ENOENT;
 	/* Find a matching upcall */
 	spin_lock(&pipe->lock);
-	gss_msg = __gss_find_upcall(pipe, uid, NULL);
+	gss_msg = __gss_find_upcall(pipe, uid);
 	if (gss_msg == NULL) {
 		spin_unlock(&pipe->lock);
 		goto err_put_ctx;
-- 
2.25.1

