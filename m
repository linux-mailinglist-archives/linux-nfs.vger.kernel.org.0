Return-Path: <linux-nfs+bounces-15974-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37307C2E39D
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 23:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D345C34ADC4
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 22:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817EE2EE5F4;
	Mon,  3 Nov 2025 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKa1FFe1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ED62EFD92
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762208030; cv=none; b=XbDSaI3XPQmUmVJ17xKyEB7hdJKGHsl+B1hYhhZUZnXEO0aKQKmSyiJm4xwEVDGWL5kzs4XkoTWxB87quVIcRNmOY21CyiHiNzVfzphV5SfG3uDV005Qf/zsUmprQI9yL8UrJw0GTbmukh3rvdgx7R3kLnUDIKgL8g4Q3BdSCSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762208030; c=relaxed/simple;
	bh=N9k/Jd2kBbBgrM6T0K17PEccw/qLrEGu0Z2uT7mwB9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbgrE5sXyCfrSrHebW4lq3spbTb+Q8NmDtczw9R30qCtU/pih1RODLFJ3IvyjddLfgeqzHaDN3OPfLOVseyX9R7c6jr6TATFmzlOd82L4VK6MfKkOepOt6pDzxJz/N8UrkzxLu17ihDMe9A/yff84P6QO7JVpBCvZQ9geaK4DOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WKa1FFe1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762208027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDHcT8Bma5LoXPK3HnyfCCqD7fk4He1BCLKN7BNUxgo=;
	b=WKa1FFe1GW5nB3iUPhAssDmhJpMfM/B3xXNu6pwHV/yPq9K0OHB2k8hEMxZAoxXLpUbAMS
	A77GA0G0em+37w+ANJ2zyRq5m/pl+Yo7PqDZI58JF5zK+fhNcmIuh9Tr8mWskL1bzIfU+/
	41X/zqHuVtpKzDJFV6O/ilDsrXCsKs0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-4E7SQgNrNUShL3mm44CtOA-1; Mon,
 03 Nov 2025 17:13:46 -0500
X-MC-Unique: 4E7SQgNrNUShL3mm44CtOA-1
X-Mimecast-MFC-AGG-ID: 4E7SQgNrNUShL3mm44CtOA_1762208025
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72B36195605F;
	Mon,  3 Nov 2025 22:13:45 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.81.195])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C73419560B7;
	Mon,  3 Nov 2025 22:13:44 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 4/4] NFSv4.1: protect destroying and nullifying bc_serv structure
Date: Mon,  3 Nov 2025 17:13:39 -0500
Message-ID: <20251103221339.45145-5-okorniev@redhat.com>
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

When we are shutting down the client, we free the callback
server structure and then at a later pointer we free the
transport used by the client. Yet, it's possible that after
the callback server is freed, the transport receives a
backchannel request at which point we can dereferene freed
memory. Instead, do the freeing the bc server and nullying
bc_serv under the lock.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfs/callback.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 8b674ee093a6..58e865bba03f 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -270,7 +270,10 @@ void nfs_callback_down(int minorversion, struct net *net, struct rpc_xprt *xprt)
 	if (cb_info->users == 0) {
 		svc_set_num_threads(serv, NULL, 0);
 		dprintk("nfs_callback_down: service destroyed\n");
-		svc_destroy(&cb_info->serv);
+		if (!minorversion)
+			svc_destroy(&cb_info->serv);
+		else
+			xprt_svc_destroy_nullify_bc(xprt, &cb_info->serv);
 	}
 	mutex_unlock(&nfs_callback_mutex);
 }
-- 
2.47.1


