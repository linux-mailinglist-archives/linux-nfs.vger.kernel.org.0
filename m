Return-Path: <linux-nfs+bounces-13394-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1C4B1966E
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Aug 2025 23:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24CE818950B5
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Aug 2025 21:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3749A1DE4F6;
	Sun,  3 Aug 2025 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTxGg86A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F2A7E792
	for <linux-nfs@vger.kernel.org>; Sun,  3 Aug 2025 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256314; cv=none; b=s/srxtW8wlNf8S6vvIFIXISawJCVe0JSZclfwQezsFEI3UsH+/CaaeTf1r+GAN+IQ2O/7LW72OTs3SV4In9CCo9J0dqacwgT2Z4ySt7ByJ07OuIJ54OTYtdrzS/3dmPniqWS+NWn9ZZFrdtbX4JYrPia93AS7Fkulr/GXUxXy2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256314; c=relaxed/simple;
	bh=R8yJGn1ouahuJ7UB3zBOgscNl2K+qkNi0eIU+gB3MHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WAOTFWyIJtHLSfy/t1iJ3Qsj1/Fz06FXJiL68Di4uk6epudh8exNn6BdEfdpcxUPCd2llSRYkbTb2coJpHAeb9L9r2dgM2QYf6qXYNUGr0Vi5w/CPkjfTYPU442D+87LJuShfY/8kuxi4SwM7sxN/AbZdOVmx7UTCZbJ1okoPmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTxGg86A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9115EC4CEEB;
	Sun,  3 Aug 2025 21:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754256313;
	bh=R8yJGn1ouahuJ7UB3zBOgscNl2K+qkNi0eIU+gB3MHQ=;
	h=From:To:Cc:Subject:Date:From;
	b=aTxGg86AzFqvvuJh+VSZJAU9P2/Fc8cpBaombub88GPDie+0lCC69+yBFAtEbOAh/
	 hP0fx+jYpLnAf5c18RMuN5wHaQpyCrB4GglOa21M7jZ4GRzyxb9Zi1jAbSr+6U59Sg
	 ZD/QgA1FdzA9p8t4248au26uVANBKYGNp6hyGHBc0Y0CM84L80AeUUtZSWC9WP4jko
	 s/BvgZJk/VfmS+fZfHVRcoF9fiBedm/yOkWk58jg1RLfIyd2ZLjXfKbazsnaQvVxy/
	 qU73kHyYFTghxioSnhDD1BpMN4crnPk9+uSCgSB3y2Z7yNzJhkDXpRAkmkX2Q7casY
	 xleJfRyfJESsw==
From: Eric Biggers <ebiggers@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] nfsd: Replace open-coded conversion of bytes to hex
Date: Sun,  3 Aug 2025 14:24:48 -0700
Message-ID: <20250803212448.117174-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the Linux kernel's sprintf() has conversion to hex built-in via
"%*phN", delete md5_to_hex() and just use that.  Also add an explicit
array bound to the dname parameter of nfs4_make_rec_clidname() to make
its size clear.  No functional change.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/nfsd/nfs4recover.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 2231192ec33f5..54f5e5392ef9d 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -90,26 +90,12 @@ static void
 nfs4_reset_creds(const struct cred *original)
 {
 	put_cred(revert_creds(original));
 }
 
-static void
-md5_to_hex(char *out, char *md5)
-{
-	int i;
-
-	for (i=0; i<16; i++) {
-		unsigned char c = md5[i];
-
-		*out++ = '0' + ((c&0xf0)>>4) + (c>=0xa0)*('a'-'9'-1);
-		*out++ = '0' + (c&0x0f) + ((c&0x0f)>=0x0a)*('a'-'9'-1);
-	}
-	*out = '\0';
-}
-
 static int
-nfs4_make_rec_clidname(char *dname, const struct xdr_netobj *clname)
+nfs4_make_rec_clidname(char dname[HEXDIR_LEN], const struct xdr_netobj *clname)
 {
 	struct xdr_netobj cksum;
 	struct crypto_shash *tfm;
 	int status;
 
@@ -131,11 +117,11 @@ nfs4_make_rec_clidname(char *dname, const struct xdr_netobj *clname)
 	status = crypto_shash_tfm_digest(tfm, clname->data, clname->len,
 					 cksum.data);
 	if (status)
 		goto out;
 
-	md5_to_hex(dname, cksum.data);
+	sprintf(dname, "%*phN", 16, cksum.data);
 
 	status = 0;
 out:
 	kfree(cksum.data);
 	crypto_free_shash(tfm);

base-commit: 186f3edfdd41f2ae87fc40a9ccba52a3bf930994
-- 
2.50.1


