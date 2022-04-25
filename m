Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4242E50E182
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Apr 2022 15:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242004AbiDYNZr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Apr 2022 09:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241993AbiDYNZn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Apr 2022 09:25:43 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C83366A2
        for <linux-nfs@vger.kernel.org>; Mon, 25 Apr 2022 06:22:33 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9571B6801; Mon, 25 Apr 2022 09:22:32 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9571B6801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1650892952;
        bh=roKnXHrl6Kvns7HBwZTmsw7rJ2jxtvyuWV1qLI29uCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uLIMvoG0kjm0ScmFclKEgWKXvRt3KAPlzZu0arbJKk1Ln9YT1t8U8HS7E8c4z1keQ
         B3psPV9R5fxgOwwDJsYqZ26OaoYN4ZejxwP5WBopc1CQJ6u58BzAB3b/go0GkZ8gvz
         XSh/qKiQYJEcA6cVX5olb7S0/wHWRbh8oaEiMQ5I=
Date:   Mon, 25 Apr 2022 09:22:32 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Daire Byrne <daire@dneg.com>
Cc:     NeilBrown <neilb@suse.de>, Patrick Goetz <pgoetz@math.utexas.edu>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: parallel file create rates (+high latency)
Message-ID: <20220425132232.GA24825@fieldses.org>
References: <20220125212055.GB17638@fieldses.org>
 <164315533676.5493.13243313269022942124@noble.neil.brown.name>
 <20220126025722.GD17638@fieldses.org>
 <CAPt2mGP2guMMf1C9VoQ0AvZ819jPuz0vDoEzJJhtL8q5DJ300A@mail.gmail.com>
 <CAPt2mGNXq==1KUskF3U6-CDeoX57=d7NW4Qn_esDqarf9bTBaw@mail.gmail.com>
 <20220211155949.GA4941@fieldses.org>
 <CAPt2mGOx0qNTWoY9vmyVBtZ3gxdbv5qQ-2qVbtqWW9FiZFRhEg@mail.gmail.com>
 <164517040900.10228.8956772146017892417@noble.neil.brown.name>
 <CAPt2mGMLQCEPqsYGeaMd3BPGRne4F4h-2-pzqm1a8nwfKqv1ug@mail.gmail.com>
 <CAPt2mGMt3Sq66qmPBeGYE0CASTTy7nY2K_LjQK6VZx-uz2P-wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPt2mGMt3Sq66qmPBeGYE0CASTTy7nY2K_LjQK6VZx-uz2P-wg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Apr 25, 2022 at 02:00:32PM +0100, Daire Byrne wrote:
> On Mon, 21 Feb 2022 at 13:59, Daire Byrne <daire@dneg.com> wrote:
> >
> > On Fri, 18 Feb 2022 at 07:46, NeilBrown <neilb@suse.de> wrote:
> > > I've ported it to mainline without much trouble.  I started some simple
> > > testing (parallel create/delete of the same file) and hit a bug quite
> > > easily.  I fixed that (eventually) and then tried with more than 1 CPU,
> > > and hit another bug.  But then it was quitting time.  If I can get rid
> > > of all the easy to find bugs, I'll post it with a CC to you, and you can
> > > find some more for me!
> >
> > That would be awesome! I have a real world production case for this
> > and it's a pretty heavy workload. If that doesn't shake out any bugs,
> > nothing will.
> >
> > The only caveat being that it will likely be restricted to NFSv3
> > testing due to the concurrency limitations with NFSv4.1+ (from the
> > other thread).
> >
> > Daire
> 
> Just to follow up on this again - I have been using Neil's patch for
> parallel file creates (thanks!) but I'm a bit confused as to why it
> doesn't seem to help in my NFS re-export case.
> 
> With the patch, I can achieve much higher parallel (multi process)
> creates directly on my re-export server to a high latency remote
> server mount, but when I re-export that to multiple clients, the
> aggregate create rate again degrades to that which we might expect
> either without the patch or if there was only one process creating the
> files in sequence.
> 
> My assumption was that the nfsd threads of the re-export server would
> act as multiple independent processes and it's clients would be spread
> across them such that they would also benefit from the parallel
> creates patch on the re-export server. So I expected many clients
> creating files in the same directory would achieve much higher
> aggregate performance.

That's the idea.

I've lost track, where's the latest version of Neil's patch?

--b.

> 
> Am I missing some other interaction here that limits parallel
> performance in my unusual re-export case?
> 
> Cheers,
> 
> Daire
