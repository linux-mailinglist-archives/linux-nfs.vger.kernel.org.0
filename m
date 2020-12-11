Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120452D7CCD
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Dec 2020 18:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394884AbgLKR1F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Dec 2020 12:27:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:50800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395242AbgLKR0o (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Dec 2020 12:26:44 -0500
From:   trondmy@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 05/15] SUNRPC: _copy_to/from_pages() now check for zero length
Date:   Fri, 11 Dec 2020 12:25:11 -0500
Message-Id: <20201211172521.5567-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211172521.5567-5-trondmy@kernel.org>
References: <20201211172521.5567-1-trondmy@kernel.org>
 <20201211172521.5567-2-trondmy@kernel.org>
 <20201211172521.5567-3-trondmy@kernel.org>
 <20201211172521.5567-4-trondmy@kernel.org>
 <20201211172521.5567-5-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Clean up callers of _copy_to/from_pages() that still check for a zero
length.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xdr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 19eaa38f7d16..01918e60b67b 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1665,8 +1665,7 @@ static void __read_bytes_from_xdr_buf(struct xdr_buf *subbuf, void *obj, unsigne
 	len -= this_len;
 	obj += this_len;
 	this_len = min_t(unsigned int, len, subbuf->page_len);
-	if (this_len)
-		_copy_from_pages(obj, subbuf->pages, subbuf->page_base, this_len);
+	_copy_from_pages(obj, subbuf->pages, subbuf->page_base, this_len);
 	len -= this_len;
 	obj += this_len;
 	this_len = min_t(unsigned int, len, subbuf->tail[0].iov_len);
@@ -1696,8 +1695,7 @@ static void __write_bytes_to_xdr_buf(struct xdr_buf *subbuf, void *obj, unsigned
 	len -= this_len;
 	obj += this_len;
 	this_len = min_t(unsigned int, len, subbuf->page_len);
-	if (this_len)
-		_copy_to_pages(subbuf->pages, subbuf->page_base, obj, this_len);
+	_copy_to_pages(subbuf->pages, subbuf->page_base, obj, this_len);
 	len -= this_len;
 	obj += this_len;
 	this_len = min_t(unsigned int, len, subbuf->tail[0].iov_len);
-- 
2.29.2

