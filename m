Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243F8440077
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Oct 2021 18:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhJ2Qn2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Oct 2021 12:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhJ2Qn2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Oct 2021 12:43:28 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7991DC061570
        for <linux-nfs@vger.kernel.org>; Fri, 29 Oct 2021 09:40:59 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 35799707A; Fri, 29 Oct 2021 12:40:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 35799707A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1635525658;
        bh=QbacSfC9g12q+5mYoOpUsmsT2arJRCgrfJsYfOe6DqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HhOkjV5pWqZjx+SbyTj97CBM2d1pw0YXWrAoID6SmlSRovAgYieXcYdBFrGyTY4HJ
         zXn6tTZTJuolcIkrFRquiKVbKn8Dv6/OAr3kkG5zQFKGRnjgxHs2gFgqqgTK45BheR
         r6uYDhAZ7UsDOyYRPwUQ7Cbgbg03CBrqMJ7D9tFg=
Date:   Fri, 29 Oct 2021 12:40:58 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/1] Enable inter server to server copies on a export
Message-ID: <20211029164058.GE19967@fieldses.org>
References: <20211028144851.644018-1-steved@redhat.com>
 <20211029134534.GA19967@fieldses.org>
 <3e928624-6a7a-8583-7ea4-4eef9c22488e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e928624-6a7a-8583-7ea4-4eef9c22488e@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 29, 2021 at 10:56:24AM -0400, Steve Dickson wrote:
> On 10/29/21 09:45, J. Bruce Fields wrote:
> >Really, first I think we should try to identify what the problem is that
> >we're trying to solve.
> I'm not trying to solve any problem... I'm just trying to enable a
> feature in a sane and safe way. By only have one module param it
> is on all the time on all copies... With an export opt, admins
> can pick and choose which exports use it. I'm thinking that
> is a bit less risky.

So, I'm not sure which risk you're thinking about.

If it's the risk of the client telling the destination server to copy
from a rogue server--I'm kind of regretting bringing that up.  If there
are bugs in that area, I'd rather they be fixed, than that we introduce
new configuration to work around bugs that may or may not exist.  They'd
need to be fixed anyway, for other reasons.  I think Dai has volunteered
to look through the code that handles replies to the small number of
operations concerned, and I think that's good enough due diligence.  And
I'm not getting the impression Trond is particularly worried about the
client code here either.

If the risk is performance--like I say, I'm not sure exactly what those
cases look like.

I've been thinking about it in terms of bandwidth, but maybe that's
wrong--the bigger problem may be when the source server is only
accessible to the client for some reason (like, you're copying from a
local server to a destination server that's outside a firewall).  Maybe
the destination server will end up waiting a long time trying to reach
the source.

But, again, I'm not sure an export option helps, because I don't see why
that problem would necessarily be per-destination-server-export.

Instead, we may just need to make sure the destination server is quick
to timeout, or has some mechanism to blacklist source servers so it's
not repeatedly timing out trying to copy from the same server.  I don't
know, I'm just thinking out loud.

> The option of setting the inter_copy_offload_enable is still
> there... if admins want to go that route.

Let's just stick with that for now, and leave it off by default until
we're sure it's mature enough.  Let's not introduce new configuration to
work around problems that we haven't really analyzed yet.

It's not as though turning on a module option is any more difficult than
setting an export option.

--b.
