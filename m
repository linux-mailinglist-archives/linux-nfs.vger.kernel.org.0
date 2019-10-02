Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BECEC8E16
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Oct 2019 18:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfJBQQL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Oct 2019 12:16:11 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45784 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfJBQQK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Oct 2019 12:16:10 -0400
Received: by mail-ua1-f68.google.com with SMTP id j5so6849104uak.12
        for <linux-nfs@vger.kernel.org>; Wed, 02 Oct 2019 09:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P5C9H6xaO7xZ4+MGQxe8w/IOw0k1b2HvZM9PDPGtnW0=;
        b=u8m9/p+xq/ETdDF3WhKeynPakJfQfMwuFWKZwaoDfui0rd9Tf8V8r52s8ggmsXE5Xc
         yKcVl0LJK4I8EBZApXGVYWdbWLu1pQ6eVpnnyraIokgNMd38lJwRqs4sUGYXgKMLRdue
         W5es2g0A/RW2cWcdDBa/THRj/1hDRlVsxoSiu8vMuAQQWIPGqy2kQv2xfK2kpgtzQNXL
         VYmdZ8YEvJrrxI7+5hhJ/v40g8IpLbNBoxnV5JVKkFjDuD4xY7mmyXRgUDfK9Bgt69o0
         iWymPSQIRkv0K+/aMaUQ0E5HJ30TArYqy5QAIzhV1YYCS/qC5tXh8PTMHtGhyuX7t1YI
         bsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5C9H6xaO7xZ4+MGQxe8w/IOw0k1b2HvZM9PDPGtnW0=;
        b=RQHu4PGz44we7Kd/LonrKcQApII+Y8A2S5ZD86OO9NbjnsreGbD5QB9NemJYjfRGzY
         /m92EIywBKXpoI1G5ic0cYNsWhhJZ/U5DSpCUw8xg674PlwQmM/RMo34uyeVgqI4yU1P
         LJsCzNtiYND/C6CtIupVsEbbWbTlAQ71wFXcd1PzQGtp1vZa7/YoP14s6oQDFFK1H7Pm
         ARvn4bkgQM1Bc3VxV8cs1Zh+MF3M9kRirb/S8zoEbFdgh/fjgztZ2fGlKGm78wSuBklx
         kVZZV2c9mNsWWy4bjAjZnuwdfP/MMOTu8bCTJ6bls1D8g6z+MgWP79ORDu01ll6gs3oi
         W8dQ==
X-Gm-Message-State: APjAAAUdJXfKO4ju93T0zZpwXim6MYEKqZricFsYBw9fbQMtPiVOQSik
        BGlPmVhuQG4PC0hbzHrhp6iQqbszUaazPW5T0ZU=
X-Google-Smtp-Source: APXvYqwODpOJnTNst8njTvq3T7UAofdtMa0mflDLj4j/NIfr7361weG9eoegmVFUKey/7zKoRLjgSf/z8f/neUgpsXI=
X-Received: by 2002:ab0:6355:: with SMTP id f21mr2130467uap.40.1570032969760;
 Wed, 02 Oct 2019 09:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
 <20190916211353.18802-14-olga.kornievskaia@gmail.com> <20191002155220.GA19089@fieldses.org>
 <CAN-5tyFk9Aw=1MYhhymyxWG9+vkm+SBjoow+eG14QLnkAM0H+g@mail.gmail.com>
In-Reply-To: <CAN-5tyFk9Aw=1MYhhymyxWG9+vkm+SBjoow+eG14QLnkAM0H+g@mail.gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 2 Oct 2019 12:15:59 -0400
Message-ID: <CAN-5tyGTMcHq9EkLF9kyQWxbv+ViHB9eR7LQ_Lvf4P4PRvXmcg@mail.gmail.com>
Subject: Re: [PATCH v7 13/19] NFSD return nfs4_stid in nfs4_preprocess_stateid_op
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 2, 2019 at 12:12 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> On Wed, Oct 2, 2019 at 11:52 AM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Mon, Sep 16, 2019 at 05:13:47PM -0400, Olga Kornievskaia wrote:
> > > @@ -1026,7 +1026,8 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
> > >  static __be32
> > >  nfsd4_verify_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > >                 stateid_t *src_stateid, struct nfsd_file **src,
> > > -               stateid_t *dst_stateid, struct nfsd_file **dst)
> > > +               stateid_t *dst_stateid, struct nfsd_file **dst,
> > > +               struct nfs4_stid **stid)
> > >  {
> > >       __be32 status;
> > >
> > ...
> > > @@ -1072,7 +1073,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
> > >       __be32 status;
> > >
> > >       status = nfsd4_verify_copy(rqstp, cstate, &clone->cl_src_stateid, &src,
> > > -                                &clone->cl_dst_stateid, &dst);
> > > +                                &clone->cl_dst_stateid, &dst, NULL);
> > >       if (status)
> > >               goto out;
> > >
> > > @@ -1260,7 +1261,7 @@ static int nfsd4_do_async_copy(void *data)
> > >
> > >       status = nfsd4_verify_copy(rqstp, cstate, &copy->cp_src_stateid,
> > >                                  &copy->nf_src, &copy->cp_dst_stateid,
> > > -                                &copy->nf_dst);
> > > +                                &copy->nf_dst, NULL);
> > >       if (status)
> > >               goto out;
> > >
> >
> > So both callers pass NULL for the new stid parameter.  Looks like that's
> > still true after the full series of patches, too.
> >
>
> If you look at an earlier chunk it uses it (there is only a single
> user of it: copy notify state)

actually the 2 user nfsd4_verify_copy and nfsd4_copy_notify in a different patch

> @@ -1034,14 +1035,14 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst
> *rqstp, struct svc_fh *fh)
>                 return nfserr_nofilehandle;
>
>         status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->save_fh,
> -                                           src_stateid, RD_STATE, src);
> +                                           src_stateid, RD_STATE, src, NULL);
>         if (status) {
>                 dprintk("NFSD: %s: couldn't process src stateid!\n", __func__);
>                 goto out;
>         }
>
>         status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
> -                                           dst_stateid, WR_STATE, dst);
> +                                           dst_stateid, WR_STATE, dst, stid);
>         if (status) {
>                 dprintk("NFSD: %s: couldn't process dst stateid!\n", __func__);
>                 goto out_put_src;
>
> > --b.
