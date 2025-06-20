Return-Path: <linux-nfs+bounces-12594-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F678AE1AFA
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 14:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F6B67A6237
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 12:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D706028468D;
	Fri, 20 Jun 2025 12:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTNMLn+E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A16257AF2
	for <linux-nfs@vger.kernel.org>; Fri, 20 Jun 2025 12:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750422721; cv=none; b=NbU7p9GDaFBotO9YIF7bX7e/8Gk1/2juXmAvQ/YGM6aIZZBwe2tcyPbyewCKB3/7mXy0GrxmJbv/OIrAIp7MdwfuRYAUxTsojbfWmDWxva2qTSVgrd32ofCC1GlJ5J8vVzJ5K4Tzt0R0Rgmz1Yj6Ciq82fPio5KWwDJfqrJsork=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750422721; c=relaxed/simple;
	bh=dv2PcmUU+S8lSpMmj6+iDFjIgA3lhAXe4eWAGi4zsck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNcmgZmhWed4xg+s0f+JoQmTFMA6IHHf8FeyjMNiK74AbIL8n9t5n1naqj4+EuiffT5Bwk+O+ASBzccLQq7djFRPSdBqOolnqp0NA3uOf324tBuETt3lnU80pOOe5VxjcyqPZqVkBOTPu1rX17rdmN/RxpaCRcuZQX1Hq6Ruyuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTNMLn+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D37C4CEEE;
	Fri, 20 Jun 2025 12:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750422721;
	bh=dv2PcmUU+S8lSpMmj6+iDFjIgA3lhAXe4eWAGi4zsck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PTNMLn+ELibtDCyl0WzTXJcO8UPgsZYkrd0CLw1l8xdNC8TSd6wIYJcKqlyjmiRDQ
	 Mfc2QvidXjZbxee8eIjF8ACd+rfN8QMNyCyI/nu3RE7wGuAC7FjR409DCdmwWTfmfg
	 yXrzV2/5sp72lWsvahca8NlBHF62CN/6nnyltlqC+YawaEb4zWawdgEEE8ra+nSkNR
	 ZRo7q5yAgaqerwLN2pTnrd0Yh/sCDh1UJBRGufF5N2/oj3Vg4kFPYdDW+wQoj9ZgPh
	 ImUImQUeBwxVWudxgjf5i3eUyaxri+JOlGVgSQQCUjhTQWiHqUL4qTh/6uROfs0Zq/
	 9JUynGGBB92KQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 1/2] NFSD: Access a knfsd_fh's fsid by pointer
Date: Fri, 20 Jun 2025 08:31:54 -0400
Message-ID: <20250620123155.271392-2-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620123155.271392-1-cel@kernel.org>
References: <20250620123155.271392-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I'm about to remove the union in struct knfsd_fh. First step is to
add an accessor function for the file handle's fsid portion.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4layouts.c |  4 ++--
 fs/nfsd/nfsfh.c       | 16 +++++++++-------
 fs/nfsd/nfsfh.h       | 11 +++++++++--
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 290271ac4245..aea905fcaf87 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -65,7 +65,7 @@ nfsd4_alloc_devid_map(const struct svc_fh *fhp)
 		return;
 
 	map->fsid_type = fh->fh_fsid_type;
-	memcpy(&map->fsid, fh->fh_fsid, fsid_len);
+	memcpy(&map->fsid, fh_fsid(fh), fsid_len);
 
 	spin_lock(&nfsd_devid_lock);
 	if (fhp->fh_export->ex_devid_map)
@@ -75,7 +75,7 @@ nfsd4_alloc_devid_map(const struct svc_fh *fhp)
 		list_for_each_entry(old, &nfsd_devid_hash[i], hash) {
 			if (old->fsid_type != fh->fh_fsid_type)
 				continue;
-			if (memcmp(old->fsid, fh->fh_fsid,
+			if (memcmp(old->fsid, fh_fsid(fh),
 					key_len(old->fsid_type)))
 				continue;
 
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index aef474f1b84b..4565112d0324 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -172,6 +172,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 	if (len == 0)
 		return error;
 	if (fh->fh_fsid_type == FSID_MAJOR_MINOR) {
+		u32 *fsid = fh_fsid(fh);
+
 		/* deprecated, convert to type 3 */
 		len = key_len(FSID_ENCODE_DEV)/4;
 		fh->fh_fsid_type = FSID_ENCODE_DEV;
@@ -181,17 +183,17 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 		 * confuses sparse, so we must use __force here to
 		 * keep it from complaining.
 		 */
-		fh->fh_fsid[0] = new_encode_dev(MKDEV(ntohl((__force __be32)fh->fh_fsid[0]),
-						      ntohl((__force __be32)fh->fh_fsid[1])));
-		fh->fh_fsid[1] = fh->fh_fsid[2];
+		fsid[0] = new_encode_dev(MKDEV(ntohl((__force __be32)fsid[0]),
+						      ntohl((__force __be32)fsid[1])));
+		fsid[1] = fsid[2];
 	}
 	data_left -= len;
 	if (data_left < 0)
 		return error;
 	exp = rqst_exp_find(rqstp ? &rqstp->rq_chandle : NULL,
 			    net, client, gssclient,
-			    fh->fh_fsid_type, fh->fh_fsid);
-	fid = (struct fid *)(fh->fh_fsid + len);
+			    fh->fh_fsid_type, fh_fsid(fh));
+	fid = (struct fid *)(fh_fsid(fh) + len);
 
 	error = nfserr_stale;
 	if (IS_ERR(exp)) {
@@ -463,7 +465,7 @@ static void _fh_update(struct svc_fh *fhp, struct svc_export *exp,
 {
 	if (dentry != exp->ex_path.dentry) {
 		struct fid *fid = (struct fid *)
-			(fhp->fh_handle.fh_fsid + fhp->fh_handle.fh_size/4 - 1);
+			(fh_fsid(&fhp->fh_handle) + fhp->fh_handle.fh_size/4 - 1);
 		int maxsize = (fhp->fh_maxsize - fhp->fh_handle.fh_size)/4;
 		int fh_flags = (exp->ex_flags & NFSEXP_NOSUBTREECHECK) ? 0 :
 				EXPORT_FH_CONNECTABLE;
@@ -614,7 +616,7 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
 	fhp->fh_handle.fh_auth_type = 0;
 
 	mk_fsid(fhp->fh_handle.fh_fsid_type,
-		fhp->fh_handle.fh_fsid,
+		fh_fsid(&fhp->fh_handle),
 		ex_dev,
 		d_inode(exp->ex_path.dentry)->i_ino,
 		exp->ex_fsid, exp->ex_uuid);
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 760e77f3630b..4569b5950b55 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -56,11 +56,15 @@ struct knfsd_fh {
 			u8		fh_auth_type;	/* deprecated */
 			u8		fh_fsid_type;
 			u8		fh_fileid_type;
-			u32		fh_fsid[NFS4_FHSIZE / 4 - 1];
 		};
 	};
 };
 
+static inline u32 *fh_fsid(const struct knfsd_fh *fh)
+{
+	return (u32 *)&fh->fh_raw[4];
+}
+
 static inline __u32 ino_t_to_u32(ino_t ino)
 {
 	return (__u32) ino;
@@ -260,9 +264,12 @@ static inline bool fh_match(const struct knfsd_fh *fh1,
 static inline bool fh_fsid_match(const struct knfsd_fh *fh1,
 				 const struct knfsd_fh *fh2)
 {
+	u32 *fsid1 = fh_fsid(fh1);
+	u32 *fsid2 = fh_fsid(fh2);
+
 	if (fh1->fh_fsid_type != fh2->fh_fsid_type)
 		return false;
-	if (memcmp(fh1->fh_fsid, fh2->fh_fsid, key_len(fh1->fh_fsid_type)) != 0)
+	if (memcmp(fsid1, fsid2, key_len(fh1->fh_fsid_type)) != 0)
 		return false;
 	return true;
 }
-- 
2.49.0


