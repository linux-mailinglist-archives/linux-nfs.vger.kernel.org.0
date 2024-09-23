Return-Path: <linux-nfs+bounces-6607-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F5697EDB9
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 17:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B2A1C212E9
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 15:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536AD19F40D;
	Mon, 23 Sep 2024 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6Pu8LUS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB69E19F127
	for <linux-nfs@vger.kernel.org>; Mon, 23 Sep 2024 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104129; cv=none; b=f96/ZDtlQTrVn+OrXF9uHcNaUpZ4uKRf1TyW0f+g0kk/Tn2Kv8bWRD+U9Io4xWGuyHYBlqDWNbid1LBxYz02NuFN7NQ78ywuTRTPYLeB9plY4RojsMSiMXShIWDMzxopjLmZlAwm7IhrWlIh0tDlHAWWlidmFt5iDvr+JH6W+lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104129; c=relaxed/simple;
	bh=Nwo764kOvSkCxwONvnCvuyYj3lTosgP6VQTob6S2lp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwAOh5B6VAYfSIcTghO2w1tbJY/EdeOS/nORz6Qz5mYwA0XR42FTRXWROfl6CMAMqKLYZ+9Ag07qkhD/iWnFWPLxLNrB6/ZGImsknQK/JYJw1ohhAomQA/FffP/co8142tGIKzDmJYnSGNgbMkvWUDF/No0Xj1LtR0ygj+9GWiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6Pu8LUS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lKiHWTaBx3zx8IjGF1i+IbwHetAMo/Hx9i4LC4nBI4=;
	b=M6Pu8LUS4dpTizbo8NZhOHTAYwuGlZRWIQ5KyIFerAV17DD/Oc27sDcBPRXz4SkH4xhgcj
	zMU/20AnyHKHSFLeSUjtDZoWgI26mhZw4VQy91p2TMeJ83hi1bs7s5UgBh3iIbmjknzRoJ
	ZyZGMh3Q2KCtie38V2rXCx10RkzXLas=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-Odl9lH7FPeeRz2-0q0JfvA-1; Mon,
 23 Sep 2024 11:08:42 -0400
X-MC-Unique: Odl9lH7FPeeRz2-0q0JfvA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 059CD18BC605;
	Mon, 23 Sep 2024 15:08:40 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.145])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 51FD51977026;
	Mon, 23 Sep 2024 15:08:31 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>,
	Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Markus Suvanto <markus.suvanto@gmail.com>
Subject: [PATCH 5/8] afs: Fix possible infinite loop with unresponsive servers
Date: Mon, 23 Sep 2024 16:07:49 +0100
Message-ID: <20240923150756.902363-6-dhowells@redhat.com>
In-Reply-To: <20240923150756.902363-1-dhowells@redhat.com>
References: <20240923150756.902363-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Marc Dionne <marc.dionne@auristor.com>

A return code of 0 from afs_wait_for_one_fs_probe is an indication
that the endpoint state attached to the operation is stale and has
been superseded.  In that case the iteration needs to be restarted
so that the newer probe result state gets used.

Failure to do so can result in an tight infinite loop around the
iterate_address label, where all addresses are thought to be responsive
and have been tried, with nothing to refresh the endpoint state.

Fixes: 495f2ae9e355 ("afs: Fix fileserver rotation")
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Link: https://lists.infradead.org/pipermail/linux-afs/2024-July/008628.html
cc: linux-afs@lists.infradead.org
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20240906134019.131553-1-marc.dionne@auristor.com/
---
 fs/afs/fs_probe.c |  4 ++--
 fs/afs/rotate.c   | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index 580de4adaaf6..b516d05b0fef 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -506,10 +506,10 @@ int afs_wait_for_one_fs_probe(struct afs_server *server, struct afs_endpoint_sta
 	finish_wait(&server->probe_wq, &wait);
 
 dont_wait:
-	if (estate->responsive_set & ~exclude)
-		return 1;
 	if (test_bit(AFS_ESTATE_SUPERSEDED, &estate->flags))
 		return 0;
+	if (estate->responsive_set & ~exclude)
+		return 1;
 	if (is_intr && signal_pending(current))
 		return -ERESTARTSYS;
 	if (timo == 0)
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index ed09d4d4c211..d612983d6f38 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -632,8 +632,10 @@ bool afs_select_fileserver(struct afs_operation *op)
 wait_for_more_probe_results:
 	error = afs_wait_for_one_fs_probe(op->server, op->estate, op->addr_tried,
 					  !(op->flags & AFS_OPERATION_UNINTR));
-	if (!error)
+	if (error == 1)
 		goto iterate_address;
+	if (!error)
+		goto restart_from_beginning;
 
 	/* We've now had a failure to respond on all of a server's addresses -
 	 * immediately probe them again and consider retrying the server.
@@ -644,10 +646,13 @@ bool afs_select_fileserver(struct afs_operation *op)
 		error = afs_wait_for_one_fs_probe(op->server, op->estate, op->addr_tried,
 						  !(op->flags & AFS_OPERATION_UNINTR));
 		switch (error) {
-		case 0:
+		case 1:
 			op->flags &= ~AFS_OPERATION_RETRY_SERVER;
-			trace_afs_rotate(op, afs_rotate_trace_retry_server, 0);
+			trace_afs_rotate(op, afs_rotate_trace_retry_server, 1);
 			goto retry_server;
+		case 0:
+			trace_afs_rotate(op, afs_rotate_trace_retry_server, 0);
+			goto restart_from_beginning;
 		case -ERESTARTSYS:
 			afs_op_set_error(op, error);
 			goto failed;


