Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E6C32ED41
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Mar 2021 15:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhCEOgv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Mar 2021 09:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhCEOgr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Mar 2021 09:36:47 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD63C061574
        for <linux-nfs@vger.kernel.org>; Fri,  5 Mar 2021 06:36:47 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 00A4C25FE; Fri,  5 Mar 2021 09:36:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 00A4C25FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614955006;
        bh=M8o/BEePr9yNNOr2OD094eY7qsl1F/RwPkgZvXvJ8KU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMuuBow5j2yfyNpSIhtpkWw3xjMP6MY3l793mmQQF0alUtodyEJCyTX206Oo3itzz
         6pJJIVQTsksuyaatQn/5N31SG4AtNjzCsjHrAqXzKTZMxHMC5AWHelgbUqu5P+ph9c
         D894GYLTqnYLDHor15741Ctb5CEreNfIOLca+zKQ=
Date:   Fri, 5 Mar 2021 09:36:45 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Steve Dickson <SteveD@RedHat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/7 V4] The NFSv4 only mounting daemon.
Message-ID: <20210305143645.GA3813@fieldses.org>
References: <20210224203053.GF11591@fieldses.org>
 <1553fb2d-9b8e-f8eb-8c72-edcd14a2ad08@RedHat.com>
 <20210303152342.GA1282@fieldses.org>
 <376b6b0a-5679-4692-cfdb-b8c7919393a5@RedHat.com>
 <20210303215415.GE3949@fieldses.org>
 <d9e766cb-9af8-0c66-efb1-a3d0a291aa48@RedHat.com>
 <20210303221730.GH3949@fieldses.org>
 <80610f08-6f8d-1390-1875-068e63e744eb@RedHat.com>
 <20210304140617.GB17512@fieldses.org>
 <4204cd8e-f8c4-103e-bb69-a6bf720e65e9@RedHat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4204cd8e-f8c4-103e-bb69-a6bf720e65e9@RedHat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 04, 2021 at 11:31:53AM -0500, Steve Dickson wrote:
> 
> 
> On 3/4/21 9:06 AM, J. Bruce Fields wrote:
> > On Thu, Mar 04, 2021 at 08:57:28AM -0500, Steve Dickson wrote:
> >> Personally I see this is the first step away from V3... 
> >>
> >> So what we don't need is all that RPC code, all the different mounting
> >> versions... no RPC code at all,  which also means no need for libtirpc... 
> >> That is a lot of code that goes away, which I think is a good thing.
> > 
> > libtirpc is a shared library, it'll still be loaded as long as anyone
> > needs it, and I'm not convinced we'll be able to get rid of all users.
> > 
> >> I never thought it was a good idea to have mountd process
> >> the v4 upcalls... I always thought it should be a different
> >> deamon... and now we have one.
> >>
> >> A simple daemon that only processes v4 upcalls.
> > 
> > I really do get the appeal, I've always liked the idea too.
> > 
> > I'm not sure it's bringing us a real practical advantage at this point,
> > compared to rpc.mountd, which can act either as a daemon that only
> > processes v4 upcalls or can do both, depending on how you start it.
> Right with some configuration changes... But I do think there is 
> value with have a package that will work right out of the box!
> 
> Boom! Install the package and you have a working v4 server
> with no configure changes... I do think there is value there.

Installing rpms and enabling systemd units is also a form of
configuration.

So maybe it comes down to whether we'd rather configure a v4-only server
with:

	dnf install nfsv4-only-server
	systemctl enable nfsv4-server

vs.

	edit some stuff in /etc/nfs.conf

My preference is for the second, but it's just a feeling, I don't really
have an objective argument either way.  Anyone else?

--b.
