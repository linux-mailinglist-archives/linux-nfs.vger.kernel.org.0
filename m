Return-Path: <linux-nfs+bounces-4872-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ADC93007D
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 20:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2858285324
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 18:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F1C18638;
	Fri, 12 Jul 2024 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ridpw+6e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE3E17BBF
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jul 2024 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720809018; cv=none; b=Z0Jr2AULqju8401ya2LdebGboZtAmegYMXdeEipNMZ5GddujHbWH+K2EUKaBFpIvQoorVfyl51b/L6MNIwI/yLyZU1l+LeXubtNmaSzQMIT1CG2eI2wZDgB2ZYLTG0/yGe/cncfG9S+FKWenAYpKfJCAQNo8+0T9OqLD7YV9aOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720809018; c=relaxed/simple;
	bh=oHHklbvcvyn+9hanV5HtvctKPu8TsJE2yjB7Ucpi0OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEGDgOmcLvn7AGfM1/2vFmFwcD5EkkeWlj6lROqn7Fm31Y0EKTdnv9Y3j72HWAXjck3rY1HwE00G6CtUeeJFkkQnkweiZyhZYUvLyTdVv1plpj9u0LSPB2SITNK1pYd80bZVdSCaL5PqGRV1B8yjJnwDduL6iOigHgIOs2MGHoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ridpw+6e; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e04289a2536so2500964276.1
        for <linux-nfs@vger.kernel.org>; Fri, 12 Jul 2024 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720809016; x=1721413816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jG5VB+TW28xdxQMvIUyhrp/WfMRTb3cZm+FMBnN+yxU=;
        b=Ridpw+6eoSpka6c1b0LlrIqqupK2k4muWzkxxTBIFdX/7DhsVXRFsBz7NG/uw+J/Yx
         oRPeT92XAw8XMWE0vIgLuYXsDzU0Xj7R6L7yWlUh6nOHHxQiaveR0K+0Y/HRqUzrsQL1
         4evg6hFOwtdoON17a2Tkd6EQnQm2UMAjrbcQ8euCKpszyLqaBrmi+e5SCW1jSAIIUOX4
         IrCeDBp41gh5LzKAHBQDqVGewvDGA5N1h1rOxBewh0/h78kTqEvQtXyJc0Xxxba0HuTB
         Sv/yeZNXYQpIaWi0PdC8GQ6C9rHLnmdRovElKVJvJi9NR9c6PyLMbPKcBM7ROWxsk/nA
         r72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720809016; x=1721413816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jG5VB+TW28xdxQMvIUyhrp/WfMRTb3cZm+FMBnN+yxU=;
        b=dE995mDi4GRXt/Iorsi3mS2b8VBVej6eUodQ2QUTt3K2yFJOsOzY1kLqvhpbreNsfy
         U4ozaguWYAGkjFhbkv19hVh2GLx7PYERKtvOemoZsQo6/Hp68r+nyq6rIFzmNmo4ToqF
         dyupoPizHvM2A/V/707xhAZpaak3NHyhoHG7eaKaPrY7LoO3vU5NrSLFxC0wZhrihBov
         Hjp3RfLm9BdWQ4FbQGvog8/SZFlKeAeamB4k3y91GmJYfeeLB2Z0iTuss2OvLP4uz2uL
         ni3lnv1eCTOY9leZbG3oGLc/0TWFu2nYx32vXE4v/bDNLeIldOM4y6AJZcZTmMpfJ+F/
         ZXnA==
X-Gm-Message-State: AOJu0YzoYALik6RNMsYE0kBDtnLGdoXtyLErFAkqSx2QyTlF3eo9HNGL
	+ITpxmUFVtoygq+iY6iDsJjHOeFqG/k3gnjAq1AJH58/ArHDaWn0HNlLjc43BD5n/3K1JVer2KK
	JfgTPwWQK73gJT4by7mtU0bPIW+Q=
X-Google-Smtp-Source: AGHT+IEQI7d4SsL2NM7GevQFaDfzzD4sCLuSIJgRv+3/bz887xPV9U4mciDUsS4A5xnsi7s8/XYj50kCsA0P+kTyzxA=
X-Received: by 2002:a05:690c:23c5:b0:627:e3ba:2ad7 with SMTP id
 00721157ae682-65dfd0906e1mr29854467b3.9.1720809016127; Fri, 12 Jul 2024
 11:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-nfsd-next-v1-1-f9f944500503@kernel.org> <ZpEwdJuoPFRE+sJ9@tissot.1015granger.net>
In-Reply-To: <ZpEwdJuoPFRE+sJ9@tissot.1015granger.net>
From: Youzhong Yang <youzhong@gmail.com>
Date: Fri, 12 Jul 2024 14:30:04 -0400
Message-ID: <CADpNCvaBr3J5w=SfUM50_DfvVhyJtgN4-xC+uHFTf_zwfvr9FA@mail.gmail.com>
Subject: Re: [PATCH] nfsd: remove unneeded EEXIST error check in nfsd_do_file_acquire
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Testing is done with this patch applied. All good, no surprise.

On Fri, Jul 12, 2024 at 9:32=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On Thu, Jul 11, 2024 at 03:11:13PM -0400, Jeff Layton wrote:
> > Given that we do the search and insertion while holding the i_lock, I
> > don't think it's possible for us to get EEXIST here. Remove this case.
> >
> > Cc: Youzhong Yang <youzhong@gmail.com>
> > Fixes: c6593366c0bf ("nfsd: don't kill nfsd_files because of lease brea=
k error")
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > This is replacement for PATCH 1/3 in the series I sent yesterday. I
> > think it makes sense to just eliminate this case.
> > ---
> >  fs/nfsd/filecache.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index f84913691b78..b9dc7c22242c 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -1038,8 +1038,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
> >       if (likely(ret =3D=3D 0))
> >               goto open_file;
> >
> > -     if (ret =3D=3D -EEXIST)
> > -             goto retry;
> >       trace_nfsd_file_insert_err(rqstp, inode, may_flags, ret);
> >       status =3D nfserr_jukebox;
> >       goto construction_err;
> >
> > ---
> > base-commit: ec1772c39fa8dd85340b1a02040806377ffbff27
> > change-id: 20240711-nfsd-next-c9d17f66e2bd
> >
> > Best regards,
> > --
> > Jeff Layton <jlayton@kernel.org>
>
> Youzhong, can you replace 1/3 in Jeff's file cache series and
> test again please?
>
> --
> Chuck Lever

