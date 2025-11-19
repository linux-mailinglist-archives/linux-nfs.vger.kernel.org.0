Return-Path: <linux-nfs+bounces-16537-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 343E2C6EF5A
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 14:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 301F13436AA
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 13:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0868B1E5B9E;
	Wed, 19 Nov 2025 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fr2TbXGY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B581AA7A6
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559160; cv=none; b=uekShnlOJGVpKdAycOPyYRjVS7dnN1hi3N2pGax/oD8N+L6JGa5MQ4b8dIrisIuvBlL4NVNh9EJFbDCD2ubFgj3LbYX4H9uEqIy0+m9/44EpeDVuBEVorAX5zWUa/2N5B2j3CYsyAwCTlivJ40vuKnbnVhXngvQr4kBJsjTTinY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559160; c=relaxed/simple;
	bh=hq13+e4+wsR2vklfucFhi49Ga5r5eytt5iELjajy+nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FtmrMrJ0EJQkvBWPqeYfaYvRfEVJl2YOeqfzWDXvxVmPpsbtPMBN18uJ/yxBuFtjzIsO2+KWcgXO3uXmM7wwJg5EY4Ep8fopGnjtCH5Ac1Jn5NuOI995YGK0AYJesFMelsfvCT0AfO1k95f+58UveeV5VB/ugauab9smE4u3m50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fr2TbXGY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763559158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IL/JNL2S+pIKysNrqWJnRzturTEhnrju51oarxCSAg0=;
	b=Fr2TbXGYH/posSjJuuktzTYA7wNmP86Nw5IPch9r2RxWMpToQDh/uSoR4CRuzu6gr7vkRT
	UZLlrz9RBmpAS37WaiTDKNpJVwPUdQaZ35+3GnYUtDcLpmZodqiLSbQFcUwVIXojzm/W6j
	/MYPQ9R30I8GAiksuL0EjOJgOBZ53XE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-D1wBo-dwOfm52PoUz0NrgQ-1; Wed,
 19 Nov 2025 08:32:34 -0500
X-MC-Unique: D1wBo-dwOfm52PoUz0NrgQ-1
X-Mimecast-MFC-AGG-ID: D1wBo-dwOfm52PoUz0NrgQ_1763559153
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6CFB19373D8;
	Wed, 19 Nov 2025 13:32:33 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.81.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62DC319560B0;
	Wed, 19 Nov 2025 13:32:33 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 649D150BB2B;
	Wed, 19 Nov 2025 08:32:31 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Check if we need to recalculate slack estimates
Date: Wed, 19 Nov 2025 08:32:31 -0500
Message-ID: <20251119133231.3660975-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

If the incoming GSS verifier is larger than what we previously recorded
on the gss_auth, that would indicate the GSS cred/context used for that
RPC is using a different enctype than the one used by the machine
cred/context, and we should recalculate the slack variables accordingly.

Link: https://bugs.debian.org/1120598
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 net/sunrpc/auth_gss/auth_gss.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 5c095cb8cb20..6da9ca08370d 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1721,6 +1721,14 @@ gss_validate(struct rpc_task *task, struct xdr_stream *xdr)
 	if (maj_stat)
 		goto bad_mic;
 
+	/*
+	 * Normally we only recalculate the slack variables once after
+	 * creating a new gss_auth, but we should also do it if the incoming
+	 * verifier has a larger size than what was previously recorded.
+	 */
+	if (cred->cr_auth->au_verfsize < (XDR_QUADLEN(len) + 2))
+		__set_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth->au_flags);
+
 	/* We leave it to unwrap to calculate au_rslack. For now we just
 	 * calculate the length of the verifier: */
 	if (test_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth->au_flags))
-- 
2.51.0


