Return-Path: <linux-nfs+bounces-10623-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779CDA61693
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Mar 2025 17:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A38464241
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Mar 2025 16:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087AC2040B6;
	Fri, 14 Mar 2025 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCNIRnie"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643812040A8
	for <linux-nfs@vger.kernel.org>; Fri, 14 Mar 2025 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970550; cv=none; b=E3lE7wMH29U0hGyYXxs8Nb/e7ETXo6yEvabPoQlWPYtqe7B8OJvd/qiFxeRxfXDNhNAsKlhHxzZRTCSWTud3P0+uPkJhfKuUbnmbyjSq+Na8zulTORq5sSOkAxnHeO0Lh+prQYWTacoiPOX/9+tT998yEiFNY7H99jEw1vTWAK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970550; c=relaxed/simple;
	bh=Zfo7G8ZZVI56easMvzkUxJjm7RkyPqw27btY50SXyBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VL4pbWQ7V7Yn/fuNAz+3J/hjV093pg2J6iwSwVSR9yNkgun0ndI7dywMPldLhdbMZF4XKckndAY9IyTvoL9xFrlV2PxQh9axDXb0KvCtiB8/jliZEQ8h7apbWGlmObV6CfW/PFmvBQDInkrdUakKgsZ16tDKkueasbnF6RiFT/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OCNIRnie; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741970548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kgs68JnbqfGZwJrqZ31YpM64s8X6n5iWQDAIZUpopD8=;
	b=OCNIRnie4ogvH9J6Xp59PO5d4kVoQGiTt9/qIdwsrXtJl6WCXe9HSJrzPiJi7frYbHfBgA
	1F72voT6kIWIru/CCRgecqUyJ76b7oqy8v0dAY83TMHaDtqxbMgXfvaYQJBO2TSolWtMPk
	HsbEaYQYznvOIQG3QrunGxS/b3T17jU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-ELC-7-6yMxSrihokJSDULg-1; Fri,
 14 Mar 2025 12:42:25 -0400
X-MC-Unique: ELC-7-6yMxSrihokJSDULg-1
X-Mimecast-MFC-AGG-ID: ELC-7-6yMxSrihokJSDULg_1741970543
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19609195605E;
	Fri, 14 Mar 2025 16:42:23 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 485451955BCB;
	Fri, 14 Mar 2025 16:42:19 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH 3/4] netfs: Fix rolling_buffer_load_from_ra() to not clear mark bits
Date: Fri, 14 Mar 2025 16:41:58 +0000
Message-ID: <20250314164201.1993231-4-dhowells@redhat.com>
In-Reply-To: <20250314164201.1993231-1-dhowells@redhat.com>
References: <20250314164201.1993231-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

rolling_buffer_load_from_ra() looms large in the perf report because it
loops around doing an atomic clear for each of the three mark bits per
folio.  However, this is both inefficient (it would be better to build a
mask and atomically AND them out) and unnecessary as they shouldn't be set.

Fix this by removing the loop.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: netfs@lists.linux.dev
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/rolling_buffer.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/netfs/rolling_buffer.c b/fs/netfs/rolling_buffer.c
index 75d97af14b4a..207b6a326651 100644
--- a/fs/netfs/rolling_buffer.c
+++ b/fs/netfs/rolling_buffer.c
@@ -146,10 +146,6 @@ ssize_t rolling_buffer_load_from_ra(struct rolling_buffer *roll,
 
 	/* Store the counter after setting the slot. */
 	smp_store_release(&roll->next_head_slot, to);
-
-	for (; ix < folioq_nr_slots(fq); ix++)
-		folioq_clear(fq, ix);
-
 	return size;
 }
 


