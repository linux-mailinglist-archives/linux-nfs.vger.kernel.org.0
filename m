Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F86758FD6F
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Aug 2022 15:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiHKNe2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Aug 2022 09:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKNe0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Aug 2022 09:34:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4B68991D
        for <linux-nfs@vger.kernel.org>; Thu, 11 Aug 2022 06:34:25 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b96so23064964edf.0
        for <linux-nfs@vger.kernel.org>; Thu, 11 Aug 2022 06:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=y6Vt/S1iljw7JHJYhlxz+L1o5662gbz5xScq1/L4AaA=;
        b=nbWz787DAeP6JdhX7PHaWS7kvTqXWN10POPmCrChMFQvuR05pTr4frDVqEvgBx3bPi
         mEsElBLgn/qsF1Aiepu36I7TnYgCT5/Olfadny3bcE+JbhSUWd+jYj8LYaO/on8+u8Cf
         Hm/SxQKUgt5xnBA8NBNue84HZXEViE98BSqRI0uhSOH/W7zTiJy3NYZ0WsCvpaLVozWi
         CyPy/G+TXHtovqgfnazbQdi2wI/z/JqkjLtmesDMlvg4jypepJZDNIq+rnA9L7lH7CPp
         39WJb2IG9WkCuoowEO54nYvfq9PKaNDgb88GMED0Q7bQUAC1AahSvPP7bbRAwF8yvR8c
         DLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=y6Vt/S1iljw7JHJYhlxz+L1o5662gbz5xScq1/L4AaA=;
        b=R2gTClsubcKqpClwN13/0dB5LuNB4JejoWEvZdc9OLMlLs1jp//lVlN+Qj4MgT87IC
         5to1KNLupJpaYMHN2AzDI2RNf1+3dtCqRm7lL2kNfwgBzDxYCKf7HIldPN2/0f3JQ2ZP
         TxKT8vdptrebbNu2UimSEImUCeMl9dlNNNhQDJ0uV84GKg/Hh0nxMdxFe90FDUWgJ/m1
         E8OUkWpEFHZ3Jq+WTpkR5M9RUXaTz4dbLBE3zfx/zqvBvZWZuq9QZVyWc9aJf/9r6fLt
         evlsm65iI5HJXBWTvI1/LnC6yAMD+m2fq7He+a0CHCjbUDym2ilKeWyQiIdKEXx9+Eub
         4ZMg==
X-Gm-Message-State: ACgBeo230LOssjZJDUNF88PgAvqG35ReLsOtz4HoxkRDPPXfEAgnF1rQ
        6JN8cKDOOPuQcRQOcBuXtAWzKyszT7gghGWCemPnshHe
X-Google-Smtp-Source: AA6agR622YcDos5V2c8u9WKU3kBLnhBNrA4J9OC8FVghiRxXazlO2/22SxoP5B7i81ULehl68MHLGaZM5jbG9mlusxo=
X-Received: by 2002:a05:6402:40c2:b0:440:4ecd:f75f with SMTP id
 z2-20020a05640240c200b004404ecdf75fmr23384643edb.405.1660224863516; Thu, 11
 Aug 2022 06:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <1659298792-5735-1-git-send-email-dai.ngo@oracle.com> <37585D43-78F3-4132-8ADF-D11BD11DDCD4@oracle.com>
In-Reply-To: <37585D43-78F3-4132-8ADF-D11BD11DDCD4@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 11 Aug 2022 09:34:12 -0400
Message-ID: <CAN-5tyH_P6atMOzg4w8pjY2axsE1zo+AedMEefC-KkKg820Eig@mail.gmail.com>
Subject: Re: [PATCH] NFSD: fix use-after-free on source server when doing
 inter-server copy
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>,
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

On Mon, Aug 1, 2022 at 12:29 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jul 31, 2022, at 4:19 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> >
> > Use-after-free occurred when the laundromat tried to free expired
> > cpntf_state entry on the s2s_cp_stateids list after inter-server
> > copy completed. The sc_cp_list that the expired copy state was
> > inserted on was already freed.
> >
> > When COPY completes, the Linux client normally sends LOCKU(lock_state x),
> > FREE_STATEID(lock_state x) and CLOSE(open_state y) to the source server.
> > The nfs4_put_stid call from nfsd4_free_stateid cleans up the copy state
> > from the s2s_cp_stateids list before freeing the lock state's stid.
> >
> > However, sometimes the CLOSE was sent before the FREE_STATEID request.
> > When this happens, the nfsd4_close_open_stateid call from nfsd4_close
> > frees all lock states on its st_locks list without cleaning up the copy
> > state on the sc_cp_list list. When the time the FREE_STATEID arrives the
> > server returns BAD_STATEID since the lock state was freed. This causes
> > the use-after-free error to occur when the laundromat tries to free
> > the expired cpntf_state.
> >
> > This patch adds a call to nfs4_free_cpntf_statelist in
> > nfsd4_close_open_stateid to clean up the copy state before calling
> > free_ol_stateid_reaplist to free the lock state's stid on the reaplist.
> >
> > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>
> I'm interested in Olga's comments as well, so I'm going to
> wait a bit before applying this one.

Sorry folks, I totally missed this thread.... I was on vacation, came
back and started working on this after running into the oops with
Chuck's new patch set..

Well as you saw from my other post that my solution is different and
suggests putting cleanup of the copy_notify states together with
idr_remove() of the stateid it was associated with.

> Also, did you figure out where this crash started to occur?
> I'd like to have a precise sense of whether this should be
> backported.

I'm not going to claim this is the first occurrence but Jorge first
ran into this while testing ssc over iwarp on the 5.15-rc4 kernel.

>
>
> > ---
> > fs/nfsd/nfs4state.c | 3 +++
> > 1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 9409a0dc1b76..749f51dff5c7 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -6608,6 +6608,7 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
> >       struct nfs4_client *clp = s->st_stid.sc_client;
> >       bool unhashed;
> >       LIST_HEAD(reaplist);
> > +     struct nfs4_ol_stateid *stp;
> >
> >       spin_lock(&clp->cl_lock);
> >       unhashed = unhash_open_stateid(s, &reaplist);
> > @@ -6616,6 +6617,8 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
> >               if (unhashed)
> >                       put_ol_stateid_locked(s, &reaplist);
> >               spin_unlock(&clp->cl_lock);
> > +             list_for_each_entry(stp, &reaplist, st_locks)
> > +                     nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
> >               free_ol_stateid_reaplist(&reaplist);
> >       } else {
> >               spin_unlock(&clp->cl_lock);
> > --
> > 2.9.5
> >
>
> --
> Chuck Lever
>
>
>
