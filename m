Return-Path: <linux-nfs+bounces-11416-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC8CAA827B
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 22:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B3777AE18D
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 20:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995A3280A58;
	Sat,  3 May 2025 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKKhCxsd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAF2280A52;
	Sat,  3 May 2025 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746302389; cv=none; b=Yg/9OnOSadQveCwNVDqBURGcUys8i05v170i0zaPkiHtHtDbVNrsT6/O2EqU7HdeNImBL467wLM6Y7E5eNOwFgnY8vXfQrKI6o4PrLEy88PrLqkfFhUhKD6ByzIu/xexXy+jfmBb8tQCe6/H44MF7d2l+LAHfEnRKmmy1L5mV1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746302389; c=relaxed/simple;
	bh=gSwF/HPRk47C+RY/8Zzaq52Y/XzIPBLZGy7m330tfxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqPDUSsv0vWfHW9oYYUU4vWs3415eH/yWsl/0jJSD0Dv6iyo+86lv42aIfd9D+R8BQ1C0HM6u5Ht4blFWGBuHkhAESwFRM61NnxvLUR1fMqgIMYWSRbNhkoltAVL2/QfV+NoCUDxKQ4u5RAZK7Qy90ySiWyrVK3avaiuMNGvgXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKKhCxsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21615C4CEEE;
	Sat,  3 May 2025 19:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746302388;
	bh=gSwF/HPRk47C+RY/8Zzaq52Y/XzIPBLZGy7m330tfxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eKKhCxsdQSTMAq8fwZPMhpP/NpBDpGu7PiOmZHDB7g8o3Kv84/i3K+m9JfSANixII
	 a5ldd4N4Pno+8L6tKKppDkRN/gcjTmR1EPvdMsqyOq4oWwC8M/Oi1QM8qEMCGKklNJ
	 N2gkZrQO4ahwS2gi/mAOEk7xNU7xr+Qk/iVMrhdbJbHXEf1JxU6rCu4znmZiQpndto
	 EnN+UepjrceCt1hvIBwX3TMCh76pVuZQaS1hWwFiepVwS4lLsFNDaoYg2Z9UHP2+x5
	 Q6G9rvo4jKGULkgxoFDP9tf41v+TlImKvP+LieNhbpXswzYKJpCYf3wL2Vg0IhrN+8
	 faEuRya0HZdZA==
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
Subject: [PATCH v4 08/18] nfsd: add tracepoints for unlink events
Date: Sat,  3 May 2025 15:59:26 -0400
Message-ID: <20250503195936.5083-9-cel@kernel.org>
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

Observe the start of UNLINK, REMOVE, and RMDIR operations for all
NFS versions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h | 24 ++++++++++++++++++++++++
 fs/nfsd/vfs.c   |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index acbf94cfb720..e96585546d01 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2498,6 +2498,30 @@ TRACE_EVENT(nfsd_vfs_link,
 	)
 );
 
+TRACE_EVENT(nfsd_vfs_unlink,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct svc_fh *fhp,
+		const char *name,
+		unsigned int len
+	),
+	TP_ARGS(rqstp, fhp, name, len),
+	TP_STRUCT__entry(
+		NFSD_TRACE_PROC_CALL_FIELDS(rqstp)
+		__field(u32, fh_hash)
+		__string_len(name, name, len)
+	),
+	TP_fast_assign(
+		NFSD_TRACE_PROC_CALL_ASSIGNMENTS(rqstp);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__assign_str(name);
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x name=%s",
+		__entry->xid, __entry->fh_hash,
+		__get_str(name)
+	)
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 30702f36db98..820290e5328f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1998,6 +1998,8 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	__be32		err;
 	int		host_err;
 
+	trace_nfsd_vfs_unlink(rqstp, fhp, fname, flen);
+
 	err = nfserr_acces;
 	if (!flen || isdotent(fname, flen))
 		goto out;
-- 
2.49.0


