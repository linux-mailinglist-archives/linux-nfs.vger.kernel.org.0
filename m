Return-Path: <linux-nfs+bounces-15973-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EC3C2E3C1
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 23:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA193BD473
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 22:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F992EFDA6;
	Mon,  3 Nov 2025 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0a773c3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90212EFD80
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762208030; cv=none; b=fMS0oIu6ysVNz0Iu3r2CaRoJISGBn7Ufjk7fSfBXfTC9cqW4HRI0SVQR6LKBxCTL95ZZXst5TA9qOIaE41bLj+yQcyp9h7WQYoZHzfqyXucM3ntyYgn3bFKu+hvV6eoWC0VdWtM0f9Gy/hjz3mAjTXTGnbZ2pLDtaLcMeyS3/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762208030; c=relaxed/simple;
	bh=lH3+CKPW9edoOrHkzoJVYtXwEIDM1ghIF9084/O7YIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4D33aBaneoD+rHJySIMeIMf8L/yLbUL8ZKb/AfjY0sorZJdrKJntmKDoG+4ArEwMgVW1ExK5mAnPwJWvEP6rQBMfdZdWdtFZNvAKS/Bwjhwam1ZlSeZX51cc0xcj5ul2b5MqKCc486s3ldJaIFU/GnX1Sz8tipHwR5cE0b2Z4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i0a773c3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762208027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PlkOawOYEK75/UG4huSDZgH09jB0n6ASv9HUaxPW0bM=;
	b=i0a773c3GOB+rvxjOpGp0OgqqYABSOrputYM2Je8koUZNv130NDtxzqG72w3zvydlFx/D0
	aCWw/bxNucJT8g/s/aiz9ey6q/dMEVvMxzsE7c9S8kdisISb8psJNndbKFXY46Jkrn04fw
	vg3nF1lu6wG34MK1lc44nRXn17z78uQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-UcFFEjKuPpG5oR0pcKgJ2A-1; Mon,
 03 Nov 2025 17:13:45 -0500
X-MC-Unique: UcFFEjKuPpG5oR0pcKgJ2A-1
X-Mimecast-MFC-AGG-ID: UcFFEjKuPpG5oR0pcKgJ2A_1762208024
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56C7E19560B7;
	Mon,  3 Nov 2025 22:13:44 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.81.195])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8906419560A2;
	Mon,  3 Nov 2025 22:13:43 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 3/4] SUNRPC: new helper function for stopping backchannel server
Date: Mon,  3 Nov 2025 17:13:38 -0500
Message-ID: <20251103221339.45145-4-okorniev@redhat.com>
In-Reply-To: <20251103221339.45145-1-okorniev@redhat.com>
References: <20251103221339.45145-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Create a new backchannel function to stop the backchannel server
and clear the bc_serv in transport protected under the bc_pa_lock.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 include/linux/sunrpc/bc_xprt.h |  5 +++++
 net/sunrpc/backchannel_rqst.c  | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/sunrpc/bc_xprt.h b/include/linux/sunrpc/bc_xprt.h
index 178f34ad8db6..9cac8f442fd4 100644
--- a/include/linux/sunrpc/bc_xprt.h
+++ b/include/linux/sunrpc/bc_xprt.h
@@ -32,6 +32,7 @@ int xprt_setup_bc(struct rpc_xprt *xprt, unsigned int min_reqs);
 void xprt_destroy_bc(struct rpc_xprt *xprt, unsigned int max_reqs);
 void xprt_free_bc_rqst(struct rpc_rqst *req);
 unsigned int xprt_bc_max_slots(struct rpc_xprt *xprt);
+void xprt_svc_destroy_nullify_bc(struct rpc_xprt *xprt, struct svc_serv **serv);
 
 /*
  * Determine if a shared backchannel is in use
@@ -69,5 +70,9 @@ static inline void set_bc_enabled(struct svc_serv *serv)
 static inline void xprt_free_bc_request(struct rpc_rqst *req)
 {
 }
+static void xprt_svc_destroy_nullify_bc(struct rpc_xprt *xprt, struct svc_serv **serv)
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


