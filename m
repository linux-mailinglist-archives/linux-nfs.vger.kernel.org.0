Return-Path: <linux-nfs+bounces-11414-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF6FAA8277
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 22:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73525A4465
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 20:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ECE280307;
	Sat,  3 May 2025 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRSDwr1P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7610027FD5F;
	Sat,  3 May 2025 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746302387; cv=none; b=FKw1uZa1OtR4gOue0Viq2IWOtJl8DSH9JPd4GvypzAcoAlXzckjUc1w1vwQqSubxfEnjPdq/dka2Kc3H206d97sp4nVOHBKYQ9yotkWVeEFkT/8dx/L4shst64aMzzvPNk23kPYkQTrtttByPJJq70NOpTJmEGy+G0Rs9/sSisk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746302387; c=relaxed/simple;
	bh=Vd2V3yfktUNBWMDsQz5uQy2iqf4emXYgrGKyd09ytSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYiW3QP8kpjtQxt2QQ9He9lDS8pudLDCZOAiBH/kMBRH9DtFP806F6ImEUanjgolFrh2aRUIKLIDXeop51WmBIOSDfN5506JhdnTElrlS9dkJKTqJPaz+irvlgKbdPCO9A2ub/5WSYufmDHfZ8qWPEJQIrF57A4cAspNk9RbSHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRSDwr1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A810C4CEEE;
	Sat,  3 May 2025 19:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746302387;
	bh=Vd2V3yfktUNBWMDsQz5uQy2iqf4emXYgrGKyd09ytSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRSDwr1P6HRV8UoA5bBkwJkVnqohjGUAVqbxtzRBr1V/EYtV/29Baprq4UCsO3gwE
	 0uMJLvnml29hvTfTWybHmk5+idaD9BzFYtrFGG36PR+Ci7P8+MHDcOSeyoha5fra6X
	 FE9pvgPBo3GPWlwMloft4mpL1SFEdBNos7+nsyEVxgWDsqFqKy2L3pBsE5dW8xHELh
	 B5c/C8fi0Z/obEXfheJ6QXtq1Xm9SFbzEtcfuS/5U3wjuZkllhF7bAtNEn8sKC3Z9l
	 Qx7vlY9fP4T25Qh1WPCNjzqjx0Y3PgMuhI8WvI8oXFszrKfg0pffC2dJiWLDe34WcM
	 7cjr21xS+54Og==
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
Subject: [PATCH v4 06/18] nfsd: add tracepoint to nfsd_symlink
Date: Sat,  3 May 2025 15:59:24 -0400
Message-ID: <20250503195936.5083-7-cel@kernel.org>
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

Observe the start of SYMLINK operations for all NFS versions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h | 27 +++++++++++++++++++++++++++
 fs/nfsd/vfs.c   |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index a71d605fd7b7..e347cdaaa732 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2444,6 +2444,33 @@ TRACE_EVENT(nfsd_vfs_create,
 	)
 );
 
+TRACE_EVENT(nfsd_vfs_symlink,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct svc_fh *fhp,
+		const char *name,
+		unsigned int namelen,
+		const char *target
+	),
+	TP_ARGS(rqstp, fhp, name, namelen, target),
+	TP_STRUCT__entry(
+		NFSD_TRACE_PROC_CALL_FIELDS(rqstp)
+		__field(u32, fh_hash)
+		__string_len(name, name, namelen)
+		__string(target, target)
+	),
+	TP_fast_assign(
+		NFSD_TRACE_PROC_CALL_ASSIGNMENTS(rqstp);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__assign_str(name);
+		__assign_str(target);
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x name=%s target=%s",
+		__entry->xid, __entry->fh_hash,
+		__get_str(name), __get_str(target)
+	)
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index cc0efc47dc25..ecd453b260b6 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1651,6 +1651,8 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32		err, cerr;
 	int		host_err;
 
+	trace_nfsd_vfs_symlink(rqstp, fhp, fname, flen, path);
+
 	err = nfserr_noent;
 	if (!flen || path[0] == '\0')
 		goto out;
-- 
2.49.0


