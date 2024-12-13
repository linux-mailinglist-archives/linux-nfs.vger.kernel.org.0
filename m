Return-Path: <linux-nfs+bounces-8547-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D669F0E01
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2024 14:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57178166F03
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2024 13:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6B31EE005;
	Fri, 13 Dec 2024 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZhWmtxF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFA11EC006
	for <linux-nfs@vger.kernel.org>; Fri, 13 Dec 2024 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097891; cv=none; b=db6rr6Dra+Xxou7iDm0E0JJwiyQPy1ZXeOANhUGdzjX+PDKTrj6DCZU2Fl05nvywbGXKyo50R511Na9BwsUwokw2wQ0SEVrD7jAB4D09E2nhgiDm9Ejk57kLVIZONzfxGQ9o2/hjk5ErE+y6qB8TiMgcr3zMiMr2Dv6/GBHmTZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097891; c=relaxed/simple;
	bh=B2Rk1xKelgaywPU+miIC1Gb2wuBFPqc4FdpMnAnCr7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3uZUOlMuCV1ldNADs/nP+iqXwbVLq6fvHqfUJtZLph5ldXXnfNddus7JU84eKAr4fBkAIXy1bVxowJzHjN0erWvY3/Ip5gyb72tq+7MFMUfHYG4sONLhhXcKCT8O2YtNMvIZ36sBOeybpCNwjLBAAwSgeYwShcl5OvSgJkavaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZhWmtxF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uxmqCJdKFxLw/y1tKF8ZCDzW6SWRkgRIhZKChhoKrx8=;
	b=hZhWmtxFvkwy4PGSwgaZns361J3sfMRa04hpPapFvdcg2XHpEiE1A5m8foCDlzI+ipWFX8
	25pe3vva/EVyjzdp20BOAlYBnQP9wgAe++pvdPdM+zbkPFA8djBGiKzh1vLr5GmadeQ6AZ
	UBmMyQTqhER5AkPKcb3Bej1pcykUugM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-dpcO627eMBu77q5ky2OXKQ-1; Fri,
 13 Dec 2024 08:51:23 -0500
X-MC-Unique: dpcO627eMBu77q5ky2OXKQ-1
X-Mimecast-MFC-AGG-ID: dpcO627eMBu77q5ky2OXKQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AFF11955E95;
	Fri, 13 Dec 2024 13:51:21 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 643061956086;
	Fri, 13 Dec 2024 13:51:16 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	Trond Myklebust <trondmy@kernel.org>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] netfs: Fix ceph copy to cache on write-begin
Date: Fri, 13 Dec 2024 13:50:09 +0000
Message-ID: <20241213135013.2964079-10-dhowells@redhat.com>
In-Reply-To: <20241213135013.2964079-1-dhowells@redhat.com>
References: <20241213135013.2964079-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

At the end of netfs_unlock_read_folio() in which folios are marked
appropriately for copying to the cache (either with by being marked dirty
and having their private data set or by having PG_private_2 set) and then
unlocked, the folio_queue struct has the entry pointing to the folio
cleared.  This presents a problem for netfs_pgpriv2_write_to_the_cache(),
which is used to write folios marked with PG_private_2 to the cache as it
expects to be able to trawl the folio_queue list thereafter to find the
relevant folios, leading to a hang.

Fix this by not clearing the folio_queue entry if we're going to do the
deprecated copy-to-cache.  The clearance will be done instead as the folios
are written to the cache.

This can be reproduced by starting cachefiles, mounting a ceph filesystem
with "-o fsc" and writing to it.

Fixes: 796a4049640b ("netfs: In readahead, put the folio refs as soon extracted")
Reported-by: Max Kellermann <max.kellermann@ionos.com>
Closes: https://lore.kernel.org/r/CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Xiubo Li <xiubli@redhat.com>
cc: netfs@lists.linux.dev
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_collect.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 47ed3a5044e2..e8624f5c7fcc 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -62,10 +62,14 @@ static void netfs_unlock_read_folio(struct netfs_io_subrequest *subreq,
 		} else {
 			trace_netfs_folio(folio, netfs_folio_trace_read_done);
 		}
+
+		folioq_clear(folioq, slot);
 	} else {
 		// TODO: Use of PG_private_2 is deprecated.
 		if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
 			netfs_pgpriv2_mark_copy_to_cache(subreq, rreq, folioq, slot);
+		else
+			folioq_clear(folioq, slot);
 	}
 
 	if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
@@ -77,8 +81,6 @@ static void netfs_unlock_read_folio(struct netfs_io_subrequest *subreq,
 			folio_unlock(folio);
 		}
 	}
-
-	folioq_clear(folioq, slot);
 }
 
 /*


