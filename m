Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE842A97CD
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Nov 2020 15:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgKFOl5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Nov 2020 09:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgKFOl5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Nov 2020 09:41:57 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146FCC0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Nov 2020 06:41:57 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id a20so1237547ilk.13
        for <linux-nfs@vger.kernel.org>; Fri, 06 Nov 2020 06:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O4pYSXpxD9NyE+W0LTzl1OZC1cUbHrJQNpHPUsBGUBI=;
        b=KMOXe1xu8Apg3pG90O7Ujws637k+z9YFVFHOd4/CupXtBdKokGggn4yVUmdde8QmCI
         gCuuHuENPq5XRLS6U4TeosL0Q8jkCN7RipgIPeDPO8xgaxDa388fHCyG2HG3vnG/6NJb
         VYrqpJFkwst0GxX5b8JYVutfMU3BxCklZENee/rexPSK1ryWtPwwzSDE0mp72iHbhZ6n
         h3FXvCBDJXl36UWtON81Qi4jLbgn6V0lJlope37k/KG2UmaY30ldYrnTRKF4faBU4sj/
         IuxjvXePxL8xYm9JcS/vYO8p1oikXQQ/j3FLcGDJ7qf5V3GYmWr1e6VWh1R7fAvbAKye
         LBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O4pYSXpxD9NyE+W0LTzl1OZC1cUbHrJQNpHPUsBGUBI=;
        b=e8+dYJFat5UxxziEcOmjX3MjHkT703+LOTod8gV36DqbPKcgv2B3TJCrW3GFy1Lucd
         0hzc9eZQZJUbHsjorlTh7Ko+whQn86hBR6IJRplofZTHf63dN3FO1FS5P7W8SnVxzCGN
         MBAYDajg4ZiaSSC/Qoyzo2KKNiWyDtEcGnRmrkL/THEJH6PZs14mfLl37bQHDTAMTiSi
         r9UgRTuHmbpbKTnTYLsAiOQEWEE2GtZwrB99Bs5xOD0oSOvu4EvH8o6LDvbt8UFBhWC5
         xneG45Yd4lReRl6SbeS8hQsvqlGP6rHiQsHHMkWrYt+bMNOhna99G0UbKfsZZ7mcaOLX
         iWuQ==
X-Gm-Message-State: AOAM532alSs00wj8K387Rh0MEzKU4qcaHifTITb05d5o3A79Nz3TDNlX
        5V7NKTulGGPtCAQu699A6+o=
X-Google-Smtp-Source: ABdhPJz7oSnGGjfvhFuZ0n/bYMtU11yGoxJfqK/VO+YhnPxkcEYa1wbVrjyCAazdCDSZmUiGvlYNWA==
X-Received: by 2002:a05:6e02:112:: with SMTP id t18mr1575678ilm.299.1604673716347;
        Fri, 06 Nov 2020 06:41:56 -0800 (PST)
Received: from Olgas-MBP-377.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id c2sm994193iot.52.2020.11.06.06.41.55
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Nov 2020 06:41:55 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, omosnace@redhat.com
Subject: [PATCH v3 1/1] NFSv4.2: condition READDIR's mask for security label based on LSM state
Date:   Fri,  6 Nov 2020 09:41:54 -0500
Message-Id: <20201106144154.3610-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Currently, the client will always ask for security_labels if the server
returns that it supports that feature regardless of any LSM modules
(such as Selinux) enforcing security policy. This adds performance
penalty to the READDIR operation.

Client adjusts superblock's support of the security_label based on
the server's support but also current client's configuration of the
LSM modules. Thus, prior to using the default bitmask in READDIR,
this patch checks the server's capabilities and then instructs
READDIR to remove FATTR4_WORD2_SECURITY_LABEL from the bitmask.

v3: changing label's initialization per Ondrej's comment
v2: dropping selinux hook and using the sb cap.

Suggested-by: Ondrej Mosnacek <omosnace@redhat.com>
Suggested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c       | 2 ++
 fs/nfs/nfs4xdr.c        | 3 ++-
 include/linux/nfs_xdr.h | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9e0ca9b2b210..d85c78657ef4 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4968,6 +4968,8 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
 		.count = count,
 		.bitmask = NFS_SERVER(d_inode(dentry))->attr_bitmask,
 		.plus = plus,
+		.labels = !!(NFS_SB(dentry->d_sb)->caps &
+				NFS_CAP_SECURITY_LABEL),
 	};
 	struct nfs4_readdir_res res;
 	struct rpc_message msg = {
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index c6dbfcae7517..585d5b5cc3dc 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1605,7 +1605,8 @@ static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg
 			FATTR4_WORD1_OWNER_GROUP|FATTR4_WORD1_RAWDEV|
 			FATTR4_WORD1_SPACE_USED|FATTR4_WORD1_TIME_ACCESS|
 			FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY;
-		attrs[2] |= FATTR4_WORD2_SECURITY_LABEL;
+		if (readdir->labels)
+			attrs[2] |= FATTR4_WORD2_SECURITY_LABEL;
 		dircount >>= 1;
 	}
 	/* Use mounted_on_fileid only if the server supports it */
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index d63cb862d58e..95f648b26525 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1119,6 +1119,7 @@ struct nfs4_readdir_arg {
 	unsigned int			pgbase;	/* zero-copy data */
 	const u32 *			bitmask;
 	bool				plus;
+	bool				labels;
 };
 
 struct nfs4_readdir_res {
-- 
2.18.2

