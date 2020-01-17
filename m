Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4186F140E22
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 16:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgAQPoi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 10:44:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38481 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729337AbgAQPoh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jan 2020 10:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579275876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3yf4bXBEtV+N0m/AYGXNmo4B989rg8nUKoS5DoL7jEM=;
        b=NXI7TnkEx0uAbZi5BxKGDki51Wac7ZRqnG1ri1H89NAXdffjmdMbqV518jB7WfJ79qTT6X
        lcBFXEEEl9noySIaIzdccBLNGbaK15QBn8/Z1w6jy9dJD6vwWblRuAFTCY8B9OgBYrP6iU
        0f+vqBwWqPVQhAnBpamykWK7++DxMx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-avFv5F18OXS38WgL_Apilw-1; Fri, 17 Jan 2020 10:44:33 -0500
X-MC-Unique: avFv5F18OXS38WgL_Apilw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12CF4DB60;
        Fri, 17 Jan 2020 15:44:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BD6D19C7F;
        Fri, 17 Jan 2020 15:44:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <b31b09abeea4982e038b0e66e45889bb2c9df750.camel@hammerspace.com>
References: <b31b09abeea4982e038b0e66e45889bb2c9df750.camel@hammerspace.com> <20200117144055.GB3215@pi3> <CAJKOXPeCVwZfBsCVbc9RQUGi0UfWQw0uFamPiQasiO8fSthFsQ@mail.gmail.com> <433863.1579270803@warthog.procyon.org.uk> <461540.1579273958@warthog.procyon.org.uk>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     dhowells@redhat.com, "krzk@kernel.org" <krzk@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "smayhew@redhat.com" <smayhew@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [BISECT BUG] NFS v4 root not working after 6d972518b821 ("NFS: Add fs_context support.")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <464190.1579275869.1@warthog.procyon.org.uk>
Date:   Fri, 17 Jan 2020 15:44:29 +0000
Message-ID: <464191.1579275869@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond Myklebust <trondmy@hammerspace.com> wrote:

> It looks like someone changed the return value from the old EINVAL to
> something else? The "Numerical result out of range" message above
> suggests it has been changed to EOVERFLOW, which probably is not
> supported by 'mount'.

Ah, I see what's happened.  nfs_get_option_ui_bound() returns -ERANGE and the
new code lets this through whereas the old code converted it to -EINVAL.

David

