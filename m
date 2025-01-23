Return-Path: <linux-nfs+bounces-9544-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDC1A1AA68
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 20:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0525918802CF
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 19:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B803A6F06B;
	Thu, 23 Jan 2025 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjR8AYO1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3582B17741
	for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661125; cv=none; b=HgnKz87hJoB+claJ+8M9VJydY9lVHTLiqGLVPciKBQnH7dKub44XGuPyuGlN744LyU7a6xa1EENbNlh0bplPSRGxdM7ZKtKIan/Dc2l7QOYhk0YyBujGWN9ZEEXc5OUybVNCO2gtf6uOcDTjtN+po0UB21Hmx05bv5oqs1SkSR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661125; c=relaxed/simple;
	bh=yzuK0DvK5VoJfIe3DGk8FgpKaM3Eosh64x1aqPTonbo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZuJfOaCioesXkSPMD9jQNd4qUxVIO/Cd189iATYfSPUCtsQhT6SoN4Ime8pVKMr50c8NJG/ozE7drfO1rJB/uM73zREysOdC79gSTl093l9SmiRKNpEuRe3qBoLvo1566KTFlntXzKpBEOnFGtsbYeZKReIInOCnCBx7Eli6U5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cjR8AYO1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737661122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EYqLSBmPPIe9J2S6EQFDQnSa4jauIHqnsfL8eMP8VVA=;
	b=cjR8AYO1WcJMvSBM+Vaaag7dAaGG6/ohnRjYnuyatdRh6neA0RcTs4pHcVR8xu4q7SwzJL
	1MxZGtwHqNy5lr8AYqAhDIU1TLsRPsIO/THtlPPNX7hsSyRh+saYQF2EWRj5DpWCqfVn6d
	Hpf2RLbieUwdmdW2l9FZ5lXVQyXX368=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-d4okew-FP4uSuK8KJKqjBA-1; Thu,
 23 Jan 2025 14:38:38 -0500
X-MC-Unique: d4okew-FP4uSuK8KJKqjBA-1
X-Mimecast-MFC-AGG-ID: d4okew-FP4uSuK8KJKqjBA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDF9D195608A;
	Thu, 23 Jan 2025 19:38:36 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.65.186])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 37F5A19560A7;
	Thu, 23 Jan 2025 19:38:35 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@suse.de,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 1/1] nfsd: adjust WARN_ON_ONCE in revoke_delegation
Date: Thu, 23 Jan 2025 14:38:31 -0500
Message-Id: <20250123193831.87330-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

A WARN_ON_ONCE() is added to revoke delegations to make sure that the
state has been marked for revocation. However, that's only true for 4.1+
stateids. For 4.0 stateids, in unhash_delegation_locked() the sc_status
is set to SC_STATUS_CLOSED. Modify the check to reflect it, otherwise
a WARN_ON_ONCE is erronously triggered.

Fixes: 8dd91e8d31fe ("nfsd: fix race between laundromat and free_stateid")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b7a0cfd05401..d2d3feba36cd 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1378,7 +1378,8 @@ static void revoke_delegation(struct nfs4_delegation *dp)
 	struct nfs4_client *clp = dp->dl_stid.sc_client;
 
 	WARN_ON(!list_empty(&dp->dl_recall_lru));
-	WARN_ON_ONCE(!(dp->dl_stid.sc_status &
+	WARN_ON_ONCE(dp->dl_stid.sc_client->cl_minorversion > 0 &&
+		     !(dp->dl_stid.sc_status &
 		     (SC_STATUS_REVOKED | SC_STATUS_ADMIN_REVOKED)));
 
 	trace_nfsd_stid_revoke(&dp->dl_stid);
-- 
2.47.1


