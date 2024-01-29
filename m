Return-Path: <linux-nfs+bounces-1563-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABBF840951
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 16:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D807728C8AA
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 15:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186141534F4;
	Mon, 29 Jan 2024 15:08:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F07D152E03
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540887; cv=none; b=WOQIEcyhHCg6f08UMDMngjPdi1CDEcjurWoQmHuxes/hOz2tVIc11VZX+nGCzdMUhagVVAnSwEZ3v5XeIDX0IO69xk6OF3uITrBxWwjSkfhS1QFu5gETHGL3xaZ/BtQ+an63yP0+vtOl5PJgBtX69f27/Audgj8c7gPFTSsJR/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540887; c=relaxed/simple;
	bh=3BJ3URFhTolIM0Zsws+hdGwYqs3N98sE0het+UYSdUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sj1iCWLIY1kG38Y3cK4fG2HuSr2bSDBHfzPhi+cPYtY0NbGBv6G8KA8tezPOalE+XlPFfTpDjv1EaDqG8ch4rXnCfkXVJpWYFnbXJ4/2nvC7fK+yYL/IVV0m4NvdEfzXEcsYBYkjGBK3YP5xgq0tDjiak/c6pfeNO8xFK9y77XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bed9c7d33fso106166739f.1
        for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 07:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706540884; x=1707145684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcu4w7D5xKzza3auRzOSdYBCP/S0Tof9xVJM8F65eFs=;
        b=GkcJyobUWm50jcaCgmNv9EVAGa4EkaUEmj2fvpomJJCygp6sI+MOOT46qRIDI/Da2t
         UrIvxFVkLJtyHMBGPBbP7bRK5J9kvdl4Y8+bdOdPKxtDh1yuNuRa+zktvaNGGfnNfQV+
         C8RSKBw7HNQR0Av6CEa2l5oHHGIMVGpaBkBotc5cHZ4F25NbOnZMOICknkQZr5k5wjO/
         my/LOMnuclxIVOyKV+y2z4vMxodPatm6U4fesTKHLAXA7PxL4Rodt01ENlQXWT/xHUZ8
         smiSEf61W5ikvNd/OQDwF7jczfX/B9VlahZ5PgiK5fa9ds/mG5xI3SylHnS9sTS+t+uB
         rnNQ==
X-Gm-Message-State: AOJu0YwEP1iMhojuEKUDMVtcJTkgBAzcJlnpZXjj3oUVetN0q5t6QpWk
	Xf/8uEUOyBRmBlesADU6sZKiFLLJ0GnGz4gtYVm2l2u1JmEArJb4Wx0L0nDXEMdyMejQTrbj6SS
	FgKQVFE9u4ROH5/iXILjD/Gj3Zxo+yxsY
X-Google-Smtp-Source: AGHT+IGWVrUcr7B5wj+T+8hfVr7tBTFiDuiqox4UnnLo07UUz6ckkQqgPuHOFaJ4FApc99hiwCRdc2lwP+5ywMCJUzA=
X-Received: by 2002:a05:6602:235d:b0:7bf:d163:1ea0 with SMTP id
 r29-20020a056602235d00b007bfd1631ea0mr5205237iot.16.1706540884044; Mon, 29
 Jan 2024 07:08:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
 <CALXu0UcT4gG8xEVOvK1mshMDa_hKYu7rJK2biq8==ySOXdA3+w@mail.gmail.com>
 <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com> <CALXu0Uf2z3um+kh=tgnqskr-ZdY2gU=185K3Amr=F_GJpb2_UQ@mail.gmail.com>
 <FD981B2C-5C24-4349-A279-C70F640C0A01@oracle.com> <CANH4o6O=ihW7ENc-BTBXR4d4JL0QJjZa5YdYaKAdoHdq9vwGcA@mail.gmail.com>
 <5DA015E1-50C6-4F56-B4E7-62A4BE90DBA4@oracle.com> <CALXu0UcLV-KZ4GNY8UgWCwiUOO_HsH=KLWOKuWJ2uEDP+a9sqw@mail.gmail.com>
 <CAKAoaQ=FDdkTW2Vh=_Y08DEWZYaJa6tDSYKnFiZCfQ6+PW_5iQ@mail.gmail.com> <610FDE39-3094-40EB-B671-F2CA876CA145@oracle.com>
In-Reply-To: <610FDE39-3094-40EB-B671-F2CA876CA145@oracle.com>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Mon, 29 Jan 2024 16:07:38 +0100
Message-ID: <CAKAoaQkdf41emWL-2Uq9_kFjF99Xc7UEK_ur0MmnfFAjJqLM7A@mail.gmail.com>
Subject: Re: refer= syntax in /etc/exports for custom non-2049 TCP ports ? /
 was: Re: Change "hostname" to "hostport" in text-based mountd downcall Re:
 BUG in exports(5), no example for refer= Re: Examples for refer= in /etc/exports?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc: Martin Wege <martin.l.wege@gmail.com>, Cedric Blancher <cedric.blancher@gmail.com>, 
	Chuck Lever III <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 3:14=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On Jan 29, 2024, at 6:44=E2=80=AFAM, Roland Mainz <roland.mainz@nrubsig=
.org> wrote:
> >
> > On Mon, Nov 13, 2023 at 2:01=E2=80=AFAM Cedric Blancher
> > <cedric.blancher@gmail.com> wrote:
> >> On Fri, 10 Nov 2023 at 20:17, Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
> >>>> On Nov 10, 2023, at 3:30 AM, Martin Wege <martin.l.wege@gmail.com> w=
rote:
> >>>> On Fri, Nov 10, 2023 at 3:20=E2=80=AFAM Chuck Lever III <chuck.lever=
@oracle.com> wrote:
> >>>>>> On Nov 9, 2023, at 7:47 PM, Cedric Blancher <cedric.blancher@gmail=
.com> wrote:
> > [snip]
> >> Yeah, instead of waiting for NetLink you could implement Roland's
> >> suggestion, and change "hostname" to "hostport" in your test-based
> >> mount protocol, and technically everywhere else, like /proc/mounts and
> >> the /sbin/mount output.
> >> So instead of:
> >> mount -t nfs -o port=3D4444 10.10.0.10:/backups /var/backups
> >> you could use
> >> mount -t nfs 10.10.0.10@4444:/backups /var/backups
> >>
> >> The same applies to refer=3D - just change from "hostname" to
> >> "hostport", and the text-based mountd downcall can stay the same (e.g.
> >> so "foobarhost" changes to "foobarhost@444" in the mountd download.)
> > [snip]
> >
> > What would be the correct syntax to specify a custom (non-2049) TCP
> > port for refer=3D in /etc/exports ?
> >
> > Would this work:
> > ---- snip ----
> > `/ref *(no_root_squash,refer=3D/export/home@134.49.22.111:32049)
> > ---- snip ----
>
> Hello Roland -
>
> Although generic NFSv4 referral support has been in NFSD for
> many years, NFSD currently does not implement alternate ports
> in referrals.

I know, but the question is about the syntax in /etc/exports. The idea
is to use the same syntax for other NFSv4 server implementations (like
nfs4j) ...

For context: I have a ticket open for the ms-nfs41-client to get the
referral support with custom (non-2049) TCP ports fixed...

> It is on our enhancement request list.

Thanks... :-)

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

