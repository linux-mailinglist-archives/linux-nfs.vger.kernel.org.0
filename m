Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDBD487B42
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jan 2022 18:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240626AbiAGRR4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Jan 2022 12:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiAGRR4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Jan 2022 12:17:56 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0878C061574
        for <linux-nfs@vger.kernel.org>; Fri,  7 Jan 2022 09:17:55 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 24ACC7306; Fri,  7 Jan 2022 12:17:55 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 24ACC7306
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641575875;
        bh=w0nTkVp+J9ZlHM1mIreCNkF2+8KxdMookVycwBmgo5k=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=GLGq9jgPZINF90iALVOzAE9kAaJeMb+SGHzJEwtA+mL1hyhIrwzpM0FdFobpxm3eA
         wBo7dS0jWKXnFWl16pg8S6dfnwxaG0Eff4qlp/0F2lwzfFnP4Mg5OtiWxPdCmLoRQU
         icGImbNkLT3TAg4WUXGuM7srUSlPUuMA4S7F0uF0=
Date:   Fri, 7 Jan 2022 12:17:55 -0500
To:     Daire Byrne <daire@dneg.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: nconnect & repeating BIND_CONN_TO_SESSION?
Message-ID: <20220107171755.GD26961@fieldses.org>
References: <CAPt2mGNF=iZkXGa93yjKQG5EsvUucun1TMhN5zM-6Gp07Bni2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPt2mGNF=iZkXGa93yjKQG5EsvUucun1TMhN5zM-6Gp07Bni2g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 07, 2022 at 12:26:07PM +0000, Daire Byrne wrote:
> Hi,
> 
> I have been playing around with NFSv4.2 over very high latency
> networks (200ms - nocto,actimeo=3600,nconnect) and I noticed that
> lookups were much slower than expected.
> 
> Looking at a normal stat, at first with simple workloads, I see the
> expected LOOKUP/ACCESS pairs for each directory and file in a path.
> But after some period of time and with extra load on the client host
> (I am also re-exporting these mounts but I don't think that's
> relevant), I start to see a BIND_CONN_TO_SESSION call for every
> nconnect connection before every LOOKUP & ACCESS. In the case of a
> high latency network, these extra roundtrips kill performance.
> 
> I am using nconnect because it has some clear performance benefits
> when doing sequential reads and writes over high latency connections.
> If I use nconnect=16 then I end up with an extra 16
> BIND_CONN_TO_SESSION roundtrips before every operation. And once it
> gets into this state, there seems to be no way to stop it.
> 
> Now this client is actually mounting ~22 servers all with nconnect and
> if I reduce the nconnect for all of them to "8" then I am less likely
> to see these repeating BIND_CONN_TO_SESSION calls (although I still
> see some). If I reduce the nconnect for each mount to 4, then I don't
> see the BIND_CONN_TO_SESSION appear (yet) with our workloads. So I'm
> wondering if there is some limit like the number of client mounts of
> unique server (22) times the total number of TCP connections to each?
> So in this case 22 servers x nconnect=8 = 176 client connections.

Hm, doesn't each of these use up a reserved port on the client by
default?  I forget the details of that.  Does "noresvport" help?

On the server (if Linux) there are maximums on the number of
connections.  It should be logging "too many open connections" if you're
hitting that.

--b.

> Or are there some sequence errors that trigger a BIND_CONN_TO_SESSION
> and increasing the number of nconnect threads increases the chances of
> triggering it? The remote servers are a mix of RHEL7 and RHEL8 and
> seem to show the same behaviour.
> 
> I tried watching the rpcdebug stream but I'll admit I wasn't really
> sure what to look for. I see the same thing on a bunch of recent
> kernels (I've only tested from 5.12 upwards). This has probably been
> happening for our workloads for quite some time but it's only when the
> latency became so large that I noticed all these extra round trips.
> 
> Any pointers as to why this might be happening?
> 
> Cheers,
> 
> Daire
