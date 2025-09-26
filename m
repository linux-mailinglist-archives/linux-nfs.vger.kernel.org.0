Return-Path: <linux-nfs+bounces-14741-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E84BA44C5
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 16:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1C037A31DE
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DA31DE3DB;
	Fri, 26 Sep 2025 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYq3Kyu9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007411DF261
	for <linux-nfs@vger.kernel.org>; Fri, 26 Sep 2025 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898316; cv=none; b=qFyjapSyP/ZDbcJZ6pJAdM7ds9SYOHe6Shbi2hPGo2wSQ2TKCxF7agFyaVr+gAQYIfgTyuGjx/GcYQxNkPL5S87ycaYwQqO18x/2atOJlRLAVl7prITmZ1XCByBi/YAHP/zqTtmHAjXvGXbZSzJJm86Q84yJ+ugT8wxAu8Ixr2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898316; c=relaxed/simple;
	bh=gFh75JgJARXDJKbAnkERZNQnsqlvfSsDgcvKvS4qk28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfXRrgDYLeGq0AbQlcTXp7yf384GUB60xFVAFbCdwHU/cNSAl/Tl2kmNDUl1CYTELzWDX2gp/HeDii4EEqkVINeDlLri0QS9Yh18VZ3HVQcB2vX9jf3DU9GrOAPWevAEAwTa/Lze5HDWxlqg7eKvJPNwCoHqb94azCWiQQe53gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYq3Kyu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0549EC113CF;
	Fri, 26 Sep 2025 14:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758898315;
	bh=gFh75JgJARXDJKbAnkERZNQnsqlvfSsDgcvKvS4qk28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYq3Kyu9O7EQCdbQQxe2RfP8DGCFBy+0RcKnH0UhYFAURIoeIrPrs7/VyhV4oAke1
	 P0jRg6v3pSJDpMiIBPpr4kBYncSyoLoOKyiWQhm+ztPmnTeaCnVjNEhDpvEzzvHd+j
	 STdciHllN457yW5/ib8Ra0eJTcqP6yRoJt2ipCgvb+rvCBCiuUZx9KLzxQBmn0KfA+
	 6PXJDePUpJX3CF6keoEV8jTzwZOC9GxDvUPtruLcPuv6joVRJIb2EYFCVT9Dbe6wtD
	 KCB9AwLSTTGfY/TLMM8niF3gmDIbVVlBhRxZppukjJur9xxPVcL4uVnCJdfWwChghr
	 to7xV5z1ZHYpQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 3/4] NFSD: Relocate the xdr_reserve_space_vec() call site
Date: Fri, 26 Sep 2025 10:51:50 -0400
Message-ID: <20250926145151.59941-4-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926145151.59941-1-cel@kernel.org>
References: <20250926145151.59941-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

In order to detect when a direct READ is possible, we need the send
buffer's .page_len to be zero when there is nothing in the buffer's
.pages array yet.

However, when xdr_reserve_space_vec() extends the size of the
xdr_stream to accommodate a READ payload, it adds to the send
buffer's .page_len.

It should be safe to reserve the stream space /after/ the VFS read
operation completes. This is, for example, how an NFSv3 READ works:
the VFS read goes into the rq_bvec, and is then added to the send
xdr_stream later by svcxdr_encode_opaque_pages().

Nit: we could probably get rid of the xdr_truncate_encode(), now
that maxcount reflects the actual count of bytes returned by the
file system.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 41f0d54d6e1b..3a5c7a0e2db8 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4475,18 +4475,30 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	__be32 zero = xdr_zero;
 	__be32 nfserr;
 
-	if (xdr_reserve_space_vec(xdr, maxcount) < 0)
-		return nfserr_resource;
-
 	nfserr = nfsd_iter_read(resp->rqstp, read->rd_fhp, read->rd_nf,
 				read->rd_offset, &maxcount, base,
 				&read->rd_eof);
 	read->rd_length = maxcount;
 	if (nfserr)
 		return nfserr;
+
+	/*
+	 * svcxdr_encode_opaque_pages() is not used here because
+	 * we don't want to encode subsequent results in this
+	 * COMPOUND into the xdr->buf's tail, but rather those
+	 * results should follow the NFS READ payload in the
+	 * buf's pages.
+	 */
+	if (xdr_reserve_space_vec(xdr, maxcount) < 0)
+		return nfserr_resource;
+
+	/*
+	 * Mark the buffer location of the NFS READ payload so that
+	 * direct placement-capable transports send only the
+	 * payload bytes out-of-band.
+	 */
 	if (svc_encode_result_payload(resp->rqstp, starting_len, maxcount))
 		return nfserr_io;
-	xdr_truncate_encode(xdr, starting_len + xdr_align_size(maxcount));
 
 	write_bytes_to_xdr_buf(xdr->buf, starting_len + maxcount, &zero,
 			       xdr_pad_size(maxcount));
-- 
2.51.0


