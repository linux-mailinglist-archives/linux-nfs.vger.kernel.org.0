Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E140717E76A
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2020 19:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgCISnY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Mar 2020 14:43:24 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.109]:26513 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727334AbgCISnX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Mar 2020 14:43:23 -0400
X-Greylist: delayed 1311 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Mar 2020 14:43:23 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id EE6B6167BB
        for <linux-nfs@vger.kernel.org>; Mon,  9 Mar 2020 13:21:31 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id BN1vjyY2AEfyqBN1vj1BdS; Mon, 09 Mar 2020 13:21:31 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=94Q67ojJZX0sr3cTE6wQF4GveZtQlKTfPuEaR91kEuo=; b=Kbde3Il7M3zJ70zSOwLiT3SbLZ
        mOUvlifuwYuxtTck+M1RWB+lkNJJEFU7af6Oq6QHGgq2exvgq0Qq8rsMJrQbcasMUu6p7CRWqyl4N
        JDRdNpcU6o42jPnrp0T1slNC4mQ8VjPGEakca1J1yXoJtP3IrUFerpTx9g8HvqP+dKLHiC349i5+4
        jzYCdYD2ULtSM+xYKiWxxEbhkgcM0vpa7XOKcin3qL/3vXUzy+uLMnNVO+OB2B71He6FmLqwWcyJa
        CFz2JOxoJ0tKhb/LILTOHHUaW1Zk3uK5PcHwjSPdX9re1qQX/i+3dT7o0mX+VTW7iY7JmdQ1ByONx
        VUJB7tuA==;
Received: from [201.162.240.150] (port=28860 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jBN1u-004LTL-1r; Mon, 09 Mar 2020 13:21:30 -0500
Date:   Mon, 9 Mar 2020 13:24:42 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] nfs: Replace zero-length array with flexible-array
 member
Message-ID: <20200309182442.GA5422@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.240.150
X-Source-L: No
X-Exim-ID: 1jBN1u-004LTL-1r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.240.150]:28860
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 30
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/nfs/dir.c      | 2 +-
 fs/nfs/nfs4proc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index d4b839b6cf89..a551a30047f9 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -141,7 +141,7 @@ struct nfs_cache_array {
 	int size;
 	int eof_index;
 	u64 last_cookie;
-	struct nfs_cache_array_entry array[0];
+	struct nfs_cache_array_entry array[];
 };
 
 typedef int (*decode_dirent_t)(struct xdr_stream *, struct nfs_entry *, bool);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 69b7ab7a5815..cc0960558284 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5550,7 +5550,7 @@ static int buf_to_pages_noslab(const void *buf, size_t buflen,
 struct nfs4_cached_acl {
 	int cached;
 	size_t len;
-	char data[0];
+	char data[];
 };
 
 static void nfs4_set_cached_acl(struct inode *inode, struct nfs4_cached_acl *acl)
-- 
2.25.0

