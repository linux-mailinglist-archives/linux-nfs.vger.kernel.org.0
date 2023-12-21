Return-Path: <linux-nfs+bounces-753-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7CB81B824
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Dec 2023 14:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C93286A04
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Dec 2023 13:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AE1128762;
	Thu, 21 Dec 2023 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7R/Riov"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA049128741
	for <linux-nfs@vger.kernel.org>; Thu, 21 Dec 2023 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703165153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLOJZBQtHn1jVYDnU489+f18yhPIxwvphTv8wiLd2rs=;
	b=O7R/RiovNhCZVp0o181EQMRWq4OgV0WXErRRp1zLp3PQwUJztZrjOaXAApDiWeLzqvNE1q
	10wJzKPg7aB7KgroEuk9ElP2lpfFWSaIddsOydQjWcsy0Xlq/2Gd/VExXd9rNBpqi/6C2a
	YJlhiUVtAUl+V6paydKfV6+dylZjfbw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-73qhAL2vNNqkaVOphF4Iig-1; Thu,
 21 Dec 2023 08:25:49 -0500
X-MC-Unique: 73qhAL2vNNqkaVOphF4Iig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B92C43C000B4;
	Thu, 21 Dec 2023 13:25:48 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C415F2166B33;
	Thu, 21 Dec 2023 13:25:45 +0000 (UTC)
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
Subject: [PATCH v5 27/40] netfs: Allocate multipage folios in the writepath
Date: Thu, 21 Dec 2023 13:23:22 +0000
Message-ID: <20231221132400.1601991-28-dhowells@redhat.com>
In-Reply-To: <20231221132400.1601991-1-dhowells@redhat.com>
References: <20231221132400.1601991-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Allocate a multipage folio when copying data into the pagecache if possible
if there's sufficient data to warrant it.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_write.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 6e7f06d9962d..b76688e98f81 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -84,14 +84,19 @@ static enum netfs_how_to_modify netfs_how_to_modify(struct netfs_inode *ctx,
 }
 
 /*
- * Grab a folio for writing and lock it.
+ * Grab a folio for writing and lock it.  Attempt to allocate as large a folio
+ * as possible to hold as much of the remaining length as possible in one go.
  */
 static struct folio *netfs_grab_folio_for_write(struct address_space *mapping,
 						loff_t pos, size_t part)
 {
 	pgoff_t index = pos / PAGE_SIZE;
+	fgf_t fgp_flags = FGP_WRITEBEGIN;
 
-	return __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+	if (mapping_large_folio_support(mapping))
+		fgp_flags |= fgf_set_order(pos % PAGE_SIZE + part);
+
+	return __filemap_get_folio(mapping, index, fgp_flags,
 				   mapping_gfp_mask(mapping));
 }
 


