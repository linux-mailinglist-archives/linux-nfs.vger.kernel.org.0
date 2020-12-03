Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C412CE150
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 23:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgLCWFV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 17:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgLCWFV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 17:05:21 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BD6C061A55
        for <linux-nfs@vger.kernel.org>; Thu,  3 Dec 2020 14:04:22 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id E94FA4EE7; Thu,  3 Dec 2020 17:04:21 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E94FA4EE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1607033061;
        bh=zhrjU+cQI4LWOQGN9jF11X86dngHyCI6HHi46umhDy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IUaNQFYZt9l01Q8/BBn+TbuKxMvXpNBKC3grWlH9BRHHDCwcm/ppHfOYBELxymcM1
         ljcEi7BT30PevJh9N2MBNxX/p0oE8IdkrrKiUyBab9xCNFVp+xobSeUg1ak5pPpOkF
         Ti4AQMe5Y4O2GwupzzAAJ+mj5ndEqQP3kwooilrk=
Date:   Thu, 3 Dec 2020 17:04:21 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "ffilzlnx@mindspring.com" <ffilzlnx@mindspring.com>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: Adventures in NFS re-exporting
Message-ID: <20201203220421.GE27931@fieldses.org>
References: <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com>
 <20201124211522.GC7173@fieldses.org>
 <932244432.93596532.1606324491501.JavaMail.zimbra@dneg.com>
 <1403656117.98163597.1606998035261.JavaMail.zimbra@dneg.com>
 <20201203185109.GB27931@fieldses.org>
 <4903965f2beb742e0eca089b5db8aa3a4cabb7f0.camel@hammerspace.com>
 <20201203211328.GC27931@fieldses.org>
 <9df8556bf825bd0d565f057b115e35c1b507cf46.camel@hammerspace.com>
 <019001d6c9bd$acbeb6b0$063c2410$@mindspring.com>
 <b9e8da547065f6a94bed22771f214fef91449931.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9e8da547065f6a94bed22771f214fef91449931.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 03, 2020 at 09:57:41PM +0000, Trond Myklebust wrote:
> On Thu, 2020-12-03 at 13:45 -0800, Frank Filz wrote:
> > > On Thu, 2020-12-03 at 16:13 -0500, bfields@fieldses.org wrote:
> > > > On Thu, Dec 03, 2020 at 08:27:39PM +0000, Trond Myklebust wrote:
> > > > > On Thu, 2020-12-03 at 13:51 -0500, bfields wrote:
> > > > > > I've been scratching my head over how to handle reboot of a
> > > > > > re-
> > > > > > exporting server.  I think one way to fix it might be just to
> > > > > > allow the re- export server to pass along reclaims to the
> > > > > > original
> > > > > > server as it receives them from its own clients.  It might
> > > > > > require
> > > > > > some protocol tweaks, I'm not sure.  I'll try to get my
> > > > > > thoughts
> > > > > > in order and propose something.
> > > > > > 
> > > > > 
> > > > > It's more complicated than that. If the re-exporting server
> > > > > reboots,
> > > > > but the original server does not, then unless that re-exporting
> > > > > server persisted its lease and a full set of stateids
> > > > > somewhere, it
> > > > > will not be able to atomically reclaim delegation and lock
> > > > > state on
> > > > > the server on behalf of its clients.
> > > > 
> > > > By sending reclaims to the original server, I mean literally
> > > > sending
> > > > new open and lock requests with the RECLAIM bit set, which would
> > > > get
> > > > brand new stateids.
> > > > 
> > > > So, the original server would invalidate the existing client's
> > > > previous clientid and stateids--just as it normally would on
> > > > reboot--but it would optionally remember the underlying locks
> > > > held by
> > > > the client and allow compatible lock reclaims.
> > > > 
> > > > Rough attempt:
> > > > 
> > > > 
> > > > https://wiki.linux-nfs.org/wiki/index.php/Reboot_recovery_for_re-expor
> > > > t_servers
> > > > 
> > > > Think it would fly?
> > > 
> > > So this would be a variant of courtesy locks that can be reclaimed
> > > by the client
> > > using the reboot reclaim variant of OPEN/LOCK outside the grace
> > > period? The
> > > purpose being to allow reclaim without forcing the client to
> > > persist the original
> > > stateid?
> > > 
> > > Hmm... That's doable, but how about the following alternative: Add
> > > a function
> > > that allows the client to request the full list of stateids that
> > > the server holds on
> > > its behalf?
> > > 
> > > I've been wanting such a function for quite a while anyway in order
> > > to allow the
> > > client to detect state leaks (either due to soft timeouts, or due
> > > to reordered
> > > close/open operations).
> > 
> > Oh, that sounds interesting. So basically the re-export server would
> > re-populate it's state from the original server rather than relying
> > on it's clients doing reclaims? Hmm, but how does the re-export
> > server rebuild its stateids? I guess it could make the clients
> > repopulate them with the same "give me a dump of all my state", using
> > the state details to match up with the old state and replacing
> > stateids. Or did you have something different in mind?
> > 
> 
> I was thinking that the re-export server could just use that list of
> stateids to figure out which locks can be reclaimed atomically, and
> which ones have been irredeemably lost. The assumption is that if you
> have a lock stateid or a delegation, then that means the clients can
> reclaim all the locks that were represented by that stateid.

I'm confused about how the re-export server uses that list.  Are you
assuming it persisted its own list across its own crash/reboot?  I guess
that's what I was trying to avoid having to do.

--b.
