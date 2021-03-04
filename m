Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F8A32D53E
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 15:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhCDOZz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Mar 2021 09:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhCDOZb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Mar 2021 09:25:31 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2860C061574
        for <linux-nfs@vger.kernel.org>; Thu,  4 Mar 2021 06:24:51 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id F31D923D8; Thu,  4 Mar 2021 09:24:50 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org F31D923D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614867891;
        bh=Mus/7Tr4KkiWl5LRoHCUIHfDcudMpPDEvC/nzzsK8kk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0A+7ecwulsqn5wR/jHX37xfHS4Di4KKZm1ZHaZft1gfMY82ZmXRP6ssQv27oy5EHp
         QWZ6qoSAA+qUoGPEbVIHt7FQk7c8sApobiFH/KYtNLljq42bpDrJaouQ8oytDXxJ1j
         zg/ysOg9Q2Q+ujWqGql6o3vQbemGHxpQmzRKQDmc=
Date:   Thu, 4 Mar 2021 09:24:50 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Steve Dickson <SteveD@RedHat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/7 V4] The NFSv4 only mounting daemon.
Message-ID: <20210304142450.GC17512@fieldses.org>
References: <20210219200815.792667-1-steved@redhat.com>
 <20210224203053.GF11591@fieldses.org>
 <1553fb2d-9b8e-f8eb-8c72-edcd14a2ad08@RedHat.com>
 <20210303152342.GA1282@fieldses.org>
 <fce1f95d-a4a5-88a8-3768-c81f7c09f193@RedHat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fce1f95d-a4a5-88a8-3768-c81f7c09f193@RedHat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 04, 2021 at 08:34:45AM -0500, Steve Dickson wrote:
> 
> 
> On 3/3/21 10:23 AM, J. Bruce Fields wrote:
> > On Tue, Mar 02, 2021 at 05:33:23PM -0500, Steve Dickson wrote:
> >>
> >>
> >> On 2/24/21 3:30 PM, J. Bruce Fields wrote:
> >>> On Fri, Feb 19, 2021 at 03:08:08PM -0500, Steve Dickson wrote:
> >>>> nfsv4.exportd is a daemon that will listen for only v4 mount upcalls.
> >>>> The idea is to allow distros to build a v4 only package
> >>>> which will have a much smaller footprint than the
> >>>> entire nfs-utils package.
> >>>>
> >>>> exportd uses no RPC code, which means none of the 
> >>>> code or arguments that deal with v3 was ported, 
> >>>> this again, makes the footprint much smaller. 
> >>>
> >>> How much smaller?
> >> Will a bit smaller... but a number of daemons like nfsd[cld,clddb,cldnts]
> >> need to also come a long. 
> > 
> > Could we get some numbers?
> > 
> > Looks like nfs-utils in F33 is about 1.2M:
> > 
> > $ rpm -qi nfs-utils|grep ^Size
> > Size        : 1243512
> Here are the numbers. Remember things are still in development so
> these may not be the final numbers
> 
> For the v4 only client
> rpm -qi nfsv4-client-utils-2* | grep ^Size
> Size        : 374573
> 
> for the v4only server:
> rpm -qi nfsv4-utils-2* | grep ^Size
> Size        : 942088

$ rpm -qi nfs-utils|grep ^Size
Size        : 1243512
$ echo $((374573+942088))
1316661

So, they're a little bigger than nfs-utils, taken together.  Like you
say, under development, probably there's just something overlooked that
could be removed from one or the other or moved to an nfs-common
package.

That might make a case for splitting up client and server sides for
minimal installs that need only one or the other.

If it's installed size we're working on, though, do we have some target
in mind here, though?  Do we know what the container people are aiming
for?  I had some idea glic is more in the 10s of megabytes, and a
minimal Fedora install is in the 100s, so I just wonder if it's worth
chasing after 10s-100s of K.

--b.
