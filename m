Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2B8C8EFF
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Oct 2019 18:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfJBQwu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Oct 2019 12:52:50 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38389 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBQwu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Oct 2019 12:52:50 -0400
Received: by mail-ua1-f65.google.com with SMTP id 107so6899848uau.5
        for <linux-nfs@vger.kernel.org>; Wed, 02 Oct 2019 09:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JyniVz/j8jKgYwRvIYzCu7P9yDfLthzK3SH4decbcig=;
        b=GOYqN+AzGekXmiGzDRYe3UE96yWlVZgHlU0SEg4MwLm5dWDZqlgCR6F9k6edFNfqCr
         oBr8zw43v0D5SS+3FLHyGa9ERdatFLM44gi1fvvpdKJykpAKAc6Gb+WCpK+yT4wRIwl/
         RHXerR9dlA9YoVA4dJNmq2WzgLMUYQJc4IE4+4guCF5x9QhQmbq/cdDw89g2WT8IRPfK
         +avuwSck/dM2dWhxbpDQoWxkd6MBPGozlw1SnOBUcJS4kc1kzDAj8jrWazRZ4poKBUCZ
         VfEDsYV9AoOlbuvISSfhRto4WCVHaKVu1T/OO6Wp0u6jBeTr9mCYV5yQMKsBSSSAfsXK
         FdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JyniVz/j8jKgYwRvIYzCu7P9yDfLthzK3SH4decbcig=;
        b=j0Ls9Y9F8KWrHn9OWx6Bs+MmVDv4rfthIdHJrtp7GguBKLDMYgEsOodtdHv2uFPwRr
         ysFjW+dExc0PqUiwrnYXHznzfm7psojn4jbQ00e8F+jj5eKLBJRnJ2RwfozL5CqajHkE
         EbhCSuXXOgAtO40HME6RvjUfNxKk7a/g+Z/TMHTosljhkQ1z/OibKL7qGwI5JX2fJzBe
         zifgl8cG6W+bw3RLq7vnKnHyPEk7HvZDiNbDhpqsU3PsoT9OYKAZ13HJwFO0+JIJSBOd
         r8rYkTJD07YynUPENqA7dBIHYqnaAXbBm/O73UKvKUhOxZ0SIR82IrTdWALGpOAowvHQ
         t/3w==
X-Gm-Message-State: APjAAAU+jZZKFt4YVE+S/z/omGO8idUMiAISiMUMpbxe90z+DuyDQHoS
        WcgFOl7JxzxNRrgVcc48f1HHAwRUUZu849lFp6o=
X-Google-Smtp-Source: APXvYqxSXNLyn4cX4M3fWRexdoK8llfP9Esgcf3cw4+49aJ2GhMmccjlNdu2CiU3fmXA8POEEinB5JNxvwwHbptkbpk=
X-Received: by 2002:a9f:31cd:: with SMTP id w13mr2179237uad.81.1570035168500;
 Wed, 02 Oct 2019 09:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
 <20190916211353.18802-14-olga.kornievskaia@gmail.com> <20191002155220.GA19089@fieldses.org>
 <CAN-5tyFk9Aw=1MYhhymyxWG9+vkm+SBjoow+eG14QLnkAM0H+g@mail.gmail.com> <20191002163439.GA23349@pick.fieldses.org>
In-Reply-To: <20191002163439.GA23349@pick.fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 2 Oct 2019 12:52:37 -0400
Message-ID: <CAN-5tyE2riqB8xTTz+cGJF84FfvSYaBweEPXNKe+kRc4Ma57Yw@mail.gmail.com>
Subject: Re: [PATCH v7 13/19] NFSD return nfs4_stid in nfs4_preprocess_stateid_op
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 2, 2019 at 12:34 PM J. Bruce Fields <bfields@redhat.com> wrote:
>
> On Wed, Oct 02, 2019 at 12:12:17PM -0400, Olga Kornievskaia wrote:
> > On Wed, Oct 2, 2019 at 11:52 AM J. Bruce Fields <bfields@fieldses.org> wrote:
> > >
> > > On Mon, Sep 16, 2019 at 05:13:47PM -0400, Olga Kornievskaia wrote:
> > > > @@ -1026,7 +1026,8 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
> > > >  static __be32
> > > >  nfsd4_verify_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > > >                 stateid_t *src_stateid, struct nfsd_file **src,
> > > > -               stateid_t *dst_stateid, struct nfsd_file **dst)
> > > > +               stateid_t *dst_stateid, struct nfsd_file **dst,
> > > > +               struct nfs4_stid **stid)
> > > >  {
> > > >       __be32 status;
> > > >
> > > ...
> > > > @@ -1072,7 +1073,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
> > > >       __be32 status;
> > > >
> > > >       status = nfsd4_verify_copy(rqstp, cstate, &clone->cl_src_stateid, &src,
> > > > -                                &clone->cl_dst_stateid, &dst);
> > > > +                                &clone->cl_dst_stateid, &dst, NULL);
> > > >       if (status)
> > > >               goto out;
> > > >
> > > > @@ -1260,7 +1261,7 @@ static int nfsd4_do_async_copy(void *data)
> > > >
> > > >       status = nfsd4_verify_copy(rqstp, cstate, &copy->cp_src_stateid,
> > > >                                  &copy->nf_src, &copy->cp_dst_stateid,
> > > > -                                &copy->nf_dst);
> > > > +                                &copy->nf_dst, NULL);
> > > >       if (status)
> > > >               goto out;
> > > >
> > >
> > > So both callers pass NULL for the new stid parameter.  Looks like that's
> > > still true after the full series of patches, too.
> > >
> >
> > If you look at an earlier chunk it uses it (there is only a single
> > user of it: copy notify state)
>
> You're talking about nfs4_preprocess_stateid_op, the above is
> nfsd4_verify_copy.

I see. You are right, looks like after reworks the nfsd4_verify_copy
doesn't need a stid. Previously both copy stateid and copy_notify
stateids were tied to its parents but I've removed the link for the
copy stateid a while back. Should I now combine this patch with "NFSD
add COPY_NOTIFY operation" because that's the only caller of
nfsd4_preprocess_stateid_op that needs the stid.

>
> --b.
>
> > @@ -1034,14 +1035,14 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst
> > *rqstp, struct svc_fh *fh)
> >                 return nfserr_nofilehandle;
> >
> >         status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->save_fh,
> > -                                           src_stateid, RD_STATE, src);
> > +                                           src_stateid, RD_STATE, src, NULL);
> >         if (status) {
> >                 dprintk("NFSD: %s: couldn't process src stateid!\n", __func__);
> >                 goto out;
> >         }
> >
> >         status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
> > -                                           dst_stateid, WR_STATE, dst);
> > +                                           dst_stateid, WR_STATE, dst, stid);
> >         if (status) {
> >                 dprintk("NFSD: %s: couldn't process dst stateid!\n", __func__);
> >                 goto out_put_src;
> >
> > > --b.
