Return-Path: <linux-nfs+bounces-8712-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB19A9FA8B6
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 01:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303441885334
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 00:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00D5383;
	Mon, 23 Dec 2024 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giNpfrF6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F5161;
	Mon, 23 Dec 2024 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734912616; cv=none; b=mjtfApBkYANF3WgYxyp/N5/KzUroA1AMOAguc6VaJxPSxVZVnQorsvV5F198gzx2hMwwsCfkIwJVmp9YEuALfAl9H+En1NaQrZ8ATBZxicXbwGV2xmCzihoTe7isYL/YNKYVm8gU0VXwETm+Av/0LYMAvmePlDFl4BODmyUVNoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734912616; c=relaxed/simple;
	bh=f09rAaLY1Cr6oRRfkpBiN8tmHdAr6lQlK7eibToJQSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VrfTqXZ51ZchfQvKyer+Oa2Pxh7F+xieNbhvlADLrlWj/xEqo1VHI7K8CJVgbiwUSJjebPOWvSyZ2TspyRPp4lPB4abwVvsB6drzLyB6p3wuAjj4xbybvHQgq/l6nM/mlljXJIwv2vWzE1nxsh2Dxfz116IsFSIgbLFzG0BwL2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giNpfrF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFA8C4CECD;
	Mon, 23 Dec 2024 00:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734912616;
	bh=f09rAaLY1Cr6oRRfkpBiN8tmHdAr6lQlK7eibToJQSA=;
	h=From:To:Cc:Subject:Date:From;
	b=giNpfrF6Tc8yRObH2LVLIkJqSRiiBBCTpqSfC3Rml/ajAGVPO6h6rBp63fXQoNDoI
	 xkCipAYx+YBRdAADCiss6Iawy+6J1rELh/g8bhumLQryZUyOPpNiyDHD03XKSStY5k
	 LDZbWTQgLBpfu2eJP0UGKycm9/rre57zxXepJZCojP1U+zDlW41RRnPNIbkAceNGc0
	 cGA1M92N8hS7IUCaZi7U7oGgulPcg5/Oh0QHV931Kz2oCHpluCJnw4InC3EG7UbbmO
	 jpTJ3iNLeJbVsnyGtIuv1heKCGAGw+flPKdyPvK1Mly2hP+DI98XMSI6P/5YD/4GfN
	 nn2+lW6DqfRyw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: Rick Macklem <rick.macklem@gmail.com>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	J David <j.david.lists@gmail.com>,
	stable@vger.kernel.org
Subject: [RFC PATCH] NFSD: Encode COMPOUND operation status on page boundaries
Date: Sun, 22 Dec 2024 19:10:06 -0500
Message-ID: <20241223001005.3654-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3323; i=chuck.lever@oracle.com; h=from:subject; bh=3sY00t1K70tyZTHeYAIHpfn9mnyj+L7fFw+5MX7+H1Q=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnaKpdGH7fDkKNAhr9TWz8V+xFNzxea3oFpzHI2 EN6jDedM5yJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ2iqXQAKCRAzarMzb2Z/ lxE5EADAjl2mqH+CB85Ae/oCITDxWTDeYT5LhPJ/OxA1heQd7KGZjOUeQozVn3VawFMXZ49shtU 67uv10oxFkbt3UR4sya74phHJ7NiF1bO3xRxDssUPqbbXpGjfhnv7FxRPRm9kcgNdBaYOW8CiIO KsTDc6wWu7/8xlDPtpRtAoAxkjDiG8kEvzrugjFViXW9rOLdwgUORgsjHNga7ly8tjtPtRWuHf6 LukJoVzZqpqYeD6fFZY5vc4YwHkTRd8Sm/a/I8SCnBIe3dkrl2SYWAIfu1Ir+JS1OLWRF1OH5l5 LdXf6iMncNw/DO5Iy53nbtKdo09Oo37SEsIAss1//9z+AvZ4f458MtXwWjuVgCwuz36Bu6WCaOn WJUroptmh+VMVV5lBbQR8EOtovM/wjIcxxfNNvDg4OeGA4Mzi8iGUcbwm30ZijzAADbhKEDykCr WnwXCL59mexKg5xVz8qX51OAbJbj3djV9Vgxa4oD124ECgeJMwXmFdli+IndLuXYkC27jmLkVCx ACFszEBUyUR5xAh45MOdVnjAZ/2qmZuOXNY50sqaQRL5lVfRHG83fHZgJ4xeJnJsFQVO9bE3qrS zgBKVKKibCqC3vLDhL1jdv+2TXYaiHgC4GDQJH1IHNQ64qIuIqcA8mplcRbiCQr4yGv4yaMxc2D cA93V5i2RCY/wSA==
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
new operation starting close to the end of a page." This behavior
appears to be one reason for that remark.

Break up the reservation of the COMPOUND op num and op status data
items into two distinct 4-octet reservations. Thanks to XDR data
item alignment restrictions, a 4-octet buffer reservation can never
straddle a page boundary.

Reported-by: J David <j.david.lists@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 53fac037611c..8780da884197 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5764,10 +5764,11 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 	nfsd4_enc encoder;
 	__be32 *p;
 
-	p = xdr_reserve_space(xdr, 8);
+	if (xdr_stream_encode_u32(xdr, op->opnum) != XDR_UNIT)
+		goto release;
+	p = xdr_reserve_space(xdr, XDR_UNIT);
 	if (!p)
 		goto release;
-	*p++ = cpu_to_be32(op->opnum);
 	post_err_offset = xdr->buf->len;
 
 	if (op->opnum == OP_ILLEGAL)
-- 
2.47.0


