Return-Path: <linux-nfs+bounces-9722-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26023A20F52
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 17:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA473A3861
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 16:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3011DDC2D;
	Tue, 28 Jan 2025 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgQpnCFT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D901C68A6
	for <linux-nfs@vger.kernel.org>; Tue, 28 Jan 2025 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738083498; cv=none; b=mvCEnn7ex29h5LL+4VwFzyuOJMj364U3xFx9B/JsKatu84lAx03WpTVAJ2TBI76qk3yLd7SD8f0WfqZ/R6tTonWoObfANp6vRL0ifiryuo+cOlV2jatt9sdGGCLnzlJ0sf6lRRPFTzSYoR6XmqosUu2egZHCvnx4pTC//eJF7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738083498; c=relaxed/simple;
	bh=6SYsXWJcVygFjjQqU09qjR0QhnB7ohBmB+ix7VRm9/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rqWridGRm2GqmmmuRSgLgI4+VTYqDhdt7fWNLY2Qu+ht6mm+vQOMrI1ofr5PlrB2faAbsg7eD+m2UCTH3U94R2IBWp7Pfb8b8on9tW07VP/RpQxvo2FpmxtwcefQHgwkFwLqqcwco+acXPq5LvKkupaiZs1qLMpcH5bBC/5FmrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgQpnCFT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738083496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ufR9BrvUeTCZhMqObo8PSXaUwbDPi7yegvHtpCY/JdQ=;
	b=dgQpnCFTsdzJL4byHZ4nXpr34NWLfYduuHmal/Gl1zDWuID8ZiyUfzyAAzWcYKuEcOz/dY
	djhD0bd5UrSNddWK/gm91wJjUVwLZzDtsGId5WszVqrnlbgsJUaCefrO4h8AM93EKLBY8z
	MDpi8S1IGVJbDGy8N1aTUu4JiVrLs+Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-ctFC7ogOO4esO9RX2j-ehQ-1; Tue,
 28 Jan 2025 11:58:15 -0500
X-MC-Unique: ctFC7ogOO4esO9RX2j-ehQ-1
X-Mimecast-MFC-AGG-ID: ctFC7ogOO4esO9RX2j-ehQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EF8E1828A80;
	Tue, 28 Jan 2025 16:58:10 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.90.70])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 15BF61800900;
	Tue, 28 Jan 2025 16:58:08 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@suse.de,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 1/1] nfsd: fix __fh_verify for localio
Date: Tue, 28 Jan 2025 11:58:06 -0500
Message-Id: <20250128165806.15153-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

__fh_verify() added a call to svc_xprt_set_valid() to help do connection
management but during LOCALIO path rqstp argument is NULL, leading to
NULL pointer dereferencing and a crash.

Fixes: eccbbc7c00a5 ("nfsd: don't use sv_nrthreads in connection limiting calculations.")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfsfh.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index bf59f83c6224..91bf0e6d5895 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -381,8 +381,9 @@ __fh_verify(struct svc_rqst *rqstp,
 	error = check_nfsd_access(exp, rqstp, may_bypass_gss);
 	if (error)
 		goto out;
-
-	svc_xprt_set_valid(rqstp->rq_xprt);
+	/* During LOCALIO call to fh_verify will be called with a NULL rqstp */
+	if (rqstp)
+		svc_xprt_set_valid(rqstp->rq_xprt);
 
 	/* Finally, check access permissions. */
 	error = nfsd_permission(cred, exp, dentry, access);
-- 
2.47.1


