Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E738B7B8D05
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Oct 2023 21:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245193AbjJDS7P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Oct 2023 14:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245198AbjJDS5d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Oct 2023 14:57:33 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157FE19B0
        for <linux-nfs@vger.kernel.org>; Wed,  4 Oct 2023 11:55:04 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c18b0569b6so461351fa.1
        for <linux-nfs@vger.kernel.org>; Wed, 04 Oct 2023 11:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1696445702; x=1697050502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyevCSMwXTkHu2xCoyw6JERTPCCU/m7U9T7AqkwuS1c=;
        b=FU9O3nqT4+bDcIsThQpphagDq1UjNljz9OQEIm0lEjhnNzNsxk41chllDop1E25xUs
         E+c6pKxrTLyM+DcZjEZF1SQ2nmvHh0f/DOgh8ItZCYnyCDrGSbmA+IVlB1y+IRKgdsIh
         bY7OsMHnPU7R/JaQaBVu+cdII3qGRzGS6xAXpbCmhEShWXzKcoo/M4d3nPsAXB/r9azv
         ItHGmuYK8xUaYzUW37CYv2YUpOiWu6Oh+XjE6ESszW0TPTV6H3QuT/2guM/IVvcSPJxm
         hqQFs9rnRnkKskr8D6MPekpZfChd1/UsEdcbhcy0uOsOAbMmeaG8rM6pLSAfwl+FtVPA
         yyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696445702; x=1697050502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyevCSMwXTkHu2xCoyw6JERTPCCU/m7U9T7AqkwuS1c=;
        b=qtqvntYFIowCKGhFrztpw9Wz1NfC70h3Sj8EAKhjVBU/uWBSb/qhw2PA7dsC7eWsCH
         +2upYDahkDZW62ZvFU/UmIdtLJH11KTXYF2nTbMDH8NGyLN/eNJrhEteFU35MBzOriiR
         M5XjOnTtQEydgryKOVe7wYdxzkN1i0efZ2LNZRDPvNDfxPtfU0HxVNFYgigDN/zuMv8h
         Q/tTqgjJnrRPF11WKzShqL6Zp6pe2kLW8wU1JPHw7n85BmSFuwWwcoiQTrgWYuBRiOqm
         906LOrW7rieWpdK72AeqpH9+JBFccEQjzeGEvmcaWIMFaTuX15H2GJk5/xt1Tg0gT2He
         qcOQ==
X-Gm-Message-State: AOJu0YwHbLd/lr9Od6lStFKhq81MCwsdkwr3FYR5wMtBSLZfAfN4BoAO
        HoyWVBGh9+50FAKJwxDNCD/U0DcRozjmAqoVHsihAKey
X-Google-Smtp-Source: AGHT+IEiy0Aj7IjG98kvlS1luAnAM30JkQezu3BFodVCHfgIw1MIFBh9n8pU4Y5loGTo6MRyLAYy1xFy90HChEOqnfs=
X-Received: by 2002:a2e:bea1:0:b0:2bf:7908:ae7c with SMTP id
 a33-20020a2ebea1000000b002bf7908ae7cmr2917251ljr.2.1696445701824; Wed, 04 Oct
 2023 11:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <93929ecf62e79670f1e3a1878757fc9fa443aa7c.1688210094.git.bcodding@redhat.com>
 <CAN-5tyGf6txJpoJBSzEh75BgZAQ1f4TbZF10Dw25GjeE4Pz=7w@mail.gmail.com>
In-Reply-To: <CAN-5tyGf6txJpoJBSzEh75BgZAQ1f4TbZF10Dw25GjeE4Pz=7w@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 4 Oct 2023 14:54:50 -0400
Message-ID: <CAN-5tyHOGoyhnkN5ZNjgavwQJWmGf6wY-NfgGCixdrXanedwFA@mail.gmail.com>
Subject: Re: [PATCH v3] NFSv4: Fix dropped lock for racing OPEN and delegation return
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        Olga.Kornievskaia@netapp.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sorry, I didn't mean this patch. I meant the revert patch.

On Wed, Oct 4, 2023 at 2:53=E2=80=AFPM Olga Kornievskaia <aglo@umich.edu> w=
rote:
>
> Hi Trond/Ben,
>
> Did this ever go to stable? I don't know if I missed a mail from Greg
> that it was picked up or it never got picked up because it wasn't
> marked for stable?
>
> Thank you.
>
> On Sat, Jul 1, 2023 at 8:13=E2=80=AFAM Benjamin Coddington <bcodding@redh=
at.com> wrote:
> >
> > Commmit f5ea16137a3f ("NFSv4: Retry LOCK on OLD_STATEID during delegati=
on
> > return") attempted to solve this problem by using nfs4's generic async =
error
> > handling, but introduced a regression where v4.0 lock recovery would ha=
ng.
> > The additional complexity introduced by overloading that error handling=
 is
> > not necessary for this case.  This patch expects that commit to be
> > reverted.
> >
> > The problem as originally explained in the above commit is:
> >
> >     There's a small window where a LOCK sent during a delegation return=
 can
> >     race with another OPEN on client, but the open stateid has not yet =
been
> >     updated.  In this case, the client doesn't handle the OLD_STATEID e=
rror
> >     from the server and will lose this lock, emitting:
> >     "NFS: nfs4_handle_delegation_recall_error: unhandled error -10024".
> >
> > Fix this by using the old_stateid refresh helpers if the server replies
> > with OLD_STATEID.
> >
> > Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
> > Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> > ---
> >  fs/nfs/nfs4proc.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 6bb14f6cfbc0..f350f41e1967 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -7180,8 +7180,15 @@ static void nfs4_lock_done(struct rpc_task *task=
, void *calldata)
> >                 } else if (!nfs4_update_lock_stateid(lsp, &data->res.st=
ateid))
> >                         goto out_restart;
> >                 break;
> > -       case -NFS4ERR_BAD_STATEID:
> >         case -NFS4ERR_OLD_STATEID:
> > +               if (data->arg.new_lock_owner !=3D 0 &&
> > +                       nfs4_refresh_open_old_stateid(&data->arg.open_s=
tateid,
> > +                                       lsp->ls_state))
> > +                       goto out_restart;
> > +               else if (nfs4_refresh_lock_old_stateid(&data->arg.lock_=
stateid, lsp))
> > +                       goto out_restart;
> > +               fallthrough;
> > +       case -NFS4ERR_BAD_STATEID:
> >         case -NFS4ERR_STALE_STATEID:
> >         case -NFS4ERR_EXPIRED:
> >                 if (data->arg.new_lock_owner !=3D 0) {
> > --
> > 2.40.1
> >
