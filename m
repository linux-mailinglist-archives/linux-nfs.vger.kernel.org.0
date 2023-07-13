Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E3E752593
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jul 2023 16:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjGMOw0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jul 2023 10:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjGMOwZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jul 2023 10:52:25 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029FF2713
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jul 2023 07:52:22 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbf1b82dc7so7362915e9.2
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jul 2023 07:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689259940; x=1691851940;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnSh5SfrnbF+Qn7RYuuYLVFsgVMj1KOf/e+4obmVm4Q=;
        b=c7pQpF+eH/hIfiqxV5fIrxhhznHPHZAHgPmPQT0dypmwGQFtjPb2d8UFCXiDmd3ESA
         IAvkt+gh3LSUZFbVIkWl+qc2xhj+7sP/8FrNqDqHkwa6tfV94NHaZ7j3LO5k8JKg3WVk
         Gf4tH9T9m24ofNDWToyEIgA9Cvz8lXfJGU9rjU53uqGEciyRqqm17Ld4jJqcm3o4hZUN
         Chjpzr0bMtrBASjruU9zoWf42yoxVaLzp1uP8bmJr9bfBjvS1oqLcqn9BSNplce/081S
         Zw96G+no9dOXfESJWt2PpdwlyjJF7F5CDUDPGI00vxIiItiyaZKsR2nYXhbR5eTfb4/2
         jsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689259940; x=1691851940;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fnSh5SfrnbF+Qn7RYuuYLVFsgVMj1KOf/e+4obmVm4Q=;
        b=Y33m4ZcJLtdTpi2YvNmu/dgm0BIl1m9YaRO2UW+74LPVqEuS5QqwGUm6VPybPERmuT
         L6Rthg3LETAToN+qJnKCxwhT6n8XhpDPDn+oKBj25fLomobgGCUwQ5TdILGazhe1chWX
         WeeuffihxOGoHGaYULyIEmqSm4K2VFykr+sf3Fo+waq5jjk67S2Nh0TGg+dPLR7jkTYg
         NrRRQyFh7etcor4JedZ3eCzMb/AClp3B088ZjzFQJRXqdjff+C0gMoX84AA4Go7jaBcD
         cG0jcQcHq7kUwAeQiPX19bcBbktQDbfDDQDwYbOhao5jma6hoKPPZ9QXex6v6/fPtIhz
         Ik8A==
X-Gm-Message-State: ABy/qLailWeneYMdpUhfrL64chv0g8Pc9OmS0ogu+Z9jB3uVVH6C/PQ7
        re0mSRlb8XNrHqsOWYJTIdY=
X-Google-Smtp-Source: APBJJlEp41ogdFI0f6UP5O4ZZQ0kJTn6pu/ot5BwlZN29I0uM0nw/2De4QLvG0PJ7de8H8YrkEFN/g==
X-Received: by 2002:a1c:7910:0:b0:3f9:82f:bad1 with SMTP id l16-20020a1c7910000000b003f9082fbad1mr1506815wme.40.1689259940220;
        Thu, 13 Jul 2023 07:52:20 -0700 (PDT)
Received: from [0.0.0.0] ([95.179.233.4])
        by smtp.gmail.com with ESMTPSA id d2-20020adfe842000000b003143c06135bsm8132412wrn.50.2023.07.13.07.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 07:52:19 -0700 (PDT)
Message-ID: <8d6d9329-f5f1-2f15-f578-e4f8010b9b02@gmail.com>
Date:   Thu, 13 Jul 2023 22:52:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Anna Schumaker <anna@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
From:   Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] nfs: fix redundant readdir request after get eof
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When a directory contains 18 files (includes . and ..), nfs client sends
a redundant readdir request after get eof.

A simple reproduce,
At NFS server, create a directory with 18 files under exported directory.
 # mkdir test
 # cd test
 # for i in {0..16} ; do touch $i; done

At NFS client, no matter mounting through nfsv3 or nfsv4,
does ls (or ll) at the created test directory.

A tshark output likes following,

 # tshark -i eth0 tcp port 2049 -Tfields -e ip.src -e ip.dst -e nfs -e nfs.cookie4

srcip   dstip   SEQUENCE, PUTFH, READDIR        0
dstip   srcip   SEQUENCE PUTFH READDIR  909539109313539306,2108391201987888856,2305312124304486544,2566335452463141496,2978225129081509984,4263037479923412583,4304697173036510679,4666703455469210097,4759208201298769007,4776701232145978803,5338408478512081262,5949498658935544804,5971526429894832903,6294060338267709855,6528840566229532529,8600463293536422524,9223372036854775807
srcip   dstip
srcip   dstip   SEQUENCE, PUTFH, READDIR        9223372036854775807
dstip   srcip   SEQUENCE PUTFH READDIR

The READDIR with cookie 9223372036854775807(0x7FFFFFFFFFFFFFFF) is redundant.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/nfs/dir.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 8f3112e71a6a..0f944b246278 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1089,6 +1089,11 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 	for (i = desc->cache_entry_index; i < array->size; i++) {
 		struct nfs_cache_array_entry *ent;
 
+		if (first_emit && i > NFS_READDIR_CACHE_MISS_THRESHOLD + 1) {
+			desc->eob = true;
+			break;
+		}
+
 		ent = &array->array[i];
 		if (!dir_emit(desc->ctx, ent->name, ent->name_len,
 		    nfs_compat_user_ino64(ent->ino), ent->d_type)) {
@@ -1107,10 +1112,6 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 			desc->ctx->pos = desc->dir_cookie;
 		else
 			desc->ctx->pos++;
-		if (first_emit && i > NFS_READDIR_CACHE_MISS_THRESHOLD + 1) {
-			desc->eob = true;
-			break;
-		}
 	}
 	if (array->folio_is_eof)
 		desc->eof = !desc->eob;
-- 
2.41.0

