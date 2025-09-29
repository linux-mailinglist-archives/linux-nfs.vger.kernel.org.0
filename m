Return-Path: <linux-nfs+bounces-14776-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE04BA9E59
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 17:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00FCB3C34CA
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 15:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAB930C10D;
	Mon, 29 Sep 2025 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZISnXZw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F6630C0EA
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161413; cv=none; b=gZW+taWme5EcGh6a2ljyvc6HUNixK6RPohh+rdbo8PvrRkG2+8SqtV8bqQWp1K9SE59XRSzb7JTGNREkcXXIyM8nzLAXW85ZYKwTKzRyGDF6zqr0wC6hHGRo4ry+eOK3wJvqo2jQpPkEcYb5BMuBPvYDHY8HMHhODmBU6fAhXzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161413; c=relaxed/simple;
	bh=lGZN+nIaksDw8Er6FxcOZQnmp/c0e5ItsAgJQLyXzD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLWx3IRj9CRfKU4pB9tdzsNknmK6nFqjEswglqUKEArdWpn4bdXiRbfl/iu6BV0AwOQAU2MoAqQS0eJErcAQ/Xz4ITTTGAQDu9F2EPUnuBD1J64cIUFq3m5YsPKAIrkXzvSUsAeBUvsifx6FTdxJj1+D2q7Gd/Ia6Vbrbsvh4ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZISnXZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4980CC116B1;
	Mon, 29 Sep 2025 15:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759161412;
	bh=lGZN+nIaksDw8Er6FxcOZQnmp/c0e5ItsAgJQLyXzD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZISnXZwvDXZCaXzhGsfryI/gjynlhHzcQhg0Jucbw3fdFOIoSgfHMu8de4AtYgtj
	 msN7l4AzyKKZpSoiW0Q9wMGb+68Arkdx9fNRzWWKkODkFKbGjv8sQ2gXoW3LoMXMkg
	 24gpJodoSazjRhUW0qsYbdrzFdyKBAkUOaf0qL0+bCW3VMcM8Ln7hgvKXSMUCTXgbp
	 erYbHZc9dWxIhqetwg+63SeLZgFOEdt/ImQ6vBqRKnkvRgdrvIO3zOn+h6Otg4/hHa
	 aM+ffWI74n6mAk6r2kONMDM/wYQECAgJabZLms0FwItZNIV6DOwDLa4P75QQ0QMQ3U
	 1SskdPQNs6+Gw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 6/6] NFSD: Ignore vfs_getattr() failure in nfsd_file_get_dio_attrs()
Date: Mon, 29 Sep 2025 11:56:46 -0400
Message-ID: <20250929155646.4818-7-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929155646.4818-1-cel@kernel.org>
References: <20250929155646.4818-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

A vfs_getattr() failure is rare but not totally impossible.

There's no recovery logic in that case; nfsd_do_file_acquire()'s
caller will fail but the wonky nfsd_file is left in the file cache.

It doesn't seem necessary for nfsd_file_do_acquire() to fail
outright if it successfully opened the file but some problem
prevented the collection of the dio alignment parameters.

Fixes: bc70aaeba7df ("NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 78cca0d751ac..b34cc8d2cb5e 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1051,7 +1051,7 @@ nfsd_file_is_cached(struct inode *inode)
 	return ret;
 }
 
-static __be32
+static void
 nfsd_file_get_dio_attrs(const struct svc_fh *fhp, struct nfsd_file *nf)
 {
 	struct inode *inode = file_inode(nf->nf_file);
@@ -1060,11 +1060,12 @@ nfsd_file_get_dio_attrs(const struct svc_fh *fhp, struct nfsd_file *nf)
 
 	/* Currently only need to get DIO alignment info for regular files */
 	if (!S_ISREG(inode->i_mode))
-		return nfs_ok;
+		return;
 
 	status = fh_getattr(fhp, &stat);
 	if (status != nfs_ok)
-		return status;
+		/* Use default dio alignment parameters (all zero) */
+		return;
 
 	trace_nfsd_file_get_dio_attrs(inode, &stat);
 
@@ -1076,8 +1077,6 @@ nfsd_file_get_dio_attrs(const struct svc_fh *fhp, struct nfsd_file *nf)
 		nf->nf_dio_read_offset_align = stat.dio_read_offset_align;
 	else
 		nf->nf_dio_read_offset_align = nf->nf_dio_offset_align;
-
-	return nfs_ok;
 }
 
 static __be32
@@ -1199,7 +1198,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
 			status = nfserrno(ret);
 			trace_nfsd_file_open(nf, status);
 			if (status == nfs_ok)
-				status = nfsd_file_get_dio_attrs(fhp, nf);
+				nfsd_file_get_dio_attrs(fhp, nf);
 		}
 	} else
 		status = nfserr_jukebox;
-- 
2.51.0


