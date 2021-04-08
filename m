Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DBE358653
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Apr 2021 16:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhDHOL1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Apr 2021 10:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49864 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232158AbhDHOJn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Apr 2021 10:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617890972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RhqHt3RTMEdpGDCKa1a4QaBDpg1yVFFzGBbMpi3OjuU=;
        b=F7pHZWRi2Rr0djoIeOUG05uSw7ICF2CH3QANW2arhv+4/hMf0iVwSjBVaVehCd2Lhv9IJt
        U7Zfpgn/MzL32Qwb2FFZ1V2F3E2WEFmPm38OI9TYbXpAZUswkGO0l4gpCCb7CPn0vKh/e6
        QpHtje7TJ+TM4uSplbMKnymjJSCNpu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-C7By_JX6Noe6-EBX-WlPZg-1; Thu, 08 Apr 2021 10:09:28 -0400
X-MC-Unique: C7By_JX6Noe6-EBX-WlPZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EA0D8189CA;
        Thu,  8 Apr 2021 14:09:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-35.rdu2.redhat.com [10.10.119.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A1F160636;
        Thu,  8 Apr 2021 14:09:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 25/30] afs: Wait on PG_fscache before modifying/releasing a
 page
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-cachefs@redhat.com,
        dhowells@redhat.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Thu, 08 Apr 2021 15:09:22 +0100
Message-ID: <161789096241.6155.5907241930823579235.stgit@warthog.procyon.org.uk>
In-Reply-To: <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk>
References: <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

PG_fscache is going to be used to indicate that a page is being written to
the cache, and that the page should not be modified or released until it's
finished.

Make afs_invalidatepage() and afs_releasepage() wait for it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/158861253957.340223.7465334678444521655.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/159465832417.1377938.3571599385208729791.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/160588536286.3465195.13231895135369807920.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161118153708.1232039.3535103645871176749.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161161049369.2537118.11591934943429117060.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/161340412903.1303470.6424701655031380012.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/161539556890.286939.5873470593519458598.stgit@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/161653812726.2770958.18167145829938766503.stgit@warthog.procyon.org.uk/ # v5
---

 fs/afs/file.c  |    9 +++++++++
 fs/afs/write.c |   10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 4a34ffaf6de4..f1e30b89e41c 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -593,6 +593,7 @@ static void afs_invalidatepage(struct page *page, unsigned int offset,
 	if (PagePrivate(page))
 		afs_invalidate_dirty(page, offset, length);
 
+	wait_on_page_fscache(page);
 	_leave("");
 }
 
@@ -610,6 +611,14 @@ static int afs_releasepage(struct page *page, gfp_t gfp_flags)
 
 	/* deny if page is being written to the cache and the caller hasn't
 	 * elected to wait */
+#ifdef CONFIG_AFS_FSCACHE
+	if (PageFsCache(page)) {
+		if (!(gfp_flags & __GFP_DIRECT_RECLAIM) || !(gfp_flags & __GFP_FS))
+			return false;
+		wait_on_page_fscache(page);
+	}
+#endif
+
 	if (PagePrivate(page)) {
 		detach_page_private(page);
 		trace_afs_page_dirty(vnode, tracepoint_string("rel"), page);
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 6e41b982c71b..1b8cabf5ac92 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -117,6 +117,10 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 		SetPageUptodate(page);
 	}
 
+#ifdef CONFIG_AFS_FSCACHE
+	wait_on_page_fscache(page);
+#endif
+
 try_again:
 	/* See if this page is already partially written in a way that we can
 	 * merge the new write with.
@@ -857,6 +861,11 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	/* Wait for the page to be written to the cache before we allow it to
 	 * be modified.  We then assume the entire page will need writing back.
 	 */
+#ifdef CONFIG_AFS_FSCACHE
+	if (PageFsCache(vmf->page) &&
+	    wait_on_page_bit_killable(vmf->page, PG_fscache) < 0)
+		return VM_FAULT_RETRY;
+#endif
 
 	if (wait_on_page_writeback_killable(vmf->page))
 		return VM_FAULT_RETRY;
@@ -947,5 +956,6 @@ int afs_launder_page(struct page *page)
 
 	detach_page_private(page);
 	trace_afs_page_dirty(vnode, tracepoint_string("laundered"), page);
+	wait_on_page_fscache(page);
 	return ret;
 }


