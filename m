Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92D36140FC2
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 18:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgAQRSx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 12:18:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44408 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726559AbgAQRSx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jan 2020 12:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579281533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ocOwdyxaK7b6+T8u5DHVlcyif0Db1NtXbwf5yNIO83E=;
        b=ferDStM+QCF3ul8ishMh2GYWEiw2dOmL/+iz01ywPpG9sK5GUcPLfWh6AFdLl/eb4RQ3Lp
        aDInk7DxXjZ2xe+TL3ZBIOcFVFftNmPTopJj4H2a7XJeD6YbDeOizEl11SJMR9Bcsq0BbM
        mCtoJwA7HcUPoipH5y0nHsBIiHtHT/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-Ub-rIdTCNjmZaEzIiV3ObA-1; Fri, 17 Jan 2020 12:18:50 -0500
X-MC-Unique: Ub-rIdTCNjmZaEzIiV3ObA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FE35800D54;
        Fri, 17 Jan 2020 17:18:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 522BB60BE1;
        Fri, 17 Jan 2020 17:18:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200117165133.GA5762@pi3>
References: <20200117165133.GA5762@pi3> <464519.1579276102@warthog.procyon.org.uk> <20200117144055.GB3215@pi3> <CAJKOXPeCVwZfBsCVbc9RQUGi0UfWQw0uFamPiQasiO8fSthFsQ@mail.gmail.com> <433863.1579270803@warthog.procyon.org.uk> <465149.1579276509@warthog.procyon.org.uk>
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     dhowells@redhat.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Scott Mayhew <smayhew@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] nfs: Return EINVAL rather than ERANGE for mount parse errors
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <473344.1579281525.1@warthog.procyon.org.uk>
Date:   Fri, 17 Jan 2020 17:18:45 +0000
Message-ID: <473345.1579281525@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna,

Can you pick this patch up and add it to your branch?

Thanks,
David

