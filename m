Return-Path: <linux-nfs+bounces-9267-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC9CA12F29
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 00:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD29160878
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 23:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC051DCB2D;
	Wed, 15 Jan 2025 23:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHUaucqH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6138C1D89F1
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 23:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736983463; cv=none; b=Hl7EioGUiciiXD5W9IqE6Xx0rVV1DUOvmuJQWFrWaHHYdhkJsqeESC1WN7QcGzsVSVUTCDuIf/sdLD5imtxCSRaVm/UYXKMZlsFxu+8aEDjwdrv4UBnH3281mzWAx3UaOfwfsj7M21GEypc/9iNrnTXDbWPIZUIMAryPDLxnUU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736983463; c=relaxed/simple;
	bh=6XMHvA7bWJ+5KMjowJSYSM7XUMxY+f4NokUmlPRSWsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qa+09sxJy7EAD403oyphQf2sZH+YETxYqfFX8TTSLVO5Z3pf/cpQa9lMT90R6joYj4Vz6RGTh0ZBNWKrY0QIVMRSHdcu5WlwZLK+oTlQETAO2FY+0m+xDqiBJQ9ubAuijN1nUROjEj4UEE2BBP2BTCZQRgt2oKIrYDWlDY5Ey18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHUaucqH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736983460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wcc1iXrXnOAI1URoxvbkRKg9RnwG7NwYxCMxo0zHmBM=;
	b=eHUaucqHjG3W2okqe/PuZltP7Mrk9E4Mnq+RZLeJo0XkOL4Ko9/Km/ZC5LA1SDHK3CohPb
	LX7N2h1bquznJX/3l9CCUUhSd24Tr7v1OWQk/3/kbePO0qWYhbrtBOs+d9Z/J53NQRka72
	C9/Ic5gOHjsH9UZUuX2gNoPVI+opJU4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-jZtdHp4gOWieHa0btSKVqA-1; Wed,
 15 Jan 2025 18:24:16 -0500
X-MC-Unique: jZtdHp4gOWieHa0btSKVqA-1
X-Mimecast-MFC-AGG-ID: jZtdHp4gOWieHa0btSKVqA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07C141955DC8;
	Wed, 15 Jan 2025 23:24:16 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.64.125])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 089FA30001BE;
	Wed, 15 Jan 2025 23:24:14 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 2/3] SUNRPC: add ability to remove specific server transport
Date: Wed, 15 Jan 2025 18:24:05 -0500
Message-Id: <20250115232406.44815-3-okorniev@redhat.com>
In-Reply-To: <20250115232406.44815-1-okorniev@redhat.com>
References: <20250115232406.44815-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

nfsd needs to be able to remove a particular entry from its
list of transports.

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 include/linux/sunrpc/svc.h |  1 +
 net/sunrpc/svc_xprt.c      | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 74658cca0f38..0bc0b9ead01e 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -444,6 +444,7 @@ int		   svc_register(const struct svc_serv *, struct net *, const int,
 				const unsigned short, const unsigned short);
 
 void		   svc_wake_up(struct svc_serv *);
+void		   svc_xprt_dequeue_entry(struct svc_xprt *xprt);
 void		   svc_reserve(struct svc_rqst *rqstp, int space);
 void		   svc_pool_wake_idle_thread(struct svc_pool *pool);
 struct svc_pool   *svc_pool_for_cpu(struct svc_serv *serv);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 06779b4cdd0a..7b86e69df08b 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -507,6 +507,17 @@ static struct svc_xprt *svc_xprt_dequeue(struct svc_pool *pool)
 	return xprt;
 }
 
+void svc_xprt_dequeue_entry(struct svc_xprt *xprt)
+{
+	struct svc_pool *pool;
+
+	pool = svc_pool_for_cpu(xprt->xpt_server);
+
+	WARN_ON_ONCE(pool->sp_xprts.ready);
+	llist_del_entry(&pool->sp_xprts.new, &xprt->xpt_ready.node);
+}
+EXPORT_SYMBOL_GPL(svc_xprt_dequeue_entry);
+
 /**
  * svc_reserve - change the space reserved for the reply to a request.
  * @rqstp:  The request in question
-- 
2.47.1


