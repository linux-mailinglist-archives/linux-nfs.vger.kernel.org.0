Return-Path: <linux-nfs+bounces-4833-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FE592EDA5
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 19:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA67282955
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 17:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D0576034;
	Thu, 11 Jul 2024 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MriThhJa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A2616B38E
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720718472; cv=none; b=BQ1EYSfKqSp42pNhfKxtqhjd81DPtPP+86Vz2BJcwwWgFKg/4HhEaG6es2SYGc4S5V+cO7v6Z+kAFSx3Tdr+BpD21p81pbgvyq7aLdGF6kYdcd55kT+YFske8UR6Iq/OwDchnNg/w3vAoPJJ7hjU4N5024i3WGacVB413t32bI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720718472; c=relaxed/simple;
	bh=JaQgHDGBeoQb17k/HozbOecKQXVUmkT7g6dv1GmhxuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kkCBIDMcGROPFxbMvwnjfwhVSgFbjIJslemRfqkAVO/nsnNaljTX/9IcaM/BaIUKjw5fEvq5G4HbT+RYxwHlHRo+4SZs60PTdXjU7mVdOfcVqSZQSPP7lJgTd93fwPkYZpcUMnj9pYReUiHZt92euV6tM/SELUUDnDqixv7bZZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MriThhJa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720718470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zTgb4XnrSF2JsrhnujfAc78DvoOR9T6PfKlfxL2wHHw=;
	b=MriThhJaMegLFc+ROHoxdScabuKWGYBJZBa8lvcAgG22Fr9vJVH+GdbrHSaMnZZH6YMKAb
	YDRJCVutSYrdhss9jMU8PxNft4ji5NbDDwnlz+x3jWPnXihaYMhEgwf2eTaC/4eZdUKITP
	L/cmJKcdhltgN7J8TMASMDj4TVp1fo8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-R3XOI78hPVycLkCyJSRO9g-1; Thu,
 11 Jul 2024 13:21:04 -0400
X-MC-Unique: R3XOI78hPVycLkCyJSRO9g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF1EA1955F67;
	Thu, 11 Jul 2024 17:21:02 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A45AC1955F40;
	Thu, 11 Jul 2024 17:21:01 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2] SUNRPC: Fixup gss_status tracepoint error output
Date: Thu, 11 Jul 2024 13:21:00 -0400
Message-ID: <64be9532e67958ed0051f6b10a89661e98a52023.1720718397.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The GSS routine errors are values, not flags.

Fixes: 0c77668ddb4e ("SUNRPC: Introduce trace points in rpc_auth_gss.ko")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
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


