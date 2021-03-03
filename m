Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EEB32C6C3
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390403AbhCDA36 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390852AbhCCWSU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 17:18:20 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25A3C061763
        for <linux-nfs@vger.kernel.org>; Wed,  3 Mar 2021 14:17:31 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id C2FA314DA; Wed,  3 Mar 2021 17:17:30 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C2FA314DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614809850;
        bh=wrjWbDbm8dlp2t9pxdizr6viK8kIKbtojDk9QDYKnKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YfW4QQ3Dy7WDkijQajERTmDxJyt6RPx4MmSxZ2+uCvaQoYr1BZGl5EeUxg3xTT4M8
         5iZCqDBSdUCFWG9lmAgPz2ucPzQUPsFU1htfMxGglhatL3hfEZsbGijU0Q9BtBs9ek
         M0ICoe9UFjI7gnew6L/PCYRbg1GqXzmPpZ+mSbfo=
Date:   Wed, 3 Mar 2021 17:17:30 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Steve Dickson <SteveD@RedHat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/7 V4] The NFSv4 only mounting daemon.
Message-ID: <20210303221730.GH3949@fieldses.org>
References: <20210219200815.792667-1-steved@redhat.com>
 <20210224203053.GF11591@fieldses.org>
 <1553fb2d-9b8e-f8eb-8c72-edcd14a2ad08@RedHat.com>
 <20210303152342.GA1282@fieldses.org>
 <376b6b0a-5679-4692-cfdb-b8c7919393a5@RedHat.com>
 <20210303215415.GE3949@fieldses.org>
 <d9e766cb-9af8-0c66-efb1-a3d0a291aa48@RedHat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9e766cb-9af8-0c66-efb1-a3d0a291aa48@RedHat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 03, 2021 at 05:07:56PM -0500, Steve Dickson wrote:
> 
> 
> On 3/3/21 4:54 PM, J. Bruce Fields wrote:
> > On Wed, Mar 03, 2021 at 04:22:28PM -0500, Steve Dickson wrote:
> >> Hey!
> >>
> >> On 3/3/21 10:23 AM, J. Bruce Fields wrote:
> >>> On Tue, Mar 02, 2021 at 05:33:23PM -0500, Steve Dickson wrote:
> >>>>
> >>>>
> >>>> On 2/24/21 3:30 PM, J. Bruce Fields wrote:
> >>>>> On Fri, Feb 19, 2021 at 03:08:08PM -0500, Steve Dickson wrote:
> >>>>>> nfsv4.exportd is a daemon that will listen for only v4 mount upcalls.
> >>>>>> The idea is to allow distros to build a v4 only package
> >>>>>> which will have a much smaller footprint than the
> >>>>>> entire nfs-utils package.
> >>>>>>
> >>>>>> exportd uses no RPC code, which means none of the 
> >>>>>> code or arguments that deal with v3 was ported, 
> >>>>>> this again, makes the footprint much smaller. 
> >>>>>
> >>>>> How much smaller?
> >>>> Will a bit smaller... but a number of daemons like nfsd[cld,clddb,cldnts]
> >>>> need to also come a long. 
> >>>
> >>> Could we get some numbers?
> >>>
> >>> Looks like nfs-utils in F33 is about 1.2M:
> >>>
> >>> $ rpm -qi nfs-utils|grep ^Size
> >>> Size        : 1243512
> >>>
> >>> $ strip utils/mountd/mountd
> >>> $ ls -lh utils/mountd/mountd
> >>> -rwxrwxr-x. 1 bfields bfields 128K Mar  3 10:12 utils/mountd/mountd
> >>> $ strip utils/exportd/exportd
> >>> $ ls -lh utils/exportd/exportd
> >>> -rwxrwxr-x. 1 bfields bfields 106K Mar  3 10:12 utils/exportd/exportd
> >>>
> >>> So replacing mountd by exportd saves us about 20K out of 1.2M.  Is it
> >>> worth it?
> >> In smaller foot print I guess I meant no v3 daemons, esp rpcbind. 
> > 
> > The rpcbind rpm is 120K installed, so if the new v4-only rpm has no
> > dependency on rpcbind then we save 120K.
> I believe it is more of a functionally thing than a size thing
> WRT to containers. 

OK.  But if it's not about size, then we can use "rpc.mountd -N2 -N3",
we don't need a separate daemon.

--b.
