Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEDFFC8E79
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Oct 2019 18:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfJBQem (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Oct 2019 12:34:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfJBQel (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 2 Oct 2019 12:34:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 53AD83086218;
        Wed,  2 Oct 2019 16:34:41 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-123-200.rdu2.redhat.com [10.10.123.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0715B5D9DC;
        Wed,  2 Oct 2019 16:34:41 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 63407120093; Wed,  2 Oct 2019 12:34:39 -0400 (EDT)
Date:   Wed, 2 Oct 2019 12:34:39 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v7 13/19] NFSD return nfs4_stid in
 nfs4_preprocess_stateid_op
Message-ID: <20191002163439.GA23349@pick.fieldses.org>
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
 <20190916211353.18802-14-olga.kornievskaia@gmail.com>
 <20191002155220.GA19089@fieldses.org>
 <CAN-5tyFk9Aw=1MYhhymyxWG9+vkm+SBjoow+eG14QLnkAM0H+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyFk9Aw=1MYhhymyxWG9+vkm+SBjoow+eG14QLnkAM0H+g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 02 Oct 2019 16:34:41 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 02, 2019 at 12:12:17PM -0400, Olga Kornievskaia wrote:
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

You're talking about nfs4_preprocess_stateid_op, the above is
nfsd4_verify_copy.

--b.

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
