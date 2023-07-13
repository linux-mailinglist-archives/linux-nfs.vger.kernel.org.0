Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C4A752C1F
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jul 2023 23:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjGMVcS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jul 2023 17:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjGMVcR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jul 2023 17:32:17 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AAC136
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jul 2023 14:32:16 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b6993ef4f2so3929791fa.0
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jul 2023 14:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689283935; x=1689888735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uE2YAXIfa27t8d7003nbDI5x+mHqZ1rdoLrWvEaqvXc=;
        b=nIPGEd03LLV7GMzUiMMhCy7RP131bzn56OWsRdGDqFLjBkRmTfYRT6Xak1vxyGxFv4
         T7jEsSFs0vagP/+dFXjVKoBt2FN7/NCm8S03VMDgCSQ4ICxYdAhueH7jOaqaYeiKYI2f
         6M7dceUgDkl6KG7eEHWc2apYkJkOe7b8AH+WICIMSwGsrVvp5/EpeXxOJIIDrbOw9XKz
         /lvaKi2aa3T6kERiTC837/oyl7ZV0c8BofH14D+20RbXkXruzSmMX1fH15N/shfZxsxt
         owiDARWrWyFB3tM7EkBQYjafqhE/WtGQZPnAUyNasY5jjvHcaKxejfctHkBj9BoOsMcW
         vr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689283935; x=1689888735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uE2YAXIfa27t8d7003nbDI5x+mHqZ1rdoLrWvEaqvXc=;
        b=PYHtbLM5BKZw8zEXwnU24bXo5TatKI/056O9ARHmVTorsUBe7KOJuc8gZjlgyD6Agg
         3M5aDC3fgQFAQBPMpa6DQTJlgBWmNClVVMIWKfxtlGzCg2N/Ud5Sw49MAl0IvG4p2eqf
         sIIyx0UQ55iCFBK1Q1lfabhiBuimLAianxIalTeT1tUxV5P5bRwkvAS9kERowWO1tuwo
         r7J1K7Cyb11kukY+9DlNF0RoX6yADZ4+Vzd03C2El+FrJLdWV2CWybmcNwl6RhCKJrEX
         aI18Z1VifN5PWrEzvcN0HfFpoqkmRhtLtavWY+iarce5Ycyvpd6IyqLPWDZCpVpkbATy
         EjcA==
X-Gm-Message-State: ABy/qLaa7b6Anizvj4Tl0s77wLKuA/605lls9rX+h4Gvr+uqZFI6KuZZ
        BFqHTu4gGABdOKfvKfV0fN7oUx2eQWGfSwk3wvc=
X-Google-Smtp-Source: APBJJlFMcwhMPzWfM/Q07EpgCLHqZci0yEj4PnvzeEmX0W+29l7nEia/9MLiEyWO6Sz60mXIonN0JJFcl0lQPDxzzr8=
X-Received: by 2002:a2e:bc11:0:b0:2b7:40e4:8e2f with SMTP id
 b17-20020a2ebc11000000b002b740e48e2fmr2471463ljf.1.1689283934577; Thu, 13 Jul
 2023 14:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230713195416.30414-1-olga.kornievskaia@gmail.com>
 <A0663B9C-F005-4089-ABD6-542F77EE43ED@redhat.com> <2C013A73-79B2-446E-885B-33EF05916CCA@redhat.com>
In-Reply-To: <2C013A73-79B2-446E-885B-33EF05916CCA@redhat.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 13 Jul 2023 17:32:03 -0400
Message-ID: <CAN-5tyGx+TS2nxgnoU+ZOViDFBh1iRwg6JuSrteNbBrR2p2aUA@mail.gmail.com>
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

On Thu, Jul 13, 2023 at 5:16=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 13 Jul 2023, at 17:08, Benjamin Coddington wrote:
>
> > On 13 Jul 2023, at 15:54, Olga Kornievskaia wrote:
> >
> >> From: Olga Kornievskaia <kolga@netapp.com>
> >>
> >> Currently, if the OPEN compound experiencing an error and needs to
> >> get the file attributes separately, it will send a stand alone
> >> GETATTR but it would use the filehandle from the results of
> >> the OPEN compound. In case of the CLAIM_FH OPEN, nfs_openres's fh
> >> is zero value. That generate a GETATTR that's sent with a zero
> >> value filehandle, and results in the server returning an error.
> >>
> >> Instead, for the CLAIM_FH OPEN, take the filehandle that was used
> >> in the PUTFH of the OPEN compound.
> >>
> >> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> >> ---
> >>  fs/nfs/nfs4proc.c | 6 +++++-
> >>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> >> index 8edc610dc1d3..0b1b49f01c5b 100644
> >> --- a/fs/nfs/nfs4proc.c
> >> +++ b/fs/nfs/nfs4proc.c
> >> @@ -2703,8 +2703,12 @@ static int _nfs4_proc_open(struct nfs4_opendata=
 *data,
> >>                      return status;
> >>      }
> >>      if (!(o_res->f_attr->valid & NFS_ATTR_FATTR)) {
> >> +            struct nfs_fh *fh =3D &o_res->fh;
> >> +
> >>              nfs4_sequence_free_slot(&o_res->seq_res);
> >> -            nfs4_proc_getattr(server, &o_res->fh, o_res->f_attr, NULL=
);
> >> +            if (o_arg->claim =3D=3D NFS4_OPEN_CLAIM_FH)
> >> +                    fh =3D NFS_FH(d_inode(data->dentry));
> >> +            nfs4_proc_getattr(server, fh, o_res->f_attr, NULL);
> >>      }
> >>      return 0;
> >>  }
> >
> > Looks good, but why not just use o_arg->fh?  Maybe also an opportunity
> > to fix the whitespace damage a few lines before this hunk too.
> >
> > Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
>
> .. and should we handle the other OPEN_CLAIM cases that use the filehandl=
e
> as well?

I was pondering about that but I think the other OPEN CLAIM that use
the FH directly are recovery opens. I'm not sure if they need this.

>
> Ben
>
