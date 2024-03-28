Return-Path: <linux-nfs+bounces-2525-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE95890595
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 17:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93AC8B226AC
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 16:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1A45A780;
	Thu, 28 Mar 2024 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaFS9qkO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C02840848
	for <linux-nfs@vger.kernel.org>; Thu, 28 Mar 2024 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643800; cv=none; b=ahrFRYBEpc3Nul+MEh5daBuAnPSVLAKXBIhPKurWSznTcMR7slds+6zZy9+CY2dozwfaoDQDgxQC2W/uwQVMGP0xL2vGxUTSQvF4TlIRp2HV3G3AEX3rj1MutzAAwuKHUsGk+yi0fj5QCOhRJ3mkrjKdcS7IbEqvD8EakHFTcg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643800; c=relaxed/simple;
	bh=Qu6JNa/GWcyY0KPB2dwXn7WgECfZDHDGW9+owd8pc8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpzlymOlyVgqLqhq09YSdSta+v3ZXuxLblYi7cxNcBmE0veR2exCwNcfA+VEVH5sH/fGqBEonh8xw1TJPU57ir+dHhFmXiihJlWdd3eA+ogvu1NkR/V24/I1BJ8d8r8sl/4M00c8veB2Kmqh7Af1yrjJdHnRZ/uZ/sNgli81fnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LaFS9qkO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTOCRVKlSMdVpJyaVTQSUOcv3/giUpppfoW0qaRDdtA=;
	b=LaFS9qkOTIm50bTOMFhZM9dRWSwWarYCh0tErAKRyF1Vod7vkBQL4BQ0OVdMuCZNlYysFG
	L01mKKFJW9qQza6vbYCreiI7RQ0ITz6fLqUgldL7Kt0zs4cl1mUykLQi8nTuS1MtvcFPWd
	zpQxbV0lL3uwFPJ3OpF2tGDfFvD5Apc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-PKKJzPiePVmnP10543grxg-1; Thu,
 28 Mar 2024 12:36:30 -0400
X-MC-Unique: PKKJzPiePVmnP10543grxg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88B663CBDF73;
	Thu, 28 Mar 2024 16:36:27 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 95C5137F2;
	Thu, 28 Mar 2024 16:36:24 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/26] netfs: Make netfs_io_request::subreq_counter an atomic_t
Date: Thu, 28 Mar 2024 16:33:59 +0000
Message-ID: <20240328163424.2781320-8-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Make the netfs_io_request::subreq_counter, used to generate values for
netfs_io_subrequest::debug_index, into an atomic_t so that it can be called
from the retry thread at the same time as the app thread issuing writes.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/output.c     | 2 +-
 include/linux/netfs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/output.c b/fs/netfs/output.c
index 625eb68f3e5a..fbdbb4f78234 100644
--- a/fs/netfs/output.c
+++ b/fs/netfs/output.c
@@ -37,7 +37,7 @@ struct netfs_io_subrequest *netfs_create_write_request(struct netfs_io_request *
 		subreq->source	= dest;
 		subreq->start	= start;
 		subreq->len	= len;
-		subreq->debug_index = wreq->subreq_counter++;
+		subreq->debug_index = atomic_inc_return(&wreq->subreq_counter);
 
 		switch (subreq->source) {
 		case NETFS_UPLOAD_TO_SERVER:
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index f36a6d8163d1..ddafc6ebff42 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -202,7 +202,7 @@ struct netfs_io_request {
 	unsigned int		debug_id;
 	unsigned int		rsize;		/* Maximum read size (0 for none) */
 	unsigned int		wsize;		/* Maximum write size (0 for none) */
-	unsigned int		subreq_counter;	/* Next subreq->debug_index */
+	atomic_t		subreq_counter;	/* Next subreq->debug_index */
 	atomic_t		nr_outstanding;	/* Number of ops in progress */
 	atomic_t		nr_copy_ops;	/* Number of copy-to-cache ops in progress */
 	size_t			submitted;	/* Amount submitted for I/O so far */


