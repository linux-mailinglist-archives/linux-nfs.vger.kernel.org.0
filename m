Return-Path: <linux-nfs+bounces-8849-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264149FEBDF
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Dec 2024 01:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CEA3A284F
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Dec 2024 00:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9EB8F5E;
	Tue, 31 Dec 2024 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5mhl/sI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B5A8BEC
	for <linux-nfs@vger.kernel.org>; Tue, 31 Dec 2024 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735604947; cv=none; b=fidmt/2luTYRIlU4I+CovU1x0Dv2ad3PjmMNH8NQ1jkqY2ZBnT9dwS7WgcGr2y4p/YMAr6ef5tdDUEZJr6o6DASDWkjmA3I0dmhhS70G1rrWddWwD7j/L1RVmblS8W62hG9VWTl6XSrokYq6LrpTx8ZmGBE8CmUuVy0VKqVedlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735604947; c=relaxed/simple;
	bh=mTzUny1CMezcW1PIxqv5iGaLn8avZ/ysicpu9dh07AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OE+ySnKfdCUApuhKwLS2Jy8emiJoIsjCeAc6RasUZgRGQX9pCF1/LvoyJ+B+DxVOZ/gf+ScorkmgVBv5iQMpWvx566Lwchnw+ZctBFgscDjngeX/7qxBgL78ID5twNaZynZ3zY3nwLWjSEeETLljyOSpj7d4GGP1u2W43Dt7PGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5mhl/sI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5291C4CED0;
	Tue, 31 Dec 2024 00:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735604947;
	bh=mTzUny1CMezcW1PIxqv5iGaLn8avZ/ysicpu9dh07AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B5mhl/sI02TDANz4b00g19fNaNIy5w4cCl7MnWc2JGNycSDElJyCXVnwbAp42/DnW
	 8EJgxIG10DqiLuKJlU6sar4GPquzTCbUso4XDvayhjirGNDvr7qJNutEbvGCZ6+Bwu
	 U/tjbIJ2DNzin1MGh/T132F+Wz3hbhKxHgaPjzlkIHLAuuDK1+Y6q8KlnuShYpOWAt
	 d+xBBjnaCDVw0p9IphNOT2wDL4R8KA9LuQCPM1T2P3lgUvIXWaHAA+q2oh6rHP/s+L
	 dJ3W7E1h52FoOOzvnIyIqTzMOpHArq4OCyxoevM6uMMoTw30rb6bvX3opcKICiFrVl
	 TzB3J4v842esg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>,
	j.david.lists@gmail.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 2/9] NFSD: Insulate nfsd4_encode_read() from page boundaries in the encode buffer
Date: Mon, 30 Dec 2024 19:28:53 -0500
Message-ID: <20241231002901.12725-3-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241231002901.12725-1-cel@kernel.org>
References: <20241231002901.12725-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Commit 28d5bc468efe ("NFSD: Optimize nfsd4_encode_readv()") replaced
the use of write_bytes_to_xdr_buf() because it's expensive and the
data items to be encoded are already properly aligned.

However, the current code will corrupt the encoded data if the XDR
data items that are reserved early and then poked into the XDR
buffer later happen to fall on a page boundary in the XDR encoding
buffer.

__xdr_commit_encode can shift encoded data items in the encoding
buffer so that pointers returned from xdr_reserve_space() no longer
address the same part of the encoding stream.

This isn't an issue for splice reads because the reserved encode
buffer areas must fall in the XDR buffers header for the splice to
work without error. For vectored reads, however, there is a
possibility of send buffer corruption in rare cases.

Fixes: 28d5bc468efe ("NFSD: Optimize nfsd4_encode_readv()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index efcb132c19d4..094806fe1a32 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4316,6 +4316,15 @@ static __be32 nfsd4_encode_splice_read(
 	int status, space_left;
 	__be32 nfserr;
 
+	/*
+	 * Splice read doesn't work if encoding has already wandered
+	 * into the XDR buf's page array.
+	 */
+	if (unlikely(xdr->buf->page_len)) {
+		WARN_ON_ONCE(1);
+		return nfserr_serverfault;
+	}
+
 	/*
 	 * Make sure there is room at the end of buf->head for
 	 * svcxdr_encode_opaque_pages() to create a tail buffer
@@ -4398,25 +4407,23 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct nfsd4_compoundargs *argp = resp->rqstp->rq_argp;
 	struct nfsd4_read *read = &u->read;
 	struct xdr_stream *xdr = resp->xdr;
-	int starting_len = xdr->buf->len;
 	bool splice_ok = argp->splice_ok;
+	unsigned int eof_offset;
 	unsigned long maxcount;
+	__be32 wire_data[2];
 	struct file *file;
-	__be32 *p;
 
 	if (nfserr)
 		return nfserr;
+
+	eof_offset = xdr_stream_pos(xdr);
 	file = read->rd_nf->nf_file;
 
-	p = xdr_reserve_space(xdr, 8); /* eof flag and byte count */
-	if (!p) {
+	/* Reserve space for the eof flag and byte count */
+	if (unlikely(!xdr_reserve_space(xdr, XDR_UNIT * 2))) {
 		WARN_ON_ONCE(splice_ok);
 		return nfserr_resource;
 	}
-	if (resp->xdr->buf->page_len && splice_ok) {
-		WARN_ON_ONCE(1);
-		return nfserr_serverfault;
-	}
 	xdr_commit_encode(xdr);
 
 	maxcount = min_t(unsigned long, read->rd_length,
@@ -4427,12 +4434,13 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 	else
 		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
 	if (nfserr) {
-		xdr_truncate_encode(xdr, starting_len);
+		xdr_truncate_encode(xdr, eof_offset);
 		return nfserr;
 	}
 
-	p = xdr_encode_bool(p, read->rd_eof);
-	*p = cpu_to_be32(read->rd_length);
+	wire_data[0] = read->rd_eof ? xdr_one : xdr_zero;
+	wire_data[1] = cpu_to_be32(read->rd_length);
+	write_bytes_to_xdr_buf(xdr->buf, eof_offset, &wire_data, XDR_UNIT * 2);
 	return nfs_ok;
 }
 
@@ -5303,10 +5311,6 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	p = xdr_reserve_space(xdr, 4 + 8 + 4);
 	if (!p)
 		return nfserr_io;
-	if (resp->xdr->buf->page_len && splice_ok) {
-		WARN_ON_ONCE(splice_ok);
-		return nfserr_serverfault;
-	}
 
 	maxcount = min_t(unsigned long, read->rd_length,
 			 (xdr->buf->buflen - xdr->buf->len));
-- 
2.47.0


