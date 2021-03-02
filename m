Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3174532A93E
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Mar 2021 19:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352144AbhCBSRN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Mar 2021 13:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573909AbhCBD2P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Mar 2021 22:28:15 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CF5C061756
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 19:27:34 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6DBEF2501; Mon,  1 Mar 2021 22:27:33 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6DBEF2501
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614655653;
        bh=9HBFXOOrXbANcO931Pqx56oVgID/LiNT2qjHGnB9S1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IhYwmnv9pp0ZpT2wt7IxKX0jvR0znxHcNgJ34nx/wsmE05zajN7NGIN9ZqSWOwgdP
         imx3JeOu6ob0e5WzbOgP+HcCdJQSntt6kdVJWaIgwuhv/4KsRuYWRdWqjNrYANekAd
         Z7P3WHYbJzaGDx4ebnX4lUIftmtiYg7IUL66WwL0=
Date:   Mon, 1 Mar 2021 22:27:33 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/5 v2] nfs-utils: provide audit-logging of NFSv4 access
Message-ID: <20210302032733.GC16303@fieldses.org>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
 <874khui7hr.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874khui7hr.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 02, 2021 at 02:01:36PM +1100, NeilBrown wrote:
> On Mon, Mar 01 2021, J. Bruce Fields wrote:
> 
> > I've gotten requests for similar functionality, and intended to
> > implement it using directory notifications on /proc/fs/nfsd/clients.
> 
> I've been exploring this a bit.
> When I mount a filesystem, 2 clients get created.
> With NFSv4.0, the second client is immediately deleted, and the first
> client is deleted one grace period after the filesystem is unmounted.
> With NFSv4.1 and 4.2, the first client is immediately deleted, and the
> second client is deleted immediately after the unmount.

Yeah, internally it's creating an "unconfirmed client" on SETCLIENTID
(or EXCHANGE_ID) and then a new "confirmed client" on
SETCLIENTID_CONFIRM (or CREATE_SESSION).

I'm not sure why the ordering's a little different between the 4.0/4.1+
cases.

The difference on unmount is because 4.1+ clients immediately send a
DESTROY_CLIENTID on unmount, but that op was new to 4.1.

(Note of course this isn't precisely mount/unmount, as the same client
can be used for multiple filesystems.)

Honestly, I think this is exposing an implementation detail and it's
dumb.  I'll look into fixing it.

(I don't know if that change itself would cause additional difficulty.)

--b.
