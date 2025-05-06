Return-Path: <linux-nfs+bounces-11537-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6A4AACF21
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 22:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9F9983845
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 20:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E55B1A256B;
	Tue,  6 May 2025 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLC6OPm1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C9D192D97;
	Tue,  6 May 2025 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746565108; cv=none; b=pjDoi1uM7mOOCc/YDft7ibDfAEU5Trnl+vp8bMXPRMH2gDTO2LLViNbdaLZ0+mjrlJX5HStVdLMPuVj3eZuaAoHaGlka1u7Ch1jPA5I5XuYuRU08VGuosl8KFj51v3X7hiq5yVroOIXFSVocpnkvt3W81dt3Nn6LmYQkCEjsDKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746565108; c=relaxed/simple;
	bh=4MJdmu2/9mzLIGHSnCNkfggi3H4p+mI6NxWvDR7pXIA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PK7mpV9XuVEtYNBTPq+alp2cNlnXo6aYimdfWmaGriGzUxga4rQ1dcr1wK6ZA4wla7k7SMD/0r9siTi/QNhGmI+nbLxctJja7JPHjDT6OfI+gLaYh8ns1BPLVvcnCIDwen4fdf/ORn7J3mtIGfp5AZmZEwnpS6yWXntFTlslhhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLC6OPm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E35FC4CEE4;
	Tue,  6 May 2025 20:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746565106;
	bh=4MJdmu2/9mzLIGHSnCNkfggi3H4p+mI6NxWvDR7pXIA=;
	h=Date:From:To:Cc:Subject:From;
	b=OLC6OPm18yQuxU0vh7rnffrP1+05W9PgdONdh1+HOVPlNYipnT5yAzLI5Dgmsim6n
	 eUQybGPQS9cQxzmlQ0/be2h0VL4zUpQFq8obtMBQW8rcanmRUtojAicQfXFjS9XMVn
	 Vtb67S5lzxTBKEqNfC7A3Khv1nASEdTIEDbTZF9jWcT8IjmmbbTF+NYc+pFRO51/gw
	 MLh10+IdWjym74HR1ln+2T45H5WTzjfmXeZEzUo73mj7kqHVSKjYvoQSzZYZLJxZE7
	 j+hf/10hovEMs/5CTJrdXdqEgviHYELr3J/GnvJnL2lcc5GHlglZ9GzjI42+1awIsF
	 O3/M48+L/wP7A==
Date: Tue, 6 May 2025 14:58:21 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] NFSD: Avoid multiple -Wflex-array-member-not-at-end
 warnings
Message-ID: <aBp37ZXBJM09yAXp@kspp>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declaration to the end of the corresponding
structures. Notice that `struct knfsd_fh` is a flexible structure --a
structure that contains a flexible-array member.

Fix the following warnings:

fs/nfsd/nfsfh.h:79:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/nfsd/state.h:763:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/nfsd/state.h:669:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/nfsd/state.h:549:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/nfsd/xdr4.h:705:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/nfsd/xdr4.h:678:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/nfsd/nfsfh.h |  4 +++-
 fs/nfsd/state.h | 12 +++++++++---
 fs/nfsd/xdr4.h  |  8 ++++++--
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 5103c2f4d225..bbee43674a2a 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -76,7 +76,6 @@ static inline ino_t u32_to_ino_t(__u32 uino)
  * pre_mtime/post_version will be used to support wcc_attr's in NFSv3.
  */
 typedef struct svc_fh {
-	struct knfsd_fh		fh_handle;	/* FH data */
 	int			fh_maxsize;	/* max size for fh_handle */
 	struct dentry *		fh_dentry;	/* validated dentry */
 	struct svc_export *	fh_export;	/* export pointer */
@@ -107,6 +106,9 @@ typedef struct svc_fh {
 	/* Post-op attributes saved in fh_fill_post_attrs() */
 	struct kstat		fh_post_attr;	/* full attrs after operation */
 	u64			fh_post_change; /* nfsv4 change; see above */
+
+	/* Must be last -ends in a flexible-array member. */
+	struct knfsd_fh		fh_handle;	/* FH data */
 } svc_fh;
 #define NFSD4_FH_FOREIGN (1<<0)
 #define SET_FH_FLAG(c, f) ((c)->fh_flags |= (f))
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 1995bca158b8..ffd3fd8c34a0 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -546,9 +546,11 @@ struct nfs4_replay {
 	__be32			rp_status;
 	unsigned int		rp_buflen;
 	char			*rp_buf;
-	struct knfsd_fh		rp_openfh;
 	int			rp_locked;
 	char			rp_ibuf[NFSD4_REPLAY_ISIZE];
+
+	/* Must be last -ends in a flexible-array member. */
+	struct knfsd_fh		rp_openfh;
 };
 
 struct nfs4_stateowner;
@@ -666,12 +668,14 @@ struct nfs4_file {
 	u32			fi_share_deny;
 	struct nfsd_file	*fi_deleg_file;
 	int			fi_delegees;
-	struct knfsd_fh		fi_fhandle;
 	bool			fi_had_conflict;
 #ifdef CONFIG_NFSD_PNFS
 	struct list_head	fi_lo_states;
 	atomic_t		fi_lo_recalls;
 #endif
+
+	/* Must be last -ends in a flexible-array member. */
+	struct knfsd_fh		fi_fhandle;
 };
 
 /*
@@ -760,9 +764,11 @@ struct nfsd4_blocked_lock {
 	struct list_head	nbl_lru;
 	time64_t		nbl_time;
 	struct file_lock	nbl_lock;
-	struct knfsd_fh		nbl_fh;
 	struct nfsd4_callback	nbl_cb;
 	struct kref		nbl_kref;
+
+	/* Must be last -ends in a flexible-array member. */
+	struct knfsd_fh		nbl_fh;
 };
 
 struct nfsd4_compound_state;
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index aa2a356da784..e453ea5ebab6 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -675,11 +675,13 @@ struct nfsd4_cb_offload {
 	struct nfsd42_write_res	co_res;
 	__be32			co_nfserr;
 	unsigned int		co_retries;
-	struct knfsd_fh		co_fh;
 
 	struct nfs4_sessionid	co_referring_sessionid;
 	u32			co_referring_slotid;
 	u32			co_referring_seqno;
+
+	/* Must be last -ends in a flexible-array member. */
+	struct knfsd_fh		co_fh;
 };
 
 struct nfsd4_copy {
@@ -702,7 +704,6 @@ struct nfsd4_copy {
 	/* response */
 	__be32			nfserr;
 	struct nfsd42_write_res	cp_res;
-	struct knfsd_fh		fh;
 
 	/* offload callback */
 	struct nfsd4_cb_offload	cp_cb_offload;
@@ -723,6 +724,9 @@ struct nfsd4_copy {
 	struct nfs_fh		c_fh;
 	nfs4_stateid		stateid;
 	struct nfsd_net		*cp_nn;
+
+	/* Must be last -ends in a flexible-array member. */
+	struct knfsd_fh		fh;
 };
 
 static inline void nfsd4_copy_set_sync(struct nfsd4_copy *copy, bool sync)
-- 
2.43.0


