Return-Path: <linux-nfs+bounces-13005-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB06B02E3F
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Jul 2025 02:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B5ED7A8A09
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Jul 2025 00:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEF64690;
	Sun, 13 Jul 2025 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="cKbu6MLN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5942023B0;
	Sun, 13 Jul 2025 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752366379; cv=none; b=UwbPrmK+ZyimOA+4hWEZ2JpPL+vlxTVvQAKymoGvXYZm7no2UD9Exaxv6QUOcLfMUAE+h6f6HLpYZCfLx89ayNaohyjHKBS0XYEYURdB/j7ZgGgGiCFbXO8A3pEs8HVo4YcfBo7A5YuIANRqViisQANVtaUvBKRUy5viHYLWXZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752366379; c=relaxed/simple;
	bh=KgLcBDnPSrGB2FQQRvwBhEckb+COWWAmkMyFdb2cBSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EI2ZIhmMMu/czcnk9twb6A/HKFcc4BC8rTyKc55GYSBB2av3sVgZpHftXk9Vt2PuODU+jG4SAz7MlOCctUxmv6T1bmu7ViWUaxXQ/A12Bx/XpUuRHAhpX/lll8JNZbbTE7f8QQwg0+X1g2+3gkMEqF9OnWzcCwOgTrArW4ciJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=cKbu6MLN; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=IjyKPtojQBu38Ua/tyqZOTARKUzdhDUEG4FUV9R8tVg=; b=cKbu6MLN0hhT1zqi
	19ZeC985eYQAm5i0m1KU4/Zd0zm3IYSXN78EInORob4g0xjoA5RBOjkpO9DsHHQYiO665axPizdb5
	9cfMvxXKbTfGQGHxx+q0b83mkUjqS/j6H/dSnShooZjfSB6jtlOiVxUU+vQln/tXXJCVh9NqgGGyc
	u3kFduZWsJz4UdnfIEHEbje9Xvxj/osHbHns7gvtAH5j5eEDvP/Q3leiP8RtY2L6zWjfH4O0kSLv9
	pF+AcaLtELYNS/1cDNpVdrCItG6cPxfIYuJZ2xbi2Zh6MDYAD8W0JCFxxqBVO34akTAznkGpyPesw
	VIfrco/2fr2jzsTYqQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1uakXd-00Fkis-2N;
	Sun, 13 Jul 2025 00:26:05 +0000
Date: Sun, 13 Jul 2025 00:26:05 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: chuck.lever@oracle.com, anna@kernel.org, jlayton@kernel.org,
	neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com,
	tom@talpey.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Remove unused xdr functions
Message-ID: <aHL9HY5V95hV_Qau@gallifrey>
References: <20250712233006.403226-1-linux@treblig.org>
 <1ae3c2fa194bb7708ad5a98b1fb7156b9efcb8e7.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ae3c2fa194bb7708ad5a98b1fb7156b9efcb8e7.camel@kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 00:24:52 up 76 days,  8:38,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Trond Myklebust (trondmy@kernel.org) wrote:
> On Sun, 2025-07-13 at 00:30 +0100, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > Remove a bunch of unused xdr_*decode* functions:
> >   The last use of xdr_decode_netobj() was removed in 2021 by:
> > commit 7cf96b6d0104 ("lockd: Update the NLMv4 SHARE arguments decoder
> > to
> > use struct xdr_stream")
> >   The last use of xdr_decode_string_inplace() was removed in 2021 by:
> > commit 3049e974a7c7 ("lockd: Update the NLMv4 FREE_ALL arguments
> > decoder
> > to use struct xdr_stream")
> >   The last use of xdr_stream_decode_opaque() was removed in 2024 by:
> > commit fed8a17c61ff ("xdrgen: typedefs should use the built-in string
> > and
> > opaque functions")
> > 
> >   The functions xdr_stream_decode_string() and
> > xdr_stream_decode_opaque_dup() were both added in 2018 by the
> > commit 0e779aa70308 ("SUNRPC: Add helpers for decoding opaque and
> > string
> > types")
> > but never used.
> > 
> > Remove them.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >  include/linux/sunrpc/xdr.h |   9 ---
> >  net/sunrpc/xdr.c           | 110 -----------------------------------
> > --
> >  2 files changed, 119 deletions(-)
> > 
> > diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> > index a2ab813a9800..e370886632b0 100644
> > --- a/include/linux/sunrpc/xdr.h
> > +++ b/include/linux/sunrpc/xdr.h
> > @@ -128,10 +128,7 @@ xdr_buf_init(struct xdr_buf *buf, void *start,
> > size_t len)
> >  __be32 *xdr_encode_opaque_fixed(__be32 *p, const void *ptr, unsigned
> > int len);
> >  __be32 *xdr_encode_opaque(__be32 *p, const void *ptr, unsigned int
> > len);
> >  __be32 *xdr_encode_string(__be32 *p, const char *s);
> > -__be32 *xdr_decode_string_inplace(__be32 *p, char **sp, unsigned int
> > *lenp,
> > -			unsigned int maxlen);
> >  __be32 *xdr_encode_netobj(__be32 *p, const struct xdr_netobj *);
> > -__be32 *xdr_decode_netobj(__be32 *p, struct xdr_netobj *);
> >  
> >  void	xdr_inline_pages(struct xdr_buf *, unsigned int,
> >  			 struct page **, unsigned int, unsigned
> > int);
> > @@ -341,12 +338,6 @@ xdr_stream_remaining(const struct xdr_stream
> > *xdr)
> >  	return xdr->nwords << 2;
> >  }
> >  
> > -ssize_t xdr_stream_decode_opaque(struct xdr_stream *xdr, void *ptr,
> > -		size_t size);
> > -ssize_t xdr_stream_decode_opaque_dup(struct xdr_stream *xdr, void
> > **ptr,
> > -		size_t maxlen, gfp_t gfp_flags);
> > -ssize_t xdr_stream_decode_string(struct xdr_stream *xdr, char *str,
> > -		size_t size);
> >  ssize_t xdr_stream_decode_string_dup(struct xdr_stream *xdr, char
> > **str,
> >  		size_t maxlen, gfp_t gfp_flags);
> >  ssize_t xdr_stream_decode_opaque_auth(struct xdr_stream *xdr, u32
> > *flavor,
> > diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> > index 2ea00e354ba6..a0aae1144212 100644
> > --- a/net/sunrpc/xdr.c
> > +++ b/net/sunrpc/xdr.c
> > @@ -37,19 +37,6 @@ xdr_encode_netobj(__be32 *p, const struct
> > xdr_netobj *obj)
> >  }
> >  EXPORT_SYMBOL_GPL(xdr_encode_netobj);
> >  
> > -__be32 *
> > -xdr_decode_netobj(__be32 *p, struct xdr_netobj *obj)
> > -{
> > -	unsigned int	len;
> > -
> > -	if ((len = be32_to_cpu(*p++)) > XDR_MAX_NETOBJ)
> > -		return NULL;
> > -	obj->len  = len;
> > -	obj->data = (u8 *) p;
> > -	return p + XDR_QUADLEN(len);
> > -}
> > -EXPORT_SYMBOL_GPL(xdr_decode_netobj);
> > -
> >  /**
> >   * xdr_encode_opaque_fixed - Encode fixed length opaque data
> >   * @p: pointer to current position in XDR buffer.
> > @@ -102,21 +89,6 @@ xdr_encode_string(__be32 *p, const char *string)
> >  }
> >  EXPORT_SYMBOL_GPL(xdr_encode_string);
> >  
> > -__be32 *
> > -xdr_decode_string_inplace(__be32 *p, char **sp,
> > -			  unsigned int *lenp, unsigned int maxlen)
> > -{
> > -	u32 len;
> > -
> > -	len = be32_to_cpu(*p++);
> > -	if (len > maxlen)
> > -		return NULL;
> > -	*lenp = len;
> > -	*sp = (char *) p;
> > -	return p + XDR_QUADLEN(len);
> > -}
> > -EXPORT_SYMBOL_GPL(xdr_decode_string_inplace);
> > -
> >  /**
> >   * xdr_terminate_string - '\0'-terminate a string residing in an
> > xdr_buf
> >   * @buf: XDR buffer where string resides
> > @@ -2247,88 +2219,6 @@ int xdr_process_buf(const struct xdr_buf *buf,
> > unsigned int offset,
> >  }
> >  EXPORT_SYMBOL_GPL(xdr_process_buf);
> >  
> > -/**
> > - * xdr_stream_decode_opaque - Decode variable length opaque
> > - * @xdr: pointer to xdr_stream
> > - * @ptr: location to store opaque data
> > - * @size: size of storage buffer @ptr
> > - *
> > - * Return values:
> > - *   On success, returns size of object stored in *@ptr
> > - *   %-EBADMSG on XDR buffer overflow
> > - *   %-EMSGSIZE on overflow of storage buffer @ptr
> > - */
> > -ssize_t xdr_stream_decode_opaque(struct xdr_stream *xdr, void *ptr,
> > size_t size)
> > -{
> > -	ssize_t ret;
> > -	void *p;
> > -
> > -	ret = xdr_stream_decode_opaque_inline(xdr, &p, size);
> > -	if (ret <= 0)
> > -		return ret;
> > -	memcpy(ptr, p, ret);
> > -	return ret;
> > -}
> > -EXPORT_SYMBOL_GPL(xdr_stream_decode_opaque);
> > -
> > -/**
> > - * xdr_stream_decode_opaque_dup - Decode and duplicate variable
> > length opaque
> > - * @xdr: pointer to xdr_stream
> > - * @ptr: location to store pointer to opaque data
> > - * @maxlen: maximum acceptable object size
> > - * @gfp_flags: GFP mask to use
> > - *
> > - * Return values:
> > - *   On success, returns size of object stored in *@ptr
> > - *   %-EBADMSG on XDR buffer overflow
> > - *   %-EMSGSIZE if the size of the object would exceed @maxlen
> > - *   %-ENOMEM on memory allocation failure
> > - */
> > -ssize_t xdr_stream_decode_opaque_dup(struct xdr_stream *xdr, void
> > **ptr,
> > -		size_t maxlen, gfp_t gfp_flags)
> > -{
> > -	ssize_t ret;
> > -	void *p;
> > -
> > -	ret = xdr_stream_decode_opaque_inline(xdr, &p, maxlen);
> > -	if (ret > 0) {
> > -		*ptr = kmemdup(p, ret, gfp_flags);
> > -		if (*ptr != NULL)
> > -			return ret;
> > -		ret = -ENOMEM;
> > -	}
> > -	*ptr = NULL;
> > -	return ret;
> > -}
> > -EXPORT_SYMBOL_GPL(xdr_stream_decode_opaque_dup);
> > -
> > -/**
> > - * xdr_stream_decode_string - Decode variable length string
> > - * @xdr: pointer to xdr_stream
> > - * @str: location to store string
> > - * @size: size of storage buffer @str
> > - *
> > - * Return values:
> > - *   On success, returns length of NUL-terminated string stored in
> > *@str
> > - *   %-EBADMSG on XDR buffer overflow
> > - *   %-EMSGSIZE on overflow of storage buffer @str
> > - */
> > -ssize_t xdr_stream_decode_string(struct xdr_stream *xdr, char *str,
> > size_t size)
> > -{
> > -	ssize_t ret;
> > -	void *p;
> > -
> > -	ret = xdr_stream_decode_opaque_inline(xdr, &p, size);
> > -	if (ret > 0) {
> > -		memcpy(str, p, ret);
> > -		str[ret] = '\0';
> > -		return strlen(str);
> > -	}
> > -	*str = '\0';
> > -	return ret;
> > -}
> > -EXPORT_SYMBOL_GPL(xdr_stream_decode_string);
> > -
> >  /**
> >   * xdr_stream_decode_string_dup - Decode and duplicate variable
> > length string
> >   * @xdr: pointer to xdr_stream
> 
> I can pick these up.

Thanks for the quick response!

Any chance you could also look at this old one:
  https://lore.kernel.org/all/20250218215250.263709-1-linux@treblig.org/

Thanks,

Dave

> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

