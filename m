Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A1D598C54
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Aug 2022 21:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbiHRTHM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Aug 2022 15:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbiHRTHL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Aug 2022 15:07:11 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1370C00E1
        for <linux-nfs@vger.kernel.org>; Thu, 18 Aug 2022 12:07:10 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id m5so1848869qkk.1
        for <linux-nfs@vger.kernel.org>; Thu, 18 Aug 2022 12:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=nAuL4OAijuwpu/163zEudsz36lqWkZNpxNjLPqTE/20=;
        b=VGGsHD4cXejgbMZukvg8yYix0rV4NoVhddlDZyoLiFCTFdN5vK4GB9f6OHp/9mWiAU
         s22oF/LhVE4rIHsnWbSAZJsdushWVve0mQ3yeKOqylbRT6dfePH/YbioDZr7RIlpKDwY
         ejcHcBolBi9xJWZ398Wr+SGh/1hBz/cRAHKBZQXdxBFaYoqjMPXmNNhzHR2TC6sgsSRe
         JQEd4UN22WIgLhJe4VOlHZOAFjhH8uh8ytsT50PXttkqPJv98uxd/NHielrJY3+BAZy4
         A4uPjcl5Ou4Ls2bCkvJR/lfM+zUHBxtqWDcnXBrIdGvZZYyJycAlskW9S4lqmrj+TP+B
         Yqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=nAuL4OAijuwpu/163zEudsz36lqWkZNpxNjLPqTE/20=;
        b=GYB/UPVKlD79VwnMnyQl4cQp+xA/X/pIGHdp8c9eouq/v4Z7ufHW8N2PL8hMlW0JZG
         pKB84tYtgRPim/G9OW3BisReCZh+ZNzNvgkjokLlP10kR34HMWPNW6G5fEHf2VaqFiVq
         u7httPUnQqq8HSnXB6cPIr+HF/UA9YsqQfim5ljTi5mFMeRctjq+52BnOcgHqc4/DsMB
         OZnAygWJheAz5Y72TYMObRAkKR815hVu2vMAtp0wYtUB3MacjYH3VkTcWJgqthcYHf5+
         97Z3VoDQXUn8lg0VPOeFXgB1mgIUyflFWeWguNP6zn3m859SwATbA7X2E6kdUjmv72dD
         CnSw==
X-Gm-Message-State: ACgBeo2kTST9JjH7i4FRql5kHQCanpYjVs37q8pE1v1PsNWgsrlFfvbk
        5gRi6JKwCADodfEhzHDZfIMOMsSuO8s=
X-Google-Smtp-Source: AA6agR5lzlhnHz1cnNpH2gA9Un1pgGQ6AkK0oqEfpeGnJkUHKf44om/rdC3vwqHq3+vM+hijXUXcKA==
X-Received: by 2002:a05:620a:12a8:b0:6ba:f035:fbda with SMTP id x8-20020a05620a12a800b006baf035fbdamr3273187qki.452.1660849629328;
        Thu, 18 Aug 2022 12:07:09 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:6dbb:c3eb:755b:9b58])
        by smtp.gmail.com with ESMTPSA id ay34-20020a05620a17a200b006bb83e2e65fsm2097062qkb.42.2022.08.18.12.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 12:07:08 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        viro@zeniv.linux.org.uk
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.2 fix problems with __nfs42_ssc_open
Date:   Thu, 18 Aug 2022 15:07:05 -0400
Message-Id: <20220818190705.47722-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

A destination server while doing a COPY shouldn't accept using the
passed in filehandle if its not a regular filehandle.

If alloc_file_pseudo() has failed, we need to decrement a reference
on the newly created inode, otherwise it leaks.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Fixes: ec4b092508982 ("NFS: inter ssc open")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index e88f6b18445e..9eb181287879 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -340,6 +340,11 @@ static struct file *__nfs42_ssc_open(struct vfsmount *ss_mnt,
 		goto out;
 	}
 
+	if (!S_ISREG(fattr->mode)) {
+		res = ERR_PTR(-EBADF);
+		goto out;
+	}
+
 	res = ERR_PTR(-ENOMEM);
 	len = strlen(SSC_READ_NAME_BODY) + 16;
 	read_name = kzalloc(len, GFP_KERNEL);
@@ -357,6 +362,7 @@ static struct file *__nfs42_ssc_open(struct vfsmount *ss_mnt,
 				     r_ino->i_fop);
 	if (IS_ERR(filep)) {
 		res = ERR_CAST(filep);
+		iput(r_ino);
 		goto out_free_name;
 	}
 
-- 
2.18.2

