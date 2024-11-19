Return-Path: <linux-nfs+bounces-8092-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F259D1CB9
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 01:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63C66B20B2A
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 00:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B58E1BC2A;
	Tue, 19 Nov 2024 00:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+XjMk7s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F41196;
	Tue, 19 Nov 2024 00:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731977256; cv=none; b=DwvX9pxnNpqU4kkR3pUK6ZvE+J1RlrYDA/79mDSyRAKKX/Q7f3JGfZlmO9QG9dnbqNjZAHebov2ioxK0rOfCi1P1luUgzVBdDNXwCoXUj9Vfn2i7FiwpGRQA67hQEEODokntPX5+UnrwmSKjNrKeJJmCkA7WP5fl4SxTNcYxS/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731977256; c=relaxed/simple;
	bh=Y/t9DqFLgpHIwTerHxr91KCR8QJ6dvKYi6drrUFjCLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtPiK9UrZ3QE3rd/oyUhnteUBnHmvt8wJYKOmi16qpH5i8TtVUUQpT2Ot7frbs9hnacqWbtvcCfcWBVON9Mwy9VOhonstmAh0DY24/VqEMfMcdlXTYo/0SwB6p+0xSTpeSEcN4VJE7+41e6LLwu6luyef/yksTwmA7WS8E8bB4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+XjMk7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE1DC4CECF;
	Tue, 19 Nov 2024 00:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731977255;
	bh=Y/t9DqFLgpHIwTerHxr91KCR8QJ6dvKYi6drrUFjCLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F+XjMk7s+DEsPoivKYX41ALsdEoHrVVhsTnXNwHNVTS9Welsgr1yD6cTwAW9e8KX8
	 9s9spKgzzP8vJiXHz5xteBuH7BKm46fHABY9WKEyuYJFf4G+sp6HJSNnILLQmiEVny
	 0Pv8suFTwZ5TTbASVvOa8lO86+YUoqksyyk7A2B0jHW8QA3ZK/SWX8AsmuYJ4kRVxc
	 BvEUtW2/ve/DRvAFyweRE+F4jQ4iMV63i6B6Gb6+5/j/KPrWMwc+apz4qe65FGdTqc
	 RM2VZB+e8vzeY6ENOSz+y7vwxcmjq3htrCovnsC5UnGEHZenqZXQcFuc5nuYm8PaPb
	 smVMKRSc9S4QA==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dai Ngo <dai.ngo@oracle.com>,
	Chen Hanxiao <chenhx.fnst@fujitsu.com>
Subject: [PATCH 5.10 1/5] NFSD: initialize copy->cp_clp early in nfsd4_copy for use by trace point
Date: Mon, 18 Nov 2024 19:47:28 -0500
Message-ID: <20241119004732.4703-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119004732.4703-1-cel@kernel.org>
References: <20241119004732.4703-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dai Ngo <dai.ngo@oracle.com>

[ Upstream commit 15d1975b7279693d6f09398e0e2e31aca2310275 ]

Prepare for adding server copy trace points.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Tested-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Stable-dep-of: 9ed666eba4e0 ("NFSD: Async COPY result needs to return a write verifier")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f10e70f37285..fbd42c1a3fcd 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1769,6 +1769,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd4_copy *async_copy = NULL;
 
+	copy->cp_clp = cstate->clp;
 	if (nfsd4_ssc_is_inter(copy)) {
 		if (!inter_copy_offload_enable || nfsd4_copy_is_sync(copy)) {
 			status = nfserr_notsupp;
@@ -1783,7 +1784,6 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			return status;
 	}
 
-	copy->cp_clp = cstate->clp;
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
 		sizeof(struct knfsd_fh));
 	if (nfsd4_copy_is_async(copy)) {
-- 
2.47.0


