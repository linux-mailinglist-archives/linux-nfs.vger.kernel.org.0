Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C14223F5C
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jul 2020 17:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGQPTj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jul 2020 11:19:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56867 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726344AbgGQPTj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jul 2020 11:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594999177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hbMhLgmVXGpPqj2waLvBYafgWE5dQt0MOjw1CX4mbfU=;
        b=LYqy8gbglO42r3GacX6NtEyAzczkevchQ0mM8UTsRNUtfYr4bbwFX8zxFM3LJdbKYKrJ3y
        723WZaub+1K9jp6ccs5IiOKxmKoy80MRCwe5i2PGC8cSYlCmXbzeIaodVYGObC++YkiGTZ
        6lhYnqUror3Not8SryGyC6he+Sgmwo8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-mCiPQADUNgGXm9zh9ViLVg-1; Fri, 17 Jul 2020 11:19:32 -0400
X-MC-Unique: mCiPQADUNgGXm9zh9ViLVg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 591F919253C0;
        Fri, 17 Jul 2020 15:19:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91C9872E48;
        Fri, 17 Jul 2020 15:19:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200717142541.GA21567@fieldses.org>
References: <20200717142541.GA21567@fieldses.org> <1594825849-24991-1-git-send-email-dwysocha@redhat.com>
To:     bfields@fieldses.org (J. Bruce Fields)
Cc:     dhowells@redhat.com, Dave Wysochanski <dwysocha@redhat.com>,
        linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: [Linux-cachefs] [RFC PATCH v1 0/13] Convert NFS client to new fscache-iter API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3607830.1594999165.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 17 Jul 2020 16:19:25 +0100
Message-ID: <3607831.1594999165@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

J. Bruce Fields <bfields@fieldses.org> wrote:

> Say I had a hypothetical, err, friend, who hadn't been following that
> FS-Cache work--could you summarize the advantages it bring us?

https://lore.kernel.org/linux-nfs/159465784033.1376674.1810646369398981103=
7.stgit@warthog.procyon.org.uk/T/#t

 - Makes the caching code a lot simpler (~2400 LoC removed, ~1000 LoDoc[*]
   removed at the moment from fscache, cachefiles and afs).

 - Stops using bmap to work out what data is cached.  This isn't reliable =
with
   modern extend-based filesystems.  A bitmap of cached granules is saved =
in
   an xattr instead.

 - Uses async DIO (kiocbs) to do I/O to/from the cache rather than using
   buffered writes (kernel_write) and pagecache snooping for read (don't a=
sk).

   - A lot faster and less CPU intensive as there's no page-to-page copyin=
g.

   - A lot less VM pressure as it doesn't have duplicate pages in the back=
ing
     fs that aren't really accounted right.

 - Uses tmpfiles+link to better handle invalidation.  It will at some poin=
t
   hopefully employ linkat(AT_LINK_REPLACE) to effect cut-over on disk rat=
her
   than unlink,link.

David

[*] The upstream docs got ReSTified, so the doc patches I have are now use=
less
    and need reworking:-(.

