Return-Path: <linux-nfs+bounces-8788-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D579FCBE3
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 17:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF811625F7
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 16:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9E213C3F6;
	Thu, 26 Dec 2024 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhKcGNsN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB0B4C74
	for <linux-nfs@vger.kernel.org>; Thu, 26 Dec 2024 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735230541; cv=none; b=VoKucvROItAO9wl4Bk5LmddzRXUfGqa3n9pV8oJEZPAF0vQ4DxktRS6Q+oDPykkilpFMn232WGPYZgAcCKPP4nTD1JqHvUwbZ10MvQGTQ3MOBfaaNW29bWWZf/Bib75vKdZV/IjIp73qSaop53c+PbBzOWV7qkT34Kn6Eh6+GYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735230541; c=relaxed/simple;
	bh=bOuMa9sMAGF/sqzqytsqwn7EWGVttZ3gpupeBr5Kh4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4/yrUQKYZ1IQ9/lhsJpjzb1oObSajYZdpWGe4TYCt4NoA+oYfd/NCgY2K6QRPZnPzbGMLCSXsJOff4C5zZbj+hj2n0Iu8hMxUNJv+jn9iPdFxHiaddbstMoKL7eMYFQmKkNWsqxzKWf5H/5zpRHfeLk24JRUL6IeL7wnAwE82E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhKcGNsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5C5C4CED4;
	Thu, 26 Dec 2024 16:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735230540;
	bh=bOuMa9sMAGF/sqzqytsqwn7EWGVttZ3gpupeBr5Kh4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DhKcGNsN55BiKo8xQUv71p3O5aoyapepkK4Aq9dBbYQWLRRl7tJB3vx/HMepq9ON9
	 7i8VGNkx7BO6zZys/n+UecOc3t4LhldbpVJFzk25nFbJ/3WhBtvge+gjOMbgetzu8i
	 jODEbaPrDi5ikU+pXlQDpZGE+nyYP4COBkn4MnsfO1/Vx/RZv/0rMPxIvu1qhszz5k
	 r167RUcd9UuJHAg/a7KjGIigyM6ZydRR0YkGI3/J1YK5kZ47y6sFRQIMcWkf8nkGyG
	 ffOEb+Mfe89sJilsMbW/C0+VKqor6iRMhpRXrqi5wAlU4K8BayYFO0XZ0TfZgvQGhn
	 wzDuA0wiJD3CQ==
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
Subject: [PATCH v3 4/6] NFSD: Insulate nfsd4_encode_read_plus_data() from page boundaries in the encode buffer
Date: Thu, 26 Dec 2024 11:28:51 -0500
Message-ID: <20241226162853.8940-5-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241226162853.8940-1-cel@kernel.org>
References: <20241226162853.8940-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Commit eeadcb757945 ("NFSD: Simplify READ_PLUS") replaced the use of
write_bytes_to_xdr_buf(), copying what was in nfsd4_encode_read()
at the time.

However, the current code will corrupt the encoded data if the XDR
data items that are reserved early and then poked into the XDR
buffer later happen to fall on a page boundary in the XDR encoding
buffer.

__xdr_commit_encode can shift encoded data items in the encoding
buffer so that pointers returned from xdr_reserve_space() no longer
address the same part of the encoding stream.

Fixes: eeadcb757945 ("NFSD: Simplify READ_PLUS")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 00e2f4fc4e19..b770225d63dc 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5304,14 +5304,21 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	struct file *file = read->rd_nf->nf_file;
 	struct xdr_stream *xdr = resp->xdr;
 	bool splice_ok = argp->splice_ok;
+	unsigned int offset_offset;
+	__be32 nfserr, wire_count;
 	unsigned long maxcount;
-	__be32 nfserr, *p;
+	__be64 wire_offset;
 
-	/* Content type, offset, byte count */
-	p = xdr_reserve_space(xdr, 4 + 8 + 4);
-	if (!p)
+	if (xdr_stream_encode_u32(xdr, NFS4_CONTENT_DATA) != XDR_UNIT)
 		return nfserr_io;
 
+	offset_offset = xdr_stream_pos(xdr);
+
+	/* Reserve space for the byte offset and count */
+	if (unlikely(!xdr_reserve_space(xdr, XDR_UNIT * 3)))
+		return nfserr_io;
+	xdr_commit_encode(xdr);
+
 	maxcount = min_t(unsigned long, read->rd_length,
 			 (xdr->buf->buflen - xdr->buf->len));
 
@@ -5322,10 +5329,12 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	if (nfserr)
 		return nfserr;
 
-	*p++ = cpu_to_be32(NFS4_CONTENT_DATA);
-	p = xdr_encode_hyper(p, read->rd_offset);
-	*p = cpu_to_be32(read->rd_length);
-
+	wire_offset = cpu_to_be64(read->rd_offset);
+	write_bytes_to_xdr_buf(xdr->buf, offset_offset, &wire_offset,
+			       XDR_UNIT * 2);
+	wire_count = cpu_to_be32(read->rd_length);
+	write_bytes_to_xdr_buf(xdr->buf, offset_offset + XDR_UNIT * 2,
+			       &wire_count, XDR_UNIT);
 	return nfs_ok;
 }
 
-- 
2.47.0


