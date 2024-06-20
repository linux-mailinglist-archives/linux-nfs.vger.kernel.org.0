Return-Path: <linux-nfs+bounces-4188-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 461F5911218
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 21:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01A21F24E79
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 19:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9881B9AD5;
	Thu, 20 Jun 2024 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUI6f0C1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB1B1AC765
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718911819; cv=none; b=NQzABt0emHAvLg7nPKP4MpoYjRNYi1DQwb4/khOvtrfIqN7XME9LYKzZ5SiTCxYbxQHAjDtLUa9gnwYvTHcnW2xqDYqmXhwJYfI7yXSEW6rPkxVsTroEklOYI+Zmd26uZha4uBju7+V3yHvfBbZ/DkmXAQhk0zdk/iwMo4HyhG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718911819; c=relaxed/simple;
	bh=Qt/f001x8Q0vKKDBE7TSU1xOBp1sWnrsaYRgABuCTXM=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=CNUxqA044tIbKJxZ+bPgQAoKZP8/uJQOc5jrJ4gdoHx+3nWAGuqv7YxrdSma8bJYrg2uxwrrz4z9+4nJ08eotPErm9YVcGHpy/wcbiyf+zPvwkwbb1HmqeVO7C9vxZg9OPy0mXXvw/T2UhDRUggIFGf7Sjzo6VYcE3DyvVaxLbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FUI6f0C1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718911815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uwdtAySFtKK2OLXgT+61d7SC+sWlPRojSuQ75KtZ2Nc=;
	b=FUI6f0C1BlKurJ5u9Si4G8BSEO5GQDvIZpusJ8HiYN0vZuXOebgc6SmMNIc01W+W40zj62
	tOU66ulr3j1V6ukmdvzKoUHkFLRWsDo+lViUDQ7NO+kIE+ASkPI84BD8qHiy0onWml0du9
	+KdVUrgPhD/sq0Tb0hysolJ9J7im+Ic=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-A6ZZI-hHP42woi_qbb99ZA-1; Thu,
 20 Jun 2024 15:30:13 -0400
X-MC-Unique: A6ZZI-hHP42woi_qbb99ZA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81A401956088;
	Thu, 20 Jun 2024 19:30:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.156])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E2001956087;
	Thu, 20 Jun 2024 19:30:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240620173137.610345-10-dhowells@redhat.com>
References: <20240620173137.610345-10-dhowells@redhat.com> <20240620173137.610345-1-dhowells@redhat.com>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>,
    Jeff Layton <jlayton@kernel.org>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/17] cifs: Defer read completion
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <612370.1718911800.1@warthog.procyon.org.uk>
Date: Thu, 20 Jun 2024 20:30:00 +0100
Message-ID: <612371.1718911800@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Oops - a bit of debugging code had got left in this patch and I forgot to
fill out the description.  Updated patch attached.

David
---
cifs: Defer read completion

Defer read completion from the I/O thread to the cifsiod thread so as not
to slow down the I/O thread.  This restores the behaviour of v6.9.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smb2pdu.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 38a06e8a0f90..e213cecd5094 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4484,6 +4484,16 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 	return rc;
 }
 
+static void smb2_readv_worker(struct work_struct *work)
+{
+	struct cifs_io_subrequest *rdata =
+		container_of(work, struct cifs_io_subrequest, subreq.work);
+
+	netfs_subreq_terminated(&rdata->subreq,
+				(rdata->result == 0 || rdata->result == -EAGAIN) ?
+				rdata->got_bytes : rdata->result, true);
+}
+
 static void
 smb2_readv_callback(struct mid_q_entry *mid)
 {
@@ -4578,9 +4588,8 @@ smb2_readv_callback(struct mid_q_entry *mid)
 			rdata->result = 0;
 	}
 	rdata->credits.value = 0;
-	netfs_subreq_terminated(&rdata->subreq,
-				(rdata->result == 0 || rdata->result == -EAGAIN) ?
-				rdata->got_bytes : rdata->result, true);
+	INIT_WORK(&rdata->subreq.work, smb2_readv_worker);
+	queue_work(cifsiod_wq, &rdata->subreq.work);
 	release_mid(mid);
 	add_credits(server, &credits, 0);
 }


