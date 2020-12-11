Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2AF2D7CC7
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Dec 2020 18:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394392AbgLKR0d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Dec 2020 12:26:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:50690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395209AbgLKR0D (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Dec 2020 12:26:03 -0500
From:   trondmy@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 01/15] SUNRPC: _shift_data_left/right_pages should check the shift length
Date:   Fri, 11 Dec 2020 12:25:07 -0500
Message-Id: <20201211172521.5567-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211172521.5567-1-trondmy@kernel.org>
References: <20201211172521.5567-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Exit early if the shift is zero.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xdr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index c852d199c789..5833329c132c 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -225,6 +225,9 @@ _shift_data_left_pages(struct page **pages, size_t pgto_base,
 
 	BUG_ON(pgfrom_base <= pgto_base);
 
+	if (!len)
+		return;
+
 	pgto = pages + (pgto_base >> PAGE_SHIFT);
 	pgfrom = pages + (pgfrom_base >> PAGE_SHIFT);
 
@@ -307,6 +310,9 @@ _shift_data_right_pages(struct page **pages, size_t pgto_base,
 
 	BUG_ON(pgto_base <= pgfrom_base);
 
+	if (!len)
+		return;
+
 	pgto_base += len;
 	pgfrom_base += len;
 
@@ -405,6 +411,9 @@ _copy_to_pages(struct page **pages, size_t pgbase, const char *p, size_t len)
 	char *vto;
 	size_t copy;
 
+	if (!len)
+		return;
+
 	pgto = pages + (pgbase >> PAGE_SHIFT);
 	pgbase &= ~PAGE_MASK;
 
@@ -449,6 +458,9 @@ _copy_from_pages(char *p, struct page **pages, size_t pgbase, size_t len)
 	char *vfrom;
 	size_t copy;
 
+	if (!len)
+		return;
+
 	pgfrom = pages + (pgbase >> PAGE_SHIFT);
 	pgbase &= ~PAGE_MASK;
 
-- 
2.29.2

