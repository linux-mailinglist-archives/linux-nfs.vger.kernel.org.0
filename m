Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEFA4BE361
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Feb 2022 18:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbiBUOAR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Feb 2022 09:00:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377182AbiBUOAQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Feb 2022 09:00:16 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4997D1A3AD
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 05:59:53 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id p15so33439391ejc.7
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 05:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2fYMWLDQPPjNpwZ9BdqqV7Y+HVdKlVjbncwG7q0T3Wg=;
        b=gLOuhnaJUPB4B5/WXaMPSHcmeDSHMS7COlKCOQ0Gr7tCY3HkY09smvFuAuB1yUxxSB
         WHaCmDFLFgBs9NbOFfsuwzDkFW8yAiIbjA7T4z0CfhFfAGOi/Fjil64Bt9lrlYmd4u/x
         J9anZWBoroc68td4bPfFR9gBFkOz0QDgotmNZh8RrW+boz0idxehFtUylQatZ+i+ClHP
         BhaHUVst3uPVl7xBstdcFaDtSi8HWT+K2OF8WX5ebB7ckkUwwu6c31YlqCTPC43LgnWn
         mMRnbnGR2mL8NVd3dYgcK7WzkCxdhMjKMQMsvkuDbK53c4mfbLHq8yl2Kdyhl/rpeUeD
         l8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2fYMWLDQPPjNpwZ9BdqqV7Y+HVdKlVjbncwG7q0T3Wg=;
        b=jXgbEus2T2y6ZYK4agGtgw+9D/yOrWAHCNiC4jjdS9h1UW4yhN4kcSBcxjCWv4MEvQ
         IQPG1/B6W4GKF2yGG7sCVnYf8odUZ31jZguQQGQT98gAFfIMMz6a+y/pxaWDJIop9kda
         t6ijBrw4wY47lu0bB1ijfyJ/oh0BkwNRO9yAxWUBGz4GS9hTnGjMCmFg2UQGzd8PDaDG
         45AzZV9muuS1KCUq1QjAgrbjbkZ8sGFGJiljEYmWIM4uUx5bXZDQqfZUXxlOd57PVeI3
         pwu8Tfch0DZ+aZ16ynZCaov3wVTGrRxgqPaNRwPUsZlLtBaoImWdNQBEECc+OOs2mtAk
         GmVQ==
X-Gm-Message-State: AOAM532Zkf+DBn6nQVIa2KQ4rOjH3Lbbn8lRTilz6wtj6NmJXxOaOHc3
        dDaUbca6coJ8JvIJOds8suH5s5pbx+ZqJjoddApb/w==
X-Google-Smtp-Source: ABdhPJyfKGeRIbMZds5xpVtLHjB2ON2wRM47lNNOtCsPFR4UykiN/zPz+BWKyIYZYrXSCCI4wBXf6jyIFWwGzoNKCaw=
X-Received: by 2002:a17:907:2a53:b0:6ce:e4fe:3f92 with SMTP id
 fe19-20020a1709072a5300b006cee4fe3f92mr15581449ejc.389.1645451991890; Mon, 21
 Feb 2022 05:59:51 -0800 (PST)
MIME-Version: 1.0
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org> <adce2b72-ed5c-3056-313c-caea9bad4e15@math.utexas.edu>
 <20220125212055.GB17638@fieldses.org> <164315533676.5493.13243313269022942124@noble.neil.brown.name>
 <20220126025722.GD17638@fieldses.org> <CAPt2mGP2guMMf1C9VoQ0AvZ819jPuz0vDoEzJJhtL8q5DJ300A@mail.gmail.com>
 <CAPt2mGNXq==1KUskF3U6-CDeoX57=d7NW4Qn_esDqarf9bTBaw@mail.gmail.com>
 <20220211155949.GA4941@fieldses.org> <CAPt2mGOx0qNTWoY9vmyVBtZ3gxdbv5qQ-2qVbtqWW9FiZFRhEg@mail.gmail.com>
 <164517040900.10228.8956772146017892417@noble.neil.brown.name>
In-Reply-To: <164517040900.10228.8956772146017892417@noble.neil.brown.name>
From:   Daire Byrne <daire@dneg.com>
Date:   Mon, 21 Feb 2022 13:59:16 +0000
Message-ID: <CAPt2mGMLQCEPqsYGeaMd3BPGRne4F4h-2-pzqm1a8nwfKqv1ug@mail.gmail.com>
Subject: Re: parallel file create rates (+high latency)
To:     NeilBrown <neilb@suse.de>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Patrick Goetz <pgoetz@math.utexas.edu>,
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

On Fri, 18 Feb 2022 at 07:46, NeilBrown <neilb@suse.de> wrote:
>
> On Fri, 18 Feb 2022, Daire Byrne wrote:
> > On Fri, 11 Feb 2022 at 15:59, J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > > I think the path forward would be to update Neil's patch, add your
> > > performance data, send it to Al and linux-fsdevel, and see if we can get
> > > some idea what remains to be done to get this right.
> >
> > If Neil or anyone else is able to do that work, I'm happy to test and
> > provide the numbers.
> >
> > If I could update the patch myself, I would have happily contributed
> > but I lack the experience or knowledge. I'm great at identifying
> > problems, but not so hot at solving them :)
> >
>
> I've ported it to mainline without much trouble.  I started some simple
> testing (parallel create/delete of the same file) and hit a bug quite
> easily.  I fixed that (eventually) and then tried with more than 1 CPU,
> and hit another bug.  But then it was quitting time.  If I can get rid
> of all the easy to find bugs, I'll post it with a CC to you, and you can
> find some more for me!

That would be awesome! I have a real world production case for this
and it's a pretty heavy workload. If that doesn't shake out any bugs,
nothing will.

The only caveat being that it will likely be restricted to NFSv3
testing due to the concurrency limitations with NFSv4.1+ (from the
other thread).

Daire
