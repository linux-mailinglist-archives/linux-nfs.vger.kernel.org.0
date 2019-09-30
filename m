Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A921C2501
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2019 18:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbfI3QT5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Sep 2019 12:19:57 -0400
Received: from fieldses.org ([173.255.197.46]:38378 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfI3QT4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 30 Sep 2019 12:19:56 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 8975363E; Mon, 30 Sep 2019 12:19:56 -0400 (EDT)
Date:   Mon, 30 Sep 2019 12:19:56 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Kevin Vasko <kvasko@gmail.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4 client locks up on larger writes with Kerberos enabled
Message-ID: <20190930161956.GC10012@fieldses.org>
References: <20190926195557.GC2849@fieldses.org>
 <3A4773DD-A4E4-47BD-957A-E24E4604E390@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3A4773DD-A4E4-47BD-957A-E24E4604E390@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 30, 2019 at 09:51:23AM -0500, Kevin Vasko wrote:
> What does the GSS window control? I mentioned it in another thread
> somewhere but I found out that clients with a slower connection seem
> to not exhibit this issue.
> 
> All of these clients are local to the NFS server (in same room, which
> is in Korea). I’ve got clients in the USA and they don’t seem to
> exhibit this lockup behavior. I haven’t done extensive testing but we
> can get 3-4MB/s across the ocean and as of yet I haven’t see a client
> from the USA lock up like the ones local. It obviously takes a lot
> longer but haven’t seen it lock up on transferring several 5GB+ files. 
> 
> Could the GSS window not be overflowing with the slower connection and
> we wouldn’t see the issue? 

Each RPCSEC_GSS request has a sequence number that increases by one for
each rpc.  Even if the client is careful to send RPCs in order, they're
often out of order by the time server threads get around to processing
them.  To allow for this, the protocol has the server advertise a window
size (128 on the linux server), and then accept requests with sequence
numbers that fall within that window.

So our theory is that something is happening that is causing requests to
get reordered to such a degree that the server might see a sequence
number more than 128 less than the most recent sequence number it's
seen.

I'd expect the likelihood of that happening to correlate with the number
of rpc's that are in flight at a given time.

Could be that the slower network has a higher (bandwidth * delay)
product, allowing more rpc's in flight?  I don't know.

--b.


> 
> -Kevin
> 
> > On Sep 26, 2019, at 2:55 PM, Bruce Fields <bfields@fieldses.org>
> > wrote:
> > 
> > ﻿On Thu, Sep 26, 2019 at 08:55:17AM -0700, Chuck Lever wrote:
> >>>> On Sep 25, 2019, at 1:07 PM, Bruce Fields <bfields@fieldses.org>
> >>>> wrote:
> >>> In that case--I seem to remember there's a way to configure the
> >>> size of the client's slot table, maybe lowering that (decreasing
> >>> the number of rpc's allowed to be outstanding at a time) would
> >>> work around the problem.
> >> 
> >>> Should the client be doing something different to avoid or recover
> >>> from overflows of the gss window?
> >> 
> >> The client attempts to meter the request stream so that it stays
> >> within the bounds of the GSS sequence number window. The stream of
> >> requests is typically unordered coming out of the transmit queue.
> >> 
> >> There is some new code (since maybe v5.0?) that handles the
> >> metering: gss_xmit_need_reencode().
> > 
> > I guess I was thinking he could write a small number (say 2 digits)
> > into /sys/module/sunrpc/parameters/tcp_max_slot_table_entries
> > (before mounting, I guess?) and see if the problem's reproducable.
> > 
> > If not, that's a little more evidence that it's the gss sequence
> > window.
> > 
> > (And might be an adequate workaround for now.)
> > 
> > --b.
