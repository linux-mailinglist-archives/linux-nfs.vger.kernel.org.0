Return-Path: <linux-nfs+bounces-13558-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8D8B21430
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 20:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34689625D1C
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 18:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22952E285E;
	Mon, 11 Aug 2025 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrU1PnXz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2DB2E2855
	for <linux-nfs@vger.kernel.org>; Mon, 11 Aug 2025 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936334; cv=none; b=Rf+fZBh5gqw4U3KnBYN4AaPQGr0obZW4no98CdbjrU000TvrcaJbFqdFPW5zyx+/z56/U/PP9zZPMZJm9IWXlG868VogZpK3ymkKEAm9r8iuhujSWUXk9V7sfg8MiJb9dsVu18yE3sj2CVZk8ZQw8yT7oqHpU6+eyT3IL3HKRZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936334; c=relaxed/simple;
	bh=UD7X4diZGhUVOlWd6ADG9EHpEuzBVGPOtPCwR93E56E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ataVFkbxQdxrGwM4nxdwBgn5iyvRinjuBH3wL9rnGRb/qy7r8pvnirf6qrKrcE5Q/kmCsUOqRNg/OLAGxoqvRP6EBUgi1fHmgco904/qiRSdvy+ps562HICxNJxbuwVFLEwnhkIIp2Clh/t2R+GQtpRB7D2lj07h5RV4jZWPAOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XrU1PnXz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754936332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLdaA9xim1xuWQndhNmHJW1Ad+n2nGARmCLKxuHIQkA=;
	b=XrU1PnXzn3F7dDGk2rhrJCf9sOIAYmdVbJ3US2vNck82UQPOmTNp1LUOGcClxmkJf5hG5n
	HLB2kU+mYF/x01j2pQleR35azqQfueRZSjBMBBVfmhOka7IKM+odTLlD8/hA3BX95WcD7F
	MF+cEtjHwF58PdIVgEr9wXBGMKkJYqc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-Qxw6ZfpFOeq-BcpdtDYTJA-1; Mon,
 11 Aug 2025 14:18:47 -0400
X-MC-Unique: Qxw6ZfpFOeq-BcpdtDYTJA-1
X-Mimecast-MFC-AGG-ID: Qxw6ZfpFOeq-BcpdtDYTJA_1754936326
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A8C619560B1;
	Mon, 11 Aug 2025 18:18:46 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.89.42])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 01DAA180028E;
	Mon, 11 Aug 2025 18:18:44 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neil@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [RFC PATCH 2/2] lockd: while grace prefer to fail with nlm_lck_denied_grace_period
Date: Mon, 11 Aug 2025 14:18:40 -0400
Message-Id: <20250811181840.99269-3-okorniev@redhat.com>
In-Reply-To: <20250811181840.99269-1-okorniev@redhat.com>
References: <20250811181840.99269-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When nfsd is in grace and receives an NLM LOCK request which turns
out to have a conflicting delegation, return that the server is in
grace.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/lockd/svc4proc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 109e5caae8c7..7ac4af5c9875 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -141,8 +141,19 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
 	resp->cookie = argp->cookie;
 
 	/* Obtain client and file */
-	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
+	resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file);
+	switch (resp->status) {
+	case 0:
+		break;
+	case nlm_drop_reply:
+		if (locks_in_grace(SVC_NET(rqstp))) {
+			resp->status = nlm_lck_denied_grace_period;
+			return rpc_success;
+		}
+		return nlm_drop_reply;
+	default:
+		return rpc_success;
+	}
 
 	/* Now try to lock the file */
 	resp->status = nlmsvc_lock(rqstp, file, host, &argp->lock,
-- 
2.47.1


