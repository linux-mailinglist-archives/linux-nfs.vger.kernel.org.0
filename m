Return-Path: <linux-nfs+bounces-10025-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67194A2F5B0
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 18:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C91D3A4B4D
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 17:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4BA231A37;
	Mon, 10 Feb 2025 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NgslL5rP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A682566EB
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209518; cv=none; b=B95klNXFbgRdYAM2rKl/dmw+DK+HmwAqBYoenrkLHEhdKajgx1n7oSgf9xhBV0YTWrG8ziEnr8WIry726wuKA361904UGpmaa6d48FT3gfyrjzn6+GbiLXddWZR6v1x5uPA9KpFLfl1s1raIFgVLyADUgIIDW/v8nYYbLzKCcaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209518; c=relaxed/simple;
	bh=fdNx1DUDaVtYdgrnYwf8qDr5+EznUmUeXdfIPP1MsRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNW5BmA8kPLhoqs7Bw4jQtPfupc7mz0HUKhe1VQMCZLiwUMWv3K0JbUrxBqGM2LtGLJEWdaHKy6rrxE/VmMjF1Hsug5H0/HapptLsrH9hQeoTvsmoB66ouniWEIWu63Os279FKGTCvmYT7ZLx5ypwrcqQgA+vNqr4BnaawuQD94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NgslL5rP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7cc0c1a37so161003666b.0
        for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 09:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1739209515; x=1739814315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdNx1DUDaVtYdgrnYwf8qDr5+EznUmUeXdfIPP1MsRA=;
        b=NgslL5rPJnNz+XbPkiPKl0NqG+mDs9PfAUXwrFlPzJc4GjuPubjq+Vu+wnyFU9g2M/
         WuH0QcIYi1oVRmBN62LFO2J3yOL/k2sIzWrjsm4n1hdtyvPxJKSHYY0dqFIhArL9ycrp
         dSS2baxxgwLDURj2bmQnZinDeJJMppx0+3vnTqkj3yc3GMFFQLyXajNZ4sRBBhjFdqdM
         vgjCk1YAZqvteUz/sOqhYPR8sDZi2VF/mz3D807WqvHWJ5vv5b/8esfz6R0IRgAVhxuv
         +MMMthkhCMss18aSTT/AXGWEZWz2okNabraRSo8eInDFans1GyGaZnGdEyXWZ7jyNK/g
         lg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209515; x=1739814315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdNx1DUDaVtYdgrnYwf8qDr5+EznUmUeXdfIPP1MsRA=;
        b=SLib6sSevld0u5fnEExtKFkCBlPSNHMqsB0lyCDyZh4b9WpUgHqcdrLO89puVK0rSf
         2lG7dFzpSKRJwgiUZ+c8WLtp4RJz+tCf+thybrZxKnKA8QdZFWPtb7J+twELF+F3Ws1u
         oMkuTek9Fc0StAeK+njJzOaBfrsdbTHc00e6XbsktMWj+tl04dx9IaL/tpRlCv6Ysf78
         LfTPUDXFmckB1KUNDLomLd8lydZX8TDqQOTgTg8ineHP5piVeBBCospCju0ygpwitik/
         S7fo/EyCMXX3yWnkoAZqgMxkdEAzoJq1DkAPqC6X3jDUL7VopQbBf4JrFtCmMKaxG7Kr
         MReQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzax8kGgpKKlqElnpo33DDgdeX/N/QfQc/LapuvdAfx5dtkS6gTgPWMMCgVUatSXvJ4JKm5jLArHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9uF2yCbrZbKatGlVTO37YXBeTrYLGW5sRNn3etjX3LnTVEo57
	D9b9RwqajEpbJratygdiNLfP15vwx1R5WSxE5DQwCfAsKnRh9hWrn4AQPz7PEjRGhsMrdlPmEek
	oBcmsteAqzqpFkKlYPTIgxUf6Jn705OqVpJqh5SEAztWDlelKUR0=
X-Gm-Gg: ASbGncvRlc9Ark9Bmv4rev7qvO7VQQNuVCwoZXpwgbUwZAiP1QdylWEm1iN6WhkKQlL
	s69u9JJLSQTEXpv1/QB8VGOVKaoSjp2eU2GzoWVEbUnqF0PR+lI8MxF226w4+RsXBQwCNzOyi1z
	biKZbs2TOCzuKD0OzMDtCbJH3CRQ==
X-Google-Smtp-Source: AGHT+IGXUbcrbs9jCJWCCDSj0H7A7skcP2xO/8QiwRx0Lv2OP1hLehSE5+2+D1t/ncKajx8/C0dIGmPhKHOCuJcDXr8=
X-Received: by 2002:a17:907:94d5:b0:ab7:6c50:5f19 with SMTP id
 a640c23a62f3a-ab789aed850mr1642511966b.31.1739209514948; Mon, 10 Feb 2025
 09:45:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
 <3052002.1739196466@warthog.procyon.org.uk> <CAKPOu+_tjkiU7mMC0mCwhH23BQ03o=QTgTH60TQ6=aC4fQr7LA@mail.gmail.com>
In-Reply-To: <CAKPOu+_tjkiU7mMC0mCwhH23BQ03o=QTgTH60TQ6=aC4fQr7LA@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 10 Feb 2025 18:45:04 +0100
X-Gm-Features: AWEUYZmS9NnwMn_wzMK0r5f-lnnWPNLNfcts3sg_BGm3yC1zJ8jSxnW_V6mGylE
Message-ID: <CAKPOu+_Cbkq7ROF=azCnWNcgDS4V=SyKC-_ixVo9siyE_SOeow@mail.gmail.com>
Subject: Re: "netfs: Can't donate prior to front"
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 6:41=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
> Additionally, here you have a file with a dump of *subreq and *req (of
> R=3D8). I have added additional fields "start0" and "len0" which contain
> the values initially set on these.

btw. this happens because there is only one subrequest (R=3D8[7]), but
the start offset is being rounded down (folio_order=3D2), thus
"fpos<start":

 (gdb) p/x fpos
 $5 =3D 0x1c0000
 (gdb) p/x fend
 $6 =3D 0x200000
 (gdb) p/x start
 $7 =3D 0x1c6000

