Return-Path: <linux-nfs+bounces-13420-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B3BB1AB07
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 00:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B351F3A7D2C
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 22:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E789F28FAB3;
	Mon,  4 Aug 2025 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GG4ca9Yc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362823C516
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754347732; cv=none; b=PlwTe+ZDFtC22MNe3N2IJ2rIjaUHvVBcz6ywR+225OZ4nkGxrkV7aIxLcCDzZOOwKQ6bmcbS1X88ewOMQaCXe40qnapgmdO5wIbQ2I6Ln7ZsYrND/u/qjenpyr4odBUwdQvCOMlh7kf44RbhSXBRkwX9NgXEagLdpIm53AjzbJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754347732; c=relaxed/simple;
	bh=t/mtvBG1J0Bhpx5k/3gEX5+Z4p4pn3XA/enUWqjdsd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiAJTIZjtRBpz7Fz9/zoZybwazmW5mway5x70ovy4H/i549HwaVRD0sIz8m+ouLowdeHNlssIXN5WaVg5tJz/k1cdedF8acn/e4nK5ZkdbnHTRX9lbs6Iha99G969Z5rzZpLpZFE+0qj1c2KPcLT7DLqDXM2aSrvHl1JbNagCLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GG4ca9Yc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF64C4CEF7;
	Mon,  4 Aug 2025 22:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754347732;
	bh=t/mtvBG1J0Bhpx5k/3gEX5+Z4p4pn3XA/enUWqjdsd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GG4ca9Ycv5sLBgN1HpbTipsSYN0FrWgixmJE15Qe8PZhUmA9Ypke1CaXa9k+C1FWi
	 YwzLkvkmXVDADax3DE/7hSpRbIISYnX4lxXgeAXIMKX72s1bq00pzFlTHfGLn4mKdr
	 qyYwar5U6X0Pm4Hev14tjllD+NTgx9NU7tc1rHHL8koriOzqqK3QkhE5Vc6uHiFRYb
	 FjKfialfstv9Ly3tw6Rf3xOeYzhHV0Ge17zq28LXPGZ8KI4Zp5T/sjpHWbMSLcCV2H
	 QdsQX6Sw7IJIQXse8Q1+lBZlD4jrwVPOhm56oB1DtY3pH2v2JSWmawaL3GVU8wfOO0
	 xgDwVO402gQrw==
From: Eric Biggers <ebiggers@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 1/2] nfsd: Replace open-coded conversion of bytes to hex
Date: Mon,  4 Aug 2025 22:46:59 +0000
Message-ID: <20250804224701.2278773-2-ebiggers@kernel.org>
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

Since the Linux kernel's sprintf() has conversion to hex built-in via
"%*phN", delete md5_to_hex() and just use that.  Also add an explicit
array bound to the dname parameter of nfs4_make_rec_clidname() to make
its size clear.  No functional change.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/nfsd/nfs4recover.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 2231192ec33f..54f5e5392ef9 100644
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
-- 
2.50.1.565.gc32cd1483b-goog


