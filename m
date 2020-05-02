Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693781C234A
	for <lists+linux-nfs@lfdr.de>; Sat,  2 May 2020 07:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgEBFdq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 2 May 2020 01:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727776AbgEBFdp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 2 May 2020 01:33:45 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B6DC208DB;
        Sat,  2 May 2020 05:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588397625;
        bh=D5XW6cZpsJwZ7D6M28ztCkO8mBJw30MPkBRR8dbGTwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aTIMQVl6HdIeINBbS+bh94aY/URMxXAIm5FeH8NT4QtQ2e0rLKrraXahmsRIShFWt
         aRE6zCqwmeA8G9OFtTVqRIbTV3f/GLhFNwcve20yI7ZmBycn7XiSCwl1yo7eOAGw6G
         BOuEKV5AX+qzZHZePQ8PfSZmRJz5VoZMvB2agScI=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 15/20] nfsd: use crypto_shash_tfm_digest()
Date:   Fri,  1 May 2020 22:31:17 -0700
Message-Id: <20200502053122.995648-16-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200502053122.995648-1-ebiggers@kernel.org>
References: <20200502053122.995648-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Instead of manually allocating a 'struct shash_desc' on the stack and
calling crypto_shash_digest(), switch to using the new helper function
crypto_shash_tfm_digest() which does this for us.

Cc: linux-nfs@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/nfsd/nfs4recover.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index a8fb18609146a2..9e40dfecf1b1a6 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -127,16 +127,8 @@ nfs4_make_rec_clidname(char *dname, const struct xdr_netobj *clname)
  		goto out;
 	}
 
-	{
-		SHASH_DESC_ON_STACK(desc, tfm);
-
-		desc->tfm = tfm;
-
-		status = crypto_shash_digest(desc, clname->data, clname->len,
-					     cksum.data);
-		shash_desc_zero(desc);
-	}
-
+	status = crypto_shash_tfm_digest(tfm, clname->data, clname->len,
+					 cksum.data);
 	if (status)
 		goto out;
 
@@ -1148,7 +1140,6 @@ nfsd4_cld_create_v2(struct nfs4_client *clp)
 	struct crypto_shash *tfm = cn->cn_tfm;
 	struct xdr_netobj cksum;
 	char *principal = NULL;
-	SHASH_DESC_ON_STACK(desc, tfm);
 
 	/* Don't upcall if it's already stored */
 	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
@@ -1170,16 +1161,14 @@ nfsd4_cld_create_v2(struct nfs4_client *clp)
 	else if (clp->cl_cred.cr_principal)
 		principal = clp->cl_cred.cr_principal;
 	if (principal) {
-		desc->tfm = tfm;
 		cksum.len = crypto_shash_digestsize(tfm);
 		cksum.data = kmalloc(cksum.len, GFP_KERNEL);
 		if (cksum.data == NULL) {
 			ret = -ENOMEM;
 			goto out;
 		}
-		ret = crypto_shash_digest(desc, principal, strlen(principal),
-					  cksum.data);
-		shash_desc_zero(desc);
+		ret = crypto_shash_tfm_digest(tfm, principal, strlen(principal),
+					      cksum.data);
 		if (ret) {
 			kfree(cksum.data);
 			goto out;
@@ -1343,7 +1332,6 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 	struct crypto_shash *tfm = cn->cn_tfm;
 	struct xdr_netobj cksum;
 	char *principal = NULL;
-	SHASH_DESC_ON_STACK(desc, tfm);
 
 	/* did we already find that this client is stable? */
 	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
@@ -1381,14 +1369,12 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 			principal = clp->cl_cred.cr_principal;
 		if (principal == NULL)
 			return -ENOENT;
-		desc->tfm = tfm;
 		cksum.len = crypto_shash_digestsize(tfm);
 		cksum.data = kmalloc(cksum.len, GFP_KERNEL);
 		if (cksum.data == NULL)
 			return -ENOENT;
-		status = crypto_shash_digest(desc, principal, strlen(principal),
-					     cksum.data);
-		shash_desc_zero(desc);
+		status = crypto_shash_tfm_digest(tfm, principal,
+						 strlen(principal), cksum.data);
 		if (status) {
 			kfree(cksum.data);
 			return -ENOENT;
-- 
2.26.2

