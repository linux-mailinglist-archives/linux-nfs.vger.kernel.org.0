Return-Path: <linux-nfs+bounces-15129-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3B7BCD5DD
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 15:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 123044E3205
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 13:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459302F49F1;
	Fri, 10 Oct 2025 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxU8FaYa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2D7287271
	for <linux-nfs@vger.kernel.org>; Fri, 10 Oct 2025 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104593; cv=none; b=CRVsKwXdw4MBRcRBGErMcKxDnXO/BQ2AKAI6znJdk7KluaxFsbr+2x2CtcTjvmkjc6fDNH3XNBUVK3Z9kODWVhauqSkTlm+mBjyky+zASupfoR8ssLvq3OWxNwXMZAd/oxWy+jEw8ZwPpaK4RMqcDVf5l/xMHD1pGw/YUo6FXQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104593; c=relaxed/simple;
	bh=CvD0wyTz07d0ePXAIeKvecrFxgee8Gck1lFrWDuQmvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FudBiVG2Ob1kLhJCsBIIFrN6ORVZ1MOm/C7X7kBUrLtOKDi/iOz4XC3u/44Pt/buJ/SkEk1IT9TSyy9amtUce19/X5MfVRgMEPuR1+/+gcFKrIAENscupYTACp8+lsEBvwn0603RW9OyahZK8HtQJ/6AICk1cxOu6uLn42bKEss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxU8FaYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB01C4CEF1;
	Fri, 10 Oct 2025 13:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760104592;
	bh=CvD0wyTz07d0ePXAIeKvecrFxgee8Gck1lFrWDuQmvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pxU8FaYaYtPkGkvra0OtR8ebM1ocO8dk11Ji1dzHQRHTXHiPVc9OibqqdFXr6b6uk
	 HUCU4bZdtEtj5Nx+9TihDDVPX8sBToePSamCWUh9csTGUh6mR7JF0YfMGsKN15+RkR
	 f8nvlq2VG0Zr9j/d/zcNsAV5fq4MegAlMUdi9yvtedwQV4TzOaUp6wMSeANdFl/3Ze
	 oOCEKgkW2ClXuDPhTNHDKTvM8H+zArswQHi9F+aiH1+fDCKqq0BPuYQMhCx8rA9r2p
	 xh+6Tm7vsjxFgpPAiiS+smu4cmKi4fi6Mv+EBNak0PgMwJBegp8UzxrOOJjOWhS0cq
	 XOLynw4/96YTQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 4/5] NFSD: Increase minimum size of slot replay cache
Date: Fri, 10 Oct 2025 09:56:22 -0400
Message-ID: <20251010135623.1723-5-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010135623.1723-1-cel@kernel.org>
References: <20251010135623.1723-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

NFSD caches solo SEQUENCE even when sa_cachethis is false. Ensure
there is enough space in each slot replay cache, even when the
client requested a zero ca_maxresponsesize_cached.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7b80f00fb32c..7d297ac2bf2b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2024,11 +2024,12 @@ static struct nfsd4_slot *nfsd4_alloc_slot(struct nfsd4_channel_attrs *fattrs,
 	size_t size;
 
 	/*
-	 * The RPC and NFS session headers are never saved in
-	 * the slot reply cache buffer.
+	 * Reserve enough space to handle solo SEQUENCE operations,
+	 * which are always cached.
 	 */
 	size = fattrs->maxresp_cached < NFSD_MIN_HDR_SEQ_SZ ?
-		0 : fattrs->maxresp_cached - NFSD_MIN_HDR_SEQ_SZ;
+		NFSD_MIN_HDR_SEQ_SZ :
+		fattrs->maxresp_cached - NFSD_MIN_HDR_SEQ_SZ;
 
 	slot = kzalloc(struct_size(slot, sl_data, size), gfp);
 	if (!slot)
-- 
2.51.0


