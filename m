Return-Path: <linux-nfs+bounces-9184-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AC5A0C4AF
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 23:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A88E3A2662
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 22:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8872D1D63ED;
	Mon, 13 Jan 2025 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZ9jI++a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E231EBA0C
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736807345; cv=none; b=hhwYij4Ptr4EVrjDQyToLISYfQiWBj4A1iC+fNbO0C01jM9N+O21FW+wOnuKpFkWyKS0NwKCfaidgm1MwfUE/3nMOjYeWn7H7jnCXWjzbcLVBNkfOilHEkz92tKSBR4pfNGM/NC5nUoYkxCeq32iQYhQOKIJquuACC5CYC80nB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736807345; c=relaxed/simple;
	bh=pSbzkUg29H6W/YUsUBHHzl5j989sZXQQ9e80fNfc4A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRdpC2ivZbySoS3Aw1z17epP+FqHLXlV6CZUOCNLhNnorvJLDKp7/zNtzCa2jGCBQ1mYL7dgMKJzvu84UWpYzXcuoSlEPXcCxYPwsfRyRiQGfRO6+srynXR/tNtsI6UymtZFAcK1d0SNKmL5I2Y1uABsVPBgObcaqUZUQYlEOMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZ9jI++a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A56C4CED6;
	Mon, 13 Jan 2025 22:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736807345;
	bh=pSbzkUg29H6W/YUsUBHHzl5j989sZXQQ9e80fNfc4A4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UZ9jI++axSG4zw6wZ2itqklTnCmbcu2gMljVJnOcemy7NxcwJrK66vaPlxMfXEjQ5
	 DnFXdtBNkMGoX83JocRTP7IFrO37t1C9Vx9DDXflBrxgSA4uGv/F/Q3flVxMOEs2Hg
	 Y2Wcvi5XCbcEy962V6UW2QNmVxP2mjvbLX1dcMuZAszyuQcaWEaePvloE9b9FD/BRu
	 5d7KqaE3zVHpgL/rt2AWPPaV6QLwTGcoWwLk0kzt6+/cImFDEAlD/5AXQK+NNJxBxD
	 +R1VivfO79t3kueeBHjVDVL15Sq0s/V864XvrOcBjahJQVZAALUMEH64x6Tdo61I5N
	 2v3BoJs4OV+1A==
Date: Mon, 13 Jan 2025 17:29:03 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfs: fix incorrect error handling in LOCALIO (was: Re:
 [for-6.13 PATCH v3 00/14] nfs/nfsd: improvements for LOCALIO)
Message-ID: <Z4WTr7zTC2eZGldp@kernel.org>
References: <20241116014106.25456-1-snitzer@kernel.org>
 <754757a44ac96f894c82338ec3212cf7202d540a.camel@kernel.org>
 <Z0E-e7p5FtWWVKeV@kernel.org>
 <Z2MG3X_PpbJRNzCw@kernel.org>
 <f0d7f601-a6ac-40d6-9665-e9a40e2dc00c@oracle.com>
 <23bc5e70-9d7a-4185-9645-0ba89cd43de0@oracle.com>
 <Z2M8blaSYonRmDYT@kernel.org>
 <Z36iY7nJT5ngLddS@kernel.org>
 <622e4634-e7d3-4f8d-af45-7178a4e6675d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <622e4634-e7d3-4f8d-af45-7178a4e6675d@oracle.com>

On Wed, Jan 08, 2025 at 03:56:27PM -0500, Anna Schumaker wrote:
> Hi Mike,
> 
> On 1/8/25 11:05 AM, Mike Snitzer wrote:
> > [top-posting because of my general inquiry]
> > 
> > Hi Anna,
> > 
> > I know Trond has been quite busy, I suspect you have been too
> > (holidays and all too).  I just wanted to check with you on this
> > patchset.
> > 
> > Given the 6.14 merge window is fast approaching, is there anything you
> > need from me?
> > 
> > Jeff did provide his Reviewed-by, and Chuck his Acked-by.  But would
> > it help for me to prepare a v4 that explicitly adds their tags
> > accordingly?
> 
> Thanks for checking in! I don't think I need anything from you at
> this time. I just pushed out a linux-next branch including these
> patches and your additional bugfix from the other week, so everything
> should be covered. If you notice anything missing, do let me know!

Thanks!  And of course I sent my previous mail _just_ before you
pushed your linux-next changes out. ;)

I do have the following v2 for the LOCALIO bugfix, commit 17da35c54142
("nfs: fix incorrect error handling in LOCALIO") in your linux-next
tree.  Once you've had a chance to look, would it be possible for you
to replace the original fix and forcibly rebase with this v2 instead?

Trond reviewed the first patch and noted that for LOCALIO's purposes
it results in some bad conversions from errno to NFSv4 status
(e.g. -EAGAIN to NFS4ERR_LOCKED and -ENODATA to NFS4ERR_NOXATTR).  I
cross-referenced the long-standing code that Hammerspace used for this
and this v2 reflects the errno to NFS v4 status mappings LOCALIO
needs:


From: Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2] nfs: fix incorrect error handling in LOCALIO

nfs4_stat_to_errno() expects a NFSv4 error code as an argument and
returns a POSIX errno.

The problem is LOCALIO is passing nfs4_stat_to_errno() the POSIX errno
return values from filp->f_op->read_iter(), filp->f_op->write_iter()
and vfs_fsync_range().

So the POSIX errno that nfs_local_pgio_done() and
nfs_local_commit_done() are passing to nfs4_stat_to_errno() are
failing to match any NFSv4 error code, which results in
nfs4_stat_to_errno() defaulting to returning -EREMOTEIO. This causes
assertions in upper layers due to -EREMOTEIO not being a valid NFSv4
error code.

Fix this by updating nfs_local_pgio_done() and nfs_local_commit_done()
to use the new nfs_localio_errno_to_nfs4_stat() to map a POSIX errno
to an NFSv4 error code.

Care was taken to factor out nfs4_errtbl_common[] to avoid duplicating
the same NFS error to errno table. nfs4_errtbl_common[] is checked
first by both nfs4_stat_to_errno and nfs_localio_errno_to_nfs4_stat
before they check their own more specialized tables (nfs4_errtbl[] and
nfs4_errtbl_localio[] respectively).

While auditing the associated error mapping tables, the (ab)use of -1
for the last table entry was removed in favor of using ARRAY_SIZE to
iterate the nfs_errtbl[] and nfs4_errtbl[]. And 'errno_NFSERR_IO' was
removed because it caused needless obfuscation.

Fixes: 70ba381e1a431 ("nfs: add LOCALIO support")
Reported-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c           |  4 +-
 fs/nfs_common/common.c     | 89 +++++++++++++++++++++++++++++++++-----
 include/linux/nfs_common.h |  3 +-
 3 files changed, 82 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 1eee5aac2884..5c21caeae075 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -388,7 +388,7 @@ nfs_local_pgio_done(struct nfs_pgio_header *hdr, long status)
 		hdr->res.op_status = NFS4_OK;
 		hdr->task.tk_status = 0;
 	} else {
-		hdr->res.op_status = nfs4_stat_to_errno(status);
+		hdr->res.op_status = nfs_localio_errno_to_nfs4_stat(status);
 		hdr->task.tk_status = status;
 	}
 }
@@ -786,7 +786,7 @@ nfs_local_commit_done(struct nfs_commit_data *data, int status)
 		data->task.tk_status = 0;
 	} else {
 		nfs_reset_boot_verifier(data->inode);
-		data->res.op_status = nfs4_stat_to_errno(status);
+		data->res.op_status = nfs_localio_errno_to_nfs4_stat(status);
 		data->task.tk_status = status;
 	}
 }
diff --git a/fs/nfs_common/common.c b/fs/nfs_common/common.c
index 34a115176f97..af09aed09fd2 100644
--- a/fs/nfs_common/common.c
+++ b/fs/nfs_common/common.c
@@ -15,7 +15,7 @@ static const struct {
 	{ NFS_OK,		0		},
 	{ NFSERR_PERM,		-EPERM		},
 	{ NFSERR_NOENT,		-ENOENT		},
-	{ NFSERR_IO,		-errno_NFSERR_IO},
+	{ NFSERR_IO,		-EIO		},
 	{ NFSERR_NXIO,		-ENXIO		},
 /*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
 	{ NFSERR_ACCES,		-EACCES		},
@@ -45,7 +45,6 @@ static const struct {
 	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
 	{ NFSERR_BADTYPE,	-EBADTYPE	},
 	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
-	{ -1,			-EIO		}
 };
 
 /**
@@ -59,26 +58,29 @@ int nfs_stat_to_errno(enum nfs_stat status)
 {
 	int i;
 
-	for (i = 0; nfs_errtbl[i].stat != -1; i++) {
+	for (i = 0; i < ARRAY_SIZE(nfs_errtbl); i++) {
 		if (nfs_errtbl[i].stat == (int)status)
 			return nfs_errtbl[i].errno;
 	}
-	return nfs_errtbl[i].errno;
+	return -EIO;
 }
 EXPORT_SYMBOL_GPL(nfs_stat_to_errno);
 
 /*
  * We need to translate between nfs v4 status return values and
  * the local errno values which may not be the same.
+ *
+ * nfs4_errtbl_common[] is used before more specialized mappings
+ * available in nfs4_errtbl[] or nfs4_errtbl_localio[].
  */
 static const struct {
 	int stat;
 	int errno;
-} nfs4_errtbl[] = {
+} nfs4_errtbl_common[] = {
 	{ NFS4_OK,		0		},
 	{ NFS4ERR_PERM,		-EPERM		},
 	{ NFS4ERR_NOENT,	-ENOENT		},
-	{ NFS4ERR_IO,		-errno_NFSERR_IO},
+	{ NFS4ERR_IO,		-EIO		},
 	{ NFS4ERR_NXIO,		-ENXIO		},
 	{ NFS4ERR_ACCESS,	-EACCES		},
 	{ NFS4ERR_EXIST,	-EEXIST		},
@@ -98,15 +100,20 @@ static const struct {
 	{ NFS4ERR_BAD_COOKIE,	-EBADCOOKIE	},
 	{ NFS4ERR_NOTSUPP,	-ENOTSUPP	},
 	{ NFS4ERR_TOOSMALL,	-ETOOSMALL	},
-	{ NFS4ERR_SERVERFAULT,	-EREMOTEIO	},
 	{ NFS4ERR_BADTYPE,	-EBADTYPE	},
-	{ NFS4ERR_LOCKED,	-EAGAIN		},
 	{ NFS4ERR_SYMLINK,	-ELOOP		},
-	{ NFS4ERR_OP_ILLEGAL,	-EOPNOTSUPP	},
 	{ NFS4ERR_DEADLOCK,	-EDEADLK	},
+};
+
+static const struct {
+	int stat;
+	int errno;
+} nfs4_errtbl[] = {
+	{ NFS4ERR_SERVERFAULT,	-EREMOTEIO	},
+	{ NFS4ERR_LOCKED,	-EAGAIN		},
+	{ NFS4ERR_OP_ILLEGAL,	-EOPNOTSUPP	},
 	{ NFS4ERR_NOXATTR,	-ENODATA	},
 	{ NFS4ERR_XATTR2BIG,	-E2BIG		},
-	{ -1,			-EIO		}
 };
 
 /*
@@ -116,7 +123,14 @@ static const struct {
 int nfs4_stat_to_errno(int stat)
 {
 	int i;
-	for (i = 0; nfs4_errtbl[i].stat != -1; i++) {
+
+	/* First check nfs4_errtbl_common */
+	for (i = 0; i < ARRAY_SIZE(nfs4_errtbl_common); i++) {
+		if (nfs4_errtbl_common[i].stat == stat)
+			return nfs4_errtbl_common[i].errno;
+	}
+	/* Then check nfs4_errtbl */
+	for (i = 0; i < ARRAY_SIZE(nfs4_errtbl); i++) {
 		if (nfs4_errtbl[i].stat == stat)
 			return nfs4_errtbl[i].errno;
 	}
@@ -132,3 +146,56 @@ int nfs4_stat_to_errno(int stat)
 	return -stat;
 }
 EXPORT_SYMBOL_GPL(nfs4_stat_to_errno);
+
+/*
+ * This table is useful for conversion from local errno to NFS error.
+ * It provides more logically correct mappings for use with LOCALIO
+ * (which is focused on converting from errno to NFS status).
+ */
+static const struct {
+	int stat;
+	int errno;
+} nfs4_errtbl_localio[] = {
+	/* Map errors differently than nfs4_errtbl */
+	{ NFS4ERR_IO,		-EREMOTEIO	},
+	{ NFS4ERR_DELAY,	-EAGAIN		},
+	{ NFS4ERR_FBIG,		-E2BIG		},
+	/* Map errors not handled by nfs4_errtbl */
+	{ NFS4ERR_STALE,	-EBADF		},
+	{ NFS4ERR_STALE,	-EOPENSTALE	},
+	{ NFS4ERR_DELAY,	-ETIMEDOUT	},
+	{ NFS4ERR_DELAY,	-ERESTARTSYS	},
+	{ NFS4ERR_DELAY,	-ENOMEM		},
+	{ NFS4ERR_IO,		-ETXTBSY	},
+	{ NFS4ERR_IO,		-EBUSY		},
+	{ NFS4ERR_SERVERFAULT,	-ESERVERFAULT	},
+	{ NFS4ERR_SERVERFAULT,	-ENFILE		},
+	{ NFS4ERR_IO,		-EUCLEAN	},
+	{ NFS4ERR_PERM,		-ENOKEY		},
+};
+
+/*
+ * Convert an errno to an NFS error code for LOCALIO.
+ */
+__u32 nfs_localio_errno_to_nfs4_stat(int errno)
+{
+	int i;
+
+	/* First check nfs4_errtbl_common */
+	for (i = 0; i < ARRAY_SIZE(nfs4_errtbl_common); i++) {
+		if (nfs4_errtbl_common[i].errno == errno)
+			return nfs4_errtbl_common[i].stat;
+	}
+	/* Then check nfs4_errtbl_localio */
+	for (i = 0; i < ARRAY_SIZE(nfs4_errtbl_localio); i++) {
+		if (nfs4_errtbl_localio[i].errno == errno)
+			return nfs4_errtbl_localio[i].stat;
+	}
+	/* If we cannot translate the error, the recovery routines should
+	 * handle it.
+	 * Note: remaining NFSv4 error codes have values > 10000, so should
+	 * not conflict with native Linux error codes.
+	 */
+	return NFS4ERR_SERVERFAULT;
+}
+EXPORT_SYMBOL_GPL(nfs_localio_errno_to_nfs4_stat);
diff --git a/include/linux/nfs_common.h b/include/linux/nfs_common.h
index 5fc02df88252..a541c3a02887 100644
--- a/include/linux/nfs_common.h
+++ b/include/linux/nfs_common.h
@@ -9,9 +9,10 @@
 #include <uapi/linux/nfs.h>
 
 /* Mapping from NFS error code to "errno" error code. */
-#define errno_NFSERR_IO EIO
 
 int nfs_stat_to_errno(enum nfs_stat status);
 int nfs4_stat_to_errno(int stat);
 
+__u32 nfs_localio_errno_to_nfs4_stat(int errno);
+
 #endif /* _LINUX_NFS_COMMON_H */
-- 
2.44.0






