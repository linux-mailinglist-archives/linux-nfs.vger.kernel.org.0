Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A9941EFD8
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Oct 2021 16:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354483AbhJAOo0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Oct 2021 10:44:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231679AbhJAOo0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Oct 2021 10:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633099361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E29GZ2oEbpCi3bTn8wkvjiBB0VUKNYOMdkitkRG9tXs=;
        b=So6R8w2g4poGZUdOtBqJ/BD24r58KhM4pZsixfBM5B0jce04seasJWVHkCbn6wmbkZUTu7
        sTsbcCjTe5rRvXnGWOSswsFeCo9WA3I9XkIFAX8fA5T/dfkBaHMTcZBVcHYkb1Nh6+nf9e
        IDcLyocJYQUQ66TI78NtQMgAOlaTbog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-2Jg3beaEOz6nx_TdC4EhkQ-1; Fri, 01 Oct 2021 10:42:34 -0400
X-MC-Unique: 2Jg3beaEOz6nx_TdC4EhkQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E74F6101F00D;
        Fri,  1 Oct 2021 14:42:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C9825DA61;
        Fri,  1 Oct 2021 14:42:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CALF+zO=165sRYRaxPpDS7DaQCpTe-YOa4FamSoMy5FV2uuG5Yg@mail.gmail.com>
References: <CALF+zO=165sRYRaxPpDS7DaQCpTe-YOa4FamSoMy5FV2uuG5Yg@mail.gmail.com> <163189104510.2509237.10805032055807259087.stgit@warthog.procyon.org.uk> <163189108292.2509237.12615909591150927232.stgit@warthog.procyon.org.uk>
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>
Subject: Re: [PATCH v2 3/8] nfs: Move to using the alternate fallback fscache I/O API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <80681.1633099351.1@warthog.procyon.org.uk>
Date:   Fri, 01 Oct 2021 15:42:31 +0100
Message-ID: <80682.1633099351@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

David Wysochanski <dwysocha@redhat.com> wrote:

> The added "if (ret < 0) ..." renders the bulk of the switch statement with
> non-zero cases moot.  I have a patch or two on top of it that cleans this
> up, and replaces the dfprintks with tracepoints.  If you want I can try to
> merge at least bits of it into a v3 of this patch, and leave the dfprintk
> conversion to tracepoints for another patch.

If you can give me the clean up bits, I can fold them in.  I think it's
probably worth keeping the dfprintk conversion separate.

David

