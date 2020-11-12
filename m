Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF972B071B
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 14:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgKLN5f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 08:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbgKLN5f (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 08:57:35 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36270C0613D1
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 05:57:35 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id A3E73410D; Thu, 12 Nov 2020 08:57:33 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A3E73410D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1605189453;
        bh=C0G8W3edyMw4zrwLW8NGGe87U733pwzKt8Am9YWTxBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jGk92S8xlVAE/1oBljBlvnu0auwMA03Tb5R2klSbAxdywbJy1T3x2ay2FKWBqIxve
         eBY/KvN6BJHspkAPyENHr5Ilmrgy4LH40Ajf05EBICSQgms7lbDhZs4ndxN2mfHND9
         gLrJEpVNcArcAEvj0oU4ZnBdo/RMF3cUEPzlNk6A=
Date:   Thu, 12 Nov 2020 08:57:33 -0500
From:   bfields <bfields@fieldses.org>
To:     Daire Byrne <daire@dneg.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: Adventures in NFS re-exporting
Message-ID: <20201112135733.GA9243@fieldses.org>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
 <20200915172140.GA32632@fieldses.org>
 <4d1d7cd0076d98973a56e89c92e4ff0474aa0e14.camel@hammerspace.com>
 <1188023047.38703514.1600272094778.JavaMail.zimbra@dneg.com>
 <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>
 <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com>
 <20201109160256.GB11144@fieldses.org>
 <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 12, 2020 at 01:01:24PM +0000, Daire Byrne wrote:
> 
> ----- On 9 Nov, 2020, at 16:02, bfields bfields@fieldses.org wrote:
> > On Wed, Oct 21, 2020 at 10:33:52AM +0100, Daire Byrne wrote:
> >> Trond has posted some (v3) patches to emulate lookupp for NFSv3 (a million
> >> thanks!) so I applied them to v5.9.1 and ran some more tests using that on the
> >> re-export server. Again, I just pathologically dropped inode & dentry caches
> >> every second on the re-export server (vfs_cache_pressure=100) while a client
> >> looped through some application loading tests.
> >> 
> >> Now for every combination of re-export (NFSv3 -> NFSv4.x or NFSv4.x -> NFSv3), I
> >> no longer see any stale file handles (/proc/net/rpc/nfsd) when dropping inode &
> >> dentry caches (yay!).
> >> 
> >> However, my assumption that some of the input/output errors I was seeing were
> >> related to the estales seems to have been misguided. After running these tests
> >> again without any estales, it now looks like a different issue that is unique
> >> to re-exporting NFSv3 from an NFSv4.0 originating server (either Linux or
> >> Netapp). The lookups are all fine (no estale) but reading some files eventually
> >> gives an input/output error on multiple clients which remain consistent until
> >> the re-export nfs-server is restarted. Again, this only occurs while dropping
> >> inode + dentry caches.
> >> 
> >> So in summary, while continuously dropping inode/dentry caches on the re-export
> >> server:
> > 
> > How continuously, exactly?
> > 
> > I recall that there are some situations where the best the client can do
> > to handle an ESTALE is just retry.  And that our code generally just
> > retries once and then gives up.
> > 
> > I wonder if it's possible that the client or re-export server can get
> > stuck in a situation where they can't guarantee forward progress in the
> > face of repeated ESTALEs.  I don't have a specific case in mind, though.
> 
> I was dropping caches every second in a loop on the NFS re-export server. Meanwhile a large python application that takes ~15 seconds to complete was also looping on a client of the re-export server. So we are clearing out the cache many times such that the same python paths are being re-populated many times.
> 
> Having just completed a bunch of fresh cloud rendering with v5.9.1 and Trond's NFSv3 lookupp emulation patches, I can now revise my original list of issues that others will likely experience if they ever try to do this craziness:
> 
> 1) Don't re-export NFSv4.0 unless you set vfs_cache_presure=0 otherwise you will see random input/output errors on your clients when things are dropped out of the cache. In the end we gave up on using NFSv4.0 with our Netapps because the 7-mode implementation seemed a bit flakey with modern Linux clients (Linux NFSv4.2 servers on the other hand have been rock solid). We now use NFSv3 with Trond's lookupp emulation patches instead.

So,

		NFSv4.2			  NFSv4.2
	client --------> re-export server -------> original server

works as long as both servers are recent Linux, but when the original
server is Netapp, you need the protocol used in both places to be v3, is
that right?

> 2) In order to better utilise the re-export server's client cache when re-exporting an NFSv3 server (using either NFSv3 or NFSv4), we still need to use the horrible inode_peek_iversion_raw hack to maintain good metadata performance for large numbers of clients. Otherwise each re-export server's clients can cause invalidation of the re-export server client cache. Once you have hundreds of clients they all combine to constantly invalidate the cache resulting in an order of magnitude slower metadata performance. If you are re-exporting an NFSv4.x server (with either NFSv3 or NFSv4.x) this hack is not required.

Have we figured out why that's required, or found a longer-term
solution?  (Apologies, the memory of the earlier conversation is
fading....)

--b.
