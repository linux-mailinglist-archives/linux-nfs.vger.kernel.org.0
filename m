Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3524C7BA8E2
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Oct 2023 20:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjJESQ7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Oct 2023 14:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjJESQz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Oct 2023 14:16:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEAE93
        for <linux-nfs@vger.kernel.org>; Thu,  5 Oct 2023 11:16:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846D5C433C7
        for <linux-nfs@vger.kernel.org>; Thu,  5 Oct 2023 18:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696529814;
        bh=q06ZTLbYUS3cD2q/AMPLE3h2HqqpppDMc9F/dupG7Pg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JrfKdI2v5KxjELU1AV6zqdcdKcGnp8DtItQB82ysgMT/D5dxIxlxIEEsX3llXf+eT
         AtX8hRCe+PLf3bD5oDqlUq2z1b7E3cVnWURDuVVO0wnKstaVp5dTmEGstqOxb14P/O
         DzcLaV3DzYKwiWURbAh4ZMhVILgx84x7XiiYbmpK9JNqPx8FPwBEZ5IkwMaenzBZBU
         K0DSVUq5FvKfkHXfTLVJ6AdLWLvzuPvGOw7ZVnYn9a+uv6XFDg16qgkgW1k5tT/NXn
         tsUwMmGIIq67wMFniHlpclSpYlnSlmuifjFmbbOOKGbfW8iAKgaZeV+0w6sOstovNG
         g2P0phwUuZCgw==
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4528cba7892so637771137.0
        for <linux-nfs@vger.kernel.org>; Thu, 05 Oct 2023 11:16:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YwZsnr1S7oO2Tn2snQrajQ423xSVboS73HF8IKD3tBbVEz5COk9
        BUWrLHPrhPR8ASzhy1Lm7JBo3UWSBjLQcjigddA=
X-Google-Smtp-Source: AGHT+IH8wM86YQhJOIN1J5BuUbCw/G4adU96NxZyxKlTchMEhlakoeppSWrkkdPk1aqf6WZS3VvsFLV9WXcW6biUVnA=
X-Received: by 2002:a67:ee17:0:b0:452:4d64:9347 with SMTP id
 f23-20020a67ee17000000b004524d649347mr5216795vsp.35.1696529813769; Thu, 05
 Oct 2023 11:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <93929ecf62e79670f1e3a1878757fc9fa443aa7c.1688210094.git.bcodding@redhat.com>
 <CAN-5tyGf6txJpoJBSzEh75BgZAQ1f4TbZF10Dw25GjeE4Pz=7w@mail.gmail.com> <CAN-5tyHOGoyhnkN5ZNjgavwQJWmGf6wY-NfgGCixdrXanedwFA@mail.gmail.com>
In-Reply-To: <CAN-5tyHOGoyhnkN5ZNjgavwQJWmGf6wY-NfgGCixdrXanedwFA@mail.gmail.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Thu, 5 Oct 2023 14:16:37 -0400
X-Gmail-Original-Message-ID: <CAFX2Jfm=sibLroZSqkGEfDMT=-JdgR1F91-kCHHdGc4kTLuYgg@mail.gmail.com>
Message-ID: <CAFX2Jfm=sibLroZSqkGEfDMT=-JdgR1F91-kCHHdGc4kTLuYgg@mail.gmail.com>
Subject: Re: [PATCH v3] NFSv4: Fix dropped lock for racing OPEN and delegation return
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        trond.myklebust@hammerspace.com, Olga.Kornievskaia@netapp.com,
        linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga,

On Wed, Oct 4, 2023 at 2:55=E2=80=AFPM Olga Kornievskaia <aglo@umich.edu> w=
rote:
>
> Sorry, I didn't mean this patch. I meant the revert patch.
>
> On Wed, Oct 4, 2023 at 2:53=E2=80=AFPM Olga Kornievskaia <aglo@umich.edu>=
 wrote:
> >
> > Hi Trond/Ben,
> >
> > Did this ever go to stable? I don't know if I missed a mail from Greg
> > that it was picked up or it never got picked up because it wasn't
> > marked for stable?

Looks like the revert went into 6.5 as commit 5b4a82a0724a. It's not
marked for stable, so it probably wasn't picked up.

Anna

> >
> > Thank you.
> >
> > On Sat, Jul 1, 2023 at 8:13=E2=80=AFAM Benjamin Coddington <bcodding@re=
dhat.com> wrote:
> > >
> > > Commmit f5ea16137a3f ("NFSv4: Retry LOCK on OLD_STATEID during delega=
tion
> > > return") attempted to solve this problem by using nfs4's generic asyn=
c error
> > > handling, but introduced a regression where v4.0 lock recovery would =
hang.
> > > The additional complexity introduced by overloading that error handli=
ng is
> > > not necessary for this case.  This patch expects that commit to be
> > > reverted.
> > >
> > > The problem as originally explained in the above commit is:
> > >
> > >     There's a small window where a LOCK sent during a delegation retu=
rn can
> > >     race with another OPEN on client, but the open stateid has not ye=
t been
> > >     updated.  In this case, the client doesn't handle the OLD_STATEID=
 error
> > >     from the server and will lose this lock, emitting:
> > >     "NFS: nfs4_handle_delegation_recall_error: unhandled error -10024=
".
> > >
> > > Fix this by using the old_stateid refresh helpers if the server repli=
es
> > > with OLD_STATEID.
> > >
> > > Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
> > > Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> > > ---
> > >  fs/nfs/nfs4proc.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > index 6bb14f6cfbc0..f350f41e1967 100644
> > > --- a/fs/nfs/nfs4proc.c
> > > +++ b/fs/nfs/nfs4proc.c
> > > @@ -7180,8 +7180,15 @@ static void nfs4_lock_done(struct rpc_task *ta=
sk, void *calldata)
> > >                 } else if (!nfs4_update_lock_stateid(lsp, &data->res.=
stateid))
> > >                         goto out_restart;
> > >                 break;
> > > -       case -NFS4ERR_BAD_STATEID:
> > >         case -NFS4ERR_OLD_STATEID:
> > > +               if (data->arg.new_lock_owner !=3D 0 &&
> > > +                       nfs4_refresh_open_old_stateid(&data->arg.open=
_stateid,
> > > +                                       lsp->ls_state))
> > > +                       goto out_restart;
> > > +               else if (nfs4_refresh_lock_old_stateid(&data->arg.loc=
k_stateid, lsp))
> > > +                       goto out_restart;
> > > +               fallthrough;
> > > +       case -NFS4ERR_BAD_STATEID:
> > >         case -NFS4ERR_STALE_STATEID:
> > >         case -NFS4ERR_EXPIRED:
> > >                 if (data->arg.new_lock_owner !=3D 0) {
> > > --
> > > 2.40.1
> > >
