Return-Path: <linux-nfs+bounces-16084-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EFEC37795
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 20:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10C3A34EFDE
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 19:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4808232E722;
	Wed,  5 Nov 2025 19:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkdWXeff"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240C329B783
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370891; cv=none; b=ER7fYD2EYTxFN8tnfoMJ4sMI+nRFBOz2GPLfMDqjfAmIFC9yi71MLj1ED0XqKRpnX4xx6f8cosaab2vddvQw5N7puK2L6+PQg3mDcilJi9EOSHH0K0IRytRq5W0pTwEM+uCgvDddfJOs9u/LG9N3XH5pjDG5Dgqm/0TkTiUm04Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370891; c=relaxed/simple;
	bh=wAmIM/AbfAmc5+9SvCw4aFo8+bezOEm99tLw/fP/4YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JB158icgxq3d/4r8Abyp0/weA9InvqS6m/85VDfcpJwgelGysqSpm4sOo+Gx8pOC65RUzptv/AfQ0zF6uGPF36PjzDPHAVP7AzMS487BzOQNOosooUN816cjKFTLS5L+Y/vTwCIVVYDqOtVk/MNkNqGn/y3djR3rpcEW3awx9BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkdWXeff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B77EC19421;
	Wed,  5 Nov 2025 19:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762370890;
	bh=wAmIM/AbfAmc5+9SvCw4aFo8+bezOEm99tLw/fP/4YY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qkdWXefftCQQnMPJWnHZQ/xAzhYuPP5RG4hrinrV5cmK+ACbE7n+Ns0cUIsfj71Sx
	 84Hnus2J/8EOd3W3Wgz2DyEpGlknlnDNsee2Blq1Z6ZtJ/H+Zj9J2TTEabz5GwOEwG
	 8EMR4QxQX7O0yHpCFVRBJ3NfNTbERur0vYyvxBe4Lubyn5m9FntMnOY90angowZcP4
	 WSFc2P2p8jPaJqLHdLP02935RvXdyfc/bx9/S8Rb+D7Rt9UF76oXBo5OeEA2q0FbZb
	 AxxumAnVVEkaMJ63HHyUpL9Z19UBOMoMFMY/1mfYDjk2ERRNr6ReI2NIk75zT6htt5
	 K2kzqw0hTq6+Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH v10 1/5] NFSD: don't start nfsd if sv_permsocks is empty
Date: Wed,  5 Nov 2025 14:28:02 -0500
Message-ID: <20251105192806.77093-2-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105192806.77093-1-cel@kernel.org>
References: <20251105192806.77093-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <okorniev@redhat.com>

Previously, while trying to create a server instance, if no
listening sockets were present then default parameter udp
and tcp listeners were created. It's unclear what purpose
was of starting these listeners were and how this could have
been triggered by the userland setup. This patch proposed
to ensure the reverse that we never end in a situation where
no listener sockets are created and we are trying to create
nfsd threads.

The problem it solves is: when nfs.conf only has tcp=n (and
nothing else for the choice of transports), nfsdctl would
still start the server and create udp and tcp listeners.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 7057ddd7a0a8..b08ae85d53ef 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -249,27 +249,6 @@ int nfsd_nrthreads(struct net *net)
 	return rv;
 }
 
-static int nfsd_init_socks(struct net *net, const struct cred *cred)
-{
-	int error;
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-
-	if (!list_empty(&nn->nfsd_serv->sv_permsocks))
-		return 0;
-
-	error = svc_xprt_create(nn->nfsd_serv, "udp", net, PF_INET, NFS_PORT,
-				SVC_SOCK_DEFAULTS, cred);
-	if (error < 0)
-		return error;
-
-	error = svc_xprt_create(nn->nfsd_serv, "tcp", net, PF_INET, NFS_PORT,
-				SVC_SOCK_DEFAULTS, cred);
-	if (error < 0)
-		return error;
-
-	return 0;
-}
-
 static int nfsd_users = 0;
 
 static int nfsd_startup_generic(void)
@@ -377,9 +356,12 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 	ret = nfsd_startup_generic();
 	if (ret)
 		return ret;
-	ret = nfsd_init_socks(net, cred);
-	if (ret)
+
+	if (list_empty(&nn->nfsd_serv->sv_permsocks)) {
+		pr_warn("NFSD: Failed to start, no listeners configured.\n");
+		ret = -EIO;
 		goto out_socks;
+	}
 
 	if (nfsd_needs_lockd(nn) && !nn->lockd_up) {
 		ret = lockd_up(net, cred);
-- 
2.51.0


