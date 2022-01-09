Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6046E488CE2
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Jan 2022 23:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiAIWiJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Jan 2022 17:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbiAIWiI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 Jan 2022 17:38:08 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885F8C06173F
        for <linux-nfs@vger.kernel.org>; Sun,  9 Jan 2022 14:38:08 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 66613BC3; Sun,  9 Jan 2022 17:38:07 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 66613BC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641767887;
        bh=TkTtCFPFQFLtORRTYZjF3Q0vnaNZSO0pC7A3x3lKRxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MhmAoeRUt1lhnVCLl3bwOx2tmfxsoGWcP8sO47+PY+ae5nccvz1dGvhfQaV73JLOj
         IwQ+SFNdrizx+IhEmJWHrzwpuia2LztyVgVVVR3sQJ7WXEEIkd5KtHmGSq5XQ8eYNc
         QowwBPmI92aBBikoAyNF4KGW7GDLKBxDQuhH2lXM=
Date:   Sun, 9 Jan 2022 17:38:07 -0500
From:   "'bfields@fieldses.org'" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>,
        'Trond Myklebust' <trondmy@hammerspace.com>,
        "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>,
        "'mbenjami@redhat.com'" <mbenjami@redhat.com>
Subject: Re: client caching and locks
Message-ID: <20220109223807.GB1589@fieldses.org>
References: <20201006172607.GA32640@fieldses.org>
 <164066831190.25899.16641224253864656420@noble.neil.brown.name>
 <20220103162041.GC21514@fieldses.org>
 <03e4cc01e9e66e523474c10846ee22147b78addf.camel@hammerspace.com>
 <20220104153205.GA7815@fieldses.org>
 <1257915fc5fd768e6c1c70fd3e8e3ed3fa1dc33e.camel@hammerspace.com>
 <20220105220353.GF25384@fieldses.org>
 <20220106141628.GA7105@fieldses.org>
 <164176658189.25899.1767614988647740830@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164176658189.25899.1767614988647740830@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 10, 2022 at 09:16:21AM +1100, NeilBrown wrote:
> On Fri, 07 Jan 2022, 'bfields@fieldses.org' wrote:
> > On Thu, Jan 06, 2022 at 07:23:16AM +0000, inoguchi.yuki@fujitsu.com wrote:
> > > > How about this?  I also updated the lock/nolock description and deleted
> > > > the end of this subsection since it's redundant with that. And removed
> > > > the bit about using nolock to mount /var with v2/v3 as that seems like a
> > > > bit of a niche case at this point.  If we still want to document that, I
> > > > think it belongs elsewhere.
> > > 
> > > Thank you so much for creating the patch!
> > > 
> > > For the most part I agree with you, but I feel unsafe to remove the part 
> > > "using nolock to mount /var with v2/v3" even if it seems niche case. 
> > > I'm also not sure if there is another suitable document to migrate it. 
> > > 
> > > Therefore, at the end of "lock/nolock" subsection ...
> > 
> > I could live with that.
> > 
> > Though the other reason I cut it was because I think it needs updates
> > too and I wasn't sure exactly how to handle them.
> > 
> > The v4 case is more important and should probably be dealt with first.
> > I think the answer there is just "don't mount /var over NFSv4", period.
> 
> Why not? An NFSv4 client has no business accessing anything in
> /var/lib/nfs, so how can it cause a problem?

Oops, you're right.

> > And maybe we should be more specific: the problem is with /var/lib/nfs,
> > not all of /var.
> 
> According to "3.2. CLIENT STARTUP" section "C/" in the README that comes
> with nfs-utils,
>       statd should be run before any NFSv2 or NFSv3 filesystem is
>       mounted with remote locking (i.e. without -o nolock).
> 
> so it is only fair to say "the problem is with /var/lib/nfs" if that is
> a separate filesystem from /var.
> 
> Note that "-o nolock" should also be used for the root filesystem for
> root-over-NFSv3, as that must be mounted before statd can be running.
> 
> Maybe that it how it should be explained in the man page:
> 
>   -o nolock should be used to mount any NFSv3 filesystems that are
>    mounted before rpc.statd can be started, which can only be started
>    after /var/lib/nfs is available.

Thanks.  I fiddled around some more and ended up with the following.--b.

@@ -737,6 +737,10 @@ The
 .B nolock
 option is required when using NFSv2 or NFSv3 to mount servers
 that do not support the NLM protocol.
+Also, /var/lib/nfs must be available before rpc.statd can be started,
+and NFSv3 locking requires rpc.statd, so if any NFSv3 filesystems are
+needed to reach /var/lib/nfs, they must be mounted with
+.B nolock .
 .TP 1.5i
 .BR cto " / " nocto
 Selects whether to use close-to-open cache coherence semantics.

