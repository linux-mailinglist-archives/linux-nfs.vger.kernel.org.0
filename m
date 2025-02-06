Return-Path: <linux-nfs+bounces-9905-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFF2A2B07D
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 19:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39511884017
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 18:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B4B1DC98A;
	Thu,  6 Feb 2025 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmMOqufr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B3F1D934B
	for <linux-nfs@vger.kernel.org>; Thu,  6 Feb 2025 18:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865747; cv=none; b=eQGIC8vU1oo7KfxZMo3Cbay3k/212Lp31sqB7wdkpTv+/LlSto83yvq34r/HNDa2YnoSNCwtQLZmUmYdl6IO40p9ghez55ezN1C5ziBQa6EMn9wnCeFaibA29egl+BEz2a0EB9MY+3/OJ/1Rh0JtPgRIavrHo/kjYGCoanjE5QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865747; c=relaxed/simple;
	bh=FatHeTfaZ1PmwABuNwGDGFLw4cnuuT2VO7um/PzzN2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lt94A6li9WufuiuHJqCEL6ImHy7J+IRJgcUQA3wfjauPrFZORkQsl8BU31GD+NuL+BvaLzhDmCrY085YM7sAyzZMpmABUyp1NAuglIJiiwbNY9WB18+JnSJpkf5VkPQiWtS44GOPyiuRZoHvovJBTZzMuN8QZ8Oa1HiCQoRuReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NmMOqufr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738865744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7DCMeWQOXP/JGPJoQVxwCLGu6YP5WCAUugLTDggMlcY=;
	b=NmMOqufr9TnCys29EoeJEKpIkAvGfaKI3LnecWuclXVAekJhx47tKPkibMuVRl/kWv6rLX
	wsRX1sNvHzy2kIP93kZRlAb8tLn21fuIwQdkfb8Dj69tiTdG9Ddv3u+rM6pOKXY5Kkp+4H
	N/3alwHHODCnXOLQ57GoAyNAAmXdEHo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-APorrUGtOCyvaO1W_8hh6A-1; Thu,
 06 Feb 2025 13:15:40 -0500
X-MC-Unique: APorrUGtOCyvaO1W_8hh6A-1
X-Mimecast-MFC-AGG-ID: APorrUGtOCyvaO1W_8hh6A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98FBC1801A1A;
	Thu,  6 Feb 2025 18:15:38 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.66.19])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AEF6319560A3;
	Thu,  6 Feb 2025 18:15:36 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@suse.de,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 1/1] svcrdma: dont unregister device for listening sockets
Date: Thu,  6 Feb 2025 13:15:34 -0500
Message-Id: <20250206181534.3442-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On an rdma-capable machine, a start/stop/start and then on a stop of
a knfsd server would lead kref underflow warning because svc_rdma_free
would indiscriminatory unregister the rdma device but a listerning
transport never call the rdma_rn_register() thus leading to kref
going down to 0 on the 1st stop of the server and on the 2nd stop
it leads a problem.

Suggested-by: Chuck Lever <chuck.lever@oracle.com>
Fixes: c4de97f7c454 ("svcrdma: Handle device removal outside of the CM event handler")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index c3fbf0779d4a..aca8bdf65d72 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -621,7 +621,8 @@ static void __svc_rdma_free(struct work_struct *work)
 	/* Destroy the CM ID */
 	rdma_destroy_id(rdma->sc_cm_id);
 
-	rpcrdma_rn_unregister(device, &rdma->sc_rn);
+	if (!test_bit(XPT_LISTENER, &rdma->sc_xprt.xpt_flags))
+		rpcrdma_rn_unregister(device, &rdma->sc_rn);
 	kfree(rdma);
 }
 
-- 
2.47.1


