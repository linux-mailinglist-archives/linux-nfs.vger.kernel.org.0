Return-Path: <linux-nfs+bounces-11417-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAC3AA827D
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 22:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D7717E4FE
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 20:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D449280CF5;
	Sat,  3 May 2025 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLYSPmWd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457EE280CE7;
	Sat,  3 May 2025 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746302390; cv=none; b=QkkcCj0QEt3HUswFL0oVBnqxAbGx0Ug3Or66a/TYIQOFUrdacGC7t20H1y+eeTOWT1x4hiT863PpgEbI4Xn4/ge6utpKCSKrqFXWoXmzKo/Fevr8hUzAuBdbwQk6coNRqOcObOY9A4kHasSN5/HUcH/Xh2Y85CUPConMDG9LwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746302390; c=relaxed/simple;
	bh=KMY3BOjFTILPTpVm7oEa9ID80RUxMf6Ju5Mms7cyin8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fa7FR4VIrPjoFOi5q9nmHC06a96q2RkgaeMGdPUVxOtSjk8CcZN+BrI7LWIb/0L/gDtnaXoTN6SIxRuud+BHhhW+ob+Gzv9KFdj262eth8T3rdHAmyvVxv3YnKpyvCmL5wtXGh/BsjGUPPMc1T4wvefIJ4VH16JbGM48Uo89zvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLYSPmWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C0BC4CEE9;
	Sat,  3 May 2025 19:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746302389;
	bh=KMY3BOjFTILPTpVm7oEa9ID80RUxMf6Ju5Mms7cyin8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BLYSPmWdg/uvfmuP9RKAnLUn2WzU4kZQCZzu5kvFLczp2q9CdM0mDlPYLJ0KObu1B
	 HoVMFwz8wChYfP71NIxYsKsc0gcXxwdMiIfZO8eGlEgZ0rO56xWnbpb4Q52CzWQNnF
	 DJdjYpollelvccFDnhJPfXdfMUCo5olJkO3+RehIfxoVcdNP/oZ8gr5mXbY+/3QxD3
	 CbSyQjy6riyKbZ2+nMAwe5X4u2N5M8eUPtn6o7Vy1axd1dAeM3ttbAQ1O2wFIJrbkv
	 /aQlEw3knLarWGd6bXeS3LNsDl9hZwdvJ3KsbEaLnVhcKu2V8B8WWkxCl9ySxI815n
	 NLFOnjsgQN2kQ==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: sargun@sargun.me,
	<linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 09/18] nfsd: add tracepoint to nfsd_rename
Date: Sat,  3 May 2025 15:59:27 -0400
Message-ID: <20250503195936.5083-10-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503195936.5083-1-cel@kernel.org>
References: <20250503195936.5083-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

Observe the start of RENAME operations for all NFS versions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h | 31 +++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c   |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index e96585546d01..46091d7f2260 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2522,6 +2522,37 @@ TRACE_EVENT(nfsd_vfs_unlink,
 	)
 );
 
+TRACE_EVENT(nfsd_vfs_rename,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct svc_fh *sfhp,
+		const struct svc_fh *tfhp,
+		const char *source,
+		unsigned int sourcelen,
+		const char *target,
+		unsigned int targetlen
+	),
+	TP_ARGS(rqstp, sfhp, tfhp, source, sourcelen, target, targetlen),
+	TP_STRUCT__entry(
+		NFSD_TRACE_PROC_CALL_FIELDS(rqstp)
+		__field(u32, sfh_hash)
+		__field(u32, tfh_hash)
+		__string_len(source, source, sourcelen)
+		__string_len(target, target, targetlen)
+	),
+	TP_fast_assign(
+		NFSD_TRACE_PROC_CALL_ASSIGNMENTS(rqstp);
+		__entry->sfh_hash = knfsd_fh_hash(&sfhp->fh_handle);
+		__entry->tfh_hash = knfsd_fh_hash(&tfhp->fh_handle);
+		__assign_str(source);
+		__assign_str(target);
+	),
+	TP_printk("xid=0x%08x sfh_hash=0x%08x tfh_hash=0x%08x source=%s target=%s",
+		__entry->xid, __entry->sfh_hash, __entry->tfh_hash,
+		__get_str(source), __get_str(target)
+	)
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 820290e5328f..41314b2a8199 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1840,6 +1840,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	int		host_err;
 	bool		close_cached = false;
 
+	trace_nfsd_vfs_rename(rqstp, ffhp, tfhp, fname, flen, tname, tlen);
+
 	err = fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_REMOVE);
 	if (err)
 		goto out;
-- 
2.49.0


