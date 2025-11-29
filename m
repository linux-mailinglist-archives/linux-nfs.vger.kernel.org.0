Return-Path: <linux-nfs+bounces-16794-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D37C9417E
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 16:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A5B6342D1E
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 15:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004151C860B;
	Sat, 29 Nov 2025 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6lwuZZM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9D5199FB0
	for <linux-nfs@vger.kernel.org>; Sat, 29 Nov 2025 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764431414; cv=none; b=KFZcoYuS37AIuKig7d60MZg4ulxL8w7W7cZV5QCIxulEsXxr9D3WlyzGgfYRH8UoIZqTUgg2FWNytnjx8/Y7Ear7NSgEK0KqoSzs93Hd8n/8jtfSiY7VI+IVw2Ve7jCZnTjFcJnbrmTQnhYgOfpymQyByaf0nxG07aG8sLp0Zpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764431414; c=relaxed/simple;
	bh=1BupSjR26JQmhX9EWadwRaAjzRphytaQZJgN6X+EDRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=WlEXqAxTISbimWai+9GIxs+d7XrQcLX5lSlk3CPNwzj7L0tQtB+K6dKL9bxNuj8+a7RNFyaUpFPJ8QbKzSlDSLKIZEzciOEZLetiIp1FwTX9FpWlKPhGJl5N57+wbhwpxYp8dy+E83g4T79gxjofdLQifyD+CbiCLhaztT63n5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6lwuZZM; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64074f01a6eso5083460a12.2
        for <linux-nfs@vger.kernel.org>; Sat, 29 Nov 2025 07:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764431411; x=1765036211; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BupSjR26JQmhX9EWadwRaAjzRphytaQZJgN6X+EDRk=;
        b=G6lwuZZMOdb4HaRxilBBO4LROEBKcpFe+ToGCJgJJMxC2vbUJkJfYbBJQ6ZrvG38P7
         LFQyOYqJ4kYapmguuNBG/Lo/4zlsvAzR2JLEPJ711jjIAfpv4g3r6qS/2UDuVt+P01tM
         hy0YOBWnXXrp59C4UmRCS3nu58sWvq4i1rfYZcXIC/rQww9I4Up/LxUB+LWuNkjfB2Gh
         gOhNE+5AOtNj8tuzFs8tMwAcwq5Pg47nvsAdqPlzMw/OaTFh3Yq9wW3Zln86d896IPUx
         Z5MoFw1L+yoJhmYqs0pWTVm6cnQ57y9RXA5upAhLZILk8JjxtGuxOmXf+B6U7jdkKwi6
         X9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764431411; x=1765036211;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1BupSjR26JQmhX9EWadwRaAjzRphytaQZJgN6X+EDRk=;
        b=ZOoq22KCS7z1z1JMJgryI9ydzPfWhOH5tJ7ZSs6yVjhmOn+pQaF8IlGrsjOTpCK/8Q
         mBlYqyNhTg99T4ReS6HxNN2a9YRhHLK0AUruXcnUXRT2pyhOgzhjPhifutbostyn6bWX
         /EbD+gCTqf0WNl97ijkimt30slk6BZqYZFeisB2vGpmUALYJxxZnYD89QxueX5x6Xveg
         quRNJDbqj7Mv7glp5+yiRlpYEbD3ptNhigkzdmSo2yt5wDHoFSb+5J1aU0z6OJfi+aHI
         VYN55pGg6Uq/EPmyKMhuH+p1bhppwFu0OWk5K64cNuMq2HIdVu4LIIN8dhde2VzydTur
         HgfA==
X-Gm-Message-State: AOJu0YwHDx+PDNgReQ8p5v+25sFvBFaPzzOSpGila0W+e3Qeh6is2PlJ
	y7yMn3ZfAfw31UexxAqr8Sro5c14ZDZHInuTV95qqPByWtzv4C2HDxs8L7Wf4FoBfsnWJ8JHLad
	EFFvyJmGlPSpw3/L1anwTZq3LdnkBUenk3TzFfKQ=
X-Gm-Gg: ASbGncu3DY6lIXjhPU7Bbet+se0kxZ9DM5jp1NPlH7LNjPnTUtttUO+PAqXHYYdsofO
	USNxpgn4t5DzyogDULGrG4GSJ90Ckx1ChQVzXXblSL/6r3TYFzwekCUA+dd+xFcSCjVwQh/MWEN
	AIjuXIOXWfYN6x4jUg0Zf/iBluzhsu/fclhv00q0cPJLno0zn+Kisgrf2wrpMYjRQHlkrPFKN4o
	L/vPD/wE8g+nVzCdLA1/aoAG3pNJh7SbK7zhqyibC5AGeIV33arWnv7wGaRtdpnbcH/05uJcM+M
	LbOZ4IuhLgQ49LE3k3L6xlBi+SE=
X-Google-Smtp-Source: AGHT+IHkcKF01Oibgm3Be3naPTIc0d+FKDIeyRjjsvsmBq6CYiC7dgsT04yj5zoRcLM05Ec1ITtS1xZsMz7Yn9eTBYY=
X-Received: by 2002:a05:6402:35cf:b0:640:b736:6c2f with SMTP id
 4fb4d7f45d1cf-64555cd9f48mr29816256a12.18.1764431411304; Sat, 29 Nov 2025
 07:50:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119005119.5147-1-cel@kernel.org> <CA+1jF5pTHTh1o1S92s1JVF4Lvx5XT7+tccu=woDSbDUPRsubXA@mail.gmail.com>
 <bde0d0ba-4e1d-420c-b8f5-71835ffcba16@app.fastmail.com>
In-Reply-To: <bde0d0ba-4e1d-420c-b8f5-71835ffcba16@app.fastmail.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Sat, 29 Nov 2025 16:49:34 +0100
X-Gm-Features: AWmQ_bmm4bDxoUNn-_rW-Ato-keL5EdHmF-38-aAgHOKMzllp7KApTGLwTHfUeQ
Message-ID: <CA+1jF5qLyY0=oKmUMwH6-b8azfP1J7j4B3LeOcfc0kg-n9bOgw@mail.gmail.com>
Subject: Re: [PATCH v1] NFSD: NFSv4 file creation neglects setting ACL
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 4:40=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Sat, Nov 29, 2025, at 2:57 AM, Aur=C3=A9lien Couderc wrote:
> > On Wed, Nov 19, 2025 at 1:51=E2=80=AFAM Chuck Lever <cel@kernel.org> wr=
ote:
> >>
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> An NFSv4 client that sets an ACL with a named principal during file
> >> creation retrieves the ACL afterwards, and finds that it is only a
> >> default ACL (based on the mode bits) and not the ACL that was
> >> requested during file creation. This violates RFC 8881 section
> >> 6.4.1.3: "the ACL attribute is set as given".
> >>
> >> The issue occurs in nfsd_create_setattr(), which calls
> >> nfsd_attrs_valid() to determine whether to call nfsd_setattr().
> >> However, nfsd_attrs_valid() checks only for iattr changes and
> >> security labels, but not POSIX ACLs. When only an ACL is present,
> >> the function returns false, nfsd_setattr() is skipped, and the
> >> POSIX ACL is never applied to the inode.
> >>
> >> Subsequently, when the client retrieves the ACL, the server finds
> >> no POSIX ACL on the inode and returns one generated from the file's
> >> mode bits rather than returning the originally-specified ACL.
> >>
> >> Reported-by: Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
> >> Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
> >> Cc: Roland Mainz <roland.mainz@nrubsig.org>
> >> X-Cc: stable@vger.kernel.org
> >> Signed-off-by: Chuck Lever <cel@kernel.org>
> >
> > stable@vger.kernel.org is in CC. When will this patch land in the
> > Linux 6.6 and 5.10 STABLE branches?
>
> I can't give an exact date, but I expect it will appear in the LTS
> kernels in about 6-7 weeks, unless someone finds an issue with it.

Do you have a web link (URL) where the patch is in Linus's tree (Linux
git HEAD)?

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

