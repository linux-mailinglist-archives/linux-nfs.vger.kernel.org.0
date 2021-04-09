Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60388359E23
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Apr 2021 14:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhDIMBD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Apr 2021 08:01:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232295AbhDIMBC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Apr 2021 08:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617969649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WpLBLcM5HPbHBdhYvmuIcG5jaKMHS2dswa4uwPfKors=;
        b=ddqJww6q/+Fvay8Q/YJyqvXUIiPe3AaiebmL5ZWT32Z8Jo/NS/uNofG2WbF5wvHvQAzsQZ
        JgsUv24XhKy9e7JAZ0W5LdP+UmhIi/motpJNcqpddAwbUMW81Ec8UPoP3sgAQ6ifrKToTK
        iiom43ZXPFzlL+2Z7Kol7I83wwtWfLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-VXpQijEJOlSLOJb_BO2ZXA-1; Fri, 09 Apr 2021 08:00:46 -0400
X-MC-Unique: VXpQijEJOlSLOJb_BO2ZXA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 845A55B38D;
        Fri,  9 Apr 2021 12:00:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-35.rdu2.redhat.com [10.10.119.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C29B160622;
        Fri,  9 Apr 2021 12:00:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210409111636.GR2531743@casper.infradead.org>
References: <20210409111636.GR2531743@casper.infradead.org> <CAHk-=wi_XrtTanTwoKs0jwnjhSvwpMYVDJ477VtjvvTXRjm5wQ@mail.gmail.com> <161796595714.350846.1547688999823745763.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, jlayton@kernel.org, hch@lst.de,
        linux-cachefs@redhat.com, v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] mm: Return bool from pagebit test functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <453416.1617969640.1@warthog.procyon.org.uk>
Date:   Fri, 09 Apr 2021 13:00:40 +0100
Message-ID: <453417.1617969640@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Apr 09, 2021 at 11:59:17AM +0100, David Howells wrote:
> > Make functions that test page bits return a bool, not an int.  This means
> > that the value is definitely 0 or 1 if they're used in arithmetic, rather
> > than rely on test_bit() and friends to return this (though they probably
> > should).
> 
> iirc i looked at doing this as part of the folio work, and it ended up
> increasing the size of the kernel.  Did you run bloat-o-meter on the
> result of doing this?

Hmmm.  With my usual monolithic x86_64 kernel, it makes vmlinux text section
100 bytes larger (19392347 rather than 19392247).  I can look into why.

David

