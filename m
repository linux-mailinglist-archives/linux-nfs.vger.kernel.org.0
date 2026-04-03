Return-Path: <linux-nfs+bounces-20635-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHNOLZrbz2mb1AYAu9opvQ
	(envelope-from <linux-nfs+bounces-20635-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 17:24:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A91395C0F
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 17:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DB633007973
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2026 15:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267EF29ACCD;
	Fri,  3 Apr 2026 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbTgnh5f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1EA3148B4
	for <linux-nfs@vger.kernel.org>; Fri,  3 Apr 2026 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229694; cv=none; b=te7qoe7JguITfjGCKnsV7fleE1RE8ABXAfSycbwBgHJh0MjtS618i5WMt8S7L8YJ5+PzqhfbcHrFkEh0ocxb4RbkrQVX0sigg8SCUJUy/f7+L79iaw1ghDfG206bQsqDTefdVXrGyMsSUo3u9SbQbonRwycF9gB9Ly2A1l2Wdsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229694; c=relaxed/simple;
	bh=Urd0g5Xzs1TIzxYKGOfR0QE2VuTBFf75mPnkrOjdXD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QdIokExme+XTCdve0r2MLnAKDynztqSgdmOX8yJWpIT9amdiZP+pqk3E5FsrGpcSOmHQ+QjS3/ABYIbujNnMO55DJ3eGYYSCkYPvsgzIFqtNW0dq9veb/iDDzmium/4112QhxblGWwJf57QDRfdk9lfskzSX4tkMWRw5qhhsiZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dbTgnh5f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775229691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HPDEp253l102JKpVv+F1rvAjGmMT68bQEI7UyCOzCtQ=;
	b=dbTgnh5fdxK2u3nk343UBhfH6chOjYkzsgifmTMF54riRlwMDTYq2Sa6uO8SwER4StyuXl
	heOqWcIV9ZOnou1eqyayGBOJ21e/12LuFXfdkOEzS2NPP2IgG7rYMTToqXWYVEidsLZ2IH
	4uybIDlosHqJufbBH1FwoeCgh8qRncs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-0I7nxk_VPVOEHh7BDMBL9Q-1; Fri,
 03 Apr 2026 11:21:26 -0400
X-MC-Unique: 0I7nxk_VPVOEHh7BDMBL9Q-1
X-Mimecast-MFC-AGG-ID: 0I7nxk_VPVOEHh7BDMBL9Q_1775229685
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC6311956050;
	Fri,  3 Apr 2026 15:21:24 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.89.67])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C577919634E4;
	Fri,  3 Apr 2026 15:21:23 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH 1/1] nfsd: fix GET_DIR_DELEGATION when VFS leases are disabled
Date: Fri,  3 Apr 2026 11:20:55 -0400
Message-ID: <20260403152055.70311-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20635-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49A91395C0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When leases are disabled on the server, running xfstest generic/309 leads
to an error because GET_DIR_DELEGATION returns EINVAL.

nfsd_get_dir_deleg() can fail in several ways: like memory allocation and
unable to get a lease because either leases are disable or it's already
held. Currently only the condition "already held" is translated to
returning directory-delegation-is-unavailable error. However, other failure
conditions are likely temporary and thus should result in the same kind
of error.

Fixes: 8b99f6a8c116 ("nfsd: wire up GET_DIR_DELEGATION handling")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>

---
Notes:
I'm unsure if kernel_setlease() can return some other error that shouldnt
be converted to GDD4_UNAVAIL. Alternatively, I propose to recognize ENOMEM,
EINVAL and EAGAIN as errors to translate to GDD4_UNAVAIL.
---
 fs/nfsd/nfs4proc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 6880c5c520e7..99b44b6ec056 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2535,10 +2535,6 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
 	dd = nfsd_get_dir_deleg(cstate, gdd, nf);
 	nfsd_file_put(nf);
 	if (IS_ERR(dd)) {
-		int err = PTR_ERR(dd);
-
-		if (err != -EAGAIN)
-			return nfserrno(err);
 		gdd->gddrnf_status = GDD4_UNAVAIL;
 		return nfs_ok;
 	}
-- 
2.52.0


