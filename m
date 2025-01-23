Return-Path: <linux-nfs+bounces-9547-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C6DA1AABB
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 20:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9413A294A
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 19:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBFB1ADC8D;
	Thu, 23 Jan 2025 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjL1FFaW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072057E105
	for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661969; cv=none; b=St8XDHLk8I3SKZsDaz1LRuWlGjXxYWGI7PLv+vMDcJ2Cr3I5Xolfk59k3NlxoEvyiUX8LFmrLS77ZX74tf3Pf2vEghijw+vCl78PnN7SQVkluxVIxFqulYWQIj6mpgXrmD5vwZQRKOJX8sCrbP3AOeFVz9Mj5OQPYf/ED4cgMRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661969; c=relaxed/simple;
	bh=yaLWrPP93PZLkFvbMLciRxhsYrSzSc/L9aVzzoE56aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7d775XJSDIflZKTnhgfNerksBwh5hDj2mM2ZoSqJSmaj4xAX7ENhqOvGdqzNGk6OeWfhR/+F4GzRa1GckrPo3LwMiSqiPUph68A/0Nt8ohTpRd4WclLKi62WPZumvDXGpcqE5VAHetzZrRqVByIlkQ2t3JVWLayAWsUxHfHVAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjL1FFaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EA5C4CED3;
	Thu, 23 Jan 2025 19:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737661968;
	bh=yaLWrPP93PZLkFvbMLciRxhsYrSzSc/L9aVzzoE56aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pjL1FFaWZdBlxI/KsKk78+gOnScAci1JDQK708e428y9NjNUkppYBX8D/614O0LVY
	 dL/yKmzR+JYPxLst4KsQPl0CA+RDfFv04UqqRhgJMy/9u3TZHrv8vsM4YDmqoXVMl7
	 aGOJG++Vunm0MaZVLQJPVSXAvGzGLRX2cpzU9k5nYn4j5DLgVLhISQEzCAU6BQRT3q
	 eus363DK9xF8nMiGnn3zcRx4JeRimGu3tuZvqoknpE0DSEhCVqTfCyeyhSndX69foh
	 HkrgKq0ZBBQ9ThgOxLRVkjvdyU2RLjV67j/P9lvRL9FjRfxhm7zO4YXUo02yJwx2Dh
	 RyuHVwXsqjXWA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>
Subject: [RFC PATCH 2/4] NFSD: Never return NFS4ERR_FILE_OPEN when removing a directory
Date: Thu, 23 Jan 2025 14:52:40 -0500
Message-ID: <20250123195242.1378601-3-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250123195242.1378601-1-cel@kernel.org>
References: <20250123195242.1378601-1-cel@kernel.org>
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
index 2d8e27c225f9..3ead7fb3bf04 100644
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
+		 * distinguishes between reg file and dir.
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


