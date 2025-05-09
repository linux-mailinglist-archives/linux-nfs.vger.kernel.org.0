Return-Path: <linux-nfs+bounces-11625-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 345BFAB1CFC
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B473BBB63
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 19:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1386B242D65;
	Fri,  9 May 2025 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfoicq5F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC56242909;
	Fri,  9 May 2025 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817440; cv=none; b=W/RAr8J2GMxmV42bkuTUsP1yCz68Im7Ks61ne6HHZcQs15pUnwbdN1pRwg875Jp6Kx3KWfDSzfxJTw6gAyB5lV/KgCKhUtrW/6P1egYKOsQ1t45sMgc7cA4pjHlGI/HVglK+n8W5gSp5T6xWL2gAUPhMxx1jj0FxRE9MYaGG7nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817440; c=relaxed/simple;
	bh=A0J6/nKjeswD8OvWOE8YPOobnGary8OSPlvRIOhlXOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUER4htrF+b/Ur7wuQzcO9NR+qhM+MCyGgymEpZOJNif4hlfWSFNFkV7mrzHVf71DaWcguKemdwKi5fa48U2hvLwwzbwlSTzBR8Jm1W+u1tA0Dv83rrTCRyo1iYZxMmEtuqtU8M54M8LrvHrO9alehnMi2+4YQ+rh+KeUAu13JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfoicq5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954ECC4CEE4;
	Fri,  9 May 2025 19:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817439;
	bh=A0J6/nKjeswD8OvWOE8YPOobnGary8OSPlvRIOhlXOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qfoicq5Ftg8CbqXLyH9HBG9/HtgoJtYUAVnbyyKNz9fCCnNhKfHwJgVInxY0TBof3
	 QXmHfHPdlltzHkgPAaJYOcvUhxKLULBMcyyaFj9bIBlgXh4w05SF+SbmRqYPdmlrh9
	 LZRWRFS6WvP0r/TfTNoRmLiMjN9Y53DHu7wB9EaOZbrYlXZ1wN+GhQhyTkm77seRaI
	 zalmhT493MaKIX1rUeNjWPameX/NYoZKcXtMWMqtBkkoJhfBUD5dMoRGnqHCWcLwgP
	 /beeRQrfLR9BLvAEXnLDM4LsEwv3PCY9mZCQMsFjJmb4NlGXjhKqtjbt81nWcX7PrT
	 n9aQuSqwxTAkw==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 03/19] sunrpc: Remove backchannel check in svc_init_buffer()
Date: Fri,  9 May 2025 15:03:37 -0400
Message-ID: <20250509190354.5393-4-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509190354.5393-1-cel@kernel.org>
References: <20250509190354.5393-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The server's backchannel uses struct svc_rqst, but does not use the
pages in svc_rqst::rq_pages. It's rq_arg::pages and rq_res::pages
comes from the RPC client's page allocator. Currently,
svc_init_buffer() skips allocating pages in rq_pages for that
reason.

Except that, svc_rqst::rq_pages is filled anyway when a backchannel
svc_rqst is passed to svc_recv() -> and then to svc_alloc_arg().

This isn't really a problem at the moment, except that these pages
are allocated but then never used, as far as I can tell.

The problem is that later in this series, in addition to populating
the entries of rq_pages[], svc_init_buffer() will also allocate the
memory underlying the rq_pages[] array itself. If that allocation is
skipped, then svc_alloc_args() chases a NULL pointer for ingress
backchannel requests.

This approach avoids introducing extra conditional logic in
svc_alloc_args(), which is a hot path.

Acked-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index e7f9c295d13c..8ce3e6b3df6a 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -640,10 +640,6 @@ svc_init_buffer(struct svc_rqst *rqstp, unsigned int size, int node)
 {
 	unsigned long pages, ret;
 
-	/* bc_xprt uses fore channel allocated buffers */
-	if (svc_is_backchannel(rqstp))
-		return true;
-
 	pages = size / PAGE_SIZE + 1; /* extra page as we hold both request and reply.
 				       * We assume one is at most one page
 				       */
-- 
2.49.0


