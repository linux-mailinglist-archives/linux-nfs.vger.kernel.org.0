Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1693F76D5
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Aug 2021 16:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238092AbhHYOGp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Aug 2021 10:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34660 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232058AbhHYOGp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Aug 2021 10:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629900358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ye7x7ROLpLa4uVII3MBvGoJurLkOurh44zhhrnNWmF8=;
        b=PlSp3eljiYjbFR7oDHpakV0l/I8O/eoK74I2CKLUu8qKqMPDq0e73IbwyW505RgkDNtDxP
        06uKZKZMkgo89yLbNGd6kzixho25gTB5bo6bzCJpEUTIsGCws9W35Yn3yfiEvnPlu00tyy
        n5/vTLkH6MaBuSKFD4kqyw66Yyj/WNY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-8zB0ShKZMiSW63FKSCZu_g-1; Wed, 25 Aug 2021 10:05:57 -0400
X-MC-Unique: 8zB0ShKZMiSW63FKSCZu_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3302B101C8AE;
        Wed, 25 Aug 2021 14:05:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A820060C04;
        Wed, 25 Aug 2021 14:05:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <6370d0a74c3ceb79c53305a64ba7a982d16d34b4.camel@redhat.com>
References: <6370d0a74c3ceb79c53305a64ba7a982d16d34b4.camel@redhat.com> <162431188431.2908479.14031376932042135080.stgit@warthog.procyon.org.uk> <162431203107.2908479.3259582550347000088.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] fscache: Fix fscache_cookie_put() to not deref after dec
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2030918.1629900351.1@warthog.procyon.org.uk>
Date:   Wed, 25 Aug 2021 15:05:51 +0100
Message-ID: <2030919.1629900351@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Jeff Layton <jlayton@redhat.com> wrote:

> > fscache_cookie_put() accesses the cookie it has just put inside the
> > tracepoint that monitors the change - but this is something it's not
> > allowed to do if we didn't reduce the count to zero.
> 
> Do you mean "if the count went to zero." ?

No.  If *we* reduced the count to zero, it falls to us to destroy the object,
so we're allowed to look into it again.

If we didn't reduce the count to zero, then someone else might destroy it
before we look into it again.

David

