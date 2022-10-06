Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0FA5F6BDB
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Oct 2022 18:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiJFQfy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Oct 2022 12:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiJFQfx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Oct 2022 12:35:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2864B2D95
        for <linux-nfs@vger.kernel.org>; Thu,  6 Oct 2022 09:35:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F2CEACE16E9
        for <linux-nfs@vger.kernel.org>; Thu,  6 Oct 2022 16:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F9EC433D6;
        Thu,  6 Oct 2022 16:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665074148;
        bh=fs/gQ4jpEI3+1zn6ee2B6EXW1kdfAXKK850n0kTLKcM=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=nEtpuQU1kOIguyws+S0JSAvYPJWIcvVVGENc5/jRWmaXgKInI9hE/trSo3NPkU2wN
         ccjcNNGWIQQQty4UICEFnARNuDj0PCPEehLj2FM9RQNXTEy+men0zgENgB6PPAsb3S
         w3Obna4gWd/F2jgQJxN8D1dVNNc0MqVVNU+WlpYMByPo9Ui7zVS6UjvX5w0mTZoER5
         CORaxoA+t2ctkS/n6io0x5Fdfn2fqXMkmk4qmXTyRXNQQw23jijX91Bzk1WJbFNjgj
         EsqASO4/HdizOGjeKPxGrETflzJ5nTkxgk+NOqoEmurgta5EkJvRultmvWbftJ7d2K
         rsGLYi7r8MrfA==
Message-ID: <63bc0e7e650435970af1070fd42fd1c904266319.camel@kernel.org>
Subject: Re: [PATCH v4 2/2] NFSD: Simplify READ_PLUS
From:   Jeff Layton <jlayton@kernel.org>
To:     Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        chuck.lever@oracle.com
Date:   Thu, 06 Oct 2022 12:35:46 -0400
In-Reply-To: <20220913180151.1928363-3-anna@kernel.org>
References: <20220913180151.1928363-1-anna@kernel.org>
         <20220913180151.1928363-3-anna@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-09-13 at 14:01 -0400, Anna Schumaker wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> Chuck had suggested reverting READ_PLUS so it returns a single DATA
> segment covering the requested read range. This prepares the server for
> a future "sparse read" function so support can easily be added without
> needing to rip out the old READ_PLUS code at the same time.
>=20
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
>  fs/nfsd/nfs4xdr.c | 139 +++++++++++-----------------------------------
>  1 file changed, 32 insertions(+), 107 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 01dd73ed5720..280c7c8ac807 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4731,79 +4731,37 @@ nfsd4_encode_offload_status(struct nfsd4_compound=
res *resp, __be32 nfserr,
> =20
>  static __be32
>  nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> -			    struct nfsd4_read *read,
> -			    unsigned long *maxcount, u32 *eof,
> -			    loff_t *pos)
> +			    struct nfsd4_read *read)
>  {
> -	struct xdr_stream *xdr =3D resp->xdr;
> +	bool splice_ok =3D test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags);
>  	struct file *file =3D read->rd_nf->nf_file;
> -	int starting_len =3D xdr->buf->len;
> -	loff_t hole_pos;
> -	__be32 nfserr;
> -	__be32 *p, tmp;
> -	__be64 tmp64;
> -
> -	hole_pos =3D pos ? *pos : vfs_llseek(file, read->rd_offset, SEEK_HOLE);
> -	if (hole_pos > read->rd_offset)
> -		*maxcount =3D min_t(unsigned long, *maxcount, hole_pos - read->rd_offs=
et);
> -	*maxcount =3D min_t(unsigned long, *maxcount, (xdr->buf->buflen - xdr->=
buf->len));
> +	struct xdr_stream *xdr =3D resp->xdr;
> +	unsigned long maxcount;
> +	__be32 nfserr, *p;
> =20
>  	/* Content type, offset, byte count */
>  	p =3D xdr_reserve_space(xdr, 4 + 8 + 4);
>  	if (!p)
> -		return nfserr_resource;
> +		return nfserr_io;
> +	if (resp->xdr->buf->page_len && splice_ok) {
> +		WARN_ON_ONCE(splice_ok);
> +		return nfserr_serverfault;
> +	}
> =20
> -	read->rd_vlen =3D xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, *maxc=
ount);
> -	if (read->rd_vlen < 0)
> -		return nfserr_resource;
> +	maxcount =3D min_t(unsigned long, read->rd_length,
> +			 (xdr->buf->buflen - xdr->buf->len));
> =20
> -	nfserr =3D nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
> -			    resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
> +	if (file->f_op->splice_read && splice_ok)
> +		nfserr =3D nfsd4_encode_splice_read(resp, read, file, maxcount);
> +	else
> +		nfserr =3D nfsd4_encode_readv(resp, read, file, maxcount);
>  	if (nfserr)
>  		return nfserr;
> -	xdr_truncate_encode(xdr, starting_len + 16 + xdr_align_size(*maxcount))=
;
> =20
> -	tmp =3D htonl(NFS4_CONTENT_DATA);
> -	write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
> -	tmp64 =3D cpu_to_be64(read->rd_offset);
> -	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
> -	tmp =3D htonl(*maxcount);
> -	write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
> -
> -	tmp =3D xdr_zero;
> -	write_bytes_to_xdr_buf(xdr->buf, starting_len + 16 + *maxcount, &tmp,
> -			       xdr_pad_size(*maxcount));
> -	return nfs_ok;
> -}
> -
> -static __be32
> -nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
> -			    struct nfsd4_read *read,
> -			    unsigned long *maxcount, u32 *eof)
> -{
> -	struct file *file =3D read->rd_nf->nf_file;
> -	loff_t data_pos =3D vfs_llseek(file, read->rd_offset, SEEK_DATA);
> -	loff_t f_size =3D i_size_read(file_inode(file));
> -	unsigned long count;
> -	__be32 *p;
> -
> -	if (data_pos =3D=3D -ENXIO)
> -		data_pos =3D f_size;
> -	else if (data_pos <=3D read->rd_offset || (data_pos < f_size && data_po=
s % PAGE_SIZE))
> -		return nfsd4_encode_read_plus_data(resp, read, maxcount, eof, &f_size)=
;
> -	count =3D data_pos - read->rd_offset;
> -
> -	/* Content type, offset, byte count */
> -	p =3D xdr_reserve_space(resp->xdr, 4 + 8 + 8);
> -	if (!p)
> -		return nfserr_resource;
> -
> -	*p++ =3D htonl(NFS4_CONTENT_HOLE);
> +	*p++ =3D cpu_to_be32(NFS4_CONTENT_DATA);
>  	p =3D xdr_encode_hyper(p, read->rd_offset);
> -	p =3D xdr_encode_hyper(p, count);
> +	*p =3D cpu_to_be32(read->rd_length);
> =20
> -	*eof =3D (read->rd_offset + count) >=3D f_size;
> -	*maxcount =3D min_t(unsigned long, count, *maxcount);
>  	return nfs_ok;
>  }
> =20
> @@ -4811,69 +4769,36 @@ static __be32
>  nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
>  		       struct nfsd4_read *read)
>  {
> -	unsigned long maxcount, count;
> +	struct file *file =3D read->rd_nf->nf_file;
>  	struct xdr_stream *xdr =3D resp->xdr;
> -	struct file *file;
>  	int starting_len =3D xdr->buf->len;
> -	int last_segment =3D xdr->buf->len;
> -	int segments =3D 0;
> -	__be32 *p, tmp;
> -	bool is_data;
> -	loff_t pos;
> -	u32 eof;
> +	u32 segments =3D 0;
> +	__be32 *p;
> =20
>  	if (nfserr)
>  		return nfserr;
> -	file =3D read->rd_nf->nf_file;
> =20
>  	/* eof flag, segment count */
>  	p =3D xdr_reserve_space(xdr, 4 + 4);
>  	if (!p)
> -		return nfserr_resource;
> +		return nfserr_io;
>  	xdr_commit_encode(xdr);
> =20
> -	maxcount =3D min_t(unsigned long, read->rd_length,
> -			 (xdr->buf->buflen - xdr->buf->len));
> -	count    =3D maxcount;
> -
> -	eof =3D read->rd_offset >=3D i_size_read(file_inode(file));
> -	if (eof)
> +	read->rd_eof =3D read->rd_offset >=3D i_size_read(file_inode(file));
> +	if (read->rd_eof)
>  		goto out;
> =20
> -	pos =3D vfs_llseek(file, read->rd_offset, SEEK_HOLE);
> -	is_data =3D pos > read->rd_offset;
> -
> -	while (count > 0 && !eof) {
> -		maxcount =3D count;
> -		if (is_data)
> -			nfserr =3D nfsd4_encode_read_plus_data(resp, read, &maxcount, &eof,
> -						segments =3D=3D 0 ? &pos : NULL);
> -		else
> -			nfserr =3D nfsd4_encode_read_plus_hole(resp, read, &maxcount, &eof);
> -		if (nfserr)
> -			goto out;
> -		count -=3D maxcount;
> -		read->rd_offset +=3D maxcount;
> -		is_data =3D !is_data;
> -		last_segment =3D xdr->buf->len;
> -		segments++;
> -	}
> -
> -out:
> -	if (nfserr && segments =3D=3D 0)
> +	nfserr =3D nfsd4_encode_read_plus_data(resp, read);
> +	if (nfserr) {
>  		xdr_truncate_encode(xdr, starting_len);
> -	else {
> -		if (nfserr) {
> -			xdr_truncate_encode(xdr, last_segment);
> -			nfserr =3D nfs_ok;
> -			eof =3D 0;
> -		}
> -		tmp =3D htonl(eof);
> -		write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, 4);
> -		tmp =3D htonl(segments);
> -		write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
> +		return nfserr;
>  	}
> =20
> +	segments++;
> +
> +out:
> +	p =3D xdr_encode_bool(p, read->rd_eof);
> +	*p =3D cpu_to_be32(segments);
>  	return nfserr;
>  }
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>

