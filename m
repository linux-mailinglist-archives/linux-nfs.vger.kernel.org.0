Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C7C6BA006
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Mar 2023 20:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjCNTux (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Mar 2023 15:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjCNTur (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Mar 2023 15:50:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF5540F3
        for <linux-nfs@vger.kernel.org>; Tue, 14 Mar 2023 12:50:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA6CF6196E
        for <linux-nfs@vger.kernel.org>; Tue, 14 Mar 2023 19:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18874C4339B
        for <linux-nfs@vger.kernel.org>; Tue, 14 Mar 2023 19:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678823445;
        bh=bpiT7i02i1UtKfpmSM2m8tEB8PsaWk+/SA6Id/G06Lo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a8/ljS5PH7gAIR/hlhHE8JCDIFAPOWe4/3OhuVmFKdCgMmCixPLBNaY2yGw6Pq5qj
         +herIOXUEiH4B+ahqXlp4A5wXcjDSN8OMhSqmHYc5GtataATogSqM0NOl2v3CqAL5K
         TbPxKSDHfyXUHYup7jAKuGx/liAXYxmyyoba6rhbGJwQvMhl7WTp+U9MH1+gtFWk+e
         gKWJtD81wsiVDTqQCvjG3tQ2l+aVzigKT8hF/u0pYUo4puvjzPWHV7NlP+Hnd5jHQH
         /qFRCdmm2tW8BrTmpGSb5YIdlDyCBHPgdIOEAgaXh9BmUznM7QS5RBGRuzyViuL4TF
         bM0Sd4GbD/olg==
Received: by mail-qv1-f42.google.com with SMTP id g9so13059181qvt.8
        for <linux-nfs@vger.kernel.org>; Tue, 14 Mar 2023 12:50:45 -0700 (PDT)
X-Gm-Message-State: AO0yUKWPL8L7zBhyFLGWv5u5+GKZnXFHBb8BS2z9E84eoHKRSiHqj0aR
        Wo2QeNg9ylRMBV+oOSAjeBLTwYfIJbI+paMU/lg=
X-Google-Smtp-Source: AK7set/oVnqkZubvhKphx9foxafaQFodqjwy+cqDTEkEM3H1G312Z+zRg1D2FzUJmcxryXxK0XUVcFP2fyRrtqa8TZI=
X-Received: by 2002:ac8:4588:0:b0:3d4:ae71:9632 with SMTP id
 l8-20020ac84588000000b003d4ae719632mr51143qtn.13.1678823444178; Tue, 14 Mar
 2023 12:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230314102058.10761-1-jlayton@kernel.org> <CAOQ4uxgrgNAJHGjqo1B05aEa5zXO+UYUPNUHfJA6GKLoiPfUUw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgrgNAJHGjqo1B05aEa5zXO+UYUPNUHfJA6GKLoiPfUUw@mail.gmail.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Tue, 14 Mar 2023 15:50:28 -0400
X-Gmail-Original-Message-ID: <CAFX2JfnZ9KBp3nJPoCT1tte+iL-_Lz8GD=2yo1SHzSdFsQMJ3A@mail.gmail.com>
Message-ID: <CAFX2JfnZ9KBp3nJPoCT1tte+iL-_Lz8GD=2yo1SHzSdFsQMJ3A@mail.gmail.com>
Subject: Re: [PATCH] lockd: set file_lock start and end when decoding nlm4 testargs
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com,
        trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 14, 2023 at 7:50=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Mar 14, 2023 at 12:21=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> >
> > Commit 6930bcbfb6ce dropped the setting of the file_lock range when
> > decoding a nlm_lock off the wire. This causes the client side grant
> > callback to miss matching blocks and reject the lock, only to rerequest
> > it 30s later.
> >
> > Add a helper function to set the file_lock range from the start and end
> > values that the protocol uses, and have the nlm_lock decoder call that =
to
> > set up the file_lock args properly.
> >
> > Fixes: 6930bcbfb6ce ("lockd: detect and reject lock arguments that over=
flow")
> > Reported-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/lockd/clnt4xdr.c        |  9 +--------
> >  fs/lockd/xdr4.c            | 13 ++++++++++++-
> >  include/linux/lockd/xdr4.h |  1 +
> >  3 files changed, 14 insertions(+), 9 deletions(-)
> >
> > Hi Amir,
> >
> > Thanks for the bug report. This patch seems to fix up the 30s stalls fo=
r
> > me. Can you give it a spin and see if it also helps you? I am still
>
> Works like a charm :)
>
> I tested a backport to 5.15.y (trivial conflict in h file).
> against 5.10.109 and 5.15.88 servers.
>
> Tested-by: Amir Goldstein <amir73il@gmail.com>
>
> > seeing one test failure with nfstest_lock, but I'm not sure it's relate=
d
> > to this. I'll plan to follow up with Jorge.
>
> I don't see this failure in my tests.
>
> Please fast track this fix which also fixes an LTS 5.15.y kernel regressi=
on.
> Please cc stable and let me know if you want me to post the 5.15.y backpo=
rt.

Thanks Jeff and Amir! I have the patch queued up, and I'll do a
bugfixes pull request later this week.

Anna

>
> Thanks for the prompt fix,
> Amir.
>
> >
> > Thanks,
> > Jeff
> >
> > diff --git a/fs/lockd/clnt4xdr.c b/fs/lockd/clnt4xdr.c
> > index 7df6324ccb8a..8161667c976f 100644
> > --- a/fs/lockd/clnt4xdr.c
> > +++ b/fs/lockd/clnt4xdr.c
> > @@ -261,7 +261,6 @@ static int decode_nlm4_holder(struct xdr_stream *xd=
r, struct nlm_res *result)
> >         u32 exclusive;
> >         int error;
> >         __be32 *p;
> > -       s32 end;
> >
> >         memset(lock, 0, sizeof(*lock));
> >         locks_init_lock(fl);
> > @@ -285,13 +284,7 @@ static int decode_nlm4_holder(struct xdr_stream *x=
dr, struct nlm_res *result)
> >         fl->fl_type  =3D exclusive !=3D 0 ? F_WRLCK : F_RDLCK;
> >         p =3D xdr_decode_hyper(p, &l_offset);
> >         xdr_decode_hyper(p, &l_len);
> > -       end =3D l_offset + l_len - 1;
> > -
> > -       fl->fl_start =3D (loff_t)l_offset;
> > -       if (l_len =3D=3D 0 || end < 0)
> > -               fl->fl_end =3D OFFSET_MAX;
> > -       else
> > -               fl->fl_end =3D (loff_t)end;
> > +       nlm4svc_set_file_lock_range(fl, l_offset, l_len);
> >         error =3D 0;
> >  out:
> >         return error;
> > diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
> > index 712fdfeb8ef0..5fcbf30cd275 100644
> > --- a/fs/lockd/xdr4.c
> > +++ b/fs/lockd/xdr4.c
> > @@ -33,6 +33,17 @@ loff_t_to_s64(loff_t offset)
> >         return res;
> >  }
> >
> > +void nlm4svc_set_file_lock_range(struct file_lock *fl, u64 off, u64 le=
n)
> > +{
> > +       s64 end =3D off + len - 1;
> > +
> > +       fl->fl_start =3D off;
> > +       if (len =3D=3D 0 || end < 0)
> > +               fl->fl_end =3D OFFSET_MAX;
> > +       else
> > +               fl->fl_end =3D end;
> > +}
> > +
> >  /*
> >   * NLM file handles are defined by specification to be a variable-leng=
th
> >   * XDR opaque no longer than 1024 bytes. However, this implementation
> > @@ -80,7 +91,7 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm=
_lock *lock)
> >         locks_init_lock(fl);
> >         fl->fl_flags =3D FL_POSIX;
> >         fl->fl_type  =3D F_RDLCK;
> > -
> > +       nlm4svc_set_file_lock_range(fl, lock->lock_start, lock->lock_le=
n);
> >         return true;
> >  }
> >
> > diff --git a/include/linux/lockd/xdr4.h b/include/linux/lockd/xdr4.h
> > index 9a6b55da8fd6..72831e35dca3 100644
> > --- a/include/linux/lockd/xdr4.h
> > +++ b/include/linux/lockd/xdr4.h
> > @@ -22,6 +22,7 @@
> >  #define        nlm4_fbig               cpu_to_be32(NLM_FBIG)
> >  #define        nlm4_failed             cpu_to_be32(NLM_FAILED)
> >
> > +void   nlm4svc_set_file_lock_range(struct file_lock *fl, u64 off, u64 =
len);
> >  bool   nlm4svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *=
xdr);
> >  bool   nlm4svc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stre=
am *xdr);
> >  bool   nlm4svc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stre=
am *xdr);
> > --
> > 2.39.2
> >
