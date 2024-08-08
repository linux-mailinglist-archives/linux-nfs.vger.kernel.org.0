Return-Path: <linux-nfs+bounces-5269-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D562494C6BD
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Aug 2024 00:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129F01C21025
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Aug 2024 22:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF809158853;
	Thu,  8 Aug 2024 22:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="IgF8xnN/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6BD146588
	for <linux-nfs@vger.kernel.org>; Thu,  8 Aug 2024 22:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723154867; cv=none; b=f/kPdGOCX3HD/oCJ5TNzrvxjGqyfopFSKXRywL0VcMkifLjGEtJC8j4Ta5GJYCcU+HQBb9dPBLUeCaCdsbIN8XIZX83yRD2UVTh+Fnfp7r0Udg4jYeD1CDgc9ZzLbUSmwJG9jfVY3uBs9d43RH0foZyUU58x3X2xk/cYVysPK34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723154867; c=relaxed/simple;
	bh=B1j3dbmZ5LP+sxXbVEd5VLhxaV7E6U39fCWZ3/zbBCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpQMH+Fu12883aaPmTZtK4rwukP27Ojw0lCTstj/vv94oxz3JcivKBCqeW+x8zUT9M+seFoZeiKmfuomzUYr05SimtdSbqY3o3nGf9DfINftHIhB9qqQRTBNud5SGyuGUumsJtKwsqMQvnzgQivhgeBuDwykaPqpRsh4Nt8+cMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=IgF8xnN/; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ef247e8479so1505041fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 08 Aug 2024 15:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1723154864; x=1723759664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvQTh196UM+0rE4rq2Usc4Huo2JVda49g2xxBS51dRo=;
        b=IgF8xnN/UwSUhB84XSw+MxMNhBSSRSvCyBe20/RyfE3i9d0Rm6FyqiocmA38q6I+iR
         wUC4Ys08NOkhf5ttr7O91bnn9kR78DgTPxth7Mr9hst1gHCy6a4z7GsNZ1tV/QzJ9Ze2
         dvAEB2TRG6/nmN1Y5DET6+1X+ZXMddRZUv327LIFlIXn6ut3q6ks1pgvm7EyY4/wxe6G
         rxcdQvgLOgWpb5ZoOfQCrehs+9rSeEq1CCgkGqp7M7660ApJeVRu8J+5luc7C8e6x5tf
         3dAPFPtp6duDJlWDz5pZuRlt8fdU84EpwRr8BAfRkT/ORYKaJ3MHduznRAF3hFpYvsII
         UwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723154864; x=1723759664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvQTh196UM+0rE4rq2Usc4Huo2JVda49g2xxBS51dRo=;
        b=gUVIflOwF+rHxBYkABhqaAYbjObUF2dCXZVKly6ezgeDewUMfjYWqHzSQLm5RcZ/Ra
         6u0kyKbxV64kTl8m0fNEqFsS2UXncxWCJ/0D1aJhclguh4mKR7DvawvA2VynHF93Dpw6
         vXUwWCE84GC21fW9qL0+F6PVYYOvYeGWG9s0N2T+WRQXrAgj8dpCv3oIlTxK9Sa8fYro
         GyUkGexKwK2M3XCIJkUyH4XfYBana4LJcD7PVLqNRzcKqsKeU+pq+tuQAmgkyQUbQERp
         C0Oyxablhut0sfegrcPYoLRAtnGGZF3VNFUn+zRa5MYUNch0mA46CsUjaGBLH0W1fKar
         yK2w==
X-Gm-Message-State: AOJu0YyOexRBWm6DZPo3+bMptIK4K1e/EYJr3mokL50QFBqQRoyocg8t
	ZPtysmzYr7ONPp1WRkD2DSlc5A2VNwDVwQWEarYJ2k8+XLJbJRstH2t1sKwMWiYSnNl9KQFEDhO
	xomVNWBpfZpqZ2aJ7hTKyfCtL6YHtUw==
X-Google-Smtp-Source: AGHT+IEtkdWxxWDUm1/WO7fd2o0ZcCAG/lOW/Qku1cyEuPCAbrQe1xtwohXFhCyVVSRzpu5ITkq1BzP4gObixxW2lGA=
X-Received: by 2002:a2e:bc0a:0:b0:2ef:2405:ff63 with SMTP id
 38308e7fff4ca-2f1a3419c56mr4432561fa.5.1723154863326; Thu, 08 Aug 2024
 15:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c4f1d8bf-745b-4a98-9d38-2da4c355d691@gmail.com>
 <66be75a6-2d3f-4f5b-96da-327556170c4a@gmail.com> <e39131ce-1816-49e1-8319-820472892a38@gmail.com>
In-Reply-To: <e39131ce-1816-49e1-8319-820472892a38@gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 8 Aug 2024 18:07:31 -0400
Message-ID: <CAN-5tyEx=j2OiRZVd+18x-2Y36SGGsJxAVApudT+mWjiNGDyxA@mail.gmail.com>
Subject: Re: NFS client to pNFS DS
To: marc eshel <eshel.marc@gmail.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Trond Myklebust <trondmy@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 5:51=E2=80=AFPM marc eshel <eshel.marc@gmail.com> wr=
ote:
>
> Hi Trond,
>
> Will the Linux NFS client try to us krb5i regardless of the MDS
> configuration?
>
> Is there any option to avoid it?

I was under the impression the linux client has no way of choosing a
different auth_gss security flavor for the DS than the MDS. Meaning
that if mount command has say sec=3Dkrb5i then both MDS and DS
connections have to do krb5i and if say the DS isn't configured for
Kerberos, then IO would fallback to MDS. I no longer have a pnfs
server to verify whether or not what I say is true but that is what my
memory tells me is the case.


>
> Thanks, Marc.
>
> ul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node
> stripe count  1
> Jul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node
> ds_num 1
> Jul 30 11:10:58 svl-marcrh-node-1 kernel: RPC:       Couldn't create
> auth handle (flavor 390004)
>
>

