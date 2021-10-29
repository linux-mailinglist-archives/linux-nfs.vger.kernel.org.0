Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36249440287
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Oct 2021 20:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhJ2Sya (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Oct 2021 14:54:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38664 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230273AbhJ2Sy2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Oct 2021 14:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635533518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/vX1aXmgWDOmHXytC/xtmTFfVJMO+hskcobUwtJeMmI=;
        b=H8seKFppfj7RTniLl8qMPFbNHiBTU/Cx6TGPmDtuYq7STB6GNxpFB/+QjX7t8a4wzfU6SA
        p2JWZriQeHgAGkSlA3V11yBruuF+HkBR3tgbxZC3CPVge2OsRYNbzZ+EmYgxhDc7oM3GWc
        Kh0dM4UchE9yJKCS4JjlS00zJFUzE8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-p1zGB8TrMduU9GKrjace1w-1; Fri, 29 Oct 2021 14:51:55 -0400
X-MC-Unique: p1zGB8TrMduU9GKrjace1w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 008188F515;
        Fri, 29 Oct 2021 18:51:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E18845D6CF;
        Fri, 29 Oct 2021 18:51:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wg_C6V_S+Aox5Fn7MuFe13ADiRVnh6UcvY4WX9JjXn3dg@mail.gmail.com>
References: <CAHk-=wg_C6V_S+Aox5Fn7MuFe13ADiRVnh6UcvY4WX9JjXn3dg@mail.gmail.com> <163551653404.1877519.12363794970541005441.stgit@warthog.procyon.org.uk> <CAHk-=wiy4KNREEqvd10Ku8VVSY1Lb=fxTA1TzGmqnLaHM3gdTg@mail.gmail.com> <1889041.1635530124@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net,
        CIFS <linux-cifs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-cachefs@redhat.com, Dave Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/10] fscache: Replace and remove old I/O API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1891410.1635533494.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 29 Oct 2021 19:51:34 +0100
Message-ID: <1891411.1635533494@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> But:
> =

> > However, if you would rather I just removed all of fscache and (most o=
f[*])
> > cachefiles, that I can do.
> =

> I assume and think that if you just do that part first, then the
> "convert to netfslib" of afs and ceph at that later stage will mean
> that the fallback code will never be needed?

The netfslib coversions for afs and ceph are already in your tree and I ha=
ve a
patch here to do that for 9p (if you're willing to take that in the upcomi=
ng
merge window?).

The issue is cifs[*] and nfs.  I could leave caching in those disabled,
pending approved patches for those filesystems.  This would mean that I
wouldn't need the fallback code.

An alternative is that I could move the "fallback" code into fs/nfs/fscach=
e.c
and fs/cifs/fscache.c if that would be easier and merge it into the functi=
ons
there.  The problem will come when the cache wants to do I/O in larger uni=
ts
than page size to suit its own block size[**].

David

[*] As it happens, it turns out that cifs seems to have a bug in it that
causes the entire cache for a superblock to be discarded each time that
superblock is mounted.

[**] At some point the cache *has* to start keeping track of what data it =
is
holding rather than relying on bmap/SEEK_DATA/SEEK_HOLE to get round the
extent-bridging problem.  I'm trying to take a leaf out of the book of oth=
er
caching filesystems and use larger block sizes (e.g. 256K) to reduce the
overhead of cache metadata.

