Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEA83698DB
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Apr 2021 20:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhDWSOX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Apr 2021 14:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWSOW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Apr 2021 14:14:22 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0552DC061574
        for <linux-nfs@vger.kernel.org>; Fri, 23 Apr 2021 11:13:45 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6FC5072B6; Fri, 23 Apr 2021 14:13:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6FC5072B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1619201625;
        bh=VDGScNMt8YSsBjppsorWazd/XLOqA14J/qrZcgK7jY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYBD6LDMK0lkICFC5weCMWQFGTrJlPLtFIQzu1vnYDxaT+hA+mmQn7fL+IqoymPst
         rKjK7yfW0xHikyK2HdJpmE/QeJ6dyfP+XFjHhVG15StOhS2HEsrYXQLHUg9g8YXUqR
         JWu/2EjQqAI2B1FdS4gV6IUNTmE+bGhvOhZ5WbOs=
Date:   Fri, 23 Apr 2021 14:13:45 -0400
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-nfs@vger.kernel.org, Steve Dickson <steved@redhat.com>,
        NeilBrown <neilb@suse.com>, Chuck Lever <chuck.lever@oracle.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>
Subject: Re: [RFC PATCH 1/1] mount.nfs: Fix mounting on tmpfs
Message-ID: <20210423181345.GE10457@fieldses.org>
References: <20210422191803.31511-1-pvorel@suse.cz>
 <20210422202334.GB25415@fieldses.org>
 <YIIuUPrlbBlr1ooD@pevik>
 <20210423142329.GB10457@fieldses.org>
 <YIL+KWuPmgm8A82C@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIL+KWuPmgm8A82C@pevik>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 23, 2021 at 07:04:41PM +0200, Petr Vorel wrote:
> Hi Bruce,
> 
> > On Fri, Apr 23, 2021 at 04:17:52AM +0200, Petr Vorel wrote:
> > > Hi,
> 
> > > > On Thu, Apr 22, 2021 at 09:18:03PM +0200, Petr Vorel wrote:
> > > > > LTP NFS tests (which use netns) fails on tmpfs since d4066486:
> 
> > > > > mount -t nfs -o proto=tcp,vers=4.2 10.0.0.2:/tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/tcp /tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/0
> > > > > mount.nfs: mounting 10.0.0.2:/tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/tcp failed, reason given by server: No such file or directory
> 
> > > > We should figure out the reason for the failure.  A network trace might
> > > > help.
> 
> > > Anything specific you're looking for?
> 
> > Actually I was thinking of capturing the network traffic, something
> > like:
> > 	tcpdump -s0 -wtmp.pcap -i<interface>
> 
> > then try the mount, then kill tcpdump and look at tmp.pcap.
> 
> I don't see anything suspicious, can you please have a look?
> https://gitlab.com/pevik/tmp/-/raw/master/nfs.v3.pcap
> https://gitlab.com/pevik/tmp/-/raw/master/nfs.v4.pcap
> https://gitlab.com/pevik/tmp/-/raw/master/nfs.v4.1.pcap
> https://gitlab.com/pevik/tmp/-/raw/master/nfs.v4.2.pcap

It might be the "hide" option, that's odd:

> exportfs -v
> /tmp/LTP_nfs01.xkKpqpRikV/4.2/tcp
> 		<world>(sync,wdelay,hide,no_subtree_check,fsid=7239,sec=sys,rw,secure,no_root_squash,no_all_squash)

--b.
