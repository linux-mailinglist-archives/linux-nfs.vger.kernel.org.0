Return-Path: <linux-nfs+bounces-8785-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C37E9FCBE0
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 17:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10A41882C4E
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 16:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07915136351;
	Thu, 26 Dec 2024 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbhwZIQN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D565A4C74
	for <linux-nfs@vger.kernel.org>; Thu, 26 Dec 2024 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735230537; cv=none; b=giovZwSLwP+aeknj/39wxrlFxS7IeEin+9v8bukfIeb1BjMw1QnMgHq8/dxbaqehxDrhCgTSAUeWAOX8/2o7k4PkuJLXyzxg/LfoSUGu6puUIDnpbDJ6+wb63GtL2Bsa+Cd28Ahi6y66dKY89ZT2jUAPVDPYSBL49ADTuyhCbyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735230537; c=relaxed/simple;
	bh=GQwAtmkyCs6amxoVHXGz+jecKwg86jAnP7qW6+XwFGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1VDe2QS8/0ZXLa8CCucqaT9YWU93Wjh3H+Rl+g1zfviTothBAMjEixM+4XtRDkgbfz9M5LZXqfwLIN5GonT8qzY2CYndYKIeYa4p4dzS+wVF9gVyCCeGRMv4Tvj603WOp4Ubg1FNgjvALwcRG/hU53cmYaCzg10tjXlctTxjF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbhwZIQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C8BC4CED4;
	Thu, 26 Dec 2024 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735230537;
	bh=GQwAtmkyCs6amxoVHXGz+jecKwg86jAnP7qW6+XwFGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jbhwZIQNKWHH2gWC8OLRp4J5r0gP7xN7G+rGjavOXz6/Hsk1uNytKSxpvRW6nkkcd
	 BJ7om6S0FHiN0lAsV2X+9KA+vFF28frLG8Ne+89+IZqUbxq2i2AgHya8Kln9es0OXA
	 ATJz9EhTuy85L2KefZuZigR03EgPByk4Ujx6vnU2vIHVqC5ZXiHImX31Nln/EjRAhn
	 Tr/xiNEW9DlEUchm2z0Ba+t/LyhtzSerBAOzWiZe7sM+QlCixCyay60dj4LZQkoedu
	 Bg5gDVdiUjVUi4I+f+qEdNk5T9gF05nlJTLWnNMb/rU2I8Mwmwe6tWs3STxTOxOdUR
	 g08vma3SPCusA==
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
Subject: [PATCH v3 1/6] NFSD: Encode COMPOUND operation status on page boundaries
Date: Thu, 26 Dec 2024 11:28:48 -0500
Message-ID: <20241226162853.8940-2-cel@kernel.org>
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


