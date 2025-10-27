Return-Path: <linux-nfs+bounces-15715-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CF5C10EC5
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 20:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9BFD935314E
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 19:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF4630F534;
	Mon, 27 Oct 2025 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eH8bcUeo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B1F2D8377
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 19:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593010; cv=none; b=rmfq0RQN4yJeVao+GzRxYuw09ZOxSJrZQFRKjqRrSezVRzCvBIb9DTzqbM83J7Z60zhJpiyFUQe9M5u9fNKX6sRxi53UL/qITqZdx51jPw/RDbecZYTygFtBBpSQMvbMuyefOOX/Mk9SMNVcvbJYDs+f2I1uvBNqD0LWlb/EiwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593010; c=relaxed/simple;
	bh=N9k/Jd2kBbBgrM6T0K17PEccw/qLrEGu0Z2uT7mwB9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOxfo9giBjI2hcKYddIr6J4R1cKgAJMmOz4NsoamGWTSEQNjpyTHbYZd1/OtAPZ+DT3aTWX2VuR+jwdV6P1gj59zglUIyw/AAVy27eI1r/00wf+bc4N0Q8Ib2sCAh1thsN9ZIqbgmmJyG3YYtLywm00ZMF6Eq8KWr+0Wk1oQiZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eH8bcUeo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761593007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDHcT8Bma5LoXPK3HnyfCCqD7fk4He1BCLKN7BNUxgo=;
	b=eH8bcUeoPUUj8anwFwM0PY8G9w82z3oTNB+ffUXxCfso49UTrzanlk7mQM13+GVZbO0wE7
	IOy/GktsRaawGhcZWTHGAbZH1GkEAFmdybfctiaVUySqzNdWHxb3ETTk0OHeK0ztS2teC9
	5dTkgGpDmOeKigxKAOuLszrllza+yb8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-6PeU8gWOMBi2SrbxRKZhBA-1; Mon,
 27 Oct 2025 15:23:24 -0400
X-MC-Unique: 6PeU8gWOMBi2SrbxRKZhBA-1
X-Mimecast-MFC-AGG-ID: 6PeU8gWOMBi2SrbxRKZhBA_1761593003
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FC5C18089A6;
	Mon, 27 Oct 2025 19:23:23 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.89.72])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BEC5530001A2;
	Mon, 27 Oct 2025 19:23:22 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [RFC PATCH 3/3] NFSv4.1: protect destroying and nullifying bc_serv structure
Date: Mon, 27 Oct 2025 15:23:18 -0400
Message-ID: <20251027192318.86366-4-okorniev@redhat.com>
In-Reply-To: <20251027192318.86366-1-okorniev@redhat.com>
References: <20251027192318.86366-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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


