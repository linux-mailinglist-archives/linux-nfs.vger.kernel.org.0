Return-Path: <linux-nfs+bounces-10794-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BECA6F62C
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 12:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05F916A2C6
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 11:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771C92566D9;
	Tue, 25 Mar 2025 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6M0Qg6Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9052566C5;
	Tue, 25 Mar 2025 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903094; cv=none; b=EMGYcIkn8P2xba0p2ls9C9mSqLJD94tV3iTebCz0KIuTsKIjqILswUY+Bbbm3+1smOftyetvIukppIJH6nhb59ABCyBTO7Z5ly1i6RYyDVjzUMWpvttaiGXWIYMY3hYlVs+gc7Hh4jkgjZIorBSJe6O2lM4pN/XREWl43UR4GV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903094; c=relaxed/simple;
	bh=L7+6+B+SMEuXjEw9gMWwD/OBdX5Bd8fZcJ0/saOl8VU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T74Yjju+ve8vFOKjagpmunZ2p16BKh7qVSsk27bJe85McMMgfSDuTLTVNFVrKZiaM9DG9q7HOfoDppNKS0Y4m1ePSUayr8Kh5t51dE18hpiMLhbIhco6FSvCVk0smJ5g029oARKzvDPvLITfYFuOijcy6cNqwOkHJGnxnLAXxdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6M0Qg6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C1FC4CEED;
	Tue, 25 Mar 2025 11:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742903093;
	bh=L7+6+B+SMEuXjEw9gMWwD/OBdX5Bd8fZcJ0/saOl8VU=;
	h=From:Date:Subject:To:Cc:From;
	b=Z6M0Qg6YkFg26pVKoeh/fFR8+15VG3Yu2xnInepKF/9H+Yp6NAsSHuxSIN97MhyRP
	 yox+qCwY7Seza/9vx08+pjCGdD4cpnzKPVXM7GBQKWZIgifnhee57TUPOY6WPSCc0q
	 /XJ2+Kp2lfLPGfMPYw1XPksVTy6gzZnOleOXh4PN9wnNk74mVyvnZYa3sfL5FmeDyp
	 ISxQ044vaTjDBZwWjBhwFb2ibZPSZd4FDOfi/aB8fRVecyGTrQMwRtkh1BvqblNRo/
	 W+rU9kTUcRXvzB83MNI6G3wQo40yXXQtkbxEjCx94FHmOd6HkmJIaqRXk7mpPIxzT6
	 dy1VuqvPMsfMA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 25 Mar 2025 07:44:45 -0400
Subject: [PATCH] nfs: add a refcount tracker for struct net as held by the
 nfs_client
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-nfs-net-nef-v1-1-0142cbd7e9ea@kernel.org>
X-B4-Tracking: v=1; b=H4sIACyX4mcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyNT3by0Yt281BIgTtNNSzYyN7BMMklNS0lUAuooKEpNy6wAmxYdW1s
 LADNyz9FdAAAA
X-Change-ID: 20250325-nfs-net-nef-fc2709b4efda
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=L7+6+B+SMEuXjEw9gMWwD/OBdX5Bd8fZcJ0/saOl8VU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn4pcuNgA73sXv72Vnhxk4THndyOleXRWV0L2Nq
 FXASJQpPMqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ+KXLgAKCRAADmhBGVaC
 FdbwD/45ROiYbaWKfw1pmbofRJ3m1ZRZAWc2FxNZ8PFXrsmxT7cWcESUFuhEyPPlIFkpiTd+VAy
 5KV7lWn9qP3bMedkNe2M6Wk7w2oKlkA06d1f+rR2bnNTr8m8xSQklNUoO/qbPfnqqt8bHxFtSU0
 /xFyJNkqUoGXg46uAU3H02VwVQwWiPO6bNf3FlJrUbg6oVoyTPsjPtF9nRAd4Oy9fVrOyVZkHiD
 C3yUTsFLgeuEzwmHNCUAjN6cOf0MXhxJYZKebTMQDItwrfugkSPndaYl/RKHB68FUzslA+dqG2d
 MptlThtnc38OlAFafspIcqvTCIwYnUZGIf/gZKO6j4EBLdOqAWSNEtNKSv0fRSE3dFoI8JTk1K5
 KIbHTS9TV8mK1hI3bJwso7RaLCsTLP0RRUcILwp2xlRXOnYQdubAS9QfpG2HQVZa+KSUxcCF/V0
 e6OvDiMxD/FLFDlhN9faw5YjTTjaob5scf4dKM2s7kgk1ClrK8dQP1dlq2VraKhLz8D/D04iyhe
 IjnlYlKZHRDehg2LgHdhp0NrKZ/LV59cIYNCoAUnoCUyAJzOEHMIPQtmNOmYtXOD9G12ybfq0Mq
 ofFKN1thLNiGv3Sss2f4Y0sTWzQzU8Dd365/KOxcNh7kYf1IqL7tXex6hpTrGxDee62t/rJ/7O4
 roCpCNqXg4H5gcw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Eric added refcount trackers to several long-held netns references in
the sunrpc layer in 2022. Add a tracker to the netns reference held by
the nfs_client as well.

Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 3b0918ade53cd331d76baaa86fd2adec5d945b78..2ce58f2d6bf50924c38962ddedb7f0ca68752a8a 100644
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
+	put_net_track(clp->cl_net, &clp->cl_ns_track);
 	put_nfs_version(clp->cl_nfs_mod);
 	kfree(clp->cl_hostname);
 	kfree(clp->cl_acceptor);

---
base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
change-id: 20250325-nfs-net-nef-fc2709b4efda

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


