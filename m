Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1318375BBC5
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 03:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjGUBXI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 21:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGUBXI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 21:23:08 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AB1E75
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 18:23:07 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so12178245e9.3
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 18:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689902585; x=1690507385;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJHc3xLH3lXbZGll906ZoFRIQ5wEaT2xRVDGdJWXuIo=;
        b=bsvcrgL1O1jRVq7k+HYZ/HZ6alpb9vDP2wgk1elFAi0yBsXltSvhVy/JhITSIGF4rA
         5vNbJ5J1wTON0cAFP6lJWFwI+kxRGCLKnSLsAq6BJ+shV3047e67pPgBNWe6W1ghGKls
         5Vyg8kz26iCt+2Ly1qmy74tJgEaKcUQPVz3YCPWpko4vl1AoUJO4EkTm+NnZTNp6g7FV
         T0a1mxcikiHQACwMVjlSeQOeqVJluqlkV0prnQmFL6H/ONxvG3Us/gwhWxSIV5+h6AeW
         qw1ruu92KuzdimKrmOckdfiuOE1nT3SKlfMaekAnis1YG3MZoZt1FaZohHY3ooMIX/SK
         1ozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689902585; x=1690507385;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kJHc3xLH3lXbZGll906ZoFRIQ5wEaT2xRVDGdJWXuIo=;
        b=f/O91EIga/xrTOugaIntUuxdhWJ1kHe9eCPUw4u0myLKbJKbrbdyLFTWaiofuopj0J
         m50V8wawjy3n2VPfqi/Ymi+D3vObvkhSJfOpPyGWgTe2yJPH1+Oh1fRETpKOvBEjCFRx
         0iwSCn2cftqrjmtddAYtGlsn9pPn8T0PztglwgLt3uPPdDKmbc1UveEyw0Wx4V798LLw
         iP9Ja9/pINKhusRdCSZ35+aSAPnnG8QtrfiHHxXmREoPiW4x+dfeI46oX1DYtCTAfy0p
         9l5SsOGzL7M28IzCZGL9I0vQiZJfr5YPed4tHEu4gLZdnVBxDDGqzRumHyDkPaUl7A61
         K5AA==
X-Gm-Message-State: ABy/qLYIgCjYE8vZqVL8K/IR+nQIdcCnYgNND1FXhhrGr2lK1vnPz4Ym
        5QMLXxxskjEMbmm4EApTz6g=
X-Google-Smtp-Source: APBJJlGPZ6vHg9VIdX/oTET3l9cD9tAucpZbm7ZRXIparbvbO23yTw/WlbUajPNo5jjOTPXkqfyW0A==
X-Received: by 2002:a7b:cd0b:0:b0:3fc:3f31:4233 with SMTP id f11-20020a7bcd0b000000b003fc3f314233mr299850wmj.38.1689902585193;
        Thu, 20 Jul 2023 18:23:05 -0700 (PDT)
Received: from [0.0.0.0] ([95.179.233.4])
        by smtp.gmail.com with ESMTPSA id w9-20020adfd4c9000000b0031423a8f4f7sm2704026wrk.56.2023.07.20.18.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 18:23:04 -0700 (PDT)
Message-ID: <0e71da0f-7762-bd46-d278-900a953a44d0@gmail.com>
Date:   Fri, 21 Jul 2023 09:23:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Anna Schumaker <anna@kernel.org>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
From:   Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH v2 RESEND] nfs: fix redundant readdir request after get eof
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When a directory contains 17 files (except . and ..), nfs client sends
a redundant readdir request after get eof.

A simple reproduce,
At NFS server, create a directory with 17 files under exported directory.
 # mkdir test
 # cd test
 # for i in {0..16}  ; do touch $i; done

At NFS client, no matter mounting through nfsv3 or nfsv4,
does ls (or ll) at the created test directory.

A tshark output likes following (for nfsv4),

 # tshark -i eth0 tcp port 2049 -Tfields -e ip.src -e ip.dst -e nfs -e nfs.cookie4

srcip   dstip   SEQUENCE, PUTFH, READDIR        0
dstip   srcip   SEQUENCE PUTFH READDIR  909539109313539306,2108391201987888856,2305312124304486544,2566335452463141496,2978225129081509984,4263037479923412583,4304697173036510679,4666703455469210097,4759208201298769007,4776701232145978803,5338408478512081262,5949498658935544804,5971526429894832903,6294060338267709855,6528840566229532529,8600463293536422524,9223372036854775807
srcip   dstip
srcip   dstip   SEQUENCE, PUTFH, READDIR        9223372036854775807
dstip   srcip   SEQUENCE PUTFH READDIR

The READDIR with cookie 9223372036854775807(0x7FFFFFFFFFFFFFFF) is redundant.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/nfs/dir.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 8f3112e71a6a..e6a51fd94fea 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1089,6 +1089,17 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 	for (i = desc->cache_entry_index; i < array->size; i++) {
 		struct nfs_cache_array_entry *ent;
 
+		/*
+		 * nfs_readdir_handle_cache_misses return force clear at
+		 * (cache_misses > NFS_READDIR_CACHE_MISS_THRESHOLD) for
+		 * readdir heuristic, NFS_READDIR_CACHE_MISS_THRESHOLD + 1
+		 * entries need be emitted here.
+		 */
+		if (first_emit && i > NFS_READDIR_CACHE_MISS_THRESHOLD + 2) {
+			desc->eob = true;
+			break;
+		}
+
 		ent = &array->array[i];
 		if (!dir_emit(desc->ctx, ent->name, ent->name_len,
 		    nfs_compat_user_ino64(ent->ino), ent->d_type)) {
@@ -1107,10 +1118,6 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
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

