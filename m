Return-Path: <linux-nfs+bounces-411-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF9B8093F2
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 22:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F4328216B
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 21:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCDF56774;
	Thu,  7 Dec 2023 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jRrfduNF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E701FF6
	for <linux-nfs@vger.kernel.org>; Thu,  7 Dec 2023 13:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701984210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i1NCs1wijkp9oudHg0v3ZW2pY0xP/Retx1SxWP1fmpE=;
	b=jRrfduNFE8TTTlKxsMcSx8oP1gVApkG2fOe+uKKsor1M+p+Ucl2XaEkhMs8sfh15eg/t9j
	YSIQ2uP6ajA8FSZihznLkaXh3AdItL+d+9C9vGBzbjcdenEprQjf2mIj6DdZO7qjKC8V5R
	PV5VuULz4fwuKFoKpZTVvmREPKRZ0wU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-_pwwI_YRN4GTpksMjMzvlA-1; Thu, 07 Dec 2023 16:23:25 -0500
X-MC-Unique: _pwwI_YRN4GTpksMjMzvlA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D04410B9340;
	Thu,  7 Dec 2023 21:23:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C4FB72026D66;
	Thu,  7 Dec 2023 21:23:21 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 21/59] netfs: Make netfs_put_request() handle a NULL pointer
Date: Thu,  7 Dec 2023 21:21:28 +0000
Message-ID: <20231207212206.1379128-22-dhowells@redhat.com>
In-Reply-To: <20231207212206.1379128-1-dhowells@redhat.com>
References: <20231207212206.1379128-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Make netfs_put_request() just return if given a NULL request pointer.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/objects.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 7ef804e8915c..3ce6313cc5f9 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -109,19 +109,22 @@ static void netfs_free_request(struct work_struct *work)
 void netfs_put_request(struct netfs_io_request *rreq, bool was_async,
 		       enum netfs_rreq_ref_trace what)
 {
-	unsigned int debug_id = rreq->debug_id;
+	unsigned int debug_id;
 	bool dead;
 	int r;
 
-	dead = __refcount_dec_and_test(&rreq->ref, &r);
-	trace_netfs_rreq_ref(debug_id, r - 1, what);
-	if (dead) {
-		if (was_async) {
-			rreq->work.func = netfs_free_request;
-			if (!queue_work(system_unbound_wq, &rreq->work))
-				BUG();
-		} else {
-			netfs_free_request(&rreq->work);
+	if (rreq) {
+		debug_id = rreq->debug_id;
+		dead = __refcount_dec_and_test(&rreq->ref, &r);
+		trace_netfs_rreq_ref(debug_id, r - 1, what);
+		if (dead) {
+			if (was_async) {
+				rreq->work.func = netfs_free_request;
+				if (!queue_work(system_unbound_wq, &rreq->work))
+					BUG();
+			} else {
+				netfs_free_request(&rreq->work);
+			}
 		}
 	}
 }


