Return-Path: <linux-nfs+bounces-20813-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCZ0IM4h2WlRmggAu9opvQ
	(envelope-from <linux-nfs+bounces-20813-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 18:14:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D3A3DA326
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 18:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11527302F40C
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 16:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A132E542C;
	Fri, 10 Apr 2026 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdzCSEKj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401BE3A6F02
	for <linux-nfs@vger.kernel.org>; Fri, 10 Apr 2026 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837374; cv=none; b=HlElB0CvfhJoTfahuRGgNlCO7lg1RNkdY0FhVVDRNKi85VAfyzKpjWF3HkBZ3SATSqBpCH/biXoZvuApv45/32vurOyThiItmAACxwRMwPPoyfaSvZyiUaJs8KTVcydmoKObnuIJOhveHPTMCZlYg3G2R80/47kZuLH4ClCj6po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837374; c=relaxed/simple;
	bh=Zx6jcFCFJvYpCBSwysRhmXS3MfvH5yjfjWNYQfpBnSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHFJ8oO6DPS3AI6qupV1Vv0rvoTU5I69zx5GAT8TR4qGQQ83ywDFns0W41jhIsvKnfEp/i+h9SvZJ6uLMJQAjNJ59Wgjx7g5EmIl0Gnk60XyXklTHxqMt6R6bZR+e1k6jw0EjJbF4TkdGLxpXYtkembvkSimw0P/1BIH5zFx9Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdzCSEKj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775837372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HJw5WA2xd69udaeiHEbvpx5qU81+Qb76YH3EmGq802E=;
	b=YdzCSEKjDHjEe84SG7ixnBxu6dy+HqAihbDrqOVW2/uDznWe+DFDL7vlBINHid81hJkRVL
	1nlnVLhdVWcylCK+j8MHQYP3WUedoHq7mhgVW8tffxdQwNVIbA/gZbBz2ITx1a80Belklv
	ZrBPs5ze9oNvuPjd9TbgpG57CKOAG0I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-Da8hPypcMHm-M50-I0y3Zw-1; Fri,
 10 Apr 2026 12:09:26 -0400
X-MC-Unique: Da8hPypcMHm-M50-I0y3Zw-1
X-Mimecast-MFC-AGG-ID: Da8hPypcMHm-M50-I0y3Zw_1775837365
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9FA319560B7;
	Fri, 10 Apr 2026 16:09:25 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.65.94])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7FACF195608E;
	Fri, 10 Apr 2026 16:09:24 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH v4 2/2] nfsd: update mtime/ctime on COPY in presence of delegated attributes
Date: Fri, 10 Apr 2026 12:09:20 -0400
Message-ID: <20260410160920.56855-3-okorniev@redhat.com>
In-Reply-To: <20260410160920.56855-1-okorniev@redhat.com>
References: <20260410160920.56855-1-okorniev@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20813-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1D3A3DA326
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When delegated attributes are given on open, the file is opened with
NOCMTIME and modifying operations do not update mtime/ctime as to not get
out-of-sync with the client's delegated view. However, for COPY operation,
the server should update its view of mtime/ctime and reflect that in any
GETATTR queries.

Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding WRITE_ATTRS delegation")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4proc.c | 11 ++++++++++-
 fs/nfsd/xdr4.h     |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index ffe85b21a9ac..850a0b31c057 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2121,8 +2121,10 @@ static int nfsd4_do_async_copy(void *data)
 
 	set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
 	trace_nfsd_copy_async_done(copy);
-	nfsd4_send_cb_offload(copy);
 	atomic_dec(&copy->cp_nn->pending_async_copies);
+	if (copy->cp_res.wr_bytes_written > 0 && copy->attr_update)
+		nfsd_update_cmtime_attr(copy->nf_dst->nf_file, 0);
+	nfsd4_send_cb_offload(copy);
 	return 0;
 }
 
@@ -2182,6 +2184,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		memcpy(&result->cb_stateid, &copy->cp_stateid.cs_stid,
 			sizeof(result->cb_stateid));
 		dup_copy_fields(copy, async_copy);
+		if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
+			       FMODE_NOCMTIME) != 0)
+			async_copy->attr_update = true;
 		memcpy(async_copy->cp_cb_offload.co_referring_sessionid.data,
 		       cstate->session->se_sessionid.data,
 		       NFS4_MAX_SESSIONID_LEN);
@@ -2200,6 +2205,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	} else {
 		status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
 				       copy->nf_dst->nf_file, true);
+		if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
+			       FMODE_NOCMTIME) != 0 &&
+				copy->cp_res.wr_bytes_written > 0)
+			nfsd_update_cmtime_attr(copy->nf_dst->nf_file, 0);
 	}
 out:
 	trace_nfsd_copy_done(copy, status);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 417e9ad9fbb3..9a4124c77e04 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -752,6 +752,7 @@ struct nfsd4_copy {
 
 	struct nfsd_file        *nf_src;
 	struct nfsd_file        *nf_dst;
+	bool			attr_update;
 
 	copy_stateid_t		cp_stateid;
 
-- 
2.52.0


