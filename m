Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE08672576
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 18:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjARRse (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 12:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjARRsP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 12:48:15 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971204994F
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 09:48:14 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id z13so9838239plg.6
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 09:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PEXa51HYFuxXoVCiWiUnLW2jtI41AvtmM2kDveEFyPQ=;
        b=WKf/h2KhNFZpo0V+K97x0LqXdAlC1gxk9ZEXLzgM8EfK5+zkLHqdeqFJGKTAtU2CAn
         M5HwLhMmFFfYMsqrOa1SeAoI4ArQve4rtFqEXqvKaNCUK2W8324h+3ISxAyo0EcfWLrB
         FmD0H5ky60sAJHxPcGCCU3d+EX1o9rFH9Ob2CJjKVQrbweCSqog7hM4/KbaK/SGHK9js
         M1axEvcrrQTNADkmvWIR7yonuWp0fu6vZ92jVQ4Uj8aPqS2eYLOxb4isYotuh/KyzGP6
         wZ8vV03PA+3T0eMzGss2sj+T7Xr4vkSlrhdN8OLBkF38LtK3XAADt46Z5+uNRzPUPiyC
         o4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEXa51HYFuxXoVCiWiUnLW2jtI41AvtmM2kDveEFyPQ=;
        b=wtLwhVZoT2L7KaENOyVAR3Gt6HBOMqh4LqFxjkY+0qBLnJCm4rLHhlImYEdf1xTZ3D
         RufzGdQZQt01IytxIUz5mxQ9PH7BdT/jIbEQPG6sCfncpMLEzpVVBoOFID975KukUke3
         UciidNexe5YUDnQH+/RL0OgDFhLANVQtrekUOqowgvdlX3iFsuRlNzf5IddeOWtXuwkV
         WL2SYbKMjNws2aV/vlTp4H/V3tss1epYCVHZJUAauc9ctNsNhPQJkiUk5fGMAsvgv9iX
         DFwoS1b2i4zEL5dhRJphgi86U9JuEirHyQaf8oVluNvq18r6Pz7bOZs7DD/8caPInS94
         X2MA==
X-Gm-Message-State: AFqh2kp6UVCNkqNPG+50MXTYS+FaGF0obFBvXpyIQC+lk8WBFIKUKoUt
        Wvb1oQXj7Q7Hpwo86T4hHhqI35oHscOJxWCY8DWryNP3
X-Google-Smtp-Source: AMrXdXsbM0YZtjZEEUjZDk7pCVYt6/xVz9V6EVOZvN0/Q3nJ6M8cmpFnETEvE5xVn5uN3r3IQV4g8ZWEC6q+eBKI/k8=
X-Received: by 2002:a17:90b:2385:b0:229:5902:697d with SMTP id
 mr5-20020a17090b238500b002295902697dmr641879pjb.171.1674064094015; Wed, 18
 Jan 2023 09:48:14 -0800 (PST)
MIME-Version: 1.0
References: <20230117193831.75201-1-jlayton@kernel.org> <20230117193831.75201-3-jlayton@kernel.org>
 <CAN-5tyHA6JgqnEorEqz1b3CLdbXWhT6hNZKXzgfZy3Fr_TdW7Q@mail.gmail.com>
 <1fc9af5a2c2a79c5befa4510c714f97e26b13ed5.camel@kernel.org>
 <CAN-5tyHKS9o3KDV3zUmzjiOjSxyC1rNe77Tc8c7RHmoXE6s_RQ@mail.gmail.com>
 <12C5F3B3-6DB1-4483-8160-A691EB464464@oracle.com> <0fbcbdc37e7e3f070b491848a74be348843074c2.camel@kernel.org>
 <DF04476E-D657-4CDA-A040-FF7FAA82ECE1@oracle.com> <11169811233f263b0086a90cc95574e664a92478.camel@kernel.org>
In-Reply-To: <11169811233f263b0086a90cc95574e664a92478.camel@kernel.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 18 Jan 2023 12:48:02 -0500
Message-ID: <CAN-5tyET4uzaTdQoadPwkzdjbATqrr_aNAg1OwFtYVM52Gd3hw@mail.gmail.com>
Subject: Re: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks in
 COPY codepath
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 18, 2023 at 12:26 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Wed, 2023-01-18 at 17:11 +0000, Chuck Lever III wrote:
> >
> > > On Jan 18, 2023, at 12:06 PM, Jeff Layton <jlayton@kernel.org> wrote:
> > >
> > > On Wed, 2023-01-18 at 16:39 +0000, Chuck Lever III wrote:
> > > >
> > > > > On Jan 18, 2023, at 11:29 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> > > > >
> > > > > On Wed, Jan 18, 2023 at 10:27 AM Jeff Layton <jlayton@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, 2023-01-18 at 09:42 -0500, Olga Kornievskaia wrote:
> > > > > > > On Tue, Jan 17, 2023 at 2:38 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > > > > > >
> > > > > > > > There are two different flavors of the nfsd4_copy struct. One is
> > > > > > > > embedded in the compound and is used directly in synchronous copies. The
> > > > > > > > other is dynamically allocated, refcounted and tracked in the client
> > > > > > > > struture. For the embedded one, the cleanup just involves releasing any
> > > > > > > > nfsd_files held on its behalf. For the async one, the cleanup is a bit
> > > > > > > > more involved, and we need to dequeue it from lists, unhash it, etc.
> > > > > > > >
> > > > > > > > There is at least one potential refcount leak in this code now. If the
> > > > > > > > kthread_create call fails, then both the src and dst nfsd_files in the
> > > > > > > > original nfsd4_copy object are leaked.
> > > > > > >
> > > > > > > I don't believe that's true. If kthread_create thread fails we call
> > > > > > > cleanup_async_copy() that does a put on the file descriptors.
> > > > > > >
> > > > > >
> > > > > > You mean this?
> > > > > >
> > > > > > out_err:
> > > > > >       if (async_copy)
> > > > > >               cleanup_async_copy(async_copy);
> > > > > >
> > > > > > That puts the references that were taken in dup_copy_fields, but the
> > > > > > original (embedded) nfsd4_copy also holds references and those are not
> > > > > > being put in this codepath.
> > > > >
> > > > > Can you please point out where do we take a reference on the original copy?
> > > > >
> > > > > > > > The cleanup in this codepath is also sort of weird. In the async copy
> > > > > > > > case, we'll have up to four nfsd_file references (src and dst for both
> > > > > > > > flavors of copy structure).
> > > > > > >
> > > > > > > That's not true. There is a careful distinction between intra -- which
> > > > > > > had 2 valid file pointers and does a get on both as they both point to
> > > > > > > something that's opened on this server--- but inter -- only does a get
> > > > > > > on the dst file descriptor, the src doesn't exit. And yes I realize
> > > > > > > the code checks for nfs_src being null which it should be but it makes
> > > > > > > the code less clear and at some point somebody might want to decide to
> > > > > > > really do a put on it.
> > > > > > >
> > > > > >
> > > > > > This is part of the problem here. We have a nfsd4_copy structure, and
> > > > > > depending on what has been done to it, you need to call different
> > > > > > methods to clean it up. That seems like a real antipattern to me.
> > > > >
> > > > > But they call different methods because different things need to be
> > > > > done there and it makes it clear what needs to be for what type of
> > > > > copy.
> > > >
> > > > In cases like this, it makes sense to consider using types to
> > > > ensure the code can't do the wrong thing. So you might want to
> > > > have a struct nfs4_copy_A for the inter code to use, and a struct
> > > > nfs4_copy_B for the intra code to use. Sharing the same struct
> > > > for both use cases is probably what's confusing to human readers.
> > > >
> > > > I've never been a stickler for removing every last ounce of code
> > > > duplication. Here, it might help to have a little duplication
> > > > just to make it easier to reason about the reference counting in
> > > > the two use cases.
> > > >
> > > > That's my view from the mountain top, worth every penny you paid
> > > > for it.
> > > >
> > >
> > > +1
> > >
> > > The nfsd4_copy structure has a lot of fields in it that only matter for
> > > the async copy case. ISTM that nfsd4_copy (the function) should
> > > dynamically allocate a struct nfsd4_async_copy that contains a
> > > nfsd4_copy and whatever other fields are needed.
> > >
> > > Then, we could trim down struct nfsd4_copy to just the info needed.
> >
> > Yeah, some of those fields are actually quite large, like filehandles.
> >
> >
> > > For instance, the nf_src and nf_dst fields really don't need to be in
> > > nfsd4_copy. For the synchronous copy case, we can just keep those
> > > pointers on the stack, and for the async case they would be inside the
> > > larger structure.
> > >
> > > That would allow us to trim down the footprint of the compound union
> > > too.
> >
> > That seems sensible. Do you feel like redriving this clean-up series
> > with the changes you describe above?
> >
>
> I can, unless Olga, Dai or someone else would rather do it. Not sure how
> soon I can get to it though.

I'm not going to volunteer as I don't believe in the suggested change.

I think there is a performance advantage to having this structure
preallocated and ready for use.

> --
> Jeff Layton <jlayton@kernel.org>
