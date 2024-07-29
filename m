Return-Path: <linux-nfs+bounces-5161-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7EE93FAC3
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 18:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3E81C223C9
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 16:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E1618A935;
	Mon, 29 Jul 2024 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gofc6sV5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E017C7C1
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270086; cv=none; b=YR3WdEhwDAQ/psIKG04+EaXBi3igwY9zGckBoPH5mgpMAzF1By15utfJ0H4arKX996n7yRgOu5tzRoiYFh+S4RMg+0vKbbBuhsSS4etwsXyrKJcZP66akEAc3pn4rhKJFDIyPxvrmEgD7voIBDpu7o2+O8elTYFk5nIWNKFSFpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270086; c=relaxed/simple;
	bh=IAYhroJd21dkfKgX48R9l8dPVtwovV8HzwFjyj0C7i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyEfK2K4ETH9gejBvJqhj9+mu2/5WShRHXiSQOcu6Q8uCK73tCXPeVd0UO+3xW2nr76Pgrd1ju2KfV09e8BJ6Pp8i5bKh4/cxhcDRs9qxj9JeJzk33LPq74WEboAZ9chIvtclBYfCXZ1+gtw7Ci1s0d5gei5TbdI/hgxItZoHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gofc6sV5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722270084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ym7Dgj5R+YdTfcRYfBpvIxa6W6XwErM+iC1RqazEX2E=;
	b=Gofc6sV5efLcuvRVsCLLjXmK9QXvVRNAX9OTN5nMPh3L9sbfjY23ak4/94ewSLwpAzN+6L
	M+G0gD/mQPASKmY8Y2m9Otra4KDW/gMUpm3s3uYTZRlWhN/syAcpEl7q+5KF8e6NcdxI/h
	Toq0eifV2KOOw9P8EE3JoB8KwvJuA6A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-SmDaEKiJM-elKkaE9Ynq4w-1; Mon,
 29 Jul 2024 12:21:19 -0400
X-MC-Unique: SmDaEKiJM-elKkaE9Ynq4w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C04641955D4D;
	Mon, 29 Jul 2024 16:21:14 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.216])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 23C2C19560AA;
	Mon, 29 Jul 2024 16:21:08 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/24] netfs: Reserve netfs_sreq_source 0 as unset/unknown
Date: Mon, 29 Jul 2024 17:19:37 +0100
Message-ID: <20240729162002.3436763-9-dhowells@redhat.com>
In-Reply-To: <20240729162002.3436763-1-dhowells@redhat.com>
References: <20240729162002.3436763-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Reserve the 0-valued netfs_sreq_source to mean unset or unknown so that it
can be seen in the trace as such rather than appearing as
download-from-server when it's going to get switched to something else.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/netfs.h        | 1 +
 include/trace/events/netfs.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index aada40d2182b..5e623e52e5a2 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -43,6 +43,7 @@ static inline void folio_start_private_2(struct folio *folio)
 #define NETFS_BUF_PAGECACHE_MARK XA_MARK_1	/* - Page needs wb/dirty flag wrangling */
 
 enum netfs_io_source {
+	NETFS_SOURCE_UNKNOWN,
 	NETFS_FILL_WITH_ZEROES,
 	NETFS_DOWNLOAD_FROM_SERVER,
 	NETFS_READ_FROM_CACHE,
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index fc5dbd19f120..bd4f6f1f1040 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -59,6 +59,7 @@
 	E_(netfs_rreq_trace_write_done,		"WR-DONE")
 
 #define netfs_sreq_sources					\
+	EM(NETFS_SOURCE_UNKNOWN,		"----")		\
 	EM(NETFS_FILL_WITH_ZEROES,		"ZERO")		\
 	EM(NETFS_DOWNLOAD_FROM_SERVER,		"DOWN")		\
 	EM(NETFS_READ_FROM_CACHE,		"READ")		\


