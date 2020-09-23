Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A7D275A7B
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Sep 2020 16:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgIWOlC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Sep 2020 10:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgIWOk5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Sep 2020 10:40:57 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB5EC0613CE
        for <linux-nfs@vger.kernel.org>; Wed, 23 Sep 2020 07:40:57 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C0B7B425E; Wed, 23 Sep 2020 10:40:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C0B7B425E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1600872056;
        bh=wQ3ySGQ3qI9b/NbrCMX0I7wrhr4hVkVvhoRW64zTCYc=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=hiHp4vDxF3twvp3DyhDbGy2GB3DAp9U/YBNBtVREk2jruYG8VxaXAusSXU51Yc5QR
         0qHQFZ2WhyV9G78I4ttIgzSTHvX7pZcLYDaptcEganQ+jBVO1QUbSNM05siL0uVatY
         tMgKf7Vw3ZP4fGj9rlEroWXWLuxSEZj86Pgqrc/8=
Date:   Wed, 23 Sep 2020 10:40:56 -0400
To:     Chris Hall <linux-nfs@gmch.uk>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: mount.nfs4 and logging
Message-ID: <20200923144056.GB4691@fieldses.org>
References: <S1725851AbgIKKt5/20200911104957Z+185@vger.kernel.org>
 <a38a1249-c570-9069-a498-5e17d85a418a@gmch.uk>
 <f06f86ef-08bd-3974-3d92-1fbda700cc11@RedHat.com>
 <f7b9c8b4-29a6-2f28-b1d9-739c546fd557@gmch.uk>
 <20200919163353.GA15785@fieldses.org>
 <20200919164020.GB15785@fieldses.org>
 <12298172-f830-4f22-8612-dfbbc74b8a40@gmch.uk>
 <20200920193245.GC28449@fieldses.org>
 <eb64e66e-0328-f9e6-7511-1b73f67c49c1@gmch.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb64e66e-0328-f9e6-7511-1b73f67c49c1@gmch.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 21, 2020 at 03:40:01PM +0100, Chris Hall wrote:
> On 20/09/2020 20:32, J. Bruce Fields wrote:
> >On Sun, Sep 20, 2020 at 10:56:28AM +0100, Chris Hall wrote:
> ...
> >>Where nfsdcld, rpc.idmapd and rpc.mountd have indeed been started
> >>but are not bound to any ports.
> 
> >That looks good.  (And rpc.mountd does still serve a purpose in the
> >NFSv4 case, answering requests from the kernel for information related
> >to exported filesystems.)
> 
> >>But rpc.statd and rpcbind have also been started, and various ports
> >>have been opened, including port 111 which is bound to systemd.  Is
> >>there a way to inhibit that for nfs4 only ?
> 
> >Unlike rpc.mountd, there's no reason for those to be running at all.
> >You can mask thoe corresponding systemd units.
> 
> I tried masking all of: rpcbind.socket, rpcbind.service,
> statd.service and statd-notify.service.  systemctl start
> nfs-server.service (eventually) gives, according to the logging:
> 
>  nfs-mountd.service: start operation timed out. Terminating.
>  nfs-mountd.service: State 'stop-sigterm' timed out. Killing.
>  nfs-mountd.service: Killing process x (rpc.mountd) with signal SIGKILL.
>  nfs-mountd.service: Control process exited, code=killed, status=9/KILL

Huh, that suggests rpc.mountd is trying to contact rpcbind, but if
you've got v2/v3 turned off in the configuration files, it shouldn't be
trying to register anything.

Looking at the code....  I wonder if the problem is the unregistration
added by 849b7072a049 "mountd: Clear mountd registrations at start up"?

> If I unmask rpcbind.service, I can start nfs-server.  It no longer
> starts rpc.statd.  But I still have rpcbind running and port 111
> open.
> 
> >It'd be nice if there was a way to make that happen automatically if v2
> >and v3 are configured out in the configuration files, but I don't know
> >how to make that happen.
> 
> It would and me neither.

I suppose they could check the configuration and exit on startup if they
see they're not needed.  Will systemd notice they died and try to
restart them or something?

--b.
