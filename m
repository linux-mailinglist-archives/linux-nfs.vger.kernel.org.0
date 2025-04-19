Return-Path: <linux-nfs+bounces-11179-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1354FA944D2
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 19:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBF43BB4D0
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 17:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A1B1DC994;
	Sat, 19 Apr 2025 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZ4Ih2QK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F6454769
	for <linux-nfs@vger.kernel.org>; Sat, 19 Apr 2025 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745083703; cv=none; b=cPf0rz+qIo7fSLXFiakA8zgAKAJLIbBVwKPJcSIa358jtG/pR9ZddI2pMHOgXHoj+dgThqUSlVkVBCLKdt/SYlftwawVf9WTvaGXA+Xny+d0kGE2/CcjAhhk633vEKsbObjrzLQkCdUoiGUMC/0pVCnsqF7+kd3r1lt1WLuLe5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745083703; c=relaxed/simple;
	bh=nkm/oGYCgVF4B9Isqd64L89BLNE6tJxd165khTgG3oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jggNHHDNHfp5H6yLfuQg+FTUtuVqXsBAXdLVlIgnLCYnqcSmQUdH8DcnywUcPvRYWbXjJO+9KNXVHWaIrPvZL3pJ2RMVIOsm/G5+o67BSL2NkVuB9m+Zw0dppljI0CS+WEQge6yJf7ZkzqIrLGVsAjOJgpSKosq9gXlaw30IAy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZ4Ih2QK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4252C4CEEB;
	Sat, 19 Apr 2025 17:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745083702;
	bh=nkm/oGYCgVF4B9Isqd64L89BLNE6tJxd165khTgG3oA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aZ4Ih2QKRVmYWci9TAA/KyPuy4/OJ5Vi35A/BSLPMMp8HmuyQW8A7TDAJwdT1oL7s
	 fzW6jqhXpVRsQ8skqbZgu3wVIlDYPX2SEWeV0cRHOFeEJacutbXVviOkJ8/+vgWJ+S
	 mmb0BrWu77op9pgh1xzHzWJ/L82ReKmnQvK+h3a/cwuGX0IFljYn9YvRuH13xdhKXW
	 Ok3QeTkpl5ZMNgNuQ2oW81IN7AqPJ9azDcsA/hYyH/UebY1gUXYfOIjHXkzOd2r0Xu
	 kOXX+W+BrpMivBiCgcKbnk2AFjPNixqHQoL4M9gy8jjwPRDSymEI3iSdvsnkbL8RhO
	 rTwFRIFNCba/w==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 01/10] sunrpc: Remove backchannel check in svc_init_buffer()
Date: Sat, 19 Apr 2025 13:28:09 -0400
Message-ID: <20250419172818.6945-2-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250419172818.6945-1-cel@kernel.org>
References: <20250419172818.6945-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

A backchannel service might use forechannel send and receive
buffers, but svc_recv() still calls svc_alloc_arg() on backchannel
svc_rqsts, so it will populate the svc_rqst's rq_pages[] array
anyway. The "is backchannel" check in svc_init_buffer() saves us
nothing.

In a moment, I plan to replace the rq_pages[] array with a
dynamically-allocated piece of memory, and svc_init_buffer() is
where that memory will get allocated. Backchannel requests actually
do use that array, so it has to be available to handle those
requests without a segfault.

XXX: Or, make svc_alloc_arg() ignore backchannel requests too?
     Could set rqstp->rq_maxpages to zero.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index e7f9c295d13c..8ce3e6b3df6a 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -640,10 +640,6 @@ svc_init_buffer(struct svc_rqst *rqstp, unsigned int size, int node)
 {
 	unsigned long pages, ret;
 
-	/* bc_xprt uses fore channel allocated buffers */
-	if (svc_is_backchannel(rqstp))
-		return true;
-
 	pages = size / PAGE_SIZE + 1; /* extra page as we hold both request and reply.
 				       * We assume one is at most one page
 				       */
-- 
2.49.0


