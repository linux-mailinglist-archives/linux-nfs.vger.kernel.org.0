Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070E8490B33
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jan 2022 16:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiAQPLX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jan 2022 10:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiAQPLX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jan 2022 10:11:23 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A6DC061574
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jan 2022 07:11:23 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 13242792D; Mon, 17 Jan 2022 10:11:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 13242792D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1642432282;
        bh=0Q1B+g1+FzZc7SsR51pQWYJ6h+f3r7sa1YevEmg3Kt4=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=jLQHwJK4Z/XR8enltTT3XT1SL4WjeqwgyGnadmM6f7aSuPi8sIX6jeiVNOHp5P4dt
         olLhOOXpIHiVY8LwDSIv6op2F/wqoMqSG48gywqqTbhg5zEiimyPr9U6F+knYiCZbJ
         WCPFAyTz5w2zMA34UnIuWGmwM38JU6LVG6qbsx34=
Date:   Mon, 17 Jan 2022 10:11:22 -0500
To:     "Dorian Taylor (Lists)" <lists@doriantaylor.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: strange activity on otherwise idle linux client
Message-ID: <20220117151122.GB28708@fieldses.org>
References: <439CFB33-94AC-4F60-B737-A0F596B815E3@doriantaylor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <439CFB33-94AC-4F60-B737-A0F596B815E3@doriantaylor.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Jan 16, 2022 at 08:35:38AM -0500, Dorian Taylor (Lists) wrote:
> I noticed yesterday that my Linux (Ubuntu 21.10 x86_64, kernel 5.13.0)
> NFS4 mount was causing load on the (also Ubuntu, 20.04 LTS) server and
> when I went to investigate, it seemed like the client was polling the
> server at about 200 operations per second (100 ops read and the other
> 100 `nfsiostat` didn’t specify). When I looked at `nfsstat` on the
> server, I saw a profusion of `putfh` (32%), `sequence` (30%),
> `layoutget` (15%), and `layoutreturn` (15%)

The client is trying to use pnfs, which our server doesn't really have
much support for.  So probably either the server's returning
inconsistent results (making it look like it supports pnfs and then
failing when the client actually tries to use it), and/or the client is
failing to give up on pnfs when it should.

If you have the "pnfs" option set on any export, turn it off.

If it's not that, I'm not sure what's happening.  Looking at the traffic
in wireshark might be interesting.

--b.

> (`getattr` and `lookup`
> took another 3% between them, and the rest fell below the 1%
> threshold, even though the total number of operations recorded was on
> the order of 100 million for a day or so of uptime with two clients
> connected).
> 
> The chatty client was had a couple files open in Emacs but I closed
> them and determined that they weren’t being accessed with `lost`, but
> the polling continued. The strangely round number of the polling rate
> is suspicious. Is this normal behaviour?
> 
> It looks like the NFS version on the client is 1.3.4-6ubuntu1 and
> server is 1.3.4-2.5ubuntu3.4.
> 
> Regards,
> 
> -- Dorian Taylor Make things. Make sense.  https://doriantaylor.com
> 


