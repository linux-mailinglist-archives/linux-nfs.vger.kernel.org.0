Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCBA6FBD46
	for <lists+linux-nfs@lfdr.de>; Tue,  9 May 2023 04:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjEICbx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 May 2023 22:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjEICbv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 May 2023 22:31:51 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9613AA5
        for <linux-nfs@vger.kernel.org>; Mon,  8 May 2023 19:31:47 -0700 (PDT)
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A058F3F229
        for <linux-nfs@vger.kernel.org>; Tue,  9 May 2023 02:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683599504;
        bh=PU1OLdX01YDDG26M4QS6MQQfkEnrym1NDlR+hrR8gA8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=HJ6MGYkQ6LrFlNc4wf/D9JY4ahIBX8O833edSuY2L1uudUQpbvSSoeV7CBm0j/Fly
         YAZJMazq0s+A939MgQXAuv7KL3+aZYe+aZjrv/wkweHCtwODaESmCTlCWLpZxEr4RB
         Mf6oZSB+r+MVXtYOmqhKgA8FHAVkqb2VOiJ6MD/dfi+P8GLFMBk/V92WL7bCdwfDFE
         +nrVVMO73tcRhLX9fvwjZA/tI6vTs3W9mzm4OXaAXqMLF40gjtSJjBuOmklEaGc+5R
         uSmiEVeQbLsQ77h81pJajVenbMVc+QOxs7+KazNqIevV1YQEEdAPdJVVZFXfWeYW7x
         LWtRGS9Y4ofvg==
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-ba2b9ecfadaso3655422276.2
        for <linux-nfs@vger.kernel.org>; Mon, 08 May 2023 19:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683599503; x=1686191503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PU1OLdX01YDDG26M4QS6MQQfkEnrym1NDlR+hrR8gA8=;
        b=KidlHp4dbKeUJ+zkeC4zRNySe59VZTA2ElOcvSw0FpN+bANL7L/3dNFDYQDeGc3FcJ
         4Tp6Gpl2hBfjryGVgxohgaTCD/E3lBBMUUc3XawNLJHCyLMdWmACtskdm8jOjAstxCC1
         Wg+JXWlpjcYjtgPLflPCvsUxVMaFOrkFJKIZQJbAXHgMM3eYHt+jAbWdIn2tHOFlDYIZ
         Gb2DHiQlJY5BfHyV+CI0/7TSglQXJ4TnkPB13gIIZpqm2UuL3bH1xqBI1f/sdx/JWnc/
         7WKE6YYPPX2hc7A+K2QpLKUVFuyLkDW2DGbgoSaphtUqJD0BugbR8Rr29odGeKMetT0m
         iykw==
X-Gm-Message-State: AC+VfDzMLPPudPdq+nys0njmrYjHgQSZz1qOGxuQgOYQI+f4UDRw+RQK
        CLQGZfNaD1kHXk148ybu4ZcXxOt1PP7BmsSdZBqnPLJtlCcW2qQb15DY42bI6Z4Nzi24f1I5b7C
        JMu3uCWKL6ielJXQR8cQabV4yje65tVXl+QdV/kBjRHEB5QokjUiqL8Q3RLDk25t9
X-Received: by 2002:a25:d185:0:b0:b9d:7887:4423 with SMTP id i127-20020a25d185000000b00b9d78874423mr14976493ybg.16.1683599503356;
        Mon, 08 May 2023 19:31:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ74VBAq6LWXxyQnoiM2BKvO6NxFZ7mC8NQe3lskTY2OIyRRQpHN0uFc/ScvPbjuwTXQOjR+xdffO6DDzIeK7Cs=
X-Received: by 2002:a25:d185:0:b0:b9d:7887:4423 with SMTP id
 i127-20020a25d185000000b00b9d78874423mr14976480ybg.16.1683599503035; Mon, 08
 May 2023 19:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230411030248.53356-1-chengen.du@canonical.com>
 <CAPt2mGNqqDeRMeCSVh6oX_=nS0UcGCfhBfVcuaVG9HpdwVSzVg@mail.gmail.com> <CAPza5qee7vHKwjwhS27xB8xXTgAFHEmv7eiFk6zGTUUc4s8=TQ@mail.gmail.com>
In-Reply-To: <CAPza5qee7vHKwjwhS27xB8xXTgAFHEmv7eiFk6zGTUUc4s8=TQ@mail.gmail.com>
From:   Chengen Du <chengen.du@canonical.com>
Date:   Tue, 9 May 2023 10:31:32 +0800
Message-ID: <CAPza5qcz_-zSJ0AQkq6tnhYvY7Gs+qAnDoaqiH67zgWhjAtAkA@mail.gmail.com>
Subject: Re: [PATCH] NFS: Add mount option 'nofasc'
To:     trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

I sincerely apologize for interrupting you, as I understand that you
may have other pressing matters to attend to.
However, I was hoping to bring your attention to a pressing matter
that a number of community users are currently experiencing.
As can be seen in this link:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2015827,
the issue at hand is causing a significant amount of inconvenience to
many individuals.

If it wouldn't be too much trouble, I would be immensely grateful if
you could spare a moment to examine the patch and perhaps offer some
guidance on how best to proceed.
Your assistance in this matter would be greatly appreciated.

Best regards,
Chengen Du

On Tue, Apr 25, 2023 at 9:41=E2=80=AFAM Chengen Du <chengen.du@canonical.co=
m> wrote:
>
> Hi,
>
> May I ask if there are any concerns or opinions regarding the
> introduction of the new mount option?
> If there is a more suitable solution, we can discuss it, and I can
> work on implementing it.
>
> Best regards,
> Chengen Du
>
> On Wed, Apr 19, 2023 at 3:18=E2=80=AFPM Daire Byrne <daire@dneg.com> wrot=
e:
> >
> > Just to say, I am personally for this or some other way to opt out of
> > the increased ACCESS calls on select servers (e.g. ones with high
> > latency or with lots of multi user logins).
> >
> > I see it as similar to "actimeo" and "nocto" options in allowing users
> > to reduce "correctness" at their own risk if it helps with their
> > workloads and they deem the risk worth it.
> >
> > I am currently reverting the original patches in our kernel for our
> > nfs re-exporting workloads.
> >
> > Daire
> >
> >
> > On Tue, 11 Apr 2023 at 04:03, Chengen Du <chengen.du@canonical.com> wro=
te:
> > >
> > > This mount option is used to skip clearing the file access cache
> > > upon login. Some users or applications switch to other privileged
> > > users via commands such as 'su' to operate on NFS-mounted folders.
> > > In such cases, the privileged user's login time will be renewed,
> > > and NFS ACCESS operations will need to be re-sent, potentially
> > > leading to performance degradation.
> > > In some production environments where the access cache can be
> > > trusted due to stable group membership, this option could be
> > > particularly useful.
> > >
> > > Signed-off-by: Chengen Du <chengen.du@canonical.com>
> > > ---
> > >  fs/nfs/dir.c              | 21 ++++++++++++---------
> > >  fs/nfs/fs_context.c       |  8 ++++++++
> > >  fs/nfs/super.c            |  1 +
> > >  include/linux/nfs_fs_sb.h |  1 +
> > >  4 files changed, 22 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > > index 6fbcbb8d6587..9a6d86e2044e 100644
> > > --- a/fs/nfs/dir.c
> > > +++ b/fs/nfs/dir.c
> > > @@ -2953,12 +2953,14 @@ static struct nfs_access_entry *nfs_access_se=
arch_rbtree(struct inode *inode, co
> > >         return NULL;
> > >  }
> > >
> > > -static u64 nfs_access_login_time(const struct task_struct *task,
> > > -                                const struct cred *cred)
> > > +static inline
> > > +bool nfs_check_access_stale(const struct task_struct *task,
> > > +                           const struct cred *cred,
> > > +                           const struct nfs_access_entry *cache)
> > >  {
> > >         const struct task_struct *parent;
> > >         const struct cred *pcred;
> > > -       u64 ret;
> > > +       u64 login_time;
> > >
> > >         rcu_read_lock();
> > >         for (;;) {
> > > @@ -2968,15 +2970,15 @@ static u64 nfs_access_login_time(const struct=
 task_struct *task,
> > >                         break;
> > >                 task =3D parent;
> > >         }
> > > -       ret =3D task->start_time;
> > > +       login_time =3D task->start_time;
> > >         rcu_read_unlock();
> > > -       return ret;
> > > +
> > > +       return ((s64)(login_time - cache->timestamp) > 0);
> > >  }
> > >
> > >  static int nfs_access_get_cached_locked(struct inode *inode, const s=
truct cred *cred, u32 *mask, bool may_block)
> > >  {
> > >         struct nfs_inode *nfsi =3D NFS_I(inode);
> > > -       u64 login_time =3D nfs_access_login_time(current, cred);
> > >         struct nfs_access_entry *cache;
> > >         bool retry =3D true;
> > >         int err;
> > > @@ -3005,7 +3007,8 @@ static int nfs_access_get_cached_locked(struct =
inode *inode, const struct cred *
> > >                 retry =3D false;
> > >         }
> > >         err =3D -ENOENT;
> > > -       if ((s64)(login_time - cache->timestamp) > 0)
> > > +       if (!(NFS_SERVER(inode)->flags & NFS_MOUNT_NOFASC) &&
> > > +           nfs_check_access_stale(current, cred, cache))
> > >                 goto out;
> > >         *mask =3D cache->mask;
> > >         list_move_tail(&cache->lru, &nfsi->access_cache_entry_lru);
> > > @@ -3025,7 +3028,6 @@ static int nfs_access_get_cached_rcu(struct ino=
de *inode, const struct cred *cre
> > >          * but do it without locking.
> > >          */
> > >         struct nfs_inode *nfsi =3D NFS_I(inode);
> > > -       u64 login_time =3D nfs_access_login_time(current, cred);
> > >         struct nfs_access_entry *cache;
> > >         int err =3D -ECHILD;
> > >         struct list_head *lh;
> > > @@ -3040,7 +3042,8 @@ static int nfs_access_get_cached_rcu(struct ino=
de *inode, const struct cred *cre
> > >                 cache =3D NULL;
> > >         if (cache =3D=3D NULL)
> > >                 goto out;
> > > -       if ((s64)(login_time - cache->timestamp) > 0)
> > > +       if (!(NFS_SERVER(inode)->flags & NFS_MOUNT_NOFASC) &&
> > > +           nfs_check_access_stale(current, cred, cache))
> > >                 goto out;
> > >         if (nfs_check_cache_invalid(inode, NFS_INO_INVALID_ACCESS))
> > >                 goto out;
> > > diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> > > index 9bcd53d5c7d4..5cd9b2882c79 100644
> > > --- a/fs/nfs/fs_context.c
> > > +++ b/fs/nfs/fs_context.c
> > > @@ -88,6 +88,7 @@ enum nfs_param {
> > >         Opt_vers,
> > >         Opt_wsize,
> > >         Opt_write,
> > > +       Opt_fasc,
> > >  };
> > >
> > >  enum {
> > > @@ -194,6 +195,7 @@ static const struct fs_parameter_spec nfs_fs_para=
meters[] =3D {
> > >         fsparam_string("vers",          Opt_vers),
> > >         fsparam_enum  ("write",         Opt_write, nfs_param_enums_wr=
ite),
> > >         fsparam_u32   ("wsize",         Opt_wsize),
> > > +       fsparam_flag_no("fasc",         Opt_fasc),
> > >         {}
> > >  };
> > >
> > > @@ -861,6 +863,12 @@ static int nfs_fs_context_parse_param(struct fs_=
context *fc,
> > >         case Opt_sloppy:
> > >                 ctx->sloppy =3D true;
> > >                 break;
> > > +       case Opt_fasc:
> > > +               if (result.negated)
> > > +                       ctx->flags |=3D NFS_MOUNT_NOFASC;
> > > +               else
> > > +                       ctx->flags &=3D ~NFS_MOUNT_NOFASC;
> > > +               break;
> > >         }
> > >
> > >         return 0;
> > > diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> > > index 05ae23657527..059513d403f8 100644
> > > --- a/fs/nfs/super.c
> > > +++ b/fs/nfs/super.c
> > > @@ -444,6 +444,7 @@ static void nfs_show_mount_options(struct seq_fil=
e *m, struct nfs_server *nfss,
> > >                 { NFS_MOUNT_NORDIRPLUS, ",nordirplus", "" },
> > >                 { NFS_MOUNT_UNSHARED, ",nosharecache", "" },
> > >                 { NFS_MOUNT_NORESVPORT, ",noresvport", "" },
> > > +               { NFS_MOUNT_NOFASC, ",nofasc", "" },
> > >                 { 0, NULL, NULL }
> > >         };
> > >         const struct proc_nfs_info *nfs_infop;
> > > diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> > > index ea2f7e6b1b0b..a39ae1bd2217 100644
> > > --- a/include/linux/nfs_fs_sb.h
> > > +++ b/include/linux/nfs_fs_sb.h
> > > @@ -153,6 +153,7 @@ struct nfs_server {
> > >  #define NFS_MOUNT_WRITE_EAGER          0x01000000
> > >  #define NFS_MOUNT_WRITE_WAIT           0x02000000
> > >  #define NFS_MOUNT_TRUNK_DISCOVERY      0x04000000
> > > +#define NFS_MOUNT_NOFASC               0x08000000
> > >
> > >         unsigned int            fattr_valid;    /* Valid attributes *=
/
> > >         unsigned int            caps;           /* server capabilitie=
s */
> > > --
> > > 2.37.2
> > >
