Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297D9224071
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jul 2020 18:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgGQQSP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jul 2020 12:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgGQQSO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jul 2020 12:18:14 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3403C0619D2
        for <linux-nfs@vger.kernel.org>; Fri, 17 Jul 2020 09:18:14 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E59719C61; Fri, 17 Jul 2020 12:18:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E59719C61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1595002693;
        bh=tYhnQxHtVXZsch71emoSMhHHLHfImF5QSXERd/ZhMhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vljbNF6piztK/mcyr+p3iJjrcNxN04UBI+3KDuZfhaQEZtHJXcBYtHMrJesVuszWu
         l7gmDsSyxecuHg66EWTpTUqqPeYbvpx/Jjzafk53+Fnr29G+yC4wdIRak/04TY4nJu
         Jj8oR2rot3jE2BNSydor+w9Qn+dlnfdcyR4EUguo=
Date:   Fri, 17 Jul 2020 12:18:13 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Dave Wysochanski <dwysocha@redhat.com>, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: [Linux-cachefs] [RFC PATCH v1 0/13] Convert NFS client to new
 fscache-iter API
Message-ID: <20200717161813.GB21567@fieldses.org>
References: <20200717142541.GA21567@fieldses.org>
 <1594825849-24991-1-git-send-email-dwysocha@redhat.com>
 <3607831.1594999165@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3607831.1594999165@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jul 17, 2020 at 04:19:25PM +0100, David Howells wrote:
> J. Bruce Fields <bfields@fieldses.org> wrote:
> 
> > Say I had a hypothetical, err, friend, who hadn't been following that
> > FS-Cache work--could you summarize the advantages it bring us?
> 
> https://lore.kernel.org/linux-nfs/159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk/T/#t
> 
>  - Makes the caching code a lot simpler (~2400 LoC removed, ~1000 LoDoc[*]
>    removed at the moment from fscache, cachefiles and afs).
> 
>  - Stops using bmap to work out what data is cached.  This isn't reliable with
>    modern extend-based filesystems.  A bitmap of cached granules is saved in
>    an xattr instead.
> 
>  - Uses async DIO (kiocbs) to do I/O to/from the cache rather than using
>    buffered writes (kernel_write) and pagecache snooping for read (don't ask).
> 
>    - A lot faster and less CPU intensive as there's no page-to-page copying.
> 
>    - A lot less VM pressure as it doesn't have duplicate pages in the backing
>      fs that aren't really accounted right.
> 
>  - Uses tmpfiles+link to better handle invalidation.  It will at some point
>    hopefully employ linkat(AT_LINK_REPLACE) to effect cut-over on disk rather
>    than unlink,link.

Thanks!--b.

> David
> 
> [*] The upstream docs got ReSTified, so the doc patches I have are now useless
>     and need reworking:-(.
