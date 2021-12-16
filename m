Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A22477895
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Dec 2021 17:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbhLPQW2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 11:22:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239575AbhLPQW1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 11:22:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639671746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMAmhA/2iZbrM5E0RnQr0aNCUgy/+HjmDwYbn/reyfE=;
        b=FP/U8uu+/tPg7Mbg4Yb6g26hpxGtSS+o0ike2bMfac0iqj7ZitYtubdt3GOmYUfbeTwnIv
        /ZHHwEBM6cZvgZAAF5UsTFmtyZ1F9qbzEZoPIUXgGBAfmZk/34ebMw9H84SQ0CoMythiwL
        5oDFQGXbAbfJzTfCXNmrFTI9XArjsfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-EeQ_DrgzNQyZUD_1Nko1sA-1; Thu, 16 Dec 2021 11:22:23 -0500
X-MC-Unique: EeQ_DrgzNQyZUD_1Nko1sA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68B4D6408E;
        Thu, 16 Dec 2021 16:22:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A044A47376;
        Thu, 16 Dec 2021 16:22:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 57/68] afs: Fix afs_write_end() to handle len > page size
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Jeff Layton <jlayton@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-afs@lists.infradead.org, dhowells@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Dec 2021 16:22:03 +0000
Message-ID: <163967172373.1823006.6118195970180365070.stgit@warthog.procyon.org.uk>
In-Reply-To: <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk>
References: <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

It is possible for the len argument to afs_write_end() to overrun the end
of the page (len is used to key the size of the page in afs_write_start()
when compound pages become a regular thing).

Fix afs_write_end() to correctly trim the write length so that it doesn't
exceed the end of the page.

Fixes: 3003bbd0697b ("afs: Use the netfs_write_begin() helper")
Reported-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/162367682522.460125.5652091227576721609.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163819660464.215744.4576104569408497052.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163906968632.143852.17508469800625963114.stgit@warthog.procyon.org.uk/ # v2
---

 fs/afs/write.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 8e4e87d66855..9db3ddb1c45b 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -120,6 +120,7 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 	_enter("{%llx:%llu},{%lx}",
 	       vnode->fid.vid, vnode->fid.vnode, folio_index(folio));
 
+	len = min_t(size_t, len, folio_size(folio) - from);
 	if (!folio_test_uptodate(folio)) {
 		if (copied < len) {
 			copied = 0;


