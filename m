Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C122D23398D
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jul 2020 22:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgG3UFP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jul 2020 16:05:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24182 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726939AbgG3UFP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jul 2020 16:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596139514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BKn7BpC5Yl43Dk6OZEWBG/yR01/4YmaH6m9WnDrhG3w=;
        b=QG1W4nhelwefq28epF9B5pOLbYsmnpMEoC2FLLy9e47ARnDaLzI3r2W+P4R/Rh1/n2JGyv
        5c96ArKLgc1B7jH78EXWc73Ly93zeDLbViH/SsVhaZdmf1ZvBf2V9oXt9fHDov6a20VRMp
        JRyGIhvZvy7jPyoom+X7vjQ3A76saNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-kKQeCJp-O7OXk9OZWW4V7w-1; Thu, 30 Jul 2020 16:05:11 -0400
X-MC-Unique: kKQeCJp-O7OXk9OZWW4V7w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EBDE18839EB;
        Thu, 30 Jul 2020 20:03:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5282219D7B;
        Thu, 30 Jul 2020 20:03:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CALF+zOn9tSft_QkPaJ7w8v_OLTfon+acUB_W9MSb8EEMQGc94w@mail.gmail.com>
References: <CALF+zOn9tSft_QkPaJ7w8v_OLTfon+acUB_W9MSb8EEMQGc94w@mail.gmail.com> <1596031949-26793-1-git-send-email-dwysocha@redhat.com> <1596031949-26793-14-git-send-email-dwysocha@redhat.com> <43e8a8ff1ea015bb7bd335d5616268d36155327a.camel@redhat.com> <CALF+zOnYLbibbYxvbyUJFJQ+NtcreuAvFkZYr9h3_qQswbMxRw@mail.gmail.com>
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>, linux-cachefs@redhat.com
Subject: Re: [Linux-cachefs] [RFC PATCH v2 13/14] NFS: Call fscache_resize_cookie() when inode size changes due to setattr
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <538845.1596139431.1@warthog.procyon.org.uk>
Date:   Thu, 30 Jul 2020 21:03:51 +0100
Message-ID: <538846.1596139431@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

David Wysochanski <dwysocha@redhat.com> wrote:

> To be honest I'm not sure about needing a call to fscache_use/unuse_cookie()
> around the call to fscache_resize_cookie().  If the cookie has a
> refcount of 1 when it is created, and a file is never opened, so
> we never call fscache_use_cookie(), what might happen inside
> fscache_resize_cookie()?  The header on use_cookie() says

I've have afs_setattr() doing use/unuse on the cookie around resize.

David

