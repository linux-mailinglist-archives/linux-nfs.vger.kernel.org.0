Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C017D19ED31
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Apr 2020 19:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgDER5g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 5 Apr 2020 13:57:36 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:40115 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726776AbgDER5g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 5 Apr 2020 13:57:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=wuyihao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Tuft5DG_1586109442;
Received: from Macintosh.local(mailfrom:wuyihao@linux.alibaba.com fp:SMTPD_---0Tuft5DG_1586109442)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 Apr 2020 01:57:23 +0800
Subject: [PATCH v3] SUNRPC/cache: Fix unsafe traverse caused double-free in
 cache_purge
From:   Yihao Wu <wuyihao@linux.alibaba.com>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        NeilBrown <neilb@suse.de>, Sasha Levin <sashal@kernel.org>
Cc:     linux-nfs@vger.kernel.org
References: <4568a7cf87f110b8e59fda6f53fda34c550ab403.1586108200.git.wuyihao@linux.alibaba.com>
Message-ID: <e0dd0339-a15e-814d-ac5a-5f51bc15d73c@linux.alibaba.com>
Date:   Mon, 6 Apr 2020 01:57:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4568a7cf87f110b8e59fda6f53fda34c550ab403.1586108200.git.wuyihao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Deleting list entry within hlist_for_each_entry_safe is not safe unless
next pointer (tmp) is protected too. It's not, because once hash_lock
is released, cache_clean may delete the entry that tmp points to. Then
cache_purge can walk to a deleted entry and tries to double free it.

Fix this bug by holding only the deleted entry's reference.

Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
---
v1->v2: Use Neil's better solution
v2->v3: Fix a checkscript warning

 net/sunrpc/cache.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index af0ddd28b081..b445874e8e2f 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -541,7 +541,9 @@ void cache_purge(struct cache_detail *detail)
 	dprintk("RPC: %d entries in %s cache\n", detail->entries, detail->name);
 	for (i = 0; i < detail->hash_size; i++) {
 		head = &detail->hash_table[i];
-		hlist_for_each_entry_safe(ch, tmp, head, cache_list) {
+		while (!hlist_empty(head)) {
+			ch = hlist_entry(head->first, struct cache_head,
+					 cache_list);
 			sunrpc_begin_cache_remove_entry(ch, detail);
 			spin_unlock(&detail->hash_lock);
 			sunrpc_end_cache_remove_entry(ch, detail);
-- 
2.20.1.2432.ga663e714

