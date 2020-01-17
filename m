Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 377371412A0
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 22:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgAQVMO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 16:12:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47916 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726896AbgAQVMO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jan 2020 16:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579295533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UmqiytuiIU9vOhwhZx9H5B3yXKuSj3/yBA5qYjhpgwg=;
        b=UArnIXPPeuCO5rNyhZm0GJIWs+LufBOtvZEenc3mLyvZYd8lsULDrB5YKNB5RCdR6GKc7F
        gt4wF98nLN+X8e1hmozhTo3vkWKMu6+2U1SsX7Hd4qk3LhOJlON5IAaDO+ymhDj2i5H7jY
        hQlomyfPJ/cmHYLOLB9oTlyLUSfAJtw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-qJl8acmNOSOxWKT0PgP05A-1; Fri, 17 Jan 2020 16:12:10 -0500
X-MC-Unique: qJl8acmNOSOxWKT0PgP05A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93764DB22;
        Fri, 17 Jan 2020 21:12:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDF0D845B5;
        Fri, 17 Jan 2020 21:12:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <5e16e2118d1c7de73627b521a2f36df76ab0e698.camel@netapp.com>
References: <5e16e2118d1c7de73627b521a2f36df76ab0e698.camel@netapp.com> <20200117165133.GA5762@pi3> <464519.1579276102@warthog.procyon.org.uk> <20200117144055.GB3215@pi3> <CAJKOXPeCVwZfBsCVbc9RQUGi0UfWQw0uFamPiQasiO8fSthFsQ@mail.gmail.com> <433863.1579270803@warthog.procyon.org.uk> <465149.1579276509@warthog.procyon.org.uk> <473345.1579281525@warthog.procyon.org.uk>
To:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>
Cc:     dhowells@redhat.com, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "smayhew@redhat.com" <smayhew@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] nfs: Return EINVAL rather than ERANGE for mount parse errors
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <493070.1579295526.1@warthog.procyon.org.uk>
Date:   Fri, 17 Jan 2020 21:12:06 +0000
Message-ID: <493071.1579295526@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Schumaker, Anna <Anna.Schumaker@netapp.com> wrote:

> Sure! I have it applied on my laptop now, and I'll push it out before I sign
> off for the weekend.

Ta!

David

