Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A39341E29
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Mar 2021 14:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCSN3F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Mar 2021 09:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhCSN2d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Mar 2021 09:28:33 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D32C06174A
        for <linux-nfs@vger.kernel.org>; Fri, 19 Mar 2021 06:28:21 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2FE7423D8; Fri, 19 Mar 2021 09:28:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2FE7423D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1616160500;
        bh=2N88ujI77SIKWOZ3syRrofcGqQUfzRdk+IqXJmkI3AA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uvufseJRQc1Jr8R0BQS7ly+ayzMUW+prHpoDtXGotyUo+9J2JxwBpQ3PDwvCi2kna
         12wjTNh4wfEtngxScwuKI6gTEEOf0VBzRnVJF7ICQHr/oshKTYfWxZNXx+IohLtzJc
         QRvFkyBolGVjLNyJ6YSysETHM4Jl12klD8Cnj7qg=
Date:   Fri, 19 Mar 2021 09:28:20 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/5 v2] nfs-utils: provide audit-logging of NFSv4 access
Message-ID: <20210319132820.GA31533@fieldses.org>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
 <874khui7hr.fsf@notabene.neil.brown.name>
 <20210302032733.GC16303@fieldses.org>
 <87y2ejerwn.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2ejerwn.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Mar 19, 2021 at 02:36:24PM +1100, NeilBrown wrote:
> On Mon, Mar 01 2021, J. Bruce Fields wrote:
> 
> > On Tue, Mar 02, 2021 at 02:01:36PM +1100, NeilBrown wrote:
> >> On Mon, Mar 01 2021, J. Bruce Fields wrote:
> >> 
> >> > I've gotten requests for similar functionality, and intended to
> >> > implement it using directory notifications on /proc/fs/nfsd/clients.
> >> 
> >> I've been exploring this a bit.
> >> When I mount a filesystem, 2 clients get created.
> >> With NFSv4.0, the second client is immediately deleted, and the first
> >> client is deleted one grace period after the filesystem is unmounted.
> >> With NFSv4.1 and 4.2, the first client is immediately deleted, and the
> >> second client is deleted immediately after the unmount.
> >
> > Yeah, internally it's creating an "unconfirmed client" on SETCLIENTID
> > (or EXCHANGE_ID) and then a new "confirmed client" on
> > SETCLIENTID_CONFIRM (or CREATE_SESSION).
> >
> > I'm not sure why the ordering's a little different between the 4.0/4.1+
> > cases.
> 
> The multiple clients are not really nfsd's "fault".  The Linux NFS
> client sends multiple EXCHANGE_ID or SET_CLIENT_ID requests, so NFSD
> really does need to create multiple clients.
> 
> For NFSv4.0, when nfsd gets a repeat SET_CLIENT_ID, it keeps the old one
> and discards the new.
> For NFSv4.1, the spec requires that it keep the new one and discard the
> old.
> This explains the different ordering.

Hm, is this the client's trunking-detection logic?

In which case, it's not just unconfirmed clients.

> So the clean up the logging, mountd needs to be able to see the
> confirmation status.

That sounds fine.

(The other possibility might be to just not expose clients till they're
confirmed.  I don't know if unconfirmed clients are really that
interesting.  But I guess I'd rather err on the side of exposing more
information here.)

> Following this reply will be a patch to nfsd to provide this status, and
> a patch to mountd/exportd to use this status.
