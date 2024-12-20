Return-Path: <linux-nfs+bounces-8687-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CECE19F95B1
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 16:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66E516F569
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 15:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FD1218EBE;
	Fri, 20 Dec 2024 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLQis4cz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51497218EAC
	for <linux-nfs@vger.kernel.org>; Fri, 20 Dec 2024 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709360; cv=none; b=aXxwE4W7FJGhpoP/UCsC4jThgG9mozkcET/yTyzPkNPq4psBNfpcZHD1vwdrC85ADgQzUwvOpDSiYpE3P1bb3bgaup3BskjvBj95oUbOZLryatAYmWDWOym64qn1GGIn/mi1ii3KjDAL6slc0yrmpEEu+laxAg/BaruyoFKMeQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709360; c=relaxed/simple;
	bh=mGjyLUC8Tdl3s3Io8OxFN8wjAOa9sgigj2kk4i+JBQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNR8DjSE8545RhDpiD7ou/gRC6uAv/Agth+ZoNVZFhdk8cBRvpQRFAfF0+IpprGCQUfw0iI7/fZe8yfciOuPhjNeAYooBR6ygtp6X2hHP2vN/Lajrt+af3ceMn7bN/Bw9UCIqHsF7nEBwWejooAsaKf1/0jxT5+yAEojWpPP4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLQis4cz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48601C4CED3;
	Fri, 20 Dec 2024 15:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734709359;
	bh=mGjyLUC8Tdl3s3Io8OxFN8wjAOa9sgigj2kk4i+JBQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLQis4czNY8B4vg7ra2Rea4ivc9GVdI9tgRlwpnYn0bv5hmFVEIBeK0/jiTiNH5sA
	 o57B1I7PtK3/gECGK6JrYdNSWw2Md7go55AZ/DwKYiXcMuQriE/xmwaDFVg8rkJ0H1
	 hDMw6BD5WbL+GTZbo5xDqpy8Qh6eCd2RwNZ3MYPFoDlfteKvRkrghk7UE2BMGYsmdd
	 I5M8Vku0jmWEdUwquAi+DtkfAZYrUNRnAO1RC7WV+uUky1kRneuJVcPEDWYFLnJlN7
	 sTRGAnp7ua4vJUuPGItZiaxcGxpTKF0ItH/lZs8eKJ8XqNb5/d1ny+JJW7+wWJdAsA
	 b3b5TAV5UwU+A==
From: cel@kernel.org
To: Olga Kornievskaia <okorniev@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 1/7] NFS: CB_OFFLOAD can return NFS4ERR_DELAY
Date: Fri, 20 Dec 2024 10:42:29 -0500
Message-ID: <20241220154227.16873-10-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220154227.16873-9-cel@kernel.org>
References: <20241220154227.16873-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=876; i=chuck.lever@oracle.com; h=from:subject; bh=qXuGrjg6SDFchdJvPLGOato/moBZTWja3ZWBZre7U8g=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnZZBplI7zb0ON3ksPyJGdZ3rXRv7V4llY6edT+ 5XQB6PruJuJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ2WQaQAKCRAzarMzb2Z/ l7VED/49r0f39OKr6+DTGV/4qLp1JlAM9sc0h/k5KD+yxfT+ml+wx5aFS59faNjVYVcH8H2kqNi FDpS8QQDzDPWxzHQQovDv2hAWbi6Eztm1mGx2nhC0p03DotdxqCI+2iTNf6Wo3v7RspFrxzhfVR 08zWZtX+ASsjNgYVwzzVTWSQTtIm8Xh6cgFivYw2kOyzP6xzfHmiJHltYOK0VjsNlI0mA93H1hr lbLk7dAtUGiVrktDyac911Lgl9hHVx1baY+NG9YQez/XfYTVirUccv1HL6hhgE0rRc2brcfAdwM NQj7pW+JNfEOYXitu95rggocsjaFnTxQRXok+JjeiwiGRfLpTu68Y+c4Vse4ud4g3bGrBmBZ7sB lQEj4vtZUatic1cSREHkRriMIyGFHUZzquC3xkSC8fr9D4POHzgllCFSiQW8+xN6vzb97jU2/Za 37S+9sXP4HylWVXvKr7M+fFP2dH1w4JLWfdPawJnV9m/J5TWdeXGeX3cIiy2g8CDxk5vN4x7MQl 1/bjnx5L2NgkZEtvo+ZlvmgCzumpVOYkoFOr1PUnsW9ThCRlowIAteGMENG7fsvbmcIzNE+eGUq VWJS7l4qAimtOp5cuOVPpj4Zn3i1XSkxOAH/xoKK9F8/shzQzA7QI041YdlUXeioaeTLqKmjoGn en6xrytlkKEkfQg==
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


