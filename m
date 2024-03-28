Return-Path: <linux-nfs+bounces-2533-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D2E8905DD
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 17:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F6B1C2F416
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 16:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B56613A89B;
	Thu, 28 Mar 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJN/bAgF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F263C49A
	for <linux-nfs@vger.kernel.org>; Thu, 28 Mar 2024 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643875; cv=none; b=P+6knlaymC5Xh5+TG/Fo4LL8AfwB+5GBAoSXkenO3O7rScLaM8f/MJDD4CFhILC0Uy1MerewWd7j0Ve9nAaGDhRjYSQHw3hX8lwOR3oferNQCvQToMMsvVEQWX2FYLhzPc2/RXhYr7ow5cei4f53O3g3IEjtGDrHWuYsVoOpOBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643875; c=relaxed/simple;
	bh=PJPhYD4IoFcUNGLano5TA/KsCENTb0bp1WXbMhgQneM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2AFQsZ23VqzD2SQKHocjjRyvDlWBkfsJVqgUrNI+Z5l7Pg5gntUkMbbOj5l1ubuRTMevo963Q76bWXmQlnfnnjtN3jwzWT9ihIgOaIOC/DhABAYTTAVKZY4iC1h96sKIgkyMR7Luo4T//O6BPBy66jWQNkNegfRUgzCnEEEHxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJN/bAgF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ioxjNilBuiqs0KYw5lDY5ynz4cuTib2XAYQ79MimHtU=;
	b=BJN/bAgF1y+e1ThKt7/8NwMBcVG5lID2RwaxAKK/IkfLguHSAUrz2WEmew5caxziN2aO2y
	HiC3iOrJddg0/7XVwBh1aCuU/RRQiNLUGR5psyquGJdb3rx8ydEKTxLhdkZCBaG637vwV3
	wg4flIyHdwYWkNEva9xUkYmBhrpo/vI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-PNBhpr21Omuq3Za9H6GKVg-1; Thu,
 28 Mar 2024 12:37:47 -0400
X-MC-Unique: PNBhpr21Omuq3Za9H6GKVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EED79282477E;
	Thu, 28 Mar 2024 16:37:45 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EE4B41121312;
	Thu, 28 Mar 2024 16:37:42 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 15/26] mm: Export writeback_iter()
Date: Thu, 28 Mar 2024 16:34:07 +0000
Message-ID: <20240328163424.2781320-16-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Export writeback_iter() so that it can be used by netfslib as a module.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Christoph Hellwig <hch@lst.de>
cc: linux-mm@kvack.org
---
 mm/page-writeback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3e19b87049db..9df160a1cf9e 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2546,6 +2546,7 @@ struct folio *writeback_iter(struct address_space *mapping,
 	folio_batch_release(&wbc->fbatch);
 	return NULL;
 }
+EXPORT_SYMBOL(writeback_iter);
 
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.


