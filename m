Return-Path: <linux-nfs+bounces-11318-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 601CCA9F9AB
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 21:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132CC1A84AD5
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 19:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0950297A5B;
	Mon, 28 Apr 2025 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7CxaRuK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885E92973CF;
	Mon, 28 Apr 2025 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869029; cv=none; b=NVTv6z65nqMIkdBrXt2/TycBG0G4LyYG4c/Ispx+XUrWq2o8JMk4zZk0P4gtl7vJULCjg8bf3IyBx4dz24D8EqizS+jgv0iPafNozhi2YN+5DJFAi4qw4zKDb0T7/ObIGFcat5Gn0uaYqZ1lrxKl8iRQjLe0BSIWKsw1YHuGITE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869029; c=relaxed/simple;
	bh=ID8b/uC+q2kCP6llbUZQCJhK3u+9oMYD3u7wdIdpaX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hkd5OBUUoDiRtF5VbCa9+/VujNsTjOy0DfddivOeFEY/4H3eGqE49EaJjmhnkZp7FIkVnosUijSCAWixr1Hz9+IE/trxHmfPi70/T/m5UT/vYpdjBqDHEPyAyFlykS6ZwphFAQL0Bl2MKKlhH6NOkcGyHBkSek+EUuLmVtpZOaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7CxaRuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D99FC4CEED;
	Mon, 28 Apr 2025 19:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745869029;
	bh=ID8b/uC+q2kCP6llbUZQCJhK3u+9oMYD3u7wdIdpaX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V7CxaRuKSIgG8t5ndaXeTOo+cWm/jUOD7epPo6EwaT2hsXppIBLdcEsuEjKoYkT6l
	 PM/Who0nI9ysC/pCwwguV85unJtt1AFUOzCWZbZGxaZDYhzirKbCcaOgv4ZGOfDm/m
	 Y/jihs7NC4QQxTeQIO9vOfzT+RE22KrJ+2Ale4ffeau+RFowHcUDoNdBFBgqLzVvml
	 /1723mmiFGe5ffb7yX0PGEVCgNGlRM3bHtHvjvp3XJqUcj1nRxSL74Yi00ubm0obvc
	 9wYvCL7cKQovygTQyFafyBTj2VZQcSASl+oNg16n3WlzmQk9EsriMhv7B/PKP1I+xb
	 Fy83hxdyaBaxg==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 03/14] sunrpc: Remove backchannel check in svc_init_buffer()
Date: Mon, 28 Apr 2025 15:36:51 -0400
Message-ID: <20250428193702.5186-4-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428193702.5186-1-cel@kernel.org>
References: <20250428193702.5186-1-cel@kernel.org>
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


