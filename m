Return-Path: <linux-nfs+bounces-9818-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817B4A245F3
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 01:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6532E3A87B9
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 00:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000E01E529;
	Sat,  1 Feb 2025 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6Mt2KqN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09AC1E49B
	for <linux-nfs@vger.kernel.org>; Sat,  1 Feb 2025 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738370092; cv=none; b=X7s5vvA91QTLwuQAhJsXcPD18eknow6IKGn3ZPo7Z/brfPnsw61vP9wkY/luwO3SIHzbAQlvcMFVV1YB68XR9fCFrztuJR+PPFBg7C95Q4MeOzNtd07+2hOEq/4INmWYHBc/h15TepCbHGjVLeEcYm+YknNSSq/HPwZcftchL+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738370092; c=relaxed/simple;
	bh=hyCBCfEmDPq7d/RcBpFUjMqx1ZszABML+5Yr6MXyhPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rP0x1j70XTJCarP/z20V0u9u1e1nWinrq60akG8+6LZvdhu4XRKQCBApDRrPu6m4L7/Cob35H/UnUyWXIFzt7M3F2F3lf+mnKcZTk7GGUKwGQ8ryUNBkfuX9r2tOEdwBmmmGc9OvycxcfWhdLPGdpq6Th5t7QpHUS5dxI8j7wj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6Mt2KqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9054BC4CEE7;
	Sat,  1 Feb 2025 00:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738370092;
	bh=hyCBCfEmDPq7d/RcBpFUjMqx1ZszABML+5Yr6MXyhPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l6Mt2KqN6BbFyti4uBeDOzgB/4i9m4oonl+tTO2ZGS2gJAnQhr4GIH1RlIOcsH3EO
	 9M8oCBjGQPe9CGRCXbaKR7gtbiRS5fyvGPhrZDTQREXLKdNKfumimkOWXh2MeJT5MY
	 e2NttadS8eO+M+S38H8qkkld4hPv59gvuUw9UghFPi0RcmqdJWgIL6ZiF2UEoltnXW
	 NWIQoy4iKCoNC4y+TjKdmBKA7hTdwaGGYhBZHQCWUeW2r4j50hvetaQOZQKD3I4wiP
	 D7hO9q5CfiLuN7Kl8tJxb33aAQyazs20vHqKO6futwn+nhmodfnngqQjexB8ojc1XT
	 e2c7HhbKbC0+w==
From: cel@kernel.org
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH v4 2/7] NFS: Fix typo in OFFLOAD_CANCEL comment
Date: Fri, 31 Jan 2025 19:34:42 -0500
Message-ID: <20250201003447.54614-3-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250201003447.54614-1-cel@kernel.org>
References: <20250201003447.54614-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Olga Kornievskaia <okorniev@redhat.com>
Tested-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 9e3ae53e2205..ef5730c5e704 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -549,7 +549,7 @@ static void nfs4_xdr_enc_copy(struct rpc_rqst *req,
 }
 
 /*
- * Encode OFFLOAD_CANEL request
+ * Encode OFFLOAD_CANCEL request
  */
 static void nfs4_xdr_enc_offload_cancel(struct rpc_rqst *req,
 					struct xdr_stream *xdr,
-- 
2.47.0


