Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65409270F8C
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Sep 2020 18:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgISQdz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Sep 2020 12:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgISQdz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Sep 2020 12:33:55 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D69C0613CE
        for <linux-nfs@vger.kernel.org>; Sat, 19 Sep 2020 09:33:55 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C503AC56; Sat, 19 Sep 2020 12:33:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C503AC56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1600533233;
        bh=tV857EfmON+0v03OUWwaMYbgY3FrTECXHKwrrH01Vo8=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=JleJAeuacAyY8AB++zZv/0gDA+ueo1ONJ5z7TNCPrnN31TEudXcy4/e4gDm0QGm/i
         EZJRll0gYObMvUcWOHZZ3cXcswDoUxPAD1qjDMiiq64VeZBWUItqz/SrMuigudL6eu
         b/oN+xtMyWIy+HyrndunQecTFDa8EIVeQzLwdxlQ=
Date:   Sat, 19 Sep 2020 12:33:53 -0400
To:     Chris Hall <linux-nfs@gmch.uk>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: mount.nfs4 and logging
Message-ID: <20200919163353.GA15785@fieldses.org>
References: <S1725851AbgIKKt5/20200911104957Z+185@vger.kernel.org>
 <a38a1249-c570-9069-a498-5e17d85a418a@gmch.uk>
 <f06f86ef-08bd-3974-3d92-1fbda700cc11@RedHat.com>
 <f7b9c8b4-29a6-2f28-b1d9-739c546fd557@gmch.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7b9c8b4-29a6-2f28-b1d9-739c546fd557@gmch.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 15, 2020 at 02:06:23PM +0100, Chris Hall wrote:
> Also FWIW, I gather that this is configuration for the client-side
> 'mount' of nfs exports, *only*.  I suppose it should be obvious that
> this has absolutely nothing to do with configuring (server-side)
> 'mountd'.  Speaking as a fully paid up moron-in-a-hurry, it has
> taken me a while to work that out :-(  [I suggest that the comments
> in the .conf files and the man-page could say that nfs.conf is
> server-side and nfsmount.conf is client-side -- just a few words,
> for the avoidance of doubt.]

That sounds sensible.  If you're feeling industrious, you can

	git clone git://linux-nfs.org/~steved/nfs-utils

and patch those files and mail us a patch....

> Given that NFSv4 is going on 20 years old now, I do wonder why the
> earlier versions are not treated a "legacy".

Agreed, they basically are legacy now, but documentation's slow to catch
up.

> For example: I run nfs on my firewall machine so that I can
> configure it from elsewhere on the network.  Naturally, the firewall
> machine is firmly wrapped so that it may only be accessed by
> particular machines inside the network.  I also try to ensure that
> the absolute minimum number of daemons are running and the absolute
> minumum number of ports are open.  In that context, (a) is there a
> way to persuade 'systemctl start nfs-service' to be "nfs4 only", and
> to *not* start 'rpcbind' (and *not* open port 111), and (b) are
> rpc.idmapd, rpc.mountd and rpc.statd required for nfs4 ?  (ie, is
> nfsdcld sufficient ?)

For the server, you don't need rpcbind or rpc.statd for v4, but you do
need rpc.idmapd, rpc.mountd and nfsdcld.

rpc.mountd is the only one of those three that needs to listen on a
network port, but that's only in the NFSv2/v3 case.  I'm not sure if
we're getting that right.

--b.
