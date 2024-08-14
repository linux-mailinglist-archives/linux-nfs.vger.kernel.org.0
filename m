Return-Path: <linux-nfs+bounces-5379-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B239523DF
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 22:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1A32836AC
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 20:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AEB1DC467;
	Wed, 14 Aug 2024 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eg3/s2y0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A38C1DB45D
	for <linux-nfs@vger.kernel.org>; Wed, 14 Aug 2024 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668063; cv=none; b=eBJz0ShG+qquJpzXUw+GquN1EjpwSXO65Oi7A9ElrwEVDMi+Zqp1X9bAPXglcIhkyT69VaqB4wKvfq/m+BOPsXo2tNuNhLTSecsX33MfB13GelwFbvp1fMb1ODEqCiTv5HIu5xW7TDcPQdRS5XMzsSmR5MZIdeIWSoEwABL8Tds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668063; c=relaxed/simple;
	bh=y/uqBvnv7Y+Yg31CdUU1M2u1mm1WF6LOFM72s5FtVRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZuQjbbWqMyUFNDoZx5UH8qp8sv5OUD69jM4tOhTxwdfEqhoCo+Pl69Tz0g2W+7ni1Y5uJ9kZQifv2P6vlB4fsJfw1cZLVUpd7Rf4F+V4+9t/hdPxqYkVE6BI0h0n5sf1bQhdM46nxWETJeW+9m7EoSaGIVq722Y0AQfcvWWkoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eg3/s2y0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RZCIFt1nFHOn2K81N2VwRb0JQpc16vDcy/7plWa8pc=;
	b=eg3/s2y0T0WejA7upOT4mGU5aj5CdGM0+kqzomAxIUJX4ciY6OXq36Yk4ChTlCCHoYqHhM
	RU4jfZJe0LcVctCymYIZ2Jse8K6bmCY/sG7T27XBsQJfcIrgse23QppSHEeScWuvD9LNY7
	bzR4cDWwjfBsWSeF0EKycRjewRDAfrs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-02X665vNNgu4MYu1Px-cDA-1; Wed,
 14 Aug 2024 16:40:51 -0400
X-MC-Unique: 02X665vNNgu4MYu1Px-cDA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BCED1955F65;
	Wed, 14 Aug 2024 20:40:48 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F4AD196BE80;
	Wed, 14 Aug 2024 20:40:42 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
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
	Steve French <sfrench@samba.org>,
	Enzo Matsumiya <ematsumiya@suse.de>
Subject: [PATCH v2 14/25] cifs: Provide the capability to extract from ITER_FOLIOQ to RDMA SGEs
Date: Wed, 14 Aug 2024 21:38:34 +0100
Message-ID: <20240814203850.2240469-15-dhowells@redhat.com>
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Make smb_extract_iter_to_rdma() extract page fragments from an ITER_FOLIOQ
iterator into RDMA SGEs.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Tom Talpey <tom@talpey.com>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
---
 fs/smb/client/smbdirect.c | 71 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 7bcc379014ca..c946b38ca825 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -6,6 +6,7 @@
  */
 #include <linux/module.h>
 #include <linux/highmem.h>
+#include <linux/folio_queue.h>
 #include "smbdirect.h"
 #include "cifs_debug.h"
 #include "cifsproto.h"
@@ -2463,6 +2464,8 @@ static ssize_t smb_extract_bvec_to_rdma(struct iov_iter *iter,
 		start = 0;
 	}
 
+	if (ret > 0)
+		iov_iter_advance(iter, ret);
 	return ret;
 }
 
@@ -2519,6 +2522,65 @@ static ssize_t smb_extract_kvec_to_rdma(struct iov_iter *iter,
 		start = 0;
 	}
 
+	if (ret > 0)
+		iov_iter_advance(iter, ret);
+	return ret;
+}
+
+/*
+ * Extract folio fragments from a FOLIOQ-class iterator and add them to an RDMA
+ * list.  The folios are not pinned.
+ */
+static ssize_t smb_extract_folioq_to_rdma(struct iov_iter *iter,
+					  struct smb_extract_to_rdma *rdma,
+					  ssize_t maxsize)
+{
+	const struct folio_queue *folioq = iter->folioq;
+	unsigned int slot = iter->folioq_slot;
+	ssize_t ret = 0;
+	size_t offset = iter->iov_offset;
+
+	BUG_ON(!folioq);
+
+	if (slot >= folioq_nr_slots(folioq)) {
+		folioq = folioq->next;
+		if (WARN_ON_ONCE(!folioq))
+			return -EIO;
+		slot = 0;
+	}
+
+	do {
+		struct folio *folio = folioq_folio(folioq, slot);
+		size_t fsize = folioq_folio_size(folioq, slot);
+
+		if (offset < fsize) {
+			size_t part = umin(maxsize - ret, fsize - offset);
+
+			if (!smb_set_sge(rdma, folio_page(folio, 0), offset, part))
+				return -EIO;
+
+			offset += part;
+			ret += part;
+		}
+
+		if (offset >= fsize) {
+			offset = 0;
+			slot++;
+			if (slot >= folioq_nr_slots(folioq)) {
+				if (!folioq->next) {
+					WARN_ON_ONCE(ret < iter->count);
+					break;
+				}
+				folioq = folioq->next;
+				slot = 0;
+			}
+		}
+	} while (rdma->nr_sge < rdma->max_sge || maxsize > 0);
+
+	iter->folioq = folioq;
+	iter->folioq_slot = slot;
+	iter->iov_offset = offset;
+	iter->count -= ret;
 	return ret;
 }
 
@@ -2563,6 +2625,8 @@ static ssize_t smb_extract_xarray_to_rdma(struct iov_iter *iter,
 	}
 
 	rcu_read_unlock();
+	if (ret > 0)
+		iov_iter_advance(iter, ret);
 	return ret;
 }
 
@@ -2590,6 +2654,9 @@ static ssize_t smb_extract_iter_to_rdma(struct iov_iter *iter, size_t len,
 	case ITER_KVEC:
 		ret = smb_extract_kvec_to_rdma(iter, rdma, len);
 		break;
+	case ITER_FOLIOQ:
+		ret = smb_extract_folioq_to_rdma(iter, rdma, len);
+		break;
 	case ITER_XARRAY:
 		ret = smb_extract_xarray_to_rdma(iter, rdma, len);
 		break;
@@ -2598,9 +2665,7 @@ static ssize_t smb_extract_iter_to_rdma(struct iov_iter *iter, size_t len,
 		return -EIO;
 	}
 
-	if (ret > 0) {
-		iov_iter_advance(iter, ret);
-	} else if (ret < 0) {
+	if (ret < 0) {
 		while (rdma->nr_sge > before) {
 			struct ib_sge *sge = &rdma->sge[rdma->nr_sge--];
 


