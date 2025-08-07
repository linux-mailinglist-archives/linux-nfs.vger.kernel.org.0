Return-Path: <linux-nfs+bounces-13469-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B331B1CFA2
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 02:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162693AB891
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 00:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3181FC8;
	Thu,  7 Aug 2025 00:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYD/6c5s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A91E36D;
	Thu,  7 Aug 2025 00:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754525009; cv=none; b=BMPzdRWsagIqOT+cg39uNPuO1ndMkCGvLq8DXhX4P3VR50j1YOsLtOowpVNlS2mHDclTa1k+mYL4CGoBTrWassT7bZ86cqktLf60C2XLs8gv7mmQPUcO0cwaRyAbVOOlUE3CqYcFyq9Tg6bg2/ImH4Je1OzCljPUCHfxQ/dNAos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754525009; c=relaxed/simple;
	bh=tDY9PLdL7KzBuSVPjaxM+AXpLClNtgGmFkXweb/RZUk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CxC6KDz0lHEmAqdT72Q3aJHpNB+15vqwVi2XB7RvI0QrGJS5R7F+i3vNU4NDH0suiFScwdzodHYVW/+12fXEpguabfY2gMSflmfND6th/1EuqmOR0mOOlyXF9KBh+lYNZJ/x9eh+HJRngwGXCgCSCe4R/Tj0KJwKHheHh/fSpX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYD/6c5s; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso585875a91.3;
        Wed, 06 Aug 2025 17:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754525008; x=1755129808; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s2nIm9pR2VFff1R0Gt37lG+o36/Td6KpLeuI6lVGeTs=;
        b=SYD/6c5sb6OM7vfFH11hvFid9lWPAu6jEhebuU3vM38H2UWD0AJETvnsk8/naWwyJB
         Ctm+i5aQwMVabwK02HFOdliwDLa5YvH819JVJtILe7pFrdxpRipeasPsASCHdAjbz8gg
         T8mkb2iEOF+meUqYS5qyZi2zgwgXu5waKrjhJfEnIXjtC05B32oqZkzxTChcrt8sKAJ9
         sDCq1epAJCRA+iKsBGrLY6S+78UvnEw6fBQXbS4cd6TLIukfVDggM8cZtoIDgLJg6vIS
         tNjI3vNVdXzTxFmDkBa1h1Rxl4yHtMufTzBEemsSeMbx/4gqtrZer28UQQfX0KDz8ZmP
         3Xnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754525008; x=1755129808;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s2nIm9pR2VFff1R0Gt37lG+o36/Td6KpLeuI6lVGeTs=;
        b=lzcd0oiDfMGtB51d04dO8S/4qnuEvgxtoBuAfXZiQNfkZg77got7heumDAy9n5gwE1
         RvWYYFaiXfua14V1xxMOYyJhi22lj/3DgaGV38wQ1uwpBtg4comgv8G4cwCbSL9ooUme
         nsVNe1pflEi4YwHFOpVdr3Jwk0YRGbH4kQI5K/8eV5WPGbZ8mrVjewS14fwW74cS1q2b
         stgHYltZMua1tKSs4VVkVAb/luxDg5Jiwj7qqhyj+kiccNKqju+/9lSog7ZWTfNGEVm+
         hTD+LXYSc3c8iA/8EZ4jvNcBIekz30jUXk2Em9eFnR2THWeSKAXt8eYRAijrD3SP56f8
         DUBw==
X-Forwarded-Encrypted: i=1; AJvYcCUbjf9uHqqVNkpEg0L1YHkoi6NMhRrPfTujJWZSgEkeTgyhklDUJ4U8SQpkZihMq3HnhwKiW9WlPJ+h@vger.kernel.org, AJvYcCVjPEbz1eu9IkLtxuQ2lILw0ABB1EuKjwadrGt+wF50gUhWzjYsxfWxm7PbJOHFnBUxjrOf4ufJ@vger.kernel.org, AJvYcCXGYHXBzjVS1lWrn5JxLAY/WpeaerglgNbiLpI8ktEJfSUozrbB2ASWIeQR61GZD4PEh+SzSitjQtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBsA2TKC/1SCpk1jlcqQh8Lkz0dZfnuV1vY07+WDMTBKk8++TS
	nj6VtnS50SLH1xo0Yt+IO1OubA1M8AXdPr2hTuYj2K+j324+pYldGLgH
X-Gm-Gg: ASbGncuB0FDDmxC5KikvW/edJiX0NOu64lA30hUQQ+4XzpBgWs8LTuv5WM9hq3rTKW5
	2tIrWlp2EIPwFIAlMLLLot84qvQSixcMPpaJCVwyyttbzezNBMO2F5pC9DVro0G7R9wiqRrR3/1
	MMXzgTpeGmcYhPKYTav+ZZMyoaohZYPWaM5S8FSjUA9XJ2c656JGi8ainDnDVZixja3By3PUb8K
	E4qwbl/ZntpYglYNo35Umv0IitlStZuteQvFz/x2cbQ+cKNh1ZoRxTuVxL56riIj32zVBkEeAtV
	5epHUK+RzE9Ou24/2ArERkbaGD6N4dC0nNV+PHS39jdw4TwrLffTpOYvQLmMn+1Z+bHnv33Df/L
	oRPWBrFZFLUFIS/NPs+sMN3s8uKM/bYVCAZIj
X-Google-Smtp-Source: AGHT+IHndIqzglD98iobqIfSre5A1Dz03NPUiXq1oQdA0qqIpiN9bEtefJ4HDNfGWlO3SOLnCSjtyw==
X-Received: by 2002:a17:90b:1c85:b0:31f:6f8c:6c92 with SMTP id 98e67ed59e1d1-32166c2b18emr6044750a91.11.1754525007434;
        Wed, 06 Aug 2025 17:03:27 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32102a559bdsm9223807a91.1.2025.08.06.17.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 17:03:26 -0700 (PDT)
Message-ID: <ad14410ef291af926e7185d5d95cb0c932135ee3.camel@gmail.com>
Subject: Re: [RFC 1/4] net/handshake: get negotiated tls record size limit
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Hannes Reinecke <hare@suse.de>, alistair.francis@wdc.com, 
	dlemoal@kernel.org, chuck.lever@oracle.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	donald.hunter@gmail.com, corbet@lwn.net, kbusch@kernel.org,
 axboe@kernel.dk, 	hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 borisp@nvidia.com, 	john.fastabend@gmail.com, jlayton@kernel.org,
 neil@brown.name, okorniev@redhat.com, 	Dai.Ngo@oracle.com, tom@talpey.com,
 trondmy@kernel.org, anna@kernel.org, 	kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Date: Thu, 07 Aug 2025 10:03:14 +1000
In-Reply-To: <2a9c71e0-f29d-46b6-823d-a957b10b4858@suse.de>
References: <20250729024150.222513-2-wilfred.opensource@gmail.com>
	 <20250729024150.222513-4-wilfred.opensource@gmail.com>
	 <2a9c71e0-f29d-46b6-823d-a957b10b4858@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-29 at 10:12 +0200, Hannes Reinecke wrote:
>=20
[snip]...
> > diff --git a/Documentation/networking/tls-handshake.rst
> > b/Documentation/networking/tls-handshake.rst
> > index 6f5ea1646a47..cd984a137779 100644
> > --- a/Documentation/networking/tls-handshake.rst
> > +++ b/Documentation/networking/tls-handshake.rst
> > @@ -169,7 +169,8 @@ The synopsis of this function is:
> > =C2=A0 .. code-block:: c
> > =C2=A0=20
> > =C2=A0=C2=A0=C2=A0 typedef void	(*tls_done_func_t)(void *data, int stat=
us,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key_serial_t p=
eerid);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key_serial_t p=
eerid,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t tls_rec=
ord_size_limit);
> > =C2=A0=20
> > =C2=A0 The consumer provides a cookie in the @ta_data field of the
> > =C2=A0 tls_handshake_args structure that is returned in the @data
> > parameter of
>=20
> Why is this exposed to the TLS handshake consumer?
> The TLS record size is surely required for handling and processing
> TLS
> streams in net/tls, but the consumer of that (eg NVMe-TCP, NFS)
> are blissfully unaware that there _are_ such things like TLS records.
> And they really should keep it that way.
>=20
> So I'd really _not_ expose that to any ULP and keep it internal to
> the TLS layer.
>=20
Hey Hannes,

Sorry for the delay in response, and thanks for the feedback! Yeah I
agree it was a bad approach from me. It definitely makes more sense to
keep things in the TLS layer. I will try to address this in V2.

Regards,
Wilfred

