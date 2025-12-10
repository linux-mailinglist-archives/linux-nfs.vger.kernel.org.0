Return-Path: <linux-nfs+bounces-17017-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 075D3CB17C9
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Dec 2025 01:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3179B30E7F83
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Dec 2025 00:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9B919F115;
	Wed, 10 Dec 2025 00:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvb18fd3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7817919D065
	for <linux-nfs@vger.kernel.org>; Wed, 10 Dec 2025 00:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765326535; cv=none; b=jO5/BCO7XBrj4s+sDMXFHrLsPUseQpLNy2iSmySvowgaMFYc4a1SqAJ442u/u+hKM8aeBplfSl/6clxtXoPOaigH3VyfwQ+OinP1n0XLLcEHXmZATlSeM5oxBL+gJIWxyZhfk+IoLB8sQrhNA/GAN6r/hWNwg5C8PFCnHumsLao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765326535; c=relaxed/simple;
	bh=VJgc7bt/6dR+KPKCizbyOL1PU0sAr8lMadmStJcEeXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgtQcSdZmm4u4nedwTQ4h3HxCfsm9JlPV3flepHjSLlnUD+FahktRbd20hhroEIwfV5RjkNtlWGmH4Ai0VERoJzy73TalgpZGTg0/YbEVuUNXYF1sb9uqZ5eC5H/f/bgfnC/z/rphaqNY5cCoOhFU94Qo+A560eFEHQ0/bA4iAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvb18fd3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC101C113D0;
	Wed, 10 Dec 2025 00:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765326535;
	bh=VJgc7bt/6dR+KPKCizbyOL1PU0sAr8lMadmStJcEeXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uvb18fd3tjjpNBuFqE4bLUhgsETcq39wbDmXjZyjCGwSAbP35VkoaKZXZs3jKSWZC
	 T8ZVwMwmwFcSTeuutpnQl8YWIW0bfL+rvrZAMMzRYD8x3WKNBS+gNBanBWrAa/CuTy
	 djLaqxb9PCcgC6RcXLw7H4/oIQVuF1bNHxu8D0H2YHuNH84XpXvB/CjmS3a0H5R724
	 kfb6swjpfUZUEhuqUk0eaXAqV3RWweHa/aCr5ydKKU+egsQVXe9Cbl5fj6epOBLo7w
	 fqmfnJEP526/V4lsULqt22dYrFWU+JGG8BTu73d2IkaDks/U/UGa4biXhtYu6PGoTW
	 9y/nHtUW73S0A==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 1/2] NFSD: Remove NFSERR_EAGAIN
Date: Tue,  9 Dec 2025 19:28:49 -0500
Message-ID: <20251210002850.318350-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210002850.318350-1-cel@kernel.org>
References: <20251210002850.318350-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I haven't found an NFSERR_EAGAIN in RFCs 1094, 1813, 7530, or 8881.
None of these RFCs have an NFS status code that match the numeric
value "11".

Based on the meaning of the EAGAIN errno, I presume the use of this
status in NFSD means NFS4ERR_DELAY. So replace the one usage of
nfserr_eagain, and remove it from NFSD's NFS status conversion
tables.

As far as I can tell, NFSERR_EAGAIN has existed since the pre-git
era, but was not actually used by any code until commit f4e44b393389
("NFSD: delay unmount source's export after inter-server copy
completed."), at which time it become possible for NFSD to return
a status code of 11 (which is not valid NFS protocol).

Fixes: f4e44b393389 ("NFSD: delay unmount source's export after inter-server copy completed.")
X-Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs_common/common.c   | 1 -
 fs/nfsd/nfs4proc.c       | 2 +-
 fs/nfsd/nfsd.h           | 1 -
 include/trace/misc/nfs.h | 2 --
 include/uapi/linux/nfs.h | 1 -
 5 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/nfs_common/common.c b/fs/nfs_common/common.c
index af09aed09fd2..0778743ae2c2 100644
--- a/fs/nfs_common/common.c
+++ b/fs/nfs_common/common.c
@@ -17,7 +17,6 @@ static const struct {
 	{ NFSERR_NOENT,		-ENOENT		},
 	{ NFSERR_IO,		-EIO		},
 	{ NFSERR_NXIO,		-ENXIO		},
-/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
 	{ NFSERR_ACCES,		-EACCES		},
 	{ NFSERR_EXIST,		-EEXIST		},
 	{ NFSERR_XDEV,		-EXDEV		},
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 814d78f23a03..4c708cf02849 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1504,7 +1504,7 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 					(schedule_timeout(20*HZ) == 0)) {
 				finish_wait(&nn->nfsd_ssc_waitq, &wait);
 				kfree(work);
-				return nfserr_eagain;
+				return nfserr_jukebox;
 			}
 			finish_wait(&nn->nfsd_ssc_waitq, &wait);
 			goto try_again;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 50be785f1d2c..b0283213a8f5 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -233,7 +233,6 @@ void		nfsd_lockd_shutdown(void);
 #define	nfserr_noent		cpu_to_be32(NFSERR_NOENT)
 #define	nfserr_io		cpu_to_be32(NFSERR_IO)
 #define	nfserr_nxio		cpu_to_be32(NFSERR_NXIO)
-#define	nfserr_eagain		cpu_to_be32(NFSERR_EAGAIN)
 #define	nfserr_acces		cpu_to_be32(NFSERR_ACCES)
 #define	nfserr_exist		cpu_to_be32(NFSERR_EXIST)
 #define	nfserr_xdev		cpu_to_be32(NFSERR_XDEV)
diff --git a/include/trace/misc/nfs.h b/include/trace/misc/nfs.h
index c82233e950ac..a394b4d38e18 100644
--- a/include/trace/misc/nfs.h
+++ b/include/trace/misc/nfs.h
@@ -16,7 +16,6 @@ TRACE_DEFINE_ENUM(NFSERR_PERM);
 TRACE_DEFINE_ENUM(NFSERR_NOENT);
 TRACE_DEFINE_ENUM(NFSERR_IO);
 TRACE_DEFINE_ENUM(NFSERR_NXIO);
-TRACE_DEFINE_ENUM(NFSERR_EAGAIN);
 TRACE_DEFINE_ENUM(NFSERR_ACCES);
 TRACE_DEFINE_ENUM(NFSERR_EXIST);
 TRACE_DEFINE_ENUM(NFSERR_XDEV);
@@ -52,7 +51,6 @@ TRACE_DEFINE_ENUM(NFSERR_JUKEBOX);
 		{ NFSERR_NXIO,			"NXIO" }, \
 		{ ECHILD,			"CHILD" }, \
 		{ ETIMEDOUT,			"TIMEDOUT" }, \
-		{ NFSERR_EAGAIN,		"AGAIN" }, \
 		{ NFSERR_ACCES,			"ACCES" }, \
 		{ NFSERR_EXIST,			"EXIST" }, \
 		{ NFSERR_XDEV,			"XDEV" }, \
diff --git a/include/uapi/linux/nfs.h b/include/uapi/linux/nfs.h
index f356f2ba3814..71c7196d3281 100644
--- a/include/uapi/linux/nfs.h
+++ b/include/uapi/linux/nfs.h
@@ -49,7 +49,6 @@
 	NFSERR_NOENT = 2,		/* v2 v3 v4 */
 	NFSERR_IO = 5,			/* v2 v3 v4 */
 	NFSERR_NXIO = 6,		/* v2 v3 v4 */
-	NFSERR_EAGAIN = 11,		/* v2 v3 */
 	NFSERR_ACCES = 13,		/* v2 v3 v4 */
 	NFSERR_EXIST = 17,		/* v2 v3 v4 */
 	NFSERR_XDEV = 18,		/*    v3 v4 */
-- 
2.52.0


