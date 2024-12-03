Return-Path: <linux-nfs+bounces-8332-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F28F19E28A9
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 18:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D12EEB38A62
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 16:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA581F8ACF;
	Tue,  3 Dec 2024 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZdtsBMr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B14F18BC1D
	for <linux-nfs@vger.kernel.org>; Tue,  3 Dec 2024 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243359; cv=none; b=WRm/XFDwuxHmh+Qhe6vmqHnBm0y3OZFz6kE5CMDpX2ynKxvTOjHOoqswcoNhUjpP0ifMqwiw8t1IPYix0Wl0AyDCS0gYRveVxiH3OUIByH7Tbny2y257GNqlffslW9R675IBSsxy+dBJM4OSNZdscQ56oJ7d5qBABHcGtChYk8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243359; c=relaxed/simple;
	bh=mGjyLUC8Tdl3s3Io8OxFN8wjAOa9sgigj2kk4i+JBQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpdGftW7DJIoGLLPG8uz83vaMdWM/spIsWVmgK/uRfnHgNrNX22pQum+eFj0i3VykCeuY0hr19kbFh75eIDTbIyZv4w4BqVfLGCL0+faAu54SWtZa69ySsK2DBEuakyGppZ7SOYjYESX8XXBUXVU300qTUCrdD2EL5/betHXzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZdtsBMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F99C4CED6;
	Tue,  3 Dec 2024 16:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733243359;
	bh=mGjyLUC8Tdl3s3Io8OxFN8wjAOa9sgigj2kk4i+JBQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LZdtsBMrMsoFtmp/pq4S4KnQhmsNt5ApbDWrOHEXFQAaXhp9VFIphBVxi5C7p6Ty/
	 2yYq6zxTzIh2oGSFJP2z7fDKYOp+4ihu4+Cj6gQJruvqF5DUaRcoQBZiWsnOcg2wjk
	 MkV99ViCLxH8l110F/dPDNG+CF3/6iXcOARxrhVi3o8sr+F+1ioMSfELd0n9EzTkSd
	 tIMK/yfNZtZKoMAohvuvE28t77LZDUkuQm9jEIHEdMCrqRr2Q2iv4hSMwx+CdNCqfQ
	 S1c3TAiMii50p+fH2jwuhl4RLGgZHmdyyGN6QOjctntMf/ygiuuLbzcAIx8JfqPUSf
	 wGon/4YCf4wCg==
From: cel@kernel.org
To: Olga Kornievskaia <okorniev@redhat.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 1/7] NFS: CB_OFFLOAD can return NFS4ERR_DELAY
Date: Tue,  3 Dec 2024 11:29:10 -0500
Message-ID: <20241203162908.302354-10-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203162908.302354-9-cel@kernel.org>
References: <20241203162908.302354-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=876; i=chuck.lever@oracle.com; h=from:subject; bh=qXuGrjg6SDFchdJvPLGOato/moBZTWja3ZWBZre7U8g=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnTzHalI7zb0ON3ksPyJGdZ3rXRv7V4llY6edT+ 5XQB6PruJuJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ08x2gAKCRAzarMzb2Z/ l1uIEACVBg6/mzssUiZPCh77Eqz44FLFXjU9l9yOyILSdNEzG89NWCNtvOUMGDhtPBuHqQIDqIN 1/o8o2MVlMGfQmeqzGz8FvLe84mX01Bb9Zo9HiK2Nkv5XNXVleZu6bHxEfU7fC7cUAd/yP2MKuC QXmvXrgInO8aSW6MpWjqxWDoVm0xiIRbOy+MCfukwZBE4CV+9pEZ6j6Hi8Rv0cAN7UpWbelPfno KQLzMqbILziA6VmIp7rXDO7zJE/OX472nr0JVU70oyztljdK5Ew178a6WZAmg/WlhnUbC2w/Hfj oubwQSqfp+ZfEhGfpeLey8B85i1vcx8nz9Lpx3vEO1TFc2YQrERB29+A1YL3/9kS6UeaCs/upQ0 2IggP3/NNIu+Vxa9wycDl+l6lqWQ6u6NKDg7G/dOLmJw6J9ni9vtkPLes9NXJnzgM4DJjvrWcRE tsvhwRfDNTx4PL3cpKveyq1MSbHTn2K7EqcI8gyrxtjO8Uxn2STCEYc24Q2O7BVe1npBvvcbYec ZI67myd1C509Y+h6YdIxNJwQayyxSmARXE5gjW8mgjq1Up+YJXuX1JtydA6wxuC0FVFWNaxZ5Sm kRUhTCJVmJ/tpvoLkniJjNjiaFU9Fjq5SFizzvKQzcf7N/L7WOYrp2djQr5XQmBPbIzoLGjuUhT zC/V4zCRalv/m2A==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

RFC 7862 permits the callback service to respond to a CB_OFFLOAD
operation with NFS4ERR_DELAY. Use that instead of
NFS4ERR_SERVERFAULT for temporary memory allocation failure, as that
is more consistent with how other operations report memory
allocation failure.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/callback_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 7832fb0369a1..8397c43358bd 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -718,7 +718,7 @@ __be32 nfs4_callback_offload(void *data, void *dummy,
 
 	copy = kzalloc(sizeof(struct nfs4_copy_state), GFP_KERNEL);
 	if (!copy)
-		return htonl(NFS4ERR_SERVERFAULT);
+		return cpu_to_be32(NFS4ERR_DELAY);
 
 	spin_lock(&cps->clp->cl_lock);
 	rcu_read_lock();
-- 
2.47.0


