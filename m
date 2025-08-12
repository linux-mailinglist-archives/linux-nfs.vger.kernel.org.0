Return-Path: <linux-nfs+bounces-13578-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8001DB22CDA
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 18:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651881AA3779
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D899A23D7DE;
	Tue, 12 Aug 2025 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MiOwb1ZK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF6F1898F8
	for <linux-nfs@vger.kernel.org>; Tue, 12 Aug 2025 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014610; cv=none; b=BKz6QgIkDs2WBuFwkwUSVMEaFnTffBluyxa7vzd2Ad0y1CNEm4oLPFCN4L0w5vhDEp3eFJpeh5FDruTGBScOn+GD6wDuBePlKCQOwglQkDbnWchpDorju0mkDXME+nGCpa1cp1wui+DAP88w5/TY1NcIdzINL8jp3jnnit0EIKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014610; c=relaxed/simple;
	bh=nIZbrIJBIiUo/raqr6Mph4NcmJpz6f0ZDoqF+dvp1A8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FlRRkaIv89AuH4076cWblYaUeYRqg5GIlzYTwUC164l3C9imofhHpEj7RaU0i7lpoJWlf6EieePX3PlFCfsGySWN8jvR/0VunEGXNljiULbeEmEO8caX/y/RQVItcIQ9Ymd4GvHgJopgqFQVFZWHqGdCzBj6iBqX7uuC+1ppD1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MiOwb1ZK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755014607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADKhEajaZJn+9aC+cA1yv9X8rLAqTKCOXpyrHS55Vxc=;
	b=MiOwb1ZK5t2IZv4cmIYgzyKi1i9D1aveAUcfJw1vOTnKJ+yJ4aayRY8YyVycC/bxY31q00
	9CgPCgnNHlgRlUNu3vLzyHaRREEbQ5qJauhLB1pJoMldpqJPNVE/GhIEBuXz+YOSoTXVMV
	JpgMLzJWghGr6wWxBN1YOu1yxyRdn+I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-IYgQTdniMuWUtZGiVxuaEQ-1; Tue,
 12 Aug 2025 12:03:24 -0400
X-MC-Unique: IYgQTdniMuWUtZGiVxuaEQ-1
X-Mimecast-MFC-AGG-ID: IYgQTdniMuWUtZGiVxuaEQ_1755014601
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88A6919560A2;
	Tue, 12 Aug 2025 16:03:21 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.82.47])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1941A300146D;
	Tue, 12 Aug 2025 16:03:19 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neil@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH v2 2/2] lockd: while grace prefer to fail with nlm_lck_denied_grace_period
Date: Tue, 12 Aug 2025 12:03:17 -0400
Message-Id: <20250812160317.25363-2-okorniev@redhat.com>
In-Reply-To: <20250812160317.25363-1-okorniev@redhat.com>
References: <20250812160317.25363-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When nfsd is in grace and receives an NLM LOCK request which turns
out to have a conflicting delegation, return that the server is in
grace.

Reviewed-by: Jeff Layton <jlayton@redhat.com>
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


