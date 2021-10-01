Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D94B41F001
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Oct 2021 16:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354644AbhJAOx7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Oct 2021 10:53:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31588 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354663AbhJAOx7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Oct 2021 10:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633099935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NSYTN0aAN3tGHA9vNvHCB7aOEx6YOmDB8klvv8KBMGc=;
        b=Jx+WvLQH/gS7cb7aDyz8q7qhjO7/pv1GmiTIkP617STH4I9tU2gRvJ3OxKGw6+tW5ljRGz
        6I9RYLONLUjzlMLm0gABaIK9vghZNEhj1BIKPPEa3BGARyzbfaQXcS1IuClUZ/Z+bKYtBl
        KrR745EdkSEiDKcoRi7GsrU7d7M5zD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-vb7rTdsSM7-ptcLEbY7RJA-1; Fri, 01 Oct 2021 10:52:12 -0400
X-MC-Unique: vb7rTdsSM7-ptcLEbY7RJA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D43E018125C1;
        Fri,  1 Oct 2021 14:52:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A59815BAE0;
        Fri,  1 Oct 2021 14:51:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <97eb17f51c8fd9a89f10d9dd0bf35f1075f6b236.camel@hammerspace.com>
References: <97eb17f51c8fd9a89f10d9dd0bf35f1075f6b236.camel@hammerspace.com> <163189104510.2509237.10805032055807259087.stgit@warthog.procyon.org.uk> <163189108292.2509237.12615909591150927232.stgit@warthog.procyon.org.uk> <CALF+zO=165sRYRaxPpDS7DaQCpTe-YOa4FamSoMy5FV2uuG5Yg@mail.gmail.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     dhowells@redhat.com, dwysocha@redhat.com,
        anna.schumaker@netapp.com, Matthew Wilcox <willy@infradead.org>,
        linux-cachefs@redhat.com, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Can the GFP flags to releasepage() be trusted? -- was Re: [PATCH v2 3/8] nfs: Move to using the alternate fallback fscache I/O API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <81119.1633099916.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 01 Oct 2021 15:51:56 +0100
Message-ID: <81120.1633099916@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond Myklebust <trondmy@hammerspace.com> wrote:

> > > @@ -432,7 +432,12 @@ static int nfs_release_page(struct page *page, =
gfp_t gfp)
> > >  	/* If PagePrivate() is set, then the page is not freeable */
> > >  	if (PagePrivate(page))
> > >  		return 0;
> > > -	return nfs_fscache_release_page(page, gfp);
> > > +	if (PageFsCache(page)) {
> > > +		if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS))
> > > +			return false;
> > > +		wait_on_page_fscache(page);
> > > +	}
> > > +	return true;
> > >  }
> =

> I've found this generally not to be safe. The VM calls ->release_page()
> from a variety of contexts, and often fails to report it correctly in
> the gfp flags. That's particularly true of the stuff in mm/vmscan.c.
> This is why we have the check above that vetos page removal upon
> PagePrivate() being set.

[Adding Willy and the mm crew to the cc list]

I wonder if that matters in this case.  In the worst case, we'll wait for =
the
page to cease being DMA'd - but we won't return true if it is.

But if vmscan is generating the wrong VM flags, we should look at fixing t=
hat.

David

