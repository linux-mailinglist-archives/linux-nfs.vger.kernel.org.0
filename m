Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3773E576277
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Jul 2022 15:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbiGONF0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Jul 2022 09:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiGONFZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Jul 2022 09:05:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752F426E2
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 06:05:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E702AB82C0A
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 13:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8EFC3411E
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 13:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657890321;
        bh=3NisH7/tzIZ0Hb0iL3fEfaPROC5V9YFqNrjudPbqrTA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SyCRC2AiR6vBjP/KYb9bSm087BoddFAGTy4mD3+WcBStCM4lj4QiAtFMNQl0TVRC1
         BklqSmB56YvSZePbc/b0iOQiBtSflg7xvvJIYo2QYOX+HUVvKqjkrILAk0qFYBOJ+1
         xFsRiWmhSVXkWxvuQOs1XxpqsvCIcjucsv+p20prWURPT7B/yrAxEqQ87AfCpRmiZq
         JYTwDCksmdgEz9yOVIgDOoyDdDoXPT81Bols1Mo46BNZd8oUw7zH3QVtlsB0sRCXVm
         bfUtHOjRtY16j1ghoCigjZethqQJSUE0Muo8wJXeeyoNw/Pv5/NcWq4SP9ryWutnEA
         y9D3BXgdjT/Aw==
Received: by mail-wm1-f51.google.com with SMTP id n185so2764540wmn.4
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 06:05:21 -0700 (PDT)
X-Gm-Message-State: AJIora9DSN/gvFMuvb355R20zaZXhvDSLQEuiylwFBuKm1dUlS6OMWLH
        YCc8yS8G3B8T9igKWSZ3A73oplO20INab9JpJHQ=
X-Google-Smtp-Source: AGRyM1sbXDeJozBtYpEDvsjoavVycTiP7m0ELU4dQhEYPHJN+7GdzFiGObEWqg/uMFmjGzSZnldrxcLXyRDqOtmCL1A=
X-Received: by 2002:a05:600c:1548:b0:3a1:95fc:aa42 with SMTP id
 f8-20020a05600c154800b003a195fcaa42mr20077631wmg.189.1657890318875; Fri, 15
 Jul 2022 06:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220713190825.615678-1-anna@kernel.org> <20220713190825.615678-7-anna@kernel.org>
 <C16B8BE4-35C6-404F-9E94-3E01714DC436@oracle.com>
In-Reply-To: <C16B8BE4-35C6-404F-9E94-3E01714DC436@oracle.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Fri, 15 Jul 2022 09:05:02 -0400
X-Gmail-Original-Message-ID: <CAFX2Jf=Sm8k2E6X5CZ8WhpwnP0k3qe1ZpZnzqpZdoKpXzLfpdQ@mail.gmail.com>
Message-ID: <CAFX2Jf=Sm8k2E6X5CZ8WhpwnP0k3qe1ZpZnzqpZdoKpXzLfpdQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] NFSD: Repeal and replace the READ_PLUS implementation
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jul 13, 2022 at 4:45 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jul 13, 2022, at 3:08 PM, Anna Schumaker <anna@kernel.org> wrote:
> >
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > Rather than relying on the underlying filesystem to tell us where hole
> > and data segments are through vfs_llseek(), let's instead do the hole
> > compression ourselves. This has a few advantages over the old
> > implementation:
> >
> > 1) A single call to the underlying filesystem through nfsd_readv() means
> >   the file can't change from underneath us in the middle of encoding.
> > 2) A single call to the underlying filestem also means that the
> >   underlying filesystem only needs to synchronize cached and on-disk
> >   data one time instead of potentially many speeding up the reply.
> > 3) Hole support for filesystems that don't support SEEK_HOLE and SEEK_DATA
>
> I'm not sure I understand why this last one is a good idea.
> Wouldn't that cause holes to appear in the file cached on
> the client where there are no holes in the stored file on
> the server?

It doesn't because the client expands the holes into zero-filled pages
during READ_PLUS decoding. Note that this expansion happens on the
server-side for the classic READ operation.

>
> Is there any encryption-related impact such as the issues
> that David brought up during LSF/MM ?

Not that I'm aware of.

>
>
> > I also included an optimization where we can cut down on the amount of
> > memory being shifed around by doing the compression as (hole, data)
> > pairs.
> >
> > This patch not only fixes xfstests generic/091 and generic/263
> > for me but the "-g quick" group tests also finish about a minute faster.
> >
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> > fs/nfsd/nfs4xdr.c | 202 +++++++++++++++++++++++-----------------------
> > 1 file changed, 102 insertions(+), 100 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 61b2aae81abb..0e1e7a37d4e0 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -4731,81 +4731,121 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
> >       return nfserr;
> > }
> >
> > +struct read_plus_segment {
> > +     enum data_content4 type;
> > +     unsigned long offset;
> > +     unsigned long length;
> > +     unsigned int page_pos;
> > +};
>
> "unsigned long" is not always 64 bits wide, and note that
> rd_offset is declared as a u64. Thus ::offset and ::length
> need to have explicit bit-width types. How about u64 for both?

Sure, I'll change that.

>
> The same type needs to be used wherever you do an
>
>         unsigned long offset = read->rd_offset;
>
> Nit: can this struct declaration use tab-formatting with the
> usual naming convention for the fields, like "rp_type" and
> "rp_offset"? That makes it easier to grep for places these
> fields are used, since the current names are pretty generic.

Yeah, no problem.

>
>
> > +
> > static __be32
> > -nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> > -                         struct nfsd4_read *read,
> > -                         unsigned long *maxcount, u32 *eof,
> > -                         loff_t *pos)
> > +nfsd4_read_plus_readv(struct nfsd4_compoundres *resp, struct nfsd4_read *read,
> > +                   unsigned long *maxcount, u32 *eof)
> > {
> >       struct xdr_stream *xdr = resp->xdr;
> > -     struct file *file = read->rd_nf->nf_file;
> > -     int starting_len = xdr->buf->len;
> > -     loff_t hole_pos;
> > -     __be32 nfserr;
> > -     __be32 *p, tmp;
> > -     __be64 tmp64;
> > -
> > -     hole_pos = pos ? *pos : vfs_llseek(file, read->rd_offset, SEEK_HOLE);
> > -     if (hole_pos > read->rd_offset)
> > -             *maxcount = min_t(unsigned long, *maxcount, hole_pos - read->rd_offset);
> > -     *maxcount = min_t(unsigned long, *maxcount, (xdr->buf->buflen - xdr->buf->len));
> > -
> > -     /* Content type, offset, byte count */
> > -     p = xdr_reserve_space(xdr, 4 + 8 + 4);
> > -     if (!p)
> > -             return nfserr_resource;
> > +     unsigned int starting_len = xdr->buf->len;
> > +     __be32 nfserr, zero = xdr_zero;
> > +     int pad;
>
> unsigned int pad;

Ok

>
>
> >
> > +     /* xdr_reserve_space_vec() switches us to the xdr->pages */
>
> IIUC this is reserving a maximum estimated size piece of the xdr_stream
> to be used for encoding the READ_PLUS, and then the mechanics of
> encoding the result can trim the message length down a bit. The missing
> xdr_reserve_space calls are a little confusing, as are the operations on
> the stream's xdr_buf rather than using xdr_stream operations, so it would
> help to explain what's going on, perhaps as part of this comment.

Sure, I'll expand on the comment. I'm not sure the best way of
switching xdr_encode_word() and xdr_encode_double() to use an xdr
stream here, since the xdr_stream_encode_*() family of functions all
call xdr_reserve_space() internally but I'm writing to space that has
already been reserved.

>
> Or, move all of this blathering to a kerneldoc comment in front of
> nfsd4_encode_read_plus_segments()
>
>
> >       read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, *maxcount);
> >       if (read->rd_vlen < 0)
> >               return nfserr_resource;
> >
> > -     nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
> > -                         resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
> > +     nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, read->rd_nf->nf_file,
> > +                         read->rd_offset, resp->rqstp->rq_vec, read->rd_vlen,
> > +                         maxcount, eof);
> >       if (nfserr)
> >               return nfserr;
> > -     xdr_truncate_encode(xdr, starting_len + 16 + xdr_align_size(*maxcount));
> > +     xdr_truncate_encode(xdr, starting_len + xdr_align_size(*maxcount));
> >
> > -     tmp = htonl(NFS4_CONTENT_DATA);
> > -     write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
> > -     tmp64 = cpu_to_be64(read->rd_offset);
> > -     write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
> > -     tmp = htonl(*maxcount);
> > -     write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
> > -
> > -     tmp = xdr_zero;
> > -     write_bytes_to_xdr_buf(xdr->buf, starting_len + 16 + *maxcount, &tmp,
> > -                            xdr_pad_size(*maxcount));
> > +     pad = (*maxcount&3) ? 4 - (*maxcount&3) : 0;
>
> Would xdr_pad_size() be appropriate here?

Probably. It still passes my testing, so I've changed it.


>
>
> > +     write_bytes_to_xdr_buf(xdr->buf, starting_len + *maxcount, &zero, pad);
> >       return nfs_ok;
> > }
> >
> > +static void
> > +nfsd4_encode_read_plus_segment(struct xdr_stream *xdr,
> > +                            struct read_plus_segment *segment,
> > +                            unsigned int *bufpos, unsigned int *segments)
> > +{
> > +     struct xdr_buf *buf = xdr->buf;
> > +
> > +     xdr_encode_word(buf, *bufpos, segment->type);
> > +     xdr_encode_double(buf, *bufpos + 4, segment->offset);
> > +
> > +     if (segment->type == NFS4_CONTENT_HOLE) {
> > +             xdr_encode_double(buf, *bufpos + 12, segment->length);
> > +             *bufpos += 4 + 8 + 8;
>
> Throughout, can you use multiples of XDR_UNIT instead of naked integers?

Sure.

>
>
> > +     } else {
> > +             size_t align = xdr_align_size(segment->length);
> > +             xdr_encode_word(buf, *bufpos + 12, segment->length);
> > +             if (*segments == 0)
> > +                     xdr_buf_trim_head(buf, 4);
> > +
> > +             xdr_stream_move_subsegment(xdr,
> > +                             buf->head[0].iov_len + segment->page_pos,
> > +                             *bufpos + 16, align);
> > +             *bufpos += 4 + 8 + 4 + align;
> > +     }
> > +
> > +     *segments += 1;
> > +}
> > +
> > static __be32
> > -nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
> > -                         struct nfsd4_read *read,
> > -                         unsigned long *maxcount, u32 *eof)
> > +nfsd4_encode_read_plus_segments(struct nfsd4_compoundres *resp,
> > +                             struct nfsd4_read *read,
> > +                             unsigned int *segments, u32 *eof)
> > {
> > -     struct file *file = read->rd_nf->nf_file;
> > -     loff_t data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
> > -     loff_t f_size = i_size_read(file_inode(file));
> > -     unsigned long count;
> > -     __be32 *p;
> > +     enum data_content4 pagetype;
> > +     struct read_plus_segment segment;
> > +     struct xdr_stream *xdr = resp->xdr;
> > +     unsigned long offset = read->rd_offset;
> > +     unsigned int bufpos = xdr->buf->len;
> > +     unsigned long maxcount;
> > +     unsigned int pagelen, i = 0;
> > +     char *vpage, *p;
> > +     __be32 nfserr;
>
> Nit: try to use reverse christmas tree style where possible.

Will do.

>
>
> > -     if (data_pos == -ENXIO)
> > -             data_pos = f_size;
> > -     else if (data_pos <= read->rd_offset || (data_pos < f_size && data_pos % PAGE_SIZE))
> > -             return nfsd4_encode_read_plus_data(resp, read, maxcount, eof, &f_size);
> > -     count = data_pos - read->rd_offset;
> > -
> > -     /* Content type, offset, byte count */
> > -     p = xdr_reserve_space(resp->xdr, 4 + 8 + 8);
> > -     if (!p)
> > +     /* enough space for a HOLE segment before we switch to the pages */
> > +     if (!xdr_reserve_space(xdr, 4 + 8 + 8))
> >               return nfserr_resource;
> > +     xdr_commit_encode(xdr);
> >
> > -     *p++ = htonl(NFS4_CONTENT_HOLE);
> > -     p = xdr_encode_hyper(p, read->rd_offset);
> > -     p = xdr_encode_hyper(p, count);
> > +     maxcount = min_t(unsigned long, read->rd_length,
> > +                      (xdr->buf->buflen - xdr->buf->len));
> >
> > -     *eof = (read->rd_offset + count) >= f_size;
> > -     *maxcount = min_t(unsigned long, count, *maxcount);
> > +     nfserr = nfsd4_read_plus_readv(resp, read, &maxcount, eof);
> > +     if (nfserr)
> > +             return nfserr;
> > +
> > +     while (maxcount > 0) {
> > +             vpage = xdr_buf_nth_page_address(xdr->buf, i, &pagelen);
> > +             pagelen = min_t(unsigned int, pagelen, maxcount);
> > +             if (!vpage || pagelen == 0)
> > +                     break;
> > +             p = memchr_inv(vpage, 0, pagelen);
>
> So you have to walk every page in the payload, byte-by-byte, to
> sort out how to encode the READ_PLUS result? That's... unfortunate.
> The whole idea of making the READ payload "opaque" is that XDR
> doesn't have to touch those bytes; and then the payload is passed
> to the network layer as pointers to pages for the same reason.
>
> It might be helpful to get this reviewed by fsdevel and linux-mm
> in case there's a better approach. Hugh was attempting to point
> all zero pages at ZERO_PAGE at one point, for example, and that
> would make it very quick to detect a range of zero bytes.

I agree something like that would be better. I brought up tracking
zero pages to Matthew Wilcox during LSF, so it's at least on his
radar.

>
> Another thought is to use a POSIX byte-range lock to prevent
> changes to the range of the file you're encoding, while leaving
> the rest of the file available for other operations. That way
> you could continue to use llseek when that's supported.

Wouldn't that still deadlock when vfs_llseek() also locks the file? Or
am I misunderstanding something about byte-range locking?

>
>
> > +             pagetype = (p == NULL) ? NFS4_CONTENT_HOLE : NFS4_CONTENT_DATA;
> > +
> > +             if (pagetype != segment.type || i == 0) {
> > +                     if (likely(i > 0)) {
> > +                             nfsd4_encode_read_plus_segment(xdr, &segment,
> > +                                                           &bufpos, segments);
> > +                             offset += segment.length;
> > +                     }
> > +                     segment.type = pagetype;
> > +                     segment.offset = offset;
> > +                     segment.length = pagelen;
> > +                     segment.page_pos = i * PAGE_SIZE;
> > +             } else
> > +                     segment.length += pagelen;
> > +
> > +             maxcount -= pagelen;
> > +             i++;
> > +     }
> > +
> > +     nfsd4_encode_read_plus_segment(xdr, &segment, &bufpos, segments);
> > +     xdr_truncate_encode(xdr, bufpos);
> >       return nfs_ok;
> > }
> >
> > @@ -4813,69 +4853,31 @@ static __be32
> > nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> >                      struct nfsd4_read *read)
> > {
> > -     unsigned long maxcount, count;
> >       struct xdr_stream *xdr = resp->xdr;
> > -     struct file *file;
> >       int starting_len = xdr->buf->len;
> > -     int last_segment = xdr->buf->len;
> > -     int segments = 0;
> > -     __be32 *p, tmp;
> > -     bool is_data;
> > -     loff_t pos;
> > +     unsigned int segments = 0;
> >       u32 eof;
> >
> >       if (nfserr)
> >               return nfserr;
> > -     file = read->rd_nf->nf_file;
> >
> >       /* eof flag, segment count */
> > -     p = xdr_reserve_space(xdr, 4 + 4);
> > -     if (!p)
> > +     if (!xdr_reserve_space(xdr, 4 + 4))
> >               return nfserr_resource;
> >       xdr_commit_encode(xdr);
> >
> > -     maxcount = min_t(unsigned long, read->rd_length,
> > -                      (xdr->buf->buflen - xdr->buf->len));
> > -     count    = maxcount;
> > -
> > -     eof = read->rd_offset >= i_size_read(file_inode(file));
> > +     eof = read->rd_offset >= i_size_read(file_inode(read->rd_nf->nf_file));
> >       if (eof)
> >               goto out;
> >
> > -     pos = vfs_llseek(file, read->rd_offset, SEEK_HOLE);
> > -     is_data = pos > read->rd_offset;
> > -
> > -     while (count > 0 && !eof) {
> > -             maxcount = count;
> > -             if (is_data)
> > -                     nfserr = nfsd4_encode_read_plus_data(resp, read, &maxcount, &eof,
> > -                                             segments == 0 ? &pos : NULL);
> > -             else
> > -                     nfserr = nfsd4_encode_read_plus_hole(resp, read, &maxcount, &eof);
> > -             if (nfserr)
> > -                     goto out;
> > -             count -= maxcount;
> > -             read->rd_offset += maxcount;
> > -             is_data = !is_data;
> > -             last_segment = xdr->buf->len;
> > -             segments++;
> > -     }
> > -
> > +     nfserr = nfsd4_encode_read_plus_segments(resp, read, &segments, &eof);
> > out:
> > -     if (nfserr && segments == 0)
> > +     if (nfserr)
> >               xdr_truncate_encode(xdr, starting_len);
> >       else {
> > -             if (nfserr) {
> > -                     xdr_truncate_encode(xdr, last_segment);
> > -                     nfserr = nfs_ok;
> > -                     eof = 0;
> > -             }
> > -             tmp = htonl(eof);
> > -             write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, 4);
> > -             tmp = htonl(segments);
> > -             write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
> > +             xdr_encode_word(xdr->buf, starting_len,     eof);
> > +             xdr_encode_word(xdr->buf, starting_len + 4, segments);
> >       }
> > -
> >       return nfserr;
> > }
>
> The clean-ups in nfsd4_encode_read_plus() LGTM.

Thanks for the review!
Anna

>
>
> --
> Chuck Lever
>
>
>
