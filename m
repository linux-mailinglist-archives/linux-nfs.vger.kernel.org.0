Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D36633DA3
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Nov 2022 14:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiKVN24 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Nov 2022 08:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiKVN24 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Nov 2022 08:28:56 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80FD64547;
        Tue, 22 Nov 2022 05:28:51 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so14342889pjl.3;
        Tue, 22 Nov 2022 05:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=95bxvB3m1WUxDVxDgwyJI7abCy5JBWykIIuSBhM3v5c=;
        b=qltDiL46ZrbgP8NaY3ll908jwySCkQARbcOCWypjMjQQctaGmfP416MwFYa25trYjS
         gpwOmyjHsHJBGiOA7wAQJZBabbF2Qw9PakW6X1A2jUNCSMwSNHl0ywhMzeGhkMUN8HA6
         98v1p/9ky7jCOd0YKW5XkUXhtx4lZteE5HP810Av20WpJJcVcvjX4Amj5T8L8Pti6kMX
         rWyUPzgXPXsmADpky4ltumvueC+UVCL+qHcL+weIpIbHKhxNtji7M3haLCKg4vn1JsPq
         AgmGdRATW4BqdyCcNDzWuQfnrnyTUrLirrQAKsxqWrprnQz6HBmd5pVZzLLKnUNQiGEu
         XLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95bxvB3m1WUxDVxDgwyJI7abCy5JBWykIIuSBhM3v5c=;
        b=QXeSZG6iw9ve8lq+opOBrGO3GUrX7mQky7jHZemsakC+oFQw0fwvm0iP515grV/gSG
         3APGxYGO0xHO60FGJbtlQT47a+GlQG6XL/uNszhV49XeD2JW1124K73CgpIvMvZugEO2
         VV1sRA0VeH18lMo2F5U3p3qDy10jIVawSFs6I/Nk8dX/WAfL7bikFg6B9EjnW1Rx6BMn
         nj80rVR98ZJJmkj9M1jvTtN57AUDvkfwDXdWJYWl8RsW+ZTHJ+1Gkd++Qktu7/1x4O1g
         0MKWHbSFGdLR9QgmwyiJLg8ZNSnPNlP6v2T1fxxXJTpCmGR96kXHahSOUA1sfcKaw31s
         s33A==
X-Gm-Message-State: ANoB5pnhF2rBbk1gFRfOBYui/oZH5FJ2JPy4/2gfokLT8UdG0LxoqhQK
        R2VHjOC4MBOJEPej/IPtKzQ=
X-Google-Smtp-Source: AA0mqf58ilSK1bCjxTI07jOEmp2NfJhoo2bgX3p6z04IKiPwMaM8Mlny8JhaZku9TFC/hGLWF+vLxw==
X-Received: by 2002:a17:902:cf0e:b0:17c:5b01:f227 with SMTP id i14-20020a170902cf0e00b0017c5b01f227mr3766303plg.3.1669123731346;
        Tue, 22 Nov 2022 05:28:51 -0800 (PST)
Received: from ubuntu.localdomain ([60.221.110.5])
        by smtp.gmail.com with ESMTPSA id x3-20020aa79403000000b0056d2317455bsm10652181pfo.7.2022.11.22.05.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 05:28:50 -0800 (PST)
From:   Donglin Peng <dolinux.peng@gmail.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Donglin Peng <dolinux.peng@gmail.com>
Subject: [PATCH] NFS: dprintk() should not print negative inode number
Date:   Tue, 22 Nov 2022 05:28:15 -0800
Message-Id: <20221122132815.15673-1-dolinux.peng@gmail.com>
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

The type of the i_ino member of the inode structure is unsigned long.
There are some occurrences where dprintk() outputs a negative inode
number.This leads to confusion and more difficult to read debugging.

Fixes: 9e6e70f8d8b6 ("NFSv4: Support NFSv4 optional attributes in the struct nfs_fattr")
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 fs/nfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 6b2cfa59a1a2..53d8704e07c5 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2081,7 +2081,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 				if (S_ISDIR(inode->i_mode))
 					nfs_force_lookup_revalidate(inode);
 				attr_changed = true;
-				dprintk("NFS: change_attr change on server for file %s/%ld\n",
+				dprintk("NFS: change_attr change on server for file %s/%lu\n",
 						inode->i_sb->s_id,
 						inode->i_ino);
 			} else if (!have_delegation)
-- 
2.25.1

