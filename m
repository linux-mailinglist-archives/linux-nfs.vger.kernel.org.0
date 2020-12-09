Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E362D44B2
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 15:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbgLIOsy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 09:48:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:49204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733219AbgLIOsr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Dec 2020 09:48:47 -0500
From:   trondmy@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 01/16] SUNRPC: _shift_data_left/right_pages should check the shift length
Date:   Wed,  9 Dec 2020 09:47:46 -0500
Message-Id: <20201209144801.700778-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209144801.700778-1-trondmy@kernel.org>
References: <20201209144801.700778-1-trondmy@kernel.org>
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
index f9efc207a7d5..1d48934bdf9e 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -226,6 +226,9 @@ _shift_data_left_pages(struct page **pages, size_t pgto_base,
 
 	BUG_ON(pgfrom_base <= pgto_base);
 
+	if (!len)
+		return;
+
 	pgto = pages + (pgto_base >> PAGE_SHIFT);
 	pgfrom = pages + (pgfrom_base >> PAGE_SHIFT);
 
@@ -308,6 +311,9 @@ _shift_data_right_pages(struct page **pages, size_t pgto_base,
 
 	BUG_ON(pgto_base <= pgfrom_base);
 
+	if (!len)
+		return;
+
 	pgto_base += len;
 	pgfrom_base += len;
 
@@ -406,6 +412,9 @@ _copy_to_pages(struct page **pages, size_t pgbase, const char *p, size_t len)
 	char *vto;
 	size_t copy;
 
+	if (!len)
+		return;
+
 	pgto = pages + (pgbase >> PAGE_SHIFT);
 	pgbase &= ~PAGE_MASK;
 
@@ -450,6 +459,9 @@ _copy_from_pages(char *p, struct page **pages, size_t pgbase, size_t len)
 	char *vfrom;
 	size_t copy;
 
+	if (!len)
+		return;
+
 	pgfrom = pages + (pgbase >> PAGE_SHIFT);
 	pgbase &= ~PAGE_MASK;
 
-- 
2.29.2

