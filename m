Return-Path: <linux-nfs+bounces-1905-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F6D851F66
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Feb 2024 22:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34639283092
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Feb 2024 21:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135944DA13;
	Mon, 12 Feb 2024 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aXaB4ioj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460FE4DA03
	for <linux-nfs@vger.kernel.org>; Mon, 12 Feb 2024 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772633; cv=none; b=KaeTyQ9mfZFo6Rj6twbceZDl3CyjFS9sb5UDUBeskFvAgHnO3PxUPGxCD+MTG5zXWawS5w0J1Fwt33UxR8CrfBFC6OmmkpE9b98zL49UbwI2W/mMLlopBjIoDStzqQr2Qq/nD8UN4UjXlUAd5poxnaBbByaD4OSS+1ImDXHC0ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772633; c=relaxed/simple;
	bh=sKyYv3h5LS/Xc+JkhqC/7H32Ejapjycaf0b1D5xsxdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxp71QszmfWYlGneJMsc4cJBEeYdiWIveRswJvETjIUUm45T2ER9sy7xA2r6wv1+BYgsDQefCow7P2ABaDRvh2GcH3AmDygHq6ltEMzK3RWgRYxGaC6zzMDFSyjogkXIQ7iEVuZYCUtOa6oYkYIQR8M3naDrVKp8xNdANeunPsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aXaB4ioj; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbed179f0faso3281746276.1
        for <linux-nfs@vger.kernel.org>; Mon, 12 Feb 2024 13:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707772630; x=1708377430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsnFwrkSPFxLZoShd+G+bJFEOcLvvtQSuD3i6JLjUWA=;
        b=aXaB4iojMUi4axEelhZ0stCsfoeKjXkqyvnfbZrFMOcXTy3lf8VtkFY2Ko0RCxA8hK
         gUOqXp9eCWzlicRERGuZaZIrFN3wWQn1ZdWqtOkFPlaofdV/+HODU8yTjxURHdlFqtLv
         ZLO7i2Hdcr3WEQAjn7Qo3jo6Dh1fnT7Ju+gGTnMTUEW1Lq3b+GAmGjkBLvTcyNsb7IvX
         C9X4aDlG/kdcKibBXcjX14+uys8CEASKUh7LIF5o1Eddxy2q+ucLTtVrCoHVOmmNl6pL
         wO0CWg7c5gxyx8NczGZwqKRgGSDYgUCPFjEjc2NIjT43UEFxYtnTeKv4KEY/kly5y2Il
         CPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707772630; x=1708377430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZsnFwrkSPFxLZoShd+G+bJFEOcLvvtQSuD3i6JLjUWA=;
        b=EEpKCgU+dLA2BaFO2yrhGPh0Xn0ithlDOgkrROOwElFFC5HKyQlN9VhPMA7y+LvhU/
         3xCOBspfgLxrEk//08al2Uubcv/6W0cxqJBZn6WwZ35xI0UzAK5mdBv1GPLH/X8RQwEN
         Yi+Kxn1EFus9gAlqjIogs6nPdXpyeU1/6y2orO9WrRBLhAYBP5Jm/13Ha7wRTr7itQyK
         b7e25axLlJqOkgCzWhT/CHhZ4Hpb4VCIzWONlRFaMWQP1CjuSUjYYLE6e+2Tz0K2XHjU
         aZwm3mXc8UScwRA8sDPO7uuqbwCwntVcmx9z4Tc7u2IGIUcLRMMlOUwu/ojC1Ki3Y6Gl
         7elQ==
X-Gm-Message-State: AOJu0Ywa4QABJKPhBlIm9rQDo2FKWrUdTurcWj+jRLh32v9FU1KAWMl1
	H7gqYRP3zPXKv/sny11hujNLIfol2EnYCpmSWW7dM0m8NJm0zQox6E67h3sp6wm7zbRoIwAAIiF
	0qyRKwsAwXkvCN6irXJEVkjH0LgLxtbXqERUK
X-Google-Smtp-Source: AGHT+IEOi98MZdQxOtaW3bif3LCitIRo8nxqZzxmxH4vbtrZo7RwV5CIap8rAl9zZwh9y87ZH2fwVGa5f+4Y+dV/RGg=
X-Received: by 2002:a81:4e10:0:b0:604:541d:9d54 with SMTP id
 c16-20020a814e10000000b00604541d9d54mr598093ywb.21.1707772629971; Mon, 12 Feb
 2024 13:17:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-13-roberto.sassu@huaweicloud.com> <305cd1291a73d788c497fe8f78b574d771b8ba41.camel@linux.ibm.com>
In-Reply-To: <305cd1291a73d788c497fe8f78b574d771b8ba41.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Feb 2024 16:16:59 -0500
Message-ID: <CAHC9VhQ7DgPJtNTRCYneu_XnpRmuwfPCW+FqVuS=k6U5-F6pJw@mail.gmail.com>
Subject: Re: [PATCH v9 12/25] security: Introduce file_post_open hook
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, 
	kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, 
	serge@hallyn.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, 
	eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org, 
	mic@digikod.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 4:06=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> Hi Roberto,
>
>
> > diff --git a/security/security.c b/security/security.c
> > index d9d2636104db..f3d92bffd02f 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -2972,6 +2972,23 @@ int security_file_open(struct file *file)
> >       return fsnotify_perm(file, MAY_OPEN);  <=3D=3D=3D  Conflict
>
> Replace with "return fsnotify_open_perm(file);"
>
> >  }
> >
>
> The patch set doesn't apply cleaning to 6.8-rcX without this change.  Unl=
ess
> there are other issues, I can make the change.

I take it this means you want to pull this via the IMA/EVM tree?

--=20
paul-moore.com

