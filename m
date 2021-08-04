Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721203DF930
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Aug 2021 03:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhHDBQj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Aug 2021 21:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbhHDBQj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Aug 2021 21:16:39 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D06FC06175F
        for <linux-nfs@vger.kernel.org>; Tue,  3 Aug 2021 18:16:27 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 99DFD50EC; Tue,  3 Aug 2021 21:16:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 99DFD50EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1628039786;
        bh=aj+RtSka8qq6Q/sZbs4Nh7uTzjeeRlThX20vwezmEHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilBVMt6ETeqmwAo4gX4w4k4xVYkViu6qqJfhHGznmZkukrWHxsOI12yYGKYJpmTSm
         BNfP5L5DTSTSyw8WAy6r7hwCo2/DQeamI25oFVC4qg+dx98VY8PMTQ3sDv7AFsLrlM
         TDzyUeB+vfFiKDkM6anVGH6eLLzthxl4jGp1KIGc=
Date:   Tue, 3 Aug 2021 21:16:26 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "neilb@suse.de" <neilb@suse.de>,
        "plambri@redhat.com" <plambri@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: cto changes for v4 atomic open
Message-ID: <20210804011626.GA19848@fieldses.org>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>
 <20210803203051.GA3043@fieldses.org>
 <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>
 <20210803213642.GA4042@fieldses.org>
 <a1934e03e68ada8b7d1abf1744ad1b8f9d784aa4.camel@hammerspace.com>
 <162803443497.32159.4120609262211305187@noble.neil.brown.name>
 <08db3d70a6a4799a7f3a6f5227335403f5a148dd.camel@hammerspace.com>
 <162803867150.32159.9013174090922030713@noble.neil.brown.name>
 <ea79c8676bea627bb78c57e33199229e3cf27a9c.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea79c8676bea627bb78c57e33199229e3cf27a9c.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 04, 2021 at 01:03:58AM +0000, Trond Myklebust wrote:
> On Wed, 2021-08-04 at 10:57 +1000, NeilBrown wrote:
> > On Wed, 04 Aug 2021, Trond Myklebust wrote:
> > > 
> > > No. What you propose is to optimise for a fringe case, which we
> > > cannot
> > > guarantee will work anyway. I'd much rather optimise for the common
> > > case, which is the only case with predictable semantics.
> > > 
> > 
> > "predictable"??
> > 
> > As I understand it (I haven't examined the code) the current
> > semantics
> > includes:
> >  If a file is open for read, some other client changed the file, and
> > the
> >   file is then opened, then the second open might see new data, or
> > might
> >   see old data, depending on whether the requested data is still in
> >   cache or not.
> > 
> > I find this to be less predictable than the easy-to-understand
> > semantics
> > that Bruce has quoted:
> >   - revalidate on every open, flush on every close
> > 
> > I'm suggesting we optimize for fringe cases, I'm suggesting we
> > provide
> > semantics that are simple, documentated, and predictable.
> > 
> 
> "Predictable" how?
> 
> This is cached I/O. By definition, it is allowed to do things like
> readahead, writeback caching, metadata caching. What you're proposing
> is to optimise for a case that breaks all of the above. What's the
> point? We might just as well throw in the towel and just make uncached
> I/O and 'noac' mounts the default.

It's possible to revalidate on every open and also still do readahead,
writeback caching, and metadata caching.

--b.
