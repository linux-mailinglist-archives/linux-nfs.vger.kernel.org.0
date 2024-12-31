Return-Path: <linux-nfs+bounces-8852-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED10B9FEBE1
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Dec 2024 01:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310FA3A28B7
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Dec 2024 00:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37608C2FB;
	Tue, 31 Dec 2024 00:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAmVvO8L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11012C2E0
	for <linux-nfs@vger.kernel.org>; Tue, 31 Dec 2024 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735604951; cv=none; b=trwjjROVBoeVCBixkaK+LDACXbgoxClxviApSnqN7DD1bPhaEXBpmwaWx5B813akktMBKHq3V5P7KwtAJknnx3C/IDcObuPWwFy8GW3wXYysP4pIx/Bgz6w6NOyiir2HteSJw1aNQ9bTkUKYgEBkWil02nr/8ISWVKOFDElc66I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735604951; c=relaxed/simple;
	bh=t0dHrzz6nCVz5GdSMqgBuHRQMV2JCKRfQ1sMFljOO0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrHQztrv9mbLAlO98WRaw0Cy2HbamyjsYzaGhL5aoyiUU2ppTukas1XbfKjvCxXFQlZWQwdLHKOR9EUVcYboCnZU7QsCXFdKwwzaQ3KJaVTy2LBFVX+K5Mw8dGNLFqVxIVVDYD6Z1OZkv4K02hhg1tOqFRnMbP4fEDs0CrFm9hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAmVvO8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73DBC4CED0;
	Tue, 31 Dec 2024 00:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735604950;
	bh=t0dHrzz6nCVz5GdSMqgBuHRQMV2JCKRfQ1sMFljOO0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CAmVvO8LAUiVLtN796dTpld7mUqx2NgiHdZKfVeDpkx3o8SGmxJ061r2S8mF+OOFs
	 WfzEGx+EP8umDlJ5A9uLrNdTaYwaodiW7DyiSzrNgud8qFVFEd9qRJCLPIMVSzmOVa
	 SQo2rQTqk8Q0qst1pASOdlrM4qyhYsGri5J7oD6G+JwEDlR6pfldKxPGk2UbaujKHQ
	 uFdHonFd+wMEapLWW5eJkFcGfof1z7B6fKQO/Gc0RxV03BUx/Gr/xsF7nWAaahH9QH
	 Oma19ZNbM0ql+VBDKbQ8Hb0TbX5/vm6GcRSOCqObolo6B7+BNj9OW9dirhm+XLsjb7
	 GsUVaFlhgpzCw==
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
Subject: [PATCH v4 5/9] NFSD: Insulate nfsd4_encode_fattr4() from page boundaries in the encode buffer
Date: Mon, 30 Dec 2024 19:28:56 -0500
Message-ID: <20241231002901.12725-6-cel@kernel.org>
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

Commit ab04de60ae1c ("NFSD: Optimize nfsd4_encode_fattr()") replaced
the use of write_bytes_to_xdr_buf() because it's expensive and the
data items to be encoded are already properly aligned.

However, there's no guarantee that the pointer returned from
xdr_reserve_space() will still point to the correct reserved space
in the encode buffer after one or more intervening calls to
xdr_reserve_space(). It just happens to work with the current
implementation of xdr_reserve_space().

This commit effectively reverts the optimization.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b770225d63dc..d4ee633b01e3 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3506,8 +3506,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	struct nfsd4_fattr_args args;
 	struct svc_fh *tempfh = NULL;
 	int starting_len = xdr->buf->len;
-	__be32 *attrlen_p, status;
-	int attrlen_offset;
+	unsigned int attrlen_offset;
+	__be32 attrlen, status;
 	u32 attrmask[3];
 	int err;
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
@@ -3627,9 +3627,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		goto out;
 
 	/* attr_vals */
-	attrlen_offset = xdr->buf->len;
-	attrlen_p = xdr_reserve_space(xdr, XDR_UNIT);
-	if (!attrlen_p)
+	attrlen_offset = xdr_stream_pos(xdr);
+	if (unlikely(!xdr_reserve_space(xdr, XDR_UNIT)))
 		goto out_resource;
 	bitmap_from_arr32(attr_bitmap, attrmask,
 			  ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
@@ -3639,7 +3638,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		if (status != nfs_ok)
 			goto out;
 	}
-	*attrlen_p = cpu_to_be32(xdr->buf->len - attrlen_offset - XDR_UNIT);
+	attrlen = cpu_to_be32(xdr_stream_pos(xdr) - attrlen_offset - XDR_UNIT);
+	write_bytes_to_xdr_buf(xdr->buf, attrlen_offset, &attrlen, XDR_UNIT);
 	status = nfs_ok;
 
 out:
-- 
2.47.0


