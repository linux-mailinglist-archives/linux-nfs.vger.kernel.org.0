Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CFE258090
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Aug 2020 20:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgHaSPj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Aug 2020 14:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgHaSPj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Aug 2020 14:15:39 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EDCC061573
        for <linux-nfs@vger.kernel.org>; Mon, 31 Aug 2020 11:15:37 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id nw23so8345861ejb.4
        for <linux-nfs@vger.kernel.org>; Mon, 31 Aug 2020 11:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8x5rjn6sPo70/9EsPHc1p/0dKHnuRjXiFa72vNPJqpE=;
        b=rQ0PDASQYz+gqoywf9d5gfUhtfjWGD76tlHsadj7mhSiiX/FVJUBUdLeZsFYwr9qd/
         dq5U8U9d/WfAxomTwM27hCuQsJeHFrABWimV6ryCBUTX/pYZbDGhy/bx0nQMaU5go3+p
         wzXH6jLDKRf8mbcGtuT0Bl1k62KeD6wdK76hsWO0QASYkVdbHv6m8g4MObbV8L+N+55F
         wLjR5DQ4SjcoaoKNiUIzwVqz87c1nMCc+TNdvD0hvPsWX8343tvv7LVRLy4DQdXjpd7H
         NzvGg+jux+eX12UAxHcbscYNXu0nHjsWOHKKwLziSNMY/4bzxQ4EBWUHRTkOdr4bI6Fk
         HOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8x5rjn6sPo70/9EsPHc1p/0dKHnuRjXiFa72vNPJqpE=;
        b=NLw1vCEzW+GnIW+Rnfemciwdc/acJXNqTtlfmu4xM8uSKmNJWv0dZC1AbOsAmxn70h
         pCcl3jJIZdmUlJEEvfPlTtpqbhi03LwqmnsAON2Xalq68jMxsxRaB4jdFySJcgj69nbu
         96DLRaqka9Y21ba8wtPOayMxOXCdPNalOXg9RDPOVR72ANyOWlgkRLBLrfhLtVEmg/94
         enzliLQMzDdaCX7f1vAldjf7ZztkC/yuv6kZUQCXlcXAXtwARjXUmQFaSIvLjwj9fuvZ
         /pEGVdiLmIxOt+sULH1rL+mTknuPQfnoat5gK6Fc42MqPXSmX+lYJ13C74rilMeGKjHh
         mO+w==
X-Gm-Message-State: AOAM5336TuUGsmzwYHlImg25zfJHrDdsqgaPoTlXsOtctDqfROfdedbb
        gjfWOkxE2NTflNfPqRH/X1DGe9jcai3CRCcjgxA=
X-Google-Smtp-Source: ABdhPJx/Q4ZBnUvud0IPi5xmW6ELkSBufFcUe/VsFxAYnLK59S2rd9A9HswZNjxSwhdOpXhqIgWqYaL5NDMjaWAgWGk=
X-Received: by 2002:a17:906:90d3:: with SMTP id v19mr2108676ejw.23.1598897735558;
 Mon, 31 Aug 2020 11:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200817165310.354092-1-Anna.Schumaker@Netapp.com>
 <20200817165310.354092-5-Anna.Schumaker@Netapp.com> <20200828221859.GC33226@pick.fieldses.org>
In-Reply-To: <20200828221859.GC33226@pick.fieldses.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Mon, 31 Aug 2020 14:15:19 -0400
Message-ID: <CAFX2Jf=L26ZxEqR=Bttgdn6EHW8jo2J6fj9dqK3ARMWXOhnegA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] NFSD: Return both a hole and a data segment
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 28, 2020 at 6:19 PM J. Bruce Fields <bfields@redhat.com> wrote:
>
> On Mon, Aug 17, 2020 at 12:53:09PM -0400, schumaker.anna@gmail.com wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > But only one of each right now. We'll expand on this in the next patch.
> >
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> >  fs/nfsd/nfs4xdr.c | 51 ++++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 37 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 2fa39217c256..3f4860103b25 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -4373,7 +4373,7 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
> >  static __be32
> >  nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> >                           struct nfsd4_read *read,
> > -                         unsigned long maxcount,  u32 *eof)
> > +                         unsigned long *maxcount, u32 *eof)
> >  {
> >       struct xdr_stream *xdr = &resp->xdr;
> >       struct file *file = read->rd_nf->nf_file;
> > @@ -4384,19 +4384,19 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> >       __be64 tmp64;
> >
> >       if (hole_pos > read->rd_offset)
> > -             maxcount = min_t(unsigned long, maxcount, hole_pos - read->rd_offset);
> > +             *maxcount = min_t(unsigned long, *maxcount, hole_pos - read->rd_offset);
> >
> >       /* Content type, offset, byte count */
> >       p = xdr_reserve_space(xdr, 4 + 8 + 4);
> >       if (!p)
> >               return nfserr_resource;
> >
> > -     read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, maxcount);
> > +     read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, *maxcount);
> >       if (read->rd_vlen < 0)
> >               return nfserr_resource;
> >
> >       nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
> > -                         resp->rqstp->rq_vec, read->rd_vlen, &maxcount, eof);
> > +                         resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
> >       if (nfserr)
> >               return nfserr;
> >
> > @@ -4404,7 +4404,7 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> >       write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
> >       tmp64 = cpu_to_be64(read->rd_offset);
> >       write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
> > -     tmp = htonl(maxcount);
> > +     tmp = htonl(*maxcount);
> >       write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
> >       return nfs_ok;
> >  }
> > @@ -4412,11 +4412,19 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> >  static __be32
> >  nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
> >                           struct nfsd4_read *read,
> > -                         unsigned long maxcount, u32 *eof)
> > +                         unsigned long *maxcount, u32 *eof)
> >  {
> >       struct file *file = read->rd_nf->nf_file;
> > +     loff_t data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
>
> Everywhere I see fs_llseek()s and i_size_read()s, I start wondering
> where there might be races.  E.g.:
>
> > +     unsigned long count;
> >       __be32 *p;
> >
> > +     if (data_pos == -ENXIO)
> > +             data_pos = i_size_read(file_inode(file));
> > +     else if (data_pos <= read->rd_offset)
> > +             return nfserr_resource;
>
> I think that means a concurrent truncate would cause us to fail the
> entire read, when I suspect the right thing to do is to return a short
> (but successful) read.

Okay. I think I can do that in nfsd4_encode_read_plus() by checking if
there is an error and if we've encoded at least 1 segment.
>
> --b.
>
> > +     count = data_pos - read->rd_offset;
> > +
> >       /* Content type, offset, byte count */
> >       p = xdr_reserve_space(&resp->xdr, 4 + 8 + 8);
> >       if (!p)
> > @@ -4424,9 +4432,10 @@ nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
> >
> >       *p++ = htonl(NFS4_CONTENT_HOLE);
> >        p   = xdr_encode_hyper(p, read->rd_offset);
> > -      p   = xdr_encode_hyper(p, maxcount);
> > +      p   = xdr_encode_hyper(p, count);
> >
> > -     *eof = (read->rd_offset + maxcount) >= i_size_read(file_inode(file));
> > +     *eof = (read->rd_offset + count) >= i_size_read(file_inode(file));
> > +     *maxcount = min_t(unsigned long, count, *maxcount);
> >       return nfs_ok;
> >  }
> >
> > @@ -4434,7 +4443,7 @@ static __be32
> >  nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> >                      struct nfsd4_read *read)
> >  {
> > -     unsigned long maxcount;
> > +     unsigned long maxcount, count;
> >       struct xdr_stream *xdr = &resp->xdr;
> >       struct file *file;
> >       int starting_len = xdr->buf->len;
> > @@ -4457,6 +4466,7 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> >       maxcount = min_t(unsigned long, maxcount,
> >                        (xdr->buf->buflen - xdr->buf->len));
> >       maxcount = min_t(unsigned long, maxcount, read->rd_length);
> > +     count    = maxcount;
> >
> >       eof = read->rd_offset >= i_size_read(file_inode(file));
> >       if (eof)
> > @@ -4465,13 +4475,26 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> >       pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
> >       if (pos == -ENXIO)
> >               pos = i_size_read(file_inode(file));
> > +     else if (pos < 0)
> > +             pos = read->rd_offset;
> >
> > -     if (pos > read->rd_offset) {
> > -             maxcount = pos - read->rd_offset;
> > -             nfserr = nfsd4_encode_read_plus_hole(resp, read, maxcount, &eof);
> > +     if (pos == read->rd_offset) {
> > +             maxcount = count;
> > +             nfserr = nfsd4_encode_read_plus_data(resp, read, &maxcount, &eof);
> > +             if (nfserr)
> > +                     goto out;
> > +             count -= maxcount;
> > +             read->rd_offset += maxcount;
> >               segments++;
> > -     } else {
> > -             nfserr = nfsd4_encode_read_plus_data(resp, read, maxcount, &eof);
> > +     }
> > +
> > +     if (count > 0 && !eof) {
> > +             maxcount = count;
> > +             nfserr = nfsd4_encode_read_plus_hole(resp, read, &maxcount, &eof);
> > +             if (nfserr)
> > +                     goto out;
> > +             count -= maxcount;
> > +             read->rd_offset += maxcount;
> >               segments++;
> >       }
> >
> > --
> > 2.28.0
> >
>
