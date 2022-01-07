Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A09487CA5
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jan 2022 19:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbiAGS5H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Jan 2022 13:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiAGS4N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Jan 2022 13:56:13 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87D9C033241
        for <linux-nfs@vger.kernel.org>; Fri,  7 Jan 2022 10:56:00 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 318957308; Fri,  7 Jan 2022 13:56:00 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 318957308
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641581760;
        bh=LYP5GNWvYo7+uUzCcQ0CpYUTN56u6o/8B2OLvmuc/Zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TX0Q/7NtE43pmfXAuK3k+1Rqo03B/fS+9kFBGBdajo3l+2K2thlA9h7rZc+aYjysG
         aBRExq8uoEfSYiMF9WO09q6MaWEI6dyAQedaRe5gL2Nv7WNMNDyywVDt01KTGB1NcW
         aroCpQrBNSX37Zteayst9k/o/6j7H9FbYhGDuJbI=
Date:   Fri, 7 Jan 2022 13:56:00 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Rick Macklem <rmacklem@uoguelph.ca>
Cc:     Daire Byrne <daire@dneg.com>, linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: nconnect & repeating BIND_CONN_TO_SESSION?
Message-ID: <20220107185600.GE26961@fieldses.org>
References: <CAPt2mGNF=iZkXGa93yjKQG5EsvUucun1TMhN5zM-6Gp07Bni2g@mail.gmail.com>
 <20220107171755.GD26961@fieldses.org>
 <YQXPR0101MB0968DEDAB6EC20BB11BF7D6ADD4D9@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQXPR0101MB0968DEDAB6EC20BB11BF7D6ADD4D9@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 07, 2022 at 05:59:33PM +0000, Rick Macklem wrote:
> Hope you don't mind a top post...
> 
> If you capture packets, you will probably see a
> callback_down flag in the reply to Sequence for
> RPC(s) just before the BindConnectionToSession.
> (This is what normally triggers them.)

Hm, I'm pretty sure we *do* have a server bug or two in that area, so
that's a possibility.

--b.

> 
> The question then becomes "why is the server
> setting the ..callback_down flag?".
> 
> One possibility might be a timeout on a callback
> attempt that is too agressive?
> --> You should be able to see the callbacks in the
>       packet trace.
> 
> Another might the server attempting the callbacks on
> the wrong TCP connection.
> --> The FreeBSD server was broken until recently and
>       would use any TCP connection to the client and not
>       just the one where the Session had enabled the
>       backchannel.
>       --> If you happen to be mounting a FreeBSD server,
>              you cannot use "nconnect" unless it is very
>             up-to-date (the fix was done 10months ago, but
>              it takes quite a while to get out in releases).
> Look for the CreateSession RPCs when the mount was
> first done and see which ones have a backchannel.
> 
> Btw, unless the client establishes a new TCP connection
> (SYN, SYN/ACK,...) before doing the BindConnectionToSession,
> the server might reply NFS4ER_INVAL. The RFC says this is
> to be done, but I'll admit the FreeBSD server doesn't bother.
> 
> Good luck with it, rick
> 
> 
> ________________________________________
> From: J. Bruce Fields <bfields@fieldses.org>
> Sent: Friday, January 7, 2022 12:17 PM
> To: Daire Byrne
> Cc: linux-nfs
> Subject: Re: nconnect & repeating BIND_CONN_TO_SESSION?
> 
> CAUTION: This email originated from outside of the University of Guelph. Do not click links or open attachments unless you recognize the sender and know the content is safe. If in doubt, forward suspicious emails to IThelp@uoguelph.ca
> 
> 
> On Fri, Jan 07, 2022 at 12:26:07PM +0000, Daire Byrne wrote:
> > Hi,
> >
> > I have been playing around with NFSv4.2 over very high latency
> > networks (200ms - nocto,actimeo=3600,nconnect) and I noticed that
> > lookups were much slower than expected.
> >
> > Looking at a normal stat, at first with simple workloads, I see the
> > expected LOOKUP/ACCESS pairs for each directory and file in a path.
> > But after some period of time and with extra load on the client host
> > (I am also re-exporting these mounts but I don't think that's
> > relevant), I start to see a BIND_CONN_TO_SESSION call for every
> > nconnect connection before every LOOKUP & ACCESS. In the case of a
> > high latency network, these extra roundtrips kill performance.
> >
> > I am using nconnect because it has some clear performance benefits
> > when doing sequential reads and writes over high latency connections.
> > If I use nconnect=16 then I end up with an extra 16
> > BIND_CONN_TO_SESSION roundtrips before every operation. And once it
> > gets into this state, there seems to be no way to stop it.
> >
> > Now this client is actually mounting ~22 servers all with nconnect and
> > if I reduce the nconnect for all of them to "8" then I am less likely
> > to see these repeating BIND_CONN_TO_SESSION calls (although I still
> > see some). If I reduce the nconnect for each mount to 4, then I don't
> > see the BIND_CONN_TO_SESSION appear (yet) with our workloads. So I'm
> > wondering if there is some limit like the number of client mounts of
> > unique server (22) times the total number of TCP connections to each?
> > So in this case 22 servers x nconnect=8 = 176 client connections.
> 
> Hm, doesn't each of these use up a reserved port on the client by
> default?  I forget the details of that.  Does "noresvport" help?
> 
> On the server (if Linux) there are maximums on the number of
> connections.  It should be logging "too many open connections" if you're
> hitting that.
> 
> --b.
> 
> > Or are there some sequence errors that trigger a BIND_CONN_TO_SESSION
> > and increasing the number of nconnect threads increases the chances of
> > triggering it? The remote servers are a mix of RHEL7 and RHEL8 and
> > seem to show the same behaviour.
> >
> > I tried watching the rpcdebug stream but I'll admit I wasn't really
> > sure what to look for. I see the same thing on a bunch of recent
> > kernels (I've only tested from 5.12 upwards). This has probably been
> > happening for our workloads for quite some time but it's only when the
> > latency became so large that I noticed all these extra round trips.
> >
> > Any pointers as to why this might be happening?
> >
> > Cheers,
> >
> > Daire
