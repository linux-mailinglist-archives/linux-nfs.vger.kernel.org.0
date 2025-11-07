Return-Path: <linux-nfs+bounces-16174-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E69B8C40871
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 16:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B9724E17B4
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 15:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAC42DAFBE;
	Fri,  7 Nov 2025 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4it0jMN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890B529E115
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762527936; cv=none; b=mVglSBMa6XPqTVux56HJrihSfAm6/s7tnWJ+Qex2aFzS6c+cx4h/9Zs7KxUeprKstCBDR46s7AWRv81dd5BZWVYW49+yxtjT5+5pftE2q46zDCNHdEdQCcDoVgYkD1Ptn3dtdx9T7QRYfXXAF7YQnuSKq0KgN41PCOidh/JWTv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762527936; c=relaxed/simple;
	bh=bOkFwYkh8Ox50JjSeHK9RiyadGSw77DoLwGZSWxdClA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZqxK4IvJAiAguiYfnVK+sdOBVGBHYcPjIyWve4wISvh+cF+C6VykXlOYwI/X27z/OSAjHfWlFKRvfnI+S/BFD1OmhcVWAb9v3hAmti5Hrr3lVa2G//k65BKiohVYVqm8jEyYJRduO98d3qw+0EwxHnAGZaRxix60bFw4xYOg8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4it0jMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6063DC116B1;
	Fri,  7 Nov 2025 15:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762527936;
	bh=bOkFwYkh8Ox50JjSeHK9RiyadGSw77DoLwGZSWxdClA=;
	h=From:To:Cc:Subject:Date:From;
	b=b4it0jMNWVxAp2ISp2pMnPAy16LcQl2tmRYCEADzhybP4goq28zwxIQMVXUHnCNs6
	 FymknKQ1ufePPhseJ+7lXUeK2ZocDovL+m4djoFF3WzNTuEP6UG8pvQ5NPALx1Sovw
	 XJfkHHnuRdxhxwXXpu/37pkczaVH68FCJ069eGPirX5HQNgvqpjiji7xYTcYAeIb0e
	 UXjDPJW5FTg0gsRrgLNBxFEtMj5fPUid0UWjAu06YxQ0d8y6oghScrIoVHmU9h9Ra2
	 /A1P2JlgJO4oLqK9sNqSGTggfIovE0MBD5OzGhVvqxIJyxPd2R9im8Q4oai6094nvL
	 32PzyBYz20z9A==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Joshua Rogers <linux@joshua.hu>
Subject: [PATCH] SUNRPC: svcauth_gss: avoid NULL deref on zero length gss_token in gss_read_proxy_verf
Date: Fri,  7 Nov 2025 10:05:33 -0500
Message-ID: <20251107150533.3769-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Rogers <linux@joshua.hu>

A zero length gss_token results in pages == 0 and in_token->pages[0]
is NULL. The code unconditionally evaluates
page_address(in_token->pages[0]) for the initial memcpy, which can
dereference NULL even when the copy length is 0. Guard the first
memcpy so it only runs when length > 0.

Fixes: 5866efa8cbfb ("SUNRPC: Fix svcauth_gss_proxy_init()")
X-Cc: stable@vger.kernel.org
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index a8ec30759a18..e2f0df8cdaa6 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1083,7 +1083,8 @@ static int gss_read_proxy_verf(struct svc_rqst *rqstp,
 	}
 
 	length = min_t(unsigned int, inlen, (char *)xdr->end - (char *)xdr->p);
-	memcpy(page_address(in_token->pages[0]), xdr->p, length);
+	if (length)
+		memcpy(page_address(in_token->pages[0]), xdr->p, length);
 	inlen -= length;
 
 	to_offs = length;
-- 
2.51.0


