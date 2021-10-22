Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62732437B97
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 19:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhJVRNx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 13:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbhJVRNj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 13:13:39 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A140C061764
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:22 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id g14so2873804qvb.0
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YuzYjtQAFGzwVEdsHhO++OF84ogE/XJ6iYl+L5z2zMM=;
        b=audN897xzvqHGjBgJ3SmTH3Sobw0o2LrWBnb0IAvipAeDw8Anwh2JfoCuBDs6Zgflj
         aR/3USDWg4ZCxZaE7o14ILDoMVWyrIpd5YiUV6c45B4Eu5frT/iqjllJp/Yvq5dKyJbM
         We3Sl56+aJ12VnTEhL/C4/6gG1PFluN5OW7pN0TsJzk9cp2uExEk9abQxMG2cKY5vo5k
         Z06fbSi1TpBUwui4dTMFDT114bscpuXUix44ryGxnQoC23+FuOQXrAZPiS82qpp8Wabt
         AhjCwwvvYC204Q8I61WI7JiMfDkF2R3ZKYA+9CDRnD9LXfAUp1RyBM9/7D3zgaYhDicD
         RVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=YuzYjtQAFGzwVEdsHhO++OF84ogE/XJ6iYl+L5z2zMM=;
        b=GKopcPJA3q/+lBI/VWQESjjAZDf5GIWhFk5OXOwGeu9EA5dNQfTl9GeTBRXJsT58dr
         gUutzZrwhzmc5TkcKdWFErXS5cffryJ4lu6BrIPd7b54ncG2IxO/bo86b8gLAxIRRkUe
         n0P7AWU2Dpoo++Yead7En0tY80wINPImmcu0gtrmTgE2/ZNKr+e1FXvncfy1zrz22y3s
         ZaXXwwugSkshhsM+4+rX6nH4Fvkybuqs+GETQoTMleUj6DrPqK21bNJXqPf608IoQYbc
         1junxZdx3RpWI38S7jPajKfoq4nbYpSu1og4mrAX9ns6N3SnjlDt8eYlBDI2PJavuuBp
         qUQg==
X-Gm-Message-State: AOAM533aoe2FWmehCXFh5RRTljD2iPbfprXASN0SGl4F5igA4ikq9LXc
        pOwfqtB2TZvwrKLglzGksXA=
X-Google-Smtp-Source: ABdhPJyelD35nLAIhydg4yVDSJE88/uKtgRQ2TLPJ2rbR6hWo8ODQGvg5/S7xiY+7l26anREvqRMuA==
X-Received: by 2002:a05:6214:c2f:: with SMTP id a15mr1305538qvd.14.1634922681279;
        Fri, 22 Oct 2021 10:11:21 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id s22sm4484586qko.135.2021.10.22.10.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 10:11:21 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 11/14] NFS: Remove the nfs4_label argument from nfs_add_or_obtain()
Date:   Fri, 22 Oct 2021 13:11:10 -0400
Message-Id: <20211022171113.16739-12-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022171113.16739-1-Anna.Schumaker@Netapp.com>
References: <20211022171113.16739-1-Anna.Schumaker@Netapp.com>
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
index 7bae21a2ba05..7100514d306b 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -321,7 +321,7 @@ nfs3_do_create(struct inode *dir, struct dentry *dentry, struct nfs3_createdata
 	if (status != 0)
 		return ERR_PTR(status);
 
-	return nfs_add_or_obtain(dentry, data->res.fh, data->res.fattr, NULL);
+	return nfs_add_or_obtain(dentry, data->res.fh, data->res.fattr);
 }
 
 static void nfs3_free_createdata(struct nfs3_createdata *data)
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 052f9c367d17..4566c2692cdd 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -524,8 +524,7 @@ extern void nfs_set_verifier(struct dentry * dentry, unsigned long verf);
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
2.33.1

