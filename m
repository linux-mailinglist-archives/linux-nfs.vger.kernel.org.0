Return-Path: <linux-nfs+bounces-5832-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBBF961B2A
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 02:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC9F28517E
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 00:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42191BC23;
	Wed, 28 Aug 2024 00:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bk+FtEgH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6391BC20
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 00:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724805895; cv=none; b=njzBL69XEffbhSAmRpnOlmxmqWetE/H54VJOeUHeJW0JzhRGnsLoFzg1w31tPMIwotOPUt8J0iEKfDgKe9HmVlevKDfWOrDSOKRexaGF9Q31r1mqlUE0um9lRRwkxrVkIUYPjRIjWMAYOGCWJMnT6BXKvHJWI26YbQryttfCPmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724805895; c=relaxed/simple;
	bh=F3RAP/hBjRM+UQdSbzvK7oOy6hXSEi0TIKMvdG/FRGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhnKlXY5wvZEhtXYqB9QMPS5HzTiYXuQc7nKzwsFfn+5mpiXLrIkLVag+IM/YeB0n7cn8eqiCPc+mvpqWpoayZ1z+FV0n2H7gInyrk7G8pV/DM40gJVjTfbvRo25XyI4Wq1YfLDeYcCQcIcot69cXbD8wK8YPif9MN3i3E7z3Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bk+FtEgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E33C4DDEE;
	Wed, 28 Aug 2024 00:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724805895;
	bh=F3RAP/hBjRM+UQdSbzvK7oOy6hXSEi0TIKMvdG/FRGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bk+FtEgHPvqsHfHeeCxnbbRppkhtYQjmgMY4OzIF7YW//17IYhzQR5Kd/faQHOeRY
	 v71VvgSP/DG+MxRiI828KpKgeQvjoDnK6Awdwq/rHIrqY9y3Q7osqI65UngJGBxBOU
	 EV4KxTVp4c2e/byPOhGh2V1rwIhzKorSDzq0/TBrpi1md9HlgMA7enVSQlw8ZcM1CX
	 p5AY5sY7uZ7cV59rV+vPfJDdIQgvXSODXoKMLeDgpxUCshH7kuwqEvQwdRn+JM4FOH
	 8xTkNMsaEXWUkFFhi2ggi+Vvswe4dUwYJ27BLaU9Ga18ezndbAHH7JZ/sFv8lwOwX2
	 wbHTC9//2IwaA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Mike Snitzer <snitzer@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 3/6] NFSD: Avoid using rqstp->rq_vers in nfsd_set_fh_dentry()
Date: Tue, 27 Aug 2024 20:44:42 -0400
Message-ID: <20240828004445.22634-4-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828004445.22634-1-cel@kernel.org>
References: <20240828004445.22634-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Currently, fh_verify() makes some daring assumptions about which
version of file handle the caller wants, based on the things it can
find in the passed-in rqstp. The about-to-be-introduced LOCALIO use
case sometimes has no svc_rqst context, so this logic won't work in
that case.

Instead, examine the passed-in file handle. It's .max_size field
should carry information to allow nfsd_set_fh_dentry() to initialize
the file handle appropriately.

lockd appears to be the only kernel consumer that does not set the
file handle .max_size when during initialization.

write_filehandle() is the other question mark, as it looks possible
to specify a maxsize between NFS_FHSIZE and NFS3_FHSIZE here.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/lockd.c |  6 ++++--
 fs/nfsd/nfsfh.c | 11 +++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index 46a7f9b813e5..e636d2a1e664 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -32,8 +32,10 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
 	int		access;
 	struct svc_fh	fh;
 
-	/* must initialize before using! but maxsize doesn't matter */
-	fh_init(&fh,0);
+	if (rqstp->rq_vers == 4)
+		fh_init(&fh, NFS3_FHSIZE);
+	else
+		fh_init(&fh, NFS_FHSIZE);
 	fh.fh_handle.fh_size = f->size;
 	memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
 	fh.fh_export = NULL;
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 4b964a71a504..77acc26e8b02 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -267,25 +267,28 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	fhp->fh_dentry = dentry;
 	fhp->fh_export = exp;
 
-	switch (rqstp->rq_vers) {
-	case 4:
+	switch (fhp->fh_maxsize) {
+	case NFS4_FHSIZE:
 		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOATOMIC_ATTR)
 			fhp->fh_no_atomic_attr = true;
 		fhp->fh_64bit_cookies = true;
 		break;
-	case 3:
+	case NFS3_FHSIZE:
 		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOWCC)
 			fhp->fh_no_wcc = true;
 		fhp->fh_64bit_cookies = true;
 		if (exp->ex_flags & NFSEXP_V4ROOT)
 			goto out;
 		break;
-	case 2:
+	case NFS_FHSIZE:
 		fhp->fh_no_wcc = true;
 		if (EX_WGATHER(exp))
 			fhp->fh_use_wgather = true;
 		if (exp->ex_flags & NFSEXP_V4ROOT)
 			goto out;
+		break;
+	case 0:
+		WARN_ONCE(1, "Uninitialized file handle");
 	}
 
 	return 0;
-- 
2.45.2


