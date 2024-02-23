Return-Path: <linux-nfs+bounces-2056-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5149786097B
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Feb 2024 04:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FB8284247
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Feb 2024 03:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D66BE7D;
	Fri, 23 Feb 2024 03:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="Zfol4vO8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71691BA5F
	for <linux-nfs@vger.kernel.org>; Fri, 23 Feb 2024 03:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708659864; cv=none; b=AcIoDkI800KBmwDgSI/Rh6o9eSrB59NC6o4ZJ+YPslF7iLBrTDs6fdQRUhlFWHQa/PeI0fPD25jsJoNupCUw2J/lPd5/0WbxL0YjQvRjwBf26oBA5rJQrhSTZrHoAjxwJpWW3YNRf5Vk6zjcWvgR53PO+W9ipkX03KmTJvJIqD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708659864; c=relaxed/simple;
	bh=Wey2cmUhSQHAiwbioFzj3eN7a2nvTaGvswAMtmSY8RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUYa3U5AcS08myOYZLEBdAnMQyjcBxhrPlwCt3CYs2xY/l+FI1fbmG6JyYkgJreWKxxCT8M933ZPBAao3utHAywVzVUR3ibQZXulyvlbikTqh5hUbwjy9NREZjFCWK5gPtCwJkY3JvCAttIUrLvi7wyBD/9pWkyWZIQ+/rY/NOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=Zfol4vO8; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512d8950e3dso625172e87.2
        for <linux-nfs@vger.kernel.org>; Thu, 22 Feb 2024 19:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708659860; x=1709264660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDydw5Ppu17DpVbXsQfWBCr5zFlq79IwyUyQlJOt1Fc=;
        b=Zfol4vO8/9yg76ESlyT78i1gxTKwwEdcuvTmkXxXBdPrF2oT3LBYHm6eL2QxNLBj3c
         LIvlSQjjIAelGhNlwbG0oM50c13e1TWRlUQkg8EWBI83J26hJ7LQaPTS0Xfea3tc4IsD
         XmWSOyWamcbMmr83QWKOEs7555bzrQ/mL47ZyIA+j9F1ltnMP1MiAy/zMx8qKsdNNJM0
         B2vHcAhPVkQgBNu3FWUG8T115zSi8vdkJR9f0Cvrm/xFYTTSeTOEkVZLCRObYKN/7trx
         DjqOCr+C6RVXh6VX5WClmJGh5ltsoAfNB1P8/dlGaZcBuclR7NCl7MlGHXzI1fgjChnp
         v8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708659860; x=1709264660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDydw5Ppu17DpVbXsQfWBCr5zFlq79IwyUyQlJOt1Fc=;
        b=FnyQpDGoVAcK1wPWTOAHpZjrVofzd8DRHdZIjbmgSXoLhBDHVa9QGH+iz9112pNljv
         fcVOatCN06pV1AP+zxFYqXz7m0uiE2uLSz84QfsqAqYlXVFrb7o4giWjOphjP1xBG1Jy
         LfemjQ3imezGyA7x9rcMaObqrbEsk920CqwASy94cwf8KutxRA/1G/gVRNHacXHbO5zJ
         uddNjvbQQ83KrGmU6TDnC1g1V1DMKtKPC52v+XvGHR1n1tkE5XHTnsKmRkzjUNd+bW58
         tlZwZbBkKvN4NBfxcQAqzhoFpuTMHVGos2NX68X9icEo/Sf9SZkCgcRj4thwO+kO3INa
         ANgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaKS3v9G/UWhyyxkqZalhRF0YAh1+um8AQn2BKX43SWh7KlRbR5JX2GVmakMOTACotaldYjRIG3atvDutDpt8q4tl+KdhHSs2+
X-Gm-Message-State: AOJu0YxQNuaOe9koOU9/4Aymid8h+QK/EdU+mDnUJVKMiNHTmXSTUPOv
	2oSc8LvgqL9kDzhC+Fpd9NmO1unS6P8P00vJzvVann/ecshoEqHxJiMIHvVEqiKvlNJ9S8Mi6eg
	+PBX7tKIIvF/tgoOvL9ReyzZ9WRujIl92nU04Mg==
X-Google-Smtp-Source: AGHT+IFI1UsB1rt1ahm8Dm2eGQUzQR8SDnTANz2yj7rVsLMwqp0NEIqKZ+ffz2TGc3UUWKVEF2CbnVh9yYg7JsAAntE=
X-Received: by 2002:ac2:5b0c:0:b0:512:cbae:4e05 with SMTP id
 v12-20020ac25b0c000000b00512cbae4e05mr548264lfn.60.1708659860020; Thu, 22 Feb
 2024 19:44:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPKjjnrYvzH8hEk9boaBt-fETX3VD2cjjN-Z6iNgwZpHqYUjWw@mail.gmail.com>
 <77a58302766cb6c8fac45682ede63569df80cd5d.camel@hammerspace.com>
 <1179779e2f74e3e5cb2be30cf89e6362aaab706d.camel@kernel.org> <16d8c8e88490ee92750b26f2c438e1329dea0061.camel@hammerspace.com>
In-Reply-To: <16d8c8e88490ee92750b26f2c438e1329dea0061.camel@hammerspace.com>
From: Zhitao Li <zhitao.li@smartx.com>
Date: Fri, 23 Feb 2024 11:44:07 +0800
Message-ID: <CAPKjjno2DKbLe6DZ4HsXWPN3AAtBRdajXq8_x+xeTA6JzrFpRA@mail.gmail.com>
Subject: Re: PROBLEM: NFS client IO fails with ERESTARTSYS when another mount
 point with the same export is unmounted with force [NFS] [SUNRPC]
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "chuck.lever@oracle.com" <chuck.lever@oracle.com>, "kolga@netapp.com" <kolga@netapp.com>, 
	"anna@kernel.org" <anna@kernel.org>, "tom@talpey.com" <tom@talpey.com>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, "neilb@suse.de" <neilb@suse.de>, 
	"Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, "huangping@smartx.com" <huangping@smartx.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for Trond's reply.

ERESTARTSYS is an unknown error in application level.  Maybe EIO or
EINTR can be more suitable.

Best regards,
Zhitao Li, at SmartX

On Thu, Feb 22, 2024 at 11:20=E2=80=AFPM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> On Thu, 2024-02-22 at 06:05 -0500, Jeff Layton wrote:
> > On Wed, 2024-02-21 at 13:48 +0000, Trond Myklebust wrote:
> > > On Wed, 2024-02-21 at 16:20 +0800, Zhitao Li wrote:
> > > > [You don't often get email from zhitao.li@smartx.com. Learn why
> > > > this
> > > > is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > >
> > > > Hi, everyone,
> > > >
> > > > - Facts:
> > > > I have a remote NFS export and I mount the same export on two
> > > > different directories in my OS with the same options. There is an
> > > > inflight IO under one mounted directory. And then I unmount
> > > > another
> > > > mounted directory with force. The inflight IO ends up with
> > > > "Unknown
> > > > error 512", which is ERESTARTSYS.
> > > >
> > >
> > > All of the above is well known. That's because forced umount
> > > affects
> > > the entire filesystem. Why are you using it here in the first
> > > place? It
> > > is not intended for casual use.
> > >
> >
> > While I agree Trond's above statement, the kernel is not supposed to
> > leak error codes that high into userland. Are you seeing ERESTARTSYS
> > being returned to system calls? If so, which ones?
>
> The point of forced umount is to kill all RPC calls associated with the
> filesystem in order to unblock the umount. Basically, it triggers this
> code before the unmount starts:
>
> void nfs_umount_begin(struct super_block *sb)
> {
>         struct nfs_server *server;
>         struct rpc_clnt *rpc;
>
>         server =3D NFS_SB(sb);
>         /* -EIO all pending I/O */
>         rpc =3D server->client_acl;
>         if (!IS_ERR(rpc))
>                 rpc_killall_tasks(rpc);
>         rpc =3D server->client;
>         if (!IS_ERR(rpc))
>                 rpc_killall_tasks(rpc);
> }
>
> So yes, that does signal all the way up to the application level, and
> it is very much intended to do so.
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

