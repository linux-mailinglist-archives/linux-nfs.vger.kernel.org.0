Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCA35B0E39
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Sep 2022 22:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiIGUhq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Sep 2022 16:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiIGUhp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Sep 2022 16:37:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC6F9CCED
        for <linux-nfs@vger.kernel.org>; Wed,  7 Sep 2022 13:37:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AE456CE1D52
        for <linux-nfs@vger.kernel.org>; Wed,  7 Sep 2022 20:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2B6C433D7
        for <linux-nfs@vger.kernel.org>; Wed,  7 Sep 2022 20:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662583059;
        bh=hBI/w2gWFK1aNMj7HHaQPwisruZ2tfxeyDUgPojMZmM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iOVvfZKa7cJlSFwCDDQ22KJt61TOjkKsejzrmS57xLHGiakJ+Vulot41LlJ7xcfI/
         uPmX3MaBASdAGh+gtExAOmKnC6IY2WXCr52acXkWYfrsXdSIT8j9uQB6i+Aj0YPMr8
         ZHZx6VqoQuMKpZH+Px4+0dpvKapFjpQfSoHaVeCRaiWeE77b7QqyMCErQ1uecHXi7J
         qugawc5VlUoz73bvpJRGjZoTF1RFQbz5qZz6a5J8l3LqWmSqr7Ap96aPZHQT5sY21m
         AFbvaKLRN4Qk6RZWlhvDFaIYk4AFlZW7Avf8NZ4lTwa6froITnjmdO9dO8FShJNhjn
         zwoSRp+mUt0dg==
Received: by mail-wm1-f44.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso119646wmb.0
        for <linux-nfs@vger.kernel.org>; Wed, 07 Sep 2022 13:37:39 -0700 (PDT)
X-Gm-Message-State: ACgBeo2Qmek565FRjmcJuukHgZgDYk8DoMdOXEcBoD668cgFMqDdbiGI
        FkgyragwyoFgcYYVJG+VfajTigNEvULsdmhHldQ=
X-Google-Smtp-Source: AA6agR4iFQbnEd5uL2j0wLGxTy7GroUMQvJkoMFlKZHdvq68cux7zI7Z6BGoz4rHhcd5KiiqeEMh3W/uRgvwZVMIh64=
X-Received: by 2002:a05:600c:2c47:b0:3a6:4623:4ccf with SMTP id
 r7-20020a05600c2c4700b003a646234ccfmr121674wmg.85.1662583057754; Wed, 07 Sep
 2022 13:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220907195259.926736-1-anna@kernel.org> <20220907195259.926736-2-anna@kernel.org>
 <06EA863F-8C11-4342-8D88-954E99A07598@oracle.com>
In-Reply-To: <06EA863F-8C11-4342-8D88-954E99A07598@oracle.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Wed, 7 Sep 2022 16:37:21 -0400
X-Gmail-Original-Message-ID: <CAFX2JfnNa80uhdeg=8YMiVWQGimkC7VrPHORjB=8SyOVw35Z_g@mail.gmail.com>
Message-ID: <CAFX2JfnNa80uhdeg=8YMiVWQGimkC7VrPHORjB=8SyOVw35Z_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] NFSD: Simplify READ_PLUS
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 7, 2022 at 4:29 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
> Be sure to Cc: Jeff on these. Thanks!
>
>
> > On Sep 7, 2022, at 3:52 PM, Anna Schumaker <anna@kernel.org> wrote:
> >
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > Chuck had suggested reverting READ_PLUS so it returns a single DATA
> > segment covering the requested read range. This prepares the server for
> > a future "sparse read" function so support can easily be added without
> > needing to rip out the old READ_PLUS code at the same time.
> >
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> > fs/nfsd/nfs4xdr.c | 139 +++++++++++-----------------------------------
> > 1 file changed, 32 insertions(+), 107 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 1e9690a061ec..bcc8c385faf2 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -4731,79 +4731,37 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
> >
> > static __be32
> > nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> > -                         struct nfsd4_read *read,
> > -                         unsigned long *maxcount, u32 *eof,
> > -                         loff_t *pos)
> > +                         struct nfsd4_read *read)
> > {
> > -     struct xdr_stream *xdr = resp->xdr;
> > +     bool splice_ok = test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags);
> >       struct file *file = read->rd_nf->nf_file;
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
> > +     struct xdr_stream *xdr = resp->xdr;
> > +     unsigned long maxcount;
> > +     __be32 nfserr, *p;
> >
> >       /* Content type, offset, byte count */
> >       p = xdr_reserve_space(xdr, 4 + 8 + 4);
> >       if (!p)
> > -             return nfserr_resource;
> > +             return nfserr_io;
>
> Wouldn't nfserr_rep_too_big be a more appropriate status for running
> off the end of the send buffer? I'm not 100% sure, but I would expect
> that exhausting send buffer space would imply the reply has grown too
> large.

I can switch it to that, no problem.

>
>
> > +     if (resp->xdr->buf->page_len && splice_ok) {
> > +             WARN_ON_ONCE(splice_ok);
> > +             return nfserr_io;
> > +     }
>
> I wish I understood why this test was needed. It seems to have been
> copied and pasted from historic code into nfsd4_encode_read(), and
> there have been recent mechanical changes to it, but there's no
> comment explaining it there...

Yeah, I saw this was in the read code and assumed it was an important
check so I added it here too.
>
> In any event, this seems to be checking for a server software bug,
> so maybe this should return nfserr_serverfault. Oddly that status
> code isn't defined yet.

Do you want me to add that code and return it in this patch?

>
>
> Do you have some performance results for v2?

Not yet, I have it running now so hopefully I'll have something ready
by tomorrow morning.

Anna
>
>
> > -     read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, *maxcount);
> > -     if (read->rd_vlen < 0)
> > -             return nfserr_resource;
> > +     maxcount = min_t(unsigned long, read->rd_length,
> > +                      (xdr->buf->buflen - xdr->buf->len));
> >
> > -     nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
> > -                         resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
> > +     if (file->f_op->splice_read && splice_ok)
> > +             nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
> > +     else
> > +             nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
> >       if (nfserr)
> >               return nfserr;
> > -     xdr_truncate_encode(xdr, starting_len + 16 + xdr_align_size(*maxcount));
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
> > -     return nfs_ok;
> > -}
> > -
> > -static __be32
> > -nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
> > -                         struct nfsd4_read *read,
> > -                         unsigned long *maxcount, u32 *eof)
> > -{
> > -     struct file *file = read->rd_nf->nf_file;
> > -     loff_t data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
> > -     loff_t f_size = i_size_read(file_inode(file));
> > -     unsigned long count;
> > -     __be32 *p;
> > -
> > -     if (data_pos == -ENXIO)
> > -             data_pos = f_size;
> > -     else if (data_pos <= read->rd_offset || (data_pos < f_size && data_pos % PAGE_SIZE))
> > -             return nfsd4_encode_read_plus_data(resp, read, maxcount, eof, &f_size);
> > -     count = data_pos - read->rd_offset;
> > -
> > -     /* Content type, offset, byte count */
> > -     p = xdr_reserve_space(resp->xdr, 4 + 8 + 8);
> > -     if (!p)
> > -             return nfserr_resource;
> > -
> > -     *p++ = htonl(NFS4_CONTENT_HOLE);
> > +     *p++ = cpu_to_be32(NFS4_CONTENT_DATA);
> >       p = xdr_encode_hyper(p, read->rd_offset);
> > -     p = xdr_encode_hyper(p, count);
> > +     *p = cpu_to_be32(read->rd_length);
> >
> > -     *eof = (read->rd_offset + count) >= f_size;
> > -     *maxcount = min_t(unsigned long, count, *maxcount);
> >       return nfs_ok;
> > }
> >
> > @@ -4811,69 +4769,36 @@ static __be32
> > nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> >                      struct nfsd4_read *read)
> > {
> > -     unsigned long maxcount, count;
> > +     struct file *file = read->rd_nf->nf_file;
> >       struct xdr_stream *xdr = resp->xdr;
> > -     struct file *file;
> >       int starting_len = xdr->buf->len;
> > -     int last_segment = xdr->buf->len;
> > -     int segments = 0;
> > -     __be32 *p, tmp;
> > -     bool is_data;
> > -     loff_t pos;
> > -     u32 eof;
> > +     u32 segments = 0;
> > +     __be32 *p;
> >
> >       if (nfserr)
> >               return nfserr;
> > -     file = read->rd_nf->nf_file;
> >
> >       /* eof flag, segment count */
> >       p = xdr_reserve_space(xdr, 4 + 4);
> >       if (!p)
> > -             return nfserr_resource;
> > +             return nfserr_io;
> >       xdr_commit_encode(xdr);
> >
> > -     maxcount = min_t(unsigned long, read->rd_length,
> > -                      (xdr->buf->buflen - xdr->buf->len));
> > -     count    = maxcount;
> > -
> > -     eof = read->rd_offset >= i_size_read(file_inode(file));
> > -     if (eof)
> > +     read->rd_eof = read->rd_offset >= i_size_read(file_inode(file));
> > +     if (read->rd_eof)
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
> > -out:
> > -     if (nfserr && segments == 0)
> > +     nfserr = nfsd4_encode_read_plus_data(resp, read);
> > +     if (nfserr) {
> >               xdr_truncate_encode(xdr, starting_len);
> > -     else {
> > -             if (nfserr) {
> > -                     xdr_truncate_encode(xdr, last_segment);
> > -                     nfserr = nfs_ok;
> > -                     eof = 0;
> > -             }
> > -             tmp = htonl(eof);
> > -             write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, 4);
> > -             tmp = htonl(segments);
> > -             write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
> > +             return nfserr;
> >       }
> >
> > +     segments++;
> > +
> > +out:
> > +     p = xdr_encode_bool(p, read->rd_eof);
> > +     *p = cpu_to_be32(segments);
> >       return nfserr;
> > }
> >
> > --
> > 2.37.2
> >
>
> --
> Chuck Lever
>
>
>
