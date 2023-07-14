Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C4E753C4C
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jul 2023 15:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbjGNN5V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jul 2023 09:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbjGNN5U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jul 2023 09:57:20 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFA7271E
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jul 2023 06:57:19 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b6993ef4f2so6034691fa.0
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jul 2023 06:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689343037; x=1689947837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p021yPXuGCEf0Yb8TOURyaAQQtPefTMD89Uo9MAEr8c=;
        b=Zhzw8C7SlZE7n37DuCluVsD5wfwMob9jg/twgxMVXkv29LHb+ySv8WK1hK/iowZ6Ky
         oSmf5eBSGf8lSzWToDjrHNZ02pIAzUTIjhKZKwxCpM9EVBSD1mdOW1Dr0KId+6PUtgtj
         Aj40tvzwGUk1mQZgy3DSpwZlOWfGOSHlceKju88zpLCIxJ4/azHR0bLDaB8zu5ou4/8W
         feOmz8DrRIllfg1NJHyElwDKo8EkoQTN1HtygfBx4/FZdOeNuA9OS5TnZpvF1Ptlw32r
         F2sVwqcyEUZHG8nj+p/pXp7eszMbuqTqsmWgpqLgn50Ai0HKsJNF1TM5CzrgZ0cAL79Z
         GwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689343037; x=1689947837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p021yPXuGCEf0Yb8TOURyaAQQtPefTMD89Uo9MAEr8c=;
        b=Ua5g/nnAg8hlAI6kOvGVZjkl9B9OACg1jjR7rpK6ohu1cCDeUVoZfbl2FtbKI3dIUp
         hAZ94e269iYSbtStVCzH1D2C64LzQczTgRu9vcNGCeeDxy/D5KRZRH3PBtDBE0BDxb3p
         Vlxy3nKAk8cosF2MAPzeWlsHFqINNx7rcNY94yLeyuuyFobrcZdAeBYdKNLL3jMvZF0Y
         CqdXvyIDmGZZwKmIk4C1fzIRuNnSrCsZ3mualmX5jrw/yuzM1aJRmuseWALd+MvYjJXz
         8qEHHfd0Gf1ZBfcu969pnHgZv2We0OLUELB2tv20td6Fm1sp63pD1OjJkTlAyfFyGPQG
         XfwQ==
X-Gm-Message-State: ABy/qLZKKlACsrUEooKr2gUEvipc8gMwwZD3owvRi9GUsMT79Ebs9s7d
        X8uyJ5nWVI/M0E2Nd5f3Y5ZYcaxzrzm/wdhXXSFSn+xn
X-Google-Smtp-Source: APBJJlFKdjvrE4kvPsWzhpUkiIKDjuWwWpJ3OV774vFT9vBNcpCCNjIlz4gMBcV1XSifpXHc2+dhvy+jCVG9yPh35xg=
X-Received: by 2002:a05:651c:2124:b0:2b6:b7ae:94e5 with SMTP id
 a36-20020a05651c212400b002b6b7ae94e5mr3807469ljq.4.1689343036992; Fri, 14 Jul
 2023 06:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230713195416.30414-1-olga.kornievskaia@gmail.com>
 <A0663B9C-F005-4089-ABD6-542F77EE43ED@redhat.com> <CAN-5tyGa1dV1A5RgZsMCQzFHDV63=LDJq0DTpg8aJ=UCO+k+Og@mail.gmail.com>
 <A05D90E0-6D74-4948-B948-852B1448DD3C@redhat.com>
In-Reply-To: <A05D90E0-6D74-4948-B948-852B1448DD3C@redhat.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 14 Jul 2023 09:57:05 -0400
Message-ID: <CAN-5tyGiiSr+jkh=WL_C4=wBAfZUiQZVsJoVxn0Sxg=yK+TA9g@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1: fix zero value filehandle in post open getattr
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 13, 2023 at 6:13=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 13 Jul 2023, at 17:27, Olga Kornievskaia wrote:
>
> > On Thu, Jul 13, 2023 at 5:09=E2=80=AFPM Benjamin Coddington <bcodding@r=
edhat.com> wrote:
> >>
> >> On 13 Jul 2023, at 15:54, Olga Kornievskaia wrote:
> >>
> >>> From: Olga Kornievskaia <kolga@netapp.com>
> >>>
> >>> Currently, if the OPEN compound experiencing an error and needs to
> >>> get the file attributes separately, it will send a stand alone
> >>> GETATTR but it would use the filehandle from the results of
> >>> the OPEN compound. In case of the CLAIM_FH OPEN, nfs_openres's fh
> >>> is zero value. That generate a GETATTR that's sent with a zero
> >>> value filehandle, and results in the server returning an error.
> >>>
> >>> Instead, for the CLAIM_FH OPEN, take the filehandle that was used
> >>> in the PUTFH of the OPEN compound.
> >>>
> >>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> >>> ---
> >>>  fs/nfs/nfs4proc.c | 6 +++++-
> >>>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> >>> index 8edc610dc1d3..0b1b49f01c5b 100644
> >>> --- a/fs/nfs/nfs4proc.c
> >>> +++ b/fs/nfs/nfs4proc.c
> >>> @@ -2703,8 +2703,12 @@ static int _nfs4_proc_open(struct nfs4_opendat=
a *data,
> >>>                       return status;
> >>>       }
> >>>       if (!(o_res->f_attr->valid & NFS_ATTR_FATTR)) {
> >>> +             struct nfs_fh *fh =3D &o_res->fh;
> >>> +
> >>>               nfs4_sequence_free_slot(&o_res->seq_res);
> >>> -             nfs4_proc_getattr(server, &o_res->fh, o_res->f_attr, NU=
LL);
> >>> +             if (o_arg->claim =3D=3D NFS4_OPEN_CLAIM_FH)
> >>> +                     fh =3D NFS_FH(d_inode(data->dentry));
> >>> +             nfs4_proc_getattr(server, fh, o_res->f_attr, NULL);
> >>>       }
> >>>       return 0;
> >>>  }
> >>
> >> Looks good, but why not just use o_arg->fh?  Maybe also an opportunity
> >> to fix the whitespace damage a few lines before this hunk too.
> >>
> >
> > I did try it first. I had 2 problems with it. First of o_arg->fh is a
> > "const struct" so it wouldn't allow me to be assigned without casting.
> > Ok so perhaps it's not a big deal that we are going against the
> > "const". Second of all, when I did do that, it produced the following
> > warning and so I thought perhaps I should really use the original fh
> > instead of what's in the args:
>
> Oh maybe because this is the error path and nfs4_opendata is getting clea=
ned
> up in nfs4_open_release()?  The comments in nfs4_open_release are a bit
> confusing, but I think for the cases where we need to re-use the opendata=
 we
> are doing a kref_get on it.  Maybe we need a kref_get on the opendata for
> this case?

I guess I don't understand what's the problem with the current
approach which is simple.

> .. I suspect we'd have the o_res.fh from nfs4_opendata_get_inode().  Out =
of
> time, will check back in tomorrow.
>
> Ben
>
