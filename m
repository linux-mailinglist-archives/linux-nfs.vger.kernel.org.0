Return-Path: <linux-nfs+bounces-3710-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A4D9062FB
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 06:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2D92848B2
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 04:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF9A132106;
	Thu, 13 Jun 2024 04:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJFOAj4c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC6748E
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 04:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252263; cv=none; b=jehOrpqEYZoG/MLCIGT8DZK3GPGIhH2B1UJy62TY8aVRGkW57XRr2pq/ZHrGwTUwZKJ9HRdeLV13BWtvt0EqzA71bULGL/7iWekctzrXAPP7girdir4ADPMXQMXE5slqd4Lez0TRwrFmhxizdLZYSBXb0NT6sD9oIqTG/+HCCyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252263; c=relaxed/simple;
	bh=zFgjZOyt/SXgAeTpfzsKhYvfi+iqaDPzYgp46heNcjA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p25WkRs2scpCKojWlxlj88iBJomoDr4g2rb63WsUcbnN6E9OYXCsi9Bc7VHUySM0Q6NXI+r5qzuAScCYJQdH3xCwvLlWsNnAMaTxuyQR6uUj8pWFUPMFqhVetXA7djDjD0NbnAY69bfu4a7wg+IF6/THjShOERKfEmWDb3SF41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJFOAj4c; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b081c675e7so3452916d6.1
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 21:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252261; x=1718857061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKLqey/xWTmH19HOBt6Vgd09H4wIzu2YiNfsJFIAaAs=;
        b=JJFOAj4cLySQq57Qmn/J/i4vsR+0tn+GiX1S3VQjqr3GfBXdCIVfNrP8qP0qa7SRyS
         U6aCeCCmRskRcRR5W8jios+9Io4L/b65zCz6tBD/p0GYShAvIFrorAtuQ0kw4Y6RdxIx
         1tLDzGsj4By8D8KvKGBKFXI9GEXD3JKcaKC9n2yAnpXptxeo0NfxR7BJN2/lGhA6OkyV
         TO6CmS93w1JTCnoVr730qSVgir6wi3vaFqTYF0zBMM0PoUlUaeOt/ZkoUG8HR2Hyg/sy
         bSchbV9PT+OvB+sS5zgRTqAZM+TbFge8TKlUZUOfpUjAhaTx/Fuz9IAUasq37gOSZCvC
         KhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252261; x=1718857061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKLqey/xWTmH19HOBt6Vgd09H4wIzu2YiNfsJFIAaAs=;
        b=JRsuMthXSVSH8F3KCcpaKH3g3PaHAqYoW9Nv2NH0+Go0hDp5T1FwYREtwEUjuhlmS4
         JsG06AuzixFyHMOKP7YfdGP5g4NsA0OTRI5BhnogT1yZzH1ejSWrpGty9VbT51hMAFj7
         HKjnJR9s3V3+nLVkyRceERi4zIuQdDA7MfUNXk+XUbwYw4V6m3yDwjgdst7PEe1Y4HLP
         b3y/8ZiqnZuG9Jt0OKre5ZgUH3WiNg6MXpukQNL4HxZLXzWtoiI6EpEUMnyHLnO5zGf/
         uVSNJ3HjIallISSemzyRAf8L0s4nXGGvvG1yzQ2H00JPP7XDy/Ogz89fx5Zzbn9wt6Wi
         4bCQ==
X-Gm-Message-State: AOJu0Yx+WjgfPKHd9mnnFYBe1AIGKdShOgS50fB9z7uJ/PswUcNW7Mys
	gcn0y1gAs6hWJLPvB5/WwyQXmzu1D7WrbBepzfqcLDmt3XT/WP4uUrJV
X-Google-Smtp-Source: AGHT+IFNRIikYufSppK9L4Y21uWgDj6V2F7D3Rruc+5+tLp4SuxwXMJb3MlEgK+8qELupo9gSNcqCw==
X-Received: by 2002:a05:6214:4293:b0:6b0:6965:511 with SMTP id 6a1803df08f44-6b1910c198cmr43523636d6.7.1718252260404;
        Wed, 12 Jun 2024 21:17:40 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c68ff3sm2851546d6.74.2024.06.12.21.17.39
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:17:40 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 01/19] NFSv4: Clean up open delegation return structure
Date: Thu, 13 Jun 2024 00:11:18 -0400
Message-ID: <20240613041136.506908-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

Instead of having the fields open coded in the struct nfs_openres,
add a separate structure for them so that we can reuse that code
for the WANT_DELEGATION case.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c       | 30 ++++++++++++++++++------------
 fs/nfs/nfs4xdr.c        | 38 +++++++++++++++++++-------------------
 include/linux/nfs_xdr.h | 21 +++++++++++++++++----
 3 files changed, 54 insertions(+), 35 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 94c07875aa3f..d3781ce7e0a5 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1960,6 +1960,13 @@ nfs4_opendata_check_deleg(struct nfs4_opendata *data, struct nfs4_state *state)
 	struct nfs_delegation *delegation;
 	int delegation_flags = 0;
 
+	switch (data->o_res.delegation.open_delegation_type) {
+	case NFS4_OPEN_DELEGATE_READ:
+	case NFS4_OPEN_DELEGATE_WRITE:
+		break;
+	default:
+		return;
+	};
 	rcu_read_lock();
 	delegation = rcu_dereference(NFS_I(state->inode)->delegation);
 	if (delegation)
@@ -1979,19 +1986,19 @@ nfs4_opendata_check_deleg(struct nfs4_opendata *data, struct nfs4_state *state)
 	if ((delegation_flags & 1UL<<NFS_DELEGATION_NEED_RECLAIM) == 0)
 		nfs_inode_set_delegation(state->inode,
 				data->owner->so_cred,
-				data->o_res.delegation_type,
-				&data->o_res.delegation,
-				data->o_res.pagemod_limit);
+				data->o_res.delegation.type,
+				&data->o_res.delegation.stateid,
+				data->o_res.delegation.pagemod_limit);
 	else
 		nfs_inode_reclaim_delegation(state->inode,
 				data->owner->so_cred,
-				data->o_res.delegation_type,
-				&data->o_res.delegation,
-				data->o_res.pagemod_limit);
+				data->o_res.delegation.type,
+				&data->o_res.delegation.stateid,
+				data->o_res.delegation.pagemod_limit);
 
-	if (data->o_res.do_recall)
+	if (data->o_res.delegation.do_recall)
 		nfs_async_inode_return_delegation(state->inode,
-						  &data->o_res.delegation);
+						  &data->o_res.delegation.stateid);
 }
 
 /*
@@ -2015,8 +2022,7 @@ _nfs4_opendata_reclaim_to_nfs4_state(struct nfs4_opendata *data)
 	if (ret)
 		return ERR_PTR(ret);
 
-	if (data->o_res.delegation_type != 0)
-		nfs4_opendata_check_deleg(data, state);
+	nfs4_opendata_check_deleg(data, state);
 
 	if (!update_open_stateid(state, &data->o_res.stateid,
 				NULL, data->o_arg.fmode))
@@ -2083,7 +2089,7 @@ _nfs4_opendata_to_nfs4_state(struct nfs4_opendata *data)
 	if (IS_ERR(state))
 		goto out;
 
-	if (data->o_res.delegation_type != 0)
+	if (data->o_res.delegation.type != 0)
 		nfs4_opendata_check_deleg(data, state);
 	if (!update_open_stateid(state, &data->o_res.stateid,
 				NULL, data->o_arg.fmode)) {
@@ -3111,7 +3117,7 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 	case NFS4_OPEN_CLAIM_DELEGATE_PREV:
 		if (!opendata->rpc_done)
 			break;
-		if (opendata->o_res.delegation_type != 0)
+		if (opendata->o_res.delegation.type != 0)
 			dir_verifier = nfs_save_change_attribute(dir);
 		nfs_set_verifier(dentry, dir_verifier);
 	}
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 1416099dfcd1..119061da5298 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -5148,13 +5148,12 @@ static int decode_space_limit(struct xdr_stream *xdr,
 }
 
 static int decode_rw_delegation(struct xdr_stream *xdr,
-		uint32_t delegation_type,
-		struct nfs_openres *res)
+		struct nfs4_open_delegation *res)
 {
 	__be32 *p;
 	int status;
 
-	status = decode_delegation_stateid(xdr, &res->delegation);
+	status = decode_delegation_stateid(xdr, &res->stateid);
 	if (unlikely(status))
 		return status;
 	p = xdr_inline_decode(xdr, 4);
@@ -5162,52 +5161,53 @@ static int decode_rw_delegation(struct xdr_stream *xdr,
 		return -EIO;
 	res->do_recall = be32_to_cpup(p);
 
-	switch (delegation_type) {
+	switch (res->open_delegation_type) {
 	case NFS4_OPEN_DELEGATE_READ:
-		res->delegation_type = FMODE_READ;
+		res->type = FMODE_READ;
 		break;
 	case NFS4_OPEN_DELEGATE_WRITE:
-		res->delegation_type = FMODE_WRITE|FMODE_READ;
+		res->type = FMODE_WRITE|FMODE_READ;
 		if (decode_space_limit(xdr, &res->pagemod_limit) < 0)
 				return -EIO;
 	}
 	return decode_ace(xdr, NULL);
 }
 
-static int decode_no_delegation(struct xdr_stream *xdr, struct nfs_openres *res)
+static int decode_no_delegation(struct xdr_stream *xdr,
+		struct nfs4_open_delegation *res)
 {
 	__be32 *p;
-	uint32_t why_no_delegation;
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
 		return -EIO;
-	why_no_delegation = be32_to_cpup(p);
-	switch (why_no_delegation) {
+	res->why_no_delegation = be32_to_cpup(p);
+	switch (res->why_no_delegation) {
 		case WND4_CONTENTION:
 		case WND4_RESOURCE:
-			xdr_inline_decode(xdr, 4);
-			/* Ignore for now */
+			p = xdr_inline_decode(xdr, 4);
+			if (unlikely(!p))
+				return -EIO;
+			res->will_notify = be32_to_cpup(p);
 	}
 	return 0;
 }
 
-static int decode_delegation(struct xdr_stream *xdr, struct nfs_openres *res)
+static int decode_delegation(struct xdr_stream *xdr,
+		struct nfs4_open_delegation *res)
 {
 	__be32 *p;
-	uint32_t delegation_type;
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
 		return -EIO;
-	delegation_type = be32_to_cpup(p);
-	res->delegation_type = 0;
-	switch (delegation_type) {
+	res->open_delegation_type = be32_to_cpup(p);
+	switch (res->open_delegation_type) {
 	case NFS4_OPEN_DELEGATE_NONE:
 		return 0;
 	case NFS4_OPEN_DELEGATE_READ:
 	case NFS4_OPEN_DELEGATE_WRITE:
-		return decode_rw_delegation(xdr, delegation_type, res);
+		return decode_rw_delegation(xdr, res);
 	case NFS4_OPEN_DELEGATE_NONE_EXT:
 		return decode_no_delegation(xdr, res);
 	}
@@ -5248,7 +5248,7 @@ static int decode_open(struct xdr_stream *xdr, struct nfs_openres *res)
 	for (; i < NFS4_BITMAP_SIZE; i++)
 		res->attrset[i] = 0;
 
-	return decode_delegation(xdr, res);
+	return decode_delegation(xdr, &res->delegation);
 xdr_error:
 	dprintk("%s: Bitmap too large! Length = %u\n", __func__, bmlen);
 	return -EIO;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index d09b9773b20c..682559e19d9d 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -449,6 +449,22 @@ struct stateowner_id {
 	__u32	uniquifier;
 };
 
+struct nfs4_open_delegation {
+	__u32 open_delegation_type;
+	union {
+		struct {
+			fmode_t			type;
+			__u32			do_recall;
+			nfs4_stateid		stateid;
+			unsigned long		pagemod_limit;
+		};
+		struct {
+			__u32			why_no_delegation;
+			__u32			will_notify;
+		};
+	};
+};
+
 /*
  * Arguments to the open call.
  */
@@ -490,13 +506,10 @@ struct nfs_openres {
 	struct nfs_fattr *      f_attr;
 	struct nfs_seqid *	seqid;
 	const struct nfs_server *server;
-	fmode_t			delegation_type;
-	nfs4_stateid		delegation;
-	unsigned long		pagemod_limit;
-	__u32			do_recall;
 	__u32			attrset[NFS4_BITMAP_SIZE];
 	struct nfs4_string	*owner;
 	struct nfs4_string	*group_owner;
+	struct nfs4_open_delegation	delegation;
 	__u32			access_request;
 	__u32			access_supported;
 	__u32			access_result;
-- 
2.45.2


