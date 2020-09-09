Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BF8263740
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Sep 2020 22:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgIIUYI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Sep 2020 16:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIUYH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Sep 2020 16:24:07 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765C4C061573
        for <linux-nfs@vger.kernel.org>; Wed,  9 Sep 2020 13:24:06 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id EE9F46196; Wed,  9 Sep 2020 16:24:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org EE9F46196
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1599683040;
        bh=ATSzBD9iW8Wv3A+hELiqeF0YXfHxRhQ1AkZ8Twb1hNM=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=CuyoKCc2pDYMx1tQi3GYF0RQfRsSxnVfCbU1h5gUs/fN2R+N9UQsfCYGyp0YK52kS
         Kj5Wvhj4VWdDT9nTGPrK6ncmZYWANuTRDgeigI1f+gBPyWfr2T/bNMQYEjftd/7JZU
         x4YkTl7b2P9+kwvTIV4L8K+uB73tO5lGlgdVjJH8=
Date:   Wed, 9 Sep 2020 16:24:00 -0400
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 4/5] NFSD: Return both a hole and a data segment
Message-ID: <20200909202400.GB3894@fieldses.org>
References: <20200908162559.509113-1-Anna.Schumaker@Netapp.com>
 <20200908162559.509113-5-Anna.Schumaker@Netapp.com>
 <20200908194944.GC6256@pick.fieldses.org>
 <CAFX2Jfn7Fb=e2Sigf0xEZ4tw5h0KMnyOQWi5MCvdfq+GFXj+-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFX2Jfn7Fb=e2Sigf0xEZ4tw5h0KMnyOQWi5MCvdfq+GFXj+-A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 09, 2020 at 12:51:38PM -0400, Anna Schumaker wrote:
> On Tue, Sep 8, 2020 at 3:49 PM J. Bruce Fields <bfields@redhat.com> wrote:
> >
> > On Tue, Sep 08, 2020 at 12:25:58PM -0400, schumaker.anna@gmail.com wrote:
> > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > >
> > > But only one of each right now. We'll expand on this in the next patch.
> > >
> > > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > ---
> > > v5: If we've already encoded a segment, then return a short read if
> > >     later segments return an error for some reason.
> > > ---
> > >  fs/nfsd/nfs4xdr.c | 54 ++++++++++++++++++++++++++++++++++-------------
> > >  1 file changed, 39 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > index 45159bd9e9a4..856606263c1d 100644
> > > --- a/fs/nfsd/nfs4xdr.c
> > > +++ b/fs/nfsd/nfs4xdr.c
> > > @@ -4603,7 +4603,7 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
> > >  static __be32
> > >  nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> > >                           struct nfsd4_read *read,
> > > -                         unsigned long maxcount,  u32 *eof)
> > > +                         unsigned long *maxcount, u32 *eof)
> > >  {
> > >       struct xdr_stream *xdr = &resp->xdr;
> > >       struct file *file = read->rd_nf->nf_file;
> > > @@ -4614,19 +4614,19 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> > >       __be64 tmp64;
> > >
> > >       if (hole_pos > read->rd_offset)
> > > -             maxcount = min_t(unsigned long, maxcount, hole_pos - read->rd_offset);
> > > +             *maxcount = min_t(unsigned long, *maxcount, hole_pos - read->rd_offset);
> > >
> > >       /* Content type, offset, byte count */
> > >       p = xdr_reserve_space(xdr, 4 + 8 + 4);
> > >       if (!p)
> > >               return nfserr_resource;
> > >
> > > -     read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, maxcount);
> > > +     read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, *maxcount);
> > >       if (read->rd_vlen < 0)
> > >               return nfserr_resource;
> > >
> > >       nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
> > > -                         resp->rqstp->rq_vec, read->rd_vlen, &maxcount, eof);
> > > +                         resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
> > >       if (nfserr)
> > >               return nfserr;
> > >
> > > @@ -4634,7 +4634,7 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> > >       write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
> > >       tmp64 = cpu_to_be64(read->rd_offset);
> > >       write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
> > > -     tmp = htonl(maxcount);
> > > +     tmp = htonl(*maxcount);
> > >       write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
> > >       return nfs_ok;
> > >  }
> > > @@ -4642,11 +4642,19 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> > >  static __be32
> > >  nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
> > >                           struct nfsd4_read *read,
> > > -                         unsigned long maxcount, u32 *eof)
> > > +                         unsigned long *maxcount, u32 *eof)
> > >  {
> > >       struct file *file = read->rd_nf->nf_file;
> > > +     loff_t data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
> > > +     unsigned long count;
> > >       __be32 *p;
> > >
> > > +     if (data_pos == -ENXIO)
> > > +             data_pos = i_size_read(file_inode(file));
> > > +     else if (data_pos <= read->rd_offset)
> > > +             return nfserr_resource;
> >
> > I think there's still a race here:
> >
> >         vfs_llseek(.,0,SEEK_HOLE) returns 1024
> >         read 1024 bytes of data
> >                                         another process fills the hole
> >         vfs_llseek(.,1024,SEEK_DATA) returns 1024
> >         code above returns nfserr_resource
> >
> > We end up returning an error to the client when we should have just
> > returned more data.
> 
> As long as we've encoded at least one segment successfully, we'll
> actually return a short read in this case (as of the most recent
> patches). I tried implementing a check for what each segment actually
> was before encoding, but it lead to a lot of extra lseeks (so
> potential for races / performance problems on btrfs). Returning a
> short read seemed like a better approach to me.

Argh, right, I forgot the "if (nfserr && segments == 0)" at the end of
nfsd4_encode_read_plus().

It's still possible to get a spurious error return if this happens at
the very start of the READ_PLUS, though.  Hm.  Might be better to just
encode another data segment?

--b.

> 
> Anna
> 
> >
> > --b.
> >
> > > +     count = data_pos - read->rd_offset;
> > > +
> > >       /* Content type, offset, byte count */
> > >       p = xdr_reserve_space(&resp->xdr, 4 + 8 + 8);
> > >       if (!p)
> > > @@ -4654,9 +4662,10 @@ nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
> > >
> > >       *p++ = htonl(NFS4_CONTENT_HOLE);
> > >        p   = xdr_encode_hyper(p, read->rd_offset);
> > > -      p   = xdr_encode_hyper(p, maxcount);
> > > +      p   = xdr_encode_hyper(p, count);
> > >
> > > -     *eof = (read->rd_offset + maxcount) >= i_size_read(file_inode(file));
> > > +     *eof = (read->rd_offset + count) >= i_size_read(file_inode(file));
> > > +     *maxcount = min_t(unsigned long, count, *maxcount);
> > >       return nfs_ok;
> > >  }
> > >
> > > @@ -4664,7 +4673,7 @@ static __be32
> > >  nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> > >                      struct nfsd4_read *read)
> > >  {
> > > -     unsigned long maxcount;
> > > +     unsigned long maxcount, count;
> > >       struct xdr_stream *xdr = &resp->xdr;
> > >       struct file *file;
> > >       int starting_len = xdr->buf->len;
> > > @@ -4687,6 +4696,7 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> > >       maxcount = min_t(unsigned long, maxcount,
> > >                        (xdr->buf->buflen - xdr->buf->len));
> > >       maxcount = min_t(unsigned long, maxcount, read->rd_length);
> > > +     count    = maxcount;
> > >
> > >       eof = read->rd_offset >= i_size_read(file_inode(file));
> > >       if (eof)
> > > @@ -4695,24 +4705,38 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> > >       pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
> > >       if (pos == -ENXIO)
> > >               pos = i_size_read(file_inode(file));
> > > +     else if (pos < 0)
> > > +             pos = read->rd_offset;
> > >
> > > -     if (pos > read->rd_offset) {
> > > -             maxcount = pos - read->rd_offset;
> > > -             nfserr = nfsd4_encode_read_plus_hole(resp, read, maxcount, &eof);
> > > +     if (pos == read->rd_offset) {
> > > +             maxcount = count;
> > > +             nfserr = nfsd4_encode_read_plus_data(resp, read, &maxcount, &eof);
> > > +             if (nfserr)
> > > +                     goto out;
> > > +             count -= maxcount;
> > > +             read->rd_offset += maxcount;
> > >               segments++;
> > > -     } else {
> > > -             nfserr = nfsd4_encode_read_plus_data(resp, read, maxcount, &eof);
> > > +     }
> > > +
> > > +     if (count > 0 && !eof) {
> > > +             maxcount = count;
> > > +             nfserr = nfsd4_encode_read_plus_hole(resp, read, &maxcount, &eof);
> > > +             if (nfserr)
> > > +                     goto out;
> > > +             count -= maxcount;
> > > +             read->rd_offset += maxcount;
> > >               segments++;
> > >       }
> > >
> > >  out:
> > > -     if (nfserr)
> > > +     if (nfserr && segments == 0)
> > >               xdr_truncate_encode(xdr, starting_len);
> > >       else {
> > >               tmp = htonl(eof);
> > >               write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, 4);
> > >               tmp = htonl(segments);
> > >               write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
> > > +             nfserr = nfs_ok;
> > >       }
> > >
> > >       return nfserr;
> > > --
> > > 2.28.0
> > >
> >
