Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBF150FD04
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Apr 2022 14:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241345AbiDZMdG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Apr 2022 08:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiDZMdF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Apr 2022 08:33:05 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8DA88B24
        for <linux-nfs@vger.kernel.org>; Tue, 26 Apr 2022 05:29:57 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id m20so15002836ejj.10
        for <linux-nfs@vger.kernel.org>; Tue, 26 Apr 2022 05:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4r9dpEEZxQjLunjtmysIuwfLl8tWCCfm3ehoce9xSWg=;
        b=ECxkDG1geDZGMIG6VRHARE9+Aqi2ANvE2ZQBFYtU7zBDX27zV2NNs7YgC8+d/zTgd3
         QKsAVr2cFmXZWVhI7UHuG82ZgSbgp7g1piudvKKb32N8kvJclGdgc7ls1lTIHAbDWfGo
         cbQuajYedDr1VqQKKPkCc8t6zL6CXypq+wvlQut3DdlNIwhcxPQxfFU7ku0IJOeE6ogi
         kwmy30+KQM3ofQaZ8kK6Tl9v4nYKc0qCdCASI6JW84cLWGyR4uX7sac4Po4f8zoF1Z6l
         siPHrRteGqdrGgA7sYnRMKaPnLnyd04oN/sFq4feGwZkGklj5N/DMcsb2qr5sGDPafP3
         R8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4r9dpEEZxQjLunjtmysIuwfLl8tWCCfm3ehoce9xSWg=;
        b=mgk8MH41HzEm6uIJ+ZpsM9tT37kV5xqzPe62HDAViwJL1cP9JMETJMg3uMPDuxXQxt
         iL49yt2KhdjumKahLBglnruPepBUE6j3DG4j9+J3QaQfyFuLFLIZ4M71f/naSm34XDcm
         oVv/x+3ZVi7krtNAIKv/ehu/2HuQcxPxvsDdCQ1Ay9QwvE8HkX35zPzlh0ZKsmQMeHwt
         gDaLgu3eIRDg2AXIP/QUbD+sBApJSfK+BWn1lSIF+ZDxy7+UZvMh0cYVojW41lBE1erE
         mUigBoh3OoCCnJKn2hOf1oi/34vQSkNkrVAjuz5YzqfOGHj0VeAwQv7qaPm7YTjkbruA
         MLLw==
X-Gm-Message-State: AOAM532jfmO6KC6ELelvJyAukjBJC8zNJB1/8JvZSj9l3NpZz85ZEtPd
        RvYLnTxUwVM5QsZRuRcmUv1S604RmuW2DzDFN+BMVQ==
X-Google-Smtp-Source: ABdhPJxw6q3MEOUevi4w0ue0sbzOA+UwETJ0BckLKO3cJDf4UqTU9OrRkcZ4W3bDKc2nClScob66NS8xWqmQzANp8yQ=
X-Received: by 2002:a17:907:6d82:b0:6ef:f56a:85a4 with SMTP id
 sb2-20020a1709076d8200b006eff56a85a4mr21599229ejc.142.1650976196367; Tue, 26
 Apr 2022 05:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220126025722.GD17638@fieldses.org> <CAPt2mGP2guMMf1C9VoQ0AvZ819jPuz0vDoEzJJhtL8q5DJ300A@mail.gmail.com>
 <CAPt2mGNXq==1KUskF3U6-CDeoX57=d7NW4Qn_esDqarf9bTBaw@mail.gmail.com>
 <20220211155949.GA4941@fieldses.org> <CAPt2mGOx0qNTWoY9vmyVBtZ3gxdbv5qQ-2qVbtqWW9FiZFRhEg@mail.gmail.com>
 <164517040900.10228.8956772146017892417@noble.neil.brown.name>
 <CAPt2mGMLQCEPqsYGeaMd3BPGRne4F4h-2-pzqm1a8nwfKqv1ug@mail.gmail.com>
 <CAPt2mGMt3Sq66qmPBeGYE0CASTTy7nY2K_LjQK6VZx-uz2P-wg@mail.gmail.com>
 <20220425132232.GA24825@fieldses.org> <CAPt2mGMtBH=jzK0cTT7+PTbX-iR-iSx1RmF2beCDxBjXY5sj8A@mail.gmail.com>
 <20220425160236.GB24825@fieldses.org> <CAPt2mGPR9c9=rh4p_D7RPo+4S=DgH7VNpqvOKryKsYwaCAtnJA@mail.gmail.com>
 <165093700757.1648.16863178337904278508@noble.neil.brown.name>
In-Reply-To: <165093700757.1648.16863178337904278508@noble.neil.brown.name>
From:   Daire Byrne <daire@dneg.com>
Date:   Tue, 26 Apr 2022 13:29:20 +0100
Message-ID: <CAPt2mGPVWuut=ESWicSw0Ser2PGTeuyb+ACL41N6p_FAAuOUwg@mail.gmail.com>
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

On Tue, 26 Apr 2022 at 02:36, NeilBrown <neilb@suse.de> wrote:
>
> On Tue, 26 Apr 2022, Daire Byrne wrote:
> >
> > I'll stare at fs/nfsd/vfs.c for a bit but I probably lack the
> > expertise to make it work.
>
> Staring at code is good for the soul ....  but I'll try to schedule time
> to work on this patch again - make it work from nfsd and also make it
> handle rename.

Yea, I stared at it for quite a while this morning and no amount of
coffee was going to help me figure out how best to proceed.

If you are able to update this for nfsd then I'll be eternally
grateful and do my best to test it under load in an effort to get it
all merged.

The community here has been so good to us over the last couple of
years and it is very much appreciated. It has helped us deliver (oscar
winning) movies!

To give some brief context as to why this is useful to us (for anyone
interested), we utilise NFS re-export extensively to run our batch
jobs (movie frame renders) in various remote DCs. In combination with
fscache and long term attribute caching, this works great for exposing
our (read often) onprem storage to the remote DCs (with varying
latencies).

But batch jobs have a tendency to start related tasks on many clients
at the same time with their results or logs being written to big
common directories. And by writing through the re-export server, we
often hit this limitation with parallel file creates which slows
everything down. We have tried to avoid large directories where
possible, but it's hard to catch and fix all the cases.

Using an NFS re-export server works 95% of the time for our workloads
(after much help from this community), so we are just trying to pick
away at the last 5% of edge cases. One of the disadvantages of the
re-export server in the middle, is that we lose some of the natural
parallelism that directly connected clients would otherwise have. And
this becomes very noticeable once the latency goes above 20ms.

Cheers,

Daire


> > It's also not entirely clear that this parallel creates RFC patch will
> > ever make it into mainline?
>
> I hope it will eventually, but I have no idea when that might be.
>
> Thanks for your continued interest,
> NeilBrown
