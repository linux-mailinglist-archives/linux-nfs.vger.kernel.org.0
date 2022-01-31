Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AAF4A5043
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jan 2022 21:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379337AbiAaUhx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jan 2022 15:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350773AbiAaUho (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jan 2022 15:37:44 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CF5C061714
        for <linux-nfs@vger.kernel.org>; Mon, 31 Jan 2022 12:37:43 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 3D77414DC; Mon, 31 Jan 2022 15:37:42 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 3D77414DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1643661462;
        bh=uJfpAwjM5tou7NFmBbnDWYY7q+KJ90NYOs82VENLpwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EFKiskf1UL95uVa/QLy4S2Zjzpu6LZJ0k4ak6aoJuXIYisYrenuIxTIdsvtSUnocN
         K1iomOZ/aeisBTuoxWSqe9Y6EsEhcCRLbAP5/YTVu/aWfsIquNg887Z6CfHk7+6oIN
         YCkOj7tkcs0EqRAUZ1PI8iF6jeGu5/xO7KMlwmH0=
Date:   Mon, 31 Jan 2022 15:37:42 -0500
From:   bfields <bfields@fieldses.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        chris chilvers <chris.chilvers@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        Daire Byrne <daire@dneg.com>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        david <david@sigma-star.at>, goliath@sigma-star.at,
        trond myklebust <trond.myklebust@hammerspace.com>,
        anna schumaker <anna.schumaker@netapp.com>
Subject: Re: [RFC PATCH] mountd: export: Deal with NFS filesystems
Message-ID: <20220131203742.GE30119@fieldses.org>
References: <20220131104316.10357-1-richard@nod.at>
 <20220131170125.GB30119@fieldses.org>
 <8290532.5517.1643649341941.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8290532.5517.1643649341941.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 31, 2022 at 06:15:41PM +0100, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > Von: "bfields" <bfields@fieldses.org>
> >> Using /proc/fs/nfsfs/volumes it is possible to find the NFS fsid
> >> from the backend and use it as seed for mountd's UUID mechanism.
> > 
> > Sorry, I haven't checked--what is that number, really?  It's probably
> > not the fsid returned from the server, as that wouldn't be guaranteed
> > unique across multiple servers.  But that means it's probably generated
> > in a way that doesn't guarantee it's stable across reboots.  And we need
> > filehandles to work across reboots.
> 
> Unless I badly misunderstood the code it comes from fs/nfs/client.c's
> nfs_create_server() where the NFS client fetches NFS_ATTR_FATTR via getattr().
> So it should be unique:
> https://datatracker.ietf.org/doc/html/rfc7530#section-5.8.1.9

Unique within one server, but not across different servers.

Depending on how your servers assign fsids, collisions might be quite
likely.  Results of a collision would be pretty bad.

--b.
