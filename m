Return-Path: <linux-nfs+bounces-15803-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9007C213CA
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 17:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3765E4E903F
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 16:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04662366FC0;
	Thu, 30 Oct 2025 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O18vCFOe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315061E7C19
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842143; cv=none; b=nQkUNAD9iHzCx+/YshVyF5GF96OeI6bS6kIcC98kUvLycH8Bkx3PpRnI2KeKq3woCNldoAoL/Amug49pcAPwAW5beRP5UUraCAdMfcFWIR2qPtzP5kBcJrI6Z5iP9mOiUGLhzg8LocYT2vEX06g5TXN7mqfU/VT5UtwAXwoqOBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842143; c=relaxed/simple;
	bh=vyvyWKEtJ/oQWZaxv/MrEHu3/g0GjvMtBRyuBaF8JJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TiGn7AjOhgGkm9JIaXsz3Ai5e1CpGGUIk+oFQLp1y1b1BNVHDD+HrQNP1Pww3n8xfsro6iwSq7vuIcylGrN8SUBcay5egBkDMhvPSDrqYHzxqSe8P4oYQXTgBdq+8KQAF2hkQr0ML0LiHXtvNNe2zClQ66n2ZTYn97t5ozQ25Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O18vCFOe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761842141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n3kEWy7kmmM+9RGuMPLWOu4CZO5HC2jRVeRIbpOw9L8=;
	b=O18vCFOeuSCdQAr9rXGu1V/GZN7rz+A3pcly4H2yx2T9LVFTm2c+tHqudqaSnszOTuiU3e
	u9gXGO3r01lf8d1Kf+ZFqR+Vd9s9msxzRA2+YmMG7hn6WEWo6PKiRSANMe06z8u3g9034i
	rjNunC2GR7D+KadZnWv7We97O7Bez8I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-tCIGT9DcOves27mCVh6CgA-1; Thu,
 30 Oct 2025 12:35:37 -0400
X-MC-Unique: tCIGT9DcOves27mCVh6CgA-1
X-Mimecast-MFC-AGG-ID: tCIGT9DcOves27mCVh6CgA_1761842135
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 206D91954B0D;
	Thu, 30 Oct 2025 16:35:35 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.64.252])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D955F1800583;
	Thu, 30 Oct 2025 16:35:33 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH 1/1] NFSD: don't start nfsd if sv_permsocks is empty
Date: Thu, 30 Oct 2025 12:35:32 -0400
Message-ID: <20251030163532.54626-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Previously, while trying to create a server instance, if no
listening sockets were present then default parameter udp
and tcp listeners were created. It's unclear what purpose
was of starting these listeners were and how this could have
been triggered by the userland setup. This patch proposed
to ensure the reverse that we never end in a situation where
no listener sockets are created and we are trying to create
nfsd threads.

The problem it solves is: when nfs.conf only has tcp=n (and
nothing else for the choice of transports), nfsdctl would
still start the server and create udp and tcp listeners.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfssvc.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 7057ddd7a0a8..40592b61b04b 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -249,27 +249,6 @@ int nfsd_nrthreads(struct net *net)
 	return rv;
 }
 
-static int nfsd_init_socks(struct net *net, const struct cred *cred)
-{
-	int error;
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-
-	if (!list_empty(&nn->nfsd_serv->sv_permsocks))
-		return 0;
-
-	error = svc_xprt_create(nn->nfsd_serv, "udp", net, PF_INET, NFS_PORT,
-				SVC_SOCK_DEFAULTS, cred);
-	if (error < 0)
-		return error;
-
-	error = svc_xprt_create(nn->nfsd_serv, "tcp", net, PF_INET, NFS_PORT,
-				SVC_SOCK_DEFAULTS, cred);
-	if (error < 0)
-		return error;
-
-	return 0;
-}
-
 static int nfsd_users = 0;
 
 static int nfsd_startup_generic(void)
@@ -377,9 +356,12 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 	ret = nfsd_startup_generic();
 	if (ret)
 		return ret;
-	ret = nfsd_init_socks(net, cred);
-	if (ret)
+
+	if (list_empty(&nn->nfsd_serv->sv_permsocks)) {
+		pr_warn("NFSD: not starting because no listening sockets found\n");
+		ret = -EIO;
 		goto out_socks;
+	}
 
 	if (nfsd_needs_lockd(nn) && !nn->lockd_up) {
 		ret = lockd_up(net, cred);
-- 
2.47.3


