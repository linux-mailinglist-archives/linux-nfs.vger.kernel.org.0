Return-Path: <linux-nfs+bounces-1222-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0C583629C
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 12:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76DDD1C282A0
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 11:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970863CF65;
	Mon, 22 Jan 2024 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qz4eE2gE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E805F3C6AB
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924221; cv=none; b=OQrGEEYI7JNswbiQ/QBXPl7NEw/p2RpjbL8LXa0zXNxo5/tPU8XyeqjzXPnp8bGI9b5MVgvqi30GKifywU/f3tI97YVmy12O4iYob40khBeToy4Asifn4wl1soa8GwFVDBm1fPXzT8tvoq9Yh8puJWMY4WeCfqLlSm+XWFzKZDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924221; c=relaxed/simple;
	bh=6kwAXtFGpxmtnXDRdMN/50kipDwC3uxCADBEG0Y+epo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4fxeC7fUM7qtwG80K3Pc8lxh2MlgFRwyBs7PlosmkGTIQadvLMYNRvKHjaD44zkRGZ7h/8WkTreiRc+HjO4MB1q6K3638ylr9I2o7L38oVLMNweKwRLi+go84p0OmFubDAgKt0cr2T6nlIGg65xjffFyHXl5wVw02h6fyIQFz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qz4eE2gE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705924218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2AeAHAEfe6p91PoKvpPp+65g3eYULuZvdVr2/JzDo7o=;
	b=Qz4eE2gEH9cg6QnWFUzCQzq2LFBzD9B6BQKRqUn8pakv9IJ+2uTfDJ3X+ryi0qNue1XJTj
	B5B4GhXZN+Rpfo54e0rj++dBSfqCkMS3Fzjhfs7vadZWF4NVXJyMcgovcaE0f6U0bdxvdr
	zJqAOeqRZEJFyOCBkdPuPIbW9x/45do=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-HBkRZ6-iO5eUtV0wvl8VqQ-1; Mon,
 22 Jan 2024 06:50:15 -0500
X-MC-Unique: HBkRZ6-iO5eUtV0wvl8VqQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CB373812587;
	Mon, 22 Jan 2024 11:50:14 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AA6FC2026D66;
	Mon, 22 Jan 2024 11:50:12 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netfs@lists.linux.dev
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] netfs, cachefiles: Change mailing list
Date: Mon, 22 Jan 2024 11:50:00 +0000
Message-ID: <20240122115007.3820330-2-dhowells@redhat.com>
In-Reply-To: <20240122115007.3820330-1-dhowells@redhat.com>
References: <20240122115007.3820330-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

The publicly accessible archives for Red Hat mailing lists stop at Oct
2023; messages sent after that time are in internal-only archives.

Change the netfs and cachefiles mailing list to one that has publicly
accessible archives:

	netfs@lists.linux.dev

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-cachefs@redhat.com
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: ceph-devel@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-erofs@lists.ozlabs.org
cc: linux-nfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..ab5858d24ffc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4547,7 +4547,7 @@ F:	drivers/net/ieee802154/ca8210.c
 
 CACHEFILES: FS-CACHE BACKEND FOR CACHING ON MOUNTED FILESYSTEMS
 M:	David Howells <dhowells@redhat.com>
-L:	linux-cachefs@redhat.com (moderated for non-subscribers)
+L:	netfs@lists.linux.dev
 S:	Supported
 F:	Documentation/filesystems/caching/cachefiles.rst
 F:	fs/cachefiles/
@@ -8223,7 +8223,7 @@ F:	include/linux/iomap.h
 
 FILESYSTEMS [NETFS LIBRARY]
 M:	David Howells <dhowells@redhat.com>
-L:	linux-cachefs@redhat.com (moderated for non-subscribers)
+L:	netfs@lists.linux.dev
 L:	linux-fsdevel@vger.kernel.org
 S:	Supported
 F:	Documentation/filesystems/caching/


