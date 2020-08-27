Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC19254967
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Aug 2020 17:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgH0P3I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Aug 2020 11:29:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51116 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726867AbgH0P3I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Aug 2020 11:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598542146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+kaDLLF1f55NCIko0/llJRLFGMqoBN4rwHWmAV1FCCk=;
        b=F2cJBMMYJY73NsbdUIafpW3IKZP3ILqr91GfzK6tOgeMZAY5/T6anXHMvKE/stNzAqrzyh
        8ybzke+A24Dr9eb9Oy2E+o6YnMoOtvf89Kln3LM9e/SJSXT9n6bJHk23mSVuC1euayhekT
        1Xd5DRMqc7vjljfA/bSpsNOWbqmZVf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-9dtdZprBOgSEsWY5L1TUOg-1; Thu, 27 Aug 2020 11:29:05 -0400
X-MC-Unique: 9dtdZprBOgSEsWY5L1TUOg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56CE310ABDC2;
        Thu, 27 Aug 2020 15:29:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14FE85C1C2;
        Thu, 27 Aug 2020 15:28:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200810164044.GA31753@lst.de>
References: <20200810164044.GA31753@lst.de> <1851200.1596472222@warthog.procyon.org.uk> <447452.1596109876@warthog.procyon.org.uk> <667820.1597072619@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] fscache rewrite -- please drop for now
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1428310.1598542135.1@warthog.procyon.org.uk>
Date:   Thu, 27 Aug 2020 16:28:55 +0100
Message-ID: <1428311.1598542135@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> FYI, a giant rewrite dropping support for existing consumer is always
> rather awkward.  Is there any way you could pre-stage some infrastructure
> changes, and then do a temporary fscache2, which could then be renamed
> back to fscache once everyone switched over?

That's a bit tricky.  There are three points that would have to be shared: the
userspace miscdev interface, the backing filesystem and the single index tree.

It's probably easier to just have a go at converting 9P and cifs.  Making the
old and new APIs share would be a fairly hefty undertaking in its own right.

David

