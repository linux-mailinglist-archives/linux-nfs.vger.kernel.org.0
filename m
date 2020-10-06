Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9315E2850C0
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Oct 2020 19:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgJFR0I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Oct 2020 13:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgJFR0I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Oct 2020 13:26:08 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAE3C061755
        for <linux-nfs@vger.kernel.org>; Tue,  6 Oct 2020 10:26:08 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9603D367; Tue,  6 Oct 2020 13:26:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9603D367
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602005167;
        bh=M4fachXUpRc9S+ieKkFnargtA7yodP3XYujMtpIY3lY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X//ZOCSzaPb3n9LeJHJHX2acFHh4C+eFt433QxBcUyK0Jhiuj4WQgJSv/btxhFGO9
         0uhkLjKePhWdryZFDp8f21MkTbKifcAuiW0so1+mPl91u4+oMROR2qrQdY5HHBhnqK
         bNU074lCMYKEjFNZh6Vt1kKDpqi5pEczO2Vr+VTM=
Date:   Tue, 6 Oct 2020 13:26:07 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Matt Benjamin <mbenjami@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: client caching and locks
Message-ID: <20201006172607.GA32640@fieldses.org>
References: <20200608211945.GB30639@fieldses.org>
 <OSBPR01MB2949040AA49BC9B5F104DA1FEF9B0@OSBPR01MB2949.jpnprd01.prod.outlook.com>
 <22b841f7a8979f19009c96f31a7be88dd177a47a.camel@hammerspace.com>
 <20200618200905.GA10313@fieldses.org>
 <20200622135222.GA6075@fieldses.org>
 <20201001214749.GK1496@fieldses.org>
 <CAKOnarndL1-u5jGG2VAENz2bEc9wsERH6rGTbZeYZy+WyAUk-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOnarndL1-u5jGG2VAENz2bEc9wsERH6rGTbZeYZy+WyAUk-w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 01, 2020 at 06:26:25PM -0400, Matt Benjamin wrote:
> I'm not sure.  My understanding has been that, NFSv4 does not mandate
> a mechanism to update clients of changes outside of any locked range.
> In AFS (and I think DCE DFS?) this role is played by DataVersion.  If
> I recall correctly, David Noveck provided an errata that addresses
> this, that servers could use in a similar manner to DV, but I don't
> recall the details.

Maybe you're thinking of the change_attr_type that's new to 4.2?  I
think that was Trond's proposal originally.  In the
CHANGE_TYPE_IS_VERSION_COUNTER case it would in theory allow you to tell
whether a file that you'd written to was also written to by someone else
by counting WRITE operations.

But we still have to ensure consistency whether the server implements
that.  (I doubt any server currently does.)

--b.

> 
> Matt
> 
> On Thu, Oct 1, 2020 at 5:48 PM bfields@fieldses.org
> <bfields@fieldses.org> wrote:
> >
> > On Mon, Jun 22, 2020 at 09:52:22AM -0400, bfields@fieldses.org wrote:
> > > On Thu, Jun 18, 2020 at 04:09:05PM -0400, bfields@fieldses.org wrote:
> > > > I probably don't understand the algorithm (in particular, how it
> > > > revalidates caches after a write).
> > > >
> > > > How does it avoid a race like this?:
> > > >
> > > > Start with a file whose data is all 0's and change attribute x:
> > > >
> > > >         client 0                        client 1
> > > >         --------                        --------
> > > >         take write lock on byte 0
> > > >                                         take write lock on byte 1
> > > >         write 1 to offset 0
> > > >           change attribute now x+1
> > > >                                         write 1 to offset 1
> > > >                                           change attribute now x+2
> > > >         getattr returns x+2
> > > >                                         getattr returns x+2
> > > >         unlock
> > > >                                         unlock
> > > >
> > > >         take readlock on byte 1
> > > >
> > > > At this point a getattr will return change attribute x+2, the same as
> > > > was returned after client 0's write.  Does that mean client 0 assumes
> > > > the file data is unchanged since its last write?
> > >
> > > Basically: write-locking less than the whole range doesn't prevent
> > > concurrent writes outside that range.  And the change attribute gives us
> > > no way to identify whether concurrent writes have happened.  (At least,
> > > not without NFS4_CHANGE_TYPE_IS_VERSION_COUNTER.)
> > >
> > > So as far as I can tell, a client implementation has no reliable way to
> > > revalidate its cache outside the write-locked area--instead it needs to
> > > just throw out that part of the cache.
> >
> > Does my description of that race make sense?
> >
> > --b.
> >
> 
> 
> -- 
> 
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
> 
> http://www.redhat.com/en/technologies/storage
> 
> tel.  734-821-5101
> fax.  734-769-8938
> cel.  734-216-5309
