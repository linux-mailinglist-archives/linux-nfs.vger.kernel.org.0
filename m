Return-Path: <linux-nfs+bounces-11755-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DE1AB8B69
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 17:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5103B3A4FA2
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 15:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC19218ACA;
	Thu, 15 May 2025 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYoQMd18"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34895219A9B
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747323912; cv=none; b=pbyI3jhPJmhGAu+jh9tBqcLYQVkAq0TjS4DXNq6lW1TsNoQHHOqber3hAGlRNJ8N/zS+78eGWNlTxOIMqKFJ0eZaA4oSn5LElkZ8QaN0Gk9IJi8xxdAIP51wuROxtskK9Uz2pp1VCUU3w/5eiWxpNoi92TVCRI8k7b2jbP5Y+sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747323912; c=relaxed/simple;
	bh=HqSYIbVWSorsHyz/DrltHpTuebYlN3giiUuAAwXS1So=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hu/O7UYU0RUUqOG8OmWgCWCQgMk//ufjorXapwzUp8xU2yx4mjlDuj7Dk1GEZ7Y+DmB3OyZnn0rCXMmlghFYS6u1FvAAfPrI8FNrpIjG7ifwoWGTHv1/uunj7IYMBJ05VT8uP4Hygb7+jBhzdG/Maa7dYqs3dUOkcFYcPRLoZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYoQMd18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00697C4CEE7;
	Thu, 15 May 2025 15:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747323910;
	bh=HqSYIbVWSorsHyz/DrltHpTuebYlN3giiUuAAwXS1So=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VYoQMd18OGn3lOLOfAiWwvxyjbBOaT+hfwKjyxMLPPj7OtE4FUEsk57VfBvYPOfEV
	 UWJfKnWwQ5sKDYVXEr9ssCIBtYVwy/gLpGLJ8kAwproyL5Vjd70+uO6ukLp/eFEhi7
	 AuAq26S08av7flD96VXl1T67jwzgE9BC4ZTSjZcw6GYGF8vwpZ2OCIB0ppuwzMQUPK
	 cnFP9GETheMpQlYt6/f7969e3UkZSVsGb7BlTHjVr13Syx45yBxU6R0pGdf7KLJCLV
	 A2anSCNiEnItPxxFy37O6d5McXcNg/szc+Qvo+V8BDlo1OhM24R/LVpRWOIFRUYztJ
	 o1l3G/cwCehzQ==
Message-ID: <27cdbdee24f514060ac62da98262f08fc19fd24e.camel@kernel.org>
Subject: Re: [PATCH 2/3] sunrpc: simplify xdr_partial_copy_from_skb
From: Jeff Layton <jlayton@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org
Date: Thu, 15 May 2025 11:45:08 -0400
In-Reply-To: <20250515114906.32559-3-hch@lst.de>
References: <20250515114906.32559-1-hch@lst.de>
	 <20250515114906.32559-3-hch@lst.de>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-05-15 at 13:48 +0200, Christoph Hellwig wrote:
> csum_partial_copy_to_xdr can handle a checksumming and non-checksumming
> case and implements this using a callback, which leads to a lot of
> boilerplate code and indirect calls in the fast path.
>=20
> Switch to storing a need_checksum flag in struct xdr_skb_reader instead
> to remove the indirect call and simplify the code.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  net/sunrpc/socklib.c | 163 ++++++++++++++++---------------------------
>  1 file changed, 59 insertions(+), 104 deletions(-)
>=20
> diff --git a/net/sunrpc/socklib.c b/net/sunrpc/socklib.c
> index 1b2b84feeec6..75e31e3a3ced 100644
> --- a/net/sunrpc/socklib.c
> +++ b/net/sunrpc/socklib.c
> @@ -27,97 +27,60 @@
>  struct xdr_skb_reader {
>  	struct sk_buff	*skb;
>  	unsigned int	offset;
> +	bool		need_checksum;
>  	size_t		count;
>  	__wsum		csum;
>  };
> =20
> -typedef size_t (*xdr_skb_read_actor)(struct xdr_skb_reader *desc, void *=
to,
> -				     size_t len);
> -
>  /**
>   * xdr_skb_read_bits - copy some data bits from skb to internal buffer
>   * @desc: sk_buff copy helper
>   * @to: copy destination
>   * @len: number of bytes to copy
>   *
> - * Possibly called several times to iterate over an sk_buff and copy
> - * data out of it.
> + * Possibly called several times to iterate over an sk_buff and copy dat=
a out of
> + * it.
>   */
>  static size_t
>  xdr_skb_read_bits(struct xdr_skb_reader *desc, void *to, size_t len)
>  {
> -	if (len > desc->count)
> -		len =3D desc->count;
> -	if (unlikely(skb_copy_bits(desc->skb, desc->offset, to, len)))
> -		return 0;
> -	desc->count -=3D len;
> -	desc->offset +=3D len;
> -	return len;
> -}
> +	len =3D min(len, desc->count);
> +
> +	if (desc->need_checksum) {
> +		__wsum csum;
> +
> +		csum =3D skb_copy_and_csum_bits(desc->skb, desc->offset, to, len);
> +		desc->csum =3D csum_block_add(desc->csum, csum, desc->offset);
> +	} else {
> +		if (unlikely(skb_copy_bits(desc->skb, desc->offset, to, len)))
> +			return 0;
> +	}
> =20
> -/**
> - * xdr_skb_read_and_csum_bits - copy and checksum from skb to buffer
> - * @desc: sk_buff copy helper
> - * @to: copy destination
> - * @len: number of bytes to copy
> - *
> - * Same as skb_read_bits, but calculate a checksum at the same time.
> - */
> -static size_t xdr_skb_read_and_csum_bits(struct xdr_skb_reader *desc, vo=
id *to, size_t len)
> -{
> -	unsigned int pos;
> -	__wsum csum2;
> -
> -	if (len > desc->count)
> -		len =3D desc->count;
> -	pos =3D desc->offset;
> -	csum2 =3D skb_copy_and_csum_bits(desc->skb, pos, to, len);
> -	desc->csum =3D csum_block_add(desc->csum, csum2, pos);
>  	desc->count -=3D len;
>  	desc->offset +=3D len;
>  	return len;
>  }
> =20
> -/**
> - * xdr_partial_copy_from_skb - copy data out of an skb
> - * @xdr: target XDR buffer
> - * @base: starting offset
> - * @desc: sk_buff copy helper
> - * @copy_actor: virtual method for copying data
> - *
> - */
>  static ssize_t
> -xdr_partial_copy_from_skb(struct xdr_buf *xdr, unsigned int base, struct=
 xdr_skb_reader *desc, xdr_skb_read_actor copy_actor)
> +xdr_partial_copy_from_skb(struct xdr_buf *xdr, struct xdr_skb_reader *de=
sc)
>  {
> -	struct page	**ppage =3D xdr->pages;
> -	unsigned int	len, pglen =3D xdr->page_len;
> -	ssize_t		copied =3D 0;
> -	size_t		ret;
> -
> -	len =3D xdr->head[0].iov_len;
> -	if (base < len) {
> -		len -=3D base;
> -		ret =3D copy_actor(desc, (char *)xdr->head[0].iov_base + base, len);
> -		copied +=3D ret;
> -		if (ret !=3D len || !desc->count)
> -			goto out;
> -		base =3D 0;
> -	} else
> -		base -=3D len;
> -
> -	if (unlikely(pglen =3D=3D 0))
> -		goto copy_tail;
> -	if (unlikely(base >=3D pglen)) {
> -		base -=3D pglen;
> -		goto copy_tail;
> -	}
> -	if (base || xdr->page_base) {
> -		pglen -=3D base;
> -		base +=3D xdr->page_base;
> -		ppage +=3D base >> PAGE_SHIFT;
> -		base &=3D ~PAGE_MASK;
> -	}
> -	do {
> +	struct page **ppage =3D xdr->pages + (xdr->page_base >> PAGE_SHIFT);
> +	unsigned int poff =3D xdr->page_base & ~PAGE_MASK;
> +	unsigned int pglen =3D xdr->page_len;
> +	ssize_t copied =3D 0;
> +	size_t ret;
> +
> +	if (xdr->head[0].iov_len =3D=3D 0)
> +		return 0;
> +
> +	ret =3D xdr_skb_read_bits(desc, xdr->head[0].iov_base,
> +			xdr->head[0].iov_len);
> +	if (ret !=3D xdr->head[0].iov_len || !desc->count)
> +		return ret;
> +	copied +=3D ret;
> +
> +	while (pglen) {
> +		unsigned int len =3D min(PAGE_SIZE - poff, pglen);
>  		char *kaddr;
> =20
>  		/* ACL likes to be lazy in allocating pages - ACLs
> @@ -126,36 +89,29 @@ xdr_partial_copy_from_skb(struct xdr_buf *xdr, unsig=
ned int base, struct xdr_skb
>  			*ppage =3D alloc_page(GFP_NOWAIT | __GFP_NOWARN);
>  			if (unlikely(*ppage =3D=3D NULL)) {
>  				if (copied =3D=3D 0)
> -					copied =3D -ENOMEM;
> -				goto out;
> +					return -ENOMEM;
> +				return copied;
>  			}
>  		}
> =20
> -		len =3D PAGE_SIZE;
>  		kaddr =3D kmap_atomic(*ppage);
> -		if (base) {
> -			len -=3D base;
> -			if (pglen < len)
> -				len =3D pglen;
> -			ret =3D copy_actor(desc, kaddr + base, len);
> -			base =3D 0;
> -		} else {
> -			if (pglen < len)
> -				len =3D pglen;
> -			ret =3D copy_actor(desc, kaddr, len);
> -		}
> +		ret =3D xdr_skb_read_bits(desc, kaddr + poff, len);
>  		flush_dcache_page(*ppage);
>  		kunmap_atomic(kaddr);
> +
>  		copied +=3D ret;
>  		if (ret !=3D len || !desc->count)
> -			goto out;
> +			return copied;
>  		ppage++;
> -	} while ((pglen -=3D len) !=3D 0);
> -copy_tail:
> -	len =3D xdr->tail[0].iov_len;
> -	if (base < len)
> -		copied +=3D copy_actor(desc, (char *)xdr->tail[0].iov_base + base, len=
 - base);
> -out:
> +		pglen -=3D len;
> +		poff =3D 0;
> +	}
> +
> +	if (xdr->tail[0].iov_len) {
> +		copied +=3D xdr_skb_read_bits(desc, xdr->tail[0].iov_base,
> +					xdr->tail[0].iov_len);
> +	}
> +
>  	return copied;
>  }
> =20
> @@ -169,17 +125,22 @@ xdr_partial_copy_from_skb(struct xdr_buf *xdr, unsi=
gned int base, struct xdr_skb
>   */
>  int csum_partial_copy_to_xdr(struct xdr_buf *xdr, struct sk_buff *skb)
>  {
> -	struct xdr_skb_reader	desc;
> -
> -	desc.skb =3D skb;
> -	desc.offset =3D 0;
> -	desc.count =3D skb->len - desc.offset;
> +	struct xdr_skb_reader desc =3D {
> +		.skb		=3D skb,
> +		.count		=3D skb->len - desc.offset,
> +	};
> =20
> -	if (skb_csum_unnecessary(skb))
> -		goto no_checksum;
> +	if (skb_csum_unnecessary(skb)) {
> +		if (xdr_partial_copy_from_skb(xdr, &desc) < 0)
> +			return -1;
> +		if (desc.count)
> +			return -1;
> +		return 0;
> +	}
> =20
> +	desc.need_checksum =3D true;
>  	desc.csum =3D csum_partial(skb->data, desc.offset, skb->csum);
> -	if (xdr_partial_copy_from_skb(xdr, 0, &desc, xdr_skb_read_and_csum_bits=
) < 0)
> +	if (xdr_partial_copy_from_skb(xdr, &desc) < 0)
>  		return -1;
>  	if (desc.offset !=3D skb->len) {
>  		__wsum csum2;
> @@ -194,12 +155,6 @@ int csum_partial_copy_to_xdr(struct xdr_buf *xdr, st=
ruct sk_buff *skb)
>  	    !skb->csum_complete_sw)
>  		netdev_rx_csum_fault(skb->dev, skb);
>  	return 0;
> -no_checksum:
> -	if (xdr_partial_copy_from_skb(xdr, 0, &desc, xdr_skb_read_bits) < 0)
> -		return -1;
> -	if (desc.count)
> -		return -1;
> -	return 0;
>  }
>  EXPORT_SYMBOL_GPL(csum_partial_copy_to_xdr);
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>

