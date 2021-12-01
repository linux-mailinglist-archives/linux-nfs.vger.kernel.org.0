Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22657465148
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Dec 2021 16:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244157AbhLAPVS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Dec 2021 10:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351106AbhLAPVD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Dec 2021 10:21:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96698C061574
        for <linux-nfs@vger.kernel.org>; Wed,  1 Dec 2021 07:17:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58476B81DF7
        for <linux-nfs@vger.kernel.org>; Wed,  1 Dec 2021 15:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F101CC53FCC
        for <linux-nfs@vger.kernel.org>; Wed,  1 Dec 2021 15:17:38 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: Remove be32_to_cpu() from DRC hash function
Date:   Wed,  1 Dec 2021 10:17:37 -0500
Message-Id:  <163837185164.12084.13786895795378585127.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.34.0
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218; h=from:subject:message-id; bh=tksvQYIg7UFJ0uKiByiPTorP9kSreRJENA5gsAtQqCM=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhp5ILi3UT27EDnqpP0OtO7uwT3iwQTS0a+NWWx3r6 cBosgE2JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYaeSCwAKCRAzarMzb2Z/l+ChEA CR+kZU/xKa2btbDNr/taEpKQCFj/migka1nO3+ctFMV9DpyHnAgfFYWT7U45/Z8FlyLPYXmQg+8Ruw HQd8GDr7k4nXIwN0ez+qlPIU+YcMQm1MvCXeKo3mpWzF9kk7ntd6ooTAXCEDV4fd6ONrxxn1K7BPeN zYiFifiWTB0UI8O2HexyyKCAUrr62vGVPNrsJi+BbJ0ChIGh0HoEmvBItPEdK9wHz9Cg6+9vJ5TB+Y k4RhC7oGtjzxY7EQeRPnDtvcZyR7SXOjF6FDz5M6wH3WBmR8qC/2XjzvjdGthYdxgb04fsTo1LkPZI A5pgIHEzd+KK6PMsnK2WKrX2vTbSLGRBybP7gDmb6lXwT85h5NiygnuIjcMldvkn6y/llTex2habVk QVnNz4NmfBy2p/MUvR6n9ZX8fIIg+eqQH0MvYkIgarPTjiXnJ2H/NBya1JNzrO53bYZnDJOrV7e+LX IFaDN8+IQwxRk3hgNS+UyH9GsKy7gHPHm3jYFPWX7mfzVZTPsqrLwBLfRRMcWzrC+WZSwXOf2F9hbR jM6Eg+LeI/UyQmOvBQiwgMoSWdbYLnlkbXNeSuBYFbcSsD7OhtWC0aq99idfNRXWXsJENfYrS9UPkK LMPHbg7wYNnBqDE18knyo4dJzudDtfPC8IL2qoT19kGY9+tNtziW4XE+FPdQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit 7142b98d9fd7 ("nfsd: Clean up drc cache in preparation for
global spinlock elimination"), billed as a clean-up, added
be32_to_cpu() to the DRC hash function without explanation. That
commit removed two comments that state that byte-swapping in the
hash function is unnecessary without explaining whether there was
a need for that change.

On some Intel CPUs, the swab32 instruction is known to cause a CPU
pipeline stall. be32_to_cpu() does not add extra randomness, since
the hash multiplication is done /before/ shifting to the high-order
bits of the result.

As a micro-optimization, remove the unnecessary transform from the
DRC hash function.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 62b14e453aba..372c4e039d9d 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -87,7 +87,7 @@ nfsd_hashsize(unsigned int limit)
 static u32
 nfsd_cache_hash(__be32 xid, struct nfsd_net *nn)
 {
-	return hash_32(be32_to_cpu(xid), nn->maskbits);
+	return hash_32((__force u32)xid, nn->maskbits);
 }
 
 static struct svc_cacherep *

