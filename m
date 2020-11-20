Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DF72BACF8
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 16:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgKTPHH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 10:07:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728761AbgKTPHH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 10:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605884825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OASbtfxyD6eIUPjL3PNzYRIfoGBOulxlBVzyzkIasn0=;
        b=gfXGrmd7wd463+ERjAiLwGn9UlcFup+6K8HcLAu4wZN7ix7BNIB1mZLzVLsxTY4JSBdL5r
        8nyp/okgP85N1Tc1GHQQyPuPApzVvijPDBhSFoaJaUSjqrP2SSjkETy/uvjp/18FhLh2kC
        C3N4eTnWZRzTBTMzooWcknuK5WtC+ro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-mRGFeT5KP024Srat-9T2_g-1; Fri, 20 Nov 2020 10:07:02 -0500
X-MC-Unique: mRGFeT5KP024Srat-9T2_g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 346E31DDE6;
        Fri, 20 Nov 2020 15:07:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6356F19C71;
        Fri, 20 Nov 2020 15:06:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 20/76] mm: Stop generic_file_buffered_read() from grabbing
 a superfluous page
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:06:53 +0000
Message-ID: <160588481358.3465195.16552616179674485179.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Under some circumstances, generic_file_buffered_read() will allocate
sufficient pages to read to the end of the file, call readahead/readpages
on them and copy the data over - and then it will allocate another page at
the EOF and call readpage on that and then ignore it.  This is unnecessary
and a waste of time and resources.

Catch the overallocation in the "no_cached_page:" part and prevent it from
happening.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 mm/filemap.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index cfb753955e36..5a63aa1dd71e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2447,6 +2447,8 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		 * Ok, it wasn't cached, so we need to create a new
 		 * page..
 		 */
+		if ((index << PAGE_SHIFT) >= i_size_read(inode))
+			goto out;
 		page = page_cache_alloc(mapping);
 		if (!page) {
 			error = -ENOMEM;


