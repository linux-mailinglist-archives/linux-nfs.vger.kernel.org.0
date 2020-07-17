Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C454022452E
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jul 2020 22:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgGQU3G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jul 2020 16:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgGQU3G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jul 2020 16:29:06 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BB2C0619D2
        for <linux-nfs@vger.kernel.org>; Fri, 17 Jul 2020 13:29:05 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id A9F3FC51; Fri, 17 Jul 2020 16:29:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A9F3FC51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1595017744;
        bh=P4jrLmj7ZDivrUsNTNWj4RNzuKDGQCZQHginKPBk/Fg=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=JpMJR+suItOOAhWk39liI27jU5SDwOkS8Tv1xeiLNErAiN0C4iUcxq0BPcCsfi2cK
         qZvsjAPnfnMlqPopJGTO6jHZklIWCZF3GIH+Y97cpfIpJCzXJf+uitW9p4ZLYJsl01
         3/JccidzbR7mac+csg1SCUJ1tZlKamQS3GAMTDXw=
Date:   Fri, 17 Jul 2020 16:29:04 -0400
To:     Steve Dickson <SteveD@RedHat.com>
Cc:     Doug Nazar <nazard@nazar.ca>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: nfs-utils README updates
Message-ID: <20200717202904.GD21567@fieldses.org>
References: <34f07da7-250d-f354-bf59-74b9f1a0e16f@nazar.ca>
 <0555b3d1-8cbe-c3d8-2214-2bf7d3d65286@RedHat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0555b3d1-8cbe-c3d8-2214-2bf7d3d65286@RedHat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jul 17, 2020 at 01:34:03PM -0400, Steve Dickson wrote:
> Hey Doug,
> 
> On 7/16/20 5:36 PM, Doug Nazar wrote:
> > I was looking through the README to ensure my systems followed the correct setup and noticed a few things.
> > 
> > Looks like the reference to libnfsidmap can be dropped.
> > 
> > It looks like nfsdcld is again the correct setup for client tracking. A section should be added to SERVER STARTUP to include nfsdcld on NFS4+ servers.
> > 
> > Should it mention which modules are required before starting? I've had to locally add 'auth_rpcgss' to my startup scripts or svcgssd will bail on startup.
> > 
> > Any other changes or best practices that should be mentioned before I send a patch?
> 
> Yes... the README is dreadfully out of date... although most of it has
> not changed but a lot has... esp when it comes to the systemd set up..
> although the systemd/README is pretty accurate... Maybe a point to
> the systemd/README in the top README would be good. 
> 
> What script did you have to add 'auth_rpcgss' to? 
> It should be automatically  be loaded when the sunrpc 
> module is loaded.

Yes, looking at that out of curiosity... there's a request_module() in
net/sunrpc/auth.c that should be trying to load "rpc-auth-6".  Together
with the MODULE_ALIAS("rpc-auth-6") in net/sunrpc/auth_gss/auth_gss.c,
that should make this automatic.

--b.
