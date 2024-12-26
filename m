Return-Path: <linux-nfs+bounces-8790-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A68EA9FCBE5
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 17:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B16D1882918
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 16:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E902126BF7;
	Thu, 26 Dec 2024 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYhKL3wI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8DC4C74
	for <linux-nfs@vger.kernel.org>; Thu, 26 Dec 2024 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735230543; cv=none; b=MlAdjAipEG6DXbLjoYxosTSYK1BCKmWsuPhaIaEGF8Yir79nyv0Hrf+6r/M2+Altq9Bm6oCQy+P0OH8g/G6Tt8h6XaBpsDHU4Urr1VhWwCGBdRt817RjxpQLYFbGT/c4ccOUDlfpcQqNHgsLXMbp4zABstE1jYDBxb5cYs0L9rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735230543; c=relaxed/simple;
	bh=vAHOURc2QFDsQ+Vf8bG4s7SmgSxxIAqY+fbvIc+HAmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJEPhwS8ShRVSCvHJaB5xP5aGFbd0gfMlul3uAIt9fW8DWJnWFPRsfkD4E/j9iQB+/MtUWrT5rgNOydEicmnJcu1frVMCe3ZF9YJ6Wcz12ZvDPooplBUsjUKWF70Mckp/sW4ZXtaGoMrkpJuSJ8trjMWc83PNegojb0XPAckirA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYhKL3wI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CEAC4CED4;
	Thu, 26 Dec 2024 16:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735230542;
	bh=vAHOURc2QFDsQ+Vf8bG4s7SmgSxxIAqY+fbvIc+HAmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JYhKL3wIn2xSMOJeIfHZfbQFT68SZEIl2Dw64AZ8VGTKwpdf/U2g2i8XDpUO+oLfS
	 CtKnD8x7f7Cm7NhA8Xmhjk4bBoRHftGn6hbjgo90h5+W9IMfQPGx6KpOb3qr8+xxTM
	 MoVJMb/15djnqimAUZ+2i6PZonFzFYddnH6VoYTzGZsgRTH5iDdxDuPq1bj7q7OCIV
	 syks52XLH4JQE0emjYzj1FqQ9oG4PPTEbBuf0CqiBcG/ZSsugzy3tgbmmgzm5ib08+
	 0tmg7suD4J7vpaU2FYwFfa3c7Zl2zEg2z0n+uECt3vOYI/RA0FQLFhE1oPWinAwemQ
	 O6wMnaGLCugZA==
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
Subject: [PATCH v3 6/6] SUNRPC: Document validity guarantees of the pointer returned by reserve_space
Date: Thu, 26 Dec 2024 11:28:53 -0500
Message-ID: <20241226162853.8940-7-cel@kernel.org>
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

A subtlety of this API is that if the @nbytes region traverses a
page boundary, the next __xdr_commit_encode will shift the data item
in the XDR encode buffer. This makes the returned pointer point to
something else, leading to unexpected behavior.

There are a few cases where the caller saves the returned pointer
and then later uses it to insert a computed value into an earlier
part of the stream. This can be safe only if either:

 - the data item is guaranteed to be in the XDR buffer's head, and
   thus is not ever going to be near a page boundary, or
 - the data item is no larger than 4 octets, since XDR alignment
   rules require all data items to start on 4-octet boundaries

But that safety is only an artifact of the current implementation.
It would be less brittle if these "safe" uses were eventually
replaced.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xdr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 62e07c330a66..f198bb043e2f 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1097,6 +1097,9 @@ static noinline __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
  * Checks that we have enough buffer space to encode 'nbytes' more
  * bytes of data. If so, update the total xdr_buf length, and
  * adjust the length of the current kvec.
+ *
+ * The returned pointer is valid only until the next call to
+ * xdr_reserve_space() or xdr_commit_encode() on this stream.
  */
 __be32 * xdr_reserve_space(struct xdr_stream *xdr, size_t nbytes)
 {
-- 
2.47.0


