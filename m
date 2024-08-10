Return-Path: <linux-nfs+bounces-5299-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3E494DEBD
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 23:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9423A282B09
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 21:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D58E22F19;
	Sat, 10 Aug 2024 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="iwc0JpeE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1211DDC9
	for <linux-nfs@vger.kernel.org>; Sat, 10 Aug 2024 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723324820; cv=none; b=UR5LHO+DBWdhTIJF4DGKdDyIb4quaiFfgb6nmt+6Qb5PAedczxLz8zNr180G5nl8WTj7x4M+eRkCtl6EvKs845tgtuJ3gdeL3mN+vlLSMRhHvlZdd666qfqqyqaTOkySodi3OgHxV6OxnB6CBYU8tiKKoWCLU+Qf7UNNeBgZizY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723324820; c=relaxed/simple;
	bh=WJQM41zJ0YL0qjcOKiM3UBkaOSUVedlEjjbcwWIC19g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=an6qpSRV/PXf1894OIyaNZwi/HwuJJAVQMj1qCGCpIaP6aqXZcp4DrYKk0fJ9qraA1+ONyidc3NbpsQ3hwSW1tjD3oQrgRKVoY1Y5VRICBG6ZjZCaYPatudDBL7R7oMG2I8aTCWsMQw6DJ6mblQ/feMtrX78VCHV0XxXvV+hYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=iwc0JpeE; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f015ea784so498758e87.1
        for <linux-nfs@vger.kernel.org>; Sat, 10 Aug 2024 14:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1723324816; x=1723929616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gc+AdO9zW4rEHmCgZBfMGhaS83kAImVFxeNiVtBkxLs=;
        b=iwc0JpeEgF5F8coRSyi9mk/h4rrIU0KdgahKi3vA0dmsJu6OVJp7OX1kxPYLxgaslK
         3DYLuLinXzgtWa6ssR6MH2qtOfBSAT3qJg94ywuxOneZDxoKgnmF+mJsu/Rx9r8OmzBi
         AG8zGdjB6kZvTODOMmSVNGhnEF3xsrof8yhaqGiZzteZKsgBNY8VvrG0DsdmX8XlYedx
         BxTJ/bGZMXRAWnDfrE1QWw7jh+S3WvlVtlcDrQ7rwObFFoJa4vLcHLWN+C4smiKkp2Di
         qPy+GNEIldZd8cpnZi95rBDzb62kaL0MOqStn/scuLr6/ZjKwqp1WLlAB92pnnZbyxno
         ewig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723324816; x=1723929616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gc+AdO9zW4rEHmCgZBfMGhaS83kAImVFxeNiVtBkxLs=;
        b=HlnaBfOlWS8uBsd4ZFlxGBZaJFaq68UmNmNUqxuVtYm+oVaCV2uJyqfO6Hv9SJAWDu
         G0ye8Akb/P++YPc4YN7oXEPnLdjkAwxF3rulHi8b3UYExTpF+WENCoa1BCdMglAtxwP5
         MSjV+sRh9ka2PXxRdEFewyNi19pZgYG69jh8iLmzLGc/IjmdLku4Qj/Lvr0M+gfsgJCN
         2/mrOfJk0AlAy9c5xFnr33GxVTpKvroB0K1BvquZYWYSSw00g6vp4Y9WrO7UeffpbHTM
         r2v3Vpdb1RfKZIr+gvs6clIH/WnwFQAjE1K3Q1taKvO1L5Q0Cv4rpZsQalhnSJ1HxKb5
         lSRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB/auKXZsx0nXwskIsoQxFBD4TjPdxb02aHhA06ful80fZ7CgY5McAOsvdOZqn6VrGumHWEfNXbSp9GHPwMgzfJrrvFrEKhmud
X-Gm-Message-State: AOJu0Ywj2l2wrGKAKpYoNqtBnBu5HZO91Xm6G9fNFWmW8yvLS2Py2jts
	vEEk4nserERvJe9ytRY14BOFZ9d1lBEZzx66QqgOCYNNzpAe+dbeJ1F0jK4ycqgyYgCy1Ul+eCf
	qVSbCJ7f3PVFHd704xxXoOgTxLaa2yw==
X-Google-Smtp-Source: AGHT+IH4GeYwrIc0/TiDVr84I9XBetgXY2qx2J+3GTNdSoJ6uxN17oJvbTVKcDpzuPHeyEpoalp2MGf5QQh41iA3CP4=
X-Received: by 2002:a05:651c:198b:b0:2ef:80:a68c with SMTP id
 38308e7fff4ca-2f1a6d713d0mr20738651fa.8.1723324815304; Sat, 10 Aug 2024
 14:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c4f1d8bf-745b-4a98-9d38-2da4c355d691@gmail.com>
 <66be75a6-2d3f-4f5b-96da-327556170c4a@gmail.com> <e39131ce-1816-49e1-8319-820472892a38@gmail.com>
 <CAN-5tyEx=j2OiRZVd+18x-2Y36SGGsJxAVApudT+mWjiNGDyxA@mail.gmail.com>
 <CAFX2Jf=k0SC4iFzj+24HbR-4MPkk0bkGCvnnOiv0OYgqO4QOBw@mail.gmail.com>
 <8ab0fd49-0c90-42bd-a34e-9dcf63a99bd5@gmail.com> <CAN-5tyHMAWmnwgfR7ih_7ygUUfOdGfE7ntf2nxRTFY+USy2HYQ@mail.gmail.com>
 <4851b332-b3d1-4f45-9fcf-5c42b8d5b483@gmail.com>
In-Reply-To: <4851b332-b3d1-4f45-9fcf-5c42b8d5b483@gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Sat, 10 Aug 2024 17:20:03 -0400
Message-ID: <CAN-5tyHXg8=Sv8MS7vJUwG+=Av8oL6Bk_ZDDfwjEf3-R0KT=dg@mail.gmail.com>
Subject: Re: NFS client to pNFS DS
To: marc eshel <eshel.marc@gmail.com>
Cc: Anna Schumaker <schumaker.anna@gmail.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Trond Myklebust <trondmy@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 12:27=E2=80=AFPM marc eshel <eshel.marc@gmail.com> w=
rote:
>
>
> On 8/9/24 8:15 AM, Olga Kornievskaia wrote:
> > On Fri, Aug 9, 2024 at 10:09=E2=80=AFAM marc eshel <eshel.marc@gmail.co=
m> wrote:
> >> Thanks for the replies, I am a little rusty with debugging NFS but thi=
s what I see when the NFS client tried to create a session with the DS.
> >>
> >> Ganesha was configured for sec=3Dsys and the client mount had the opti=
on sec=3Dsys, I assume flavor 390004 means it was trying to use krb5i.
> > For 4.1, the client will always try to do state operations with krb5i
> > even when sec=3Dsys when the client detects that it's configured to do
> > Kerberos (ie., gssd is running). This context creation is triggered
> > regardless of whether the rpc client is used for MDS or DS.
> >
> > My question to you: is the MDS configured with Kerberos but the DS
> > isn't? And also, does this lead to a failure?
> Both MDS DS are configured for sec=3Dsys and it is leading to client
> switching from DS to MDS so yes, it is pNFS failure. What I see on the
> DS is the client creating a session and than imminently destroying it
> before committing it. If the is something else that I can debug I will
> be happy to.

pnfs failure is unexpected. I'm pretty confident that a non-kerberos
configured client can do normal pnfs with sec=3Dsys. I can help debug,
if you want to send me a network trace and tracepoint output. Btw what
kernel/distro are you using?

>
> Marc.
>
> >
> >> Jul 30 11:10:58 svl-marcrh-node-1 kernel: RPC:       Couldn't create
> >> auth handle (flavor 390004)
> >>
> >> Marc.
> >>
> >> On 8/9/24 6:06 AM, Anna Schumaker wrote:
> >>
> >> On Thu, Aug 8, 2024 at 6:07=E2=80=AFPM Olga Kornievskaia <aglo@umich.e=
du> wrote:
> >>
> >> On Mon, Aug 5, 2024 at 5:51=E2=80=AFPM marc eshel <eshel.marc@gmail.co=
m> wrote:
> >>
> >> Hi Trond,
> >>
> >> Will the Linux NFS client try to us krb5i regardless of the MDS
> >> configuration?
> >>
> >> Is there any option to avoid it?
> >>
> >> I was under the impression the linux client has no way of choosing a
> >> different auth_gss security flavor for the DS than the MDS. Meaning
> >>
> >> That's a good point, I completely missed that this is specifically for=
 the DS.
> >>
> >> that if mount command has say sec=3Dkrb5i then both MDS and DS
> >> connections have to do krb5i and if say the DS isn't configured for
> >> Kerberos, then IO would fallback to MDS. I no longer have a pnfs
> >>
> >> That's what I would expect, too.
> >>
> >> server to verify whether or not what I say is true but that is what my
> >> memory tells me is the case.
> >>
> >>
> >> Thanks, Marc.
> >>
> >> ul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node
> >> stripe count  1
> >> Jul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node
> >> ds_num 1
> >> Jul 30 11:10:58 svl-marcrh-node-1 kernel: RPC:       Couldn't create
> >> auth handle (flavor 390004)
> >>
> >>
>

