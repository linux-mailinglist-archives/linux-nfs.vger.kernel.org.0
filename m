Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB66A7CAE93
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Oct 2023 18:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjJPQK3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Oct 2023 12:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjJPQK1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Oct 2023 12:10:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246C6F1
        for <linux-nfs@vger.kernel.org>; Mon, 16 Oct 2023 09:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697472583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iqaZ7DcM+18tUsVRQeG7YQZoHIt0T3tkZ81YQtekvTU=;
        b=d9Ge7DQwNceiP8fa3gyJM05tXcObKUHcj5l5YFiPaYoDLRzt4IUdwZKqonZsJRySgrGc4a
        vt1vTJo4Sj9L3BcLcP1/joVnlnqWM2hKP2YueV72ElPn3XBSnLQjy9GX7HD1mjh9kw9rjf
        QrXiRtaoW0ukipuhgOKWV/+GIeUecF8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-XkDUqMmGO5qnLyDuWfP0Dw-1; Mon, 16 Oct 2023 12:09:34 -0400
X-MC-Unique: XkDUqMmGO5qnLyDuWfP0Dw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0A2E800969;
        Mon, 16 Oct 2023 16:09:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F03C111D3DC;
        Mon, 16 Oct 2023 16:09:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <e1351696345351cb3d168fb41c54a1ef8ccf0b16.camel@kernel.org>
References: <e1351696345351cb3d168fb41c54a1ef8ccf0b16.camel@kernel.org> <20231013160423.2218093-1-dhowells@redhat.com> <20231013160423.2218093-10-dhowells@redhat.com>
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
Subject: Re: [RFC PATCH 09/53] netfs: Implement unbuffered/DIO vs buffered I/O locking
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2840728.1697472569.1@warthog.procyon.org.uk>
Date:   Mon, 16 Oct 2023 17:09:29 +0100
Message-ID: <2840729.1697472569@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

> It's nice to see this go into common code, but why not go ahead and
> convert ceph (and possibly NFS) to use this? Is there any reason not to?

I'm converting ceph on a follow-on branch and for ceph this will be dealt with
there.

I could do NFS round about here, I suppose.

David

