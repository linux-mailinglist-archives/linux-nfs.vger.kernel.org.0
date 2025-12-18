Return-Path: <linux-nfs+bounces-17178-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5B1CCAB98
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 08:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47BBF3009FD1
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 07:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4081D6195;
	Thu, 18 Dec 2025 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcFcsc88"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3F6296BCC
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766044077; cv=none; b=J2PEpPvYFPEU0tvlovh0sMBL9r2W6L/Oee85ODBLRu+ucxgalRKOrSqxK3VeYcxb0SWVYeLeP+7L4zn7P//xQJIFKFV13ibl8Lj77BVfQ0w5yeHTkRIY003JfzhO1nKvJNs4hbvNsa22nqhMaQZROBzFjUdShpZ98AJWBXj8u1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766044077; c=relaxed/simple;
	bh=G4p6Y0IQKSSXCV4Sbt7Ic9Nm9A3X6gHFKx/WgvAJaDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=cWagCIz9IhVlEoyRbdx1cGEpVAAzK0loTxYXi1xgLtIK0KtVyj5zDC7kyhJErSlIdn5AuSh2RfHRkZXV91Uk4fIzk+ue58zcCE0UeTD6NCvIyDKEUoHi6NtiO4OoHRhsj+JY0VBJR08aR9siZHQ2wgvL8eKCcUJtHNdg5DuHgUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcFcsc88; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so465139a12.1
        for <linux-nfs@vger.kernel.org>; Wed, 17 Dec 2025 23:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766044073; x=1766648873; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4p6Y0IQKSSXCV4Sbt7Ic9Nm9A3X6gHFKx/WgvAJaDs=;
        b=DcFcsc88yoJLX1ObI9qMf3rJQKOjlcpHfITt2gULQeAw9TxIVAhx2TyC3echdRlawt
         jsQQGZ8IlJwXH+hLEPnNxsN2slbjw25UFjL9SZojT9Xoa1eLHEGFKFsToXntWnWqfhLX
         +YaofYXazTe4ifJLP42jICtZ7UvlMLf5Vz0LrmqwR9FrgojzQfCCPs4t54bnV4ziqePW
         nV06HVm+xFj3HSPka5HTiR5GJBMgIhs2Qoprr/bIeKeAsTbj/1ym1UXxzzhqYYXM68Ml
         85p1FES3g1B4VPlg/5K6FgxhnU6P7I4DjiGDtkUZz31hF6RTURC87m6QBcyQ7398bYAk
         1zgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766044073; x=1766648873;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G4p6Y0IQKSSXCV4Sbt7Ic9Nm9A3X6gHFKx/WgvAJaDs=;
        b=SncURhLc674s/1lKP486xgc3jZyZ/ynrZBRASGA3GtBfQkJVgHtIXJJmlyv38nS8qh
         9J4q1zIzHUQgIMeINQ346IXw6Dy/QwCG1Z7e1yGzLXhwxU/8JX3T3+0C2EMcpQMQdHyK
         xn467lJFb5+hdzgBJ7KxiE+Wm1ykFzC9BaT5mCmK/XRiQueY88DVQ1mIgY/9IPUOkBVI
         QrT+tV5+VCst0Wb2sFKMQ2XzIHROO3ING/rDvnQrEb6v034ft1H7SgNRoVn1A/RINhBV
         aIDTX3obBTz0QGh69lt2Z5f5EgNg7NCeDqWzWs0mbSODzkckoKUlTvY6pYGL/kcgV2Eb
         H+Tg==
X-Gm-Message-State: AOJu0Yy/C8RNu5Yx+19SxgSEE9Ff6iNfNwHhG1Q7FvrzHkC1f+BqLiY0
	v780ULcfHvUQr0P2kIHA0GZvD6Rk+noTR9H4+PCKhLwwR5HdgYiYs8pAiEcodpWYfvPOe9bO8Yd
	QKHE+CrQPTTofRfu/3vKGEBYwqZlkJ8kJit1y
X-Gm-Gg: AY/fxX5TTJGVuaUY55f9fzQGPQaxZjFwAuOBfgsmiQtb21EbtNSaAeWtVgfu57NS7at
	sylzhPuvdY4yfAUJOcy88yi9soCZvYAYOx4EF4ZC9rP7R+ywz200ONdAaZ92PKoeextZOoNMM2B
	MGusNj7J7tAPD0e1ZdveXau1b7cA3+rTQGAbSWfSaSzYdKaabYHexT2Dso+rhFKHo7MtyMjDcxD
	AmJ4ARHJtnoy7gSNy7AomzjFmb76xjeVyZeaG+z9NfqMfnHgN6Bo4YlFg1pbT/1SJvSgSxZEadr
	pX6WDSuYMSwQjp40HGzfGI/ERFlr
X-Google-Smtp-Source: AGHT+IELIqS6pcGgfuZu61EW8XjTAPCNWhFhikN1NVFr+huyLoF0TerhYKd3kHhybVjbOIwYkVND6RnVOuNL9YNtRjA=
X-Received: by 2002:a05:6402:3589:b0:64b:57d2:7ce6 with SMTP id
 4fb4d7f45d1cf-64b57d27f51mr1949434a12.16.1766044073278; Wed, 17 Dec 2025
 23:47:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119005119.5147-1-cel@kernel.org> <CA+1jF5pTHTh1o1S92s1JVF4Lvx5XT7+tccu=woDSbDUPRsubXA@mail.gmail.com>
 <bde0d0ba-4e1d-420c-b8f5-71835ffcba16@app.fastmail.com> <CA+1jF5qLyY0=oKmUMwH6-b8azfP1J7j4B3LeOcfc0kg-n9bOgw@mail.gmail.com>
 <b7ec524c-91fa-4638-86f0-ab2e93029c2a@app.fastmail.com>
In-Reply-To: <b7ec524c-91fa-4638-86f0-ab2e93029c2a@app.fastmail.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Thu, 18 Dec 2025 08:46:00 +0100
X-Gm-Features: AQt7F2rlQ0Gx4cpIP74WtIm-VzAYXvq8_TUI-FH0FagX8YTon-G84pemlG7zB4Q
Message-ID: <CA+1jF5oQD_zi9oaamYAuWBDYnwTvaxTF1VyGr_7zRAB6eeSypA@mail.gmail.com>
Subject: Re: [PATCH v1] NFSD: NFSv4 file creation neglects setting ACL
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Is there any target date when this will land in Linux main tree, and
when will this land in the Linux 6.6 LTS tree?

Aur=C3=A9lien

On Sat, Nov 29, 2025 at 5:16=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Sat, Nov 29, 2025, at 10:49 AM, Aur=C3=A9lien Couderc wrote:
> > On Sat, Nov 29, 2025 at 4:40=E2=80=AFPM Chuck Lever <cel@kernel.org> wr=
ote:
> >>
> >>
> >>
> >> On Sat, Nov 29, 2025, at 2:57 AM, Aur=C3=A9lien Couderc wrote:
> >> > On Wed, Nov 19, 2025 at 1:51=E2=80=AFAM Chuck Lever <cel@kernel.org>=
 wrote:
> >> >>
> >> >> From: Chuck Lever <chuck.lever@oracle.com>
> >> >>
> >> >> An NFSv4 client that sets an ACL with a named principal during file
> >> >> creation retrieves the ACL afterwards, and finds that it is only a
> >> >> default ACL (based on the mode bits) and not the ACL that was
> >> >> requested during file creation. This violates RFC 8881 section
> >> >> 6.4.1.3: "the ACL attribute is set as given".
> >> >>
> >> >> The issue occurs in nfsd_create_setattr(), which calls
> >> >> nfsd_attrs_valid() to determine whether to call nfsd_setattr().
> >> >> However, nfsd_attrs_valid() checks only for iattr changes and
> >> >> security labels, but not POSIX ACLs. When only an ACL is present,
> >> >> the function returns false, nfsd_setattr() is skipped, and the
> >> >> POSIX ACL is never applied to the inode.
> >> >>
> >> >> Subsequently, when the client retrieves the ACL, the server finds
> >> >> no POSIX ACL on the inode and returns one generated from the file's
> >> >> mode bits rather than returning the originally-specified ACL.
> >> >>
> >> >> Reported-by: Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
> >> >> Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
> >> >> Cc: Roland Mainz <roland.mainz@nrubsig.org>
> >> >> X-Cc: stable@vger.kernel.org
> >> >> Signed-off-by: Chuck Lever <cel@kernel.org>
> >> >
> >> > stable@vger.kernel.org is in CC. When will this patch land in the
> >> > Linux 6.6 and 5.10 STABLE branches?
> >>
> >> I can't give an exact date, but I expect it will appear in the LTS
> >> kernels in about 6-7 weeks, unless someone finds an issue with it.
> >
> > Do you have a web link (URL) where the patch is in Linus's tree (Linux
> > git HEAD)?
>
> It hasn't been merged yet, so it isn't in Linus' tree at the moment.
>
>
> --
> Chuck Lever



--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

