Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2539450E0FC
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Apr 2022 15:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbiDYNEQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Apr 2022 09:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240811AbiDYNEO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Apr 2022 09:04:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3FC13F2A
        for <linux-nfs@vger.kernel.org>; Mon, 25 Apr 2022 06:01:09 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u15so29394704ejf.11
        for <linux-nfs@vger.kernel.org>; Mon, 25 Apr 2022 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a29dK23//il3VwdnQYpE2X0vejRLgB4qGqIjrQEj4i0=;
        b=sfxq0XMzCAMyyAbiwwF6fwEdSfd3seOHFY4b4Vl3nlIuMmwIup6Rhih2TFdCKdKsvK
         jlRSoJynTgMY9eRzCD/8ksIBONcS/nhWBl2ub3EMGTrC9atIYPt5JIOzFHHYvxAVGidb
         tWGbWKycHKSqED6ZUWtBpmwA50NzsC9or5lLgH5t8w72xmjgzdxuLPV/qSl8KVYa18DS
         IpnVNLsCOyJASiSER7el1JXuJNYN9Bi+oHnlZAWGVHQqzm6OY+oZCOOufEdQHtIF9HEO
         hKaOr7eW5EFUYzFJRFiQbYSmvQj1SGVNoVa8c0Mblw18K2dLAjO1cL34bnnFN67V9DFz
         hPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a29dK23//il3VwdnQYpE2X0vejRLgB4qGqIjrQEj4i0=;
        b=XMj4oVJbrOyjOpskGmnsrdz0iyPG+oDXJXNE+LdlPT26/5wyFhqq4WzLJt/7WT3J/+
         8pNI2X//fZpbpYS5XBjHxCXTkiMsGU9HfChNIOXkNAFH9QWGvPGC339tg1YapYH0mrEE
         XHeT9QAMRimENfj3iz/lf8uesJ70jIhpH/CsrlLrKpO59gQ9wAW5rpnMwasbqRIsg4Hg
         FWjGLEertiw9fSDbidwxr4huS8QaJYvRQhKfurdMagmW7mpe/16k1JAy2kLiRb9Cd2Qu
         a224iEpXEOdwM1ZFLDNNQcIRmuDMiRYxDMkWYZoMO8WIHzWdSqITVC+YcNg6JIoKF5lc
         55vw==
X-Gm-Message-State: AOAM531+5xmdS4rnlVGJqSRaz93oJIA/rRygaXCEl+ZrHktjRF5yon7g
        SuqAJDsLMhgbSy1fM02P/pTSJX8uwHc2M0vA6wrClVDK8nkAZA==
X-Google-Smtp-Source: ABdhPJx43IeCvIAV+8CcA4bKIv+wDMwTchENq5EKz9ldW/f4apHl+jloby7R+uRdd+R7OPr+++KfGTOfLEOFUEI9Euc=
X-Received: by 2002:a17:907:6d82:b0:6ef:f56a:85a4 with SMTP id
 sb2-20020a1709076d8200b006eff56a85a4mr16730294ejc.142.1650891667712; Mon, 25
 Apr 2022 06:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org> <adce2b72-ed5c-3056-313c-caea9bad4e15@math.utexas.edu>
 <20220125212055.GB17638@fieldses.org> <164315533676.5493.13243313269022942124@noble.neil.brown.name>
 <20220126025722.GD17638@fieldses.org> <CAPt2mGP2guMMf1C9VoQ0AvZ819jPuz0vDoEzJJhtL8q5DJ300A@mail.gmail.com>
 <CAPt2mGNXq==1KUskF3U6-CDeoX57=d7NW4Qn_esDqarf9bTBaw@mail.gmail.com>
 <20220211155949.GA4941@fieldses.org> <CAPt2mGOx0qNTWoY9vmyVBtZ3gxdbv5qQ-2qVbtqWW9FiZFRhEg@mail.gmail.com>
 <164517040900.10228.8956772146017892417@noble.neil.brown.name> <CAPt2mGMLQCEPqsYGeaMd3BPGRne4F4h-2-pzqm1a8nwfKqv1ug@mail.gmail.com>
In-Reply-To: <CAPt2mGMLQCEPqsYGeaMd3BPGRne4F4h-2-pzqm1a8nwfKqv1ug@mail.gmail.com>
From:   Daire Byrne <daire@dneg.com>
Date:   Mon, 25 Apr 2022 14:00:32 +0100
Message-ID: <CAPt2mGMt3Sq66qmPBeGYE0CASTTy7nY2K_LjQK6VZx-uz2P-wg@mail.gmail.com>
Subject: Re: parallel file create rates (+high latency)
To:     NeilBrown <neilb@suse.de>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Patrick Goetz <pgoetz@math.utexas.edu>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 21 Feb 2022 at 13:59, Daire Byrne <daire@dneg.com> wrote:
>
> On Fri, 18 Feb 2022 at 07:46, NeilBrown <neilb@suse.de> wrote:
> > I've ported it to mainline without much trouble.  I started some simple
> > testing (parallel create/delete of the same file) and hit a bug quite
> > easily.  I fixed that (eventually) and then tried with more than 1 CPU,
> > and hit another bug.  But then it was quitting time.  If I can get rid
> > of all the easy to find bugs, I'll post it with a CC to you, and you can
> > find some more for me!
>
> That would be awesome! I have a real world production case for this
> and it's a pretty heavy workload. If that doesn't shake out any bugs,
> nothing will.
>
> The only caveat being that it will likely be restricted to NFSv3
> testing due to the concurrency limitations with NFSv4.1+ (from the
> other thread).
>
> Daire

Just to follow up on this again - I have been using Neil's patch for
parallel file creates (thanks!) but I'm a bit confused as to why it
doesn't seem to help in my NFS re-export case.

With the patch, I can achieve much higher parallel (multi process)
creates directly on my re-export server to a high latency remote
server mount, but when I re-export that to multiple clients, the
aggregate create rate again degrades to that which we might expect
either without the patch or if there was only one process creating the
files in sequence.

My assumption was that the nfsd threads of the re-export server would
act as multiple independent processes and it's clients would be spread
across them such that they would also benefit from the parallel
creates patch on the re-export server. So I expected many clients
creating files in the same directory would achieve much higher
aggregate performance.

Am I missing some other interaction here that limits parallel
performance in my unusual re-export case?

Cheers,

Daire
