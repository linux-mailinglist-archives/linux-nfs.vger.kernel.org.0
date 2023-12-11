Return-Path: <linux-nfs+bounces-495-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D3280DBAF
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 21:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B321C281EA6
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 20:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC802F55;
	Mon, 11 Dec 2023 20:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrhX+MXp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E88B2F46
	for <linux-nfs@vger.kernel.org>; Mon, 11 Dec 2023 20:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4ACC433C7;
	Mon, 11 Dec 2023 20:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702326937;
	bh=eDm/y62JAKrz0cnaMduV/pGoRHEvmpfUfoMirIKzVEU=;
	h=From:Date:Subject:To:Cc:From;
	b=JrhX+MXpTRpYaOST9R/yuZSXwDl9tuf7nKtHTz6AWVeIJXRzPb3ARe124YvzZA/oz
	 bYGxsG97qEHKnmn2fBkV5AM1x2F7WDL7cVb5jimhcOVjjANWwdYTa+y45V1PsxX8Zd
	 axKSM2jb740MVyGJF+zv8Tj+fAFiGwWpMIxk5XbMUkMmqv1iD4ERAA1337EevYzKEk
	 kP8p5MY/otvgBhTUAjaFY5DElNmBgqeN+xJeiau4XSGB7F/33naBidr9i3z9ufRZtP
	 QOayeDJrbs4YtarEJ4u4/C4T8YKulmEU46YKtNNoJz4zRMIbH7NYK/JiA1KZ5W6Woy
	 sluuHLeREl9cA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 11 Dec 2023 15:35:30 -0500
Subject: [PATCH] nfsd: properly tear down server when write_ports fails
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231211-nfsd-fixes-v1-1-c87a802f4977@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJFyd2UC/x2LQQqAMAzAvjJ6dmArIvoV8SBrp71MWUGEsb87P
 IYkBUyyisHiCmR51PRKDbBzEM49HeKVGwP1NCAh+hSNfdRXzPMcCXkMSDxBG+4sv2j9utX6ASG
 aVHdcAAAA
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Zhi Li <yieli@redhat.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4975; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=eDm/y62JAKrz0cnaMduV/pGoRHEvmpfUfoMirIKzVEU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBld3KX1EvNgC2UdnMV+0GXDrCsdCTFcKk0KZjZ2
 n5aR5HkPUaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZXdylwAKCRAADmhBGVaC
 FaEMEACVsXytDzQkJ9NWp8Rd2G/uyS7dDh7u0ji+RXjDx1TZULc+bQUvcSU3xqAH2mIUhGl1kTZ
 EeDWQJ6XkJH45j5/C8eHSWe9NZoh5K0Z7gJIrJl23YQMBv3y1o/JEg5BIlg4ZvfA01rN1i6ufrh
 gN468CpPBkkuJ4gU2b5G6tQ1qG+nL1ne5Tclo91lfhaN9CWnK8whwNfACCpouOJAYESVkfJIoJz
 CsgnrVeFkwpLU5RRvv4NNKkgjoPgtV+w7VjpXTZbFIfb27sa72MKsoeYtcH+6+xK4hiJLkuc+rB
 iVImMZyX9K58U9PfXX/FFXo/k79AY4kof9T/BF7SIHftLiMjRc/T4782YH+hYbWZ3RSza8x1Z1Z
 zTOJjWxVXcibxApnfrYCiJgwAQODxtTmBooA2nwQvtOytUqBxg2TQ/0z93iAo7SyfRd/9Fn37D/
 8R0z4N59v3blIDsOhDFwRUfJ9QQaeMMNEHJ9wYTPf1zMxnSUREbePIeKr8IMtU1RIUsDHCLIJsB
 miZfdyB14yei75jNvBGAzNw/iLSII5LdgSesMPMvsVV0wb8y+5YSpYDdEIlsePC69g2OjlS+R/3
 8pxRfwm4ty/v69Zj8IMdOj9ERzpvWm8CKigHc++qJUeLfDDAjFzg18NtefQHXQQU+NNtJlOkV+A
 k5rUPocfc5lL59g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When the initial write to the "portlist" file fails, we'll currently put
the reference to the nn->nfsd_serv, but leave the pointer intact. This
leads to a UAF if someone tries to write to "portlist" again.

Simple reproducer, from a host with nfsd shut down:

    # echo "foo 2049" > /proc/fs/nfsd/portlist
    # echo "foo 2049" > /proc/fs/nfsd/portlist

The kernel will oops on the second one when it trips over the dangling
nn->nfsd_serv pointer. There is a similar bug in __write_ports_addfd.

This patch fixes it by adding some extra logic to nfsd_put to ensure
that nfsd_last_thread is called prior to putting the reference when the
conditions are right.

Fixes: 9f28a971ee9f ("nfsd: separate nfsd_last_thread() from nfsd_put()")
Closes: https://issues.redhat.com/browse/RHEL-19081
Reported-by: Zhi Li <yieli@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This should probably go to stable, but we'll need to backport for v6.6
since older kernels don't have nfsd_nl_rpc_status_get_done. We should
just be able to drop that hunk though.
---
 fs/nfsd/nfsctl.c | 32 ++++++++++++++++++++++++++++----
 fs/nfsd/nfsd.h   |  8 +-------
 fs/nfsd/nfssvc.c |  2 +-
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 3e15b72f421d..1ceccf804e44 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -61,6 +61,30 @@ enum {
 	NFSD_MaxReserved
 };
 
+/**
+ * nfsd_put - put the reference to the nfsd_serv for given net
+ * @net: the net namespace for the serv
+ * @err: current error for the op
+ *
+ * When putting a reference to the nfsd_serv from a control operation
+ * we must first call nfsd_last_thread if all of these are true:
+ *
+ * - the configuration operation is going fail
+ * - there are no running threads
+ * - there are no successfully configured ports
+ *
+ * Otherwise, just put the serv reference.
+ */
+static inline void nfsd_put(struct net *net, int err)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv = nn->nfsd_serv;
+
+	if (err < 0 && !nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
+		nfsd_last_thread(net);
+	svc_put(serv);
+}
+
 /*
  * write() for these nodes.
  */
@@ -709,7 +733,7 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 	    !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
 		svc_get(nn->nfsd_serv);
 
-	nfsd_put(net);
+	nfsd_put(net, err);
 	return err;
 }
 
@@ -748,7 +772,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 	if (!nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
 		svc_get(nn->nfsd_serv);
 
-	nfsd_put(net);
+	nfsd_put(net, 0);
 	return 0;
 out_close:
 	xprt = svc_find_xprt(nn->nfsd_serv, transport, net, PF_INET, port);
@@ -757,7 +781,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 		svc_xprt_put(xprt);
 	}
 out_err:
-	nfsd_put(net);
+	nfsd_put(net, err);
 	return err;
 }
 
@@ -1687,7 +1711,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
 {
 	mutex_lock(&nfsd_mutex);
-	nfsd_put(sock_net(cb->skb->sk));
+	nfsd_put(sock_net(cb->skb->sk), 0);
 	mutex_unlock(&nfsd_mutex);
 
 	return 0;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index f5ff42f41ee7..3aa8cd2c19ac 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -113,13 +113,6 @@ int		nfsd_pool_stats_open(struct inode *, struct file *);
 int		nfsd_pool_stats_release(struct inode *, struct file *);
 void		nfsd_shutdown_threads(struct net *net);
 
-static inline void nfsd_put(struct net *net)
-{
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-
-	svc_put(nn->nfsd_serv);
-}
-
 bool		i_am_nfsd(void);
 
 struct nfsdfs_client {
@@ -153,6 +146,7 @@ struct nfsd_net;
 enum vers_op {NFSD_SET, NFSD_CLEAR, NFSD_TEST, NFSD_AVAIL };
 int nfsd_vers(struct nfsd_net *nn, int vers, enum vers_op change);
 int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change);
+void nfsd_last_thread(struct net *net);
 void nfsd_reset_versions(struct nfsd_net *nn);
 int nfsd_create_serv(struct net *net);
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index fe61d9bbcc1f..d6939e23ffcf 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -542,7 +542,7 @@ static struct notifier_block nfsd_inet6addr_notifier = {
 /* Only used under nfsd_mutex, so this atomic may be overkill: */
 static atomic_t nfsd_notifier_refcount = ATOMIC_INIT(0);
 
-static void nfsd_last_thread(struct net *net)
+void nfsd_last_thread(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv = nn->nfsd_serv;

---
base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
change-id: 20231211-nfsd-fixes-d9f21d5c12d7

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


