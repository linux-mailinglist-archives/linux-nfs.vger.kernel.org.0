Return-Path: <linux-nfs+bounces-11415-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AFDAA8279
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 22:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4CF17E27A
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 20:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A189D28033D;
	Sat,  3 May 2025 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EH4Uj/mJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9EA280333;
	Sat,  3 May 2025 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746302388; cv=none; b=DBBt9QOtiiuyW6v7/ZlXovw+x1sWqU9nKVhzy+qpXcSZAdfMvOs0QYxKkBX0X0UrrBwpKvCuTFwPo/jad1xNhXH6EGoDc7DtCGjjCKp3qk8CduoFg6JPfKuAywGusMgZmvEDqrYre91vqun6CqQUw8bErCj6eEVkOYXs5wNJ0kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746302388; c=relaxed/simple;
	bh=u8MwXtZfnrSUjQkKdU1yXQ7CiwJtv2xi+V8+9cmp40Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/XzIw/d5mSHQgivOKpDV7dlLAf0eGFMwcdI36TFWOfYpZjYaE642oBdgN+DyYmg15hfkDmHNGvg6U2CiqoCY0EZRo1BWJJ/RTInMjW7tNMhOchdbG5dH5iWzNpK3me8Z/0dbrq0ZIb/+mcYBszjPDluhNzYSykVjqWbf1REELE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EH4Uj/mJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360F5C4CEE3;
	Sat,  3 May 2025 19:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746302387;
	bh=u8MwXtZfnrSUjQkKdU1yXQ7CiwJtv2xi+V8+9cmp40Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EH4Uj/mJvcs7VuKi2TU00jSH1vyozPpCACpEQiBrxsXyOnDctbSQKlZ50oMB0i3b+
	 sFsT0lVRrGpW3BgUPBI7CrVzMeDoMDvnB9n/M48+pcaxYJaciXX57Mo0V+mR6mYDjX
	 8I67nk3Ai2td8gaZ199vsm8malM1FSvpi/Jd1f5TzKM59Zxcd2SImEhnUMdC3HzugE
	 dz8+wSpQzDHNRe2tfAGeVPiUWkYp4E+Y64W3bi0+zfZNfaOUQJEGOKltFgyc/BCV9o
	 AlgwU/x9bkN4wIcOmhyzaVCm4C2vKkw7s47WHyq748Zq9y8KSkXxHEOM3G+gBq8q/L
	 iDc07OeZ8Ubvw==
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
Subject: [PATCH v4 07/18] nfsd: add tracepoint to nfsd_link()
Date: Sat,  3 May 2025 15:59:25 -0400
Message-ID: <20250503195936.5083-8-cel@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h | 27 +++++++++++++++++++++++++++
 fs/nfsd/vfs.c   |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index e347cdaaa732..acbf94cfb720 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2471,6 +2471,33 @@ TRACE_EVENT(nfsd_vfs_symlink,
 	)
 );
 
+TRACE_EVENT(nfsd_vfs_link,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct svc_fh *sfhp,
+		const struct svc_fh *tfhp,
+		const char *name,
+		unsigned int namelen
+	),
+	TP_ARGS(rqstp, sfhp, tfhp, name, namelen),
+	TP_STRUCT__entry(
+		NFSD_TRACE_PROC_CALL_FIELDS(rqstp)
+		__field(u32, sfh_hash)
+		__field(u32, tfh_hash)
+		__string_len(name, name, namelen)
+	),
+	TP_fast_assign(
+		NFSD_TRACE_PROC_CALL_ASSIGNMENTS(rqstp);
+		__entry->sfh_hash = knfsd_fh_hash(&sfhp->fh_handle);
+		__entry->tfh_hash = knfsd_fh_hash(&tfhp->fh_handle);
+		__assign_str(name);
+	),
+	TP_printk("xid=0x%08x src_fh=0x%08x tgt_fh=0x%08x name=%s",
+		__entry->xid, __entry->sfh_hash, __entry->tfh_hash,
+		__get_str(name)
+	)
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index ecd453b260b6..30702f36db98 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1721,6 +1721,8 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	__be32		err;
 	int		host_err;
 
+	trace_nfsd_vfs_link(rqstp, ffhp, tfhp, name, len);
+
 	err = fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_CREATE);
 	if (err)
 		goto out;
-- 
2.49.0


