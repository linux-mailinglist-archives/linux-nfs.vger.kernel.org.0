Return-Path: <linux-nfs+bounces-6538-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 496A997B9FB
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Sep 2024 11:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B472818EB
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Sep 2024 09:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7102F1304BA;
	Wed, 18 Sep 2024 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mvvndkNL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E2F78C7E
	for <linux-nfs@vger.kernel.org>; Wed, 18 Sep 2024 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726650514; cv=none; b=IX/U/aR77kkLNk6dmx8sIzaobnxi10ZezbIZP/zhcaZMaDts2gKif9scGSkcDtLOymxI7+3F6d5G61+82VeFpYhSizIjueRMy3T/jzEdyVAPp761WGUDrBzxu//bOPn2HThninA67TJ4RP0Z0w1uq6fZd8nmuKPaAWEc2QQ91so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726650514; c=relaxed/simple;
	bh=35UT0mzkT2At7YD8S7rKqhzW++xhgclOc7Xjtmnl/GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SohwOiLLvqbW18bbkDqWDT2enL7ms8kXMgjljAHHARrkawgL0e3Ld5jcC/D8XlQZkrzDr1JfcGwL7ocu7Qw8OBO7l6m+AHitiiZ3u/pftsXKyrxceWTB5BfOJ2PyiVEtoR17S380dQm1Z6gGk2bsJ/r1JXMOUO+bjmuutAslhRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mvvndkNL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso916856366b.1
        for <linux-nfs@vger.kernel.org>; Wed, 18 Sep 2024 02:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726650511; x=1727255311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CyhU8MfENXOt5yEmDqHbEDVzzB1Q81FM9wZ/DLasjBw=;
        b=mvvndkNLsfS+NTpb/6gGKf8CHazodVBQf7fqxLZXXcd0x5csQWmBtwEoqFPgnEX2y5
         lJPikStc4Kenu2LtA6L2iG7IzEHTZhwaUEjde3w5SFCO8x5aPCU7C4b6q4CYkI3BZiEz
         IQ867fPXn1ka6Xon2vLql1UZc7lYana5wudj3Pmve57kuo3/gy4a1dyCXD7TAf5o2GvE
         QGlntQDD8pa17usSZNOMe+uWJIEUcJrgQP1Dx7Pv6O6Dtka1ZvV3uYV1s6cnAMZ91l/u
         ZAu2SB0DHSGdu+ANrURLjZAPK3nI6wMtjNIMUnZme1PvMO71SZyzt748Kc3UzVXE62yE
         DZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726650511; x=1727255311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyhU8MfENXOt5yEmDqHbEDVzzB1Q81FM9wZ/DLasjBw=;
        b=OJrolVjRDpnzfySnMcBF4PrUhIJjpOWXSkp60Fo/b7rO38Ab3/KClnSt4IUuJOX/vk
         7URK8bDRg/LVHC/exWXb+nB2Ln0RGddGAXs9tkObMgS8/2M6j+YdGLn0dYn9i9yz7Ir4
         WY5cWlqKhon2zWEy3p+16WeDH5DAqHhcYRRvs+XzhguQmoya6eW+97NfOe20LPsteint
         U4uRk/lICybVSR+hykt8lzYROtj81kjmsYuQeFoWXkU5E8uA47ACQXZHFnDVxpOG/LKX
         XuiLLmvjegl9kdjbhfGJVcWkLR9Dm2SA6udyAZbJV/jfZfIj8J1fNPuFWiWrRy/BjEgY
         4GvQ==
X-Gm-Message-State: AOJu0YxVl4h6Wfj5Du/yxlHq1RvAIqBHP+BTe4vRJewQghDWAV34Kl/p
	U9WCO1WXNV0KZZ+rTBw0wVzycEm4XFp/h7jYEi/+k+m1dqX6yQ3Ib2w+K+TzZE7pQ4EzvJEQPf0
	lZ8g=
X-Google-Smtp-Source: AGHT+IHNiNhTKyDx5qG4i5RNOIoG4Cd+KLrpHtjN/KO+SDDxslPuFI+CtExr/RDZBQtnEqTAWnz2Uw==
X-Received: by 2002:a17:907:7f20:b0:a8d:2a46:606f with SMTP id a640c23a62f3a-a90294ef246mr2170856066b.38.1726650510426;
        Wed, 18 Sep 2024 02:08:30 -0700 (PDT)
Received: from localhost ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061096a08sm559239166b.2.2024.09.18.02.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 02:08:29 -0700 (PDT)
Date: Wed, 18 Sep 2024 12:08:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [bug report] SUNRPC: Convert unwrap_integ_data() to use
 xdr_stream
Message-ID: <cbfa4637-ccf1-40c0-ae96-e1d582820a4d@suswa.mountain>
References: <9084882e-0fa6-4426-bc4d-fb20e86eeead@stanley.mountain>
 <ZuhWAX8IrPEHtU8o@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuhWAX8IrPEHtU8o@tissot.1015granger.net>

On Mon, Sep 16, 2024 at 12:00:01PM -0400, Chuck Lever wrote:
> On Mon, Sep 16, 2024 at 06:14:31PM +0300, Dan Carpenter wrote:
> > Hello Chuck Lever,
> > 
> > Commit b68e4c5c3227 ("SUNRPC: Convert unwrap_integ_data() to use
> > xdr_stream") from Jan 2, 2023 (linux-next), leads to the following
> > Smatch static checker warning:
> > 
> > 	net/sunrpc/auth_gss/svcauth_gss.c:895 svcauth_gss_unwrap_integ()
> > 	warn: potential user controlled sizeof overflow 'offset + 4'
> > 
> > net/sunrpc/auth_gss/svcauth_gss.c
> >     859 static noinline_for_stack int
> >     860 svcauth_gss_unwrap_integ(struct svc_rqst *rqstp, u32 seq, struct gss_ctx *ctx)
> >     861 {
> >     862         struct gss_svc_data *gsd = rqstp->rq_auth_data;
> >     863         struct xdr_stream *xdr = &rqstp->rq_arg_stream;
> >     864         u32 len, offset, seq_num, maj_stat;
> >     865         struct xdr_buf *buf = xdr->buf;
> >     866         struct xdr_buf databody_integ;
> >     867         struct xdr_netobj checksum;
> >     868 
> >     869         /* Did we already verify the signature on the original pass through? */
> >     870         if (rqstp->rq_deferred)
> >     871                 return 0;
> >     872 
> >     873         if (xdr_stream_decode_u32(xdr, &len) < 0)
> >                                                ^^^^
> >     874                 goto unwrap_failed;
> >     875         if (len & 3)
> > 
> > There used a if (len > buf->len) here but it was deleted.
> 
> True, there is no /explicit/ bounds check, but AFAICT,
> xdr_buf_subsegment() will return -1 if the value of @len is larger
> than the remaining space in @buf.
> 

Ah yes.  I see that now.  Thanks.

regards,
dan carpenter


