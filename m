Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C5047319C
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Dec 2021 17:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbhLMQXA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Dec 2021 11:23:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234563AbhLMQXA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Dec 2021 11:23:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639412578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+7tw6CacjHpoJ+4+RJN7+YJ1xW4fzNGqGBz5JPgltyk=;
        b=HpbAm3cUpAlJHPNTu66Wkxvpccr2JtUpzWtI97w2DYuD7pdxp7aXMUu4a7UDp2P9jtiXj7
        vPHX+1ZsGen58USKmLDmC223FVgbWhvD7BJ6PzEcXdjiIueYjK5+E6y3gzv1zviZkxRXY+
        nypPwX5Q/uelPRFWQjC0RlRoGzdxpLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-08poFCnQMx6bfRqkwyXIcQ-1; Mon, 13 Dec 2021 11:22:57 -0500
X-MC-Unique: 08poFCnQMx6bfRqkwyXIcQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E30B08015CD
        for <linux-nfs@vger.kernel.org>; Mon, 13 Dec 2021 16:22:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC50B60C9F;
        Mon, 13 Dec 2021 16:22:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <599331.1639410068@warthog.procyon.org.uk>
References: <599331.1639410068@warthog.procyon.org.uk> <CALF+zOnmJ0=j8pEMikpxYgLrS10gVZiXfCjBhDz9Je0Qip7wnw@mail.gmail.com> <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk> <CALF+zOnA2U6LjDTE8m2REDTMmFVnWkcBkn0ZJQRGULPUjeQW4Q@mail.gmail.com>
Cc:     dhowells@redhat.com, David Wysochanski <dwysocha@redhat.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] fscache: Need to go round again after processing LRU_DISCARDING state
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <604660.1639412575.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 13 Dec 2021 16:22:55 +0000
Message-ID: <604661.1639412575@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> However, if both LRU discard and relinquishment happen *before* the SM
> runs, one of the queue events will get discarded, along with the ref tha=
t
> would be associated with it.  The last ref is then discarded and the coo=
kie
> is removed without completing the relinquishment process - leaving the
> cookie hashed.

This can be seen in a trace, e.g.:

  kworker/u16:97-5939    [000] .....   639.403740: fscache_cookie: c=3D000=
071a9 -   lrudo r=3D3
  kworker/u16:97-5939    [000] .....   639.403741: fscache_cookie: c=3D000=
071a9 GQ  endac r=3D4
  kworker/u16:97-5939    [000] .....   639.403745: fscache_cookie: c=3D000=
071a9 PUT lru   r=3D3
       dirstress-7027    [002] .....   639.427220: fscache_relinquish: c=3D=
000071a9 V=3D00000001 r=3D3 U=3D0 f=3Dbd rt=3D0
       dirstress-7027    [002] .....   639.427222: fscache_cookie: c=3D000=
071a9 GQ  endac r=3D4
       dirstress-7027    [002] .....   639.427223: fscache_cookie: c=3D000=
071a9 PQ  overq r=3D3

where the "overq" line marks the discarded event and ref.

David

