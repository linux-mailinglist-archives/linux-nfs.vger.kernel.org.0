Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B0E259A6D
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Sep 2020 18:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbgIAQtl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Sep 2020 12:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729627AbgIAQtk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Sep 2020 12:49:40 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCE2C061244
        for <linux-nfs@vger.kernel.org>; Tue,  1 Sep 2020 09:49:40 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id AB70F6EEB; Tue,  1 Sep 2020 12:49:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org AB70F6EEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1598978978;
        bh=YFSwODfeIZpeFJvQnKOhf6BrQ38YBN2aecwmJ1o1CT8=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=afexJoktLJNCPwVgkZw3qKMKzjNxO/BuIN+wRBsXUPnUkD78C9+Co8QN48qRu/Fog
         FUZJL4f2Rji2jAA4wNjikDl+2C6pNkfue/uu/0S29+cKEryufwLAgP1gj+PVGUAh10
         nNrnm8WC+b2H4uBHkFz1Gr95aD5E1w9X6hBS3AaY=
Date:   Tue, 1 Sep 2020 12:49:38 -0400
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] NFSD: Add READ_PLUS data support
Message-ID: <20200901164938.GC12082@fieldses.org>
References: <20200817165310.354092-1-Anna.Schumaker@Netapp.com>
 <20200817165310.354092-3-Anna.Schumaker@Netapp.com>
 <20200828212521.GA33226@pick.fieldses.org>
 <20200828215627.GB33226@pick.fieldses.org>
 <CAFX2Jfn3LN9Zc-=4mAm1mQ3k8PN6C1yF4xqh6B-yyXCxFnp7hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFX2Jfn3LN9Zc-=4mAm1mQ3k8PN6C1yF4xqh6B-yyXCxFnp7hQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 31, 2020 at 02:16:26PM -0400, Anna Schumaker wrote:
> On Fri, Aug 28, 2020 at 5:56 PM J. Bruce Fields <bfields@redhat.com> wrote:
> >
> > On Fri, Aug 28, 2020 at 05:25:21PM -0400, J. Bruce Fields wrote:
> > > On Mon, Aug 17, 2020 at 12:53:07PM -0400, schumaker.anna@gmail.com wrote:
> > > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > >
> > > > This patch adds READ_PLUS support for returning a single
> > > > NFS4_CONTENT_DATA segment to the client. This is basically the same as
> > > > the READ operation, only with the extra information about data segments.
> > > >
> > > > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > > ---
> > > >  fs/nfsd/nfs4proc.c | 17 ++++++++++
> > > >  fs/nfsd/nfs4xdr.c  | 83 ++++++++++++++++++++++++++++++++++++++++++++--
> > > >  2 files changed, 98 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > index a09c35f0f6f0..9630d33211f2 100644
> > > > --- a/fs/nfsd/nfs4proc.c
> > > > +++ b/fs/nfsd/nfs4proc.c
> > > > @@ -2523,6 +2523,16 @@ static inline u32 nfsd4_read_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
> > > >     return (op_encode_hdr_size + 2 + XDR_QUADLEN(rlen)) * sizeof(__be32);
> > > >  }
> > > >
> > > > +static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
> > > > +{
> > > > +   u32 maxcount = svc_max_payload(rqstp);
> > > > +   u32 rlen = min(op->u.read.rd_length, maxcount);
> > > > +   /* enough extra xdr space for encoding either a hole or data segment. */
> > > > +   u32 segments = 1 + 2 + 2;
> > > > +
> > > > +   return (op_encode_hdr_size + 2 + segments + XDR_QUADLEN(rlen)) * sizeof(__be32);
> > >
> > > I'm not sure I understand this calculation.
> > >
> > > In the final code, there's no fixed limit on the number of segments
> > > returned by a single READ_PLUS op, right?
> >
> > I think the worst-case overhead to represent a hole is around 50 bytes.
> >
> > So as long as we don't encode any holes less than that, then we can just
> > use rlen as an upper bound.
> >
> > We really don't want to bother encoding small holes.  I doubt
> > filesystems want to bother with them either.  Do they give us any
> > guarantees as to the minimum size of a hole?
> 
> The minimum size seems to be PAGE_SIZE from everything I've seen.

OK, can we make that assumption explicit?  It'd simplify stuff like
this.

--b.
