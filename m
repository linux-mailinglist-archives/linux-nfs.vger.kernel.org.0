Return-Path: <linux-nfs+bounces-20721-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LIkEnCY1WmG7wcAu9opvQ
	(envelope-from <linux-nfs+bounces-20721-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 01:51:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 977A43B58B1
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 01:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AFB9301E22E
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 23:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00FD387571;
	Tue,  7 Apr 2026 23:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7D2U68p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB8D387350
	for <linux-nfs@vger.kernel.org>; Tue,  7 Apr 2026 23:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775605849; cv=none; b=JCHSwRQ+xu6Ym4VQJSknJikAzrs36JqW6ACBc6+x+jVZh3ApiAq7mafBcc9C1YD7s7IYbqsLvMTqeC8qn85Gdoh+eGpIB4Rbu7NIDnMzY7l+jaqei5bvaH2VvGQ6F6SrWCLwSK/s7NY9Gt6cPdj1oNHlYkRhPg/cRFOUiTjQd1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775605849; c=relaxed/simple;
	bh=4B/5eMRrK/aB2AwxLI5b9eWHXAekIO6FpzhohAerXMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KppONf8ulwKRFoFX0UpVD67mRUO4A0NOQuMWEG2poM8MwJ4cDZz6CmJaiuQrm0Hpie+SCAbHsKT1fuUCzqK5Or+qzmC3TOQUjIXvQtlL9V5UnlhVEk+3UOUUdo8cKVKZYPRITRGAZyMOg9sGDyN0fMcuvovogQUYeLRDFbkuPtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F7D2U68p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775605847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/WZTR2g8g2aXYQwXXpU5thnheKhESKMSB24kGqjfjM=;
	b=F7D2U68phtrOUZ6gd3XbNd9ofpGDCaaNvTIFr2YX9gkmjSc8ihJ3SylMzClNCNc9W57ws1
	5/8/w2K1edw1mas6H4UQ+we47rRM2cSzMnATDjFsT2TD+wX/o6NiBaHL/2AIxaaO1FNEu3
	Y93Ijbh3B5eeNhn8/nUF8RXxAqlrgLk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-OLvZcdlnOm2Qsb3qqdShKQ-1; Tue,
 07 Apr 2026 19:50:44 -0400
X-MC-Unique: OLvZcdlnOm2Qsb3qqdShKQ-1
X-Mimecast-MFC-AGG-ID: OLvZcdlnOm2Qsb3qqdShKQ_1775605842
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C984195608B;
	Tue,  7 Apr 2026 23:50:42 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.80.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4ECA81955D84;
	Tue,  7 Apr 2026 23:50:41 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH 1/3] nfsd: update mtime/ctime on CLONE in presense of delegated attributes
Date: Tue,  7 Apr 2026 19:50:36 -0400
Message-ID: <20260407235038.55749-2-okorniev@redhat.com>
In-Reply-To: <20260407235038.55749-1-okorniev@redhat.com>
References: <20260407235038.55749-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20721-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[okorniev@redhat.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 977A43B58B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When delegated attributes are given on open the file is opened with NOCMTIME
and modifying operations do not update mtime/ctime as to not get out-of-sync
with the client's delegated view. However, for CLONE operation, the server
should update its view of mtime/ctime and reflect that in any GETATTR queries.

Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding WRITE_ATTRS delegation")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4proc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 99b44b6ec056..fb891e35ebe9 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1396,6 +1396,17 @@ nfsd4_verify_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	goto out;
 }
 
+static void nfsd_update_cmtime_attr(struct dentry *dentry)
+{
+	struct iattr attr = {
+		.ia_valid = ATTR_CTIME | ATTR_MTIME,
+	};
+
+	inode_lock(d_inode(dentry));
+	notify_change(&nop_mnt_idmap, dentry, &attr, NULL);
+	inode_unlock(d_inode(dentry));
+}
+
 static __be32
 nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
@@ -1413,6 +1424,9 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			dst, clone->cl_dst_pos, clone->cl_count,
 			EX_ISSYNC(cstate->current_fh.fh_export));
 
+	if ((READ_ONCE(dst->nf_file->f_mode) & FMODE_NOCMTIME) != 0)
+		nfsd_update_cmtime_attr(cstate->current_fh.fh_dentry);
+
 	nfsd_file_put(dst);
 	nfsd_file_put(src);
 out:
-- 
2.52.0


