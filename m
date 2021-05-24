Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6D138E233
	for <lists+linux-nfs@lfdr.de>; Mon, 24 May 2021 10:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhEXIVR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 May 2021 04:21:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:38532 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232279AbhEXIVQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 24 May 2021 04:21:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621844388;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gBjxf+3ZRrtJXQdnJVDvhPpsQbh5YWRQfsbjsz0dV+I=;
        b=x4w8wq+RfdRY6+AuRi1qGmAqVvVVPt+5lC0FvL1bWYBglP3YTn/iMJ1S9UOH+ANI8qsVm8
        xZWvofAoNZ8/l+JFXR5+gynKWGqEuAcyrXO0ZXZlu/kIQEQIhtd5FpQcQ1NhcudEmYOqfx
        6id2XAN+ndxUI5eQS0w+hNBVWaxtYQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621844388;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gBjxf+3ZRrtJXQdnJVDvhPpsQbh5YWRQfsbjsz0dV+I=;
        b=v0dnFIjayGQfvDZ6e/rkXMqxGBIiIsf21dUdWIxesy4NCQ51rIP6/Mrshk7UVM2aPI30WU
        RTgZuziwQI93bPAg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6612AABC1;
        Mon, 24 May 2021 08:19:48 +0000 (UTC)
Date:   Mon, 24 May 2021 10:19:46 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org,
        Yong Sun <yosun@suse.com>
Subject: Re: pynfs: COUR2, EID50 test failures
Message-ID: <YKthorSz5jv70JQe@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <YKdXZa6Izs7kqgfE@pevik>
 <YKf+a7e4lv2BwBBQ@pick.fieldses.org>
 <YKqpnXjGP+Ub0lB0@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKqpnXjGP+Ub0lB0@pevik>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

> > On Fri, May 21, 2021 at 08:47:01AM +0200, Petr Vorel wrote:
> > > Hi Bruce,

> > > what's wrong with pynfs COUR2, EID50 tests?
> > > They're failing on various kernels.
> > > I got these failures on 5.11.12 (openSUSE package), 5.13.0-rc2 (mainline on
> > > openSUSE), 4.9.0 (Debian package):

> > > COUR2    st_courtesy.testLockSleepLock                            : FAILURE
> > >            OP_OPEN should return NFS4_OK, instead got
> > >            NFS4ERR_GRACE

> > Are you running it immediately after starting the server?  If so, that's
> > expected.  Personally my test scripts mount the server and create a file
> > there before running pynfs tests.  The create won't return until the
> > grace period's done.
> Thanks for info, I'll test that!

Actually, if I create file in NFS root directory not only that COUR2 still fail,
but 2 other tests fail (CSID4, FAILURE). Maybe really doing proper setup in the
test would be the best.

Kind regards,
Petr

> > Might be worth documenting in the README, or teaching pynfs to wait
> > before running tests.
> Or maybe test should create a test file before? That might be faster than waiting.
> Because there is some wait for 2 min as part of testing.

> > > EID50    st_exchange_id.testSSV                                   : FAILURE
> > >            nfs4lib.NFS4Error: OP_EXCHANGE_ID should return
> > >            NFS4_OK, instead got NFS4ERR_ENCR_ALG_UNSUPP

> > > Nothing in dmesg (tested with "rpcdebug -m nfsd -s lockd").
> > > Or is it just my wrong setup?

> > SSV support is optional.  We should probably drop the "all" tag from
> > that test.
> Again, thanks for info. It'd be great if you implement that.

> Kind regards,
> Petr

> > --b.

