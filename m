Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1684B1522
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Feb 2022 19:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245623AbiBJSTr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Feb 2022 13:19:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245646AbiBJSTq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Feb 2022 13:19:46 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8BF218E
        for <linux-nfs@vger.kernel.org>; Thu, 10 Feb 2022 10:19:46 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id y3so17442345ejf.2
        for <linux-nfs@vger.kernel.org>; Thu, 10 Feb 2022 10:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mAsQykUvXxBdEw/FG6ajVcX5jBKhgpoBWJgKD0ppErw=;
        b=MT+r6Fb9qxJQpdSMDuCceyydbvSitX6qVn1UE6QBKMfAbMiP+dvyN6Uy35J6FYO6hW
         k2aAembePBF5NKaADkf0lpvDl1li5QnInx65zLspVGE8Tudi4DrFCEmSHOI4mVY9G6mA
         canfkdp1jRf7ysn4yaPjtdFgW6j56/vEcIcW9G9X9V56NtReQKxheDwhhBuFfYn+v4k8
         qtlh5NYwGWVn1+D3NFcA2g5mcuK+3t0/oZ9eBbEIVj86M+M4aP4hGSZJ8cpgYt9Maoam
         cKR2IP5qVm3Sq2VA6aT+wMZRO7X02VworqYmbE3YSyWF/j2/YBfEWvPyMRz8r5Hhmerl
         6PgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAsQykUvXxBdEw/FG6ajVcX5jBKhgpoBWJgKD0ppErw=;
        b=vxD3BTcXAMOc8fdmD+NTveE9lOFBIuY5pjBjgXi4nmVwq/gqK+hd8sRg4ZWepua3ew
         W8u3kmUvqx97Kdaty01KvmbzN51S1XvwOPWfy5x8af77a5vOfaXmv0T7vboox6poQBL/
         SSlrtp3V7ROfRksT9YSE5w9957cCGfvlugUxpD0wdfWrkNpqtWDDCVL+260X9zrMU/Ui
         5ZywOZEQMU2TVrmVkOlM6cNDM7gJm+/30CBOFVWS7Vr4lk3Da1Hu2hi++mJUINNVGeRl
         qWJzfRHnggpND0upUvVyz4XMg+DlYbPoZx6J0a7yoWfuCx8i9hhnWeeYPpgIIEyWu+X9
         MTeQ==
X-Gm-Message-State: AOAM530ApY2I3TdhsMcwGMg4a9zPvEJ1o9CfJL2b/HGyHzfZVg9WYxV3
        gr3fWd5W7NTMiULPjTafe/iHn6GGEYM1xdA6bsdf3aOruiyU0oSk
X-Google-Smtp-Source: ABdhPJwOjCZg7JPn9x4GVl6BB3D8DH2k3jLHwAappeLJnS013rbP1TsdVDez/PTIX4gSl9DGBRcjFYNEk7Hh96CyUrw=
X-Received: by 2002:a17:906:81b:: with SMTP id e27mr7579525ejd.142.1644517185323;
 Thu, 10 Feb 2022 10:19:45 -0800 (PST)
MIME-Version: 1.0
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org> <adce2b72-ed5c-3056-313c-caea9bad4e15@math.utexas.edu>
 <20220125212055.GB17638@fieldses.org> <164315533676.5493.13243313269022942124@noble.neil.brown.name>
 <20220126025722.GD17638@fieldses.org> <CAPt2mGP2guMMf1C9VoQ0AvZ819jPuz0vDoEzJJhtL8q5DJ300A@mail.gmail.com>
In-Reply-To: <CAPt2mGP2guMMf1C9VoQ0AvZ819jPuz0vDoEzJJhtL8q5DJ300A@mail.gmail.com>
From:   Daire Byrne <daire@dneg.com>
Date:   Thu, 10 Feb 2022 18:19:09 +0000
Message-ID: <CAPt2mGNXq==1KUskF3U6-CDeoX57=d7NW4Qn_esDqarf9bTBaw@mail.gmail.com>
Subject: Re: parallel file create rates (+high latency)
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     NeilBrown <neilb@suse.de>, Patrick Goetz <pgoetz@math.utexas.edu>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I had a quick attempt at updating Neil's patch for mainline but I
quickly got stuck and confused. It looks like fs/namei.c in particular
underwent major changes and refactoring from v5.7+.

If there is ever any interest in updating this and getting it into
mainline, I'm more than willing to test it with production loads. I
just lack the skills to update it myself.

It definitely solves a big problem for us, but I also suspect we may
be the only ones with this problem.

Cheers,

Daire


On Tue, 8 Feb 2022 at 18:48, Daire Byrne <daire@dneg.com> wrote:
>
> On Wed, 26 Jan 2022 at 02:57, J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Wed, Jan 26, 2022 at 11:02:16AM +1100, NeilBrown wrote:
> > > On Wed, 26 Jan 2022, J. Bruce Fields wrote:
> > > > On Tue, Jan 25, 2022 at 03:15:42PM -0600, Patrick Goetz wrote:
> > > > > So the directory is locked while the inode is created, or something
> > > > > like this, which makes sense.
> > > >
> > > > It accomplishes a number of things, details in
> > > > https://www.kernel.org/doc/html/latest/filesystems/directory-locking.html
> > >
> > > Just in case anyone is interested, I wrote this a while back:
> > >
> > > http://lists.lustre.org/pipermail/lustre-devel-lustre.org/2018-November/008177.html
> > >
> > > it includes a patch to allow parallel creates/deletes over NFS (and any
> > > other filesystem which adds support).
> > > I doubt it still applies, but it wouldn't be hard to make it work if
> > > anyone was willing to make a strong case that we would benefit from
> > > this.
>
> Well, I couldn't resist quickly testing Neil's patch. I found it
> applied okay to v5.6.19 with minimal edits.
>
> As before, without the patch, parallel file creates in a single
> directory with 1000 threads topped out at an aggregate of 3 creates/s
> over a 200ms link. With the patch it jumps up to 1,200 creates/s.
>
> So a pretty dramatic difference. I can't say if there are any other
> side effects or regressions as I only did this simple test.
>
> It's great for our super niche workloads and use case anyway.
>
> Daire
>
>
> > Neato.
> >
> > Removing the need to hold an exclusive lock on the directory across
> > server round trips seems compelling to me....
> >
> > I also wonder: why couldn't you fire off the RPC without any locks, then
> > wait till you get a reply to take locks and update your local cache?
> >
> > OK, for one thing, calls and replies and server processing could all get
> > reordered.  We'd need to know what order the server processed operations
> > in, so we could process replies in the same order.
> >
> > --b.
