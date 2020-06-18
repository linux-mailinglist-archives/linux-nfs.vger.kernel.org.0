Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F1F1FE2D2
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2020 04:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbgFRCEV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Jun 2020 22:04:21 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25]:60498 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726893AbgFRCEU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 17 Jun 2020 22:04:20 -0400
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2020 22:04:19 EDT
Received: from ubuntu.localdomain (unknown [124.16.136.101])
        by APP-05 (Coremail) with SMTP id zQCowACnEg+9yepektJEAQ--.42974S2;
        Thu, 18 Jun 2020 09:56:14 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     bfields@fieldses.org, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: Use seq_putc() in two functions
Date:   Thu, 18 Jun 2020 09:56:13 +0800
Message-Id: <20200618015613.17806-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowACnEg+9yepektJEAQ--.42974S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF18tr1DKFWxXr4UZFyfCrg_yoWfZFbE93
        yxuF10kF45Jwn8GFZ0ga1fta4DuayDJr1rt3yI9r9rKF95Gw1UZrs7ZrW3Ar95G3yFgFy8
        Cr9YgFyFy34S9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2xYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_KwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcBMKDUUUU
X-Originating-IP: [124.16.136.101]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBQcLA16HQn8FdgAAsd
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A single character (line break) should be put into a sequence.
Thus use the corresponding function "seq_putc()".

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 fs/nfsd/nfs4idmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index 9460be8a8321..f92161ce1f97 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -168,7 +168,7 @@ idtoname_show(struct seq_file *m, struct cache_detail *cd, struct cache_head *h)
 			ent->id);
 	if (test_bit(CACHE_VALID, &h->flags))
 		seq_printf(m, " %s", ent->name);
-	seq_printf(m, "\n");
+	seq_putc(m, '\n');
 	return 0;
 }
 
@@ -346,7 +346,7 @@ nametoid_show(struct seq_file *m, struct cache_detail *cd, struct cache_head *h)
 			ent->name);
 	if (test_bit(CACHE_VALID, &h->flags))
 		seq_printf(m, " %u", ent->id);
-	seq_printf(m, "\n");
+	seq_putc(m, '\n');
 	return 0;
 }
 
-- 
2.17.1

