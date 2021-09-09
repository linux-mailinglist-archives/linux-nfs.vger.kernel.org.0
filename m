Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C125B405DE7
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Sep 2021 22:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhIIUOq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Sep 2021 16:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbhIIUOl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Sep 2021 16:14:41 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3624DC061757
        for <linux-nfs@vger.kernel.org>; Thu,  9 Sep 2021 13:13:31 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id ay33so3245750qkb.10
        for <linux-nfs@vger.kernel.org>; Thu, 09 Sep 2021 13:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a3JwvIG+jhiREYJH5m11iAk6G/o9z1M7L05zTtJp6Ks=;
        b=fVXBjjKemL5nE6mq9CmmC8C5+evLK0pW+Ix4yTRpNMwQb2lfRea4d5HQFQwKUo1dnd
         geTlWDSgvgAdFVjaJlqPVMhws8mCFFd7kVzyHPkDYPME1+DpODB6ucclHgExryTkb1HY
         bBspn3nJVv1gZ1d9hE0BSNbvbPw/ENnSYE4zc1nx/pL527MHbJYOuTeczu+KufmFRx/A
         nMLVdKpewxUu9bnpPHpzej3q95F1agvIyK5pJsoQkBNZIzZ7OPV9zD20z5GgHWwl1JVC
         rSSsf06A6/I8eLIikhoXgZj7w//8QPN1WA1RJic6W/EXrNCj8SIX+Z1ZbW3ytGKgjR2Z
         xOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=a3JwvIG+jhiREYJH5m11iAk6G/o9z1M7L05zTtJp6Ks=;
        b=db4iIACIqXzJEppqrBGmDVyAXMFRp2iRRITdFAeFDCs0pJOyYNtBxNJ3JWuXCrmSUH
         uUgUNjlPGG54K23Halm6f95L6cVhCQEqu0FsZ5Iu+o8Kuk9hlYaQqdcvV6fxx1yqoClJ
         GiSHu2BmH4C8OCqozqZOOknlaooxWKjoGirtSp1hxDtSbdBxkrLpxuoEKiuxyF96k0Er
         z875ZHnFTOd1aITCBN/tLUf6QpJDXd0Ec9QDypzqanbm/3zy5Xy8y0eHR2GoZQG60+QX
         bae41okxaRlCHVxfSvegAjyaGVCftW1XzbMkS7+EprPAzT3X5i0m96n2MO6Z9avxi5K7
         Cqlg==
X-Gm-Message-State: AOAM533+1d7nHUElE0OyzARPDf9Tyuroe0c88WFmKHZJyua82uLjCvOE
        ZkSjzUkV9xz6HBAUqU1FU18=
X-Google-Smtp-Source: ABdhPJzxf9st3X2AK4nPuWzE/Oc923i6KqTMsAGczykRnlb9W+JsZmAPIzswcp2oo6EYngsUE40V7A==
X-Received: by 2002:ae9:c119:: with SMTP id z25mr4496307qki.201.1631218410223;
        Thu, 09 Sep 2021 13:13:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id l13sm2104020qkp.97.2021.09.09.13.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:13:29 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 03/14] NFS: Remove the nfs4_label from the nfs4_create_res struct
Date:   Thu,  9 Sep 2021 16:13:16 -0400
Message-Id: <20210909201327.108759-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210909201327.108759-1-Anna.Schumaker@Netapp.com>
References: <20210909201327.108759-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Instead, use the label embedded in the attached fattr.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs4proc.c       | 12 +++++-------
 fs/nfs/nfs4xdr.c        |  2 +-
 include/linux/nfs_xdr.h |  1 -
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e1214bb6b7ee..06569a35a6df 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4851,7 +4851,6 @@ struct nfs4_createdata {
 	struct nfs4_create_res res;
 	struct nfs_fh fh;
 	struct nfs_fattr fattr;
-	struct nfs4_label *label;
 };
 
 static struct nfs4_createdata *nfs4_alloc_createdata(struct inode *dir,
@@ -4863,8 +4862,8 @@ static struct nfs4_createdata *nfs4_alloc_createdata(struct inode *dir,
 	if (data != NULL) {
 		struct nfs_server *server = NFS_SERVER(dir);
 
-		data->label = nfs4_label_alloc(server, GFP_KERNEL);
-		if (IS_ERR(data->label))
+		data->fattr.label = nfs4_label_alloc(server, GFP_KERNEL);
+		if (IS_ERR(data->fattr.label))
 			goto out_free;
 
 		data->msg.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_CREATE];
@@ -4875,12 +4874,11 @@ static struct nfs4_createdata *nfs4_alloc_createdata(struct inode *dir,
 		data->arg.name = name;
 		data->arg.attrs = sattr;
 		data->arg.ftype = ftype;
-		data->arg.bitmask = nfs4_bitmask(server, data->label);
+		data->arg.bitmask = nfs4_bitmask(server, data->fattr.label);
 		data->arg.umask = current_umask();
 		data->res.server = server;
 		data->res.fh = &data->fh;
 		data->res.fattr = &data->fattr;
-		data->res.label = data->label;
 		nfs_fattr_init(data->res.fattr);
 	}
 	return data;
@@ -4902,14 +4900,14 @@ static int nfs4_do_create(struct inode *dir, struct dentry *dentry, struct nfs4_
 					      data->res.fattr->time_start,
 					      NFS_INO_INVALID_DATA);
 		spin_unlock(&dir->i_lock);
-		status = nfs_instantiate(dentry, data->res.fh, data->res.fattr, data->res.label);
+		status = nfs_instantiate(dentry, data->res.fh, data->res.fattr, data->res.fattr->label);
 	}
 	return status;
 }
 
 static void nfs4_free_createdata(struct nfs4_createdata *data)
 {
-	nfs4_label_free(data->label);
+	nfs4_label_free(data->fattr.label);
 	kfree(data);
 }
 
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 466b2832de75..98594a97529d 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -6361,7 +6361,7 @@ static int nfs4_xdr_dec_create(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 	status = decode_getfh(xdr, res->fh);
 	if (status)
 		goto out;
-	decode_getfattr_label(xdr, res->fattr, res->label, res->server);
+	decode_getfattr_label(xdr, res->fattr, res->fattr->label, res->server);
 out:
 	return status;
 }
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 9960f6628066..5aba81b74c98 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1040,7 +1040,6 @@ struct nfs4_create_res {
 	const struct nfs_server *	server;
 	struct nfs_fh *			fh;
 	struct nfs_fattr *		fattr;
-	struct nfs4_label		*label;
 	struct nfs4_change_info		dir_cinfo;
 };
 
-- 
2.33.0

