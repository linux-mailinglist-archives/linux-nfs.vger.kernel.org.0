Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D92780605
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 08:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358086AbjHRGzb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Aug 2023 02:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358159AbjHRGzZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Aug 2023 02:55:25 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E3C2713;
        Thu, 17 Aug 2023 23:55:16 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68879c7f5easo502413b3a.1;
        Thu, 17 Aug 2023 23:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692341715; x=1692946515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z2dlCcrBqBcGUSz9puYC08uaYiHm3jH93zO50sHybWA=;
        b=fxVRXcIx9MkYFfp1QWkdHndQWctk0v+7gnYTe1gepuK998MWE6/HIfZLE9TQh3ZT+/
         PMZK3s8m0xAbT6wY6yg9NDcBw1YczbQrFithT1n5vda0+KgXttmSysVssw1NOYHegjKn
         8KXkTnNCZIuAV1J1J6EtLaDblxyyRkTY2Jb2gTTxIy2sOq/CQSFst3Si9C6jxUT0pWXP
         s32jrZJi8DUEGKf9JEOAnW3P44PGdwyvHqLk2RlZkBICDc30OnL0ZSKcDy0e/dLyPvE4
         8dlhz4mc2heICmG1RGPvUl+KaraNFrYkfYn4K5JftNFZDhZ31CHDFK/jzs5XU1msqaPt
         tmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692341715; x=1692946515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2dlCcrBqBcGUSz9puYC08uaYiHm3jH93zO50sHybWA=;
        b=Z22vB6Rwsa9xalakd5TQs8YjHdenhJ4Pdf1M3uwTlNib1fgYYkdnYjr0HRI0SGkdkw
         FCVtUASqiQFOdPmpyp1+vkfco9IDAsFvAmQU9wliO4A7yn2Ly1zIbvAg4EqCFcLLGTWQ
         u03hSjtj3qpCAn+sohOIQk1AkJLbT9vRlKBY2i0tkEv0AmBwMz84wduid1tDcDwlVKIa
         O4rbHubo4IoTIhCT5RCk7iFCXIOAI4yXffdEg7qQTZGhqqwg3Oj6ykdc0tVEgu9DfVpz
         jfBTHJvIi29Y+xeG+SnAOjay3+n4bWYAHt6RK1+h9jf1rbeiVeAYpW245RbHRscQ0CaI
         iC9w==
X-Gm-Message-State: AOJu0YzGKBhjE5n8S97XpzB5hMz3RAyASlreq+xRgZAvrqVN4l9l6Ip9
        LsRB+DwymsGO38yGeN4gT9s=
X-Google-Smtp-Source: AGHT+IGnv48CX1thOsyiIzhxcw/gjE7Emd+LTOt3xw+9bqZaa6jvD2NtK1WNyRJ9DiDhjoFeY56lqg==
X-Received: by 2002:a05:6a00:158a:b0:686:9385:4642 with SMTP id u10-20020a056a00158a00b0068693854642mr1995004pfk.6.1692341715193;
        Thu, 17 Aug 2023 23:55:15 -0700 (PDT)
Received: from haodong-Precision.fareast.nevint.com ([140.206.46.75])
        by smtp.gmail.com with ESMTPSA id a18-20020a62bd12000000b00687dde8ae5dsm817234pff.154.2023.08.17.23.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 23:55:14 -0700 (PDT)
From:   Haodong Wong <haydenw.kernel@gmail.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     haodong.wong@nio.com, "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: fix race condition in nfsd_file_acquire
Date:   Fri, 18 Aug 2023 14:55:07 +0800
Message-Id: <20230818065507.1280625-1-haydenw.kernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Before Kernel 6.1, we observed the following OOPS in the stress test
caused by reorder on set bit NFSD_FILE_HASHED and NFSD_FILE_PENDING,
and smp_mb__after_atomic() should be a paire.

Task A:                         Task B:

nfsd_file_acquire:

    new = nfsd_file_alloc()
    open_file:
    refcount_inc(&nf->nf_ref);
                                 nf = nfsd_file_find_locked();
                                 wait_for_construction:

                                 since nf_flags is zero it will not wait

                                 wait_on_bit(&nf->nf_flags,
                                                    NFSD_FILE_PENDING);

                                if (status == nfs_ok) {
                                     *pnf = nf;      //OOPS happen!

Unable to handle kernel NULL pointer at virtual address 0000000000000028
Mem abort info:
  ESR = 0x96000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000152546000
[0000000000000028] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 96000004 [#1] PREEMPT_RT SMP
CPU: 7 PID: 1767 Comm: nfsd Not tainted 5.10.104 #1
pstate: 40c00005 (nZcv daif +PAN +UAO -TCO BTYPE=--)
pc : nfsd_read+0x78/0x280 [nfsd]
lr : nfsd_read+0x68/0x280 [nfsd]
sp : ffff80001c0b3c70
x29: ffff80001c0b3c70 x28: 0000000000000000
x27: 0000000000000002 x26: ffff0000c8a3ca70
x25: ffff0000c8a45180 x24: 0000000000002000
x23: ffff0000c8a45178 x22: ffff0000c8a45008
x21: ffff0000c31aac40 x20: ffff0000c8a3c000
x19: 0000000000000000 x18: 0000000000000001
x17: 0000000000000007 x16: 00000000b35db681
x15: 0000000000000156 x14: ffff0000c3f91300
x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000
x9 : 0000000000000000 x8 : ffff000118014a80
x7 : 0000000000000002 x6 : ffff0002559142dc
x5 : ffff0000c31aac40 x4 : 0000000000000004
x3 : 0000000000000001 x2 : 0000000000000000
x1 : 0000000000000001 x0 : ffff000255914280
Call trace:
 nfsd_read+0x78/0x280 [nfsd]
 nfsd3_proc_read+0x98/0xc0 [nfsd]
 nfsd_dispatch+0xc8/0x160 [nfsd]
 svc_process_common+0x440/0x790
 svc_process+0xb0/0xd0
 nfsd+0xfc/0x160 [nfsd]
 kthread+0x17c/0x1a0
 ret_from_fork+0x10/0x18

Signed-off-by: Haodong Wong <haydenw.kernel@gmail.com>
---
 fs/nfsd/filecache.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index e30e1ddc1ace..ba980369e6b4 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -974,8 +974,12 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	nfsd_file_slab_free(&new->nf_rcu);
 
 wait_for_construction:
+	/* In case of set bit NFSD_FILE_PENDING and NFSD_FILE_HASHED reorder */
+	smp_rmb();
 	wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
 
+	/* Be a paire of smp_mb after clear bit NFSD_FILE_PENDING */
+	smp_mb__after_atomic();
 	/* Did construction of this file fail? */
 	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
 		if (!retry) {
@@ -1018,8 +1022,11 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	nf = new;
 	/* Take reference for the hashtable */
 	refcount_inc(&nf->nf_ref);
-	__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
 	__set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
+	/* Ensure set bit order set NFSD_FILE_HASHED after set NFSD_FILE_PENDING */
+	smp_wmb();
+	__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
+
 	list_lru_add(&nfsd_file_lru, &nf->nf_lru);
 	hlist_add_head_rcu(&nf->nf_node, &nfsd_file_hashtbl[hashval].nfb_head);
 	++nfsd_file_hashtbl[hashval].nfb_count;
-- 
2.25.1

