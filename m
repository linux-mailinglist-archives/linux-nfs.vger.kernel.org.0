Return-Path: <linux-nfs+bounces-20795-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGLjITXX12mDTggAu9opvQ
	(envelope-from <linux-nfs+bounces-20795-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 18:43:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8555A3CDC04
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 18:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9A9E3007B28
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Apr 2026 16:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED753DA7DD;
	Thu,  9 Apr 2026 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHRHATq1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B713E121E
	for <linux-nfs@vger.kernel.org>; Thu,  9 Apr 2026 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775753007; cv=none; b=u3qbb7J+Z1FY6+1b0AG1mVOVW+lOSuBq+TgqlMddAS1f7gu13zKEmskd/tx+s1r5Mq8UCDw728Wjt0oP/rc0E1JAFAVKjQXbeB5DizSPZut4Hxb4q945Z0SgNVA6F87B2QhWJ/i6puj8j5BUO94VUNuqx5rFKLYCsh6LQvsBAO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775753007; c=relaxed/simple;
	bh=02JnNT4O8X4ttWZ1pUBFVr5xe1Mzf1inumjDIMR0szA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osCOuQlkUmx7r+6iCHdqBCBIOWVQ+a+NJfS1OCNs8CVKYJFjTX349Ez1JjKWlEieCyO2MpVqhaDIdOzCzVf4xLfv6z++mZ8XD3UPyCockKeDzxwHsVcIrC9348emoNixtikGxw9/Jgmq/1TM7tKhhHMPXlhuZhCaGSjtLqvSBUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHRHATq1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775753005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXOXiEY0bzK2/rnDq9pFCOasvRp4KNFBzdxo4dd4KQQ=;
	b=HHRHATq1EVQkTIAd1DnHEcpoX5pYjXGhTamerPIkrORRQyk/PydwoYN6BC7PGTGlMLPMZ9
	aIQbOVyjWXONvPUoixHi68W2WIdu+466/H9AwVVvJGI/ZU7JIZGK6EVAxd4+0sBkXKxms+
	NlIVvLr7n5cIkcshii44qvCEZqEO/po=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-XxjpFxuDPo2cF4UHm1t_EA-1; Thu,
 09 Apr 2026 12:43:21 -0400
X-MC-Unique: XxjpFxuDPo2cF4UHm1t_EA-1
X-Mimecast-MFC-AGG-ID: XxjpFxuDPo2cF4UHm1t_EA_1775753000
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2CC719560B4;
	Thu,  9 Apr 2026 16:43:19 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.65.236])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A603D1801ACB;
	Thu,  9 Apr 2026 16:43:18 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH v3 1/2] nfsd: update mtime/ctime on CLONE in presense of delegated attributes
Date: Thu,  9 Apr 2026 12:43:15 -0400
Message-ID: <20260409164316.19748-2-okorniev@redhat.com>
In-Reply-To: <20260409164316.19748-1-okorniev@redhat.com>
References: <20260409164316.19748-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20795-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[okorniev@redhat.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8555A3CDC04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When delegated attributes are given on open, the file is opened with
NOCMTIME and modifying operations do not update mtime/ctime as to not get
out-of-sync with the client's delegated view. However, for CLONE operation,
the server should update its view of mtime/ctime and reflect that in any
GETATTR queries.

Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding WRITE_ATTRS delegation")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4proc.c  |  6 ++++++
 fs/nfsd/nfs4state.c | 14 +-------------
 fs/nfsd/state.h     | 16 ++++++++++++++++
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2797da8cc950..5091527a6dc7 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1403,6 +1403,9 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_clone *clone = &u->clone;
 	struct nfsd_file *src, *dst;
 	__be32 status;
+	struct iattr attr = {
+		.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_DELEG,
+	};
 
 	status = nfsd4_verify_copy(rqstp, cstate, &clone->cl_src_stateid, &src,
 				   &clone->cl_dst_stateid, &dst);
@@ -1413,6 +1416,9 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			dst, clone->cl_dst_pos, clone->cl_count,
 			EX_ISSYNC(cstate->current_fh.fh_export));
 
+	if ((READ_ONCE(dst->nf_file->f_mode) & FMODE_NOCMTIME) != 0 && !status)
+		nfsd_update_cmtime_attr(dst->nf_file, &attr);
+
 	nfsd_file_put(dst);
 	nfsd_file_put(src);
 out:
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c75d3940188c..553102da6f7d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1225,8 +1225,6 @@ static void put_deleg_file(struct nfs4_file *fp)
 static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct file *f)
 {
 	struct iattr ia = { .ia_valid = ATTR_ATIME | ATTR_CTIME | ATTR_MTIME | ATTR_DELEG };
-	struct inode *inode = file_inode(f);
-	int ret;
 
 	/* don't do anything if FMODE_NOCMTIME isn't set */
 	if ((READ_ONCE(f->f_mode) & FMODE_NOCMTIME) == 0)
@@ -1245,17 +1243,7 @@ static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct f
 		return;
 
 	/* Stamp everything to "now" */
-	inode_lock(inode);
-	ret = notify_change(&nop_mnt_idmap, f->f_path.dentry, &ia, NULL);
-	inode_unlock(inode);
-	if (ret) {
-		struct inode *inode = file_inode(f);
-
-		pr_notice_ratelimited("nfsd: Unable to update timestamps on inode %02x:%02x:%lu: %d\n",
-					MAJOR(inode->i_sb->s_dev),
-					MINOR(inode->i_sb->s_dev),
-					inode->i_ino, ret);
-	}
+	nfsd_update_cmtime_attr(f, &ia);
 }
 
 static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 811c148f36fc..683c305a8808 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -844,6 +844,22 @@ extern void nfsd4_shutdown_copy(struct nfs4_client *clp);
 void nfsd4_put_client(struct nfs4_client *clp);
 void nfsd4_async_copy_reaper(struct nfsd_net *nn);
 bool nfsd4_has_active_async_copies(struct nfs4_client *clp);
+static inline void nfsd_update_cmtime_attr(struct file *f,
+					   struct iattr *attr)
+{
+	int ret;
+	struct inode *inode = file_inode(f);
+
+	inode_lock(inode);
+	ret = notify_change(&nop_mnt_idmap, f->f_path.dentry, attr, NULL);
+	inode_unlock(inode);
+	if (ret)
+		pr_notice_ratelimited("nfsd: Unable to update timestamps on "
+				      "inode %02x:%02x:%lu: %d\n",
+				      MAJOR(inode->i_sb->s_dev),
+				      MINOR(inode->i_sb->s_dev),
+				      inode->i_ino, ret);
+}
 extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name,
 				struct xdr_netobj princhash, struct nfsd_net *nn);
 extern bool nfs4_has_reclaimed_state(struct xdr_netobj name, struct nfsd_net *nn);
-- 
2.52.0


