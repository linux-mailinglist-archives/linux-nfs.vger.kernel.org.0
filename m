Return-Path: <linux-nfs+bounces-16040-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57131C340A8
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 07:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 456B44E2E80
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 06:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7549F22424E;
	Wed,  5 Nov 2025 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuGDo/Y9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5093F176ADE
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 06:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762323549; cv=none; b=XMFJXHNkWcTkKAM6p4FLCYaIeWENJVvqZGUVlNaEFjnU6RJxMcu5mEPlDn4c7aDw8qXYFUie1Z1wagyJwgniWQ6YW0peOa91Zw1c9yrl4ZdmahA6VqNlL+swvjlVIM7ikUG3HvJOEGhinVb4hHpWbWPKjPofek2jLfW6mgyHkIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762323549; c=relaxed/simple;
	bh=v/QPJahXO4cqwdS+i5xMZCoJbMlLVbXOa5AcmJXPpKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dcj5WszZTNAT98KX8kj9K/by9r6B5opCN2Hds+o2GITmUuMVO7cqe0zG5/Qg4DfZaP03t+JDdD6yUYa4+yD/HYM5F89pR6/QobdKFJkBh1SoGrefRsOnq3gnxbxd2GDLvbz17s7gDXEn0HpBy55qlZMK08uEGkik7S8eC2zaAY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuGDo/Y9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D582C4CEF8;
	Wed,  5 Nov 2025 06:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762323547;
	bh=v/QPJahXO4cqwdS+i5xMZCoJbMlLVbXOa5AcmJXPpKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CuGDo/Y9Og7BfWdzPCpM4WtvzwqFXFr8xIUB6xT7B+6AciixWQUOBHEkl4dCT3FV4
	 HockEeMKDuJxhQT1RdIxywnti4k/YOef1pq2Udc1bd5iHg6z1dvVRqF9zrKQJrtCOY
	 KnwMoxZKJR5ZIP2x7UEa4pFS0vNU6/wL0zR3gLW2Ogyo7B94hgXmBL2d9pM0s4HSrk
	 MhEiQA+JCQDn9dXdY2592SECS8F+7lTZCsukLzpLXWev8AEhtgbnHDolBDm0JtMDR6
	 t7mtp8dsaFJAX6m42YiwOXYAYfWPRZiAdsuR+DqO4VKl4qQm8WwLWTlFfIgR9d29tz
	 K8X1I0jOreu4g==
Date: Wed, 5 Nov 2025 01:19:06 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/3] NFSD: avoid DONTCACHE for misaligned ends of
 misaligned DIO WRITE
Message-ID: <aQrsWnHK1ny3Md9g@kernel.org>
References: <20251104164229.43259-1-snitzer@kernel.org>
 <20251104164229.43259-2-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104164229.43259-2-snitzer@kernel.org>

NFSD_IO_DIRECT can easily improve streaming misaligned WRITE
performance if it uses buffered IO (without DONTCACHE) for the
misaligned end segment(s) and O_DIRECT for the aligned middle
segment's IO.

On one capable testbed, this commit improved streaming 47008 byte
write performance from 0.3433 GB/s to 1.26 GB/s.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/vfs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

v3: drop unrelated change to avoid DONTCACHE if READ is less than 32K

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 701dd261c252..075d7162eb2e 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1347,6 +1347,14 @@ nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
 		++args->nsegs;
 	}
 
+	/*
+	 * Don't use IOCB_DONTCACHE if misaligned DIO (args->nsegs > 1),
+	 * because IO for misaligned segments can benefit from the page
+	 * cache (e.g. when handling streaming misaligned IO).
+	 */
+	if (args->nsegs > 1 && (args->flags_buffered & IOCB_DONTCACHE))
+		args->flags_buffered &= ~IOCB_DONTCACHE;
+
 	return;
 
 no_dio:
@@ -1400,7 +1408,7 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	/*
 	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT when
-	 * writing unaligned segments or handling fallback I/O.
+	 * falling back to buffered IO if entire WRITE is unaligned.
 	 */
 	args.flags_buffered = kiocb->ki_flags;
 	if (args.nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
-- 
2.44.0


