Return-Path: <linux-nfs+bounces-11812-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13E1ABBFE9
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 15:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61543A8B0F
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 13:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761B2286415;
	Mon, 19 May 2025 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fkzctv+t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47092857EA
	for <linux-nfs@vger.kernel.org>; Mon, 19 May 2025 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747662556; cv=none; b=b1DI9/EMaEJwgxOZAerQxTXceZ4OR4AaP6ZlnDtxHIPc8BnN8nRm+PaRvaCGqRQA4+JoSC+LUayU06bSIBCmDbiuqTKERU9oflfeLZfvdKj9s4LFIRfEl8gfkWALixNDigJQ4QBO0g0SNUcVAc0pyGZYmz3oFdE6GZREay3TGDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747662556; c=relaxed/simple;
	bh=UCoMdICp/gw89XIbdQM+OmSIRLQL7az7fwhXkn4tDLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pw+kABK6CMwHbqZCn+CWR/ft7B2xYwgC5SyxXjyvvrueHl6rd03CVYKSUinVxmh6cFmxFj79h3kXsnwNHmVgG00PUOdyeBvbQBjJRvF4MTGdiBZ12GVSobwo6Ql7KBBcbz0lHMtag3k3wyupkjXmeWu6uhpCKrfQLqFGC5iKT4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fkzctv+t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747662554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DPjMJJz2v4n37NQzAn1i/LDtyNv/dDQ+9/+iNZyVoKo=;
	b=fkzctv+tbiVBaSrf0DbvNH9GFdr8oH0HcfvtxXD25DtV7T4PTqEU4+jzCN9B1PknIe0GPS
	Qu27nGex2N5l0DUi3rXsUO6dyXU2vLPW8y7Up7xNbH2PZAR/dIHsTePt2tvvskUwklWNan
	eabUGtcaRQ7ZBiQXbibh7p/LbZJcEHA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-VnAWM9DbMCu6SncNgvJyQA-1; Mon,
 19 May 2025 09:49:08 -0400
X-MC-Unique: VnAWM9DbMCu6SncNgvJyQA-1
X-Mimecast-MFC-AGG-ID: VnAWM9DbMCu6SncNgvJyQA_1747662547
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 032A8180087B;
	Mon, 19 May 2025 13:49:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.188])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD608180045B;
	Mon, 19 May 2025 13:49:03 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] fs/netfs: declare field `proc_link` only if CONFIG_PROC_FS=y
Date: Mon, 19 May 2025 14:48:04 +0100
Message-ID: <20250519134813.2975312-9-dhowells@redhat.com>
In-Reply-To: <20250519134813.2975312-1-dhowells@redhat.com>
References: <20250519134813.2975312-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Max Kellermann <max.kellermann@ionos.com>

This field is only used for the "proc" filesystem.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/netfs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 2b127527544e..3f7056d837f8 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -228,7 +228,9 @@ struct netfs_io_request {
 	struct kiocb		*iocb;		/* AIO completion vector */
 	struct netfs_cache_resources cache_resources;
 	struct netfs_io_request	*copy_to_cache;	/* Request to write just-read data to the cache */
+#ifdef CONFIG_PROC_FS
 	struct list_head	proc_link;	/* Link in netfs_iorequests */
+#endif
 	struct netfs_io_stream	io_streams[2];	/* Streams of parallel I/O operations */
 #define NR_IO_STREAMS 2 //wreq->nr_io_streams
 	struct netfs_group	*group;		/* Writeback group being written back */


