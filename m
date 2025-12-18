Return-Path: <linux-nfs+bounces-17213-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E20CCD7E6
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07508305741A
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED652D879B;
	Thu, 18 Dec 2025 20:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6vfNuV4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A142D8370
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088849; cv=none; b=cUn8ez6lGjfKQp0GcvVCVWctnD9tbDI32bNhhLb8DRLYZZXIQPzLl27/wN7SoTpTchKpMmgrZkUNH4Zb9lr06hcddYd0vUNVeLTruW43OpvXDK8BaJJM1ffSWp774PMsA0Hm5xxYfYBCGpT7v34Y2/eXkJ9MF/3gpT6DaEjUm64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088849; c=relaxed/simple;
	bh=go/O5PZydP8ou1CdyQDgnVh9d7yHqLuA9jQ3WzeEczs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ly7MfEZSpcJgsOYxlNvO5yScu/guXsicvkPQp+HnFYLi+cYZtHusfUhgd4gH+VHNh3J+aATERM96gNryYPvWRbRBWZ6VGuZVDOQEsQh0u5vJjShe/2T2REBIDvE5N86mHTzd4n/GFDo2uj6VkLzL3Y6Swin+kvd4v//XNFcW5sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6vfNuV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3BFC113D0;
	Thu, 18 Dec 2025 20:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088849;
	bh=go/O5PZydP8ou1CdyQDgnVh9d7yHqLuA9jQ3WzeEczs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L6vfNuV43N0DJD+EoI4aCTz5BXbqw0wqLAh9xmmVw7ul7fQFELp+81ZlSA10glSE0
	 4jyeZ6dobtHNm3A2wjBmZaUkP960VIX501NDtrHvwWfzSWrO5CLGBTlkO7wG/hbC1q
	 7g5oJu6vnM7cmvO7AQKBQEokNxbKCcsYxvaWCM2Pmd4tFT3cLnOMJoO+s0LgyYoIq8
	 Gqj/JsXa66bS36NpL3/Y4Rj+gSHrUjPEvwQJwOinTPkEl4y3jFt5WZOopeAJ+RrekD
	 H4Rec+qlmnemEwuMO3gojTYLwdDce6znjQaPwfrbV/+IAyPyoLPdYw6XMQeofHN0Jh
	 k8EOVXzJRmOYg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 25/36] lockd: Convert server-side NLMPROC4_UNLOCK_RES to use xdrgen
Date: Thu, 18 Dec 2025 15:13:35 -0500
Message-ID: <20251218201346.1190928-26-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218201346.1190928-1-cel@kernel.org>
References: <20251218201346.1190928-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index c005eb73e146..6ca06c2051f5 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -1067,15 +1067,15 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "CANCEL_RES",
 	},
-	[NLMPROC_UNLOCK_RES] = {
-		.pc_func = nlm4svc_proc_null,
-		.pc_decode = nlm4svc_decode_void,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_res),
-		.pc_argzero = sizeof(struct nlm_res),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "UNLOCK_RES",
+	[NLMPROC4_UNLOCK_RES] = {
+		.pc_func	= nlm4svc_proc_null,
+		.pc_decode	= nlm4_svc_decode_nlm4_res,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_res),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "UNLOCK_RES",
 	},
 	[NLMPROC_GRANTED_RES] = {
 		.pc_func = nlm4svc_proc_granted_res,
-- 
2.52.0


