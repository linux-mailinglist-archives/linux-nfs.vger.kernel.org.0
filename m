Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB302637A6
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Sep 2020 22:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIIUob (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Sep 2020 16:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729507AbgIIUob (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Sep 2020 16:44:31 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EE5C061573
        for <linux-nfs@vger.kernel.org>; Wed,  9 Sep 2020 13:44:30 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 01502AB6; Wed,  9 Sep 2020 16:44:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 01502AB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1599684270;
        bh=Yb4Am/ag4XbCzbjMvrocrka2QV6iC2SdZhrDf5Xug0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tuYZxvNL8FEI4hdS4jyUChQJZCy3CWmexxK7ID7ZghCU0FMh9E6+tAXYc/SnSagRY
         YehauMoplvfzeIS7m/8QR9Dj7XFZara8dxJy3/bmsQfuD0CZmBAXXpcg4LQxBw+UOM
         emnZLjlmSHb2AnsaP2BE0fHoWW/0BnQYPQPI83Lc=
Date:   Wed, 9 Sep 2020 16:44:29 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 4/5] NFSD: Return both a hole and a data segment
Message-ID: <20200909204429.GD3894@fieldses.org>
References: <20200908162559.509113-1-Anna.Schumaker@Netapp.com>
 <20200908162559.509113-5-Anna.Schumaker@Netapp.com>
 <20200908194944.GC6256@pick.fieldses.org>
 <CAFX2Jfn7Fb=e2Sigf0xEZ4tw5h0KMnyOQWi5MCvdfq+GFXj+-A@mail.gmail.com>
 <20200909202400.GB3894@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909202400.GB3894@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 09, 2020 at 04:24:00PM -0400, bfields wrote:
> On Wed, Sep 09, 2020 at 12:51:38PM -0400, Anna Schumaker wrote:
> > On Tue, Sep 8, 2020 at 3:49 PM J. Bruce Fields <bfields@redhat.com> wrote:
> > > I think there's still a race here:
> > >
> > >         vfs_llseek(.,0,SEEK_HOLE) returns 1024
> > >         read 1024 bytes of data
> > >                                         another process fills the hole
> > >         vfs_llseek(.,1024,SEEK_DATA) returns 1024
> > >         code above returns nfserr_resource
> > >
> > > We end up returning an error to the client when we should have just
> > > returned more data.
> > 
> > As long as we've encoded at least one segment successfully, we'll
> > actually return a short read in this case (as of the most recent
> > patches). I tried implementing a check for what each segment actually
> > was before encoding, but it lead to a lot of extra lseeks (so
> > potential for races / performance problems on btrfs). Returning a
> > short read seemed like a better approach to me.
> 
> Argh, right, I forgot the "if (nfserr && segments == 0)" at the end of
> nfsd4_encode_read_plus().

(Oops, it's actually the "if (nfserr)" below that handles that case.)

> It's still possible to get a spurious error return if this happens at
> the very start of the READ_PLUS, though.  Hm.  Might be better to just
> encode another data segment?

So, I mean, if nfsd4_encode_read_plus_hole() doesn't find a hole after
all, just keep going, and create a data segment.

--b.

> 
> --b.
> 
> > 
> > Anna
> > 
> > >
> > > --b.
> > >
> > > > +     count = data_pos - read->rd_offset;
> > > > +
> > > >       /* Content type, offset, byte count */
> > > >       p = xdr_reserve_space(&resp->xdr, 4 + 8 + 8);
> > > >       if (!p)
> > > > @@ -4654,9 +4662,10 @@ nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
> > > >
> > > >       *p++ = htonl(NFS4_CONTENT_HOLE);
> > > >        p   = xdr_encode_hyper(p, read->rd_offset);
> > > > -      p   = xdr_encode_hyper(p, maxcount);
> > > > +      p   = xdr_encode_hyper(p, count);
> > > >
> > > > -     *eof = (read->rd_offset + maxcount) >= i_size_read(file_inode(file));
> > > > +     *eof = (read->rd_offset + count) >= i_size_read(file_inode(file));
> > > > +     *maxcount = min_t(unsigned long, count, *maxcount);
> > > >       return nfs_ok;
> > > >  }
> > > >
> > > > @@ -4664,7 +4673,7 @@ static __be32
> > > >  nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> > > >                      struct nfsd4_read *read)
> > > >  {
> > > > -     unsigned long maxcount;
> > > > +     unsigned long maxcount, count;
> > > >       struct xdr_stream *xdr = &resp->xdr;
> > > >       struct file *file;
> > > >       int starting_len = xdr->buf->len;
> > > > @@ -4687,6 +4696,7 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> > > >       maxcount = min_t(unsigned long, maxcount,
> > > >                        (xdr->buf->buflen - xdr->buf->len));
> > > >       maxcount = min_t(unsigned long, maxcount, read->rd_length);
> > > > +     count    = maxcount;
> > > >
> > > >       eof = read->rd_offset >= i_size_read(file_inode(file));
> > > >       if (eof)
> > > > @@ -4695,24 +4705,38 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> > > >       pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
> > > >       if (pos == -ENXIO)
> > > >               pos = i_size_read(file_inode(file));
> > > > +     else if (pos < 0)
> > > > +             pos = read->rd_offset;
> > > >
> > > > -     if (pos > read->rd_offset) {
> > > > -             maxcount = pos - read->rd_offset;
> > > > -             nfserr = nfsd4_encode_read_plus_hole(resp, read, maxcount, &eof);
> > > > +     if (pos == read->rd_offset) {
> > > > +             maxcount = count;
> > > > +             nfserr = nfsd4_encode_read_plus_data(resp, read, &maxcount, &eof);
> > > > +             if (nfserr)
> > > > +                     goto out;
> > > > +             count -= maxcount;
> > > > +             read->rd_offset += maxcount;
> > > >               segments++;
> > > > -     } else {
> > > > -             nfserr = nfsd4_encode_read_plus_data(resp, read, maxcount, &eof);
> > > > +     }
> > > > +
> > > > +     if (count > 0 && !eof) {
> > > > +             maxcount = count;
> > > > +             nfserr = nfsd4_encode_read_plus_hole(resp, read, &maxcount, &eof);
> > > > +             if (nfserr)
> > > > +                     goto out;
> > > > +             count -= maxcount;
> > > > +             read->rd_offset += maxcount;
> > > >               segments++;
> > > >       }
> > > >
> > > >  out:
> > > > -     if (nfserr)
> > > > +     if (nfserr && segments == 0)
> > > >               xdr_truncate_encode(xdr, starting_len);
> > > >       else {
> > > >               tmp = htonl(eof);
> > > >               write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, 4);
> > > >               tmp = htonl(segments);
> > > >               write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
> > > > +             nfserr = nfs_ok;
> > > >       }
> > > >
> > > >       return nfserr;
> > > > --
> > > > 2.28.0
> > > >
> > >
