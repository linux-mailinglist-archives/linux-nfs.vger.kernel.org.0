Return-Path: <linux-nfs+bounces-13585-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13417B236CA
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 21:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E230C1899822
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 19:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536153FE7;
	Tue, 12 Aug 2025 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FozovN8M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8478B2882CE
	for <linux-nfs@vger.kernel.org>; Tue, 12 Aug 2025 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025376; cv=none; b=GLvpNBI0NlVG6qapktzovvm3uqFikBEWLP4EpJWWqlAL0K5bhAS6KKE2BENZ+8r4DpiFs7Sc8t6A15mSrp21xggNaIlDh0Cg+xTt4vaRgeM4eXxdbJ6re6Clt6FOMQ7YLsgsnLznqsqlyPuPhcYCzPQVTGhaNhlDDfcrt4wdW3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025376; c=relaxed/simple;
	bh=Tpcw4qX3ZBhisC8xGWWSrRYVNKCjvLqcehHIJdqtGLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HjoGRxmZlMeyQJCdkphPmu3efEV+KniqLFZ+nJZRnJb4gTBCr2AdSLV57YPRNjTzOOpljExS18C36TaYaH1zm/7oaV18UYef/FXViSsu2KSUT6hdV9HikYCWvuAM1rlBW34ionJWfCqGIBmUCiJdXEnbnDtHu6HK1m93bud/YOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FozovN8M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755025373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3SETwERK4Xp92seE8FHVjgq9oouDqtz7Ks+D9/ZMhJg=;
	b=FozovN8MbRDUOEx7FmrXATcXzdO0/mwr9nw/E8Pxyv694lhEsmFsRiDOLwFUZaXAD2GAY7
	FvdxCVu9GDk7LwLTJiymUMZSHAf6GSUVMmQsk0rKv9vBfIDae3HQlfSRmjyTd1jhmkBIfa
	DtYaWR2/NR9RAQTAgEGaEVmmbxJ+97g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121--DG-Tk58OzeW8yrEJ2ZrAQ-1; Tue,
 12 Aug 2025 15:02:48 -0400
X-MC-Unique: -DG-Tk58OzeW8yrEJ2ZrAQ-1
X-Mimecast-MFC-AGG-ID: -DG-Tk58OzeW8yrEJ2ZrAQ_1755025367
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAEAA19560A0;
	Tue, 12 Aug 2025 19:02:46 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.82.47])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 09D1F30001A1;
	Tue, 12 Aug 2025 19:02:44 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neil@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH 1/1] nfsd: unregister with rpcbind when removing listener
Date: Tue, 12 Aug 2025 15:02:44 -0400
Message-Id: <20250812190244.30452-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When a listener is added, a part of creation of transport also registers
program/port with rpcbind. However, when the listener is removed,
while transport goes away, rpcbind still has the entry for that
port/type.

Removal of listeners works by first removing all transports and then
re-adding the ones that were not removed. In addition to destroying
all transports, now also call the function that unregisters everything
with the rpcbind. But we also then need to call the rpcbind setup
function before adding back new transports.

Fixes: d093c9089260 ("nfsd: fix management of listener transports")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfsctl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 2909d70de559..99d06343117b 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1998,8 +1998,11 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	 * Since we can't delete an arbitrary llist entry, destroy the
 	 * remaining listeners and recreate the list.
 	 */
-	if (delete)
+	if (delete) {
 		svc_xprt_destroy_all(serv, net);
+		svc_rpcb_cleanup(serv, net);
+		svc_bind(serv, net);
+	}
 
 	/* walk list of addrs again, open any that still don't exist */
 	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
-- 
2.47.1


