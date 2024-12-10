Return-Path: <linux-nfs+bounces-8509-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C6F9EB406
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 15:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA734286160
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 14:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B116B1A2389;
	Tue, 10 Dec 2024 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6EIMpRN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0141A9B25
	for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842406; cv=none; b=nUb36pDaUkBpRPKVZqFvy/Fg026aQ1J+8BJD+xloIiQ5j53t8rcpzsJGsT0kGad7exTmRZ3OI5x0SohBqix3W+Uqj//Egv3wTMNKQQB0eCpVi48YpnF5HZDSWYb0ylZwn06wcnpN1YIWyGUIrU2v2KqocJwYPKzqYEU5asbXiEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842406; c=relaxed/simple;
	bh=uTa/lBLietCuUfe0XcM5vlYIN5s6xguVoMLTN2F94+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DyjYvssgUmJa8iQNpd1l07xo4LmG55yQE0J0cXkOT+f23ukVpmeDoRrZrByZUreGgFfTdSY7hlvd7M+f9Gk005zKODjsypKSnm5hJyT1kBQyacIliF7xg8xVzurntRpa9XpujKsFOmnkVVKGp7YnyXe8JSrMPWRbiyAhuJ3fGMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h6EIMpRN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733842403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=io5bbeV8+yj9M/pxlfkVOg9q/DEsngnyV1yPYFNp39k=;
	b=h6EIMpRNvMl1V3RjTRyHXwMh+msGwmvKCNBTcLE31dG/VTX8RDWKgYcgl3XeEbDy5Hy5Pc
	7zz8/6Bp/+fVEZ5h07JWmDVUzzvFBSweOayPviZNhPoYibqJptOQS3tDQkiKA05ktVc8i/
	ZHvnqoP/zLlS2E+Ed2eUEwPu8HN0A1Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-JFE45WakPlOJgSqcag66vA-1; Tue,
 10 Dec 2024 09:53:19 -0500
X-MC-Unique: JFE45WakPlOJgSqcag66vA-1
X-Mimecast-MFC-AGG-ID: JFE45WakPlOJgSqcag66vA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 385761954211;
	Tue, 10 Dec 2024 14:53:18 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.82.57])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9CE519560A7;
	Tue, 10 Dec 2024 14:53:17 +0000 (UTC)
Received: from aion.. (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 08F2F2E6672;
	Tue, 10 Dec 2024 07:25:55 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: jur@avtware.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: fix legacy client tracking initialization
Date: Tue, 10 Dec 2024 07:25:54 -0500
Message-ID: <20241210122554.133412-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Get rid of the nfsd4_legacy_tracking_ops->init() call in
check_for_legacy_methods().  That will be handled in the caller
(nfsd4_client_tracking_init()).  Otherwise, we'll wind up calling
nfsd4_legacy_tracking_ops->init() twice, and the second time we'll
trigger the BUG_ON() in nfsd4_init_recdir().

Fixes: 74fd48739d04 ("nfsd: new Kconfig option for legacy client tracking")
Reported-by: Jur van der Burg <jur@avtware.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219580
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfsd/nfs4recover.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 4a765555bf84..1c8fcb04b3cd 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -2052,7 +2052,6 @@ static inline int check_for_legacy_methods(int status, struct net *net)
 		path_put(&path);
 		if (status)
 			return -ENOTDIR;
-		status = nn->client_tracking_ops->init(net);
 	}
 	return status;
 }
-- 
2.47.1


