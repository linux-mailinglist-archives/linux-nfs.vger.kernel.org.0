Return-Path: <linux-nfs+bounces-15708-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BFEC0FCC7
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 18:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFAF481171
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 17:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B9B31690A;
	Mon, 27 Oct 2025 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b019tXFD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038903168EC
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587550; cv=none; b=S2lVoynJzEoqN3W4zOPCMUa4XlbDl+CssjxOI/qhetGqXVUcfQTFEdFR3+LYnBA4KS7brie9IEsJgxAIM3lys3AwbcIjuv7gHU524Cj1wfh/yzeubHnhuxLrVstV2ryXXwOWFaK76kUgxmWpCF5IM9C3FPGBrMnIAEY/IQSEmEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587550; c=relaxed/simple;
	bh=NQKkppItIlLkvxU5/JFw4qa7bp6upWhE+SFJ7L18UhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcZG5Eqae/jNfDxYjrvjs3JvSofI5v0WcoGAwGdnqmIivkuKEBtgQRR+bXRocD5gh20cHC6crK45m6U5xoMsWZlIs5eiiOktWMBbGzhBAoM4g8rA73KcrYkTwyDjqcJjrcQJTSee7jskCDVEZrpC2SCPPVj3S2xfPqH9XBWwbf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b019tXFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6322EC4CEF1;
	Mon, 27 Oct 2025 17:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761587549;
	bh=NQKkppItIlLkvxU5/JFw4qa7bp6upWhE+SFJ7L18UhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b019tXFDbpdlqFOfwCAGNy5ZVq3c7f1zRFfkQdVfodiMQahcFq1t/uswpoBWwSbvf
	 h9CNROwraxJjg6hxcl2RdnBW50X5ZoRxdamhCFWOgbE0xVAkgjyZGCLBEEfoRb8T23
	 rHNPAmS7htqjaTOGHoSL/mFqFvkUkQPOnsDp5q/2DwO0/vAC09cvDJDep1Yg1xCnh3
	 eRHUHVckYWlN9dKNcSgU50QAybe2eU724+GkuaS02rFOG7upq+oDK2tW7mkzfO3sTs
	 ahmOfh+Q0c1hIRXA/8F2Rge6DC49uwNSkZe4a+Bza0YaQNix7BrjiGcwccN6AbhBWa
	 OxLD2p5ea14hg==
Date: Mon, 27 Oct 2025 13:52:28 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: [v6.18-rcX PATCH 4/3] nfs/localio: Ensure DIO WRITE's IO on stable
 storage upon completion
Message-ID: <aP-xXB_ht8F1i5YQ@kernel.org>
References: <aPSvi5Yr2lGOh5Jh@dell-per750-06-vm-07.rhts.eng.pek2.redhat.com>
 <ed50690c04699c820873642ea38a01eec53d21af.camel@kernel.org>
 <aPURMSaH1rXQJkdj@kernel.org>
 <aPZ-dIObXH8Z06la@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPZ-dIObXH8Z06la@kernel.org>

LOCALIO's misaligned DIO WRITE support requires synchronous IO for any
misaligned head and/or tail that are issued using buffered IO.  In
addition, it is important that the O_DIRECT middle be on stable
storage upon its completion via AIO.

Otherwise, a misaligned DIO WRITE could mix buffered IO for the
head/tail and direct IO for the DIO-aligned middle -- which could lead
to problems associated with deferred writes to stable storage (such as
out of order partial completions causing incorrect advancement of the
file's offset, etc).

Fixes: c817248fc831 ("nfs/localio: add proper O_DIRECT support for READ and WRITE")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 35e332627168..fdbbf5a3617b 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -485,8 +485,12 @@ nfs_local_iters_init(struct nfs_local_kiocb *iocb, int rw)
 		struct nfs_local_dio local_dio;
 
 		if (nfs_is_local_dio_possible(iocb, rw, len, &local_dio) &&
-		    nfs_local_iters_setup_dio(iocb, rw, v, len, &local_dio) != 0)
+		    nfs_local_iters_setup_dio(iocb, rw, v, len, &local_dio) != 0) {
+			/* Ensure DIO WRITE's IO on stable storage upon completion */
+			if (rw == ITER_SOURCE)
+				iocb->kiocb.ki_flags |= IOCB_DSYNC|IOCB_SYNC;
 			return; /* is DIO-aligned */
+		}
 	}
 
 	/* Use buffered IO */
-- 
2.44.0


