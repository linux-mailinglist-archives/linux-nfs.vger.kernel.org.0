Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403C24B2983
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Feb 2022 16:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345213AbiBKP7x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Feb 2022 10:59:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344108AbiBKP7v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Feb 2022 10:59:51 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603F31CF
        for <linux-nfs@vger.kernel.org>; Fri, 11 Feb 2022 07:59:50 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7898FBC3; Fri, 11 Feb 2022 10:59:49 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7898FBC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1644595189;
        bh=7S7MJdh4l+onksxIgdY0DmRBb7eYRS2JPKa2rr8vIZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cTfBl2YTiJNVLqj7QivhtH1Yqfzc7UqgZr/ktIXbIqIxZLzxMTTuyrS5BAlj9j09h
         tAsFTvoNL5Uv1gsgp0nlGvStGZc3Il7Xye0K/Qar9fRYLPiw+I7rITlI85Y2m6GGdO
         PFgLUxVWSJRUM5IjpIPsWiaSsVoyHKH1ecE4rSR0=
Date:   Fri, 11 Feb 2022 10:59:49 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Daire Byrne <daire@dneg.com>
Cc:     NeilBrown <neilb@suse.de>, Patrick Goetz <pgoetz@math.utexas.edu>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: parallel file create rates (+high latency)
Message-ID: <20220211155949.GA4941@fieldses.org>
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org>
 <adce2b72-ed5c-3056-313c-caea9bad4e15@math.utexas.edu>
 <20220125212055.GB17638@fieldses.org>
 <164315533676.5493.13243313269022942124@noble.neil.brown.name>
 <20220126025722.GD17638@fieldses.org>
 <CAPt2mGP2guMMf1C9VoQ0AvZ819jPuz0vDoEzJJhtL8q5DJ300A@mail.gmail.com>
 <CAPt2mGNXq==1KUskF3U6-CDeoX57=d7NW4Qn_esDqarf9bTBaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPt2mGNXq==1KUskF3U6-CDeoX57=d7NW4Qn_esDqarf9bTBaw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Feb 10, 2022 at 06:19:09PM +0000, Daire Byrne wrote:
> I had a quick attempt at updating Neil's patch for mainline but I
> quickly got stuck and confused. It looks like fs/namei.c in particular
> underwent major changes and refactoring from v5.7+.
> 
> If there is ever any interest in updating this and getting it into
> mainline, I'm more than willing to test it with production loads. I
> just lack the skills to update it myself.
> 
> It definitely solves a big problem for us, but I also suspect we may
> be the only ones with this problem.

It benefits anyone trying to do a lot of creates in a on an NFS
filesystem where the network round trip time is significant.  That
doesn't seem so weird.  And even if the case is a little weird, just
having a case and clear numbers to show the improvement is a big help.

I haven't had the chance to read Neil's patch or work out what the issue
with the namei changes.

Al Viro is the expert on VFS locking.  I was sure I'd seen him speculate
about what would be needed to make parallel directory modifications
possible, but I spent some time mining old mail and didn't find that.

I think the path forward would be to update Neil's patch, add your
performance data, send it to Al and linux-fsdevel, and see if we can get
some idea what remains to be done to get this right.

--b.

> 
> Cheers,
> 
> Daire
> 
> 
> On Tue, 8 Feb 2022 at 18:48, Daire Byrne <daire@dneg.com> wrote:
> >
> > On Wed, 26 Jan 2022 at 02:57, J. Bruce Fields <bfields@fieldses.org> wrote:
> > >
> > > On Wed, Jan 26, 2022 at 11:02:16AM +1100, NeilBrown wrote:
> > > > On Wed, 26 Jan 2022, J. Bruce Fields wrote:
> > > > > On Tue, Jan 25, 2022 at 03:15:42PM -0600, Patrick Goetz wrote:
> > > > > > So the directory is locked while the inode is created, or something
> > > > > > like this, which makes sense.
> > > > >
> > > > > It accomplishes a number of things, details in
> > > > > https://www.kernel.org/doc/html/latest/filesystems/directory-locking.html
> > > >
> > > > Just in case anyone is interested, I wrote this a while back:
> > > >
> > > > http://lists.lustre.org/pipermail/lustre-devel-lustre.org/2018-November/008177.html
> > > >
> > > > it includes a patch to allow parallel creates/deletes over NFS (and any
> > > > other filesystem which adds support).
> > > > I doubt it still applies, but it wouldn't be hard to make it work if
> > > > anyone was willing to make a strong case that we would benefit from
> > > > this.
> >
> > Well, I couldn't resist quickly testing Neil's patch. I found it
> > applied okay to v5.6.19 with minimal edits.
> >
> > As before, without the patch, parallel file creates in a single
> > directory with 1000 threads topped out at an aggregate of 3 creates/s
> > over a 200ms link. With the patch it jumps up to 1,200 creates/s.
> >
> > So a pretty dramatic difference. I can't say if there are any other
> > side effects or regressions as I only did this simple test.
> >
> > It's great for our super niche workloads and use case anyway.
> >
> > Daire
> >
> >
> > > Neato.
> > >
> > > Removing the need to hold an exclusive lock on the directory across
> > > server round trips seems compelling to me....
> > >
> > > I also wonder: why couldn't you fire off the RPC without any locks, then
> > > wait till you get a reply to take locks and update your local cache?
> > >
> > > OK, for one thing, calls and replies and server processing could all get
> > > reordered.  We'd need to know what order the server processed operations
> > > in, so we could process replies in the same order.
> > >
> > > --b.
