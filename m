Return-Path: <linux-nfs+bounces-13137-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3837EB095DE
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 22:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400E65A1BFA
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 20:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B7E22616C;
	Thu, 17 Jul 2025 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kPHNVA8Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A080A1F4623
	for <linux-nfs@vger.kernel.org>; Thu, 17 Jul 2025 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784954; cv=none; b=CEc3LxT+/Z17F0AJ+Wij/eK9/X2/a1jyePB6WiRShTEBcG81RElHbchrl+vquQ/QnJt2l/p+uOki4aLRNaXwyDygT6hdES9bfBz/9tdnxQaBEbV4TYPaee9oheDCqfjiAT+WLMfLw4lK7C0S4Sc0NcVA5rLLhvr5kvYvpIuC+SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784954; c=relaxed/simple;
	bh=8xHzhnsmrVig04m/9BR79i+zd/rgH6E5Tv7KQ7VUC58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kscXX/CjlGTZ3EaXv+HBS6kiMeLyOojfbgx4OydJ/MoNGS6IRACys6lcK+NplNpi3eadRbFeWf4pns2qG7faqYY/goUCNVQhXyKlz6P0FnDIfpEZa3tAf5m25OX7EUM+8zlND4RWpF2AMWvIekf3Tb0MJAwzffVt/1AGzdjab60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kPHNVA8Q; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72c47631b4cso1059260a34.1
        for <linux-nfs@vger.kernel.org>; Thu, 17 Jul 2025 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752784950; x=1753389750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldlF+I8llOCn2cLMQIQOjBCb32s1ACkmxJthAbMjiMA=;
        b=kPHNVA8Q/9DpEidmdv4hFghUrx2DlaOCsSdW8t44YV7rJuMF0sRTFFdhqArogqsi7L
         +wtAVNv8zHjsb584dAlMshWOOyDHUNXAlD0UEJqWUX839/a6r4M0/GI3bfgcqiDvW6nC
         okskx1VQwUbbI+eqMrFEKtMtq/6q+/CSa5yJD5IVyADGhI0tqCP/9CN/wmiCyCEX82el
         vIb99TMwXG8ERTDdv8m7jPz5aQaA2QVnNikGoYQ38Lo6AeafwiQYRajBQQktM3OLOaYu
         VykKVaLIsO0r7/+11Thm0mvoYS9JMW3uaFl69s2hKF4sHIchd8JxNJbu32VCHyEmQOUW
         lR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752784950; x=1753389750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldlF+I8llOCn2cLMQIQOjBCb32s1ACkmxJthAbMjiMA=;
        b=pW5VKcLbcJSbQ/Nwkhw+tLQwFIZ3sIaYZlYY4fmorLz8gP4qdL1h7J97mlfZZ6WxbI
         mtxefW+xrgOJNDV9LEbEAbWQYWaP+HjAyhhf8yU5I/Bl315fJHR0J8zwF7g5JFlyJds1
         lu0R2EBfZoQGBvzPAWIJ6816Fs+yaSzBadkEIgjV/27s/vi8Gh2pnDSeihw9F8as/B3e
         mXTXUyM2ct1K4qWysdKu8swkwJ0TgCe9M37mmpF3Qw2fprjhHycEyhsNcw3ktYHSer7v
         oKvpwGZcht125mQt3ci6W40hLSfRo3vShXpCCcXZE99cHQhWvHVOLWhMSeqmCZExDwdv
         9Nqg==
X-Forwarded-Encrypted: i=1; AJvYcCXS69e269werpSqaVZbHwweH7ZYxNef8vDVzQPFbhXE0bhf2VhErUxt4PBPcZc4BY+rHbuSSrfkC04=@vger.kernel.org
X-Gm-Message-State: AOJu0YymYV91a+HwrZ5UmB2zPj68iMohzAxNCh1+yDZnoLj9L1LhETEi
	QfhR0+/ZK99FWOCk3XPNbj7WC0OSBNSkqq+qLxxx+KbMegwwWen/jC6337OKdCJ3G+I=
X-Gm-Gg: ASbGnctzq5sfGcN/Pk/rIohjHKACRMZLozC5c+1yLonUb2brCj3NxhQ0nPKcH3gCvsA
	yaiRw2NAb74O8pPw9YvZXukL1JR3VwFnw6b4PkrMfy+1X0Gd86X6delmQKUvjJfC7IuKVu9kzI2
	ihSsQaxW9Z3onaLuyJAelMSGRo/xvTmw01S1QFtlkT+DYaju1dlxHfe5uiDqIfyg0H35460qAy6
	5fbo67TvpZlbPwVC1ZKyF1vds6azPVnjpWgGsyRcTvn0MhPk+yfdr4lPQMRm6XK3/Erkb7gPLZ+
	23m6RA1SCsHDOazyZWsMbEX6Yjk1ShmVQpAWQji/BkN0RK+qb/Rp8UOSBpqidtxpaE6Sg4/tPHs
	FoLH7glmms5Hfe2/zGs888ba17uWv
X-Google-Smtp-Source: AGHT+IFCBhJw9A2YtCVV2dc5ZzvZ/NZVoz0GXNj/2FwobeWK3umYY1q1bgyL7GEUlu9mi9lxJdGgIQ==
X-Received: by 2002:a05:6871:9d02:b0:2c8:5db8:f23a with SMTP id 586e51a60fabf-2ffb23fcf91mr5822397fac.20.1752784950529;
        Thu, 17 Jul 2025 13:42:30 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:2c38:70d4:43e:b901])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3010220aea0sm17912fac.20.2025.07.17.13.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 13:42:29 -0700 (PDT)
Date: Thu, 17 Jul 2025 23:42:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NFSD: Change ret code of xdr_stream_decode_opaque_fixed
Message-ID: <0e4116bf-1cfb-4286-be91-0337892e2031@suswa.mountain>
References: <20250717194838.69200-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717194838.69200-1-sergeybashirov@gmail.com>

On Thu, Jul 17, 2025 at 10:48:30PM +0300, Sergey Bashirov wrote:
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index 67f6632f723b4..dd80163e0140c 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -1863,7 +1863,7 @@ static inline int decode_opaque_fixed(struct xdr_stream *xdr,
>  				      void *buf, size_t len)
>  {
>  	ssize_t ret = xdr_stream_decode_opaque_fixed(xdr, buf, len);
> -	if (unlikely(ret < 0))
> +	if (unlikely(ret))
>  		return -EIO;

We could propagate the error code (-EBADMSG) instead of return -EIO?

regards,
dan carpenter

>  	return 0;
>  }


