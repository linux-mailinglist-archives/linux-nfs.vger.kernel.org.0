Return-Path: <linux-nfs+bounces-13470-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08975B1CFAB
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 02:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64801887D97
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 00:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE18D2E36F7;
	Thu,  7 Aug 2025 00:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIEWpRVb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563E7186A;
	Thu,  7 Aug 2025 00:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754525083; cv=none; b=USnkvPtwergDNrJUEavnueop9hGDwOOjeSTVNIs3gPx6c3xUzXhQRmMfc56dLlPPcZsRPkmGBiRVJWxpoDinKmmjG2/hvmIwfIQqArIocNZwY0wYu+EF9KmRbKwSSUBpKZQy4SrfMFmRZWMglNCucckvZMwKxeBKbvpHNOeLet8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754525083; c=relaxed/simple;
	bh=rWSJADiT5YFucAiGDF6MjM9ePHCHYf61hCJW+WuXhyE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UCo3sWeiXD1LOxEtjN5p3D+UdBgr04Z7tnrbci566JHPGsKria8pIZDbAv5NqRW3HffYptp08RUuMhM0zOmxkxkUTtFOLo7RFkpuARFud9kxx0sVA8X4yOokHvUyFrrrLS0sVeSRNF1PzJzpqlCHT6HapeTMct8lEhMEixRuZ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIEWpRVb; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31effad130bso405399a91.3;
        Wed, 06 Aug 2025 17:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754525082; x=1755129882; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K/A9C8/bVgIC1L6UfQS08Wm98G+tK+gmaXMJoj3JOjM=;
        b=EIEWpRVbbaxxnxRBRth5IHHKanlt5Iinbls+cR5wyQagPF3nFu6BVy4SNh7jDFx9Vm
         UpibyT2ByvduSu7uKqZNuvxSSaBMsuLJO2p/18oZ2123U18SYgI2V/yI9E5blWQhdps5
         96NMzHmL01Q+pQNpOfQdOigaisXzh9yP9fnm7khqYwM8PzF4WnAEs6CHsEFpmllppluo
         aNDdjur3iAkbsQRo0atq5A75gHTEMRtMkIZI9d82SXrkrwHP3D8yVXuSdy5AnDFAAbos
         sBo/6o1KSxUtUNCyRuCCYlkdqkwAg/rRBMlpO0wguoy0OmXtsEo/1a7z1atczibim2vU
         vNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754525082; x=1755129882;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K/A9C8/bVgIC1L6UfQS08Wm98G+tK+gmaXMJoj3JOjM=;
        b=q6cLqWe9r3A/k8OjP3HJy7PoGQHflssoaMLCtegtrdKzyNsfTLgmMOXDz1en2N+rgY
         T6tzX0lwrF760GH7IuGfl0kFNhQ51UVWkocA7w4xX6yY1ou7Tm6zmro7bJu/YSnO/Xn2
         lychLpWDu/ZomYNur4DXoJYLy4ib5nV1xv2I56Jdu1YOXQc3Ycofv8RmBaPpaZTBlBYK
         ny/YRHGngLwtQubw6fBB+Wb9Bih79VFG+rUMpSei+sCoqVmOsLpnVFKR5bVcLp8eTsHB
         j0vf7QvOE3bPptCXHbPkpr27UrnRhxIJH5gzN8UiGjcdPvUBBQTN3WKHQL4xzNF/ngEo
         v89w==
X-Forwarded-Encrypted: i=1; AJvYcCUd2WXHsgeKwNv2kpqry7NGETermX2ICdNEFyhssjouRolUW0LCMl8oWfFoUpFeRTMFt3e4Zq1CxZU=@vger.kernel.org, AJvYcCVU2UbZpjU8CMS0np3OS+y8sdmBCyMSYKCMP1bRK+3Xtp6/QWWJS9Ge0STtd1/skFhe5y7McagB@vger.kernel.org, AJvYcCWDIZ7wjfaJosj4cYC2E0rHZOPzAX0cwQ5556O3MTdVAU94i0VGGb2Ldh97tjMuPt325CwQ8Ys4RAzJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyOmByj0OqGGGJMs377WPAfoLwiWmfHpXditxuczZ7qQXBsvpsB
	FedGLAmEuvDOFc59RIKJZdBLcH4FSkkZKyTjAxkEynCqeUsrpk2PfnUt
X-Gm-Gg: ASbGncsSY58YN4Fw1Ed6xQmX3jrLF/GZfC6PZjML89H5StCOAa0CozBD919YIrcRhHn
	s156629k7qFEObFWDxhXSJzeAIC7bYJbo0HTZy7rngQBZoDGSdb4zKvUBhIVfkzGX/e+kGwLyKJ
	S5J77tvd1xFVK7CbU7NDRtZ8nvl+vvz9wcQDnO+/K5ermbC9MnZqmKAppf2yL2rMUOmWwjOii1X
	90a0ootNIc3IguygBZj+833HfisMZ+w864urXn8M2i4JTKrA5bjUK0hPXZGw5kBv07fw/yNCIFN
	sUB8v3NcR/EnYvDWmrlkkmrEuA5LxBEkhU4p1bCPNUcizatLedZz6E5cNdIFQSVQLxm9+hWGyS4
	lBlaehiIS6+Bq54xCVk7ADgnlPDnq3DD0cjfHFcF16Y3nhoc=
X-Google-Smtp-Source: AGHT+IE8yf3mW+Zix4aWhzoVPQkRdDv26V46vDKBnE4qstNKDwz/t8jIdzc+kq2t00duIY4+nurXzw==
X-Received: by 2002:a17:90b:2d87:b0:313:f6fa:5bb5 with SMTP id 98e67ed59e1d1-3216752304fmr6652697a91.18.1754525081598;
        Wed, 06 Aug 2025 17:04:41 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32102a5be52sm10378051a91.1.2025.08.06.17.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 17:04:41 -0700 (PDT)
Message-ID: <aa5680f2974cb18e4a7d40266a85727ef43377c4.camel@gmail.com>
Subject: Re: [RFC 2/4] net/tls/tls_sw: use the record size limit specified
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>, alistair.francis@wdc.com, 
	chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, 	pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, 	kbusch@kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	borisp@nvidia.com, john.fastabend@gmail.com, jlayton@kernel.org,
 neil@brown.name, 	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 trondmy@kernel.org, 	anna@kernel.org, kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Date: Thu, 07 Aug 2025 10:04:30 +1000
In-Reply-To: <8ce2c9ce-9636-4888-8d63-2169441addcb@kernel.org>
References: <20250729024150.222513-2-wilfred.opensource@gmail.com>
	 <20250729024150.222513-5-wilfred.opensource@gmail.com>
	 <8ce2c9ce-9636-4888-8d63-2169441addcb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-29 at 17:13 +0900, Damien Le Moal wrote:
> On 7/29/25 11:41, Wilfred Mallawa wrote:
> > From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> >=20
> > Currently, for tls_sw, the kernel uses the default 16K
> > TLS_MAX_PAYLOAD_SIZE for records. However, if an endpoint has
> > specified
> > a record size much lower than that, it is currently not respected.
>=20
> Remove "much". Lower is lower and we have to respect it, even if it
> is 1B.
>=20
> > This patch adds support to using the record size limit specified by
> > an
> > endpoint if it has been set.
>=20
> s/to using/for using
>=20
> >=20
> > Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>=20
> > @@ -1045,6 +1046,13 @@ static int tls_sw_sendmsg_locked(struct sock
> > *sk, struct msghdr *msg,
> > =C2=A0		}
> > =C2=A0	}
> > =C2=A0
> > +	if (tls_ctx->tls_record_size_limit > 0) {
> > +		tls_record_size_limit =3D min(tls_ctx-
> > >tls_record_size_limit,
> > +					=C2=A0=C2=A0=C2=A0 TLS_MAX_PAYLOAD_SIZE);
> > +	} else {
> > +		tls_record_size_limit =3D TLS_MAX_PAYLOAD_SIZE;
> > +	}
>=20
> You can simplify this with:
>=20
> 	tls_record_size_limit =3D
> 		min_not_zero(tls_ctx->tls_record_size_limit,
> 			=C2=A0=C2=A0=C2=A0=C2=A0 TLS_MAX_PAYLOAD_SIZE);
>=20
Hey Damien,

Thanks for the feedback! Will amend for V2.

Regards,
Wilfred
>=20
>=20

