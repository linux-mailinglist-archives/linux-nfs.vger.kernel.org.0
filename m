Return-Path: <linux-nfs+bounces-8848-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E889FEBDE
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Dec 2024 01:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6015161B7E
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Dec 2024 00:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D5E846F;
	Tue, 31 Dec 2024 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nrw2vjnA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C4479F5
	for <linux-nfs@vger.kernel.org>; Tue, 31 Dec 2024 00:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735604946; cv=none; b=qnFJLfPFoPnoIIuqIiQsGe33HE4ACJZErr9thIUYCBRP3MpfmXIyMn2Ba6WOZ/8+2rlZLttFRPTlPvrvmGmKVmB6WW8UC2IQiEo8JSVgkEvD1T0D6gVobdhSoWsLx9SxG1Av+PETmQkaBaEPL/I7Bv5Uehjz4bW4kS+FFdq0aBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735604946; c=relaxed/simple;
	bh=GQwAtmkyCs6amxoVHXGz+jecKwg86jAnP7qW6+XwFGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A40ZlPZVUrD5PIjluX/cY2us2L0Lw2pWQITzyxytA/VcHcPTP69I45X4kc2Z6ptRNpR5U8abeQWa9eFa9un3PsxbsRzYZNGp3UZ1TYZd4Fr3+KDREiJ6GN1XEGgSc953U+QjNhg4JQLBuAYPsknDEQBhwWN7FkUzkYctYmgftDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nrw2vjnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E78C4CED7;
	Tue, 31 Dec 2024 00:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735604946;
	bh=GQwAtmkyCs6amxoVHXGz+jecKwg86jAnP7qW6+XwFGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nrw2vjnAfWu3Ex8yZPzWhJuUlpiBPVMtUpTwmi+HX9qS9BKLO41fhtezI81O8zlyz
	 8GDdgdIadp8R5mXf/NueoEBdEH3+yC1ep+y+rLWDkrgua9OlnAt32vjf4E4RLJmZX+
	 xTQanJSIICzz0F1KJXafJpDYLld0ANMY+4kXH2cf/f0QiCKC2yy0T/g3nkneax5+n0
	 WAAaDCtNPZSVrS5kW0A3JTshs6gaWZ6Qpn5oe+Pzdh95/DhQyN3UoPTi3R7HAU/17w
	 Yrr3+zNeXZcoHWum034cCUkH1K1IGbVzpK4ZyyqVHdxiDuMXIxhKDcwOOLtEWQR2Z0
	 pyyEuowVHp/pw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>,
	j.david.lists@gmail.com,
	Chuck Lever <chuck.lever@oracle.com>,
	Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v4 1/9] NFSD: Encode COMPOUND operation status on page boundaries
Date: Mon, 30 Dec 2024 19:28:52 -0500
Message-ID: <20241231002901.12725-2-cel@kernel.org>
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

J. David reports an odd corruption of a READDIR reply sent to a
FreeBSD client.

xdr_reserve_space() has to do a special trick when the @nbytes value
requests more space than there is in the current page of the XDR
buffer.

In that case, xdr_reserve_space() returns a pointer to the start of
the next page, and then the next call to xdr_reserve_space() invokes
__xdr_commit_encode() to copy enough of the data item back into the
previous page to make that data item contiguous across the page
boundary.

But we need to be careful in the case where buffer space is reserved
early for a data item whose value will be inserted into the buffer
later.

One such caller, nfsd4_encode_operation(), reserves 8 bytes in the
encoding buffer for each COMPOUND operation. However, a READDIR
result can sometimes encode file names so that there are only 4
bytes left at the end of the current XDR buffer page (though plenty
of pages are left to handle the remaining encoding tasks).

If a COMPOUND operation follows the READDIR result (say, a GETATTR),
then nfsd4_encode_operation() will reserve 8 bytes for the op number
(9) and the op status (usually NFS4_OK). In this weird case,
xdr_reserve_space() returns a pointer to byte zero of the next buffer
page, as it assumes the data item will be copied back into place (in
the previous page) on the next call to xdr_reserve_space().

nfsd4_encode_operation() writes the op num into the buffer, then
saves the next 4-byte location for the op's status code. The next
xdr_reserve_space() call is part of GETATTR encoding, so the op num
gets copied back into the previous page, but the saved location for
the op status continues to point to the wrong spot in the current
XDR buffer page because __xdr_commit_encode() moved that data item.

After GETATTR encoding is complete, nfsd4_encode_operation() writes
the op status over the first XDR data item in the GETATTR result.
The NFS4_OK status code (0) makes it look like there are zero items
in the GETATTR's attribute bitmask.

The patch description of commit 2825a7f90753 ("nfsd4: allow encoding
across page boundaries") [2014] remarks that NFSD "can't handle a
new operation starting close to the end of a page." This bug appears
to be one reason for that remark.

Reported-by: J David <j.david.lists@gmail.com>
Closes: https://lore.kernel.org/linux-nfs/3998d739-c042-46b4-8166-dbd6c5f0e804@oracle.com/T/#t
Tested-by: Rick Macklem <rmacklem@uoguelph.ca>
Reviewed-by: NeilBrown <neilb@suse.de>
X-Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 53fac037611c..efcb132c19d4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5760,15 +5760,14 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 	struct nfs4_stateowner *so = resp->cstate.replay_owner;
 	struct svc_rqst *rqstp = resp->rqstp;
 	const struct nfsd4_operation *opdesc = op->opdesc;
-	int post_err_offset;
+	unsigned int op_status_offset;
 	nfsd4_enc encoder;
-	__be32 *p;
 
-	p = xdr_reserve_space(xdr, 8);
-	if (!p)
+	if (xdr_stream_encode_u32(xdr, op->opnum) != XDR_UNIT)
+		goto release;
+	op_status_offset = xdr_stream_pos(xdr);
+	if (!xdr_reserve_space(xdr, XDR_UNIT))
 		goto release;
-	*p++ = cpu_to_be32(op->opnum);
-	post_err_offset = xdr->buf->len;
 
 	if (op->opnum == OP_ILLEGAL)
 		goto status;
@@ -5809,20 +5808,21 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 		 * bug if we had to do this on a non-idempotent op:
 		 */
 		warn_on_nonidempotent_op(op);
-		xdr_truncate_encode(xdr, post_err_offset);
+		xdr_truncate_encode(xdr, op_status_offset + XDR_UNIT);
 	}
 	if (so) {
-		int len = xdr->buf->len - post_err_offset;
+		int len = xdr->buf->len - (op_status_offset + XDR_UNIT);
 
 		so->so_replay.rp_status = op->status;
 		so->so_replay.rp_buflen = len;
-		read_bytes_from_xdr_buf(xdr->buf, post_err_offset,
+		read_bytes_from_xdr_buf(xdr->buf, op_status_offset + XDR_UNIT,
 						so->so_replay.rp_buf, len);
 	}
 status:
 	op->status = nfsd4_map_status(op->status,
 				      resp->cstate.minorversion);
-	*p = op->status;
+	write_bytes_to_xdr_buf(xdr->buf, op_status_offset,
+			       &op->status, XDR_UNIT);
 release:
 	if (opdesc && opdesc->op_release)
 		opdesc->op_release(&op->u);
-- 
2.47.0


