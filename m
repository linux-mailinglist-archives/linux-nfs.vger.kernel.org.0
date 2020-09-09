Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E86B2637D2
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Sep 2020 22:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgIIUuW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Sep 2020 16:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgIIUuV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Sep 2020 16:50:21 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9E2C061573
        for <linux-nfs@vger.kernel.org>; Wed,  9 Sep 2020 13:50:21 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 4A4DFAB6; Wed,  9 Sep 2020 16:50:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 4A4DFAB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1599684620;
        bh=2ix9RkHtZ/mniV9tR4ZtFJYe5pudgL3JZFVw0YB81N4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YlEKOQY0fYkNMUKSGAmNwtZN7rscNgDefhOWAZn2x7+UOhMhxIFAuHmlXzktgtBLi
         cG0eBmY4c8CtK2Oc8vMBz3I1PY5Ll+pJsHTv5xD/fx/Bq0OMWCJ1Su6sUP+DRFCpc1
         McoRXpIzdkEigh5MXVSRqugwkuhrFgczaL6/G+oE=
Date:   Wed, 9 Sep 2020 16:50:20 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 2/5] NFSD: Add READ_PLUS data support
Message-ID: <20200909205020.GE3894@fieldses.org>
References: <20200908162559.509113-1-Anna.Schumaker@Netapp.com>
 <20200908162559.509113-3-Anna.Schumaker@Netapp.com>
 <20200908194245.GB6256@pick.fieldses.org>
 <CAFX2Jfkt0Qv1oO6iEr21N3zjkvE7VyKQQ47g2vQ4PHV6xmgrSg@mail.gmail.com>
 <20200909202534.GC3894@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909202534.GC3894@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 09, 2020 at 04:25:34PM -0400, bfields wrote:
> On Wed, Sep 09, 2020 at 12:53:18PM -0400, Anna Schumaker wrote:
> > On Tue, Sep 8, 2020 at 3:42 PM J. Bruce Fields <bfields@redhat.com> wrote:
> > >
> > > On Tue, Sep 08, 2020 at 12:25:56PM -0400, schumaker.anna@gmail.com wrote:
> > > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > >
> > > > This patch adds READ_PLUS support for returning a single
> > > > NFS4_CONTENT_DATA segment to the client. This is basically the same as
> > > > the READ operation, only with the extra information about data segments.
> > > >
> > > > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > >
> > > > ---
> > > > v5: Fix up nfsd4_read_plus_rsize() calculation
> > > > ---
> > > >  fs/nfsd/nfs4proc.c | 20 +++++++++++
> > > >  fs/nfsd/nfs4xdr.c  | 83 ++++++++++++++++++++++++++++++++++++++++++++--
> > > >  2 files changed, 101 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > index eaf50eafa935..0a3df5f10501 100644
> > > > --- a/fs/nfsd/nfs4proc.c
> > > > +++ b/fs/nfsd/nfs4proc.c
> > > > @@ -2591,6 +2591,19 @@ static inline u32 nfsd4_read_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
> > > >       return (op_encode_hdr_size + 2 + XDR_QUADLEN(rlen)) * sizeof(__be32);
> > > >  }
> > > >
> > > > +static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
> > > > +{
> > > > +     u32 maxcount = svc_max_payload(rqstp);
> > > > +     u32 rlen = min(op->u.read.rd_length, maxcount);
> > > > +     /*
> > > > +      * Worst case is a single large data segment, so make
> > > > +      * sure we have enough room to encode that
> > > > +      */
> > >
> > > After the last patch we allow an unlimited number of segments.  So a
> > > zillion 1-byte segments is also possible, and is a worse case.
> > >
> > > Possible ways to avoid that kind of thing:
> > >
> > >         - when encoding, stop and return a short read if the xdr-encoded
> > >           result would exceed the limit calculated here.
> > 
> > Doesn't this happen automatically through calls to xdr_reserve_space()?
> 
> No, xdr_reserve_space() will keep us from running out of buffer
> completely, but it won't check that ops come in under the estimates made
> in read_plus_rsize().

If it's easier, another option might be just: if we ever get a "small"
hole (say, less than 512 bytes), just give up and encode the rest of the
result as a single big data segment.

--b.
