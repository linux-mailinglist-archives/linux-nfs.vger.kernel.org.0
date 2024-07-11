Return-Path: <linux-nfs+bounces-4820-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DCD92EB95
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 17:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79160283B97
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 15:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2D916B392;
	Thu, 11 Jul 2024 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YD3sz3QZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D36316A94B
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720711449; cv=none; b=lS1GWhclxTaF1iFP2RMpYx5YQG/RIvNmMsPU1jwJSWggvxfmErYhk/mvNORAkzybBAC0bI3I9SEtCUJNYqAnC7NJTNGZIIS41Wjtko+1CuVYBITpePOx1wEhlNCYB/8FsNzzfQCkVqMugrwBC4PaeM5v+kJpzFYgeTzaMiGif8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720711449; c=relaxed/simple;
	bh=XKCtny0M4vZC/aT4ezPa/aIWVsNn35GsVk/+8RDvtTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V6DIp9RgS1+IlvOOVBdAI0sImXhTuFyYk6KpvUdU0vmSy0JFSeJuPXv4Ru9koKhI5/NvboTZU+00sbVqDEQBFq9qvb2j9CfDXDPzpkKvzpOw2fB+nRC8sVWUik/FMzbgwcwuy6Ne5KSm8qDY5AJAJQf1e6LEHe6NTlWxfQP7nMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YD3sz3QZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720711446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pUoDF5cZQCbjVAbx3HMXke4FPr6VI2ovKsRjxGXmI7o=;
	b=YD3sz3QZ3noVkWwmBa4XGL93ATjy13kFT1x3QVP5HfbrhgmSqnaHMAC8TGH/SlCfRpqiPB
	Y6G1iDdjaHQCXy44aYMWuSSLmQbu75Oi+DoFrPbvcaDzGWyiq0WNJgqC/HNjiko3AkJ7Kx
	qRU24kqavh6H6+x6QRxzb22+eXlPIKU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-VoeuxGJVPHiW27cYDh1yEA-1; Thu,
 11 Jul 2024 11:24:05 -0400
X-MC-Unique: VoeuxGJVPHiW27cYDh1yEA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD23719560A1;
	Thu, 11 Jul 2024 15:24:03 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D1B9B1955F40;
	Thu, 11 Jul 2024 15:24:02 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Fixup gss_status tracepoint error output
Date: Thu, 11 Jul 2024 11:24:01 -0400
Message-ID: <27526e921037d6217bdfc6a078c53d37ae9effab.1720711381.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The GSS routine errors are values, not flags.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 include/trace/events/rpcgss.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index 7f0c1ceae726..b0b6300a0cab 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -54,7 +54,7 @@ TRACE_DEFINE_ENUM(GSS_S_UNSEQ_TOKEN);
 TRACE_DEFINE_ENUM(GSS_S_GAP_TOKEN);
 
 #define show_gss_status(x)						\
-	__print_flags(x, "|",						\
+	__print_symbolic(x, 						\
 		{ GSS_S_BAD_MECH, "GSS_S_BAD_MECH" },			\
 		{ GSS_S_BAD_NAME, "GSS_S_BAD_NAME" },			\
 		{ GSS_S_BAD_NAMETYPE, "GSS_S_BAD_NAMETYPE" },		\
-- 
2.44.0


