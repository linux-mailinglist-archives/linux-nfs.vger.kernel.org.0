Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A01365EBA
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Apr 2021 19:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhDTRlI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Apr 2021 13:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhDTRlI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Apr 2021 13:41:08 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980ABC06174A
        for <linux-nfs@vger.kernel.org>; Tue, 20 Apr 2021 10:40:36 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1CBCE6D1C; Tue, 20 Apr 2021 13:40:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1CBCE6D1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1618940436;
        bh=X9toThkin5149zH09S/sFcZ0ZAhAw/iXkYFyz96xI74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NNDo7RhmL+9IHebhcxtw4N+80ikDCPH2NN+S+NFNLZKMVClfvAtoqUwKTcCcNVq2M
         9GGrGbER2Zq1iuc3ZUvKLmiReMTxHMWeje+U+KlrJSbkJ3LSu0LnPOQ1KKJCmZhO3p
         UurfOXsgtAZ556xS4Onk0oSAHFRbSuPJoEYhutjg=
Date:   Tue, 20 Apr 2021 13:40:36 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "ajmitchell@redhat.com" <ajmitchell@redhat.com>,
        "SteveD@RedHat.com" <SteveD@RedHat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
Message-ID: <20210420174036.GD4017@fieldses.org>
References: <366FA143-AB3E-4320-8329-7EA247ADB22B@oracle.com>
 <77a6e5a4-7f14-c920-0277-2284983e6814@RedHat.com>
 <2F7FBCA0-7C8D-41F0-AC39-0C3233772E31@oracle.com>
 <c13f792a-71e8-494f-3156-3ff2ac7a0281@RedHat.com>
 <DAFAF7B1-5C56-4DA7-B7F9-4F544CCDA031@oracle.com>
 <f0525973-a32c-32d4-4ccc-827acaa3c125@RedHat.com>
 <20A43DDA-C08E-4E39-A83C-24E326768ADE@oracle.com>
 <2d7d391802a3984b68aa8b3e7f360b0b6cb733dc.camel@hammerspace.com>
 <20210420171806.GC4017@fieldses.org>
 <be1a2b6beab29b3e40277f5fefd6c49b37c32361.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be1a2b6beab29b3e40277f5fefd6c49b37c32361.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 20, 2021 at 05:28:08PM +0000, Trond Myklebust wrote:
> On Tue, 2021-04-20 at 13:18 -0400, J. Bruce Fields wrote:
> > On Tue, Apr 20, 2021 at 02:31:58PM +0000, Trond Myklebust wrote:
> > > I think the important thing is, as Chuck said, that the setting of
> > > the
> > > uniquifier has to be automated. There are too many instances out
> > > there
> > > of people who get confused because they are using a default
> > > hostname,
> > > such as 'localhost.localdomain' and are setting no uniquifier.
> > > 
> > > So the point is that it needs to be persisted by an automated
> > > script if
> > > unset.
> > > 
> > > While that script could use nfsconf to get/set the persisted
> > > uniquifier, the worry is that such an automated change might be
> > > made
> > > while the user is performing some other edit of nfs.conf. What
> > > happens
> > > then?
> > 
> > The one thing I'm a little uneasy about is ignoring /etc/machine-id.
> > Seems like distros *should* be creating it for us.  And it would be
> > convenient to have one source of machine identity rather than
> > separate
> > ones for different subsystems.
> > 
> > Maybe we could use that if it exists, and fall back on generating our
> > own only if it doesn't?
> > 
> > (Well, where "use it" actually means take a hash of it, as explained
> > in
> > machine-id(5).)
> > 
> 
> Maybe, but that ties the nfs-utils package irrevocably to systemd.

Well, like I say, we could have a fallback.  Or even provide alternative
scripts in nfs-utils and let the distro decide which to install
depending on whether they use systemd.

But, whatever, those two alternatives (machine-id or vs. nfs generating
its own uuid) are basically the same on some level.

I agree with the basic idea that this should be automated rather than
living in a configuration file that humans might have to deal with.

--b.
