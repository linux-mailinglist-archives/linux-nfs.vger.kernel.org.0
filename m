Return-Path: <linux-nfs+bounces-10638-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FAFA66006
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 22:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0EE19A25A2
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 21:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CFE205AC2;
	Mon, 17 Mar 2025 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNtlFWJu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C503204F63;
	Mon, 17 Mar 2025 21:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245218; cv=none; b=nNNuKRstso80EOsQnl2mMKg9coC4Jf37hLSilE7oDAgcDcdIeVNcx5VXxHqyX6+179FBUGaYbc3BW6QF7HB3TttnLMmG2UB8K1v50y/U3mntNKmSM54Pj+vzWVYaUCWHeoDHVwEIMoWcjOscIAH6sFbYCtmNfkR5zL3QldI1BSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245218; c=relaxed/simple;
	bh=VIYyeSTvZ+KE6fzatpx9PpZw8b244H4HoirdliCtKfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tAsfd4RcHNMOX29KnlmJpja0CgGookNtGOCwFBocML4BXlhmTLIPoXDNInLTBBYC1lxFNIseldzdTctlLNseOGWR4zVQX71JppOO2jcpJk+2MOkKOELaGz3v1oYUMK4yRi6sVuP3KdTy59i4ybrUb78mVBAY6sPvglius2xbfaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNtlFWJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A88C4CEEF;
	Mon, 17 Mar 2025 21:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742245216;
	bh=VIYyeSTvZ+KE6fzatpx9PpZw8b244H4HoirdliCtKfc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iNtlFWJuvmCBckC34H1DPDzeVV8Mxwv3ZXdjFVRQS9Qr6WVFu0kTxjQitylLFsvdD
	 gQD0+ewRpBpl5N9rd8sarptX+xpacESW9eS6weak95OOQRlzHCMdxmPA+pUaeVayfQ
	 9Deg30EGpaO3zvZksfiEDc4vdGRu8gKwrk3+d3/6eknQQdw/wHZqtG0jpf/SwItPqn
	 6hgOI1v/ko3mIyyaGZyGsVvapCT8kAHzNNKLjV6PddnMd1eJ1/Qa1pyeucKwAAQgPd
	 EGqNzjXjB6BwM8jWmFkhxQyurys5vqRkQTkS1STILKPFzJZmzzVliY977VnIVkNT0F
	 a1U+7XIai5qsw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 17 Mar 2025 16:59:57 -0400
Subject: [PATCH RFC 5/9] nfs: don't hold a reference to struct net in
 struct nfs_client
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rpc-shutdown-v1-5-85ba8e20b75d@kernel.org>
References: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
In-Reply-To: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, 
 Benjamin Coddington <bcodding@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3230; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=VIYyeSTvZ+KE6fzatpx9PpZw8b244H4HoirdliCtKfc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn2I1ViDiUEQS0Wt/GAqTra62F1ds5XDzIyXX0N
 523Sc8LPpGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ9iNVQAKCRAADmhBGVaC
 FagmEACJo2L22E2DGsk+XyX0ZAudSnlK2NZLL2gDkXKTriIBasZJet8y+I+FKjyYdykdqLtdSAJ
 GqkJDCqPqv2yMdzQxsJRuitrnmW9x2ccSxz4ByduZczKGCAMc3l/6c8SffMhSeCo/ka6VVEh4Go
 Wf0yE2HETHsPCw3NpZrfcRe3gl0N7gze/CAbWTTUinTcgmFxg1C7zjETKlmV+I9rmGQrDAkdG4s
 mRI3dFr+b/k5pUQT5dvShsUAL/dj7rQ70Ni7CW8H33ByKbJrc39oaOjqdoO8oyH8ybQHeEMUctN
 SEgWZHcmR+NvvXawYf04CSRWLgtGJGmMcWRO8LGrw8SUy5GxP2bn632vuPwm9XJWMXi9foyWvvr
 EwXjvcmw53X2ggrsjLHa75TVdLIaVaPoJYHE2GGTSjeQy4L9P1oYh+ALJy7mrAy+jEVKreqlphX
 bQ6TfQru6BE55hsJHAWDgmmBWTvxMHnbWh8/eO1S0MZIzG+TJsjot1LMUF7wlGX4ShvFYUpkqki
 2RA+y/l7+0GLdBTX8jcvNOpGq89bdKP0qikCFIu+XpmuXiOA75iqosqnz22mXlVX6jPCJxbsuMl
 jtv8JwrnCnX4q1OH1b/nLK8bZiluzfeaiGt7kcF0TIoKdk7cYsGJYA/Sb5/C11JFNlvQk23roG0
 qf+ilhPMIQezTVg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

An NFS client holds a reference to the net namespace. This can cause
nfs_clients to stick around after a container dies spontaneously.

The container orchestrator sees that there are no more tasks in the
container, detaches the filesystems and tears down the networking.
Unfortunately, there can still be RPCs in flight that will end up
attempting to retransmit indefinitely. No userland tasks have a way
to reach that net namespace any longer though, so there is no hope of it
being rescued.

Instead of keeping a net reference in struct nfs_client, add a nfs_net
pre_exit routine that kills off the nfs_server and any remaining
nfs_clients, and then waits for the nfs_client_list to go empty.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/client.c |  6 ++++--
 fs/nfs/inode.c  | 28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 3b0918ade53cd331d76baaa86fd2adec5d945b78..8f41cb88f88c2b4d7f10424484b6e70ac2b8835a 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -180,7 +180,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	clp->cl_proto = cl_init->proto;
 	clp->cl_nconnect = cl_init->nconnect;
 	clp->cl_max_connect = cl_init->max_connect ? cl_init->max_connect : 1;
-	clp->cl_net = get_net(cl_init->net);
+	clp->cl_net = cl_init->net;
 
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	seqlock_init(&clp->cl_boot_lock);
@@ -244,13 +244,15 @@ static void pnfs_init_server(struct nfs_server *server)
  */
 void nfs_free_client(struct nfs_client *clp)
 {
+	struct nfs_net *nn = net_generic(clp->cl_net, nfs_net_id);
+
 	nfs_localio_disable_client(clp);
 
 	/* -EIO all pending I/O */
 	if (!IS_ERR(clp->cl_rpcclient))
 		rpc_shutdown_client(clp->cl_rpcclient);
 
-	put_net(clp->cl_net);
+	wake_up_var(&nn->nfs_client_list);
 	put_nfs_version(clp->cl_nfs_mod);
 	kfree(clp->cl_hostname);
 	kfree(clp->cl_acceptor);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 1aa67fca69b2fbd8afb1c51be78198220b1e13c7..0352e7e6ee270562a971d031ba02bdec96496288 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2562,9 +2562,37 @@ static void nfs_net_exit(struct net *net)
 	nfs_clients_exit(net);
 }
 
+static bool all_clients_gone(struct nfs_net *nn)
+{
+	bool	gone;
+
+	spin_lock(&nn->nfs_client_lock);
+	gone = list_empty(&nn->nfs_client_list);
+	spin_unlock(&nn->nfs_client_lock);
+
+	return gone;
+}
+
+static void nfs_net_pre_exit(struct net *net)
+{
+	struct nfs_net *nn = net_generic(net, nfs_net_id);
+	struct nfs_server *server;
+	struct nfs_client *clp;
+
+	spin_lock(&nn->nfs_client_lock);
+	list_for_each_entry(server, &nn->nfs_volume_list, master_link)
+		nfs_server_shutdown(server);
+	list_for_each_entry(clp, &nn->nfs_client_list, cl_share_link)
+		rpc_clnt_shutdown(clp->cl_rpcclient);
+	spin_unlock(&nn->nfs_client_lock);
+
+	wait_var_event(&nn->nfs_client_list, all_clients_gone(nn));
+}
+
 static struct pernet_operations nfs_net_ops = {
 	.init = nfs_net_init,
 	.exit = nfs_net_exit,
+	.pre_exit = nfs_net_pre_exit,
 	.id   = &nfs_net_id,
 	.size = sizeof(struct nfs_net),
 };

-- 
2.48.1


