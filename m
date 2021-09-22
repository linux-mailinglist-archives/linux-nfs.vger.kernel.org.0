Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395D1414BD6
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Sep 2021 16:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbhIVO20 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Sep 2021 10:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbhIVO20 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Sep 2021 10:28:26 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D185C061574
        for <linux-nfs@vger.kernel.org>; Wed, 22 Sep 2021 07:26:56 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1C7A6367; Wed, 22 Sep 2021 10:26:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1C7A6367
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1632320815;
        bh=ze+0jcQBzL6Ulx22ziDKjl/vaKbRclTnC12s+Dg9obI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T71QDNLTYYL0ZvBWv1dAf3PL1HNULmXGqi8nuAnGm49LqLRZTF3bOy6YTcARy5g71
         FFHY5JzQJl5wMd0J1G8wdrw+oXD2633dS36EL2PaBDJrWG70Jh19Q6ImDzPlSCYSoY
         dp5V/VIVZ/wRXrpiZyB3oYNauHWsjgAgcyY1dGmI=
Date:   Wed, 22 Sep 2021 10:26:55 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Daire Byrne <daire@dneg.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: reexport documentation
Message-ID: <20210922142655.GA22937@fieldses.org>
References: <20210921143259.GB21704@fieldses.org>
 <37851433-48C9-4585-9B68-834474AA6E06@oracle.com>
 <20210921160030.GC21704@fieldses.org>
 <CAPt2mGOf8orCkOj9hCM_sSu2uucPiRFPEK+yep+kufv-cDvhSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPt2mGOf8orCkOj9hCM_sSu2uucPiRFPEK+yep+kufv-cDvhSA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 22, 2021 at 10:47:35AM +0100, Daire Byrne wrote:
> We don't use or need crossmnt functionality, but I know from chatting
> to others within our industry that the fsid/crossmnt limitation causes
> them the most grief and confusion. I think in the case of Netapps,
> there are similar problems with trying to re-export a namespace made
> up of different volumes?
> 
> As noted on the wiki, the only way around that is probably to have a
> "proxy" mode (similar to what ganesha does?).

I'm not sure what Ganesha does.  I spent some time thinking about and
couldn't figure out how to do it, at least not on my own in a reasonable
amount of time.

I liked the idea of limiting the proxy to reexport only one original
server and reusing the filehandles from the original server without any
wrapping.  That addresses the fsid/crossmnt limitation and filehandle
length limitations.  It means proxies all share the same filehandles so
eventually you could also implement migration and failover between them
and the original server.

It means when you get a filehandle the only way to find out *anything*
about it--even what filesystem it's from--is to go ask the server.
That's slow, so you need a filehandle cache.  You have to deal with the
case where you get a filehandle for an object that isn't mounted yet.
Its parents may not be mounted yet either.  If it's a regular file you
can't call LOOKUPP on it.  I'm not sure how to handle the vfs details in
that case--how do you fake up a superblock and vfsmount?

Simpler might be to give up on that idea of reusing the original
server's filehandle, and automatically generate and persistently store
uuids for new filesystems as you discover them.

I don't know, I'm rambling.

--b.
