Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FD447358F
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Dec 2021 21:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbhLMUDZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Dec 2021 15:03:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229897AbhLMUDY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Dec 2021 15:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639425803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J0rYuFUUeq4zJSgPdjgBoZ7nTLvqV84GSbKlhW9yRFE=;
        b=RP/oGkFD+YPa3Kmv0xfbXhUujywDiMoUxD3kQ9AbziyOyNCr4zzLfg7nEia3f9maO2aQhi
        aKXw8gzFVrSb84PyW5Gaj1nXHuyhuAA7bxu2ABCTAQPPHEMD3/Da+VD+Yht1xJcVi6/odk
        2+uDbKGm7nxQVIquB07dK9CIDxB3GUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-PqCIbcSmOxqH3d8n-n8Paw-1; Mon, 13 Dec 2021 15:03:22 -0500
X-MC-Unique: PqCIbcSmOxqH3d8n-n8Paw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15EBF801ADC
        for <linux-nfs@vger.kernel.org>; Mon, 13 Dec 2021 20:03:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41C9F45D61;
        Mon, 13 Dec 2021 20:03:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <599331.1639410068@warthog.procyon.org.uk>
References: <599331.1639410068@warthog.procyon.org.uk> <CALF+zOnmJ0=j8pEMikpxYgLrS10gVZiXfCjBhDz9Je0Qip7wnw@mail.gmail.com> <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk> <CALF+zOnA2U6LjDTE8m2REDTMmFVnWkcBkn0ZJQRGULPUjeQW4Q@mail.gmail.com>
Cc:     dhowells@redhat.com, David Wysochanski <dwysocha@redhat.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] fscache: Need to go round again after processing LRU_DISCARDING state
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <629802.1639425799.1@warthog.procyon.org.uk>
Date:   Mon, 13 Dec 2021 20:03:19 +0000
Message-ID: <629803.1639425799@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I forgot to commit part of the patch.  Attached is the patch in full.

David
---
commit a3d01f1a21bcf2c39aa6db49edbc08540378a593
Author: David Howells <dhowells@redhat.com>
Date:   Mon Dec 13 16:26:44 2021 +0000

    afs: Fix mmap
    
    Fix afs_add_open_map() to check that the vnode isn't already on the list
    when it adds it.  It's possible that afs_drop_open_mmap() decremented the
    cb_nr_mmap counter, but hadn't yet got into the locked section to remove
    it.
    
    Also vnode->cb_mmap_link should be initialised, so fix that too.
    
    Fixes: 6e0e99d58a65 ("afs: Fix mmap coherency vs 3rd-party changes")
    Reported-by: Marc Dionne <marc.dionne@auristor.com>
    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: linux-afs@lists.infradead.org

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 572063dad0b3..bcda99dcfdec 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -539,8 +539,9 @@ static void afs_add_open_mmap(struct afs_vnode *vnode)
 	if (atomic_inc_return(&vnode->cb_nr_mmap) == 1) {
 		down_write(&vnode->volume->cell->fs_open_mmaps_lock);
 
-		list_add_tail(&vnode->cb_mmap_link,
-			      &vnode->volume->cell->fs_open_mmaps);
+		if (list_empty(&vnode->cb_mmap_link))
+			list_add_tail(&vnode->cb_mmap_link,
+				      &vnode->volume->cell->fs_open_mmaps);
 
 		up_write(&vnode->volume->cell->fs_open_mmaps_lock);
 	}
diff --git a/fs/afs/super.c b/fs/afs/super.c
index af7cbd9949c5..5ec9fd97eccc 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -668,6 +668,7 @@ static void afs_i_init_once(void *_vnode)
 	INIT_LIST_HEAD(&vnode->pending_locks);
 	INIT_LIST_HEAD(&vnode->granted_locks);
 	INIT_DELAYED_WORK(&vnode->lock_work, afs_lock_work);
+	INIT_LIST_HEAD(&vnode->cb_mmap_link);
 	seqlock_init(&vnode->cb_lock);
 }
 

