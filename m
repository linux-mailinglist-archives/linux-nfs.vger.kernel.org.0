Return-Path: <linux-nfs+bounces-3973-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4380690C396
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 08:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669341C20DB2
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 06:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DC422EE4;
	Tue, 18 Jun 2024 06:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5BnfHPS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE53F9D5;
	Tue, 18 Jun 2024 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718692299; cv=none; b=psuI3tv+Ww7qrryrKeJ9BZMXUNgerAKQG4buQqXkHydqxu5BQWSbQcUTjx3xjo3pwJ3lS2V5Smxh1DEQp6nEnlpVWS90gm7Gro6mgQG+ZN5twpGenA0hwP9qG14eHY18RMoMMq84sVL7T0xYoDznI8xYqvYTB0I8lWyIKcv4oLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718692299; c=relaxed/simple;
	bh=VHS6lB7HkmXjrN6QsJqAM80k16ZONVGNGDEGLOitYG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKzAyV6NpvSP4a6oT7kfIYQNj0s0eFI8OzIfqzld7YfrGPd2O+zNOrljLbqCB88BJCEhJ2X47nJ4tFestLDE93nYDFpVIhQG5xZ5ks6mVXRCVJPpLYi8DN8PebYJmZLz5UOm52vmS3/mla+TXD3CXdJPVCiiEMioC36DYCbaoHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5BnfHPS; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4ecf11df664so1654893e0c.2;
        Mon, 17 Jun 2024 23:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718692296; x=1719297096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fhji/OUuk8lshxY2tb/G24HXAQLb8WmH+egKf13zEH0=;
        b=B5BnfHPSkroe7eYM5+1q6Ush+ZFMCXaBT5NjrU+UHDCJIT7Tz2GsSb+gjVgOo6TEhx
         quIGZaX1JAV9bzJFtF9vYRbij5Nz7A95rxXvzk4Xvm+RAZgUXXewrtU5pxScnsHv2u8T
         T/0W/nfXlwIW0a5T7xoMeNRW5+oEu4BkUMRhi10/B5gXcQIOeIejcMg2UaGm1Q+uLP80
         HGfZ2G0pQ03poaVAlm0XUtuR0wd+tfUlVACMmCpBck5BPzflsCf4DqTx7q2TDAi5sCY6
         oNWfn4Tu5g1fa6qfauKRg5Sp98GlW0/o3Mfdnda9ndtiK1S62Ah3zI+IBtULjNjQgBHO
         7VoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718692296; x=1719297096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fhji/OUuk8lshxY2tb/G24HXAQLb8WmH+egKf13zEH0=;
        b=tnF3Foc+8tUB61wcuOyXb2kKMtCsW2626D1o1Fd6/AKLYdzSaUF7bJHK4RytjHLxGw
         KCdI7DXRX+vg6c10FX38+gAvu7g4YDYlpxIiDsi15dBzqJKlELyxet6QTjCtj9+uwUKV
         S0PviVbLNKVyx9f89BOvsbwndzP4aTdkNC7aoCD8uvYV2iYb/kExLpCGiD/A0Prk9pzV
         oAs9Wseu0EGIUHyH40ulQkabJxDIfrtOtbg+bF/aB0CAfi8FKHQGz/tL1bzSRSwnMRkO
         AQqTPUlpYKlnbzuwhC4QSReXsjYDGTFmcx+TJJR7K85+2XzH/QOJdg6mNJ9x9lMo6+D/
         dDrg==
X-Forwarded-Encrypted: i=1; AJvYcCWUKrm9t9sUoJC5/dP+qo4goF82onKETGA4Q5am944V0pTsotrZfdArh07FpGuCxz9cxO9piYVqXmKYK2gkMZINCedfDHm7yZGTjku6Dcb+vostVHRlRSJcb9ATma+mXYuqKE2zBQ==
X-Gm-Message-State: AOJu0YzseVUedJXw6kWjiUaOdFFrPZke2ajnWeK5P5Qq5qsVUWAfStcP
	dtl/nKGeJB+LWJDVhjHKikObMdISeaEC/lAC8jXWQG92936jYK3tNgiB8xrQX2YiwNMBjgHseFP
	rlZPjmq6SnT/0ci1ubGTRfnq2Z7Pqh9ai
X-Google-Smtp-Source: AGHT+IHKiftvN1Jq/c5pWNkpCMblBsWG+z83c8TOftFKVld+yZI7GeYG1J7h/i9NaAg892W3YlLKdIRnlakXUTAaZW0=
X-Received: by 2002:a05:6122:1693:b0:4ec:f4a2:69fc with SMTP id
 71dfb90a1353d-4ee3f06bb4dmr12038754e0c.7.1718692295979; Mon, 17 Jun 2024
 23:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614100329.1203579-1-hch@lst.de> <20240614100329.1203579-2-hch@lst.de>
 <20240614112148.cd1961e84b736060c54bdf26@linux-foundation.org>
 <CAGsJ_4wnWzoScqO9_NddHcDPbe_GbAiRFVm4w_H+QDmH=e=Rsw@mail.gmail.com>
 <20240616085436.GA28058@lst.de> <CAGsJ_4ytrnXJbfVi=PpTw34iBDqEoAm3b16oZr2VQpVWLmh5zA@mail.gmail.com>
 <20240617053201.GA16852@lst.de> <CAGsJ_4xQgY4kn46NO2=OWh2oDUj2F1-oYCRnKG4KCPJFfBT=Ng@mail.gmail.com>
 <20240618055253.GA27945@lst.de> <CAGsJ_4xMzU2N=c-vtLv+vJwSJFcADjdaUONc=8yDTm52QabOXw@mail.gmail.com>
 <20240618061340.GA28200@lst.de>
In-Reply-To: <20240618061340.GA28200@lst.de>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 18 Jun 2024 18:31:24 +1200
Message-ID: <CAGsJ_4xmgSog82Ygx61iAaOaS71MKdyPgw6gMdk_NGECVcNaYw@mail.gmail.com>
Subject: Re: [PATCH] nfs: fix nfs_swap_rw for large-folio swap
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 6:13=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Tue, Jun 18, 2024 at 06:05:33PM +1200, Barry Song wrote:
> > Yes, that was exactly what I missed. I then figured it out, reproduced
> > the issue,
> > and discovered that the root cause was unrelated to large folios. It
> > was actually
> > due to a batched bio plugging optimization from 2022. You can find the =
new patch
> > here:
> >
> > https://lore.kernel.org/linux-mm/20240617220135.43563-1-21cnbao@gmail.c=
om/
>
> I don't really see any point in keeping the VM_BUG_ON.  The underlying
> direct I/O code doesn't really care about the size at all.

I am perfectly fine with dropping the VM_BUG/WARN. I was keeping it
for debugging
purposes while we add mTHP swapout support for the swapfile. Large folios m=
ight
be in bio vec, this can help verify things are still normal after
having large folios there.

But I agree that this is not important for the NFS code itself. I can
add this warning
locally for debugging when needed.

