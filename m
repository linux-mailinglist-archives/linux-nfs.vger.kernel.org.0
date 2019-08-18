Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44F9D918C6
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Aug 2019 20:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfHRSV3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Aug 2019 14:21:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36878 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfHRSV3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Aug 2019 14:21:29 -0400
Received: by mail-io1-f65.google.com with SMTP id q22so16090949iog.4
        for <linux-nfs@vger.kernel.org>; Sun, 18 Aug 2019 11:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zMTL8eAE2fsV+kXbzBynz4mEZYtb9N7gNpsezC7pvlc=;
        b=cKizCAURtG5hn3qAHtTnYaDo1/b3xUeBihaiLsb44RpVmNIcOq7V+Kt+u4WSqwtJrn
         V6ZbRI3EbYYNtWQ54mXzr20QXY9Q/A3QP/Z+6PL+MWeso32/NMHzjh0L3b89g9jPmx0s
         TuAskEzKnr4X0GdRHdrBrpDiADP/heEi1UQGaUqBBSchilfe2RkTIlmnYklxpnBYIMC9
         5ZagAZ8w/QSWBruIIPVRDVgqZsYIYSfJLZF00EiGwx2o2fxV3l+wms9jUP9o9dc3BJRJ
         SkImkmnrAwuNGjwUTh9jHMZCcsjZwXEL8YDv/l4cDDeSZDI2XtnR3f/5hAKKlBAVFXvR
         QTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zMTL8eAE2fsV+kXbzBynz4mEZYtb9N7gNpsezC7pvlc=;
        b=j7sW+q6nscrIvLjmJ6IibOV31HYo5AJWQvs+XCYlE7q3K0n7x6fxrrxX5Xfsv3wcns
         zU8SxDU/lHmArRxAZqXRDxBQAUtIo5yugri0/B46R5RHkYW95nNxtpSgcT/v6Bo2udsi
         JwWZbTECuKRghPk51SopiofKOcTfxHOk5/zxeLmHBQhiw8Yfbh3Xe8RksPxfmOrsyndq
         TNFGPakbHbzuYfrak99bvF0RJU1Dyq/bI6GZN8pz+Cd8VdxuHgls4kaiSxTEEP0s724d
         YqHgy7eYVt/VMIxd11rtCJhlXeMnPS+QdkDHRGp319zAqSv20ntfvwK1yKX7oyVUimDd
         VC7w==
X-Gm-Message-State: APjAAAWuVNsD3Dt5oAXvvsJz1VYbsUr9CDBIgXDfr4QO+ywSD4tgTeaA
        Bzd1IRx5IoQWMh2CQZ59iVBR0vg=
X-Google-Smtp-Source: APXvYqyJLkyQlIpgBA/qIUsG2dYMLooMrRZU+dIoUpZhENYCNRFJJYa2TFzNSs2MVKHqbiRJooxGCA==
X-Received: by 2002:a6b:dd18:: with SMTP id f24mr9913136ioc.97.1566152488206;
        Sun, 18 Aug 2019 11:21:28 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id n22sm10317844iob.37.2019.08.18.11.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:21:27 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 14/16] nfsd: close cached files prior to a REMOVE or RENAME that would replace target
Date:   Sun, 18 Aug 2019 14:18:57 -0400
Message-Id: <20190818181859.8458-15-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818181859.8458-14-trond.myklebust@hammerspace.com>
References: <20190818181859.8458-1-trond.myklebust@hammerspace.com>
 <20190818181859.8458-2-trond.myklebust@hammerspace.com>
 <20190818181859.8458-3-trond.myklebust@hammerspace.com>
 <20190818181859.8458-4-trond.myklebust@hammerspace.com>
 <20190818181859.8458-5-trond.myklebust@hammerspace.com>
 <20190818181859.8458-6-trond.myklebust@hammerspace.com>
 <20190818181859.8458-7-trond.myklebust@hammerspace.com>
 <20190818181859.8458-8-trond.myklebust@hammerspace.com>
 <20190818181859.8458-9-trond.myklebust@hammerspace.com>
 <20190818181859.8458-10-trond.myklebust@hammerspace.com>
 <20190818181859.8458-11-trond.myklebust@hammerspace.com>
 <20190818181859.8458-12-trond.myklebust@hammerspace.com>
 <20190818181859.8458-13-trond.myklebust@hammerspace.com>
 <20190818181859.8458-14-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

It's not uncommon for some workloads to do a bunch of I/O to a file and
delete it just afterward. If knfsd has a cached open file however, then
the file may still be open when the dentry is unlinked. If the
underlying filesystem is nfs, then that could trigger it to do a
sillyrename.

On a REMOVE or RENAME scan the nfsd_file cache for open files that
correspond to the inode, and proactively unhash and put their
references. This should prevent any delete-on-last-close activity from
occurring, solely due to knfsd's open file cache.

This must be done synchronously though so we use the variants that call
flush_delayed_fput. There are deadlock possibilities if you call
flush_delayed_fput while holding locks, however. In the case of
nfsd_rename, we don't even do the lookups of the dentries to be renamed
until we've locked for rename.

Once we've figured out what the target dentry is for a rename, check to
see whether there are cached open files associated with it. If there
are, then unwind all of the locking, close them all, and then reattempt
the rename.

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/vfs.c | 62 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 8e2c8f36eba3..84e87772c2b8 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1590,6 +1590,26 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	goto out_unlock;
 }
 
+static void
+nfsd_close_cached_files(struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+
+	if (inode && S_ISREG(inode->i_mode))
+		nfsd_file_close_inode_sync(inode);
+}
+
+static bool
+nfsd_has_cached_files(struct dentry *dentry)
+{
+	bool		ret = false;
+	struct inode *inode = d_inode(dentry);
+
+	if (inode && S_ISREG(inode->i_mode))
+		ret = nfsd_file_is_cached(inode);
+	return ret;
+}
+
 /*
  * Rename a file
  * N.B. After this call _both_ ffhp and tfhp need an fh_put
@@ -1602,6 +1622,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	struct inode	*fdir, *tdir;
 	__be32		err;
 	int		host_err;
+	bool		has_cached = false;
 
 	err = fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_REMOVE);
 	if (err)
@@ -1620,6 +1641,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
 		goto out;
 
+retry:
 	host_err = fh_want_write(ffhp);
 	if (host_err) {
 		err = nfserrno(host_err);
@@ -1659,11 +1681,16 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
 		goto out_dput_new;
 
-	host_err = vfs_rename(fdir, odentry, tdir, ndentry, NULL, 0);
-	if (!host_err) {
-		host_err = commit_metadata(tfhp);
-		if (!host_err)
-			host_err = commit_metadata(ffhp);
+	if (nfsd_has_cached_files(ndentry)) {
+		has_cached = true;
+		goto out_dput_old;
+	} else {
+		host_err = vfs_rename(fdir, odentry, tdir, ndentry, NULL, 0);
+		if (!host_err) {
+			host_err = commit_metadata(tfhp);
+			if (!host_err)
+				host_err = commit_metadata(ffhp);
+		}
 	}
  out_dput_new:
 	dput(ndentry);
@@ -1676,12 +1703,26 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	 * as that would do the wrong thing if the two directories
 	 * were the same, so again we do it by hand.
 	 */
-	fill_post_wcc(ffhp);
-	fill_post_wcc(tfhp);
+	if (!has_cached) {
+		fill_post_wcc(ffhp);
+		fill_post_wcc(tfhp);
+	}
 	unlock_rename(tdentry, fdentry);
 	ffhp->fh_locked = tfhp->fh_locked = false;
 	fh_drop_write(ffhp);
 
+	/*
+	 * If the target dentry has cached open files, then we need to try to
+	 * close them prior to doing the rename. Flushing delayed fput
+	 * shouldn't be done with locks held however, so we delay it until this
+	 * point and then reattempt the whole shebang.
+	 */
+	if (has_cached) {
+		has_cached = false;
+		nfsd_close_cached_files(ndentry);
+		dput(ndentry);
+		goto retry;
+	}
 out:
 	return err;
 }
@@ -1728,10 +1769,13 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	if (!type)
 		type = d_inode(rdentry)->i_mode & S_IFMT;
 
-	if (type != S_IFDIR)
+	if (type != S_IFDIR) {
+		nfsd_close_cached_files(rdentry);
 		host_err = vfs_unlink(dirp, rdentry, NULL);
-	else
+	} else {
 		host_err = vfs_rmdir(dirp, rdentry);
+	}
+
 	if (!host_err)
 		host_err = commit_metadata(fhp);
 	dput(rdentry);
-- 
2.21.0

