Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D6647C4DF
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 18:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbhLURVK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Dec 2021 12:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhLURVJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Dec 2021 12:21:09 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD87CC061574
        for <linux-nfs@vger.kernel.org>; Tue, 21 Dec 2021 09:21:09 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id B27EE70C2; Tue, 21 Dec 2021 12:21:07 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B27EE70C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1640107267;
        bh=+Ntw/+KLBQhEXNe/jNMPs9OXWPgjaGoIINZiFYkains=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OcfThCsz2kSiM1vLecW7LUUiCmZslvJI66+Rr5UIahE9IbgneBHpatH8IQVuUW1F9
         o8GPzbCwSxaVf9wEBAFPtSOwpk21j8dZ0J2iLgiXEGkjhUZcGlQGaKgLghzDJrP4Zt
         pl/AQYXetg3/mL3dDKu6UJDOSkrFBTQKNhDgrxHE=
Date:   Tue, 21 Dec 2021 12:21:07 -0500
From:   bfields <bfields@fieldses.org>
To:     Daire Byrne <daire@dneg.com>
Cc:     Richard Weinberger <richard@nod.at>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        chris chilvers <chris.chilvers@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david <david@sigma-star.at>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: Re: Improving NFS re-export
Message-ID: <20211221172107.GA10448@fieldses.org>
References: <1576494286.153679.1639083948872.JavaMail.zimbra@nod.at>
 <20211209214139.GA23483@fieldses.org>
 <763412597.153709.1639087404752.JavaMail.zimbra@nod.at>
 <CAPt2mGM5jJNu_O=pjvU4UEYZ7L9pcunGedVmFP1h+J4QoMLPUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPt2mGM5jJNu_O=pjvU4UEYZ7L9pcunGedVmFP1h+J4QoMLPUg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 21, 2021 at 02:30:45PM +0000, Daire Byrne wrote:
> On Thu, 9 Dec 2021 at 22:03, Richard Weinberger <richard@nod.at> wrote:
> >
> > I see. That way we could get rid of file handle wrapping but loose the
> > NFS clinet inode cache on the re-exporting server, I think.
> 
> As an avid user of re-exporting over the WAN, we do like to be able to
> selectively cache as much of the metadata lookups as possible
> (actimeo=3600, vfs_cache_pressure=1).
> 
> I'm not sure if losing the re-export server's client inode cache would
> effect that ability?

A proxy without an inode cache wouldn't be good.

So the inode cache would have to be indexed just on (a hash of) the raw
filehandle.

> And on the subject of the "proxy" server and a server per export; if
> like us, you have 30 servers or mountpoints to re-export but you might
> only actively use 5-10 of those at any one time, so it is more
> resource efficient (CPU, RAM, fscache storage) to use a single
> re-export server for more than one mountpoint re-export.

That's useful to know, thanks.

> But in the proxy case, maybe the same thing could be achieved with a
> containerised knfsd with all the proxy servers running on the same
> server?

Yes, that's what I was thinking.

> I'm not sure if you could have shared storage and have multiple
> fs-cache/cachefilesd in containers though.

Seems like there should be a few ways to do that.

> Either way, I'm interested to see what you come up with. Always happy
> to test new variations on re-exporting.

I haven't managed to come up with a plan for making a proxy-only mode
work, though, so I'm not feeling too optimistic about that particular
idea.

--b.
