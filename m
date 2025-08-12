Return-Path: <linux-nfs+bounces-13583-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE00B230F0
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 19:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2671892117
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 17:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972002FDC55;
	Tue, 12 Aug 2025 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="uDK9qv6e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B702FDC52
	for <linux-nfs@vger.kernel.org>; Tue, 12 Aug 2025 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021480; cv=none; b=Ys8BIYfqjQcGa/b2iWK9tqTxOzAs00vTHB/XOu4oEjLvWD8OMQO52MhlBcUuemlKdbHWm5E1rUHDDMqHnjNHTcQ4CuPc4lq/1zCvnfEeW2VGc8pxsfxs2XUowMwcmb6+cg3/fPXsoBmDygJh9tSKnRSqYlZvk2yPUubn6Qd7TL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021480; c=relaxed/simple;
	bh=hPrGuxrOLQ9ipBeDFWhoJK1vM+KGW1+i9S6rdpPe8xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcaDwwnfFir7WaKeMftzjXJMGhYcaWwBCHL/KO9iQJ3iziRR0kF00x5BDBbFHx1FfdKWlGw6JCaxFZIBpnhji4ny7o0lD1MVRb5MWskRyVsbeG5Sultox513qHT9m4/Bbl2JUmqgsYbJHxfzE1On/sNRcDoqAKJlQ6lszs2pSZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=uDK9qv6e; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76be8e4b59aso4973220b3a.1
        for <linux-nfs@vger.kernel.org>; Tue, 12 Aug 2025 10:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1755021478; x=1755626278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qc+A4jnBK4EPdKh66angrNfmE3qm0EXV6FaKJ1CugA4=;
        b=uDK9qv6eTp2PMd3L4a8hShsQcjDB5jf48FIhmNfWH2VcfmiteLxvDDlGaLdwujL5D9
         lHNURWLvSFtiaBpw/FL2Js9X7ifwtQQeSvS+DyF63YdqEH7EcBZmOIGjh1WXRsqfubqJ
         g/L1LzJ0Ub5shHfn8f1IlHGjlE+ja+bc++unIogu9YN9F+4Ig9vrIOX9pN+ofxd+f3Gw
         QIHvTWG25ZxIDouRkxvn+6YYlmhBVXT2XrQthUuT8JUhKS/oDbtCM3e0lxa2gKEoKq/7
         SOAwT9+yY57Jqg0t3NMnCMJJn60oqoppI4DjRVwiLT62c8lhBA1A6+2Ebh3n8jvZDRXE
         zm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021478; x=1755626278;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qc+A4jnBK4EPdKh66angrNfmE3qm0EXV6FaKJ1CugA4=;
        b=EPmzcHZuE0x2H4MxLk1refzXbcJ2/OBcrkm+ioEw5OQVj8xJiCXGazXAE6h0RYDSLu
         oMNbW/3Bi7sx9w8GCveTIMOYTudYIQpj7U7cyfxAYSjpVrrw5Hbl0PZRvh6uQ2OaShTM
         LIhxMZRiQCVbiC3/GGjCc1tA9EULLG6Gqb7BL1PzIeoiFDq9spPLK7mB+mvGaz1aA5qE
         /LemPzw9xf96NqqIT8AHl+grVJAnzeyRvcbQRgp/M4UaCNol1X0eUw5bNTXXYp1Z7jeA
         jchIp9X0zCZdp8Pm+0pjGfzgzr1ePp+PyBiR+1eGX2DAVFDdxcNEPu1y/TaoZCGCOegD
         f+cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvHfcBDv9mWMKmwvPGMKYBB1Aq9PWOXA0eK7CNds8MfbjhO7505Xm1Y38gD/YxPs6/++Gfw4nbN88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjJwPXI2+1RgcHDEPvM8Y6YWiuOD5ZuWCvulY2lLbohgQ+xvYd
	ek4+DtytDSfJLZ6z2CG/LABm7LJ7yBZIaMmoufmEPVFQsG2dgoRGsLUunIow1erG9II=
X-Gm-Gg: ASbGncsg6CnwqWa44a3cBViSn4hIp20UTwXkEzEu/cdO2/LpQWFMwHyglUt+2oKNYip
	IDHv5fdwiu26olaQLXe6D2qGOAklS9MXTti1rSI49x5qfXfSs+hDmdFKt7LRTRNgQ0bTdRbdokX
	/vFn0Mw251sYJyewTDfKN+g3i+0qxZ3BO5DIyxxqAHB3PEGKtsGkct0Z3mJ3UhJW1C5Hdo+rgGc
	XtTfDRsUpZjShLwi/568iDtetadUO47byXY0XMih0BOQGuaFqmMpoVUEMF6NKQE+0NJwAK6NhPe
	qzQCEIxppnJEQAz9CuXeSKOMXor/rCQ1cE8BMFCMjRV75sodM3Zv0fSfL2vMFb5hKOneFzlhSIv
	SUpvCte/lByDLXuWBbcm+i2wzjmItKxNoX+C7QpFQVzulZmBVGqbXG6ec8zKRP9PygJMcn5b+mO
	IqBCWqMVY=
X-Google-Smtp-Source: AGHT+IHxi2HOW8bSGkAzQGQAd8ZqXnSd+5ht/WWbBZm7UBPBn7pRtc+d0H/ulq4tQ+TrYx/lPWqfGA==
X-Received: by 2002:a05:6a00:b55:b0:748:fe3a:49f2 with SMTP id d2e1a72fcca58-76e20f900d8mr126425b3a.21.1755021478408;
        Tue, 12 Aug 2025 10:57:58 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfcf523sm29950265b3a.90.2025.08.12.10.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:57:58 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:57:55 -0700
From: Joe Damato <joe@dama.to>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com,
	jlayton@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, neil@brown.name,
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
	horms@kernel.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sunrpc: fix "occurence"->"occurrence"
Message-ID: <aJuAo3lfY9lRB-Oo@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Xichao Zhao <zhao.xichao@vivo.com>, trondmy@kernel.org,
	anna@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, horms@kernel.org,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20250812113359.178412-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812113359.178412-1-zhao.xichao@vivo.com>

On Tue, Aug 12, 2025 at 07:33:59PM +0800, Xichao Zhao wrote:
> Trivial fix to spelling mistake in comment text.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  net/sunrpc/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
> index 09434e1143c5..8b01b7ae2690 100644
> --- a/net/sunrpc/sysfs.c
> +++ b/net/sunrpc/sysfs.c
> @@ -389,7 +389,7 @@ static ssize_t rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
>  	saddr = (struct sockaddr *)&xprt->addr;
>  	port = rpc_get_port(saddr);
>  
> -	/* buf_len is the len until the first occurence of either
> +	/* buf_len is the len until the first occurrence of either
>  	 * '\n' or '\0'
>  	 */
>  	buf_len = strcspn(buf, "\n");

In the future probably a good idea to add net-next to the subject line so it
is clear which tree you are targeting (e.g. [PATCH net-next]).

Reviewed-by: Joe Damato <joe@dama.to>

