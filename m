Return-Path: <linux-nfs+bounces-13421-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A085AB1AB08
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 00:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1A73A6BB1
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 22:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5F62900AF;
	Mon,  4 Aug 2025 22:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ao/NtOdI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6846923C516
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 22:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754347733; cv=none; b=Og+ANdkmxzQ0Jca3F2afptzjB2hcExJfRKSg/vYoZwORQXBSOEGjwWBuoaPt4rrkTsecuJzazV4QW/waV1aXhoJQ36gqRXyyBRNcaF5elbavmjubYFSupINUAeuuYefaXWc7vyU/DSSPD+43KJCmgXHxnRJqKo6JzK3L21vHY/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754347733; c=relaxed/simple;
	bh=VVtpc65EtJGuIRuhMvWB72DRG08Rh9U5IMrXpqzL8aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPI/Bv2kl6/NnrC9T5wfz2iiIzOM1bBMRw9LJEQjxiSyccWBGGE7PuNkjobzGHAK6VwDee23WfCss34THmbg4+4uKFnrJaIhrTROzLSEChfiO2XbSubGSpdL48y7Q61ZPQuEMj79KD8LKepXFi+eI201uwUa91Uam+1TOMsYUbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ao/NtOdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F52C4CEF8;
	Mon,  4 Aug 2025 22:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754347732;
	bh=VVtpc65EtJGuIRuhMvWB72DRG08Rh9U5IMrXpqzL8aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ao/NtOdIkf9CBlUjux+uSQVMawmXqIHiKHepbEmPoDGS+RXrPfu7U7JXxMO2nmBa4
	 t8BZMTLmwsOYIyUCTDdzFzggnqdUDk1QI+b3bVtK4xJB6+oIsgSa/OQ/LC6iQIbq2R
	 v4XONJywmbviE9DUGUP48G5GeuKSROhTk95wBKbisIEOouB+VAghI8mP7HSPAnAosn
	 71Sl7AHFmgzvshsnXrXs855Js3/Yn8IPqChd8YYMXiI12ySdDIO9Za4eoxja/HkiiY
	 wdJrfX5kRieZCsphpbmLJ8rSHFvVEVFCZPlshbwj2xT5tRvVxnC6EXKobKuVQ7Plf5
	 I3qW3a7ejVNFA==
From: Eric Biggers <ebiggers@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 2/2] nfsd: Eliminate an allocation in nfs4_make_rec_clidname()
Date: Mon,  4 Aug 2025 22:47:00 +0000
Message-ID: <20250804224701.2278773-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250804224701.2278773-1-ebiggers@kernel.org>
References: <20250804224701.2278773-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since MD5 digests are fixed-size, make nfs4_make_rec_clidname() store
the digest in a stack buffer instead of a dynamically allocated buffer.
Use MD5_DIGEST_SIZE instead of a hard-coded value, both in
nfs4_make_rec_clidname() and in the definition of HEXDIR_LEN.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/nfsd/nfs4recover.c | 15 ++++-----------
 fs/nfsd/state.h       |  4 +++-
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 54f5e5392ef9..e2b9472e5c78 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -93,11 +93,11 @@ nfs4_reset_creds(const struct cred *original)
 }
 
 static int
 nfs4_make_rec_clidname(char dname[HEXDIR_LEN], const struct xdr_netobj *clname)
 {
-	struct xdr_netobj cksum;
+	u8 digest[MD5_DIGEST_SIZE];
 	struct crypto_shash *tfm;
 	int status;
 
 	dprintk("NFSD: nfs4_make_rec_clidname for %.*s\n",
 			clname->len, clname->data);
@@ -105,27 +105,20 @@ nfs4_make_rec_clidname(char dname[HEXDIR_LEN], const struct xdr_netobj *clname)
 	if (IS_ERR(tfm)) {
 		status = PTR_ERR(tfm);
 		goto out_no_tfm;
 	}
 
-	cksum.len = crypto_shash_digestsize(tfm);
-	cksum.data = kmalloc(cksum.len, GFP_KERNEL);
-	if (cksum.data == NULL) {
-		status = -ENOMEM;
- 		goto out;
-	}
-
 	status = crypto_shash_tfm_digest(tfm, clname->data, clname->len,
-					 cksum.data);
+					 digest);
 	if (status)
 		goto out;
 
-	sprintf(dname, "%*phN", 16, cksum.data);
+	static_assert(HEXDIR_LEN == 2 * MD5_DIGEST_SIZE + 1);
+	sprintf(dname, "%*phN", MD5_DIGEST_SIZE, digest);
 
 	status = 0;
 out:
-	kfree(cksum.data);
 	crypto_free_shash(tfm);
 out_no_tfm:
 	return status;
 }
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 8adc2550129e..b7d4c6d6f3d4 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -33,10 +33,11 @@
  */
 
 #ifndef _NFSD4_STATE_H
 #define _NFSD4_STATE_H
 
+#include <crypto/md5.h>
 #include <linux/idr.h>
 #include <linux/refcount.h>
 #include <linux/sunrpc/svc_xprt.h>
 #include "nfsfh.h"
 #include "nfsd.h"
@@ -379,11 +380,12 @@ struct nfsd4_sessionid {
 	clientid_t	clientid;
 	u32		sequence;
 	u32		reserved;
 };
 
-#define HEXDIR_LEN     33 /* hex version of 16 byte md5 of cl_name plus '\0' */
+/* Length of MD5 digest as hex, plus terminating '\0' */
+#define HEXDIR_LEN	(2 * MD5_DIGEST_SIZE + 1)
 
 /*
  *       State                Meaning                  Where set
  * --------------------------------------------------------------------------
  * | NFSD4_ACTIVE      | Confirmed, active    | Default                     |
-- 
2.50.1.565.gc32cd1483b-goog


