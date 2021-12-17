Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408DA478C1B
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 14:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbhLQNVS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 08:21:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229913AbhLQNVS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 08:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639747276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPJIX96Ao1kJo9oMuf/T+qEaGHFsU7gHolnpTL5sNes=;
        b=dbUJY/aDIC1nXpBQiaqgSnfXsn1gyUapowihfHjX1OmHeQyF7m3STqBbBgR7ito7VyaoUD
        LtijzP6wptM11nDgARuV3GVuzMBm8quWI6rEkhg3GWPe0XhpUrQGYp4jFPmmg2gvl6MWaL
        CPmeoj6EXeBb9mpGaMNKj/hrOU4T2SU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-mpZzYMZ_NMCTwk4QxJVCTQ-1; Fri, 17 Dec 2021 08:21:13 -0500
X-MC-Unique: mpZzYMZ_NMCTwk4QxJVCTQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98E1434830;
        Fri, 17 Dec 2021 13:21:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F367E5C2EF;
        Fri, 17 Dec 2021 13:21:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CALF+zOkvC7kZ9LFQyjsRduQq+-gmaD4bLWc7H=AtVi6=NuC_dA@mail.gmail.com>
References: <CALF+zOkvC7kZ9LFQyjsRduQq+-gmaD4bLWc7H=AtVi6=NuC_dA@mail.gmail.com> <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk> <163967182112.1823006.7791504655391213379.stgit@warthog.procyon.org.uk>
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     dhowells@redhat.com, linux-cachefs <linux-cachefs@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 63/68] nfs: Convert to new fscache volume/cookie API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1958025.1639747261.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 17 Dec 2021 13:21:01 +0000
Message-ID: <1958026.1639747261@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

David Wysochanski <dwysocha@redhat.com> wrote:

> >
> >  (4) fscache_enable/disable_cookie() have been removed.
> >
> >      Call fscache_use_cookie() and fscache_unuse_cookie() when a file =
is
> >      opened or closed to prevent a cache file from being culled and to=
 keep
> >      resources to hand that are needed to do I/O.
> >
> >      Unuse the cookie when a file is opened for writing.  This is gate=
d by
> >      the NFS_INO_FSCACHE flag on the nfs_inode.
> >
> >      A better way might be to invalidate it with FSCACHE_INVAL_DIO_WRI=
TE
> >      which will keep it unused until all open files are closed.
> >
> =

> Comment still out of date here, reference
> https://marc.info/?l=3Dlinux-nfs&m=3D163922984027745&w=3D4

Okay, how about:

 (4) fscache_enable/disable_cookie() have been removed.

     Call fscache_use_cookie() and fscache_unuse_cookie() when a file is
     opened or closed to prevent a cache file from being culled and to kee=
p
     resources to hand that are needed to do I/O.

     If a file is opened for writing, we invalidate it with
     FSCACHE_INVAL_DIO_WRITE in lieu of doing writeback to the cache,
     thereby making it cease caching until all currently open files are
     closed.  This should give the same behaviour as the uptream code.
     Making the cache store local modifications isn't straightforward for
     NFS, so that's left for future patches.

David

