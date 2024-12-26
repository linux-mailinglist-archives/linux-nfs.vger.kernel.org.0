Return-Path: <linux-nfs+bounces-8787-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BF09FCBE1
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 17:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725C71625E2
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 16:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF32313BC18;
	Thu, 26 Dec 2024 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAd0nZzc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3C54C74
	for <linux-nfs@vger.kernel.org>; Thu, 26 Dec 2024 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735230539; cv=none; b=VmgaV7gtCW3Hl9KYIa62aPS1TRqD4rjn+Y/qUkHD5JntJrjQA+iatlbmtLKV+I7eE7JlL+9ABm6Qvwzm/B8oV6P1xa0zTQSxE/mBf7gmcTBndpobz+xglzfQ+9bnAkuDgOR2vVj47dnFbhOaxaKD3/7W/krQi/Up6PBBsag0PXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735230539; c=relaxed/simple;
	bh=JaWDDhfb+mmrwo7+SaQV+zwajMn+Ijykp/ajU/NijbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDGcYc+tPJqgvfzwqxRjNkczZHizD2dW9hNvXZx8CjTRiqTlLqyxwTkRVPDVF0gqPdFTue4KoZFVpT2RQisfIIg8Rg7DoSDGOolH3WrECCi4YUxqASUVFk8XewnC9nIFgND5URtI4+AWXYlLMcUEmKU6wchjyAY6GhC8+8GmLn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAd0nZzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0949C4CED7;
	Thu, 26 Dec 2024 16:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735230539;
	bh=JaWDDhfb+mmrwo7+SaQV+zwajMn+Ijykp/ajU/NijbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VAd0nZzcZpQx4I6R0vh24/mBgWDdvmdP7FilFQk5U+FKWOJfDnh8DiZuAhawvJ+0W
	 yKnZ3Iecgnlp/pvSmZpXTfUtisobU25o31Iygl2ENFtlHX4/k5Hg0k669xjRIcwhle
	 RnUnX6R52VyuLFpGc3azDDG0cAg+WDvdi65PnS7KJ3nxU6C599gE4UMm/ODxPY+6iU
	 y8SNOP8tlYX+j8Ik3nO8BcFMxSUq3aEm8LuaBTFnqpDPZxGAwg42B/+sBOvlBWrOhv
	 AurS3T9/SIZjvJSEYsjHKUejKYK+CKm8szqoY68mzB0hrToNbAEWnmMPVApT0r4eSj
	 wLPX6QANIhIog==
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
Subject: [PATCH v3 3/6] NFSD: Insulate nfsd4_encode_read_plus() from page boundaries in the encode buffer
Date: Thu, 26 Dec 2024 11:28:50 -0500
Message-ID: <20241226162853.8940-4-cel@kernel.org>
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
 fs/nfsd/nfs4xdr.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 094806fe1a32..00e2f4fc4e19 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5336,16 +5336,17 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct nfsd4_read *read = &u->read;
 	struct file *file = read->rd_nf->nf_file;
 	struct xdr_stream *xdr = resp->xdr;
-	int starting_len = xdr->buf->len;
+	unsigned int eof_offset;
+	__be32 wire_data[2];
 	u32 segments = 0;
-	__be32 *p;
 
 	if (nfserr)
 		return nfserr;
 
-	/* eof flag, segment count */
-	p = xdr_reserve_space(xdr, 4 + 4);
-	if (!p)
+	eof_offset = xdr_stream_pos(xdr);
+
+	/* Reserve space for the eof flag and segment count */
+	if (unlikely(!xdr_reserve_space(xdr, XDR_UNIT * 2)))
 		return nfserr_io;
 	xdr_commit_encode(xdr);
 
@@ -5355,15 +5356,16 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 	nfserr = nfsd4_encode_read_plus_data(resp, read);
 	if (nfserr) {
-		xdr_truncate_encode(xdr, starting_len);
+		xdr_truncate_encode(xdr, eof_offset);
 		return nfserr;
 	}
 
 	segments++;
 
 out:
-	p = xdr_encode_bool(p, read->rd_eof);
-	*p = cpu_to_be32(segments);
+	wire_data[0] = read->rd_eof ? xdr_one : xdr_zero;
+	wire_data[1] = cpu_to_be32(segments);
+	write_bytes_to_xdr_buf(xdr->buf, eof_offset, &wire_data, XDR_UNIT * 2);
 	return nfserr;
 }
 
-- 
2.47.0


