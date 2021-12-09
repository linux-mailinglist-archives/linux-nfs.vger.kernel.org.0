Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9DE46F0DC
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Dec 2021 18:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhLIRLy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Dec 2021 12:11:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229536AbhLIRLx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Dec 2021 12:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639069699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U+HuoVKpu95c2SdU4PtFRJoEoWn1fNPxJawKKDa63+k=;
        b=QTRzDN4VFT5mwCtezRxD6DXd3QK8jsWBV8h4DxeVkCi5QYXI8LfIv+rNonsyb1n2TdZ5dn
        4wNg/P7c48YUQxXP6fv7CPWZ18fDnMqDCWWzf/Gym1gsfleeZ8J1+dcSfKuQrcA3/kk6BQ
        BY9HZpzUKJCxc1bre6tEwRymjZk3MRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-1YcpFrybPmeB5137idmN6g-1; Thu, 09 Dec 2021 12:08:16 -0500
X-MC-Unique: 1YcpFrybPmeB5137idmN6g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C59221006AA1;
        Thu,  9 Dec 2021 17:08:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A8035C23A;
        Thu,  9 Dec 2021 17:08:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 56/67] afs: Fix afs_write_end() to handle len > page size
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
Date:   Thu, 09 Dec 2021 17:08:06 +0000
Message-ID: <163906968632.143852.17508469800625963114.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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


