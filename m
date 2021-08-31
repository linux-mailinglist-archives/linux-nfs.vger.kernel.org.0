Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CE43FCD7A
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Aug 2021 21:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhHaTGb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Aug 2021 15:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239988AbhHaTGa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 31 Aug 2021 15:06:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E201A61041;
        Tue, 31 Aug 2021 19:05:34 +0000 (UTC)
Subject: [PATCH RFC 4/6] SUNRPC: svc_fill_write_vector() must handle non-zero
 page_bases
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 31 Aug 2021 15:05:34 -0400
Message-ID: <163043673422.1415.7454603360299190766.stgit@klimt.1015granger.net>
In-Reply-To: <163043485613.1415.4979286233971984855.stgit@klimt.1015granger.net>
References: <163043485613.1415.4979286233971984855.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

svc_fill_write_vector() was introduced in commit 8154ef2776aa
("NFSD: Clean up legacy NFS WRITE argument XDR decoders").

I'm about to add a case where page_base will sometimes not be zero
when the NFS WRITE proc functions invoke this API. Refactor the
API and function internals to handle this case properly.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 34ced7f538ee..3d9f9da98aed 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1705,6 +1705,7 @@ unsigned int svc_fill_write_vector(struct svc_rqst *rqstp,
 	struct kvec *vec = rqstp->rq_vec;
 	size_t total = payload->len;
 	unsigned int i;
+	size_t offset;
 
 	/* Some types of transport can present the write payload
 	 * entirely in rq_arg.pages. In this case, @first is empty.
@@ -1717,12 +1718,14 @@ unsigned int svc_fill_write_vector(struct svc_rqst *rqstp,
 		++i;
 	}
 
+	offset = payload->page_base;
 	while (total) {
-		vec[i].iov_base = page_address(*pages);
-		vec[i].iov_len = min_t(size_t, total, PAGE_SIZE);
+		vec[i].iov_base = page_address(*pages) + offset;
+		vec[i].iov_len = min_t(size_t, total, PAGE_SIZE - offset);
 		total -= vec[i].iov_len;
 		++i;
 		++pages;
+		offset = 0;
 	}
 
 	WARN_ON_ONCE(i > ARRAY_SIZE(rqstp->rq_vec));


