Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49702CE131
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 22:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgLCVym (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 16:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbgLCVym (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 16:54:42 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EE6C061A4F
        for <linux-nfs@vger.kernel.org>; Thu,  3 Dec 2020 13:54:02 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id D9DED6F73; Thu,  3 Dec 2020 16:54:00 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org D9DED6F73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1607032440;
        bh=kGJzjoOZDnrdEdFLLONWXmydx7zt4QZhNuZ/VHECyws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eABE0L1Mc1VOVOPDWLoneKozr7QeuxD849Kd/c6ohR7UDuc1Nz2kABoZs6KyYO9Eq
         2SUz1lZ/lB2Mdu+b8WG1gMrlKyIJCG6Asl6JpaCR1qSoKiQO093FkhgFAeO6GwotI0
         Qr6gBBAoPPNZi7WT8IsLI5fE9+1nTijP4UM5uQ7I=
Date:   Thu, 3 Dec 2020 16:54:00 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: Adventures in NFS re-exporting
Message-ID: <20201203215400.GD27931@fieldses.org>
References: <20201109160256.GB11144@fieldses.org>
 <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com>
 <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com>
 <20201124211522.GC7173@fieldses.org>
 <932244432.93596532.1606324491501.JavaMail.zimbra@dneg.com>
 <1403656117.98163597.1606998035261.JavaMail.zimbra@dneg.com>
 <20201203185109.GB27931@fieldses.org>
 <4903965f2beb742e0eca089b5db8aa3a4cabb7f0.camel@hammerspace.com>
 <20201203211328.GC27931@fieldses.org>
 <9df8556bf825bd0d565f057b115e35c1b507cf46.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9df8556bf825bd0d565f057b115e35c1b507cf46.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 03, 2020 at 09:34:26PM +0000, Trond Myklebust wrote:
> On Thu, 2020-12-03 at 16:13 -0500, bfields@fieldses.org wrote:
> > On Thu, Dec 03, 2020 at 08:27:39PM +0000, Trond Myklebust wrote:
> > > On Thu, 2020-12-03 at 13:51 -0500, bfields wrote:
> > > > I've been scratching my head over how to handle reboot of a re-
> > > > exporting
> > > > server.  I think one way to fix it might be just to allow the re-
> > > > export
> > > > server to pass along reclaims to the original server as it
> > > > receives
> > > > them
> > > > from its own clients.  It might require some protocol tweaks, I'm
> > > > not
> > > > sure.  I'll try to get my thoughts in order and propose
> > > > something.
> > > > 
> > > 
> > > It's more complicated than that. If the re-exporting server
> > > reboots,
> > > but the original server does not, then unless that re-exporting
> > > server
> > > persisted its lease and a full set of stateids somewhere, it will
> > > not
> > > be able to atomically reclaim delegation and lock state on the
> > > server
> > > on behalf of its clients.
> > 
> > By sending reclaims to the original server, I mean literally sending
> > new
> > open and lock requests with the RECLAIM bit set, which would get
> > brand
> > new stateids.
> > 
> > So, the original server would invalidate the existing client's
> > previous
> > clientid and stateids--just as it normally would on reboot--but it
> > would
> > optionally remember the underlying locks held by the client and allow
> > compatible lock reclaims.
> > 
> > Rough attempt:
> > 
> >         https://wiki.linux-nfs.org/wiki/index.php/Reboot_recovery_for_re-export_servers
> > 
> > Think it would fly?
> 
> So this would be a variant of courtesy locks that can be reclaimed by
> the client using the reboot reclaim variant of OPEN/LOCK outside the
> grace period? The purpose being to allow reclaim without forcing the
> client to persist the original stateid?

Right.

> Hmm... That's doable,

Keep mulling it over and let me know if you see something that doesn't
work.

> but how about the following alternative: Add a
> function that allows the client to request the full list of stateids
> that the server holds on its behalf?

So, on the re-export server:

The client comes back up knowing nothing, so it requests that list of
stateids.  A reclaim comes in from an end client.  The client looks
through its list for a stateid that matches that reclaim somehow.  So, I
guess the list of stateids also has to include filehandles and access
bits and lock ranges and such, so the client can pick an appropriate
stateid to use?

> I've been wanting such a function for quite a while anyway in order to
> allow the client to detect state leaks (either due to soft timeouts, or
> due to reordered close/open operations).

Yipes, I hadn't realized that was possible.

--b.
