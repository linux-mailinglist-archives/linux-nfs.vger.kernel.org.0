Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C793B4F61
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Jun 2021 18:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFZQH7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Jun 2021 12:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFZQHy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 26 Jun 2021 12:07:54 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5F9C061767
        for <linux-nfs@vger.kernel.org>; Sat, 26 Jun 2021 09:05:30 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id bm25so22693020qkb.0
        for <linux-nfs@vger.kernel.org>; Sat, 26 Jun 2021 09:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HTeKvhcaNPhIGWLvdLMbBPtum6F/YoGDtYog8ZFBj/E=;
        b=DPhZT8e7kEdzcmep23PV4fkA92gUBYqfbainLPpuU7ybT65TgAKJUbx3dRAYL2Bx3z
         f2AhqOz5vAGnB9+Q9cKaWPNAWvjBQmwYn64Z9WqyMUjRhHGMYlbnMbBm0mg4KXAY+Rbl
         70G9uVb/3riyuVXE/595EGDLfxYNdlTS09/hl+yU26nrvgF+JQ6IMwkRgXyKPy4eBdVf
         dHX63j5AHQtHzftnVkNplgwTP1IsUXy+gFHuAHsWX892sOuDNXEMec7wwzuie7qjVgpO
         mY5m2OQMR+Slx4tlazWo6dPg9IoRkYGhSQhq44KjVlp267cVRZYoQpBd80QKGTfaBHDQ
         +hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HTeKvhcaNPhIGWLvdLMbBPtum6F/YoGDtYog8ZFBj/E=;
        b=jUVLOtueMYUYnBC/6IrPEy10D6grYuuYyxCNVjKYCp4RHT0v0h1eyjls98CMORi1XZ
         4W/8w8ujAhgP5m6ZWY24Gp4H3aiXLRXPswpBnNbqlseJ6TpROylTg3LXSMezuFeaGL3R
         Neti/oETkK6AjRK/tWOuWJ34N56p8VGzZNB9J+uClGo6ThXA3WO4eVhAKDZQ46bMiSid
         MhjlaTmkjBl738zOg+O2fLuCTDwV5TsaKw4O1W5WHhdz1eEIm49dbCLKznDJhxlTRLIq
         Nbn300f48pTTLsKMRqcaoZhmdOEnvETG8UM8Uf407LDQ3VrAVj6z1O1ixeXBscM3QnPZ
         A3wg==
X-Gm-Message-State: AOAM5308I3CMQfeywdsaosC4pXMLjBZSJEB0/o3MvOAIt9jg6jPTeWjB
        Wms/mebdCojJlBCk/wu5y+OBKWwffokh
X-Google-Smtp-Source: ABdhPJyzBnlPZWkAPrnhsZ2lY6mmDGVggcC/W9sv4CP9GLWz0uTLMC7x0hMcM2LSazGIHAc8eF2z+w==
X-Received: by 2002:a05:620a:1516:: with SMTP id i22mr10665115qkk.373.1624723529588;
        Sat, 26 Jun 2021 09:05:29 -0700 (PDT)
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id 202sm5797624qki.83.2021.06.26.09.05.28
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 09:05:28 -0700 (PDT)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFSv4: Fix handling of non-atomic change attrbute updates
Date:   Sat, 26 Jun 2021 12:05:25 -0400
Message-Id: <20210626160526.323332-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210626160526.323332-2-trond.myklebust@hammerspace.com>
References: <20210626160526.323332-1-trond.myklebust@hammerspace.com>
 <20210626160526.323332-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the change attribute update is declared to be non-atomic by the
server, or our cached value does not match the server's value before the
operation was performed, then we should declare the inode cache invalid.

On the other hand, if the change to the directory raced with a lookup or
getattr which already updated the change attribute, then optimise away
the revalidation.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e4efb7bccd7e..2031d2b9b6e3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1205,12 +1205,12 @@ nfs4_update_changeattr_locked(struct inode *inode,
 	u64 change_attr = inode_peek_iversion_raw(inode);
 
 	cache_validity |= NFS_INO_INVALID_CTIME | NFS_INO_INVALID_MTIME;
+	if (S_ISDIR(inode->i_mode))
+		cache_validity |= NFS_INO_INVALID_DATA;
 
 	switch (NFS_SERVER(inode)->change_attr_type) {
 	case NFS4_CHANGE_TYPE_IS_UNDEFINED:
-		break;
-	case NFS4_CHANGE_TYPE_IS_TIME_METADATA:
-		if ((s64)(change_attr - cinfo->after) > 0)
+		if (cinfo->after == change_attr)
 			goto out;
 		break;
 	default:
@@ -1218,24 +1218,21 @@ nfs4_update_changeattr_locked(struct inode *inode,
 			goto out;
 	}
 
-	if (cinfo->atomic && cinfo->before == change_attr) {
-		nfsi->attrtimeo_timestamp = jiffies;
-	} else {
-		if (S_ISDIR(inode->i_mode)) {
-			cache_validity |= NFS_INO_INVALID_DATA;
+	inode_set_iversion_raw(inode, cinfo->after);
+	if (!cinfo->atomic || cinfo->before != change_attr) {
+		if (S_ISDIR(inode->i_mode))
 			nfs_force_lookup_revalidate(inode);
-		} else {
-			if (!NFS_PROTO(inode)->have_delegation(inode,
-							       FMODE_READ))
-				cache_validity |= NFS_INO_REVAL_PAGECACHE;
-		}
 
-		if (cinfo->before != change_attr)
-			cache_validity |= NFS_INO_INVALID_ACCESS |
-					  NFS_INO_INVALID_ACL |
-					  NFS_INO_INVALID_XATTR;
+		if (!NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
+			cache_validity |=
+				NFS_INO_INVALID_ACCESS | NFS_INO_INVALID_ACL |
+				NFS_INO_INVALID_SIZE | NFS_INO_INVALID_OTHER |
+				NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_NLINK |
+				NFS_INO_INVALID_MODE | NFS_INO_INVALID_XATTR |
+				NFS_INO_REVAL_PAGECACHE;
+		nfsi->attrtimeo = NFS_MINATTRTIMEO(inode);
 	}
-	inode_set_iversion_raw(inode, cinfo->after);
+	nfsi->attrtimeo_timestamp = jiffies;
 	nfsi->read_cache_jiffies = timestamp;
 	nfsi->attr_gencount = nfs_inc_attr_generation_counter();
 	nfsi->cache_validity &= ~NFS_INO_INVALID_CHANGE;
-- 
2.31.1

