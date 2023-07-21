Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C4975CF63
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 18:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjGUQcf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 12:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjGUQcO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 12:32:14 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB244226;
        Fri, 21 Jul 2023 09:30:47 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b74310566cso32237511fa.2;
        Fri, 21 Jul 2023 09:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689956984; x=1690561784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qHEqgw4Pn9UBisxvApajhxxyFeSD6XeoYA6uu/VXuk=;
        b=efCdlvV4kcBAvo3uKPnikg+rdKkPtqRGCHlZQQ+gwAacf3Bq2Xjx4qdyEdUdZY9a4x
         dL5rJ0nRmvG1c99qlRZg+qSOEtgfojzjLjVP+j3h+drmUV/BPKRnE/MS2eTOeuVVDO1a
         NMQDXluAJ/iky05gy79d5WQSMHL33cbRBkMYGDZjwI2yaLnrrgVG5ZboaKA06TYbOkZx
         HtKMqerrzweOmyGMYoBRCnwJjIr9c80w1gKqAowIOCayHm22Ka9U2nexqUq+EJyFC/NB
         jgKlygAybq3MbiTuwbUR+yN/Vz7DoMyakDajl7FCblCFBGFSDyea9yvNLJRnJH5GO+Eo
         Fz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689956984; x=1690561784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qHEqgw4Pn9UBisxvApajhxxyFeSD6XeoYA6uu/VXuk=;
        b=QZJFo4dMQk+j6NyUoxXqHNUdgRjFtIA+uEKqAdKpdm+ZQ3EnP+1+cRaSzQ7p29LouC
         2RqYcLzdDvTzhQYHhg6IJXu22B+tVUhNjjx9e5ys39x61iUc44X9EirfaEpHq9wmH8pk
         WHFRSsvypy7K6LyapqWpxJIo2m/cbylDwiaiiABp0dvC+pPt4rJs1RdmyMcjXwGSYGs0
         cYvv1qM3P7PQBU9dVg2GTNPnCr73z2hllkvvgT7pMqLvLXxJRs0tFdXIlexxxzfMM0Lu
         CO6kSz7iPRdkjF86vuVItOE2DwFTB40oexl/pkgN9Glgt/nIsplo28hGLRqtTbbV5lS6
         Vt2w==
X-Gm-Message-State: ABy/qLYEISB9SAahs+v/oL8HHKaSaT4AZRsdWENbgTWGFN1Rf4xKikMp
        3B2nsI5qdTazA35WDnG3kV+b/C6PJJtMymNd11LoKsH+
X-Google-Smtp-Source: APBJJlE+JiQAHHsvuU+tQsoIodHiDuMZZaAbw05uWYVkwhcstIm99YrMlAYm7UqlKLuyjfxvnWSENO+SqVtq9kdh3+k=
X-Received: by 2002:a2e:b1d3:0:b0:2b9:3684:165 with SMTP id
 e19-20020a2eb1d3000000b002b936840165mr1868107lja.8.1689956983928; Fri, 21 Jul
 2023 09:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230721142642.45871-1-jlayton@kernel.org>
In-Reply-To: <20230721142642.45871-1-jlayton@kernel.org>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 21 Jul 2023 18:29:32 +0200
Message-ID: <CAHpGcM+JCXu6TVrt+-woHCRFTKD2Dr_x6Xp0n4fw9aJHScbbMw@mail.gmail.com>
Subject: Re: [PATCH] nfsd: better conform to setfacl's method for setting
 missing ACEs
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
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

Am Fr., 21. Juli 2023 um 16:26 Uhr schrieb Jeff Layton <jlayton@kernel.org>=
:
> Andreas pointed out that the way we're setting missing ACEs doesn't
> quite conform to what setfacl does. Change it to better conform to
> how setfacl does this.

Thanks, this looks reasonable.

Andreas

> Cc: Andreas Gr=C3=BCnbacher <andreas.gruenbacher@gmail.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4acl.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> Chuck, it might be best to fold this into the original patch, if it
> looks ok.
>
> diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
> index 64e45551d1b6..9ec61bd0e11b 100644
> --- a/fs/nfsd/nfs4acl.c
> +++ b/fs/nfsd/nfs4acl.c
> @@ -742,14 +742,15 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl =
*acl,
>          *  no owner, owning group, or others entry,  a  copy of  the  AC=
L
>          *  owner, owning group, or others entry is added to the Default =
ACL."
>          *
> -        * If none of the requisite ACEs were set, and some explicit user=
 or group
> -        * ACEs were, copy the requisite entries from the effective set.
> +        * Copy any missing ACEs from the effective set.
>          */
> -       if (!default_acl_state.valid &&
> -           (default_acl_state.users->n || default_acl_state.groups->n)) =
{
> -               default_acl_state.owner =3D effective_acl_state.owner;
> -               default_acl_state.group =3D effective_acl_state.group;
> -               default_acl_state.other =3D effective_acl_state.other;
> +       if (default_acl_state.users->n || default_acl_state.groups->n) {
> +               if (!(default_acl_state.valid & ACL_USER_OBJ))
> +                       default_acl_state.owner =3D effective_acl_state.o=
wner;
> +               if (!(default_acl_state.valid & ACL_GROUP_OBJ))
> +                       default_acl_state.group =3D effective_acl_state.g=
roup;
> +               if (!(default_acl_state.valid & ACL_OTHER))
> +                       default_acl_state.other =3D effective_acl_state.o=
ther;
>         }
>
>         *pacl =3D posix_state_to_acl(&effective_acl_state, flags);
> --
> 2.41.0
>
