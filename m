Return-Path: <linux-nfs+bounces-10018-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAFEA2F3DE
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 17:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463AD1640F6
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 16:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68862580F2;
	Mon, 10 Feb 2025 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmdFuVFS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EDB2580D8
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205814; cv=none; b=VXGGrYPZ3awcSZeFzFwkkpj1uUWHB7Q3UcZyfLdxz2Xh7rpD0RHl6N+qhgSF3ViNeuWz3SJnysx5jytdqkkNufQ3gCrzEZsl2U1LN1jCKxFCXLF6Orl+srSkdqZjbDQCvfWAfiha7isUtZWaXyFCezS5r/UfIbKSSk5NjAnq/Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205814; c=relaxed/simple;
	bh=HIzhxEO27ifjPw3fatxEfVJLY7Piu/XSP00m6+7osl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3ajyE0dyhDgQ9B8bOb73BMnOgx4UWndv+wzlwivTNXQAfJ9CDaAATNKP9gioVvCr0LHey+hxiwaftJ9VNkET4DlLmFe9biyQWSEnod1l3jbqaQtcOoCkdrYGUkjKf4ePlnCJ9iR/kM9VqAT0Bm5P6fUvgaPGteGU8dhos7Tw7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmdFuVFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40916C4CED1;
	Mon, 10 Feb 2025 16:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739205813;
	bh=HIzhxEO27ifjPw3fatxEfVJLY7Piu/XSP00m6+7osl8=;
	h=From:To:Cc:Subject:Date:From;
	b=ZmdFuVFSLGiKysFCzy0J0dJ0zSnAtXs5VTfD6zo2EbzwTOp9+sAFAmceaxtXsstQ3
	 JBfSoK4ocLw37c3HoitMup8oGi1Hj8Fa5GgIwFGPzqCz0kB+ZCsA1uy9eh5qj2Vze0
	 ToK/B1GCyILojU3pPl0vew1TvNeCkLdDbmLGFWQBg3eZPLlofy13nL76MkCihpbdkS
	 XcmGSMAwRUUwZD3qsMrmL6OXxJbroqRBRYKjOe/Vkzo4ym+soKSFLNoM165B/+LQmS
	 1T517A/jrZChcn1H9/cwWVC6hGLwaDIvoTHit2yBf8OJ4siyoo2nr9ebqR1e8b3Z2Y
	 YZVdfV5LG7BLQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] NFSD: Fix CB_GETATTR status fix
Date: Mon, 10 Feb 2025 11:43:31 -0500
Message-ID: <20250210164331.113479-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Jeff says:

Now that I look, 1b3e26a5ccbf is wrong. The patch on the ml was correct, but
the one that got committed is different. It should be:

    status = decode_cb_op_status(xdr, OP_CB_GETATTR, &cb->cb_status);
    if (unlikely(status || cb->cb_status))

If "status" is non-zero, decoding failed (usu. BADXDR), but we also want to
bail out and not decode the rest of the call if the decoded cb_status is
non-zero. That's not happening here, cb_seq_status has already been checked and
is non-zero, so this ends up trying to decode the rest of the CB_GETATTR reply
when it doesn't exist.

Reported-by: Jeff Layton: <jlayton@kernel.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219737
Fixes: 1b3e26a5ccbf ("NFSD: fix decoding in nfs4_xdr_dec_cb_getattr")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index cf6d29828f4e..484077200c5d 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -679,7 +679,7 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
 		return status;
 
 	status = decode_cb_op_status(xdr, OP_CB_GETATTR, &cb->cb_status);
-	if (unlikely(status || cb->cb_seq_status))
+	if (unlikely(status || cb->cb_status))
 		return status;
 	if (xdr_stream_decode_uint32_array(xdr, bitmap, 3) < 0)
 		return -NFSERR_BAD_XDR;
-- 
2.47.0


