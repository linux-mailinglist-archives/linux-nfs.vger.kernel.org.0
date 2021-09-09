Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7FB405DEC
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Sep 2021 22:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242975AbhIIUOt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Sep 2021 16:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245620AbhIIUOq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Sep 2021 16:14:46 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C657C061574
        for <linux-nfs@vger.kernel.org>; Thu,  9 Sep 2021 13:13:36 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id x5so2586074qtq.13
        for <linux-nfs@vger.kernel.org>; Thu, 09 Sep 2021 13:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NHSqQj2Uz/cR7Z7XaZVMVTCQMvyjXywS3dbNkyavA5c=;
        b=GGr5kuhpiBDOcl40KObknVAzCn+3WxSBQEET1idlnEA4RO0Sgv+G5NUm8sD/MijC+F
         KTBriWTCNQHLkmFhm9pd7ebHyaNk0AcsbKHURLMnXn6FuTX4XPvEuhJsGV15RDQtCbE+
         3MOziHhWh8qtee2SIAwnNvW2XCGL9qwM7XyhPjbwq9kOE9UTqJHTTj/sxPVWr7aqyrnW
         6hIaPoZOWh84Pg+hbZcTmAO3qpLEMznr4t26OkqxxARczxUPndEWGsVaNKmG29ZPVz15
         Io+vVW+CQUcPgERRvi1I+BmA3PkUy2XbFJ9AqSjwuYMKt/PoHha20ANbARh5gSLDFUF4
         Bkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=NHSqQj2Uz/cR7Z7XaZVMVTCQMvyjXywS3dbNkyavA5c=;
        b=AuvZ5YgFb8wwEQIszy1b4BKxJgbUyx+BFSSgsvLsDRXRKJLlsv+gISCrSaliYJHAVw
         /wJ4VqBjG9zZ+7ZJ5Zrb+FWBkXhEhewNVx4kuYNv+NJZM/6LJ6LDELcVPLTVHRzsmM4R
         tsAxjnItglVu2nFC0hiuhqDFmwMMD7r2keJfqKTv4Q7UYGgzm1YLV54tRsxvd9VR9af6
         iJmAZMiiaiZpDij1GoNMaZvL8E4KMGNsqeyLA/tYw+KrgzP3sGZXRBGxK3eHHhMmECIp
         8FbMauG3YayxQqXmK1TzKh8MjeGXScF/r+10yvD/CTXsBZUpd3AA+Up/2VZ9JTt8W5kp
         RN8g==
X-Gm-Message-State: AOAM533IJCPnasNdoFMGMosSDDKoTpHV6iNjoNR9n1Hh4PCiQt0wfB2E
        +ewhV8pi2stJt7LeYOFQl/I=
X-Google-Smtp-Source: ABdhPJw/reI4n93m3NRNZznDV/xTxPeor013d5I8dkhH8kEyjPaaWiJ0pP0WT5tLButSl8dNyOUAbA==
X-Received: by 2002:ac8:108a:: with SMTP id a10mr4825601qtj.14.1631218415422;
        Thu, 09 Sep 2021 13:13:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id l13sm2104020qkp.97.2021.09.09.13.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:13:35 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 11/14] NFS: Remove the nfs4_label argument from nfs_add_or_obtain()
Date:   Thu,  9 Sep 2021 16:13:24 -0400
Message-Id: <20210909201327.108759-12-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210909201327.108759-1-Anna.Schumaker@Netapp.com>
References: <20210909201327.108759-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/dir.c           | 7 +++----
 fs/nfs/nfs3proc.c      | 2 +-
 include/linux/nfs_fs.h | 3 +--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 77bcafc692c3..cf7d0280155a 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2034,8 +2034,7 @@ static int nfs4_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 
 struct dentry *
 nfs_add_or_obtain(struct dentry *dentry, struct nfs_fh *fhandle,
-				struct nfs_fattr *fattr,
-				struct nfs4_label *label)
+				struct nfs_fattr *fattr)
 {
 	struct dentry *parent = dget_parent(dentry);
 	struct inode *dir = d_inode(parent);
@@ -2058,7 +2057,7 @@ nfs_add_or_obtain(struct dentry *dentry, struct nfs_fh *fhandle,
 		if (error < 0)
 			goto out_error;
 	}
-	inode = nfs_fhget(dentry->d_sb, fhandle, fattr, label);
+	inode = nfs_fhget(dentry->d_sb, fhandle, fattr, fattr->label);
 	d = d_splice_alias(inode, dentry);
 out:
 	dput(parent);
@@ -2077,7 +2076,7 @@ int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fhandle,
 {
 	struct dentry *d;
 
-	d = nfs_add_or_obtain(dentry, fhandle, fattr, fattr->label);
+	d = nfs_add_or_obtain(dentry, fhandle, fattr);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
 
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 5695335bb5b2..cdc929efe4fd 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -322,7 +322,7 @@ nfs3_do_create(struct inode *dir, struct dentry *dentry, struct nfs3_createdata
 	if (status != 0)
 		return ERR_PTR(status);
 
-	return nfs_add_or_obtain(dentry, data->res.fh, data->res.fattr, NULL);
+	return nfs_add_or_obtain(dentry, data->res.fh, data->res.fattr);
 }
 
 static void nfs3_free_createdata(struct nfs3_createdata *data)
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 07d4cd27111f..457c5a7c1e1c 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -519,8 +519,7 @@ extern void nfs_set_verifier(struct dentry * dentry, unsigned long verf);
 extern void nfs_clear_verifier_delegated(struct inode *inode);
 #endif /* IS_ENABLED(CONFIG_NFS_V4) */
 extern struct dentry *nfs_add_or_obtain(struct dentry *dentry,
-			struct nfs_fh *fh, struct nfs_fattr *fattr,
-			struct nfs4_label *label);
+			struct nfs_fh *fh, struct nfs_fattr *fattr);
 extern int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fh,
 			struct nfs_fattr *fattr);
 extern int nfs_may_open(struct inode *inode, const struct cred *cred, int openflags);
-- 
2.33.0

