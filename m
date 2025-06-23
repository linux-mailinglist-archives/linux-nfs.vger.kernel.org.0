Return-Path: <linux-nfs+bounces-12658-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBDFAE4104
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 14:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F67165BE4
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 12:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B135253F03;
	Mon, 23 Jun 2025 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFqRuCsc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00961253958
	for <linux-nfs@vger.kernel.org>; Mon, 23 Jun 2025 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682960; cv=none; b=RwZy4KBoslMTyrmhXnrghJN/4YogLpDLBrv4rL+4SO1zWraetskpJKTVTU52jqDMu9C2ywkXPXAZLO+6yby9wr/lKskMqvV4msZ8YGiS0+aMVHbQf+GzZ3piAga1oZJeBXq4pa0v7aJjD9u6ftX8Qt82Iy2cW6M/pox4wejQWAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682960; c=relaxed/simple;
	bh=zttpQsblGMp7z07jk1lN8v6oW9ojloS7/vENaMxLw5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSqtjLZ69OR5OV3WhspxjoXaSg7yTH3PepqyAVnfCpsQUsn2pmtKUn+3/nJCA4AePV9IiY5fVIHDQcI6gm2cCBQCxz7fRkby+45ViwUPtk096QrKaZYsarHpvLxFu1ScDVXgwvCaOagPCCRzT7iJwSnAeW0C2hBSingKbHLYe7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UFqRuCsc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750682958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hAkDWqWictGqLE9t+71XFB8sKg+zbKHb8YN2JrhliGE=;
	b=UFqRuCscQptJjY/For3/qfOi7kF2kw/mn4GoZHms9juE7CNgIeqznmokW+zy/kobEwa12K
	+QTtF4mVH+0IogD5qH8x0oYUDbYeHqj0C/irRisOgjwk3aGKjsfDmMW+BbhdteAoaZdGkE
	bdJyPYs30+1tRzXH/CJSbF5oVZ/eTD8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-2SGQBkdxOt-n-7M3CZ5wKQ-1; Mon,
 23 Jun 2025 08:49:13 -0400
X-MC-Unique: 2SGQBkdxOt-n-7M3CZ5wKQ-1
X-Mimecast-MFC-AGG-ID: 2SGQBkdxOt-n-7M3CZ5wKQ_1750682950
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B760C19560AE;
	Mon, 23 Jun 2025 12:49:09 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 133FF195608D;
	Mon, 23 Jun 2025 12:49:05 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH 05/11] netfs: Fix ref leak on inserted extra subreq in write retry
Date: Mon, 23 Jun 2025 13:48:25 +0100
Message-ID: <20250623124835.1106414-6-dhowells@redhat.com>
In-Reply-To: <20250623124835.1106414-1-dhowells@redhat.com>
References: <20250623124835.1106414-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The write-retry algorithm will insert extra subrequests into the list if it
can't get sufficient capacity to split the range that needs to be retried
into the sequence of subrequests it currently has (for instance, if the
cifs credit pool has fewer credits available than it did when the range was
originally divided).

However, the allocator furnishes each new subreq with 2 refs and then
another is added for resubmission, causing one to be leaked.

Fix this by replacing the ref-getting line with a neutral trace line.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_retry.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index 9d1d8a8bab72..7158657061e9 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -153,7 +153,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			trace_netfs_sreq_ref(wreq->debug_id, subreq->debug_index,
 					     refcount_read(&subreq->ref),
 					     netfs_sreq_trace_new);
-			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_split);
 
 			list_add(&subreq->rreq_link, &to->rreq_link);
 			to = list_next_entry(to, rreq_link);


