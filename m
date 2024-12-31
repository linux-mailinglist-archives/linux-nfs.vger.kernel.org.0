Return-Path: <linux-nfs+bounces-8856-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C52B59FEBE5
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Dec 2024 01:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1A3E161EA3
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Dec 2024 00:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A8E5227;
	Tue, 31 Dec 2024 00:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWGuA5T3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FC44C8F
	for <linux-nfs@vger.kernel.org>; Tue, 31 Dec 2024 00:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735604955; cv=none; b=dCtUUZ1N5HNjkUEJGDZRqSaN4v5h9w40tbXfGVAIo3i/aBjB3I2czUTHW4FTlITDhwsy415akHAwLmJBcpzmgEnkqa90SSVWydhvqNA9ygUfr8yhWQ1yGSdUZbzMjHfGDh7FRIzJpvshg2VHgvDOnHVyNjp+qQLZ1if3pfYjfN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735604955; c=relaxed/simple;
	bh=Dvz+y0oVf9SZkGJkHtQdwbnWNBzmte4pNKg4/KKMckE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEunozVscNJFmD9636v9Yfa2C33MMyaj/KBol8+pStXMn1m05ml7/17D53dEVYZF3nFoVTrgBbOu2QdFYELzCyTflGmPtWP4LLdjPJpGnl+7fxC/cvIjinYBldqJUiJoxyaPSfGj2s0Sj0RULnDQOWIlx6Otl7GQEexpfTx0Ego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWGuA5T3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07395C4CEDD;
	Tue, 31 Dec 2024 00:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735604954;
	bh=Dvz+y0oVf9SZkGJkHtQdwbnWNBzmte4pNKg4/KKMckE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tWGuA5T3LFeE+M7YxL3lLFSyn+5rU6IPLiqw9Z/G5zh+H/SssJNm3ucSCElrDUADs
	 GFoneZQbYxrcDoYd8aabbgd4hCju/jjoUyvQUgaqRCKJ4i3/o+BlJnWSWjCKZ1ALw4
	 rrYbsgO8kN+EB9efAZCygXjXGUkBk5VtIlUQzqlNsZYBkSqBNUNaEV8Fzaz2HxBO83
	 2EISicK/DH8vUo6gb+XT3LHm/Jv5VZNWkCvod5r9llqWMCU3WarEwIeKUTSF8vyqS3
	 ZsTqxwMXLEPdxMSw3bxOuSYzJDvjng4G/AkYwhDHwt58r5wT3MdlpgqhKhDaM5n3ta
	 8aFiveeZ22VFg==
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
Subject: [PATCH v4 9/9] SUNRPC: Document validity guarantees of the pointer returned by reserve_space
Date: Mon, 30 Dec 2024 19:29:00 -0500
Message-ID: <20241231002901.12725-10-cel@kernel.org>
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
 net/sunrpc/xdr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 62e07c330a66..4e003cb516fe 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1097,6 +1097,12 @@ static noinline __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
  * Checks that we have enough buffer space to encode 'nbytes' more
  * bytes of data. If so, update the total xdr_buf length, and
  * adjust the length of the current kvec.
+ *
+ * The returned pointer is valid only until the next call to
+ * xdr_reserve_space() or xdr_commit_encode() on @xdr. The current
+ * implementation of this API guarantees that space reserved for a
+ * four-byte data item remains valid until @xdr is destroyed, but
+ * that might not always be true in the future.
  */
 __be32 * xdr_reserve_space(struct xdr_stream *xdr, size_t nbytes)
 {
-- 
2.47.0


