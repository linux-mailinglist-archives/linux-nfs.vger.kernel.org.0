Return-Path: <linux-nfs+bounces-16038-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BACE0C333CB
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 23:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5419189A435
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 22:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CA4313E2C;
	Tue,  4 Nov 2025 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzMXA6X9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90CC313295
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295378; cv=none; b=Tc1xjHrMl2g0nLplMtOI/f6IHUbDpag1RIIzQ2DLGX4DPmleQFpG7GbkCjaHAQdsu4DZxNk1Uqyx3/SmZF8HNcgzBFiDR8aNQWafs993WHSsNVlwU7kIfFydpi7wUYy/xXzHH+B6VVb0wKco7DPMoeqjtG1X6z/rOfg6Oh079l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295378; c=relaxed/simple;
	bh=5VF0/q6aV1KtpRYOUtQeU2x/FsUPXkdMUOJ2FJeFFVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfBWd6ztg8om31mIpr+feNmMGXIqAj03PKPL3HOpE0ZafzMQJ+d20pM5fy0mAdh9U57R3pHZpzJX29Qnjv7bCIi77c2+KSOxkFxEnGqWDeNPu6Iw3XK1RZjBD5Aa1i9iLpvlXNFKCcJwYkFh9kTNncy8pB8cpGA3PB3Ob8eEPWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GzMXA6X9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762295375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xC8xdTjZRPh0qQs01e7EtF4wMo7RWTIdRr2zv8qRbqE=;
	b=GzMXA6X9TPDDKIKTdt1r3QYa+WWVoj6fmrECVVrdxTTAiHfJtkrQEcJA3NRNXreckarCgp
	dOTaEZjFMniDojMGpi1SaJNeUSLVkrjWv6oG9mC1AYZHVWSELQe42GlyCLFIHLFLAHR1F5
	O8vcqdjUgN9qc3mMdtUoRBkL1WvcZUI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-kTnzzFvWP2yLhuS2v5IAgA-1; Tue,
 04 Nov 2025 17:29:34 -0500
X-MC-Unique: kTnzzFvWP2yLhuS2v5IAgA-1
X-Mimecast-MFC-AGG-ID: kTnzzFvWP2yLhuS2v5IAgA_1762295373
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8195195608D;
	Tue,  4 Nov 2025 22:29:33 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.88.89])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD3CD1956056;
	Tue,  4 Nov 2025 22:29:32 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 4/4] NFSv4.1: protect destroying and nullifying bc_serv structure
Date: Tue,  4 Nov 2025 17:29:27 -0500
Message-ID: <20251104222927.69423-5-okorniev@redhat.com>
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

When we are shutting down the client, we free the callback
server structure and then at a later pointer we free the
transport used by the client. Yet, it's possible that after
the callback server is freed, the transport receives a
backchannel request at which point we can dereferene freed
memory. Instead, do the freeing the bc server and nullying
bc_serv under the lock.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfs/callback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 8b674ee093a6..fabda0f6ec1a 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -270,7 +270,7 @@ void nfs_callback_down(int minorversion, struct net *net, struct rpc_xprt *xprt)
 	if (cb_info->users == 0) {
 		svc_set_num_threads(serv, NULL, 0);
 		dprintk("nfs_callback_down: service destroyed\n");
-		svc_destroy(&cb_info->serv);
+		xprt_svc_destroy_nullify_bc(xprt, &cb_info->serv);
 	}
 	mutex_unlock(&nfs_callback_mutex);
 }
-- 
2.47.1


