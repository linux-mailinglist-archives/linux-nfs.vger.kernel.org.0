Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88C642270E
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Oct 2021 14:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhJEMyt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 08:54:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233762AbhJEMyt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Oct 2021 08:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633438378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kEVUd+EJ8zScAgefVne9tFCB6N15lKXoKzusJv+hmY4=;
        b=G3ZB6beZXcMDnTmLz9Kr5Qz0yTyqCUmoure5cXwDPrvVMRVd/aVc8FQaHnJowpzK2JvazY
        GGQxVp80uchsLVyTm4AeP9J9B9i6Q5ApkLIprr4KWiq8D6ibUwHflTA+w/RLcSGO1vdaQ6
        vIkTxXihXniRhtI2L40aGlGbNKl0oBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-1-yrthBlMvCjzOWypvnzqw-1; Tue, 05 Oct 2021 08:52:55 -0400
X-MC-Unique: 1-yrthBlMvCjzOWypvnzqw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9995C19067E1;
        Tue,  5 Oct 2021 12:52:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1C881F422;
        Tue,  5 Oct 2021 12:52:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1633288958-8481-2-git-send-email-dwysocha@redhat.com>
References: <1633288958-8481-2-git-send-email-dwysocha@redhat.com> <1633288958-8481-1-git-send-email-dwysocha@redhat.com>
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-cachefs@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 1/7] NFS: Fixup patch 3/8 of fscache-iter-3 v2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1078845.1633438369.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 05 Oct 2021 13:52:49 +0100
Message-ID: <1078846.1633438369@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Dave Wysochanski <dwysocha@redhat.com> wrote:

> =

> Handle failed return values of fscache_fallback_read_page() in
> switch statement.

After some discussion on IRC, the attached is probably better.  Returning =
1
might result in 1 being returned through ->readpage(), which could be a
problem.

David
---
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 5b0e78742444..68e266a37675 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -346,33 +346,18 @@ int __nfs_readpage_from_fscache(struct inode *inode,=
 struct page *page)
 =

 	ret =3D fscache_fallback_read_page(nfs_i_fscache(inode), page);
 	if (ret < 0) {
-		dfprintk(FSCACHE, "NFS:    readpage_from_fscache: "
-			 "fscache_fallback_read_page failed ret =3D %d\n", ret);
-		return ret;
-	}
-
-	switch (ret) {
-	case 0: /* Read completed synchronously */
-		dfprintk(FSCACHE,
-			 "NFS:    readpage_from_fscache: read successful\n");
-		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_OK);
-		SetPageUptodate(page);
-		return 0;
-
-	case -ENOBUFS: /* inode not in cache */
-	case -ENODATA: /* page not in cache */
 		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL);
 		dfprintk(FSCACHE,
-			 "NFS:    readpage_from_fscache %d\n", ret);
-		SetPageChecked(page);
-		return 1;
-
-	default:
-		dfprintk(FSCACHE, "NFS:    readpage_from_fscache %d\n", ret);
-		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL);
+			 "NFS:    readpage_from_fscache failed %d\n", ret);
 		SetPageChecked(page);
+		return ret;
 	}
-	return ret;
+
+	/* Read completed synchronously */
+	dfprintk(FSCACHE, "NFS:    readpage_from_fscache: read successful\n");
+	nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_OK);
+	SetPageUptodate(page);
+	return 0;
 }
 =

 /*

