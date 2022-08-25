Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5AE5A15D1
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Aug 2022 17:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242937AbiHYPbn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Aug 2022 11:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243276AbiHYPbH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Aug 2022 11:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773A413E8A
        for <linux-nfs@vger.kernel.org>; Thu, 25 Aug 2022 08:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661441465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bcBEWvFtJ5NmdnAB/S7p0gK5rp/4clo47N5JIYngCSc=;
        b=HehyD/QG5UFRuB9lQw7zGlJaduusg4GVSEMktO7zMTBTL9y6617Qz/3j772+VT0Ce54Qxc
        7CYSiNlU2sM9JpGw+0Pp/GgzVwD2TNrCVjGlNwyY7q3+A66GgvrBhcwyRidvyvvFmBZC8E
        KMlYUmWX0xopPd7etLChwvVlfSlPacs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-Z4j1jXTIOVCedlDyNkwVrw-1; Thu, 25 Aug 2022 11:31:02 -0400
X-MC-Unique: Z4j1jXTIOVCedlDyNkwVrw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF2B1101E989;
        Thu, 25 Aug 2022 15:30:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0AF24010FA0;
        Thu, 25 Aug 2022 15:30:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YweOySTkKQ3PDLCv@casper.infradead.org>
References: <YweOySTkKQ3PDLCv@casper.infradead.org> <da9200f1bded9b8b078a7aef227fd6b92eb028fb.camel@hammerspace.com> <20220824093501.384755-1-dwysocha@redhat.com> <20220824093501.384755-3-dwysocha@redhat.com> <429ecc819fcffe63d60dbb2b72f9022d2a21ddd8.camel@hammerspace.com> <CALF+zOknvMZyufSUD-g9Z9Y5RfwE-vUFT+CF0kxqbcpR=yJPJw@mail.gmail.com> <216681.1661350326@warthog.procyon.org.uk> <5ab3188affa7e56e68a4f66a42f45d7086c1da23.camel@hammerspace.com> <YwZXfSXMzZgaSPAg@casper.infradead.org> <5dfadceb26da1b4d8d499221a5ff1d3c80ad59c0.camel@hammerspace.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire.byrne@gmail.com" <daire.byrne@gmail.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "benmaynard@google.com" <benmaynard@google.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>
Subject: Re: [RFC PATCH 2/3] NFS: Add support for netfs in struct nfs_inode and Kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3965610.1661441458.1@warthog.procyon.org.uk>
Date:   Thu, 25 Aug 2022 16:30:58 +0100
Message-ID: <3965611.1661441458@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> AFS tracks one dirty range per folio, but it first brings the folio uptodate
> by reading it from the server before overwriting it (I suppose that's a
> fourth option).

I'm intending on moving afs towards the nfs way of doing things when writing
to as-yet unread folios - unless a cache is in operation, then we read it
anyway and store the folio(s) into the cache unless the entire cache granule
is going to be overwritten unless we're supporting disconnected mode.  I know
that's exceptions-to-exceptions.

David

