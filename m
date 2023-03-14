Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F72D6B920D
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Mar 2023 12:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjCNLuN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Mar 2023 07:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjCNLuN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Mar 2023 07:50:13 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8646F1814B
        for <linux-nfs@vger.kernel.org>; Tue, 14 Mar 2023 04:50:09 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id by13so13839625vsb.3
        for <linux-nfs@vger.kernel.org>; Tue, 14 Mar 2023 04:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678794608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjPVqtaOTeOVwAw3mvVvciUuMTo4DHmzUtmhcH6zrUE=;
        b=kkB1VLGGfKW09y5C9Wmh3wv0AgffDmsBC4N9jsrnCmbnbCkatx+mF5h8JgOFQoqaza
         MElZo0Scj0XejiE0aBlQUykwpDz5zICIoi2aDDrEb4em+eh9F1sZooBrzRQ7uAkNYeSP
         5+sKTb0g6buiDwf3/1gFEEGU4kkPJtRJV7xH9IgkyEnQiLuV2WE2W4SwX/VxkeXQpVKB
         yywZ/RAmupZFA6vV54wP5qwk8j/m5STQ0fXbsKiVM75cwaiRIfFjPE8blvvBo8G+6/3H
         xvByrlvfJZVt3WQPECmK/i3h30ompsE5JV+K7Hyc6qInrv2jM0D1k1hGvS4X84nWnm6k
         XLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678794608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjPVqtaOTeOVwAw3mvVvciUuMTo4DHmzUtmhcH6zrUE=;
        b=oqH7NbD+bmKds4NSvZjyFGuvtdXK5B7rl4J6iq0YN4jAQafN4u1KnU2J1wP0Cw+hX4
         dwdSzyJmpITu30/Td5TY+y50YhGhiUrtIBv7PZbZaZfQb7QJHqNd+5IOH3GgLOhAQrG/
         dyTmEPjysAUPnIVrCd1l1TL3sYFyqHiPWOIB6pqQgKctrpyoPNDCNseJDjyhjsBFXU7l
         4UtYU2Aynj3GGfcloodJML3gfpbw78hXXS1Aw4q2tnqgh4LjEVDpnuWShXEaI96F5Alw
         7H1U5WHHDjl0ZllI08MBKiVOogthg6QGDKAOfqc6udHbW1T2f/CCfHfkIGVduF/eF4uo
         wIuw==
X-Gm-Message-State: AO0yUKVe1uKL9CQdlB9tFC1Qpc60JKpllZB+1DygNsbP0PDdZd6qdk8j
        aHlzsDbGz4X9biToH3Ch3WR8r+6yKjs+T6NSef99pf6/eeY=
X-Google-Smtp-Source: AK7set/z1sm+cjmNavyuCqfZkWbCxVTzgUYHl5WnDcfCKyi6064RtrXqTTKPA6OJ6jBWjr3GpxUKdwrch1g24kD6xaQ=
X-Received: by 2002:a67:ea49:0:b0:411:a740:c3ea with SMTP id
 r9-20020a67ea49000000b00411a740c3eamr25055870vso.0.1678794608509; Tue, 14 Mar
 2023 04:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230314102058.10761-1-jlayton@kernel.org>
In-Reply-To: <20230314102058.10761-1-jlayton@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 14 Mar 2023 13:49:57 +0200
Message-ID: <CAOQ4uxgrgNAJHGjqo1B05aEa5zXO+UYUPNUHfJA6GKLoiPfUUw@mail.gmail.com>
Subject: Re: [PATCH] lockd: set file_lock start and end when decoding nlm4 testargs
To:     Jeff Layton <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, trond.myklebust@hammerspace.com,
        anna@kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 14, 2023 at 12:21=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> Commit 6930bcbfb6ce dropped the setting of the file_lock range when
> decoding a nlm_lock off the wire. This causes the client side grant
> callback to miss matching blocks and reject the lock, only to rerequest
> it 30s later.
>
> Add a helper function to set the file_lock range from the start and end
> values that the protocol uses, and have the nlm_lock decoder call that to
> set up the file_lock args properly.
>
> Fixes: 6930bcbfb6ce ("lockd: detect and reject lock arguments that overfl=
ow")
> Reported-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/lockd/clnt4xdr.c        |  9 +--------
>  fs/lockd/xdr4.c            | 13 ++++++++++++-
>  include/linux/lockd/xdr4.h |  1 +
>  3 files changed, 14 insertions(+), 9 deletions(-)
>
> Hi Amir,
>
> Thanks for the bug report. This patch seems to fix up the 30s stalls for
> me. Can you give it a spin and see if it also helps you? I am still

Works like a charm :)

I tested a backport to 5.15.y (trivial conflict in h file).
against 5.10.109 and 5.15.88 servers.

Tested-by: Amir Goldstein <amir73il@gmail.com>

> seeing one test failure with nfstest_lock, but I'm not sure it's related
> to this. I'll plan to follow up with Jorge.

I don't see this failure in my tests.

Please fast track this fix which also fixes an LTS 5.15.y kernel regression=
.
Please cc stable and let me know if you want me to post the 5.15.y backport=
.

Thanks for the prompt fix,
Amir.

>
> Thanks,
> Jeff
>
> diff --git a/fs/lockd/clnt4xdr.c b/fs/lockd/clnt4xdr.c
> index 7df6324ccb8a..8161667c976f 100644
> --- a/fs/lockd/clnt4xdr.c
> +++ b/fs/lockd/clnt4xdr.c
> @@ -261,7 +261,6 @@ static int decode_nlm4_holder(struct xdr_stream *xdr,=
 struct nlm_res *result)
>         u32 exclusive;
>         int error;
>         __be32 *p;
> -       s32 end;
>
>         memset(lock, 0, sizeof(*lock));
>         locks_init_lock(fl);
> @@ -285,13 +284,7 @@ static int decode_nlm4_holder(struct xdr_stream *xdr=
, struct nlm_res *result)
>         fl->fl_type  =3D exclusive !=3D 0 ? F_WRLCK : F_RDLCK;
>         p =3D xdr_decode_hyper(p, &l_offset);
>         xdr_decode_hyper(p, &l_len);
> -       end =3D l_offset + l_len - 1;
> -
> -       fl->fl_start =3D (loff_t)l_offset;
> -       if (l_len =3D=3D 0 || end < 0)
> -               fl->fl_end =3D OFFSET_MAX;
> -       else
> -               fl->fl_end =3D (loff_t)end;
> +       nlm4svc_set_file_lock_range(fl, l_offset, l_len);
>         error =3D 0;
>  out:
>         return error;
> diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
> index 712fdfeb8ef0..5fcbf30cd275 100644
> --- a/fs/lockd/xdr4.c
> +++ b/fs/lockd/xdr4.c
> @@ -33,6 +33,17 @@ loff_t_to_s64(loff_t offset)
>         return res;
>  }
>
> +void nlm4svc_set_file_lock_range(struct file_lock *fl, u64 off, u64 len)
> +{
> +       s64 end =3D off + len - 1;
> +
> +       fl->fl_start =3D off;
> +       if (len =3D=3D 0 || end < 0)
> +               fl->fl_end =3D OFFSET_MAX;
> +       else
> +               fl->fl_end =3D end;
> +}
> +
>  /*
>   * NLM file handles are defined by specification to be a variable-length
>   * XDR opaque no longer than 1024 bytes. However, this implementation
> @@ -80,7 +91,7 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_l=
ock *lock)
>         locks_init_lock(fl);
>         fl->fl_flags =3D FL_POSIX;
>         fl->fl_type  =3D F_RDLCK;
> -
> +       nlm4svc_set_file_lock_range(fl, lock->lock_start, lock->lock_len)=
;
>         return true;
>  }
>
> diff --git a/include/linux/lockd/xdr4.h b/include/linux/lockd/xdr4.h
> index 9a6b55da8fd6..72831e35dca3 100644
> --- a/include/linux/lockd/xdr4.h
> +++ b/include/linux/lockd/xdr4.h
> @@ -22,6 +22,7 @@
>  #define        nlm4_fbig               cpu_to_be32(NLM_FBIG)
>  #define        nlm4_failed             cpu_to_be32(NLM_FAILED)
>
> +void   nlm4svc_set_file_lock_range(struct file_lock *fl, u64 off, u64 le=
n);
>  bool   nlm4svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xd=
r);
>  bool   nlm4svc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream=
 *xdr);
>  bool   nlm4svc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream=
 *xdr);
> --
> 2.39.2
>
