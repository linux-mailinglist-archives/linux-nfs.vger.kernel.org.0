Return-Path: <linux-nfs+bounces-11671-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA646AB4E53
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 10:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B9E1892AC0
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 08:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43FC20B207;
	Tue, 13 May 2025 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6bgFy6s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CEA1DACA1;
	Tue, 13 May 2025 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747125771; cv=none; b=NmDErLvJCNe7ZhiQAnVgkZf68CAVmu69L9w6GduMmEB+Tv6TY/wql1A4dk+O/MM6UK9u9QFgyrenr94WFHXkzg0GGeCMJQCw3ECJQVn2OpW5S2u4Pw6IxYbMjPWgsL0d8Q48vXupVPpxH+GxPdS2IEHixcrBuwNcdb3IbYFVkDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747125771; c=relaxed/simple;
	bh=OzZ66wt4HAm6wey4RjSjmAObLxD250cALf3K1QBNgws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3w4MZfA0UUPWTs8O0b2XtE8bypr5tJAx6f72KZ397wKSVUZ8Dkc/atbCgoc1bw6ZtWU8LhRogfrW9drV1+HYqbfUM8Q6dRnbd+VEj31+OsU0u46nTQeKiOwCqP5fbtRx7ihr2S1TkwQfKyD68nrg8xf5H2aqy7rlXEWz9sfPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6bgFy6s; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2c2c754af3cso4932710fac.3;
        Tue, 13 May 2025 01:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747125769; x=1747730569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnHMxDDmp1Gl8n7186sTU9lQMsLD+PQrzrZRHfNvawY=;
        b=j6bgFy6sxgQCbbemH/PtgJobHFOrLTpK0evCrYq9uBr9mgaoY4bNysTl3Pb5CDAXX4
         HKjZq65YAcRxAkirSn4uYlufxKRYIrmTLwUXLnEjI3FE5ZIbUaRIN7RQYJnhCNTcyNqd
         OGMRh/iSILCfqydhPUqKEfSCzfxNt+LxGmPxYfCWNn2GX2yAE/c2k6TZsIv8oedqINJL
         sg2tvFv8bmRs52tAMvGO3iWqiKncyKNf2lU8KtQTBjqM4Yv3UtFU9XzVgsO6WkBMPAPZ
         /ZoD9kC4Jo1e7vRP7GkOyoTl1ewbSeTIJdtgbMJ9rAR4iPrkfId2497HPzZNhyn4YcFC
         bKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747125769; x=1747730569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnHMxDDmp1Gl8n7186sTU9lQMsLD+PQrzrZRHfNvawY=;
        b=PowugYW13B7DXpiq/IzkxugQD+3jU9nDjsXJVeKJxTu3B9JNYGSefdYQsY3yUiNarO
         S7xLX/f56q/jyi647LdSVjOnDL86d48uys+xdL1Tvf5X4IARUtuL6XOTvXtjh5CNMwlD
         lKBqVhw9ouaYsKJoXe0modQRUAe+PAu3Lps6QIDgrKBKxHeiTYwqR8Q2Yx+nXEotmv5s
         7XMg+g0SkYFWqSIk//DYjQvJpDrTBdLWbqbdFvNbfp6imG4SivrjuHFezjOsSPbCoyHz
         1b+0IKk7SZ9SeGzd2iVo8rWILbidFOKjTGEFNQ46GVvPmQrG/qxgNy89HZCXlXqhnLwA
         vNKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1uWsComXfMyRiSDPaNmvu4rUFAYNhDshnVAOMXHBclEytAbXxAKTBeBfrl0dXBaXRHyBt15nE8Is=@vger.kernel.org, AJvYcCWmK7/D5SzO1L21SmgPnqP1+RE6KrOU/hoSddUI5mfrIt0Nb2aiKHDXe1BeT0zN4vkPa8+88N2ZreVulA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxatgootC+5c37sh+bGWi/2SXHUxU+57GJpkz9KZzWngYOIciHe
	khQGIuZQhby9x9QEF0Y7OCeelxDOn77JVPJCd0QY1ITqEL+pp+6gdW3gVze5ZEVCfuUziTC2woo
	C5XokYOqKtQqeR95EO6IKv8Hu+Xw=
X-Gm-Gg: ASbGnctMc4NUJm/xPUMTdX+5g1gT3aml/Tc0lQSQ8vFi8UlP7kgtpVDL1dUYxLflHLy
	JlcEg0r4V/gmDV/Hp+s22hrwfJL+240RPiscBHqPvQ1l73p6XyOK0orDmXj3WA3Fwd6Xr0E1HYV
	yrqeXxFb1BXsv5hd+djynq0s5ZrMrQJTEx
X-Google-Smtp-Source: AGHT+IFSrhH1/39CYmuZRXcHiUrZZnTtHqJM0Y/edlTj2LGLVUxkj8Bt1EWzkM/qVbH64cUA1i/LGPOmXnXgN4YNK1M=
X-Received: by 2002:a05:6870:71d4:b0:29e:3c90:148b with SMTP id
 586e51a60fabf-2dba44dc473mr9452641fac.26.1747125769171; Tue, 13 May 2025
 01:42:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509190354.5393-1-cel@kernel.org> <20250509190354.5393-20-cel@kernel.org>
 <CA+1jF5pLds8XYfsBqVsJOmr4b+YaXPdHzUNWmtx8aQLec6UKZQ@mail.gmail.com> <8179372a-1d5a-42b7-b84d-72a8dcefbdd1@kernel.org>
In-Reply-To: <8179372a-1d5a-42b7-b84d-72a8dcefbdd1@kernel.org>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Tue, 13 May 2025 10:42:12 +0200
X-Gm-Features: AX0GCFsgZbSXnkLGxZSdkBJGiIdIukIaOFK3j0bfiJ4pvAKPsJQNrMYVFjTRrDQ
Message-ID: <CA+1jF5rpxD8NSMxzURWEF+RsgwhVXsr5pmDs_zDYe5nfJk0V2g@mail.gmail.com>
Subject: Re: [PATCH v5 19/19] SUNRPC: Bump the maximum payload size for the server
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 8:09=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> On 5/12/25 12:44 PM, Aur=C3=A9lien Couderc wrote:
> > Could this patch series - minus the change to the default of 1MB - be
> > promoted to Linux 6.6 LongTermSupport, please?
>
> It has to be merged upstream first.
>
> But, new features are generally not backported to stable. At this time,
> this feature is intended only for future kernels.

1. I could argue that this patch series - minus the change to the
default of 1MB - is a "necessary cleanup", removing half broken buffer
size limits
2. The patch series makes  /proc/fs/nfsd/max_block_size usable

IMO this qualifies the patch series for stable@

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

