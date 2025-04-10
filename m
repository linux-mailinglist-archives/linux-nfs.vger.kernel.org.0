Return-Path: <linux-nfs+bounces-11087-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBCEA84A4E
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 18:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1687D9A07CF
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 16:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF741DFE0A;
	Thu, 10 Apr 2025 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyDePdUq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DC21C700D
	for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744303216; cv=none; b=Slpgj/WMw2HaAdQLu33M7AVyah3YQHeJpma2L2ZBWKnwblkXFjhRZkJqM4Odbrd+rC2EDeevJ93TeOvkCwCaSXKnkXt3JuiF4r0if4vuMCg8giY13yKMm/sv6efewj5pIO+La3IV3ByfJIp6iAiHHf0PJvwJqImz98mrAqenaXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744303216; c=relaxed/simple;
	bh=TqhHIcMHDXopmGXGfEreyc/jr5JVPqoSHz5T/ZLx4U0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqYfpc3VDdFm54pusUG4f3hmCL282VgeR483Ux1SWzlmX+EusWmmcPgYJyO7IqD/uFlDBkNzsrROWTlfX4SRWoTWBpEiCXXsNuWSIJZB+ry/nHBjBgh2JQmfSTxVIhzizE4LHMERocWj4eBRIjdw2FCxlzhq/p4zJ5aND39Qu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyDePdUq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaecf50578eso182416466b.2
        for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 09:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744303212; x=1744908012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqhHIcMHDXopmGXGfEreyc/jr5JVPqoSHz5T/ZLx4U0=;
        b=VyDePdUqt7o/fgbNgnpFSWmOs9umhbARh7gJVshBKyNTCQzYJM7AyBFJ4ZHzTgOEN9
         Tolj5iXjMuB4MXq2XsconMaVaXLb0P/BduChHlja8eDu0AgGDUbHQ+UcRNQfBfMFZaRG
         L8kzb4E4wYrhnN47L35pPhafq8X0/B0VHxil2HFyv1dq8qlYzNHNKofhsVtG4QVdqNcp
         7eFboHq0IYTGfRQrqloxaXeHCVTmzW8miFElTozhtYERJbVK2yfIREzO90DrY6Gea/ec
         9ONhaTjAqI9AfU5P2qo21XB/4WjWgvUkA58giTp0pGeFZCqwrRMDAd8yMA2ewUX+Vmau
         wxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744303212; x=1744908012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqhHIcMHDXopmGXGfEreyc/jr5JVPqoSHz5T/ZLx4U0=;
        b=EHGG5+OUNtviAbXgK4kzms7FRIUtGgeM+y9f9AZ6GCKJIe4NguBdBcrFtu4SwVcvdi
         AMG1/jrVyteOOA/U89m+lF8aIiUOi3KNm2ceBKtPV7Uz0tYpBV6IUzYnD45Wf+wOwzHi
         bF9qFekwwWrI0GXDLzMica361VKlYzNqfl3FvxfxbJju/ct2P8Jp+4sswabnKySrBJ1z
         CVHVDsBFkrCCUaNmoEznLO0niKVtIojo7lPBmMg60tNNCjmvsjPnKFVG/rGsQcXaUDDn
         ue/3c//XxQ5gxtTTimJrw3jcrlrd7fgrlEeow6LAiEzPhQWnkYehn9KMClYY8EeUDveI
         9xvg==
X-Forwarded-Encrypted: i=1; AJvYcCX8Xp5sCr7MqfhCeyKFqoUjPSA3HZpGohu9FuudW8Qof/Uxlc8no7IfoIiKojCYyjuluLP31RXCeZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNUxSoSrtxPo+YEqwm3wDYz9Bf1oPx98Mp7EpT2kKWc8KZdaOn
	Qog7pNLYxGVyOHlBOyiETCi9xHAwmszi4i/JjS/YRD4r19VVuE1+uIzS3cMDcbjZExhLN2/QkhR
	tuPlk/y/up5dyeLnHZsFpO1bKnwPwuA==
X-Gm-Gg: ASbGnctkQ2waegQqxdZ7mOJKUUg6wf/djnUHrjuM7klyvq4Y9UvHcoZDsJJMsEIG3oG
	+bsejezjCHRlmtcbTvFPoo5YdBBX5h2hXZ2GTsHImZ+0ohvpDFHvGE7FLTrSd/bh3wGkfi0puru
	tYAyd3NjEyBoxQ0XtzHhBGng==
X-Google-Smtp-Source: AGHT+IFP6yq/vzY7I4fvc4+UIvmPbN2K4Z6WtiAs5cm6EtrHw17tV90l0qM/f+vFv3TLEUuLwtDRu/yv2d/BWtBPDUU=
X-Received: by 2002:a17:907:6ea1:b0:ac6:f5a8:b7a1 with SMTP id
 a640c23a62f3a-acabd202949mr312224366b.31.1744303212180; Thu, 10 Apr 2025
 09:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410141012.22187-1-cel@kernel.org>
In-Reply-To: <20250410141012.22187-1-cel@kernel.org>
From: Sebastian Feld <sebastian.n.feld@gmail.com>
Date: Thu, 10 Apr 2025 18:39:35 +0200
X-Gm-Features: ATxdqUELHniV27PNWd7lg2zOlw1dyi1ujqecqA_XWr0S-fRz6acHfbvX32-zHpk
Message-ID: <CAHnbEG+fNNEveZh3oTsp+8MSuGVZ7P35XBZN+2yMJxbHRt3VHQ@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Update Neil Brown's email address
To: cel@kernel.org
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 4:15=E2=80=AFPM <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Neil is planning retirement, and has asked me to replace his Suse
> email address with his personal email address. Both addresses
> currently route to the same mailbox.

No no no no. Neil is NOT going to retire. He is needed here. So please
reject the patch, and let him happily work at SuSE until he is 150
years old.

Sebi
--=20
Sebastian Feld - IT security consultant

