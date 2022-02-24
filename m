Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE10A4C37B2
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 22:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiBXV0I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 16:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbiBXV0H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 16:26:07 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED5828B63F
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 13:25:33 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x5so4674410edd.11
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 13:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qb3lm1K4tSzN4XX08/7kFIIWh1IGPnLbE42KBlncf0A=;
        b=Jbyt7xR0I3UAhZ1VntoPftOFQU4Lzw8J4nbzAKivqm6Ef2U2WZyBijhywoZn5XoOPC
         /DqrpLnsa22oNyN1JuSba3qyvlqhkUXuJUAOt7/PS01aJkV0yfNsLAMWNY1FOTXvsY9Y
         Orhgd+TbiMhQ9w+qeqeGDe9UcnEdDPi6hp8D2Y2XzhGy2LbNK32LI8FDxjuf2Q0gLUht
         H6/oGK1F74I/H9D/5vFkzf/B0VjWn4UNP9fGcETOtYhOXzSj1V0P0LKgofu6eMfAic1O
         s/hkSZRRLboE3Hh1btefRaA5Xf+MGUeFFpTgcFb3X3sEXzR8PbyDxc0r2ifk6o8X4uGX
         GzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qb3lm1K4tSzN4XX08/7kFIIWh1IGPnLbE42KBlncf0A=;
        b=k/8yqdACPAEbcqfVauPXPTQp/lzjcN1Ty/tOlY9K2voJwLGUq8Bax0Q3XDEXcgSWmA
         SeyO2hi7AAuK0qiu19JAsJa1uu7no85kn+6TlVBfHgGuZsbf80iniEgnVzhAN1iy1V+q
         mI8dYj5SlXMxSVYWvjqZlETIosth4hqLlpTsy8m/++smSFbHt49M4ybNpXa7wT5vLD5j
         Yl53oeYpLaoB+XUsNNVEX5Z4YZLvQDD7JsPRUh7p0G/azlFp86kPlsAS/o/lCZEWn5/T
         092zqszFUULJG4MoFMYZ3IY/tfEHf+HKkm6f4syAAwh0RxS28E41QJmsxr0ILVrxV/h4
         5KLA==
X-Gm-Message-State: AOAM530nSJ2X36UtD62nb58Ggv22hugz90Cw6yvscusTyCSFWOT46+t3
        ahaAcZHj4UqdWgqj/V8o/nxODFtL3gu8hQDyHNA=
X-Google-Smtp-Source: ABdhPJylBzjOWrLUFhfalbijmIsLtddtPdyfTGm9af8ZuWkhjZtQXpX1sGx16DOOuJf1LQuNNjt5XuRlH3/hv8IJGNI=
X-Received: by 2002:a05:6402:34d1:b0:410:fede:429b with SMTP id
 w17-20020a05640234d100b00410fede429bmr4160634edc.250.1645737931391; Thu, 24
 Feb 2022 13:25:31 -0800 (PST)
MIME-Version: 1.0
References: <20220223174041.77887-1-olga.kornievskaia@gmail.com>
 <77E34F86-FC2E-4CBF-AFCA-272BAA7C4040@oracle.com> <CAN-5tyEWWbxCtWQPaMhYdP3OW-XKbCANZKx4mk9Fz=cwbQBU6g@mail.gmail.com>
 <BA1B54FF-FAD5-40FB-80CF-65424535C5F6@oracle.com>
In-Reply-To: <BA1B54FF-FAD5-40FB-80CF-65424535C5F6@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 24 Feb 2022 16:25:20 -0500
Message-ID: <CAN-5tyEkT_LNPoPErW5OFU8oRoBm=E2czC-bLysqw4R26UsT8A@mail.gmail.com>
Subject: Re: [PATCH v1] NFSv4.1 provide mount option to toggle trunking discovery
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Feb 24, 2022 at 1:20 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
> > On Feb 24, 2022, at 12:55 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > On Thu, Feb 24, 2022 at 10:30 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>
> >>> On Feb 23, 2022, at 12:40 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >>>
> >>> From: Olga Kornievskaia <kolga@netapp.com>
> >>>
> >>> Introduce a new mount option -- trunkdiscovery,notrunkdiscovery -- to
> >>> toggle whether or not the client will engage in actively discovery
> >>> of trunking locations.
> >>
> >> An alternative solution might be to change the client's
> >> probe to treat NFS4ERR_DELAY as "no trunking information
> >> available" and then allow operation to proceed on the
> >> known good transport.
> >
> > I'm not sure what you mean about "the known good transport".
>
> The transport on which the client sent the
> GETATTR(fs_locations).
>
> The NFS4ERR_DELAY response means the server has no other
> trunks available "at this time."

But GETATTR(fs_locations) isn't only used for trunking query, it's
used for filesystem location (migration) as well. Are we redefining
what ERR_DELAY means in the context of trunking vs migration?

> > I don't
> > think the ERR_DELAY is associated with a transport. Btw, if you saw a
> > previous patch which restricts fs_location query to the main transport
> > makes your statement even more confusing as it would mean there is no
> > good transport. Or do you mean to say we should have trunking
> > discovery done asynchronous to mount by a separate kernel thread and
> > therefore not impact mount steps?
>
> Yes, something like that.
>
> Trunking discovery that is independent of the NFS mount
> process should be the goal. In fact, trunking discovery
> really ought to be done in user space.

I agree it should be a goal of continuous management of trunking but
the initial setup is a part of file system attributes discovery.
fs_location is a file system attribute which is queried along with
other attributes upon discovery of a file system. Thus I maintain that
the current treatment of trunking discovery is valid.

What is being described below is a set of goals for trunking that we
have discussed before and are important.

> - There is now a user/kernel API for managing transports
>
> - The trunking configuration on the server might change
>   during the lifetime of the mount, so periodic checking
>   is needed
>
> - Adding an extra round trip, especially one that might
>   be slowed by one or more NFS4ERR_DELAY replies, is
>   going to be a problem during a mount storm
>
> - There might be local policies that affect which network
>   paths to choose for trunking
>
> - The choice of transports might be made automatically
>   by an orchestrator
>
> - Tying this setting to a mount option is not appropriate
>   because the transports are shared amount multiple NFS
>   mounts
>
>
> > I do object to treating a single ERR_DELAY during discovery as a
> > permanent error as there are legitimate reasons to a delay in looking
> > up the information that can be resolved in time by the server.
> > However, I don't object to putting a time limit or number of tries on
> > ERR_DELAY as safety wheels.
>
> In the past, some have objected to /any/ delay added to
> the NFS mount process.

I again would like to note that fs_locations is a file system
attribute thus I would argue has to be treated as other file system
attributes.

> There's no reason to hold up the mount process -- the
> client can try the trunking discovery probe again in a
> few moments while the mount proceeds, can't it?

Given that I suggested doing it asynchronous means I consider it a
possible design though I think it increases the complexity of the
system greatly (I'm not convinced that it's the right call to be
done).

> If that means handing the probe to a work queue or
> leaving it to user space, that seems like a more
> flexible choice.
>
>
> > Lastly, I think perhaps we can do both have a mount option to toggle
> > discovery as well as safeguard the discovery from broken servers?
>
> I'd really rather not add a mount option for this
> purpose unless you know of another reason why trunking
> discovery needs to be disabled.

I don't offhand. I thought it is the simplest and most appropriate
solution and perhaps inline with "migration/nomigration" option but I
must be mistaken there.

> The best solution is to fix the server implementations.
> If that's not possible then the second best is to have
> the client manage the situation without needing any
> human intervention.
>
> Adding an administrative tunable is, to my mind, an
> option of the very last resort.
>
>
> --
> Chuck Lever
>
>
>
