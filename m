Return-Path: <linux-nfs+bounces-13800-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 468C4B2DF65
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Aug 2025 16:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2158F5C7D71
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Aug 2025 14:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65F2320CC7;
	Wed, 20 Aug 2025 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C59h+8fd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C9D320CBA
	for <linux-nfs@vger.kernel.org>; Wed, 20 Aug 2025 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755700052; cv=none; b=twRBnjHp14VBBEfRxY5yehMLqafl/vjZCStSHKaA8r2QctKyoWHleQxGxLges2iekQlmAmUe3xXdV+K+g3zv93zikMIti9p3FB0RXnVfwGbMmzmH/QX+3cWoGkcbsxwHMK1LETdjdAgOGqXRfxG6zSU5S6xjs06KOw3BAbWnZB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755700052; c=relaxed/simple;
	bh=kQ2ZQfmOwGS/UuSTLyLLSHgaAhSDCuJTr5WIkevHBms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwqWn1zyuibiF3Vq+Re+ni6rPcs0NEeBOvqJ34A9P2zQhlUMGaEMSt9+Bll28BtRaLf8qEEtzUT2AngnXTcb10D6omVt+ygz9b2sXcI62RYB1Dlx7Pn3xjbb6dAPnSM7xwrswxLxspQJE31Rt55NOXua9oM/ieeGpT27ie741Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C59h+8fd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9FDC4CEEB;
	Wed, 20 Aug 2025 14:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755700052;
	bh=kQ2ZQfmOwGS/UuSTLyLLSHgaAhSDCuJTr5WIkevHBms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C59h+8fd0uWAxyXLI/7qw+pWuqzE41zEygd1Ng1O5HOXAjUmiN2Pmu9ueuyjoJVhQ
	 xYfOAEF8QrlRnodh7/FFKgSQbTobPCslxUUhI+TGhnYX2y/XHPTmWNr1U1XgtmJMxO
	 Mnn84JbBE252PFHSiY+UMdvtdi3wdhnvTuVbG55ruUIB0yFkFce1X7vYYA1MPnH5Jh
	 CDrsdfoaLvxoA9364pHyl+6fn489RYGT1UlRuxxoeXdHOfnovlkdko7iKsGgf8bcbW
	 LOQmHyggAVZm/Rc2NotNQhjI5AQulYpUDXBqrQoOCB2kp3gNQ7kfC5adUS70r+C39a
	 FJdPriYGbw4dA==
From: Chuck Lever <cel@kernel.org>
To: <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 1/2] NFS: Remove rpcbind cleanup for NFSv4.0 callback
Date: Wed, 20 Aug 2025 10:27:27 -0400
Message-ID: <20250820142729.89704-2-cel@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250820142729.89704-1-cel@kernel.org>
References: <20250820142729.89704-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The NFS client's NFSv4.0 callback listeners are created with
SVC_SOCK_ANONYMOUS, therefore svc_setup_socket() does not register
them with the client's rpcbind service.

And, note that nfs_callback_down_net() does not call
svc_rpcb_cleanup() at all when shutting down the callback server.

Even if svc_setup_socket() were to attempt to register or unregister
these sockets, the callback service has vs_hidden set, which shunts
the rpcbind upcalls.

The svc_rpcb_cleanup() error flow was introduced by
commit c946556b8749 ("NFS: move per-net callback thread
initialization to nfs_callback_up_net()"). It doesn't appear in the
code that was relocated by that commit.

Therefore, there is no need to call svc_rpcb_cleanup() when listener
creation fails during callback server start-up.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/callback.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 86bdc7d23fb9..511f80878809 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -153,7 +153,7 @@ static int nfs_callback_up_net(int minorversion, struct svc_serv *serv,
 	ret = svc_bind(serv, net);
 	if (ret < 0) {
 		printk(KERN_WARNING "NFS: bind callback service failed\n");
-		goto err_bind;
+		goto err;
 	}
 
 	ret = 0;
@@ -166,13 +166,11 @@ static int nfs_callback_up_net(int minorversion, struct svc_serv *serv,
 
 	if (ret < 0) {
 		printk(KERN_ERR "NFS: callback service start failed\n");
-		goto err_socks;
+		goto err;
 	}
 	return 0;
 
-err_socks:
-	svc_rpcb_cleanup(serv, net);
-err_bind:
+err:
 	nn->cb_users[minorversion]--;
 	dprintk("NFS: Couldn't create callback socket: err = %d; "
 			"net = %x\n", ret, net->ns.inum);
-- 
2.50.0


