Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A482C7284
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Nov 2020 23:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389838AbgK1VuJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Nov 2020 16:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbgK1Sh7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 28 Nov 2020 13:37:59 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32027C02A1A0;
        Sat, 28 Nov 2020 05:50:59 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id u2so4001067pls.10;
        Sat, 28 Nov 2020 05:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NAaKMiO3+eNR4sgSR3sGVZDQoceEJQzQRN6qUQNwYCU=;
        b=F1MwlJUVPCdrfSPBqGl/h5JdLKUPgahWOy5Sm4oa3ZsAC9TstDAhSsAQh0vRiCDcI1
         yA1+oUeK8ABjlWraDuX8EG7wl+MaUyrwGkLeE6ilk5JeihD8d0Iq11HpfL8ydxWDefe5
         Ye7w06MvsBycYVtAC8CnzTrB0fpfcBqUZ8lQDEcmGfxvJlDGqbtyhoQseoKB0UdYuVSi
         sBH0Vm++TscbVYJ3fmisT3IsL/e8m4R8yiH2M4Up7V6lKGTtYZAYB07WintI/PzwKeRN
         860bstwPjq41NXvyb4PohFWQW2ElklIUM7fueZoBPQhcvCkV50ehRmWSaAs/gQYXjJyU
         ZP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NAaKMiO3+eNR4sgSR3sGVZDQoceEJQzQRN6qUQNwYCU=;
        b=fosyIs3q+Rt/K3WQBQGVe//9D8EgOIUPDw6ljFDJrIQ2DIxbKRVEmZXSaRWmuAJn7D
         shGuTD/tVEj61Wlo2CYS+ZfKSwVFnoHKS/x6B3RmVNPRtOtzn9zo1LF/eEz/DFssJjf1
         x9tanWtr9z5zbj/Vfea6YbX4D5f9ZVqAoyzXLBOO2Ei5F955OUIOQ1rrO2Nh2O24EFnK
         xX0pW3WlXGsNfUnek3iG+KjH2ekVnasQm3C0Fc7k/K10QkZ91Ai2riT4FzckjNwTGEg7
         GkHJgcH++uRJjMeY4rsP+VN9Pjm+2LxjV9GZoeNN2Bsergx0CvXbRB8alGvRL+TkrETZ
         csBw==
X-Gm-Message-State: AOAM530ispzGWwHDls8AB4gVrvVFKmm7sP2lGlxBd/xq4ytV8/+oONCl
        uFhxqlzvBcm91y9nk0kwEgjZiR1eASJwHQ==
X-Google-Smtp-Source: ABdhPJy69mn4Wl+YKc9TEvM+9ZzjAeoDT83i1CjHOOHqcWxQqrpoafrTCNZ26a4HY64a7Zjf8xSFFQ==
X-Received: by 2002:a17:902:eb0c:b029:da:51da:cdac with SMTP id l12-20020a170902eb0cb02900da51dacdacmr6451087plb.4.1606571458474;
        Sat, 28 Nov 2020 05:50:58 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.167.220.174])
        by smtp.gmail.com with ESMTPSA id e17sm10414159pfm.155.2020.11.28.05.50.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Nov 2020 05:50:57 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] nfsd: Fix kernel test robot warning
Date:   Sat, 28 Nov 2020 19:20:51 +0530
Message-Id: <1606571451-3655-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Kernel test robot throws below warning -

>> fs/nfsd/nfs3xdr.c:299:6: warning: variable 'err' is used
>> uninitialized whenever 'if' condition is false
>> [-Wsometimes-uninitialized]
           if (!v4 || !inode->i_sb->s_export_op->fetch_iversion)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/nfsd/nfs3xdr.c:304:6: note: uninitialized use occurs here
           if (err) {
               ^~~
   fs/nfsd/nfs3xdr.c:299:2: note: remove the 'if' if its condition is
always true
           if (!v4 || !inode->i_sb->s_export_op->fetch_iversion)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/nfsd/nfs3xdr.c:293:12: note: initialize the variable 'err' to
silence this warning
           __be32 err;
                     ^
                      = 0
   1 warning generated.

Initialize err = 0 to silence this warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 fs/nfsd/nfs3xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index abb1608..47aeaee 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -290,7 +290,7 @@ void fill_post_wcc(struct svc_fh *fhp)
 {
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
 	struct inode *inode = d_inode(fhp->fh_dentry);
-	__be32 err;
+	__be32 err = 0;
 
 	if (fhp->fh_post_saved)
 		printk("nfsd: inode locked twice during operation.\n");
-- 
1.9.1

