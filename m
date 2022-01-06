Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EC74869FF
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jan 2022 19:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242811AbiAFSdQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jan 2022 13:33:16 -0500
Received: from mta-102a.oxsus-vadesecure.net ([51.81.61.66]:47157 "EHLO
        nmtao102.oxsus-vadesecure.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242799AbiAFSdQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Jan 2022 13:33:16 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jan 2022 13:33:15 EST
DKIM-Signature: v=1; a=rsa-sha256; bh=eNfxpTckACcDHKBW/uXnIpn2Fyp3slkYifxRnE
 GNk+o=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1641493692;
 x=1642098492; b=Vjm71RPlF66vcdPqZxksGBC+rDS/EJk/Hh4fVnXEgpI14gbdXviUdPs
 GtSl6XQLjT+Hz4qPljEiAnYPbZMmG5pXIIA0Z3CSc36b+bklJSBWQLKVAoLWqaPcmmRSt99
 W63TLm1c1wSY+i/1MSsHfaXEJJMi7wo0JzVkwQ2hHLn/n09y+oblit6vJcc5bCDfqhWgOQX
 gktwGW94t9Bkm3ybJcutMsGQm53+ZvFoPfZhZ88ukGlSsUYTvFYFGPYmeI7f/ko+Y5bD4sE
 fgc+/Yls5jm96EmbvBMkdEFB8ZUF9xEdUuASjmVnBsY7JfGCiKD9W6FVbKRIh7wvFhR/nSa
 a7w==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by smtp.oxsus-vadesecure.net ESMTP oxsus1nmtao02p with ngmta
 id 9f75172a-16c7c1d0c0b95c7e; Thu, 06 Jan 2022 18:28:11 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Bruce Fields'" <bfields@fieldses.org>,
        "'Chuck Lever III'" <chuck.lever@oracle.com>
Cc:     "'Linux NFS Mailing List'" <linux-nfs@vger.kernel.org>
References: <164010014140.6448.18108343631467243001.stgit@klimt.1015granger.net> <20220103210013.GK21514@fieldses.org> <BAA88CD4-C692-4AEE-9A8D-F62F8CBEA2F5@oracle.com> <20220104030708.GC27642@fieldses.org>
In-Reply-To: <20220104030708.GC27642@fieldses.org>
Subject: RE: [PATCH RFC] NFSD: Fix zero-length NFSv3 WRITEs
Date:   Thu, 6 Jan 2022 10:28:10 -0800
Message-ID: <058a01d8032b$2992e740$7cb8b5c0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQKWYapNrF8jKbD/l/9lE4SZwMJ+uAKapAyhAkiWL54BpUJMPKqlTmhg
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On Tue, Jan 04, 2022 at 01:12:40AM +0000, Chuck Lever III wrote:
> > > but still may be worth posting
> > > somewhere and making it the start of a collection of protocol-level
> > > v3 tests.
> >
> > ... I question whether it's worth posting anything until there is a
> > framework for collecting and maintaining such things. I do agree that
> > the community should be working up a set of NFSv3 specific tests like
> > this. I like Frank's idea of making them a part of pynfs, fwiw.
> 
> Somebody did actually do a v3 pynfs that I never got around to merging,
it'd be
> worth revisiting:
> 
> 	https://github.com/sthaber/pynfs

I'm working on that... It requires significant effort, but I have made some
progress:

https://github.com/ffilz/pynfs/commit/d3a1610815117cb6bdf6567e575baedb0d8809
5e

I need to get back to it, but it's lower on my priority list.

Frank

