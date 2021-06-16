Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3B13AA555
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 22:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbhFPUcr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 16:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbhFPUcq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 16:32:46 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207E4C061574
        for <linux-nfs@vger.kernel.org>; Wed, 16 Jun 2021 13:30:40 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6C28F5047; Wed, 16 Jun 2021 16:30:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6C28F5047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1623875439;
        bh=hUuk0t6G4dAjNlxn6vju3TxT1t8DFFIQbQngHtvMmHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tCpBAQnoQDplkd07hf/6r8kGOzRdXTlI3EUopc6EEj4lzp9dIJOalPa7W4Icva7K3
         Hy6jJ54pB7gEddHUMkdT0mhzSqpmRdcnRV3GGWgzcW7aKoyt56+1IBl0qUr2xgq+wB
         1WIWEySTRXz/oalg1NilzWlAf+Es9NXEI7KgFrOE=
Date:   Wed, 16 Jun 2021 16:30:39 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
Message-ID: <20210616203039.GA6049@fieldses.org>
References: <20210603181438.109851-1-dai.ngo@oracle.com>
 <20210616160239.GC4943@fieldses.org>
 <8A44DFA1-683C-4D5F-BE71-0B94865AFA28@oracle.com>
 <5bd3e11c-8749-b9ec-b1ae-5398fff5df4e@oracle.com>
 <50752B0A-A56A-4A80-81AE-32E20754E31F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50752B0A-A56A-4A80-81AE-32E20754E31F@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 16, 2021 at 07:29:37PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jun 16, 2021, at 3:25 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> > 
> > On 6/16/21 9:32 AM, Chuck Lever III wrote:
> >>> On Jun 16, 2021, at 12:02 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> >>> 
> >>> On Thu, Jun 03, 2021 at 02:14:38PM -0400, Dai Ngo wrote:
> >>>> . instead of destroy the client anf all its state on conflict, only destroy
> >>>> the state that is conflicted with the current request.
> >>> The other todos I think have to be done before we merge, but this one I
> >>> think can wait.
> >> I agree on both points: this one can wait, but the others
> >> should be done before merge.
> > 
> > yes, will do.
> > 
> >> 
> >> 
> >>>> . destroy the COURTESY_CLIENT either after a fixed period of time to release
> >>>> resources or as reacting to memory pressure.
> >>> I think we need something here, but it can be pretty simple.
> >> We should work out a policy now.
> >> 
> >> A lower bound is good to have. Keep courtesy clients at least
> >> this long. Average network partition length times two as a shot
> >> in the dark. Or it could be N times the lease expiry time.
> >> 
> >> An upper bound is harder to guess at. Obviously these things
> >> will go away when the server reboots. The laundromat could
> >> handle this sooner. However using a shrinker might be nicer and
> >> more Linux-y, keeping the clients as long as practical, without
> >> the need for adding another administrative setting.
> > 
> > Can we start out with a simple 12 or 24 hours to accommodate long
> > network outages for this phase?
> 
> Sure. Let's go with 24 hours.
> 
> Bill suggested adding a "clear_locks" like mechanism that could be
> used to throw out all courteous clients at once. Maybe another
> phase 2 project!

For what it's worth, you can forcibly expire a client by writing
"expire" to /proc/fs/nfsd/client/xxx/ctl.  So it shouldn't be hard to
script this, if we add some kind of "courtesy" flag to
client_info_show() and/or a number of seconds since the most recent
renew.

Maybe adding a command like "expire_if_courtesy" would also simplify
that and avoid a race where the renew comes in simultaneously with the
expire command.

Or we could just add a single call to clear all courtesy clients.  But
the per-client approach would allow more flexibility if you wanted (e.g.
to throw out only clients over a certain age).

--b.
