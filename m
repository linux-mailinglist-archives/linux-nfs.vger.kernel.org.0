Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B352467AC8
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Dec 2021 17:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381944AbhLCQJq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Dec 2021 11:09:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47143 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244701AbhLCQJo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Dec 2021 11:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638547580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LVMMDKvm2y6h1koO6as/JvdCsM7i928rktB8GPUfizE=;
        b=IfHQh4Fn9oLDR3A1/41Qk+gX9YYcOH8I2VJAOQsGwbZy2hFWq0qkNPsjLMs0vrGD8N7R7Q
        QA4z9Aw/09eR8Qfis1BBz0fezTI9wJiFlKlQgKXOP3NYRNn+BYaw7v2OzL19MKI85QjOe3
        2jR4yHjsRQlrRhzMx7x2hMHaQK7UmE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-mCEA155tMm-jlGdwWPHJrw-1; Fri, 03 Dec 2021 11:06:19 -0500
X-MC-Unique: mCEA155tMm-jlGdwWPHJrw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B1BE84B9A4;
        Fri,  3 Dec 2021 16:06:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56BA719729;
        Fri,  3 Dec 2021 16:06:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CALF+zOkZgtfP7HrX4oP=qx2uKr3FTRHqECRqKGkRBZaz6F-jdg@mail.gmail.com>
References: <CALF+zOkZgtfP7HrX4oP=qx2uKr3FTRHqECRqKGkRBZaz6F-jdg@mail.gmail.com> <20211201085443.GA24725@kili>
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     dhowells@redhat.com, Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [bug report] nfs: Convert to new fscache volume/cookie API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <997840.1638547576.1@warthog.procyon.org.uk>
Date:   Fri, 03 Dec 2021 16:06:16 +0000
Message-ID: <997841.1638547576@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

David Wysochanski <dwysocha@redhat.com> wrote:

> >     29         if (*_len > NFS_MAX_KEY_LEN)
> >     30                 return false;
> >     31         if (x == 0)
> > --> 32                 key[(*_len)++] = ',';
> >     33         else
> >     34                 *_len += sprintf(key + *_len, ",%llx", x);
> >     35         return true;
> >     36 }
> >
> > This function is very badly broken.  As the checker suggests, the >
> > should be >= to prevent an array overflow.  But it's actually off by
> > two because we have to leave space for the NUL terminator so the buffer
> > is full when "*_len == NFS_MAX_KEY_LEN - 1".  That means the check
> > should be:
> >
> >         if (*_len >= NFS_MAX_KEY_LEN - 1)
> >                 return false;

It shouldn't ever overflow the array.  The sprintf really shouldn't insert
more than 18 chars (comma, 16 hex digits and a NUL), but the allocated space
has a 24-char excess to handle that.

Maybe I should use:

	static inline unsigned int how_many_hex_digits(unsigned int x)
	{
		return x ? round_up(ilog2(x) + 1, 4) / 4 : 0;
	}

from fs/cachefiles/key.c to determine how much space I'm actually going to
use.

Actually, I would very much rather not include the comms parameters if I can
avoid it.  They aren't really something that distinguishes volumes on servers
- they're purely a local phenomenon to distinguish local *mounts* made with
different parameters (for which nfs has different superblocks!).

David

