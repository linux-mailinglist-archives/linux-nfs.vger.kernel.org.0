Return-Path: <linux-nfs+bounces-14627-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E835B97ABA
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 00:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21B91898AAB
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Sep 2025 22:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F23D30F932;
	Tue, 23 Sep 2025 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxUtQXNq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B3C30E84A
	for <linux-nfs@vger.kernel.org>; Tue, 23 Sep 2025 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664803; cv=none; b=e7K21D9YW4bY7TedpMR5GMHvd1gBY7apVbW1lmT1Wd3SEt8MKchsPEEl7WbO9JTSY2RRZkAxmoNm9sbG8GH+N1cFyfMtHxFsxTkWQ4aCqDb/FhwwmIZGzCcPCOp74ggQOLfzLdnzjVHcoWcQI0JPYmRZCe1gTdwU9xzPWVKLz8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664803; c=relaxed/simple;
	bh=cqrM3YyZuS0FV2DB9oaYwA6wn9MV1S0MzjfdJr5vtn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2L3iCK2ltOnyBMjN6l9vAOO6iPF8To3QKrzsrEdeLw3MaNv6PQJYn0S2o8XfxFaBUBy47Ka8nkRmRF9JBAds0cDrKoAE3SOA87Mo6di6nRmApRp/7bEfhmPB+WKaKgVEuPvFxlz6eaW8wZJtDxwp7wTXID9QsHM9K33oaiDizs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxUtQXNq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758664800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2fLhk2k057T/qaa3aehmVRxBRoXDOQaf1b02jNKRLY=;
	b=dxUtQXNq7Gq4h6KhwOvnnV0FlDYqlg/RvGkJlCNL2CcIfZ7VLDHAPZ10ZX3kFTtJaz1M02
	GtBabMRC+fjTD/K+sMEMdgOkdPopKORD/lbHhVN9wjrRYRpfI/dYn6iwaF1OvSWWd7K0iI
	50uXThmL3f6jxZpFO2A0/cpf1vc+WG8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-4O3A8zkcOLa2Qa53XGDBNw-1; Tue,
 23 Sep 2025 17:59:56 -0400
X-MC-Unique: 4O3A8zkcOLa2Qa53XGDBNw-1
X-Mimecast-MFC-AGG-ID: 4O3A8zkcOLa2Qa53XGDBNw_1758664795
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA5FF19560B3;
	Tue, 23 Sep 2025 21:59:55 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.89.158])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 916261800452;
	Tue, 23 Sep 2025 21:59:55 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 09AF046F6F7;
	Tue, 23 Sep 2025 17:59:54 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 3/4] rudimentary CB_NOTIFY_LOCK support
Date: Tue, 23 Sep 2025 17:59:52 -0400
Message-ID: <20250923215953.165858-4-smayhew@redhat.com>
In-Reply-To: <20250923215953.165858-1-smayhew@redhat.com>
References: <20250923215953.165858-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 nfs4.1/nfs4client.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
index f4fabcc..b6d8edc 100644
--- a/nfs4.1/nfs4client.py
+++ b/nfs4.1/nfs4client.py
@@ -283,6 +283,12 @@ class NFS4Client(rpc.Client, rpc.Server):
         res = self.posthook(arg, env, res=NFS4_OK)
         return encode_status(res)
 
+    def op_cb_notify_lock(self, arg, env):
+        log_cb.info("In CB_NOTIFY_LOCK")
+        self.prehook(arg, env)
+        res = self.posthook(arg, env, res=NFS4_OK)
+        return encode_status(res)
+
     def op_cb_layoutrecall(self, arg, env):
         log_cb.info("In CB_LAYOUTRECALL")
         self.prehook(arg, env)
-- 
2.51.0


