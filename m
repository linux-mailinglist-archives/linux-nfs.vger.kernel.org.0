Return-Path: <linux-nfs+bounces-3859-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BC390A1B0
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F672813EC
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B923FEC;
	Mon, 17 Jun 2024 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmklTJc1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924CCEC2
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587510; cv=none; b=tQen2Ft3s6DvswyNWoZhAucVa31AV5EPUKsjCLEYK/RUrdkRkZ3l01nPkHhgEteL1qjaWV4g/4/6y1zDdtqpaKeT1LkMrPG36QzntG5gamQ4P5hIZUDHnVcZEGXGZognz6AjTJ9DwZwysjamr5ILHWFOculc9izn7bygR3IvONA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587510; c=relaxed/simple;
	bh=BvV5Hb9APOFgpfUn6Hn5ppnHLpVTENJNkhSyB0r+5dc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rm+6uTWLYcp5WwgjI8Ly/TpiLOCYFk2+twYSw1OgUocmZd8xVJxO9JuQg2xuz6bzdPOTMvg0Ea0kNd0hYWV+xRf87PSOQtZXAr30Lw2YLujgz/hy8lPvFjHclcYZlNqPnsaQso9gbYxNYLxD84Gz00/RgWLrVLQtBxI67V/qwY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmklTJc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D08C4AF1C
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718587510;
	bh=BvV5Hb9APOFgpfUn6Hn5ppnHLpVTENJNkhSyB0r+5dc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WmklTJc1ef3UEjFtXKSQZbhoVburKe5+zBgHEmQOIGeO32ZsJ/IAZDTX0DDBSczUr
	 qPBZJPaZoBr1UR1GKsUY+7PUUZ5NrQtPPIatxwtCPj8rV7cFAj6/9eYoX0LGo+QF/t
	 l5e9ZAYX76dqwwJRYK0Y7ywb+ojwVOwIqwSliFe6WUgx4JZy0AxcjClJ2XOf7xn0cb
	 nh0I387BCTpPqU4baNO90Qm6w/WjIoK30uSc7kCr7HV2kkdby07zJiYpnpRPiBcy0C
	 Xy1e+pfbRWFdMh3fWK+bcPkqwylcw6oboFP73bgSk6wDHYrMZ0T+b8C/lZYKN3Vlrd
	 4AEQaQdK7CfDw==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 01/19] NFSv4: Clean up open delegation return structure
Date: Sun, 16 Jun 2024 21:21:19 -0400
Message-ID: <20240617012137.674046-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617012137.674046-1-trondmy@kernel.org>
References: <20240617012137.674046-1-trondmy@kernel.org>
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c       | 30 ++++++++++++++++++------------
 fs/nfs/nfs4xdr.c        | 38 +++++++++++++++++++-------------------
 include/linux/nfs_xdr.h | 21 +++++++++++++++++----
 3 files changed, 54 insertions(+), 35 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a691fa10b3e9..7a74dc1bcfbd 100644
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


