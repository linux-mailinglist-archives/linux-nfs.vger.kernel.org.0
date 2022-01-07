Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A4B48765D
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jan 2022 12:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347061AbiAGLUP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Jan 2022 06:20:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48520 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347054AbiAGLUN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Jan 2022 06:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641554412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PswEpjxzjKrjXqvo3ZcUyyPMxbfB05nP29oDsBh+1Z4=;
        b=dcU4TT+000R99CGvrPN4CxWlqYaarfdF5pRcHuCj0sb6kadvg7q251/Aoj9sFxKDY/Rpi5
        qX/YtOISywNVkSzPzO8CZu4NbEb5YMDOSys2GE/DLZXll+2PpkKKYmEQLMXhN9jMQfwxEC
        8qxtNtjqk/6J3Q0rL+6XuhjjOPcivU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-_zFRiW7tPMu4lwviEKOwRQ-1; Fri, 07 Jan 2022 06:20:07 -0500
X-MC-Unique: _zFRiW7tPMu4lwviEKOwRQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CF571800D50;
        Fri,  7 Jan 2022 11:20:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D1597E23A;
        Fri,  7 Jan 2022 11:19:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1e102cc81aaf71df2b7f5ae906b79c188a34a111.camel@kernel.org>
References: <1e102cc81aaf71df2b7f5ae906b79c188a34a111.camel@kernel.org> <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk> <164021549223.640689.14762875188193982341.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 44/68] cachefiles: Implement key to filename encoding
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3149373.1641554392.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 07 Jan 2022 11:19:52 +0000
Message-ID: <3149374.1641554392@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> Since most cookies are fairly small, is there any real benefit to
> optimizing for length here? How much inflation are we talking about?

Taking AFS as an example, a vnode is represented at the file level by two
numbers: a 32-bit or 96-bit file ID and a 32-bit uniquifier.  If it's a 96=
-bit
file ID, a lot of the time, the upper 64-bits will be zero, so we're talki=
ng
something like:

	S421d4,1f07f34,,

instead of:

	S000421d401f07f340000000000000000

or:

	E0AAQh1AHwfzQAAAAAAAAAAA=3D=3D

The first makes for a more readable name in the cache.  The real fun is wi=
th
NFS, where the name can be very long.  For one that's just 5 words in leng=
th:

	T81010001,1,20153e2,,a906194b

instead of:

	T8101000100000001020153e200000000a906194b

or:

	E0gQEAAQAAAAECAVPiAAAAAKkGGUs=3D

(The letter on the front represents the encoding scheme; in the base64 enc=
oding
the second digit indicates the amount of padding).

I don't know how much difference it makes to the backing filesystem's
directory packing - and it may depend on the particular filesystem.

David

