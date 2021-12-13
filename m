Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375A14737B3
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Dec 2021 23:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243664AbhLMWjk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Dec 2021 17:39:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51396 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241247AbhLMWjj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Dec 2021 17:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639435179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HWSMXK7LEjzSsPpRTrrPvFP8lmS43rRYj29GaO0/pDg=;
        b=fdEcPgPVQEqRXWpIEhva2Xt+M1gxRtlIDEfb3gOW5Zyv5iwS/wjJyKp0/jCRs1CsXF/2xF
        3MW6oE7VkKHbVs5JF0zNKK8rl14rR6HsZgg6BaENK/cteo92qYyXb3er1vqNYaKaiEHcmu
        tTvZlHlRm+WkNltgh0/HCJwIXK7YEVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-7LVp6QaYM6ynFHZoZvwXJg-1; Mon, 13 Dec 2021 17:39:36 -0500
X-MC-Unique: 7LVp6QaYM6ynFHZoZvwXJg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 586041853028
        for <linux-nfs@vger.kernel.org>; Mon, 13 Dec 2021 22:39:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D136779D6;
        Mon, 13 Dec 2021 22:39:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <629803.1639425799@warthog.procyon.org.uk>
References: <629803.1639425799@warthog.procyon.org.uk> <599331.1639410068@warthog.procyon.org.uk> <CALF+zOnmJ0=j8pEMikpxYgLrS10gVZiXfCjBhDz9Je0Qip7wnw@mail.gmail.com> <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk> <CALF+zOnA2U6LjDTE8m2REDTMmFVnWkcBkn0ZJQRGULPUjeQW4Q@mail.gmail.com>
Cc:     dhowells@redhat.com, David Wysochanski <dwysocha@redhat.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] fscache: Need to go round again after processing LRU_DISCARDING state
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <686219.1639435166.1@warthog.procyon.org.uk>
Date:   Mon, 13 Dec 2021 22:39:26 +0000
Message-ID: <686220.1639435166@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> I forgot to commit part of the patch.  Attached is the patch in full.

Sigh.  I replied to the wrong message.

David

