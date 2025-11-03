Return-Path: <linux-nfs+bounces-15947-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A254C2D8C6
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 18:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33C034E704D
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 17:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106D8226D16;
	Mon,  3 Nov 2025 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Md+o2sRP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C256A1C5F13
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192666; cv=none; b=VNAYIloC4HI6z+XyG6QJeznCV30VvFD6tiVc8dbbjIZR/PCzllSwc4YIqV/Wbk5pljHY3YNsyTx8Za61bQxL9+bZ3ClKvVkPpL77waBtC2cqAPuwWvT69y5/EXmBddZ43/V/GpGjY2zsUoqhSgQob/hHIglu8RizSRAppFpFQ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192666; c=relaxed/simple;
	bh=abzbLSDLA2IheCUQQCuhfOV17jVIRH8LiYFeLNUcvhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nHOzKjzM9rk5xNNvCBwnKmSsUH8o9gUJKLrtMjXsRFnn/64JrtIurtEzj+TeuJsr4QNGgV+sg4LL8EX8hKfCsSFW7+driKTZ8rSXlyudTsji2GcNNECw7Q1/Pg8aaz/ndx1NfNT9J5SITC5n4jFsHL+tAxEx9Q4qBJHhBsNa0z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Md+o2sRP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762192662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZDCIr0Vc5P3zUicFNGVlmH7XplhQb16+RM48ldJjpq0=;
	b=Md+o2sRP0gSBxLsi0wFzMbBxubR/ALbMN3m9a2YzCucewYUgHP3njncmFfV1a+2ZXHO7vg
	q4TuM6ktdnScbF09CnirDSd5G/IyWezE5GVWtGNE5VEDdS3rzmZtyjknlN3zppeZJXPYmu
	xwzDMFAj/wQu2KcCLA0aPpmiDoqr2hk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-a4Rn5CYkNb6JAo772bHSyQ-1; Mon,
 03 Nov 2025 12:57:39 -0500
X-MC-Unique: a4Rn5CYkNb6JAo772bHSyQ-1
X-Mimecast-MFC-AGG-ID: a4Rn5CYkNb6JAo772bHSyQ_1762192657
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E16F1195609F;
	Mon,  3 Nov 2025 17:57:36 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.81.195])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D7DA1800576;
	Mon,  3 Nov 2025 17:57:35 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH v2 1/1] NFSD: don't start nfsd if sv_permsocks is empty
Date: Mon,  3 Nov 2025 12:57:34 -0500
Message-ID: <20251103175734.38634-1-okorniev@redhat.com>
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
index 7057ddd7a0a8..b08ae85d53ef 100644
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
+		pr_warn("NFSD: Failed to start, no listeners configured.\n");
+		ret = -EIO;
 		goto out_socks;
+	}
 
 	if (nfsd_needs_lockd(nn) && !nn->lockd_up) {
 		ret = lockd_up(net, cred);
-- 
2.47.3


