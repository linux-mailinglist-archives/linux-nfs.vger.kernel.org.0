Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85A27CAFDA
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Oct 2023 18:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbjJPQjU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Oct 2023 12:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbjJPQhv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Oct 2023 12:37:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1593855
        for <linux-nfs@vger.kernel.org>; Mon, 16 Oct 2023 09:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697473215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=63Rq1KcfOTDhlc8whKkbAUCIQI+yHNiEHhPiU2TPE3M=;
        b=HRNQytnv7Y6pZMpjuu1yAzzjcGGzFjvfIthtsY5oQ5g821gtGns5wa5M3wZ0g2CRosNoft
        6HXCqRzz2ihMxC6sEjTMKmhfTI40wSxRJSOtiSFm/56k/DoTRYUvGbU2QXNWm/S3/ok9FR
        ehkS4nK9I8ATQAV9O9T+/nBGGHFQhpg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-bJAGqS1LPQevnpXDvvjhEQ-1; Mon, 16 Oct 2023 12:19:55 -0400
X-MC-Unique: bJAGqS1LPQevnpXDvvjhEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E3DE862F4E;
        Mon, 16 Oct 2023 16:19:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A802825C8;
        Mon, 16 Oct 2023 16:19:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <be2434a2d51900b9e51d8bf0fe5a8b82e3f1a879.camel@kernel.org>
References: <be2434a2d51900b9e51d8bf0fe5a8b82e3f1a879.camel@kernel.org> <20231013160423.2218093-1-dhowells@redhat.com> <20231013160423.2218093-9-dhowells@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, Steve French <smfrench@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com
Subject: Re: [RFC PATCH 08/53] netfs: Add rsize to netfs_io_request
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2840973.1697473191.1@warthog.procyon.org.uk>
Date:   Mon, 16 Oct 2023 17:19:51 +0100
Message-ID: <2840974.1697473191@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> > +	rreq->rsize = 4 * 1024 * 1024;
> >  	return 0;
> ...
> > +	rreq->rsize = 1024 * 1024;
> > +
> 
> Holy magic numbers, batman! I think this deserves a comment that
> explains how you came up with these values.

Actually, that should be set to something like the object size for ceph.

> Also, do 9p and cifs not need this for some reason?

At this point, cifs doesn't use netfslib, so that's implemented in a later
patch in this series.

9p does need setting, but I haven't tested that yet.  It probably needs
setting to 1MiB as I think that's the maximum the 9p transport can handle.

But in the case of cifs, this is actually dynamic, depending on how many
credits we can obtain.  The same may be true of ceph, though I'm not entirely
clear on that as yet.

For afs, the maximum [rw]size the protocol supports is actually something like
281350422593565 (ie. (65535-28) * (2^32-1)) minus a few bytes, but that's
probably not a good idea.  I might be best setting it at something like 256KiB
as that's what OpenAFS uses.

David

