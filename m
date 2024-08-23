Return-Path: <linux-nfs+bounces-5628-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4DE95D2DE
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 18:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335A11F22B02
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 16:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741E7194096;
	Fri, 23 Aug 2024 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwLEnlth"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA4C18A951
	for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429575; cv=none; b=Lx/ANX6X26+Zl+vMr2i8QDy4HUN9WKlKQACmkjgQr8V+VPo105qQ2yBQWW76TJFc1PVNPYMumujgro4XwhISaovqYLSXPsqxYdBAptS+6XzcZsKQIzU4zrslxPB2ZQcqQokhYPdsssHtJ6pM8CrNkDqp3Bu5JooU86McNQdSx7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429575; c=relaxed/simple;
	bh=FbX1MxFORvAXV1r6WiurHQFuRWa9an4aaCwoArqvxcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1kMI5jCnn5mLQEngPs2AcGnghFblnolAOGbm+GeyW2YBZx06RH7td96R4sBY8XaRyWS/nt8JRZu+tScOW5KBwEaDU4RYIN3YnmbUgxB+9+5U9oZdn4ceWVmW/x/StUQJ6BmsLcB5zuWggDJ26e1hrcdeHpufUVgEpgNqyf1uNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwLEnlth; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724429572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4kdxje9pJwe2F8kxgsN+SQonQ75sAMbOz8YwNBazmI=;
	b=TwLEnlthX9rOYg98Xon+OSkg5xRz/p7wVSuwbQ/jpwwxsgvac5mFOsUIeSQJt961EcZI0/
	M5CdDRImWTSBCOFGoyCW1a0HRG4xk8Z0CqGIcJT/860mL62GJDR5PamOdzE7Ttg77OfEKi
	5In9uMtQJ/tr8yqwgDeQ7mCFohXSNI0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-tWlcgTiVMRa8lhTgu6q_UA-1; Fri,
 23 Aug 2024 12:12:44 -0400
X-MC-Unique: tWlcgTiVMRa8lhTgu6q_UA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFCD01955D47;
	Fri, 23 Aug 2024 16:12:41 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B46D19560A3;
	Fri, 23 Aug 2024 16:12:37 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
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
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH 4/5] cifs: Fix short read handling
Date: Fri, 23 Aug 2024 17:12:05 +0100
Message-ID: <20240823161209.434705-5-dhowells@redhat.com>
In-Reply-To: <20240823161209.434705-1-dhowells@redhat.com>
References: <20240823161209.434705-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fix smb2_readv_callback() to always take -ENODATA as indicating we hit EOF
and to always set the NETFS_SREQ_HIT_EOF flag rather than only doing it
under some circumstances.

Fixes: 942ad91e2956 ("netfs, cifs: Fix handling of short DIO read")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smb2pdu.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index e182fdbec887..9829784e8ec5 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4601,16 +4601,8 @@ smb2_readv_callback(struct mid_q_entry *mid)
 				     rdata->got_bytes);
 
 	if (rdata->result == -ENODATA) {
-		/* We may have got an EOF error because fallocate
-		 * failed to enlarge the file.
-		 */
-		if (rdata->subreq.start + rdata->subreq.transferred < rdata->subreq.rreq->i_size)
-			rdata->result = 0;
-		if (rdata->subreq.start + rdata->subreq.transferred + rdata->got_bytes >=
-		    ictx->remote_i_size) {
-			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
-			rdata->result = 0;
-		}
+		__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
+		rdata->result = 0;
 	} else {
 		if (rdata->got_bytes < rdata->actual_len &&
 		    rdata->subreq.start + rdata->subreq.transferred + rdata->got_bytes ==


