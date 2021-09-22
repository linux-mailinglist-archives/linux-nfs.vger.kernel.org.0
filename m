Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E697B414C41
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Sep 2021 16:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbhIVOlx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Sep 2021 10:41:53 -0400
Received: from mta-202a.oxsus-vadesecure.net ([51.81.232.240]:42189 "EHLO
        mta-202a.oxsus-vadesecure.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232720AbhIVOlx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Sep 2021 10:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; bh=7QNjXhYbRVw6dhTmWuCMnie/8ToA1kANIUcED2
 kEdj8=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1632321621;
 x=1632926421; b=EKn8nxmUB5IItJRc+1aEorI/gdqNYkw3nnWgoyeT4YgbdMFYT6HR74t
 FxSo/XVcWiKHkeKmILShAZMJ+D/XI+AJ0ZNid/ncR59KfSeQzdnBMSCckzL9wRGIjJSmX+T
 5ACdIBcI9TzbPoYLjmQbxijqm7ki/waoiaVDvcI2moyrxYg10Eq2DW9ff5bhebQRQxElFqq
 GNNScfp8+zzBoFk6pVXqZzm0IZbkc3NAU9HlHvU0DvQz9hi3TeQQJuQQPhWKTix2LTk39aN
 axM86qyZ8vuXTu5Sjn+w4HnBVIHa0gYZEW6uc9iOgS7E4gSAtc5tWInPrRoYXjaKN2eKNEW
 ESA==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by smtp.oxsus-vadesecure.net ESMTP oxsus2nmtao02p with ngmta
 id 4e501eda-16a72bddc4a42b8d; Wed, 22 Sep 2021 14:40:21 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Bruce Fields'" <bfields@fieldses.org>,
        "'Daire Byrne'" <daire@dneg.com>
Cc:     "'Chuck Lever III'" <chuck.lever@oracle.com>,
        "'Linux NFS Mailing List'" <linux-nfs@vger.kernel.org>
References: <20210921143259.GB21704@fieldses.org> <37851433-48C9-4585-9B68-834474AA6E06@oracle.com> <20210921160030.GC21704@fieldses.org> <CAPt2mGOf8orCkOj9hCM_sSu2uucPiRFPEK+yep+kufv-cDvhSA@mail.gmail.com> <20210922142655.GA22937@fieldses.org>
In-Reply-To: <20210922142655.GA22937@fieldses.org>
Subject: RE: [PATCH] nfs: reexport documentation
Date:   Wed, 22 Sep 2021 07:40:21 -0700
Message-ID: <01ca01d7afbf$c59723f0$50c56bd0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHaPmxrNtjQ+kQkvcxH7DV+BmtjZwK315yQATRhzjcB4dNh3wHVC7eIq23nh/A=
Content-Language: en-us
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On Wed, Sep 22, 2021 at 10:47:35AM +0100, Daire Byrne wrote:
> > We don't use or need crossmnt functionality, but I know from chatting
> > to others within our industry that the fsid/crossmnt limitation causes
> > them the most grief and confusion. I think in the case of Netapps,
> > there are similar problems with trying to re-export a namespace made
> > up of different volumes?
> >
> > As noted on the wiki, the only way around that is probably to have a
> > "proxy" mode (similar to what ganesha does?).
> 
> I'm not sure what Ganesha does.  I spent some time thinking about and
couldn't
> figure out how to do it, at least not on my own in a reasonable amount of
time.
> 
> I liked the idea of limiting the proxy to reexport only one original
server and
> reusing the filehandles from the original server without any wrapping.
That
> addresses the fsid/crossmnt limitation and filehandle length limitations.
It
> means proxies all share the same filehandles so eventually you could also
> implement migration and failover between them and the original server.
> 
> It means when you get a filehandle the only way to find out *anything*
about it-
> -even what filesystem it's from--is to go ask the server.
> That's slow, so you need a filehandle cache.  You have to deal with the
case
> where you get a filehandle for an object that isn't mounted yet.
> Its parents may not be mounted yet either.  If it's a regular file you
can't call
> LOOKUPP on it.  I'm not sure how to handle the vfs details in that
case--how do
> you fake up a superblock and vfsmount?

That really highlights how Ganesha's proxy is different than anything knfsd
would do. Ganesha doesn't have to deal with all the vfs stuff. It just needs
to be able to reflect the original server's handle back to the original
server. Ganesha ONLY supports NFSv3 proxy (without file open) and NFSv4.1+
proxy since it needs open by handle. Ganesha then lives with totally
floating inodes. They may get connected in a name space as a result of
READDIR or LOOKUP but it never needs the name space. Changing knfsd to NOT
need to hook the proxied server's handles into vfs would just result in a
kernel implementation of something more like Ganesha and probably not worth
it.

> Simpler might be to give up on that idea of reusing the original server's
> filehandle, and automatically generate and persistently store uuids for
new
> filesystems as you discover them.

Ganesha does have a mode for proxy where it uses a database to map original
server handles and Ganesha handles. That helps get around file handle size
problems but it's not a great solution because you have to keep a persistent
data base or lose it all when the proxy crashes.

Frank


