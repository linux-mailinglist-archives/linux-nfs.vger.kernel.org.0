Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D73C20256A
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jun 2020 18:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgFTQzI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 20 Jun 2020 12:55:08 -0400
Received: from fieldses.org ([173.255.197.46]:60846 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgFTQzI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 20 Jun 2020 12:55:08 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id E0BAA9235; Sat, 20 Jun 2020 12:55:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E0BAA9235
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1592672104;
        bh=SdZcLRfjSoAcF6fd71CZglK3+x1D6M3WFCrVO60D2YA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z+wyI4pOOXhnkQrugmFcrLHzJaqf76f652z467KxUjuuJ6sZDP1dSaDaVHnIPLIGf
         KvMxCjCcmk8FjTzcMUan0ufZDTC07oBbsO8AVvtAi/UnxRmvMJ5DgC13MxYCOIYHFP
         rY7medSbY70o4YMzAdMnu8FJev2PDrgulUoQplxQ=
Date:   Sat, 20 Jun 2020 12:55:04 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [GIT PULL] nfsd changes for 5.8
Message-ID: <20200620165504.GG1514@fieldses.org>
References: <20200611155743.GC16376@fieldses.org>
 <CAADWXX9tV_khCjrO5eUJQry+QV4VLatt21KEkJ8irEcuqTbBsQ@mail.gmail.com>
 <20200611181141.GD16376@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611181141.GD16376@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 11, 2020 at 02:11:41PM -0400, J. Bruce Fields wrote:
> On Thu, Jun 11, 2020 at 10:42:19AM -0700, Linus Torvalds wrote:
> > I'm not entirely sure why, but gmail hates you and marked this as spam.
> > 
> > I (obviously) caught it despite that, but thought I'd mention it. I
> > assume it's lack of DKIM for fieldses.org.
> 
> Twenty years ago running my own mail service sounded like a fun idea.
> 
> Nowadays it's just this thing that means that, every now and then, I
> have to drop everything and go learn about some random bit of annoying
> tech, just so I can get on with my work or talk to my friends.  Then
> I'll promptly forget it, until years later it breaks, and I have to go
> relearn it all from scratch.
> 
> Anyway, googling DKIM....

By the way, I think the real problem might have been Spamhaus SBLCSS
listing my Linode server's IPv6 address.  I followed the suggestion at:

	https://www.spamhaus.org/faq/section/Spamhaus%20CSS#426

and requested a new /64 from Linode, added an IP from the new /64 to my
main interface, and updated AAAA and reverse DNS records.

I also set up DKIM (mainly following instructions from README.fedora in
the opendkim package).  Reading up a little more suggested DMARC is a
bad idea for my case.

Anyway, hopefully things are better now.

--b.
