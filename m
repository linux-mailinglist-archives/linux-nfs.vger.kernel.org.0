Return-Path: <linux-nfs+bounces-11041-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A29DA80CCF
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Apr 2025 15:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB511BA1C61
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Apr 2025 13:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A74191F77;
	Tue,  8 Apr 2025 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2DStrtG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2B4184524;
	Tue,  8 Apr 2025 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744119806; cv=none; b=B50PoWMnttnlwmL2fBUOxTEhT0ZSO3v72+Z5w6znXXM70eWNjKrnomuETZtaldBZyZynsKF0wN0Y4oESUeGUOPaPalVDDCHVxlHp066kQWkzys0fWxUSYq3flcTL4eUoYDtMtkz86F32XkM/2e2dxywzabkId0RnHOycYnbK3KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744119806; c=relaxed/simple;
	bh=2Ddq2Ob5OM25ETLhpoIPhbrffu1fDDQkhe/CqhWKAZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dzd/ZxTwLkIwrtMrQ/a1WkpOVBbuE22DXP6I8g5BtCO8BpkH5L1+Co1tcT02jUp8GaXx+P+MgAru9pRzIYYTsMT0eOrwm9wkFEummeSnT//Rn1YwRg4dkH7Bf1ET9ArRyGMsUAJnAEsbpJH3fZUstRlkFrR52CzeKT4gzEjLGVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2DStrtG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E08C4CEE5;
	Tue,  8 Apr 2025 13:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744119804;
	bh=2Ddq2Ob5OM25ETLhpoIPhbrffu1fDDQkhe/CqhWKAZE=;
	h=From:Date:Subject:To:Cc:From;
	b=d2DStrtG3hSneoiqTq0u5eckz4kfWrSvuNZmYaaZQHhwtOaHMP8u/nRT8WpvjFa+9
	 NlbBdRXGdPXS258BW4gtASFsISGjOcmpXQn9aDKXrUFBitH0BBqvMgcrWDkbntrOQC
	 j/yEh7L2hDiF7/ftrT2UmDk5O00x0ypzipSs+15xVhWaIKO6UnwLVlj126NR2FJXuu
	 0jyT6unZKsQVU3alQz6kNwfDswJ7tdWhUCTSPZzyGc07SsMMaNOCsmUlRczLoxNsRo
	 DcNgjxh6sv/gE43bQlKz5J7j9LctWJC6ddXkHk6pmpYzcJXzMxvZsZ2DEiCkZ7d/x8
	 oy7gS7L3GNjUg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 08 Apr 2025 09:43:15 -0400
Subject: [PATCH v2] nfs: add a refcount tracker for struct net as held by
 the nfs_client
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-nfs-testing-v2-1-beead5b9e528@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPIn9WcC/x3MQQqAIBBA0avIrBNEVKSrRIvK0WZj4UgE4t2Tl
 m/xfwPGQsgwiwYFH2K68oCeBBznlhNKCsOglbbKKC9zZFmRK+UklY+bi87txgYYxV0w0vvflrX
 3D77gJ6ldAAAA
X-Change-ID: 20250408-nfs-testing-08fa6f66b45d
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1828; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=2Ddq2Ob5OM25ETLhpoIPhbrffu1fDDQkhe/CqhWKAZE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn9Sf79M0qcSF8+mtNIU77W3TF5iuonhGzb8Wgv
 s5c2hnBPMOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/Un+wAKCRAADmhBGVaC
 FeuqEACGjKzZ5uyiXtWbyWnh37FIYzP84eZGWMzGHpxierEyx4O0eX/yxfDa/nZHhm/Sy5EMtKV
 b2X2XgWTx7d3nUc8lYPGy/LiUGXwAEFw5jnI/cjvW6+nrukHcEVX+bIL6he3xxXziaGc9R7Fcws
 IeLL1BzIAwIaPGrIvJDrlyfwUl2CvuzRaXNfY1qetrdfpVHPL8sU0PyWUnAENEwILAn19jkihwc
 S/WleBFzHwRJO0I8ESYr2FF/uR/PlrdwTG3ndp7O5iuhjH5413m635Ii88C3xOyJP4Xz4ii2U7W
 AnyWfBS8GtYlZxrsE/0G+lFX8ImGX6I+FWj2Ot+6C2E6bUcMW4Rpj6vcgKUEGbaa6YoHpfaWz/p
 tFnNLUKU+I3TMt2RiWt13UFMVJqmbiyR9/JkgFSfespqy9j0hJ+BKRy5tE1awwf57O1sky8olCw
 go2oMIDhC95TG4QVRJlx2vUldIIl+IezTporPh986Y9SZH7ENLv4aJsD5LvHREFPfOz4+QreLF2
 9d7YT+fvWDaOpMWGipgVbzEUmNUdoZ9yM7qFxswnHzy/WHPbSczzOJ2EsL8WMixP+SJ6bvgoIWG
 S5RVXJHlkvoLgLljQSKLRW+rnkaJPpi8bLKgSBYXWxSzNKhORNyrjaB0ZMUWTbx97kfhWO1ijcy
 78Uc4A1aYe+EKRw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

These are long-held references to the netns, so make sure the refcount
tracker is aware of them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/client.c           | 4 ++--
 include/linux/nfs_fs_sb.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 02c916a550205f3ccbe9551686e92700900dc176..9500b46005b0148a5a9a7d464095ca944de06bb5 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -180,7 +180,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	clp->cl_proto = cl_init->proto;
 	clp->cl_nconnect = cl_init->nconnect;
 	clp->cl_max_connect = cl_init->max_connect ? cl_init->max_connect : 1;
-	clp->cl_net = get_net(cl_init->net);
+	clp->cl_net = get_net_track(cl_init->net, &clp->cl_ns_tracker, GFP_KERNEL);
 
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	seqlock_init(&clp->cl_boot_lock);
@@ -250,7 +250,7 @@ void nfs_free_client(struct nfs_client *clp)
 	if (!IS_ERR(clp->cl_rpcclient))
 		rpc_shutdown_client(clp->cl_rpcclient);
 
-	put_net(clp->cl_net);
+	put_net_track(clp->cl_net, &clp->cl_ns_tracker);
 	put_nfs_version(clp->cl_nfs_mod);
 	kfree(clp->cl_hostname);
 	kfree(clp->cl_acceptor);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 71319637a84e61c848a296910109828c2c245d67..a5dd543494de9a59db1ec6e1efb6e3ffda2246ee 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -125,6 +125,7 @@ struct nfs_client {
 	 */
 	char			cl_ipaddr[48];
 	struct net		*cl_net;
+	netns_tracker		cl_ns_tracker;
 	struct list_head	pending_cb_stateids;
 	struct rcu_head		rcu;
 

---
base-commit: ee1c801410b2649b2a1c71e0fb5fe1b16fd20e86
change-id: 20250408-nfs-testing-08fa6f66b45d

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


