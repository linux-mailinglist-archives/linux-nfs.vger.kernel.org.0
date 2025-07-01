Return-Path: <linux-nfs+bounces-12836-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF5BAF000E
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jul 2025 18:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444123B7043
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jul 2025 16:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A248A27F01B;
	Tue,  1 Jul 2025 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIgTbIr3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA09427E7D8
	for <linux-nfs@vger.kernel.org>; Tue,  1 Jul 2025 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387954; cv=none; b=gkC5G0rwAnCjy7F2TEh03KPkcvn0lT1xlwVeFaxa1rXYNn3iwGLRXwcPcDxXgy+/X2f0GWiBUlrdICaswatnrfGUjgqYMEHgRc7HoXl4nAxfLPc4wkNEb1OQRJ/sVedzGKkCtd1huOmsLzJSr5qZ1Ds/XdaeUUqH32ObDKn/mrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387954; c=relaxed/simple;
	bh=uT1tmzY8aqGpAfMHZ/0ZFb7NqQ+YPhzb8xiQfHsiL6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUmbGOfYCkOkqqKvpJhCUlJZgofSHixHHJiWoatHJ25ZZpZw/frNLJJYyLMr23kwnsybibSfn1r45OKxOaAufLUEKBs1gd7U5pf4BRFVA26wkSYoMzPpGkLYuCE5PlZgR9aagdxkpTbOTDrJCKbztZpK5Z5mMyyq3W4Sa8EKMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IIgTbIr3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751387951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7k4azEyuX7ZG5TiA6CUYD8w2mJuuzVeBBXu65ekEOQ=;
	b=IIgTbIr3lILEUKhZOTU6T5pbFZH7oFpNe9zhz8yJ/dR8d8omjQ/7WC1auSlVrm05I9YKfD
	fQ5qOUu0CQnDYEr6s3XdNSyVosqc1MFD6Zw54Oy9+ETEQnxPC+qAFiW0OAx7MxAkuZdMbD
	8k1XpvZZrJD4c9pQHnOoEceDHUCoeHE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-EQ2zBC8qOSuiT9NcI9_FlQ-1; Tue,
 01 Jul 2025 12:39:07 -0400
X-MC-Unique: EQ2zBC8qOSuiT9NcI9_FlQ-1
X-Mimecast-MFC-AGG-ID: EQ2zBC8qOSuiT9NcI9_FlQ_1751387946
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C20F18011EF;
	Tue,  1 Jul 2025 16:39:05 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AC737180045B;
	Tue,  1 Jul 2025 16:39:01 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH 01/13] netfs: Fix hang due to missing case in final DIO read result collection
Date: Tue,  1 Jul 2025 17:38:36 +0100
Message-ID: <20250701163852.2171681-2-dhowells@redhat.com>
In-Reply-To: <20250701163852.2171681-1-dhowells@redhat.com>
References: <20250701163852.2171681-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

When doing a DIO read, if the subrequests we issue fail and cause the
request PAUSE flag to be set to put a pause on subrequest generation, we
may complete collection of the subrequests (possibly discarding them) prior
to the ALL_QUEUED flags being set.

In such a case, netfs_read_collection() doesn't see ALL_QUEUED being set
after netfs_collect_read_results() returns and will just return to the app
(the collector can be seen unpausing the generator in the trace log).

The subrequest generator can then set ALL_QUEUED and the app thread reaches
netfs_wait_for_request().  This causes netfs_collect_in_app() to be called
to see if we're done yet, but there's missing case here.

netfs_collect_in_app() will see that a thread is active and set inactive to
false, but won't see any subrequests in the read stream, and so won't set
need_collect to true.  The function will then just return 0, indicating
that the caller should just sleep until further activity (which won't be
forthcoming) occurs.

Fix this by making netfs_collect_in_app() check to see if an active thread
is complete - i.e. that ALL_QUEUED is set and the subrequests list is empty
- and to skip the sleep return path.  The collector will then be called
which will clear the request IN_PROGRESS flag, allowing the app to
progress.

Fixes: 2b1424cd131c ("netfs: Fix wait/wake to be consistent about the waitqueue used")
Reported-by: Steve French <sfrench@samba.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.org>
Tested-by: Steve French <sfrench@samba.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/misc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 43b67a28a8fa..0a54b1203486 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -381,7 +381,7 @@ void netfs_wait_for_in_progress_stream(struct netfs_io_request *rreq,
 static int netfs_collect_in_app(struct netfs_io_request *rreq,
 				bool (*collector)(struct netfs_io_request *rreq))
 {
-	bool need_collect = false, inactive = true;
+	bool need_collect = false, inactive = true, done = true;
 
 	for (int i = 0; i < NR_IO_STREAMS; i++) {
 		struct netfs_io_subrequest *subreq;
@@ -400,9 +400,11 @@ static int netfs_collect_in_app(struct netfs_io_request *rreq,
 			need_collect = true;
 			break;
 		}
+		if (subreq || !test_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags))
+			done = false;
 	}
 
-	if (!need_collect && !inactive)
+	if (!need_collect && !inactive && !done)
 		return 0; /* Sleep */
 
 	__set_current_state(TASK_RUNNING);


