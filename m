Return-Path: <linux-nfs+bounces-16037-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3888C333C8
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 23:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C1F1899245
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 22:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CC4313559;
	Tue,  4 Nov 2025 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HA64SrXz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850AF313524
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295378; cv=none; b=A3hYXsz5pyZ7NKRl4EUSfvuo6QYcEaW6ERKW15oxn7M6OOrLVxmVRIi85DU1cDZTTf5Swdii04p2W/rvmEHMNIkV9OMcsZzE3ja9ppLhOQgQCPFzPGjkNHDDckuSvVno66DVLkjPsy/ZDpjyXjnvCE3Snt+7hQC3ZVLzIMsqEy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295378; c=relaxed/simple;
	bh=WqIjWu0d3Rz8CEMzPz+KRUFjCYKPVr4yg4loXy4UhGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2+DR23Xspd+l9cVyvoN1rrd/nqvi9xlS0Smgx1E1rBqPhl9BKToUFP0yicK3mT7X2p/YnbfEV65UPJyof1dAasMhWIeGD9oxah5wzMqic4IUoXD44c7QrBIHFcDvAR5ae5Y6yvZ589zgA/Mo6781eN4u2tCRb9/AyYV0FXNDsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HA64SrXz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762295375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/C7jLR0XYboJf3cK+65+DQC/fXR4Gln7PkaoONoouwg=;
	b=HA64SrXzp4L0N16WACkn3oChXphDJCHWy/BS/n8G3njftjqlI7htYxcK6EBiK0+uOyNdNI
	ePSRZGmkA0k2xJ8amp84Qk5aEVnR8fl5f+1sbAb5/6EvPsPKfLgEPrwjtqJb4JX9FKK51g
	Ci8gZP4iOGXdO871Xi6fIUf1vVgPaMw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-g592a82RM_SgixmpQtTtQw-1; Tue,
 04 Nov 2025 17:29:33 -0500
X-MC-Unique: g592a82RM_SgixmpQtTtQw-1
X-Mimecast-MFC-AGG-ID: g592a82RM_SgixmpQtTtQw_1762295372
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93E3E19560B5;
	Tue,  4 Nov 2025 22:29:32 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.88.89])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BFC5919540DD;
	Tue,  4 Nov 2025 22:29:31 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 3/4] SUNRPC: new helper function for stopping backchannel server
Date: Tue,  4 Nov 2025 17:29:26 -0500
Message-ID: <20251104222927.69423-4-okorniev@redhat.com>
In-Reply-To: <20251104222927.69423-1-okorniev@redhat.com>
References: <20251104222927.69423-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Create a new backchannel function to stop the backchannel server
and clear the bc_serv in transport protected under the bc_pa_lock.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 include/linux/sunrpc/bc_xprt.h |  6 ++++++
 net/sunrpc/backchannel_rqst.c  | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/sunrpc/bc_xprt.h b/include/linux/sunrpc/bc_xprt.h
index 178f34ad8db6..98939cb664cf 100644
--- a/include/linux/sunrpc/bc_xprt.h
+++ b/include/linux/sunrpc/bc_xprt.h
@@ -32,6 +32,7 @@ int xprt_setup_bc(struct rpc_xprt *xprt, unsigned int min_reqs);
 void xprt_destroy_bc(struct rpc_xprt *xprt, unsigned int max_reqs);
 void xprt_free_bc_rqst(struct rpc_rqst *req);
 unsigned int xprt_bc_max_slots(struct rpc_xprt *xprt);
+void xprt_svc_destroy_nullify_bc(struct rpc_xprt *xprt, struct svc_serv **serv);
 
 /*
  * Determine if a shared backchannel is in use
@@ -69,5 +70,10 @@ static inline void set_bc_enabled(struct svc_serv *serv)
 static inline void xprt_free_bc_request(struct rpc_rqst *req)
 {
 }
+
+static inline void xprt_svc_destroy_nullify_bc(struct rpc_xprt *xprt, struct svc_serv **serv)
+{
+	svc_destroy(serv);
+}
 #endif /* CONFIG_SUNRPC_BACKCHANNEL */
 #endif /* _LINUX_SUNRPC_BC_XPRT_H */
diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
index efddea0f4b8b..68b1fcdea8f0 100644
--- a/net/sunrpc/backchannel_rqst.c
+++ b/net/sunrpc/backchannel_rqst.c
@@ -24,6 +24,22 @@ unsigned int xprt_bc_max_slots(struct rpc_xprt *xprt)
 	return BC_MAX_SLOTS;
 }
 
+/*
+ * Helper function to nullify backchannel server pointer in transport.
+ * We need to synchronize setting the pointer to NULL (done so after
+ * the backchannel server is shutdown) with the usage of that pointer
+ * by the backchannel request processing routines
+ * xprt_complete_bc_request() and rpcrdma_bc_receive_call().
+ */
+void xprt_svc_destroy_nullify_bc(struct rpc_xprt *xprt, struct svc_serv **serv)
+{
+	spin_lock(&xprt->bc_pa_lock);
+	svc_destroy(serv);
+	xprt->bc_serv = NULL;
+	spin_unlock(&xprt->bc_pa_lock);
+}
+EXPORT_SYMBOL_GPL(xprt_svc_destroy_nullify_bc);
+
 /*
  * Helper routines that track the number of preallocation elements
  * on the transport.
-- 
2.47.1


