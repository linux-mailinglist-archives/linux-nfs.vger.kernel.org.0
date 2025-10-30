Return-Path: <linux-nfs+bounces-15816-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 820B1C22763
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 22:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 165274E7DC3
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 21:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A343128CE;
	Thu, 30 Oct 2025 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3U77C/V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30FE2620C3
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860893; cv=none; b=WsSu+JJh2bd9YV2ZSglL3Ztm0zYg5H4FrnSMuhtgYB4yMg9QpugFO8ytmviTC8A/hTm2joRX2QCTnQ66x7VfeNsR4bt9pNxUyirkuB0ZIlQm0JlPbddxk1uROWmv+29+lWitQbpSYDx7/+Q2z9phK4pANvDPGKBczy4DoQxgMck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860893; c=relaxed/simple;
	bh=ZjKKQ3LMAygwCLSEifqCgweDjfeYUmuvByvuWtn5rnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXX5wYkZAFzxIR394hU+rKRMz98IDQqXL7bLAsySdD21jJXZidu9khwXZGvGt63CQG3Tc5M/Q7IenXoEu8Yq77q3KYsIUln/UYV2BTNpoUT5kfGlnHJ7L45eSuD9syZtu9pAZMqNcLh6FVXtxav4Mt3pQP7pwhnMWVMuyQGg6do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F3U77C/V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761860890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZnJ+CIqIlRcbog7IOzPlOCv361pnI6zR4KQUiY4+ho=;
	b=F3U77C/VRgLFWJyW+0iBfEuPOgG1wnzKlnDTYveocfrGHzTMFLrbRW6vRVKdoeuQuUfYNg
	+OUcALFeZb/NfUyTYdwsLqrMNOh2zncyWWCHN/wlkgLSyeUHhDMOy75gCIg0P40o5SXTpz
	KsYl5NcgcMDV6ymSDjxMoI/WribAFj4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-AhAVXhqBPiGhNtgVu1dPTQ-1; Thu,
 30 Oct 2025 17:48:06 -0400
X-MC-Unique: AhAVXhqBPiGhNtgVu1dPTQ-1
X-Mimecast-MFC-AGG-ID: AhAVXhqBPiGhNtgVu1dPTQ_1761860885
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D2211805C02;
	Thu, 30 Oct 2025 21:48:05 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.64.252])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3CBE819540DA;
	Thu, 30 Oct 2025 21:48:04 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/3] NFSv4.1: protect destroying and nullifying bc_serv structure
Date: Thu, 30 Oct 2025 17:47:59 -0400
Message-ID: <20251030214759.62746-4-okorniev@redhat.com>
In-Reply-To: <20251030214759.62746-1-okorniev@redhat.com>
References: <20251030214759.62746-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When we are shutting down the client, we free the callback
server structure and then at a later pointer we free the
transport used by the client. Yet, it's possible that after
the callback server is freed, the transport receives a
backchannel request at which point we can dereferene freed
memory. Instead, do the freeing the bc server and nullying
bc_serv under the lock.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfs/callback.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 8b674ee093a6..2135c363c394 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -270,7 +270,14 @@ void nfs_callback_down(int minorversion, struct net *net, struct rpc_xprt *xprt)
 	if (cb_info->users == 0) {
 		svc_set_num_threads(serv, NULL, 0);
 		dprintk("nfs_callback_down: service destroyed\n");
-		svc_destroy(&cb_info->serv);
+		if (!minorversion)
+			svc_destroy(&cb_info->serv);
+		else
+#ifdef CONFIG_SUNRPC_BACKCHANNEL
+			xprt_svc_destroy_nullify_bc(xprt, &cb_info->serv);
+#else
+			svc_destroy(&cb_info->serv);
+#endif
 	}
 	mutex_unlock(&nfs_callback_mutex);
 }
-- 
2.47.1


