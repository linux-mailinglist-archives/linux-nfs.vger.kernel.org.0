Return-Path: <linux-nfs+bounces-20722-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEAwElyY1WmG7wcAu9opvQ
	(envelope-from <linux-nfs+bounces-20722-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 01:50:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A2F3B58A1
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 01:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 187033004600
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 23:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E7138D6AA;
	Tue,  7 Apr 2026 23:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgrU0AFh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98916388E63
	for <linux-nfs@vger.kernel.org>; Tue,  7 Apr 2026 23:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775605849; cv=none; b=PLJlJHyOKX+qbpkViiAi4MbsuxMIm+VEBYmHyKjyAznsHPWis5AESMWbz3/T8jqKyuK6oLA16WwN+B/THJNMR80oP2wekKbBvQpu2ixQ1GovHGkFGapYDgCRTgiB4BOtk29qZy1Q61wuFxckdi3xDyiUKP744+hnsGa/ZNekn98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775605849; c=relaxed/simple;
	bh=UPyi4ki8RPs695kIs0WLeJfc5CVhWELlmT/08YoKw3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jetePvMawS21vBfRd6rH0SM5OBwVDXRAqnMnW5Wsz5c+h4AyVCkB3NQz8fIKg9bpxNI9UWIRYBbHoyI3FKvxnIHyjMAA6oDz0UdXjASSZ83YygZqaqfL+H2sWIr7CbqiPemlYKrCqX+M6Kw7psf4tlhUDwnyhaEkqxVWLP4p0EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FgrU0AFh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775605847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJn+7qO8Mj+w/C2lKW2WpIbL6/Bowh1/CgAWEHM1+UI=;
	b=FgrU0AFhN8URY1zneNW+2ZOkutFqJm3GJQaxd3XKNQmw9BOziLx8Vbz5jNDY7Jmc9FMePx
	zv9gMNLWZ0xqYUs8rx/qOE+kQ21DY6C2V0/yEKa18+MItfWbebuehS6dvYHlz/VVPgoy6x
	QY9MPtxye9N1vJ1RJamTnkdwEtUpb8w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-sHkvNSOTPdiBIWUCA-OpEg-1; Tue,
 07 Apr 2026 19:50:46 -0400
X-MC-Unique: sHkvNSOTPdiBIWUCA-OpEg-1
X-Mimecast-MFC-AGG-ID: sHkvNSOTPdiBIWUCA-OpEg_1775605845
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3486D180049D;
	Tue,  7 Apr 2026 23:50:45 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.80.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1DE311955D84;
	Tue,  7 Apr 2026 23:50:43 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH 3/3] nfsd: update mtime/ctime on asynchronous COPY with delegated attributes
Date: Tue,  7 Apr 2026 19:50:38 -0400
Message-ID: <20260407235038.55749-4-okorniev@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20722-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2A2F3B58A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Asynchronous COPY should update destination file's mtime/ctime upon
completion of copy work (not COPY compound processing).

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4proc.c | 21 ++++++++++++++++++++-
 fs/nfsd/xdr4.h     |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 04d8d0d1ca7d..d858a5b58a24 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2134,6 +2134,16 @@ static int nfsd4_do_async_copy(void *data)
 	trace_nfsd_copy_async_done(copy);
 	nfsd4_send_cb_offload(copy);
 	atomic_dec(&copy->cp_nn->pending_async_copies);
+	/* choosing to check for existence of set dentry pointer to indicate
+	 * that we need to update the attributes and do a dput because the
+	 * file flag could be cleared by a DELEGRETURN and then we'd lose
+	 * that copy was started with file opened with NOCMTIME and we gotten
+	 * a reference on the dentry.
+	 */
+	if (copy->d_dst) {
+		nfsd_update_cmtime_attr(copy->d_dst);
+		dput(copy->d_dst);
+	}
 	return 0;
 }
 
@@ -2193,6 +2203,11 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		memcpy(&result->cb_stateid, &copy->cp_stateid.cs_stid,
 			sizeof(result->cb_stateid));
 		dup_copy_fields(copy, async_copy);
+		if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
+			       FMODE_NOCMTIME) != 0) {
+			async_copy->d_dst = cstate->current_fh.fh_dentry;
+			dget(cstate->current_fh.fh_dentry);
+		}
 		memcpy(async_copy->cp_cb_offload.co_referring_sessionid.data,
 		       cstate->session->se_sessionid.data,
 		       NFS4_MAX_SESSIONID_LEN);
@@ -2220,8 +2235,12 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	release_copy_files(copy);
 	return status;
 out_dec_async_copy_err:
-	if (async_copy)
+	if (async_copy) {
 		atomic_dec(&nn->pending_async_copies);
+		if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
+			       FMODE_NOCMTIME) != 0)
+			dput(cstate->current_fh.fh_dentry);
+	}
 out_err:
 	if (nfsd4_ssc_is_inter(copy)) {
 		/*
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 417e9ad9fbb3..ddd6e005d3cf 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -752,6 +752,7 @@ struct nfsd4_copy {
 
 	struct nfsd_file        *nf_src;
 	struct nfsd_file        *nf_dst;
+	struct dentry		*d_dst;
 
 	copy_stateid_t		cp_stateid;
 
-- 
2.52.0


