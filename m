Return-Path: <linux-nfs+bounces-1266-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CED837647
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 23:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ADB81F27A98
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 22:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D394B5BE;
	Mon, 22 Jan 2024 22:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AshfL+Xq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC494B5AC
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 22:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705962777; cv=none; b=B2xO+Gz1EWxe82EB+5/WYMCYaYCcEcuhJRxnhFakGkAXFuYwfnifvmQJKpPl7jZTfKyUcTR+AHuDnlcVJ4T3GQv2PuGFP/GSP1KfcVx9czOod2X1Q5AFkjY9UhKvV0Gg+3bn1c1og1qxKehpdWknI+NDlZWxzUwWAZuJ53mArnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705962777; c=relaxed/simple;
	bh=WkDohQJAiOIl1Ft4waaOXjoJcWWnF6gbh1qSMCNZIGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCKAooK0tDXRpIYaOHH1bBM1o680MDprz+m3mh+TG69QrYQU8WXRDFyR3XGsOxMIXAonZkslkdIM/M0x7hHJ01sv1RCMHn3E8L9ztu4hg6UFFNFSsgGjelpNR92P6f+cWbakUiEuD50xutt5lEJQzy/fT3h8ZE5QSsw0Soi88OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AshfL+Xq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705962775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRe99Wj+tzBNI3ZsVZlJ7dd6pgKPiqDyuDCv0Ih9868=;
	b=AshfL+XqYELkK8n7DtRv8201tXTWU8DEhiKjfFN5hsyvbYgXkTn7+b1vUoRIowJKT5yVE2
	Y+OMCX5+xIUqZjLD7gvCdrq/Jrz6pprsOZPptz9Rs4rXo+ledjPdqKF9bQmjfQ/6L6RNjF
	A7zTn5QILzJ1/YvYAHwMfTz719/yLsk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-XfsFasc1N_mUuQUWqPtJ_w-1; Mon,
 22 Jan 2024 17:32:52 -0500
X-MC-Unique: XfsFasc1N_mUuQUWqPtJ_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C97C1C04184;
	Mon, 22 Jan 2024 22:32:51 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 66B69C0FDCA;
	Mon, 22 Jan 2024 22:32:48 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
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
	Marc Dionne <marc.dionne@auristor.com>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH v2 06/10] cachefiles, erofs: Fix NULL deref in when cachefiles is not doing ondemand-mode
Date: Mon, 22 Jan 2024 22:32:19 +0000
Message-ID: <20240122223230.4000595-7-dhowells@redhat.com>
In-Reply-To: <20240122223230.4000595-1-dhowells@redhat.com>
References: <20240122223230.4000595-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

cachefiles_ondemand_init_object() as called from cachefiles_open_file() and
cachefiles_create_tmpfile() does not check if object->ondemand is set
before dereferencing it, leading to an oops something like:

	RIP: 0010:cachefiles_ondemand_init_object+0x9/0x41
	...
	Call Trace:
	 <TASK>
	 cachefiles_open_file+0xc9/0x187
	 cachefiles_lookup_cookie+0x122/0x2be
	 fscache_cookie_state_machine+0xbe/0x32b
	 fscache_cookie_worker+0x1f/0x2d
	 process_one_work+0x136/0x208
	 process_scheduled_works+0x3a/0x41
	 worker_thread+0x1a2/0x1f6
	 kthread+0xca/0xd2
	 ret_from_fork+0x21/0x33

Fix this by making cachefiles_ondemand_init_object() return immediately if
cachefiles->ondemand is NULL.

Fixes: 3c5ecfe16e76 ("cachefiles: extract ondemand info field from cachefiles_object")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Gao Xiang <xiang@kernel.org>
cc: Chao Yu <chao@kernel.org>
cc: Yue Hu <huyue2@coolpad.com>
cc: Jeffle Xu <jefflexu@linux.alibaba.com>
cc: linux-erofs@lists.ozlabs.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---

Notes:
    Changes
    =======
    ver #2)
     - Move check of object->ondemand into cachefiles_ondemand_init_object()

 fs/cachefiles/ondemand.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 5fd74ec60bef..4ba42f1fa3b4 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -539,6 +539,9 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 	struct fscache_volume *volume = object->volume->vcookie;
 	size_t volume_key_size, cookie_key_size, data_len;
 
+	if (!object->ondemand)
+		return 0;
+
 	/*
 	 * CacheFiles will firstly check the cache file under the root cache
 	 * directory. If the coherency check failed, it will fallback to


