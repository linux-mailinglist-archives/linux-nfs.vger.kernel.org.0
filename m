Return-Path: <linux-nfs+bounces-9586-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEC2A1B8A8
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 16:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEAD116AECF
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 15:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73251150994;
	Fri, 24 Jan 2025 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6jtaLDV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2FA14D70B
	for <linux-nfs@vger.kernel.org>; Fri, 24 Jan 2025 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731759; cv=none; b=lg3+xc4Y+iIcPkM7i74XfhtRGiBznIZiNVHVriaFeZrWr8zN6uhQqDbvYzyy/diqk0MxdInpqil1zH5YWGoCtC4FxU2ZL+zIsWkzdivaJ2yxQP86FfTCPaCwSQbDjVrNod5eFSjmtwnwK5ynnGQzJzO/wWrQuC3vkmBH4235x9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731759; c=relaxed/simple;
	bh=xXw90luifKfLIPhezyEdSqttYHmT0msZHUPxaQuTLBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CN5U7H9d0KgBACg9Jvk25LQA6vVC47+lyKZVI+PnBcSmSt+02UMZJ/ropRm110LTW+2sp+pBzGTczt0fV+2LXgiu3Z03zNOFlQthvMsO8U0H9Mhz1wWVzIAIcNZy7TItmg65SfcjwvX8bg3gwg8/lEiGX3/Sol8YzsmyGaD90TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6jtaLDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30B0C4CEE7;
	Fri, 24 Jan 2025 15:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737731758;
	bh=xXw90luifKfLIPhezyEdSqttYHmT0msZHUPxaQuTLBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6jtaLDVkFbFzLpJNQ9Dd8fvbOOz+Yt+lJBbWUvCFvts0jwxE25eW+emJ7hAJUQ5A
	 efwExICx+SgLdxmcob3GgEvOR49BRJ+P08Ae2fL/yemxWH1gnQhzdv218oSs6lDvVO
	 o8fgYPEX5vIpmeKJZSCjVjBTST6vl0KK7X+IoJe0KVh3Yfoa1J3iCuOvBQPq+3vztV
	 OWNS+LaqktzbDdemGohFPY7RCaBmZI92fovlLkhTko/SX2GG+/tPPTs7WgdnqAkOfF
	 pEpt0dJfH+D5aaDwOCsfC4OaA+rupy2cH+Lb/hbdTJlKMopnpugYkocFAZmfPnRlRR
	 IQ9iVMMOK8wbA==
From: cel@kernel.org
To: Amir Goldstein <amir73il@gmail.com>,
	Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>
Subject: [PATCH v2 2/4] NFSD: Never return NFS4ERR_FILE_OPEN when removing a directory
Date: Fri, 24 Jan 2025 10:15:51 -0500
Message-ID: <20250124151553.17824-3-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250124151553.17824-1-cel@kernel.org>
References: <20250124151553.17824-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

RFC 8881 Section 18.25.4 paragraph 5 tells us that the server
should return NFS4ERR_FILE_OPEN only if the target object is an
opened file. This suggests that returning this status when removing
a directory will confuse NFS clients.

This is a version-specific issue; nfsd_proc_remove/rmdir() and
nfsd3_proc_remove/rmdir() already return nfserr_access as
appropriate.

Unfortunately there is no quick way for nfsd4_remove() to determine
whether the target object is a file or not, so the check is done in
to nfsd_unlink() for now.

Reported-by: Trond Myklebust <trondmy@hammerspace.com>
Fixes: 466e16f0920f ("nfsd: check for EBUSY from vfs_rmdir/vfs_unink.")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 2d8e27c225f9..6cd130b5c2b6 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1931,9 +1931,17 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	return err;
 }
 
-/*
- * Unlink a file or directory
- * N.B. After this call fhp needs an fh_put
+/**
+ * nfsd_unlink - remove a directory entry
+ * @rqstp: RPC transaction context
+ * @fhp: the file handle of the parent directory to be modified
+ * @type: enforced file type of the object to be removed
+ * @fname: the name of directory entry to be removed
+ * @flen: length of @fname in octets
+ *
+ * After this call fhp needs an fh_put.
+ *
+ * Returns a generic NFS status code in network byte-order.
  */
 __be32
 nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
@@ -2007,10 +2015,14 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	fh_drop_write(fhp);
 out_nfserr:
 	if (host_err == -EBUSY) {
-		/* name is mounted-on. There is no perfect
-		 * error status.
+		/*
+		 * See RFC 8881 Section 18.25.4 para 4: NFSv4 REMOVE
+		 * wants a status unique to the object type.
 		 */
-		err = nfserr_file_open;
+		if (type != S_IFDIR)
+			err = nfserr_file_open;
+		else
+			err = nfserr_acces;
 	}
 out:
 	return err != nfs_ok ? err : nfserrno(host_err);
-- 
2.47.0


