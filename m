Return-Path: <linux-nfs+bounces-11397-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 821F8AA8142
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 17:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F983B6817
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 15:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A8327BF88;
	Sat,  3 May 2025 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkzA6YY3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3DB27BF7E;
	Sat,  3 May 2025 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285112; cv=none; b=mDONobpxQK8s2BXDwCHW7Zj5QHHBgUeQA72ZZ43YlB8HgDIlP63EkQhdQR8P2gSE0mJtwG1rDBeaxoM/70vV7bP6C8tSeD1SCA6Ez5YBfOyj17w1Daduj6SVblvUcLkPJm+kuSWJ4nVuA31sBgBTCl84UD4thg/ozvQYNOtS5kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285112; c=relaxed/simple;
	bh=qDWqByR0drsyEO3uTrcoD6BDg3chsL7q6TLudUz9IEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DeEzpzytoXhWgt5g28/+tKFPoNANnLBLvukxTiBcfQXgcnEmUqZ9+GyhJ/2YFZOikkX81W0Rnsxwo3CfmciIPLUR47fbA4X11Uuk6GFUegMLh9TiGY/c3dUNH16iZiu3pRylPVg5TBem2kOl91Kzqcs5FpNdsZ53Za8bfAFIYkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkzA6YY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDDCC4CEEE;
	Sat,  3 May 2025 15:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746285112;
	bh=qDWqByR0drsyEO3uTrcoD6BDg3chsL7q6TLudUz9IEk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FkzA6YY3gN7Lwjf77+7WMkdN5lQ5Kj+bYgFBTYy8lrUZlC4IpazvwI9X6QXby1e5K
	 abE/Ygks/f6j56CgIx+OSWaBnzMGIgcGg2392hlXR0N677f3lkad5Ox3uNa8k4ixdy
	 YrdxcUcMx3A6SIZClc+5XDezMDdBxXkQe8+NBMmeb2naRAb4ClhQ/NvIlqW/17UV7Z
	 8StFI2smEj4U6ruGuejoKgRKMPo9sEdYsHlhqhBe0Iea7Me2wUdpSzuPJWV2MCbt8S
	 rIg37QC1XCbnb54DRbGDIYOiK88fkyq94D7DNx98iKsbxnyMS5Z/0ZSqZ9TaWnYmqp
	 BlvYgu7FprheA==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 03 May 2025 11:11:23 -0400
Subject: [PATCH v3 07/17] nfsd: add tracepoints for unlink events
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-nfsd-tracepoints-v3-7-d89f445969af@kernel.org>
References: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
In-Reply-To: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1567; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qDWqByR0drsyEO3uTrcoD6BDg3chsL7q6TLudUz9IEk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoFjItvy7/AZW0YUPuu8/Eo8bF75gYN+Ixx4OIS
 AtY6g2mGnaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBYyLQAKCRAADmhBGVaC
 FbhSD/0TdUHL+r+FuUDyURtRngFed3fgWSZiqnJUmkXU0CFrOGGmL+9BxJprmfxkIpnyaCYkOTd
 F70mgcw0rsNeRVdysK8pvyHJfRjyRtz2dgeAKgPs2l5SVQ/YfMDDmYXIuE/ueZ8fVOj2Gk9mAnO
 Qp+h5e3i3AgZAOQXFgXAKWXY3hZz+o0Lw45HXBtNerBc8+N0o6OMV/SDLsS136hBhA2JhbpQgmN
 nsMVZz96u5M8mcA5H8g14c6GGAwzbylMi01BdOV8u/FyNcOgophZbRYpivOemP/HxbRzg8f3T33
 yvFBQbkF0pybbQCl7uiMTlS27bZI+EUce954rU9TCE/o+I0nl+Tc28y8sorOG+jaWVL0imofs/+
 Ga6ljzbFgl7lM/0GkfyTayY2zJWBZIvErJh4WwBOuMoLc3/O7Fkhg0Rzv7yVyXNkw97nmhVg/Bm
 nKpDemhUW9ux5YseMNn38iZBQIIPT7ZDqVlgIDcPkvWQ2ikEE4pPvJ1xHgXfKywf7egUEz9wn0o
 OmAHOX9fovzfccys8a4wt5A/+rROrSdXjM+LbWVmr5TudzwvMhydzVbUh2JZkvX6CK3FsJt99fM
 G6ZhD8hMi8ZdecKwTgj8rf5Fm065ygWC3eG9p/bd9JTF0LFBXV/I5hisrrohUDRS6Kbqir0Uln7
 oRQuCUN85SX+ryw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/trace.h | 21 +++++++++++++++++++++
 fs/nfsd/vfs.c   |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 17c09d8a52041205ff4edd47fbd4d31135e97f85..24e3c32d9db48bd8bf51eb41dda46b889dfa9e8d 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2463,6 +2463,27 @@ TRACE_EVENT(nfsd_vfs_link,
 		  __entry->xid, __entry->sfh_hash, __entry->tfh_hash,
 		  __get_str(name))
 );
+
+TRACE_EVENT(nfsd_vfs_unlink,
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
+		  __entry->xid, __entry->fh_hash,
+		  __get_str(name))
+);
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index d949860d2aac998efb1b74218d0657a73a0d3fc6..bd19e5926ef198279e39ac9ef1873eab289cb4a0 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2023,6 +2023,8 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	__be32		err;
 	int		host_err;
 
+	trace_nfsd_vfs_unlink(rqstp, fhp, fname, flen);
+
 	err = nfserr_acces;
 	if (!flen || isdotent(fname, flen))
 		goto out;

-- 
2.49.0


