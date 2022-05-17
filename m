Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8781852A3A0
	for <lists+linux-nfs@lfdr.de>; Tue, 17 May 2022 15:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240590AbiEQNj0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 May 2022 09:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244994AbiEQNjZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 May 2022 09:39:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABE24CD67
        for <linux-nfs@vger.kernel.org>; Tue, 17 May 2022 06:39:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so1416221wms.3
        for <linux-nfs@vger.kernel.org>; Tue, 17 May 2022 06:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7c6Icc+5YOUNiSLDhgzN1DhWdd2y2DpMY2qgbO6ja5U=;
        b=byTlfnMih0Pls9jjFKj2HGo5075tzsxqKXztbVwfCBue7QarhamHhpydQzapCz8Mhq
         Bh4Ys6KbdvVEH4+j39f8Zp7pKXn8OHEGsjAzJX13So6yAbyV08OUAD99AijenM6BFR3E
         upwsppoGAmn1RFYZvi3bqAdW+9lvrJRGG0QEVUe6+dvl7IWkQfP01SGKoboIp0ZDLqe0
         X3gYh1eIHSFxRtMfMnAKIA8TdEifaCiCNXXqAlt31uINudCR95wQIjJJCIAHDg+oUujA
         nm0KEED2p3A8XSx3P04Bu9SOwF95S4AcBzA9SvuurcXusx8WoNmoqJ58ljro1QciVqzv
         9zgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7c6Icc+5YOUNiSLDhgzN1DhWdd2y2DpMY2qgbO6ja5U=;
        b=jxOaBsOe15slaSTnu8S04Uj94VPpHREdqpID2nGNRl3L5YmbrhAcEiHUQhl6fD/8rN
         vprTQ6bU5L0MZIT1UsnvlHVrljGh2H34qu2IWSX4o6q85X/O/vt1LHjeM1YKcgCwyqq0
         BQ4m3THBLUJZRf3u3qL2y5JcJgb76Yz1/deteQypkGBx9zS1bI4nHOUrF7KDRCcYwb6N
         YXT+il1d6JqNWdNrGrgfzIGiRHj0qmKi7+ndL/hN7EzPHh7UFFdZpKDw6D1r6xFvCTLd
         o+hoKx+ZWZq43XuO9tE/MRRCDoPr/X3XM9IiXyDuVneIl6mhoNWrBKncaHfyLPG9w+Jn
         mhYw==
X-Gm-Message-State: AOAM531dDu8PQWA1eoVM413XGycK1mPZHt8Xq53bIAwlkxeMhdmEAORe
        QDtAXQV/wVrvpPj1MZ+WfIz1KnCeGMxW0f2TQxQ=
X-Google-Smtp-Source: ABdhPJy+qHgAy4U8CY56En2UcptMsSxpU8c4StY7GEsL36vUjTnSCDtZiR3/gaCRgPedzghHOIHBG8+uTw48aiUID84=
X-Received: by 2002:a05:600c:4f52:b0:394:61af:a168 with SMTP id
 m18-20020a05600c4f5200b0039461afa168mr32015674wmq.114.1652794762309; Tue, 17
 May 2022 06:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220516203549.2605575-1-Anna.Schumaker@Netapp.com>
 <20220516203549.2605575-7-Anna.Schumaker@Netapp.com> <CFB40FB8-5180-499E-93B8-0DF4C8FE8D94@oracle.com>
In-Reply-To: <CFB40FB8-5180-499E-93B8-0DF4C8FE8D94@oracle.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Tue, 17 May 2022 09:39:06 -0400
Message-ID: <CAFX2JfnxCYF6FSk6k5gfNA+oCRSf-xfqdZY9Hcog2MaL1PdaOg@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] NFSD: Repeal and replace the READ_PLUS implementation
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

On Mon, May 16, 2022 at 11:16 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On May 16, 2022, at 4:35 PM, Anna.Schumaker@Netapp.com wrote:
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
> >
> > I also included an optimization where we can cut down on the amount of
> > memory being shifed around by doing the compression as (hole, data)
> > pairs.
> >
> > This patch not only fixes xfstests generic/091 and generic/263
> > for me but the "-g quick" group tests also finish about a minute faster.
> >
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>
> Hi Anna, some general comments on the NFSD pieces:

Thanks for looking over this!

>
> - Doesn't READ have the same issue that the file bytes can't change
>   until the Reply is fully sent? I would think the payload data
>   can't change until there is no possibility of a transport-layer
>   retransmit. Also, special restrictions like this should be
>   documented via code comments, IMHO.

The problem with the current READ_PLUS code is that the first segment
in the reply could already be stale data by the time the last segment
has been encoded. So we're returning a view of the file from multiple
points in time. READ only does the single call into the vfs, so it
doesn't have the same race that's causing issues.

>
> - David Howells might be interested in this approach, as he had some
>   concerns about compressing files in place that would appear to
>   apply also to READ_PLUS. Please copy David on the next round of
>   these patches.

Will do!

>
> - Can you say why the READ_PLUS decoder and encoder operates on
>   struct xdr_buf instead of struct xdr_stream? I'd prefer xdr_stream
>   if you can. You could get rid of write_bytes_to_xdr_buf,
>   xdr_encode_word and xdr_encode_double and use the stream-based
>   helpers.

I think my reason was that write_bytes_to_xdr_buf() and
xdr_encode_word() already took the xdr_buf, so I was matching the
style. I can change everything over to xdr_stream easily enough, since
the xdr_bufs in question are always attached to the xdr_stream. Would
you prefer it if I rework the existing functions as part of this patch
series, or as a separate prerequisite series?

>
> - Instead of using naked integers, please use multiples of XDR_UNIT.

I hadn't encountered XDR_UNIT before, but I can do that.

>
>
> > ---
> > fs/nfsd/nfs4xdr.c | 202 +++++++++++++++++++++++-----------------------
> > 1 file changed, 102 insertions(+), 100 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index da92e7d2ab6a..973b4a1e7990 100644
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
> >
> > +     /* xdr_reserve_space_vec() switches us to the xdr->pages */
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
> > +     } else {
> > +             size_t align = xdr_align_size(segment->length);
> > +             xdr_encode_word(buf, *bufpos + 12, segment->length);
> > +             if (*segments == 0)
> > +                     xdr_buf_trim_head(buf, 4);
> > +
> > +             xdr_stream_move_segment(xdr,
> > +                             buf->head[0].iov_len + segment->page_pos,
> > +                             *bufpos + 16, align);
>
> The term "segment" is overloaded in general, and in particular
> here. xdr_stream_move_subsegment() might be a less confusing
> name for this helper.

Sure, no problem.

>
> However I don't immediately see a benefit from working with the
> xdr_buf here. Can't you do these operations entirely with the
> passed-in xdr_stream?

I assume so, since the xdr_buf is part of the xdr_stream

>
>
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
> >
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
> >
> > --
> > 2.36.1
> >
>
> --
> Chuck Lever
>
>
>
