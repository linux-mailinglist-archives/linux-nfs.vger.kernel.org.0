Return-Path: <linux-nfs+bounces-13810-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9072B2EA23
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 03:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FB6A254EF
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 01:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE8E1FF5E3;
	Thu, 21 Aug 2025 01:10:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C19D5FEE6
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 01:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738647; cv=none; b=p9RI9eZjckddiLMhMeehhxvU2Uw6mnfvXqXN6OR1pdIpfLNrk8LqUPp26UhI3tZvZZVx1SnMGEPwMes2c7LQm1EAvl2ppiWc5KI/hToJiZ8anygrBaSLsx7qkIF5hqZVuFisGATJCSKE02LjtCEsJdMnrLDtjpI2yEzLtT32hLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738647; c=relaxed/simple;
	bh=4vKdAy+8m4Zj6qA9WQE3u0wblOreP6PWojmRjJwh+kE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=gIhLFtUKawO2GPXxzfZfhBNnL4Mjp0UzF8EIw8nAGTw90RSZpQI2EePCNgnhg0Q8OAqRopMgVWV7D6q9QF5pHdkVIzQ1PMO8AJ4LfZCIaBn1IiCVOV8dna7RhjFHlNIwuY/5HSg/NZ+4xzz5WnT7lFHR25q5fG5FVCePvwo3SXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uotp9-006WnM-Qy;
	Thu, 21 Aug 2025 01:10:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: discard nfserr_dropit
Date: Thu, 21 Aug 2025 11:10:41 +1000
Message-id: <175573864133.2234665.4220094746965657176@noble.neil.brown.name>



nfserr_dropit hasn't been used for over a decade, since rq_dropme and
the RQ_DROPME were introduced.

Time to get rid of it completely.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/lockd.c | 2 --
 fs/nfsd/nfsd.h  | 8 +-------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index edc9f75dc75c..dca80f5de0ad 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -57,8 +57,6 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct =
file **filp,
 	switch (nfserr) {
 	case nfs_ok:
 		return 0;
-	case nfserr_dropit:
-		return nlm_drop_reply;
 	case nfserr_stale:
 		return nlm_stale_fh;
 	default:
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 1cd0bed57bc2..2c9fa884ab05 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -335,14 +335,8 @@ void		nfsd_lockd_shutdown(void);
  * cannot conflict with any existing be32 nfserr value.
  */
 enum {
-	NFSERR_DROPIT =3D NFS4ERR_FIRST_FREE,
-/* if a request fails due to kmalloc failure, it gets dropped.
- *  Client should resend eventually
- */
-#define	nfserr_dropit		cpu_to_be32(NFSERR_DROPIT)
-
 /* end-of-file indicator in readdir */
-	NFSERR_EOF,
+	NFSERR_EOF, =3D NFS4ERR_FIRST_FREE,
 #define	nfserr_eof		cpu_to_be32(NFSERR_EOF)
=20
 /* replay detected */

--=20
2.50.0.107.gf914562f5916.dirty


