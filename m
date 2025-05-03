Return-Path: <linux-nfs+bounces-11420-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 398F2AA8280
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 22:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F4C17E630
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 20:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6E828153D;
	Sat,  3 May 2025 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfRo2zBR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26313281530;
	Sat,  3 May 2025 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746302393; cv=none; b=aX7nlEAY5sNclwGELAXK+40L3ZHlew0RAHc0ysd3oPUJ7/v1edvlQpvF16RlZsdKgfxw5452G9b2ThIOTHQ1KMejVIGoX77Vb+rGOMmS1EbZ+OJdCb/6ZXxw5eNRz4t4t/NSCUw8UwHVGxRyhybyjYIJuaW/kR0zEDEPJDlorIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746302393; c=relaxed/simple;
	bh=TVHo4Ecy++QVCQpnYiE4psmntUpTeyQ75KVVZClLUzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUaOImEI/ojtFK1UksR+ycQEJuYVwNUUdS5vR51xYUcef2b1mlUXTDMvUfLPJTueN0kKr0vdk4dZZoznk8YVn94fx1ds7nYYOxyLwUulGHKpr/Ps8WHZNJw+Qfj5RwL9jHuvOq+uTJq/znZGDJ0oJBQMaAFALmXERfZRTG4JCOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfRo2zBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E5AC4CEEF;
	Sat,  3 May 2025 19:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746302392;
	bh=TVHo4Ecy++QVCQpnYiE4psmntUpTeyQ75KVVZClLUzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gfRo2zBRgJes8jqTLAuFuu2BUobMaNoh9dM0mwC3jP/8ANMolvc7b7edZ0moMNuee
	 Ib/BPADMCBANV6d/ysYLMCehuVV8k/7D4mn4yC3TCVsEMgcaMcEHElRWk/p1xRwI1f
	 R7FGnQ0aKfBoBaW5IBJrgxw1tS+5IWjXfow5GbhHkLDgloA5l3ZC6q9d7pYXk3G884
	 Hd/x5S9C0aYySIYQdoCyulcH7qwp2Vt/EVy8qhqjGv7L6cVwz/TSh2ShFdfbFJT8in
	 ibo0fUdpKo8cpZ5z3Oz9ef4TGXyJKPNGb/5OXUCkZnkeg64UeEIeKgXU8AHbT6SZzy
	 xyYb/vzcNofHA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: sargun@sargun.me,
	<linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 12/18] nfsd: remove old v2/3 create path dprintks
Date: Sat,  3 May 2025 15:59:30 -0400
Message-ID: <20250503195936.5083-13-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503195936.5083-1-cel@kernel.org>
References: <20250503195936.5083-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

Observability here is now covered by static tracepoints.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c | 15 ---------------
 fs/nfsd/nfsproc.c  |  5 -----
 2 files changed, 20 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index f6eb8331dc4b..a4dd1f7c202f 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -385,11 +385,6 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
 	svc_fh *dirfhp, *newfhp;
 
-	dprintk("nfsd: CREATE(3)   %s %.*s\n",
-				SVCFH_fmt(&argp->fh),
-				argp->len,
-				argp->name);
-
 	dirfhp = fh_copy(&resp->dirfh, &argp->fh);
 	newfhp = fh_init(&resp->fh, NFS3_FHSIZE);
 
@@ -410,11 +405,6 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
 		.na_iattr	= &argp->attrs,
 	};
 
-	dprintk("nfsd: MKDIR(3)    %s %.*s\n",
-				SVCFH_fmt(&argp->fh),
-				argp->len,
-				argp->name);
-
 	argp->attrs.ia_valid &= ~ATTR_SIZE;
 	fh_copy(&resp->dirfh, &argp->fh);
 	fh_init(&resp->fh, NFS3_FHSIZE);
@@ -479,11 +469,6 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
 	int type;
 	dev_t	rdev = 0;
 
-	dprintk("nfsd: MKNOD(3)    %s %.*s\n",
-				SVCFH_fmt(&argp->fh),
-				argp->len,
-				argp->name);
-
 	fh_copy(&resp->dirfh, &argp->fh);
 	fh_init(&resp->fh, NFS3_FHSIZE);
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 8816cc565c0c..eec925d84410 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -295,9 +295,6 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	int		hosterr;
 	dev_t		rdev = 0, wanted = new_decode_dev(attr->ia_size);
 
-	dprintk("nfsd: CREATE   %s %.*s\n",
-		SVCFH_fmt(dirfhp), argp->len, argp->name);
-
 	/* First verify the parent file handle */
 	resp->status = fh_verify(rqstp, dirfhp, S_IFDIR, NFSD_MAY_EXEC);
 	if (resp->status != nfs_ok)
@@ -551,8 +548,6 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
 		.na_iattr	= &argp->attrs,
 	};
 
-	dprintk("nfsd: MKDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), argp->len, argp->name);
-
 	if (resp->fh.fh_dentry) {
 		printk(KERN_WARNING
 			"nfsd_proc_mkdir: response already verified??\n");
-- 
2.49.0


