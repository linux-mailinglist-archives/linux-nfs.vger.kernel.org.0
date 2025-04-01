Return-Path: <linux-nfs+bounces-10981-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB7FA78453
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 00:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D227B3AE0E7
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 22:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB0520D51C;
	Tue,  1 Apr 2025 22:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Toh5IroY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CE8204F6B;
	Tue,  1 Apr 2025 22:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743545001; cv=none; b=o7pb2VAhaeWH53cbIOz0XNYCC3yaK5utcuOGSFXeXmQQNrId0CxKGbJbgVLyQ0RerHl7byYcEsc318qHmkLznw40myo8gEzvmlNtcJTzXc0ylwOW1CVN15fcO7/X9/sqmYsnZCO0wsOsNWubD+iohV1szeqAIOw89iNI6NGMEqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743545001; c=relaxed/simple;
	bh=u/p4PqHWWDv4YOPhMDDi1O7bZreu7QjIV1UjU9GXshI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJE4jKXnlqfa6ChBl9PuRTrdEZCUkttAwAwBv4/o0cUMAGLK/3BsMJAYzR3ynksxzB0XkWDft64+xCxpalqQbD+IDjOwsGQ5S0wo5EEQg/LLrFM66si+oli2JyMLjfT5VUJQ58wAb6g2Wx0kUj9OU6T616DvavEN0OWnIQkefEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Toh5IroY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B546BC4CEE4;
	Tue,  1 Apr 2025 22:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743545000;
	bh=u/p4PqHWWDv4YOPhMDDi1O7bZreu7QjIV1UjU9GXshI=;
	h=From:To:Cc:Subject:Date:From;
	b=Toh5IroYbHDD+2vBRQwub37S21UKmZ6Yt3v9SP9hdQVbDdxBDBoii5xppnmxqpbt1
	 1f2OzXhhw4CQqwLopD1G2aIz/5ykZPO+qLd38LQ027wGSK/+EgFy21aDFPcMPSpjW7
	 OWqKQlbF/nOd7cpf20oE7iP0p/t/sqyVMIqJHUUgoEFEI/SCZroyTPg3rsvMac2pCM
	 UdIxs6zbIYnWgReTIngDqjdEK9kKbsaMo3L2ib0ap7aI2kjp+6FmqJ1l6ny9lJpj5z
	 mjvfJ6zJxNEucDAJi28Ot3ifls66cje+qljKJdX7kx4p4a+FqCv5wSZTvk1yk1HiMo
	 NpuVHCMNmQbNw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-nfs@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nfs: add missing selections of CONFIG_CRC32
Date: Tue,  1 Apr 2025 15:02:21 -0700
Message-ID: <20250401220221.22040-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

nfs.ko, nfsd.ko, and lockd.ko all use crc32_le(), which is available
only when CONFIG_CRC32 is enabled.  But the only NFS kconfig option that
selected CONFIG_CRC32 was CONFIG_NFS_DEBUG, which is client-specific and
did not actually guard the use of crc32_le() even on the client.

The code worked around this bug by only actually calling crc32_le() when
CONFIG_CRC32 is built-in, instead hard-coding '0' in other cases.  This
avoided randconfig build errors, and in real kernels the fallback code
was unlikely to be reached since CONFIG_CRC32 is 'default y'.  But, this
really needs to just be done properly, especially now that I'm planning
to update CONFIG_CRC32 to not be 'default y'.

Therefore, make CONFIG_NFS_FS, CONFIG_NFSD, and CONFIG_LOCKD select
CONFIG_CRC32.  Then remove the fallback code that becomes unnecessary,
as well as the selection of CONFIG_CRC32 from CONFIG_NFS_DEBUG.

Fixes: 1264a2f053a3 ("NFS: refactor code for calculating the crc32 hash of a filehandle")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/Kconfig           | 1 +
 fs/nfs/Kconfig       | 2 +-
 fs/nfs/internal.h    | 7 -------
 fs/nfs/nfs4session.h | 4 ----
 fs/nfsd/Kconfig      | 1 +
 fs/nfsd/nfsfh.h      | 7 -------
 include/linux/nfs.h  | 7 -------
 7 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index c718b2e2de0e..5b4847bd2fbb 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -366,10 +366,11 @@ config GRACE_PERIOD
 	tristate
 
 config LOCKD
 	tristate
 	depends on FILE_LOCKING
+	select CRC32
 	select GRACE_PERIOD
 
 config LOCKD_V4
 	bool
 	depends on NFSD || NFS_V3
diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index d3f76101ad4b..07932ce9246c 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -1,9 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config NFS_FS
 	tristate "NFS client support"
 	depends on INET && FILE_LOCKING && MULTIUSER
+	select CRC32
 	select LOCKD
 	select SUNRPC
 	select NFS_COMMON
 	select NFS_ACL_SUPPORT if NFS_V3_ACL
 	help
@@ -194,11 +195,10 @@ config NFS_USE_KERNEL_DNS
 	default y
 
 config NFS_DEBUG
 	bool
 	depends on NFS_FS && SUNRPC_DEBUG
-	select CRC32
 	default y
 
 config NFS_DISABLE_UDP_SUPPORT
        bool "NFS: Disable NFS UDP protocol support"
        depends on NFS_FS
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 1ac1d3eec517..0d6eb632dfcf 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -897,22 +897,15 @@ static inline
 u64 nfs_timespec_to_change_attr(const struct timespec64 *ts)
 {
 	return ((u64)ts->tv_sec << 30) + ts->tv_nsec;
 }
 
-#ifdef CONFIG_CRC32
 static inline u32 nfs_stateid_hash(const nfs4_stateid *stateid)
 {
 	return ~crc32_le(0xFFFFFFFF, &stateid->other[0],
 				NFS4_STATEID_OTHER_SIZE);
 }
-#else
-static inline u32 nfs_stateid_hash(nfs4_stateid *stateid)
-{
-	return 0;
-}
-#endif
 
 static inline bool nfs_error_is_fatal(int err)
 {
 	switch (err) {
 	case -ERESTARTSYS:
diff --git a/fs/nfs/nfs4session.h b/fs/nfs/nfs4session.h
index 351616c61df5..f9c291e2165c 100644
--- a/fs/nfs/nfs4session.h
+++ b/fs/nfs/nfs4session.h
@@ -146,20 +146,16 @@ static inline void nfs4_copy_sessionid(struct nfs4_sessionid *dst,
 		const struct nfs4_sessionid *src)
 {
 	memcpy(dst->data, src->data, NFS4_MAX_SESSIONID_LEN);
 }
 
-#ifdef CONFIG_CRC32
 /*
  * nfs_session_id_hash - calculate the crc32 hash for the session id
  * @session - pointer to session
  */
 #define nfs_session_id_hash(sess_id) \
 	(~crc32_le(0xFFFFFFFF, &(sess_id)->data[0], sizeof((sess_id)->data)))
-#else
-#define nfs_session_id_hash(session) (0)
-#endif
 #else /* defined(CONFIG_NFS_V4_1) */
 
 static inline int nfs4_init_session(struct nfs_client *clp)
 {
 	return 0;
diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 792d3fed1b45..731a88f6313e 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -2,10 +2,11 @@
 config NFSD
 	tristate "NFS server support"
 	depends on INET
 	depends on FILE_LOCKING
 	depends on FSNOTIFY
+	select CRC32
 	select LOCKD
 	select SUNRPC
 	select EXPORTFS
 	select NFS_COMMON
 	select NFS_ACL_SUPPORT if NFSD_V2_ACL
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 876152a91f12..5103c2f4d225 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -265,11 +265,10 @@ static inline bool fh_fsid_match(const struct knfsd_fh *fh1,
 	if (memcmp(fh1->fh_fsid, fh2->fh_fsid, key_len(fh1->fh_fsid_type)) != 0)
 		return false;
 	return true;
 }
 
-#ifdef CONFIG_CRC32
 /**
  * knfsd_fh_hash - calculate the crc32 hash for the filehandle
  * @fh - pointer to filehandle
  *
  * returns a crc32 hash for the filehandle that is compatible with
@@ -277,16 +276,10 @@ static inline bool fh_fsid_match(const struct knfsd_fh *fh1,
  */
 static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
 {
 	return ~crc32_le(0xFFFFFFFF, fh->fh_raw, fh->fh_size);
 }
-#else
-static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
-{
-	return 0;
-}
-#endif
 
 /**
  * fh_clear_pre_post_attrs - Reset pre/post attributes
  * @fhp: file handle to be updated
  *
diff --git a/include/linux/nfs.h b/include/linux/nfs.h
index 9ad727ddfedb..0906a0b40c6a 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -53,11 +53,10 @@ enum nfs3_stable_how {
 
 	/* used by direct.c to mark verf as invalid */
 	NFS_INVALID_STABLE_HOW = -1
 };
 
-#ifdef CONFIG_CRC32
 /**
  * nfs_fhandle_hash - calculate the crc32 hash for the filehandle
  * @fh - pointer to filehandle
  *
  * returns a crc32 hash for the filehandle that is compatible with
@@ -65,12 +64,6 @@ enum nfs3_stable_how {
  */
 static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
 {
 	return ~crc32_le(0xFFFFFFFF, &fh->data[0], fh->size);
 }
-#else /* CONFIG_CRC32 */
-static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
-{
-	return 0;
-}
-#endif /* CONFIG_CRC32 */
 #endif /* _LINUX_NFS_H */

base-commit: 91e5bfe317d8f8471fbaa3e70cf66cae1314a516
-- 
2.49.0


