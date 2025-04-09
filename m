Return-Path: <linux-nfs+bounces-11054-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E1BA827FA
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 16:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D34ED7B1250
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 14:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F572676E3;
	Wed,  9 Apr 2025 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCO4Q2fH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963E42676D9;
	Wed,  9 Apr 2025 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209186; cv=none; b=IQi3rb7rl7Fe4YB5vUPYFqq1jb1n2AKaI87jJWG5PNvAfxGoQo3bp6pic8ZRjiB8khgqPTzQfrbbkzGqW1fBFCaCcUez8EzVJNd2GIHp/fANg7Z63pCUdl0PtfyCkIrbFMyc8NMpg/Gm26JbtfQCDWUJkUSbu2bzC0CM2WP9JdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209186; c=relaxed/simple;
	bh=/KOiVKP/mQmiuytCVVn5ylF3FHBWBCxPKil6kEIiXok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kLocWwsyn8A+o6CTMP+mVUTNpCqUAqc/V9um2wLtMDHYCNgAJeqnxNBtz9CnC9A7LnjzF9OKUejUH+M+TFxhdxYdMCjprnb+ryxToAmVHXyC9O0dSiDTBYPXSQBaY1n9uCJIxWb0mfildYdm+UlqFtmBABzY/oMFA5iiWF0UpaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCO4Q2fH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B3DC4CEE9;
	Wed,  9 Apr 2025 14:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744209186;
	bh=/KOiVKP/mQmiuytCVVn5ylF3FHBWBCxPKil6kEIiXok=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kCO4Q2fHYQBSPh9tk8oehxKKXEMBsfF0dSH+ctRcrJJu8FzTiFWOvPBNBHA7N8tIp
	 Vy0qBbibv+qmnHSsAZ7hzy6viQfROpjjePa5lLqdHsczzVLhbOFuhxAlXWcbbrwP80
	 UNbK/iyyzTz+ILk+1RYPiFxLt0IjyTGrSrXpNg2/05+QIDdDs5edV6Xcw5mkJQ3dnJ
	 XPJVhNOjHjNJv4ezUn0q4rIW1uliQBDXp9ed2xlY71hnNUxhBaPS4vxNDkQu7yIfr3
	 vX/LWFJiv21fKmo2ZuTJaF/+/4Djgx2lMulshrEqWDlOta+ytZe9hZtrZimQxTRAMM
	 sXGbmw8uypQPg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 09 Apr 2025 10:32:27 -0400
Subject: [PATCH v2 05/12] nfsd: add a tracepoint to nfsd_lookup_dentry
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-nfsd-tracepoints-v2-5-cf4e084fdd9c@kernel.org>
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
In-Reply-To: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/KOiVKP/mQmiuytCVVn5ylF3FHBWBCxPKil6kEIiXok=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn9oUaxPLdpG5t52q2LscinJDLxW04SnJkdNZc0
 v5U98KSE+CJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/aFGgAKCRAADmhBGVaC
 Fb+BD/4sa+W5ImWyE5XuqzRwNT1M3A92I6DMhGpSLDEkHZwGTm1f9rRN35wzOcCRsgbbU6OMxCa
 2s87TjJZpPVBdrlj9KtMAMl4MXkvDdkG+/5UbF2NxpKLLHUFWPru+feS3oWkW1ET5LgJCq5S2TI
 o0DcwT0fhfYbnZRxit2YXUTQrz0R5pOucdQfHlDjFEDkdFbu31Oi24fxORYH6XlwK8+4pHfs9O2
 O8xAN3p/8+PS80/Di6R27RPFWepjBy+ke1JyT3/3CgcKKzl+zVRbV2QzLLzp1ECDjwSGC/PRZmF
 /uZg+JT1dj0W8yP3RbVzHNMFO9cpi7/8azsgiM5HGMUslH9mHZUtBfRISJCP66BDHcADemnEf+w
 WI20ZEJ6OGQ7tjFS1ZZo0+VFMR7UDOTa3plBfQI3VFBmBnT0WlTKUeFeH1slPjmzlJK5IN3aPrZ
 ABidft9vbmMfxmILEUtKsPdi7TshmP5yXsVbx7gqz34Nz5FospzU99gFsmHsQu295DknWvG4E09
 rU2nohWhcB1Y9AbXBzn/1q8wuhrggLK6eLjRzfJUACKZVzGm5aF3UMvk1m6Gn0ZCcdXWKferkBs
 Uct6g2ALDq7/bOssfsETR5lKO2A96mCwKPPJT8LBcn5OC7l+e/Bc+RUqunS/tMV/jYXbq94zjiX
 iLGm/wIgwMxIb4w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

...and drop the dprintk.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/trace.h | 19 +++++++++++++++++++
 fs/nfsd/vfs.c   |  2 +-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index c496fed58e2eed15458f35a158fbfef39a972c55..382849d7c321d6ded8213890c2e7075770aa716c 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2372,6 +2372,25 @@ TRACE_EVENT(nfsd_setattr,
 	)
 )
 
+TRACE_EVENT(nfsd_lookup_dentry,
+	TP_PROTO(struct svc_rqst *rqstp,
+		 struct svc_fh *fhp,
+		 const char *name,
+		 unsigned int len),
+	TP_ARGS(rqstp, fhp, name, len),
+	TP_STRUCT__entry(
+		SVC_RQST_ENDPOINT_FIELDS(rqstp)
+		__field(u32, fh_hash)
+		__string_len(name, name, len)
+	),
+	TP_fast_assign(
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__assign_str(name);
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x name=%s",
+		  __entry->xid, __entry->fh_hash, __get_str(name))
+);
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 77ae22abc1a21ec587cf089b2a5f750464b5e985..2b96806111d6a45b351707db6a93219cb91d45f5 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -246,7 +246,7 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct dentry		*dentry;
 	int			host_err;
 
-	dprintk("nfsd: nfsd_lookup(fh %s, %.*s)\n", SVCFH_fmt(fhp), len,name);
+	trace_nfsd_lookup_dentry(rqstp, fhp, name, len);
 
 	dparent = fhp->fh_dentry;
 	exp = exp_get(fhp->fh_export);

-- 
2.49.0


