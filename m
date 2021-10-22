Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0704437B8C
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 19:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbhJVRNq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 13:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbhJVRNe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 13:13:34 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0111EC061764
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:17 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a13so5141410qkg.11
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u0LCQ2Q01yFPOa55Zc528lPs7tc3fuvW5Z082KuZArM=;
        b=R5L2y2Jw9ZjUM4vNIcylyvs8OJvn0hIGBDEBjRb528FjV7rpRJ4iyhnwg71EDWCHjc
         k1uAWI1hDEtiUYfRdU24J5UU0sjNQVejT7iCLBW9X8f6h5N7op897u2BQxTnNKAowMe+
         vVRd67vd3Fe7vwz7iZreYs1l46JIh9EnMCKmgT66xk0w7pUtIVHT6CT/SfRsA8IrVTCe
         0Hz9ZdXGcTX2KIo6XEc0LX9Bt+y3MRaTsJUUo3zPxUedUBlQQqhzmVkTJRWI8QXymETU
         Q1qvXFXE2RIQul9FIyNxgZKToihi//Gf6CvXvfmzNULc41KRLJCoWC9L2XufOO4L9tSw
         MjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=u0LCQ2Q01yFPOa55Zc528lPs7tc3fuvW5Z082KuZArM=;
        b=yfLOHs0XcIQDXM/vDeBZ/ih/wATckSn9tKoFZq5xhsNTjbEpwdxqAg34DOU+TUMQfK
         l1kMhmGNrzULXooXvSUc0ImmsBfGBSZ/qHeUYVPwS7ZQAgJ+aUKf16ErRnq4v58rmx/e
         IdwnzjB77s75NML6uO+hOxujroIPMs/C/xSApXc+nVy1Jcoa07nzz3bO2ScANlnHIU/5
         Bp0h10A4JfUDiIZAcVn9nYneCst0wETYN6uKMUkKGIZ/c/Otic9gwqKiW9yPXDMCLr09
         dohqkd/8e8GJfMx4JT4NqngTvFUYtot4OeA7sue3spl065BXm0oHXSnvA1cygx9YSSpx
         h/Xw==
X-Gm-Message-State: AOAM531Y/kZD80J68SNjI5Wq6IQ3APqosKisl4SNxp+BXEw/SmODKG2W
        CmIFFRvy+SHLbNj39NB/gk4=
X-Google-Smtp-Source: ABdhPJzZtT67cWAQY0IjHaz6f3S27nZvt50/a61FTbk01vnGEejnpF8yvICwEsWxZblLLoeFsM95pw==
X-Received: by 2002:a05:620a:25c9:: with SMTP id y9mr1101721qko.386.1634922676088;
        Fri, 22 Oct 2021 10:11:16 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id s22sm4484586qko.135.2021.10.22.10.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 10:11:15 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 03/14] NFS: Remove the nfs4_label from the nfs4_create_res struct
Date:   Fri, 22 Oct 2021 13:11:02 -0400
Message-Id: <20211022171113.16739-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022171113.16739-1-Anna.Schumaker@Netapp.com>
References: <20211022171113.16739-1-Anna.Schumaker@Netapp.com>
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
2.33.1

