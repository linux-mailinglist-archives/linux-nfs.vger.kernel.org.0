Return-Path: <linux-nfs+bounces-9639-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A53A1CEDF
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 22:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E64A166895
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 21:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF733158A09;
	Sun, 26 Jan 2025 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzJ1zoHa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A32225A64F
	for <linux-nfs@vger.kernel.org>; Sun, 26 Jan 2025 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737928226; cv=none; b=qY0DWTzrRdKcnXph2/id1btRFPm6d6Of0AqOSChXo6HBRjIJNVyZrc1sf6MgSAOQv9NiUH2EJVx6EUH0NABBSUJKPgHa22THJh6cn2K+EoB8QefBf0wke3ZJaTvBdqWxfd/xa6MMnYfeZPWTE268hTT9nT0CLZDEEoT2zv34Cgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737928226; c=relaxed/simple;
	bh=mZUHBZ4A4sEnSTaCQ5MyMjWrK0FDdPsYWqeujrtmVOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1aDsl5WHYcPQc65jtQXmh5NFdY6UJOPr+UDpFsVD6VpVuItumLv2Q/WO8Iv6uzq9SFJpEcGhqxVC6aEzvD2Zexwh63aQq1VvreW0NOsWg3HaQ3ksZioFr1D9etOETJ0ZGWzvTm336SBUzbiZM16MLhxNfACL5GI7kO700V4MP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzJ1zoHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31710C4CEE5;
	Sun, 26 Jan 2025 21:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737928226;
	bh=mZUHBZ4A4sEnSTaCQ5MyMjWrK0FDdPsYWqeujrtmVOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hzJ1zoHaR/SJS8u4OEiHZqzN2OgBKPfkuRivBe6f3HeDIHd1uS+qQfAhe17JPL6V4
	 Tz5TxpGJWyUcoZgGKxpV4SPbcEh2hlzzlPftwGGVXYOznIJFj2vWfYFAtp2SaKWZIG
	 QASrXicDKUD3Tg36vPz0SEQTXX04x3MbD6U3s5LmhXhDa09FeTOZDEimTGMz+N8w0m
	 a5CWNbMJvnRYV66l/KyFwtaEkLVnuYGaL+GSYag5+yr5Oixy/U8DZ4QJj1BkdbI0xD
	 m4VCpFll+XNkmw+f9mrn3LRuILO9eMGARg9BPusGycrlVhpketCjsi0F1oKlvmYn+1
	 jRwhKsYpMQLUw==
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
Subject: [PATCH v3 2/4] NFSD: Never return NFS4ERR_FILE_OPEN when removing a directory
Date: Sun, 26 Jan 2025 16:50:18 -0500
Message-ID: <20250126215020.2466-3-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250126215020.2466-1-cel@kernel.org>
References: <20250126215020.2466-1-cel@kernel.org>
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
in nfsd_unlink() for now.

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


