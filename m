Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE78C8DEE
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Oct 2019 18:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfJBQM3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Oct 2019 12:12:29 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:38677 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfJBQM3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Oct 2019 12:12:29 -0400
Received: by mail-vk1-f194.google.com with SMTP id s72so4450307vkh.5
        for <linux-nfs@vger.kernel.org>; Wed, 02 Oct 2019 09:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ASuVDA/8nPhLcMZq6VLeuTmaGOLUGR+NpZSh2eMYzCs=;
        b=KZwfnqFdmez3i/7gKJsKXzaOFwSamZtpS+dBzc/9avkrmiztkLO1HVFboCl+kuMuPn
         87u1bDbfTTCqqibowFTYziVypVfr4fdTjC8MvyaiIf3te0M6ZbR/bJE0ZmZdneXnzONn
         RBwmJ4ZzL/qaLzofypOzFqfgWWFS45sVyoOqqTucQC1CRidR+3txBTuTfDZyGjejazuZ
         QCnsh7BchVlQX065VSuEURCMULM/yNYZSqoPoprHYuoAExsHcyQELFgHPmhW15wl1EbY
         OTWnl/VvyrQ3FNM4X0ehCyWYcf8LiS/UUVSF961bZRi8Jz75srizz41QqMChVIl6s+Tb
         t8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ASuVDA/8nPhLcMZq6VLeuTmaGOLUGR+NpZSh2eMYzCs=;
        b=sW2hBXtL8NC4Fm4Gbol4Oyv+9lDG21kmGQvkFgG+ZIyZ9jQu68vtma/1ETwGYSLeay
         xbyrztkFwnRGB6z6QkYcOPdWp/pkGfo+Ryn5mHCUK7vxonfnOsW3mpqNCz7wsPHxXQl7
         dfDnL6ODH+AffCCdr3Ga21jDumXmg+1XJZmJ5cthwTXeM1IvVeq6pboTauXgDeZjAdkA
         V0L5lg9Jl2a9PUiHXXA+KZXbwHBt5zqRHQ1Paris6b/jpWk4Lgc3J2KAAwNKEVDHLXgj
         WrJDQZayGhyqoNlp4JneQXg30GwZ0W30vKSBb2RWjADsmhiCigaF4SA/BHzpnberrFLp
         ao3A==
X-Gm-Message-State: APjAAAUE8NccYyeUPhZUb3cTjOedORUyTY3sGh0SnzEr4nURwl9uM7hH
        USnEZ6HC2V3dWR6cR1hNmvnUerCricCAViut+KQ=
X-Google-Smtp-Source: APXvYqziZ5h0i4+HJGJ9QeCx3k32eUXP59+UFXAYbbmFy2pyukP7VVNz7n4HEXlKx1TDhKePILPxHsIubVKwvUMYYT8=
X-Received: by 2002:a1f:f2cd:: with SMTP id q196mr2373104vkh.31.1570032748202;
 Wed, 02 Oct 2019 09:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
 <20190916211353.18802-14-olga.kornievskaia@gmail.com> <20191002155220.GA19089@fieldses.org>
In-Reply-To: <20191002155220.GA19089@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 2 Oct 2019 12:12:17 -0400
Message-ID: <CAN-5tyFk9Aw=1MYhhymyxWG9+vkm+SBjoow+eG14QLnkAM0H+g@mail.gmail.com>
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

On Wed, Oct 2, 2019 at 11:52 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Mon, Sep 16, 2019 at 05:13:47PM -0400, Olga Kornievskaia wrote:
> > @@ -1026,7 +1026,8 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
> >  static __be32
> >  nfsd4_verify_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >                 stateid_t *src_stateid, struct nfsd_file **src,
> > -               stateid_t *dst_stateid, struct nfsd_file **dst)
> > +               stateid_t *dst_stateid, struct nfsd_file **dst,
> > +               struct nfs4_stid **stid)
> >  {
> >       __be32 status;
> >
> ...
> > @@ -1072,7 +1073,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
> >       __be32 status;
> >
> >       status = nfsd4_verify_copy(rqstp, cstate, &clone->cl_src_stateid, &src,
> > -                                &clone->cl_dst_stateid, &dst);
> > +                                &clone->cl_dst_stateid, &dst, NULL);
> >       if (status)
> >               goto out;
> >
> > @@ -1260,7 +1261,7 @@ static int nfsd4_do_async_copy(void *data)
> >
> >       status = nfsd4_verify_copy(rqstp, cstate, &copy->cp_src_stateid,
> >                                  &copy->nf_src, &copy->cp_dst_stateid,
> > -                                &copy->nf_dst);
> > +                                &copy->nf_dst, NULL);
> >       if (status)
> >               goto out;
> >
>
> So both callers pass NULL for the new stid parameter.  Looks like that's
> still true after the full series of patches, too.
>

If you look at an earlier chunk it uses it (there is only a single
user of it: copy notify state)
@@ -1034,14 +1035,14 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst
*rqstp, struct svc_fh *fh)
                return nfserr_nofilehandle;

        status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->save_fh,
-                                           src_stateid, RD_STATE, src);
+                                           src_stateid, RD_STATE, src, NULL);
        if (status) {
                dprintk("NFSD: %s: couldn't process src stateid!\n", __func__);
                goto out;
        }

        status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
-                                           dst_stateid, WR_STATE, dst);
+                                           dst_stateid, WR_STATE, dst, stid);
        if (status) {
                dprintk("NFSD: %s: couldn't process dst stateid!\n", __func__);
                goto out_put_src;

> --b.
