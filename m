Return-Path: <linux-nfs+bounces-13486-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A09D5B1DBF1
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 18:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03271632CD
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF90B101F2;
	Thu,  7 Aug 2025 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aolpUa/C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A2C186A
	for <linux-nfs@vger.kernel.org>; Thu,  7 Aug 2025 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754585386; cv=none; b=qJC1WVtRUoDWOdPX9tn0x/YnZmsnQPclXLl0Q3wYsBYH8A+BmBVE24x9xUyeQNBJX7czXg+wXKyA4Fiva75zs3GkUjfK5u4l43amUbFcusFaAAbCYwa6MmyfiMRFveumdy3NUBeAlZUEUcCrKRDslsj4lWvN2iUkqUWm+a6Z/0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754585386; c=relaxed/simple;
	bh=fkffwYBdo82d2Pfsgptj/T30KOsErzhD/VxkNyHE710=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAbU/lDvwFO/XslIer2wr3v4KJkDdAs1DoPwJ8e0JE6Td3ONy4q8uovuxF/6zsA0pHncjxhT9AxN4YbIvjOff+00G210RI0EiKlhX1ToF2PA9ChCiWqAOPT/0BCjXrijSJEF+5NbSNl0u49jnJ4sMPu53KnPDddsZdPemwC0fng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aolpUa/C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754585383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+tJuImOZCgaD4Lzc5br74b5jjANGzMjsGOQ27W7wXI=;
	b=aolpUa/C6e4MaiHPnNZxUUjK1cdGe+eWIgwyFWZvWENXminZPpx6NtO+uXxGPbkKBwWkUx
	rBztbIdNr1GavkqBEBJBohYypU6llUxeWK2fpgdWS/1nv71PHe+s3stYGl/vVkrwEuFYeI
	H4O4Ew+ijsFlct45g8j4xICKA4ekU7o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-7vk5ynnQMHmFl0FUxhwWcw-1; Thu,
 07 Aug 2025 12:49:42 -0400
X-MC-Unique: 7vk5ynnQMHmFl0FUxhwWcw-1
X-Mimecast-MFC-AGG-ID: 7vk5ynnQMHmFl0FUxhwWcw_1754585380
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F965180045C;
	Thu,  7 Aug 2025 16:49:40 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.50])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B96C1800446;
	Thu,  7 Aug 2025 16:49:40 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 4936A35F613;
	Thu, 07 Aug 2025 12:49:38 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: snitzer@kernel.org,
	trondmy@kernel.org,
	anna@kernel.org
Cc: zlang@redhat.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH] nfs/localio: restore creds before releasing pageio data
Date: Thu,  7 Aug 2025 12:49:38 -0400
Message-ID: <20250807164938.2395136-1-smayhew@redhat.com>
In-Reply-To: <aJKUHsz79TOHHQE7@kernel.org>
References: <aJKUHsz79TOHHQE7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Otherwise if the nfsd filecache code releases the nfsd_file
immediately, it can trigger the BUG_ON(cred == current->cred) in
__put_cred() when it puts the nfsd_file->nf_file->f-cred.

Fixes: b9f5dd57f4a5 ("nfs/localio: use dedicated workqueues for filesystem read and write")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
Mike - I applied the four patches you mentioned and I still see the oops
quite frequently.  This patch fixes it for me.

 fs/nfs/localio.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 510d0a16cfe9..e2213ef18bae 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -453,12 +453,13 @@ static void nfs_local_call_read(struct work_struct *work)
 	nfs_local_iter_init(&iter, iocb, READ);
 
 	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
+
+	revert_creds(save_cred);
+
 	if (status != -EIOCBQUEUED) {
 		nfs_local_read_done(iocb, status);
 		nfs_local_pgio_release(iocb);
 	}
-
-	revert_creds(save_cred);
 }
 
 static int
@@ -649,14 +650,15 @@ static void nfs_local_call_write(struct work_struct *work)
 	file_start_write(filp);
 	status = filp->f_op->write_iter(&iocb->kiocb, &iter);
 	file_end_write(filp);
+
+	revert_creds(save_cred);
+	current->flags = old_flags;
+
 	if (status != -EIOCBQUEUED) {
 		nfs_local_write_done(iocb, status);
 		nfs_local_vfs_getattr(iocb);
 		nfs_local_pgio_release(iocb);
 	}
-
-	revert_creds(save_cred);
-	current->flags = old_flags;
 }
 
 static int
-- 
2.50.1


