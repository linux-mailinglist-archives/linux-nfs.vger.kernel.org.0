Return-Path: <linux-nfs+bounces-19810-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II/SMt+oqWlSBwEAu9opvQ
	(envelope-from <linux-nfs+bounces-19810-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 17:01:35 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6522150F8
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 17:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94C9530DE197
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2026 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235353A6EFA;
	Thu,  5 Mar 2026 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icGKOci9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7877C330B00
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726397; cv=none; b=DoW/YxTwp6MI1mBl/jxY2AT6ifNrGqohfTgUFzjqq0iJ4wwcNWH010/ZXiqqkGvgMs1eld4rkc1Z8WiSOTKKWq56BFSdeOykt4hRtwRsuaQna44Ln1ij34bQOBLiHtD09DHWyPyo/+WS5KJETOhWOVF9Glk2u1sfQV0CzEbhSOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726397; c=relaxed/simple;
	bh=CzpiJePh0z07Vhbj1H2InmzN1JZXIisDQKzsiQUAuuk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9ULSlAJbKE2b6735ZTlOBO3x7J3fuC18VppWZ8jhkrS0Zcx8EmqWHkXsPP5hL2qCBIBnjP97XDlJAUBwc/K9MH3/rMQCxmhcdSrk+vVcRAUs6ndZZx/mXCdTPRsrOcUQa+lNyay7jWa12FmQQvQO6NgDwKwiwMOMRuJE1nvaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=icGKOci9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772726392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vrxA9BJR9hRbcXITJ4djdgODfvUJI6/uM8E2msKmCw=;
	b=icGKOci97vIz+NwVSlYkQCrXtbUgA98yzwcdf3F1HUyY/hYGHq34cLjWvArj7scSkvBgy+
	2jCXeUcoE4Gdck+uAVMO1xgpbdg4c1CgrXjHT8n+b/Hb+M/0qJigGiM5Z0dK3z5Pj8Gozg
	27PHuZM5PeEhucCVZ0BOkNskD6LvUsQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-HfrK-hdiNWmT3OwMsJ-QaA-1; Thu,
 05 Mar 2026 10:59:50 -0500
X-MC-Unique: HfrK-hdiNWmT3OwMsJ-QaA-1
X-Mimecast-MFC-AGG-ID: HfrK-hdiNWmT3OwMsJ-QaA_1772726390
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2632E195605A
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 15:59:50 +0000 (UTC)
Received: from bighat.com (steved-laptop.mht.redhat.com [10.17.16.21])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3AC6180075F
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 15:59:49 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/4] mountd: Minor refactor of get_rootfh()
Date: Thu,  5 Mar 2026 10:59:45 -0500
Message-ID: <20260305155948.11261-2-steved@redhat.com>
In-Reply-To: <20260305155948.11261-1-steved@redhat.com>
References: <20260305155948.11261-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 7E6522150F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19810-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[steved.redhat.com:query timed out];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Perform the mountpoint checks before checking the user path.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/mountd/mountd.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
index dbd5546d..39afd4aa 100644
--- a/utils/mountd/mountd.c
+++ b/utils/mountd/mountd.c
@@ -412,6 +412,23 @@ get_rootfh(struct svc_req *rqstp, dirpath *path, nfs_export **expret,
 		*error = MNT3ERR_ACCES;
 		return NULL;
 	}
+	if (nfsd_path_stat(exp->m_export.e_path, &estb) < 0) {
+		xlog(L_WARNING, "can't stat export point %s: %s",
+		     p, strerror(errno));
+		*error = MNT3ERR_NOENT;
+		return NULL;
+	}
+	if (exp->m_export.e_mountpoint &&
+		   !check_is_mountpoint(exp->m_export.e_mountpoint[0]?
+				  exp->m_export.e_mountpoint:
+				  exp->m_export.e_path,
+				  nfsd_path_lstat)) {
+		xlog(L_WARNING, "request to export an unmounted filesystem: %s",
+		     p);
+		*error = MNT3ERR_NOENT;
+		return NULL;
+	}
+
 	if (nfsd_path_stat(p, &stb) < 0) {
 		xlog(L_WARNING, "can't stat exported dir %s: %s",
 				p, strerror(errno));
@@ -426,12 +443,6 @@ get_rootfh(struct svc_req *rqstp, dirpath *path, nfs_export **expret,
 		*error = MNT3ERR_NOTDIR;
 		return NULL;
 	}
-	if (nfsd_path_stat(exp->m_export.e_path, &estb) < 0) {
-		xlog(L_WARNING, "can't stat export point %s: %s",
-		     p, strerror(errno));
-		*error = MNT3ERR_NOENT;
-		return NULL;
-	}
 	if (estb.st_dev != stb.st_dev
 	    && !(exp->m_export.e_flags & NFSEXP_CROSSMOUNT)) {
 		xlog(L_WARNING, "request to export directory %s below nearest filesystem %s",
@@ -439,17 +450,6 @@ get_rootfh(struct svc_req *rqstp, dirpath *path, nfs_export **expret,
 		*error = MNT3ERR_ACCES;
 		return NULL;
 	}
-	if (exp->m_export.e_mountpoint &&
-		   !check_is_mountpoint(exp->m_export.e_mountpoint[0]?
-				  exp->m_export.e_mountpoint:
-				  exp->m_export.e_path,
-				  nfsd_path_lstat)) {
-		xlog(L_WARNING, "request to export an unmounted filesystem: %s",
-		     p);
-		*error = MNT3ERR_NOENT;
-		return NULL;
-	}
-
 	/* This will be a static private nfs_export with just one
 	 * address.  We feed it to kernel then extract the filehandle,
 	 */
-- 
2.53.0


