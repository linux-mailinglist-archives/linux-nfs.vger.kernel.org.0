Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342263518C9
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Apr 2021 19:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbhDARrj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Apr 2021 13:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51308 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234276AbhDARmQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Apr 2021 13:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617298936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WvQa+OFrW5Va5fKOaEC+GHMYXi23ytEjTAR9F/0dm5w=;
        b=dS5/st8LlnzfBjdUjhyQjDAxhP3/ADkgUncgvw2cral1oyyOKTv7+v46rGXun0mUaYbfnR
        f/BYLE4Wpliti/PXLkd1brJvuBRSiL3d5Oe6VcenO6j98AadAhvkhRUCceDzkvVSAiZWUw
        pxCR8i/7wl4KaG/qfDoc2/pPfLOl4Ro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-1JSlI9TwOUazfMMSGAgqbA-1; Thu, 01 Apr 2021 11:41:45 -0400
X-MC-Unique: 1JSlI9TwOUazfMMSGAgqbA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0188F108BD06;
        Thu,  1 Apr 2021 15:41:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6006D5C237;
        Thu,  1 Apr 2021 15:41:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210401151339.GE351017@casper.infradead.org>
References: <20210401151339.GE351017@casper.infradead.org> <49e123c6702cb6b27f114dfa64157d9a73463fad.camel@hammerspace.com> <CALF+zOnCisFWTubWEHhTLpt6=CUb7n86YvrNX3nreCYS73_v_Q@mail.gmail.com> <3727198.1617285066@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        jlayton@kernel.org, Steve French <sfrench@samba.org>
Subject: Re: RFC: Approaches to resolve netfs API interface to NFS multiple completions problem
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3737151.1617291701.1@warthog.procyon.org.uk>
Date:   Thu, 01 Apr 2021 16:41:41 +0100
Message-ID: <3737152.1617291701@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

>  - I don't understand how a folio gets to be partially cached.  Cached
>    should be tracked on a per-folio basis (like dirty or uptodate), not
>    on a per-page basis.  The point of the folio work is that managing
>    memory in page-sized chunks is now too small for good performance.

Consider the following scenario:

 (1) You read two 256K chunks from an nfs file.  These are downloaded from the
     server and cached.

 (2) The nfs inode is dropped from the cache.

 (3) You do a 1M read that includes both 256K chunks.

The VM might create a 1M folio to handle (3) that covers the entire read, but
only half of the data is in the cache; the other half has to be fetched from
the server.

David

