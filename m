Return-Path: <linux-nfs+bounces-8750-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25569FB3CB
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 19:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20024164E81
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 18:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C2E199920;
	Mon, 23 Dec 2024 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlRIDxih"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D4618A6B7
	for <linux-nfs@vger.kernel.org>; Mon, 23 Dec 2024 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734977255; cv=none; b=Oc8VvJAlH2PAN+n6SOrWMl3npov9VRKaVju7mc7kRP1oYWKVi4IyLPhOJxKdc3jHZ0+QadovFsf5HQsYrkQPotqvQIFebNQNdLlIeAsZ0Siu95tmaTXxLxcZi9nIaW7tTkiZIjRAA8oK0EQxUbunRC035A073yEnE+l0G6htLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734977255; c=relaxed/simple;
	bh=fF7L8SORLShgP9+zfYC/zn3TR/vGeNVj+dETpfeUJCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LseklQDjmHRcCU/mTQFkfdRIWBoADNV/ff491XyyyhcJFUssTwm3MIU+k5RVHy07dGZdIgu0zwoDSYXl/F/DkNBWlIF5swoWyQfcjdFpz785/RKHXe9ff1d/HKZSjor/sYv5eHQVrsk9IJpftuCnz1xXp/1X0E38o7tacGTmppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlRIDxih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4229BC4CED7;
	Mon, 23 Dec 2024 18:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734977255;
	bh=fF7L8SORLShgP9+zfYC/zn3TR/vGeNVj+dETpfeUJCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qlRIDxihj8geSaqZ8/rw+30tdZbGBNAzz9UugrDzN3Z/bXBiLn5emFhLJ9JFJCcO8
	 1x6+lxCCsFV0Wa0livnSFqqAv8y6w0OW3DXH9wmUhqX2O9qsLvs+a+hh7hzwVRFHMd
	 I+DWrkRlOTzAr21LwhZMEJFk9r0pwL/ZrcjgJMo+5kKLtILgZU9Mp81PpJKX38vG0O
	 C74FZykhViHeZXI0X8LbSdFZ3APs3SMSUQilLy/ImTR/xd1XwPaoBRrvw3mU7N4NcY
	 6pCyZ2g7me1YT0rGtLFVDeVhhU+XS/8OiBAaei+UVYUQXSLkn04EwUAeZDfGYH7sL1
	 mtsOc6AHFRuTA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	J David <j.david.lists@gmail.com>
Subject: [PATCH v2 1/2] NFSD: Encode COMPOUND operation status on page boundaries
Date: Mon, 23 Dec 2024 13:07:26 -0500
Message-ID: <20241223180724.1804-5-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241223180724.1804-4-cel@kernel.org>
References: <20241223180724.1804-4-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4427; i=chuck.lever@oracle.com; h=from:subject; bh=LYJfaZtNX+HXrRxHzcDNZg0ZR7/EUWImJtn5TanD9S4=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnaabiuKlnQy1PKIrTurwPvVGOWRNSm1KlX7kAd r50+KsGSwiJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ2mm4gAKCRAzarMzb2Z/ l3t5EAC/G6HdGrTCUSPPLpdwyqGpFJ7C2xRwXUghDHS2KwVLbKXQ0VrBFd6TX8M8dOEPfiqGMvD J/22U/czcocnqV7Cz2aBl5I80TXp7c13tYbgB5yMJNWkovwATNvRFQ0DgMxhGQEOwujxoEA4YtD sygwsZuKSaQwmPeSoT5SHf1GdoQ8fcC0yvP/M+O2B27VGMcIlJNmpt9jeGAIWkYLY/rD1nqABxg wKGrurDfZHJFDG/w26E7CUGODAHbgIYkyAlOi1PyZoErNwUKaAMHHeV5oXxRvhTAIEzSWg3IizX SGRpdGEmmxro+zHYPC1VUZ344BlyTD4EJk/NTQS0zw63PiqJqVAwFqZ5fLggc+bf8LoB3wyY6/M yEzdplrYPhtfhREMWvgPp7A/qJjPpgt7QQ7cmb33695sd6COZdiNOr5dEP4ACkPR5GFQgBEQIfc GbPruhU9lnBQyDAiVF95cYQGE1CpuRJ5+ismatzaTcbZ16Qu6lkb4zTs2WIXx+Q3BHxhc+DwqK1 PP0S4BM3umiHrEPmLHYUvSppUSRRWzfT5W+YCGB9ZhtvqkUt5qqWr55Lt6VDHwFiilPEUxaZYVO zlAAk4d2LjTlHpZXaq6nF7aJtgjJ2UUVVE8sdZ/3HD4iDJgrM6CnSpZWyP/tB7S3HH1qznaLIVo 0y3Ybm8Dnwv360w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
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
early for a data item that will be inserted into the buffer later.

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
X-Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 53fac037611c..15cd716e9d91 100644
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
+	if (!xdr_reserve_space(xdr, 4))
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


