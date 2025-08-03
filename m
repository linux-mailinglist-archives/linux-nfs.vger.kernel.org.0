Return-Path: <linux-nfs+bounces-13393-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAF0B19640
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Aug 2025 23:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12B518949AE
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Aug 2025 21:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51A0221F13;
	Sun,  3 Aug 2025 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAviez+F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A9421CA1E
	for <linux-nfs@vger.kernel.org>; Sun,  3 Aug 2025 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256152; cv=none; b=uPulEgO3j74jOM3RyUXWhPaek4R3ZPdtXHM1nIHyT65jPxa8gqfH5Qdzlyil2DqP9/JuYkwgC9P3bkrDGllNwgFTcRRAO/LBNUfFdUqwwMspkb/vvXIByRJEv8uI/6EWEMod6aApTfuxtudX5jxqrj99w5UC783IlWcdLR/wGQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256152; c=relaxed/simple;
	bh=sW4AifLlIcjcsLBu9rPB5UoBxQFwI/2eoC0ZK76CaQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L3ZC8IwWU8QNKaDPb7+/12HfHY7P+6NZRbRZ+kCpHdz3ySabgMe2I2lQxQdjH4P2IO9CQL784C/plSbA14c/wrglX2oU7bTE7wSM/KdiDp7wo06zYmN7sUEc5dTR2fjPV1273v1OY+3ADONrQl1NbThcgFh45XPAcmYnLYXasjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAviez+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E042C4CEF0;
	Sun,  3 Aug 2025 21:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754256152;
	bh=sW4AifLlIcjcsLBu9rPB5UoBxQFwI/2eoC0ZK76CaQU=;
	h=From:To:Cc:Subject:Date:From;
	b=OAviez+FA7LVxXp2TNPZ4DvtG1ZaqiLWLDwt94CO7G3EADnsTlYMoCtI3Nvpkzykj
	 RO+C1bUftXlOX36gkhrupXiV0BcM/hD/mz5nP06G7VT43S8NylUkuFPB1L9ATt12ut
	 2YnoLv8a+UmjZdcQGhI5ah7lxjHgQnd6jaevQNBary1yq48hJNbh5jTCYmQRwTshcA
	 5aPFcl0j6jI/Z3JvNtDNWOPwxuR/mhu5pq9lgfbJL73Kq3iWWmYL5Avc9F7nJkJj0u
	 QcY43lY3JXkbHfRcmLC5kLZpubKQyXyQ77aqQjuyWsFHboYOgfrCEJw0SI+mflbRBs
	 BXXY2CwKw3IjA==
From: Eric Biggers <ebiggers@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] nfsd: Don't force CRYPTO_LIB_SHA256 to be built-in
Date: Sun,  3 Aug 2025 14:21:30 -0700
Message-ID: <20250803212130.105700-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that nfsd is accessing SHA-256 via the library API instead of via
crypto_shash, there is a direct symbol dependency on the SHA-256 code
and there is no benefit to be gained from forcing it to be built-in.
Therefore, select CRYPTO_LIB_SHA256 from NFSD (conditional on NFSD_V4)
instead of from NFSD_V4, so that it can be 'm' if NFSD is 'm'.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/nfsd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 879e0b104d1c8..e134dce45e350 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -3,10 +3,11 @@ config NFSD
 	tristate "NFS server support"
 	depends on INET
 	depends on FILE_LOCKING
 	depends on FSNOTIFY
 	select CRC32
+	select CRYPTO_LIB_SHA256 if NFSD_V4
 	select LOCKD
 	select SUNRPC
 	select EXPORTFS
 	select NFS_COMMON
 	select NFS_ACL_SUPPORT if NFSD_V2_ACL
@@ -75,11 +76,10 @@ config NFSD_V4
 	bool "NFS server support for NFS version 4"
 	depends on NFSD && PROC_FS
 	select FS_POSIX_ACL
 	select RPCSEC_GSS_KRB5
 	select CRYPTO
-	select CRYPTO_LIB_SHA256
 	select CRYPTO_MD5
 	select GRACE_PERIOD
 	select NFS_V4_2_SSC_HELPER if NFS_V4_2
 	help
 	  This option enables support in your system's NFS server for

base-commit: 186f3edfdd41f2ae87fc40a9ccba52a3bf930994
-- 
2.50.1


