Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ED03574D6
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Apr 2021 21:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345052AbhDGTPC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Apr 2021 15:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhDGTPB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Apr 2021 15:15:01 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265EEC06175F
        for <linux-nfs@vger.kernel.org>; Wed,  7 Apr 2021 12:14:52 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 206FD6A45; Wed,  7 Apr 2021 15:14:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 206FD6A45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1617822891;
        bh=Gv9dPIwJx66BKvpyd17YWXFAtBD3wEg3XSsOKYAv1lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UkFQfmt7Qeeh+uKWN61RoFqp812Q5sTmIKMIjQpEHa6K0cwoB96uaEvpvYSVJdW85
         5m+zf5O+n9h59mTuUk1DzH3VjrxufXP24gx9/tUlwWIH/or5MvcCRdLwJcZLFf6FCZ
         lEGsbtuCqNmZY+Z7W8Bt7ayQ04OHeHbX2hYB0l8U=
Date:   Wed, 7 Apr 2021 15:14:51 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/5 v2] nfs-utils: provide audit-logging of NFSv4 access
Message-ID: <20210407191451.GA3663@fieldses.org>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
 <874khui7hr.fsf@notabene.neil.brown.name>
 <20210302032733.GC16303@fieldses.org>
 <87y2ejerwn.fsf@notabene.neil.brown.name>
 <20210319132820.GA31533@fieldses.org>
 <87lfaieuoj.fsf@notabene.neil.brown.name>
 <20210319210922.GD31533@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319210922.GD31533@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Mar 19, 2021 at 05:09:22PM -0400, J. Bruce Fields wrote:
> On Sat, Mar 20, 2021 at 07:48:44AM +1100, NeilBrown wrote:
> > On Fri, Mar 19 2021, J. Bruce Fields wrote:
> > 
> > > On Fri, Mar 19, 2021 at 02:36:24PM +1100, NeilBrown wrote:
> > >> On Mon, Mar 01 2021, J. Bruce Fields wrote:
> > >> 
> > >> > On Tue, Mar 02, 2021 at 02:01:36PM +1100, NeilBrown wrote:
> > >> >> On Mon, Mar 01 2021, J. Bruce Fields wrote:
> > >> >> 
> > >> >> > I've gotten requests for similar functionality, and intended to
> > >> >> > implement it using directory notifications on /proc/fs/nfsd/clients.
> > >> >> 
> > >> >> I've been exploring this a bit.
> > >> >> When I mount a filesystem, 2 clients get created.
> > >> >> With NFSv4.0, the second client is immediately deleted, and the first
> > >> >> client is deleted one grace period after the filesystem is unmounted.
> > >> >> With NFSv4.1 and 4.2, the first client is immediately deleted, and the
> > >> >> second client is deleted immediately after the unmount.
> > >> >
> > >> > Yeah, internally it's creating an "unconfirmed client" on SETCLIENTID
> > >> > (or EXCHANGE_ID) and then a new "confirmed client" on
> > >> > SETCLIENTID_CONFIRM (or CREATE_SESSION).
> > >> >
> > >> > I'm not sure why the ordering's a little different between the 4.0/4.1+
> > >> > cases.
> > >> 
> > >> The multiple clients are not really nfsd's "fault".  The Linux NFS
> > >> client sends multiple EXCHANGE_ID or SET_CLIENT_ID requests, so NFSD
> > >> really does need to create multiple clients.
> > >> 
> > >> For NFSv4.0, when nfsd gets a repeat SET_CLIENT_ID, it keeps the old one
> > >> and discards the new.
> > >> For NFSv4.1, the spec requires that it keep the new one and discard the
> > >> old.
> > >> This explains the different ordering.
> > >
> > > Hm, is this the client's trunking-detection logic?
> > 
> > Yes.
> > 
> > >
> > > In which case, it's not just unconfirmed clients.
> > 
> > For NFSv4.1, only the EXCHANGE_ID is duplicate.  There is only one
> > CREATE_SESSION, and that is where the client is confirmed.  So only one
> > confirmed client.
> > 
> > For NFSv4.0 bother SETCLIENTID and SETCLIENDID_CONFIRM are duplicate.
> > So maybe both clients get confirmed.  I should check that.
> 
> Drifting off topic, but I don't see how this client behavior makes
> sense.  Mount is chatty enough without the unnecessary duplication.
> Looking at the code....

I never sorted this out, by the way.  I think there must be a bug,
though.

--b.
