Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC68405DE6
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Sep 2021 22:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245698AbhIIUOq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Sep 2021 16:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237322AbhIIUOo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Sep 2021 16:14:44 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C092AC061764
        for <linux-nfs@vger.kernel.org>; Thu,  9 Sep 2021 13:13:33 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id f22so3257348qkm.5
        for <linux-nfs@vger.kernel.org>; Thu, 09 Sep 2021 13:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jx8gVbZsneDu58BoN510yrdkttFG79ZqVJ/+xfrcCwY=;
        b=HgwnPXB5pAwt01IGL6p6pt/c7/UnTfGPYvCmwOiggTPRU1Y7zleSMCAMED13X3z6Zn
         j+0cM5Cu5j9uDR8MAc146kYIdMjN4gYvrX834bm00+W2sPWdS+q0Icr2fz3UJwzPjGUU
         n/CvIQQhywnpiboGtLtbVR/vVxWfNsXd8PxSQvD01wb/JfWgk7GSugNlaBpxogdoJqVu
         WQMEJquFvbLHjnqZXu+5FEbUz70/mjIruc+k5Hctl4RLFykrUs9QhsOUfTFB2RYUiilD
         3D6mfE+Opws/djqxLbtoIxnL4PNOfGLuXXXmNwSo3cKiwHWo3RPprhRJyR/MkcHJwDiK
         NhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Jx8gVbZsneDu58BoN510yrdkttFG79ZqVJ/+xfrcCwY=;
        b=2svtQc4gFWChTNZBTP68qj/Z1/mRrd54NuqbAQpsT+7m43BojAUWHq31y3Y8AWDEYx
         UHGiUrDNbp5sXrLzT7m0wH00FYpNiyA3vhtCIODwr8RPd1ePRRFKz0mOQ8LVjXG7ZGjv
         XTsddzIJazoN9z50kysqQv+NIUQTrnYsR/xATFSHSW6mkZtZeAC584SUGcEuetET/ksF
         iPkWClT58WgYmlCikk4glDalQqWMwygFv3VNlMwVL8Fgw6pvvGRGTcwq3eMWwnpamnrG
         uRzNy0Sv9uWsJ/HWG4C9Phk2fw0rOJVBQfRsQJf8biBq0XL0/OXS2AxZIskvCKxKNCNv
         tNPw==
X-Gm-Message-State: AOAM5314C79kpHICmvRPh8CuzDt56tMgC2p473kbYoC65U+36W8NRaVh
        UzgfVqQtV3Bqt0Mozpm7m8V3Jt44Ib8=
X-Google-Smtp-Source: ABdhPJxinoHsRU3YVzpCmxmqxseeFGVcjGFP05I7zm2zQQSORo6vrPa2xpFsvZtmJtz7Sg50OUaN6g==
X-Received: by 2002:a05:620a:1f1:: with SMTP id x17mr4566685qkn.227.1631218412881;
        Thu, 09 Sep 2021 13:13:32 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id l13sm2104020qkp.97.2021.09.09.13.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:13:32 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 07/14] NFS: Remove the f_label from the nfs4_opendata and nfs_openres
Date:   Thu,  9 Sep 2021 16:13:20 -0400
Message-Id: <20210909201327.108759-8-Anna.Schumaker@Netapp.com>
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
 fs/nfs/nfs4_fs.h        |  1 -
 fs/nfs/nfs4proc.c       | 35 +++++++++++------------------------
 fs/nfs/nfs4xdr.c        |  2 +-
 include/linux/nfs_xdr.h |  1 -
 4 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index ba78df4b13d9..b621e29e6187 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -234,7 +234,6 @@ struct nfs4_opendata {
 	struct nfs4_string group_name;
 	struct nfs4_label *a_label;
 	struct nfs_fattr f_attr;
-	struct nfs4_label *f_label;
 	struct dentry *dir;
 	struct dentry *dentry;
 	struct nfs4_state_owner *owner;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 7e02c698c60f..51b86de47b60 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1329,7 +1329,6 @@ nfs4_map_atomic_open_claim(struct nfs_server *server,
 static void nfs4_init_opendata_res(struct nfs4_opendata *p)
 {
 	p->o_res.f_attr = &p->f_attr;
-	p->o_res.f_label = p->f_label;
 	p->o_res.seqid = p->o_arg.seqid;
 	p->c_res.seqid = p->c_arg.seqid;
 	p->o_res.server = p->o_arg.server;
@@ -1355,8 +1354,8 @@ static struct nfs4_opendata *nfs4_opendata_alloc(struct dentry *dentry,
 	if (p == NULL)
 		goto err;
 
-	p->f_label = nfs4_label_alloc(server, gfp_mask);
-	if (IS_ERR(p->f_label))
+	p->f_attr.label = nfs4_label_alloc(server, gfp_mask);
+	if (IS_ERR(p->f_attr.label))
 		goto err_free_p;
 
 	p->a_label = nfs4_label_alloc(server, gfp_mask);
@@ -1439,7 +1438,7 @@ static struct nfs4_opendata *nfs4_opendata_alloc(struct dentry *dentry,
 err_free_label:
 	nfs4_label_free(p->a_label);
 err_free_f:
-	nfs4_label_free(p->f_label);
+	nfs4_label_free(p->f_attr.label);
 err_free_p:
 	kfree(p);
 err:
@@ -1461,7 +1460,7 @@ static void nfs4_opendata_free(struct kref *kref)
 	nfs4_put_state_owner(p->owner);
 
 	nfs4_label_free(p->a_label);
-	nfs4_label_free(p->f_label);
+	nfs4_label_free(p->f_attr.label);
 
 	dput(p->dir);
 	dput(p->dentry);
@@ -2013,7 +2012,7 @@ nfs4_opendata_get_inode(struct nfs4_opendata *data)
 		if (!(data->f_attr.valid & NFS_ATTR_FATTR))
 			return ERR_PTR(-EAGAIN);
 		inode = nfs_fhget(data->dir->d_sb, &data->o_res.fh,
-				&data->f_attr, data->f_label);
+				&data->f_attr, data->f_attr.label);
 		break;
 	default:
 		inode = d_inode(data->dentry);
@@ -2709,7 +2708,7 @@ static int _nfs4_proc_open(struct nfs4_opendata *data,
 	if (!(o_res->f_attr->valid & NFS_ATTR_FATTR)) {
 		nfs4_sequence_free_slot(&o_res->seq_res);
 		nfs4_proc_getattr(server, &o_res->fh, o_res->f_attr,
-				o_res->f_label, NULL);
+				o_res->f_attr->label, NULL);
 	}
 	return 0;
 }
@@ -3125,7 +3124,6 @@ static int _nfs4_do_open(struct inode *dir,
 	enum open_claim_type4 claim = NFS4_OPEN_CLAIM_NULL;
 	struct iattr *sattr = c->sattr;
 	struct nfs4_label *label = c->label;
-	struct nfs4_label *olabel = NULL;
 	int status;
 
 	/* Protect against reboot recovery conflicts */
@@ -3148,19 +3146,11 @@ static int _nfs4_do_open(struct inode *dir,
 	if (opendata == NULL)
 		goto err_put_state_owner;
 
-	if (label) {
-		olabel = nfs4_label_alloc(server, GFP_KERNEL);
-		if (IS_ERR(olabel)) {
-			status = PTR_ERR(olabel);
-			goto err_opendata_put;
-		}
-	}
-
 	if (server->attr_bitmask[2] & FATTR4_WORD2_MDSTHRESHOLD) {
 		if (!opendata->f_attr.mdsthreshold) {
 			opendata->f_attr.mdsthreshold = pnfs_mdsthreshold_alloc();
 			if (!opendata->f_attr.mdsthreshold)
-				goto err_free_label;
+				goto err_opendata_put;
 		}
 		opendata->o_arg.open_bitmap = &nfs4_pnfs_open_bitmap[0];
 	}
@@ -3169,7 +3159,7 @@ static int _nfs4_do_open(struct inode *dir,
 
 	status = _nfs4_open_and_get_state(opendata, flags, ctx);
 	if (status != 0)
-		goto err_free_label;
+		goto err_opendata_put;
 	state = ctx->state;
 
 	if ((opendata->o_arg.open_flags & (O_CREAT|O_EXCL)) == (O_CREAT|O_EXCL) &&
@@ -3186,11 +3176,12 @@ static int _nfs4_do_open(struct inode *dir,
 			nfs_fattr_init(opendata->o_res.f_attr);
 			status = nfs4_do_setattr(state->inode, cred,
 					opendata->o_res.f_attr, sattr,
-					ctx, label, olabel);
+					ctx, label, opendata->o_res.f_attr->label);
 			if (status == 0) {
 				nfs_setattr_update_inode(state->inode, sattr,
 						opendata->o_res.f_attr);
-				nfs_setsecurity(state->inode, opendata->o_res.f_attr, olabel);
+				nfs_setsecurity(state->inode, opendata->o_res.f_attr,
+						opendata->o_res.f_attr->label);
 			}
 			sattr->ia_valid = ia_old;
 		}
@@ -3203,13 +3194,9 @@ static int _nfs4_do_open(struct inode *dir,
 		opendata->f_attr.mdsthreshold = NULL;
 	}
 
-	nfs4_label_free(olabel);
-
 	nfs4_opendata_put(opendata);
 	nfs4_put_state_owner(sp);
 	return 0;
-err_free_label:
-	nfs4_label_free(olabel);
 err_opendata_put:
 	nfs4_opendata_put(opendata);
 err_put_state_owner:
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 77467216cd5d..8d9d4df75f88 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -6532,7 +6532,7 @@ static int nfs4_xdr_dec_open(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 		goto out;
 	if (res->access_request)
 		decode_access(xdr, &res->access_supported, &res->access_result);
-	decode_getfattr_label(xdr, res->f_attr, res->f_label, res->server);
+	decode_getfattr_label(xdr, res->f_attr, res->f_attr->label, res->server);
 	if (res->lg_res)
 		decode_layoutget(xdr, rqstp, res->lg_res);
 out:
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index f0a685d9b8bd..cb28e01ea41e 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -488,7 +488,6 @@ struct nfs_openres {
 	struct nfs4_change_info	cinfo;
 	__u32                   rflags;
 	struct nfs_fattr *      f_attr;
-	struct nfs4_label	*f_label;
 	struct nfs_seqid *	seqid;
 	const struct nfs_server *server;
 	fmode_t			delegation_type;
-- 
2.33.0

