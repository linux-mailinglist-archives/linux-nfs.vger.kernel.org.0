Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A9D38CDA1
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 20:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhEUSlH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 May 2021 14:41:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhEUSlH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 May 2021 14:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621622383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2bresmZwcb0qBtGOLXai3rrPS7BII9VRs6jTka+1aWo=;
        b=NSkPI4BQYzudCcqdLQcQ7i4B45G7GDHMIPYmSvTcZigAwXB6puSzejfMon1mYRR2SGYcY/
        KiyhxLK0tgGkLObYtIQp6bzxwR2w7CBs4PTaJuP0mePemajvUE8Rhw9DzL3iKrVElCXiyc
        IBurzHn3VDaw+x3ESCetst/X5biFHcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-LC_Eh2EINVCMyU8IdC-4Fg-1; Fri, 21 May 2021 14:39:41 -0400
X-MC-Unique: LC_Eh2EINVCMyU8IdC-4Fg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB867188E3D3;
        Fri, 21 May 2021 18:39:40 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-114-99.phx2.redhat.com [10.3.114.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A121D5C648;
        Fri, 21 May 2021 18:39:40 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 5B6D4120966; Fri, 21 May 2021 14:39:39 -0400 (EDT)
Date:   Fri, 21 May 2021 14:39:39 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-nfs@vger.kernel.org, Yong Sun <yosun@suse.com>
Subject: Re: pynfs: COUR2, EID50 test failures
Message-ID: <YKf+a7e4lv2BwBBQ@pick.fieldses.org>
References: <YKdXZa6Izs7kqgfE@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKdXZa6Izs7kqgfE@pevik>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 21, 2021 at 08:47:01AM +0200, Petr Vorel wrote:
> Hi Bruce,
> 
> what's wrong with pynfs COUR2, EID50 tests?
> They're failing on various kernels.
> I got these failures on 5.11.12 (openSUSE package), 5.13.0-rc2 (mainline on
> openSUSE), 4.9.0 (Debian package):
> 
> COUR2    st_courtesy.testLockSleepLock                            : FAILURE
>            OP_OPEN should return NFS4_OK, instead got
>            NFS4ERR_GRACE

Are you running it immediately after starting the server?  If so, that's
expected.  Personally my test scripts mount the server and create a file
there before running pynfs tests.  The create won't return until the
grace period's done.

Might be worth documenting in the README, or teaching pynfs to wait
before running tests.

> EID50    st_exchange_id.testSSV                                   : FAILURE
>            nfs4lib.NFS4Error: OP_EXCHANGE_ID should return
>            NFS4_OK, instead got NFS4ERR_ENCR_ALG_UNSUPP
> 
> Nothing in dmesg (tested with "rpcdebug -m nfsd -s lockd").
> Or is it just my wrong setup?

SSV support is optional.  We should probably drop the "all" tag from
that test.

--b.

