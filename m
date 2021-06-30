Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2A43B862F
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 17:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbhF3PZ3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 11:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbhF3PZ2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Jun 2021 11:25:28 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92C3C061756
        for <linux-nfs@vger.kernel.org>; Wed, 30 Jun 2021 08:22:58 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 063FD64B9; Wed, 30 Jun 2021 11:22:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 063FD64B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1625066578;
        bh=KIYGbeonWNUahb7Q+rvjhZsEuaqRZdL0OsklNsuTOSg=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=T1cs1wZpXas0H/vqanW7ShBz8TkSKflBf0mjAXcyTRVBUIHyE8IROA+13iagF3XLJ
         rGt3IU5MwFVecaPJ/3DCTnbczmT+N6w2IvON3RX1bcYqS4L9ow9MDOnzvipW/oHs3t
         mNIhkpW4I7qf5rvOdLDFtT6Cu7TOSZYWFa0CGbMg=
Date:   Wed, 30 Jun 2021 11:22:58 -0400
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: client's caching of server-side capabilities
Message-ID: <20210630152258.GC20229@fieldses.org>
References: <CAN-5tyEuB5C9u+xZ5L47fSQ9cwZnsbhJuBs+gybU2A-jzAkfog@mail.gmail.com>
 <81154dc28d528402bf5e090a81e6892c7abc431c.camel@hammerspace.com>
 <B0CA736F-E3E8-4446-9A6E-3ADCDD7F8736@oracle.com>
 <CAN-5tyE5Y3+ZPrfAR8=UVdNnWxyzO6a_NTeTsMFH_TyyMqK-bQ@mail.gmail.com>
 <607F15BF-89B4-4123-8223-A3893229D219@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <607F15BF-89B4-4123-8223-A3893229D219@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 29, 2021 at 01:51:43PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jun 29, 2021, at 9:48 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> > 
> > On Tue, Jun 29, 2021 at 8:58 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >> 
> >> 
> >> 
> >>> On Jun 28, 2021, at 6:06 PM, Trond Myklebust <trondmy@hammerspace.com> wrote:
> >>> 
> >>> On Mon, 2021-06-28 at 16:23 -0400, Olga Kornievskaia wrote:
> >>>> Hi folks,
> >>>> 
> >>>> I have a general question of why the client doesn't throw away the
> >>>> cached server's capabilities on server reboot. Say a client mounted a
> >>>> server when the server didn't support security_labels, then the
> >>>> server
> >>>> was rebooted and support was enabled. Client re-establishes its
> >>>> clientid/session, recovers state, but assumes all the old
> >>>> capabilities
> >>>> apply. A remount is required to clear old/find new capabilities. The
> >>>> opposite is true that a capability could be removed (but I'm assuming
> >>>> that's a less practical example).
> >>>> 
> >>>> I'm curious what are the problems of clearing server capabilities and
> >>>> rediscovering them on reboot? Is it because a local filesystem could
> >>>> never have its attributes changed and thus a network file system
> >>>> can't
> >>>> either?
> >>>> 
> >>>> Thank you.
> >>> 
> >>> In my opinion, the client should aim for the absolute minimum overhead
> >>> on a server reboot. The goal should be to recover state and get I/O
> >>> started again as quickly as possible.
> >> 
> >> I 100% agree with the above. However...
> >> 
> >> 
> >>> Detection of new features, etc
> >>> can wait until the client needs to restart.
> >> 
> >> A server reboot can be part of a failover to a different server. I
> >> think capability discovery needs to happen as part of server reboot
> >> recovery, it can't be optimized away.
> > 
> > Can you clarify what you mean by a "failover to a different server"?
> 
> IP-based failover means that a server can crash, and its partner can
> detect that and take over the IP address and exports of the failed
> server. The replacement server doesn't have to have exactly the same
> set of capabilities.

So it could also lose capabilities?

I'm a little nervous about server features being changed out from under
the client while the client has the server mounted.

But, I don't know, looking quickly through the list of NFS_CAP_*
definitions in nfs_fs_sb.h, I'm not coming up with a case where we
couldn't handle it, maybe it's OK.

--b.
