Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5817E7CB010
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Oct 2023 18:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbjJPQmS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Oct 2023 12:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjJPQl6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Oct 2023 12:41:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976001FEC
        for <linux-nfs@vger.kernel.org>; Mon, 16 Oct 2023 09:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697473880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rbzg7U/87dJSaK89YmTgCyu23XfU1BhnpwaB496FV9g=;
        b=BOBTuB52y0K0wAR6s5CX7xgG1BncSFYX1sn3YfPs1bk0qfe7Wa4BiskcwpkSPMKCQ0r5U/
        qo3DAlcGX3nEFEsVMLh67Lhri50sAV56zmTQJH+qGWU/NuxQHOGhVU/F+wXFR+fgxvIuAe
        Y8Zf8lhtAI+B+rmlKFxv+LPgw34oOKQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-g1DVukGdOg29WJloZ1VP1g-1; Mon, 16 Oct 2023 12:31:16 -0400
X-MC-Unique: g1DVukGdOg29WJloZ1VP1g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 523CF81D9E2;
        Mon, 16 Oct 2023 16:31:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7B49492BEE;
        Mon, 16 Oct 2023 16:31:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <11ec6f637698feb04963c6a7c39a5ca80af95464.camel@kernel.org>
References: <11ec6f637698feb04963c6a7c39a5ca80af95464.camel@kernel.org> <20231013155727.2217781-1-dhowells@redhat.com> <20231013155727.2217781-3-dhowells@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, Steve French <smfrench@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
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
Subject: Re: [RFC PATCH 02/53] netfs: Track the fpos above which the server has no data
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2841425.1697473872.1@warthog.procyon.org.uk>
Date:   Mon, 16 Oct 2023 17:31:12 +0100
Message-ID: <2841426.1697473872@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

> >  (7) If stored data is culled from the local cache, we must set zero_point
> >      above that if the data also got written to the server.
> 
> When you say culled here, it sounds like you're just throwing out the
> dirty cache without writing the data back. That shouldn't be allowed
> though, so I must be misunderstanding what you mean here. Can you
> explain?

I meant fscache specifically.  Too many caches - and some of them with the
same names!

> >  (8) If dirty data is written back to the server, but not the local cache,
> >      we must set zero_point above that.
> 
> How do you write back without writing to the local cache? I'm guessing
> this means you're doing a non-buffered write?

I meant fscache.  fscache can decline to honour a request to store data.

> > +		if (size != i_size) {
> > +			truncate_pagecache(&vnode->netfs.inode, size);
> > +			netfs_resize_file(&vnode->netfs, size);
> > +			fscache_resize_cookie(afs_vnode_cache(vnode), size);
> > +		}
> 
> Isn't this an existing bug? AFS is not setting remote_i_size in the
> setattr path currently? I think this probably ought to be done in a
> preliminary AFS patch.

It is being set.  afs_apply_status() sets it.  This is called by
afs_vnode_commit_status() which is called from afs_setattr_success().  The
value isn't updated until we get the return status from the server that
includes the new value.

> > +	loff_t			zero_point;	/* Size after which we assume there's no data
> > +						 * on the server */
> 
> While I understand the concept, I'm not yet sure I understand how this
> new value will be used. It might be better to merge this patch in with
> the patch that adds the first user of this data.

I'll consider it.  At least it might make sense to move them adjacent to each
other in the series.

David

