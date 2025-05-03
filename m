Return-Path: <linux-nfs+bounces-11401-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B543AA814B
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 17:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CDB75A6400
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 15:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A7A27CCE2;
	Sat,  3 May 2025 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHZKQcVb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D402927CCDB;
	Sat,  3 May 2025 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285116; cv=none; b=ICwdKFw8g/EDPTfNCDlbF/m2r08TtNQsXqNJEbNDDm1h31x4P1P4ALo1WthLUUOWPBRmEqbrzwB80p78mO32AV8TVO2SilQzAZEb2DyNACfOBz4pucsIpBwTE+xoS9YZv7HDF+/7O76R50iYhDksnSz003O4nkKCzacH+u+4mxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285116; c=relaxed/simple;
	bh=puw/ksLPm4ioCKeRZH1T4nn8ZrUcLF8Shq+WG41gIHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DoTD3khYXbKWG5SoLVBDcQBAW1gr4S8Z1uUjzKuE9CZfChE0r+ARcd7qTJy6ZfVHRXz8AV2yu17ILCje8n3W/tKbY1OhdmT4uWA5TBNggiAWUc+rJb41Ddg4RnN6ChluKjqGZklx82uhPjOU86fyx5UAv2ROietcF6WsKLImvnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHZKQcVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D813C4CEEE;
	Sat,  3 May 2025 15:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746285116;
	bh=puw/ksLPm4ioCKeRZH1T4nn8ZrUcLF8Shq+WG41gIHw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZHZKQcVbdX33YF+Qmh9nmewNSSOGFfX+OynuLWP3uO/3eNHeve0AOlPNtzIl+zzD3
	 dP28wAj6W1cFBx7IXWuNVYfiFSl6/IfiET29S50eCa4nMoMLDR4mfM4pQlvPJMQI07
	 xXrECr7AeBGPimY3gv5TJq6uUJo0iBPa1Cwbuu/v0OpZai+kFUJljyHvJ/VWVxZ9Mb
	 6+O1NB7wNwpUtbq3I+6uwIIYziE+lljSEn9KwH0g9S8FKbIFqZ/+PfRv0Y8O7aB5Cf
	 325AC8dsWxxbPKke+48X3PSSjhkkqqhQJjEy0mNMyK2kV7m1zltu5XVMFxHWhOqq8K
	 jEzWw5/dTPhUg==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 03 May 2025 11:11:27 -0400
Subject: [PATCH v3 11/17] nfsd: remove old v2/3 create path dprintks
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-nfsd-tracepoints-v3-11-d89f445969af@kernel.org>
References: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
In-Reply-To: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2207; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=puw/ksLPm4ioCKeRZH1T4nn8ZrUcLF8Shq+WG41gIHw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoFjIu5D1W6x2kgpjD1czjKtDtwkzETkZHVjmEv
 rfOK4Kpc6qJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBYyLgAKCRAADmhBGVaC
 FdBID/9pTUAtZ/4vowgsoszGoENsxOdKo0lzz9tyHMzWNznfRavn1G3Bhv88L61/QCVtumIS2Xa
 4yudiDPGfANxvKd6xVWZsrzscD8IP4beiLVq0frM4vL7Jt29HtXQLnlhWMebjaQevJgG1JOes7/
 Je9Xzl5gYSFLxqWHrMhsc/LT3G+tJUdNOFl0ZEK6Cw+dEJQZi9OTKDH+N5bDJ346/5nPoeAZov0
 OFW2t2omdF90CNRAVLpon2nCEezONx0J7awYgW2sGAEI7dKL6ntIlhXxTzBRhBxuc3sgcJzGfHs
 KyRls8F+H9Cjg8VuSv5haCUMHWQo061bVCRjNZhH+o5QRg5HSbhk7TXrAdXPog353JIRn5XACzo
 8g+SqGpUwdpb88CscYCSRQDIPe3l5EmI/FWIPZJ/0OH+wEnVWl8dsvIlPSBKDAhGza+CfgZlc/B
 jgNYYPfFS036/HVggIxmn7NI6g087DrY3PPnShD5zqEKJzoLC7Jh76C0yPUhI1pBHiQaLtnmv8L
 igFbNG/pPm9nvFVv7qmHWr5+Qgat+sIOpNr3c0PsDiQUrhT5xr3Ksh0+TK0aglCzjDixgC4zGo8
 eygWJH5vNbec3FSlWffit1vwjJ2vLB9x6uJ+XF2gTh5Kzx2v/cixhmvV+KJTPSIVmwowDgrhkva
 Pd0Vd/nL45w6evg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs3proc.c | 15 ---------------
 fs/nfsd/nfsproc.c  |  5 -----
 2 files changed, 20 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index c77e273e73a423c77047ff68126556ed36bc9c8e..215d60b5b5e0386942d28432e66069ee6f960e0d 100644
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
index dd6ad6c87b55b3c830b81a7beda10d674dc0d09c..5e93e17b94d4de0382f9038b4600938bb6a699c2 100644
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


