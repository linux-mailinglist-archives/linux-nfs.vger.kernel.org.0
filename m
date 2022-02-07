Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93EB4AC49C
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 17:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiBGP5y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 10:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379814AbiBGPxK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Feb 2022 10:53:10 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E44CC0401CE
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 07:53:09 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id AAD85ABC; Mon,  7 Feb 2022 10:53:08 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org AAD85ABC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1644249188;
        bh=rNJxM7GeGOHkDovVj4pq73zdj235xWOl515TYoBHqYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VXbQa6UnQSsvmZlTr8lea4KcUbvAabDVSEV4O8pkhkN4hGaNJ2B9et0zw3Yjx7FG2
         uUSWrE/qmLQKNTEipU14DBpHL6QsfeSwHI3+/yWQkqtAWCqvBwA3nbfN3ZBMONHW3Q
         m6bQk8xXQ+yaoypc6ze4vPSk96tPo05c5U9n1ieA=
Date:   Mon, 7 Feb 2022 10:53:08 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Daire Byrne <daire@dneg.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: nconnect & repeating BIND_CONN_TO_SESSION?
Message-ID: <20220207155308.GF16638@fieldses.org>
References: <CAPt2mGNF=iZkXGa93yjKQG5EsvUucun1TMhN5zM-6Gp07Bni2g@mail.gmail.com>
 <20220107171755.GD26961@fieldses.org>
 <CAPt2mGPtxNzigMEYXKFX0ayVc__gyJcQJVHU51CKqU+ujqh7Cg@mail.gmail.com>
 <20220110145210.GA18213@fieldses.org>
 <20220110172106.GC18213@fieldses.org>
 <CAPt2mGPUa_VHHshXwLLCH=wvdrd6Hyb4gttMeEqKdgFV4GJY7g@mail.gmail.com>
 <20220123224238.GA9255@fieldses.org>
 <CAPt2mGMXHqBtWJhuEM76MY5tm0V=uAghKT21KRsHBQAfgkuJpg@mail.gmail.com>
 <CAPt2mGN-fqG3nMnrtaa8jWQpkTZYqQuWAR+EseD0d7CCfEPmzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPt2mGN-fqG3nMnrtaa8jWQpkTZYqQuWAR+EseD0d7CCfEPmzw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The server enforces a limit on the total number of connections in
net/sunrpc/svc.c:svc_check_conn_limits().  Maybe that's what you're
hitting.

By default it's (number of threads + 3) * 20.  You can bump the number
of nfsd threads or change /proc/fs/nfsd/max_connections.

Weird that your limit would be 80, though, which is the number you'd
expect if the server was running with just one thread.

The only other rpc server I can think of that's involved here is the NFS
client's callback server, which does have only one thread, but
nfs_callback_create_svc() does:

	/* As there is only one thread we need to over-ride the default
	 * maximum of 80 connections
	 */
	serv->sv_maxconn = 1024;

and has since the beginning.  I can't see why that wouldn't work.  If
80's really your limit, though, that seems like an odd coincidence.
Have you seen that "too many connections" warning in the client logs?

--b.

On Mon, Feb 07, 2022 at 03:21:41PM +0000, Daire Byrne wrote:
> Trond kindly posted a patch to fix the noresvport mount issue with
> v4.2 and recent kernels.
> 
> I tested it quickly and verified ports greater than 1024 were being
> used as expected, but it seems the same issue persists. It still feels
> like it's related to the total number of server + nconnect pairings.
> 
> So I can have 20 servers mounted with nconnect=4 or 10 servers mounted
> with nconnect=8 but any combination that increases the total
> connection on the client past that and at least one of the servers
> ends up in a state such that it's just sending a bind_conn_to_session
> with every operation.
> 
> I'll see if I can discern anything from any packet capture (as
> suggested earlier by Rick), but it's hard to reproduce exactly in time
> and on demand. My theory is that maybe there is a timeout on the
> callback and that adding more connections is just adding more
> load/throughput and making a timeout more likely.
> 
> My workaround atm is to simply use NFSv3 instead of NFSv4 which might
> be a better choice for this kind of workload anyway.
> 
> Daire
> 
> 
> On Mon, 24 Jan 2022 at 12:33, Daire Byrne <daire@dneg.com> wrote:
> >
> > On Sun, 23 Jan 2022 at 22:42, J. Bruce Fields <bfields@fieldses.org> wrote:
> > > > I suspect it's just more recent kernels that has lost the ability to
> > > > use v4+noresvport
> > >
> > > Yes, thanks for checking that.  Let us know if you narrow down the
> > > kernel any more.
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=215526
> >
> > I think it stopped working somewhere between v5.11 and v5.12. I'll try
> > and bisect it this week.
> >
> > Daire
