Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822072BC2CE
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Nov 2020 01:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgKVACT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Nov 2020 19:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgKVACT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Nov 2020 19:02:19 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2306C0613CF
        for <linux-nfs@vger.kernel.org>; Sat, 21 Nov 2020 16:02:18 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id ACC146E9D; Sat, 21 Nov 2020 19:02:16 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org ACC146E9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606003336;
        bh=kWiXqsqeeKzuPgJ9oSmEHy6qJ3vVeCE9G6JG2XvAEcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jfh63sDn1EXARSSRVaTExaxnub3oSs4zE40opNkYx/XWm9kAMn2mp8XVr1SDePhXE
         BDrhDH64yIZktuj9Q4uIU21X9DKF2DGQ3PsaOGZYkBE4BuX7wyRxits/Cj9tKIqHkc
         h+ZCc0hKwobvx3vhVAverFqtsJ288J41MTkTGZFQ=
Date:   Sat, 21 Nov 2020 19:02:16 -0500
From:   bfields <bfields@fieldses.org>
To:     Daire Byrne <daire@dneg.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/4] nfsd: pre/post attr is using wrong change attribute
Message-ID: <20201122000216.GE3476@fieldses.org>
References: <20201117031601.GB10526@fieldses.org>
 <1605583086-19869-2-git-send-email-bfields@redhat.com>
 <a5704a8f7a6ebdfa60d4fa996a4d9ebaacc7daaf.camel@kernel.org>
 <20201117152636.GC4556@fieldses.org>
 <725499c144317aac1a03f0334a22005588dbdefc.camel@kernel.org>
 <20201120223831.GB7705@fieldses.org>
 <20201120224438.GC7705@fieldses.org>
 <5f8e9e0cb53c89a7d1c156a6799c6dbc6db96dae.camel@kernel.org>
 <1758069641.91412432.1605995069116.JavaMail.zimbra@dneg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758069641.91412432.1605995069116.JavaMail.zimbra@dneg.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Nov 21, 2020 at 09:44:29PM +0000, Daire Byrne wrote:
> ----- On 21 Nov, 2020, at 01:03, Jeff Layton jlayton@kernel.org wrote:
> > On Fri, 2020-11-20 at 17:44 -0500, J. Bruce Fields wrote:
> >> On Fri, Nov 20, 2020 at 05:38:31PM -0500, J. Bruce Fields wrote:
> >> > I think the first one's all that's needed to fix the problem Daire
> >> > identified.  I'm a little less sure of the rest.
> 
> I can confirm that patch 1/8 alone does indeed address the reported revalidation issue for us (as did the previous patch). The re-export server's client cache seems to remain intact and can serve the same cached results to multiple clients.

Thanks again for the testing.

> I should also mention that I still see a lot of unexpected repeat
> lookups even with the iversion optimisation patches with certain
> workloads. For example, looking at a network capture on the re-export
> server I might see 100s of getattr calls to the originating server for
> the same filehandle within 30 seconds which I would have expected the
> client cache to serve. But it could also be that the client cache is
> under memory pressure and not holding that data for very long.

That sounds weird.  Is the filehandle for a file or a directory?  Is the
file or directory actually changing at the time, and if so, is it the
client that's changing it?

Remind me what the setup is--a v3 re-export of a v4 mount?

--b.

> But now I do wonder if these NFSv4 directory modifications and
> pre/post change attributes could be one potential contributor? I might
> run some production loads with a v3 re-export of a v3 server to see if
> that changes anything.
> 
> Many thanks again for the patches, I will take the entire set and run
> them through our production re-export workloads to see if anything
> shakes out.
> 
> Daire
