Return-Path: <linux-nfs+bounces-1265-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EA6837642
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 23:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC9B1F2769D
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 22:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30184A99D;
	Mon, 22 Jan 2024 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Df359GEU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915AC495C0
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705962773; cv=none; b=ksAtVhKouQc06pHobP4zgaP+c0upY1SDXzaKObGDy/MdgUorgIZWxgv4eauzlXlSZ2jgJSMWOs8mnyCwmLnZO6qkbR66mDpgh/zIWk7GWIqb9xspxc3myrPLdsohLZ0B/UZoebjM3fCYSgKr5G1m5yAwx75GF7/lvrhfBYzf8lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705962773; c=relaxed/simple;
	bh=Qn7dd9HK9v0F1KFFIftRsyM5xQPDc6YGUH7hJwsGprs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwVE6vX4X6nIHGNkeI7nHqxgyYEj/EDtjCQDCqkt+oH6AZp9JZupdn9A5SKKUtnSjqa17m0kEKk+BbSFjph3RKgfZ236XHadfSmLw1BCfhw5fdnofYGm2HLLnJxvE40n+w1xfTug2W4Vjlh/RisPRghaTxBh8+kwG01nvREMCnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Df359GEU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705962770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTDK7i2Q4hPQnzfb2SdByLYJyeMyokMSiVdAUDeKcK0=;
	b=Df359GEUYatsB4tJcTHaWE2QlW8i3TFWajNcFnXnUfykCUdhFy0+oyrtXqrrFgDc2XejxJ
	aBKt76XcPrzaobMZ/PbI3DlYBily/3qhRY+1jY3SF7Jf8txK+KO3vhH865n7QzZbx7nanv
	wBD8Hzz3rD06e6ukm5W3K60meOD0cZA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-Qkey4K3HML2HB-kO-l1Q7Q-1; Mon,
 22 Jan 2024 17:32:48 -0500
X-MC-Unique: Qkey4K3HML2HB-kO-l1Q7Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A62011C0418A;
	Mon, 22 Jan 2024 22:32:47 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 80C1F1C060B1;
	Mon, 22 Jan 2024 22:32:45 +0000 (UTC)
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
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2 05/10] netfs: Fix a NULL vs IS_ERR() check in netfs_perform_write()
Date: Mon, 22 Jan 2024 22:32:18 +0000
Message-ID: <20240122223230.4000595-6-dhowells@redhat.com>
In-Reply-To: <20240122223230.4000595-1-dhowells@redhat.com>
References: <20240122223230.4000595-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

From: Dan Carpenter <dan.carpenter@linaro.org>

The netfs_grab_folio_for_write() function doesn't return NULL, it returns
error pointers.  Update the check accordingly.

Fixes: c38f4e96e605 ("netfs: Provide func to copy data to pagecache for buffered write")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/29fb1310-8e2d-47ba-b68d-40354eb7b896@moroto.mountain/
---
 fs/netfs/buffered_write.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index e7f9ba6fb16b..a3059b3168fd 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -221,10 +221,11 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		if (unlikely(fault_in_iov_iter_readable(iter, part) == part))
 			break;
 
-		ret = -ENOMEM;
 		folio = netfs_grab_folio_for_write(mapping, pos, part);
-		if (!folio)
+		if (IS_ERR(folio)) {
+			ret = PTR_ERR(folio);
 			break;
+		}
 
 		flen = folio_size(folio);
 		offset = pos & (flen - 1);


