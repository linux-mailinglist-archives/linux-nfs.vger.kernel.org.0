Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086A1422798
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Oct 2021 15:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbhJENRh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 09:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234978AbhJENRh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Oct 2021 09:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633439746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aVKc5yd2u429wV/BLHqqmA9iOdQQcgUkmy1ws4LmTWQ=;
        b=Bt7g0KVo+ZRHCMS0m70fUrK4dWm4pmJY7pnyG82wl9wpg6wkc534H4YgM+GkSnrGNdF5Fo
        QSKyW8XqUUHqDoHCEgTDOKG8MFQBA0Ih4dK899gZiqnf7O+Pb1vV/9rzS6iZx90oFXBSVd
        n8k4Puukv13kN1b/ba3AJp226bkQ+WQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-dKSukSxeNrmdtMHa7dOL2g-1; Tue, 05 Oct 2021 09:15:45 -0400
X-MC-Unique: dKSukSxeNrmdtMHa7dOL2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 196B6100C624;
        Tue,  5 Oct 2021 13:15:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 758A853E08;
        Tue,  5 Oct 2021 13:15:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <23033528036059af4633f60b8325e48eab95ac36.camel@hammerspace.com>
References: <23033528036059af4633f60b8325e48eab95ac36.camel@hammerspace.com> <97eb17f51c8fd9a89f10d9dd0bf35f1075f6b236.camel@hammerspace.com> <163189104510.2509237.10805032055807259087.stgit@warthog.procyon.org.uk> <163189108292.2509237.12615909591150927232.stgit@warthog.procyon.org.uk> <CALF+zO=165sRYRaxPpDS7DaQCpTe-YOa4FamSoMy5FV2uuG5Yg@mail.gmail.com> <81120.1633099916@warthog.procyon.org.uk>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     dhowells@redhat.com,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>
Subject: Re: Can the GFP flags to releasepage() be trusted? -- was Re: [PATCH v2 3/8] nfs: Move to using the alternate fallback fscache I/O API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1080873.1633439740.1@warthog.procyon.org.uk>
Date:   Tue, 05 Oct 2021 14:15:40 +0100
Message-ID: <1080874.1633439740@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond Myklebust <trondmy@hammerspace.com> wrote:

> To elaborate a bit: we used to have code here that would check whether
> the page had been cleaned but was unstable, and if an argument of
> GFP_KERNEL or above was set, we'd try to call COMMIT to ensure the page
> was synched to disk on the server (and we'd wait for that call to
> complete).
> 
> That code would end up deadlocking in all sorts of horrible ways, so we
> ended up having to pull it.

I don't think that a deadlock should be possible with this.  PG_fscache is now
only being used to indicate that a DIO write to the cache is in progress on
the page.  It will complete and remove the mark at some point.

David

