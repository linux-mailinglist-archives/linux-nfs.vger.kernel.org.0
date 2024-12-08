Return-Path: <linux-nfs+bounces-8425-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1402C9E842A
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 08:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7791884747
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 07:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBDA13AD22;
	Sun,  8 Dec 2024 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/r9as2P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C095237160
	for <linux-nfs@vger.kernel.org>; Sun,  8 Dec 2024 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733643733; cv=none; b=Ed41169Fu/BbMR/pX8v6V85TiYtyhWBIRMZtLBWVtOnjCX5iw6G+cWkmtjiEnfxdp5YBAYkObtfvWJZ7/J0aNyv8M9sfTZ9Xq+4mEn4ABdq3mjT2/y8/vSW1i7t5KsL261/QADI65UvfmpZJtyC7mRbsKXmpRnudSCOCbw88ViA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733643733; c=relaxed/simple;
	bh=LCCrNJocttKiQ+ep4WiLJXZowlzulMpgwEaZLM48mso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=R53uOr7xdBNV9Sxt4ap68UL3qNAqRM3lcqmqnj7uYzZJUUfP1pqMZXgYyBeCNK81aF5sXiTwTVqTHfiAPlOToU4R6gYsQnVwuOnQJAyDHLh1XzLbXyKVrYEeu/9av11vPbNiRnPIOIRc/rYV8G+eExf6yt0CaP842UYzpSwTqHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/r9as2P; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so6122106a12.0
        for <linux-nfs@vger.kernel.org>; Sat, 07 Dec 2024 23:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733643729; x=1734248529; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCCrNJocttKiQ+ep4WiLJXZowlzulMpgwEaZLM48mso=;
        b=l/r9as2PRqvJ//r75lmC4xmLgRJFNARjFN8Mm75RDNXBr0/BIduEBCsmR5K/VGcALQ
         QLnL0IqOns1wTqQpt7GTR/rKqWuPCEYmX/FbVChv2+q67HBGEaj6THLAhyixtqfk5O/y
         2nex9PmnHFzP4BsE870OPP1NmruEfeczD7jMsesxhKV59BIpqdFZEgbzi8veMIi1ibXq
         Xgx2EpND/KUHAIaAMB+UHRIGPSb9AsRaZma3yQseI9M5ZcjUw+/b+GLVBflorW6vhHY9
         qiZtoKflUYuCx3tJM5Gol6M5W2DQTEi6sWA2y20R+BjkhfHzOMNfrtJjS5G76Hqqccda
         BjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733643729; x=1734248529;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCCrNJocttKiQ+ep4WiLJXZowlzulMpgwEaZLM48mso=;
        b=Uf2cRjFhZfee6sI46xo0iPoZLzmlqKVSAfTqCBWuFUm71mhdK8Jhuyl3IiVpor4rGt
         5IguXMiJtI4YMEm1gELSVDS54b2B9Gjq1nN/576s2HDni8QXamelYnveN0TW1ZjbBzq9
         ZOV7xHU0WROJlLb8v6gqpoT3x0WxzNJ/wxtCEOYCH3kwoCvWWEE34mjl8WPegI2PMt5g
         hm086DLpVyW2cosL/Rd0wwuVtTd0wLI1DTI/C6PyISq7IawFQJXJkwZfDK/sk9XDdd3z
         +mwQ1zfGh1iq47tVQuFS7D91izJc1yygdHvqGMfewhBxo4dvbIntptSidYjqkT3FmHKP
         VM+A==
X-Gm-Message-State: AOJu0Yx3RL0t0SfFct/BiyCnQu1jz+Ml/HF2nO7WAsgAfe/m1q3BWB0e
	tHaHw27ek4B3mce3wEHyoKuKwv8DF9TJRmi3agVg6DrUmYrHeVBa14DMYzf8IQZK/TaakStI4io
	3B8jNSQlocLwiJaAIVLoM/9loMMyTQAZpL3I=
X-Gm-Gg: ASbGncs03Cyw2Z8A8bBgTDiIJPgT8I530PmOc56kAzjMTI7L3KfsWSYtw35LQZQDhF4
	ULHLnZKsp8yMxc6gXK2lG8ipeuyME67Q=
X-Google-Smtp-Source: AGHT+IHXbLcXFecRtiMTjRb/h6/ujZy83jcliS5PjmyqDci/xZnwJlnKEgS6VZKvZYmVhMdG0k6wZxx8o/uz4J8zpQo=
X-Received: by 2002:a05:6402:26c4:b0:5d3:f041:140e with SMTP id
 4fb4d7f45d1cf-5d3f041190bmr1331139a12.13.1733643729192; Sat, 07 Dec 2024
 23:42:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
 <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com>
In-Reply-To: <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Sun, 8 Dec 2024 08:41:00 +0100
Message-ID: <CALXu0UfT-M37mTF52BPP+cuFAi+gya=XeyerJgAzqXSs7Lmwcw@mail.gmail.com>
Subject: Re: [patch] mount.nfs: Add support for nfs://-URLs ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Dec 2024 at 16:54, Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Hi Roland, thanks for posting.
>
> Here are some initial review comments to get the ball rolling.
>
>
> On 12/6/24 5:54 AM, Roland Mainz wrote:
> > Hi!
> >
> > ----
> >
> > Below (and also available at https://nrubsig.kpaste.net/b37) is a
> > patch which adds support for nfs://-URLs in mount.nfs4, as alternative
> > to the traditional hostname:/path+-o port=3D<tcp-port> notation.
> >
> > * Main advantages are:
> > - Single-line notation with the familiar URL syntax, which includes
> > hostname, path *AND* TCP port number (last one is a common generator
> > of *PAIN* with ISPs) in ONE string
> > - Support for non-ASCII mount points, e.g. paths with CJKV (Chinese,
>
> s/mount points/export paths
>
> (When/if you need to repost, you should move this introductory text into
> a cover letter.)
>
>
> > Japanese, ...) characters, which is typically a big problem if you try
> > to transfer such mount point information across email/chat/clipboard
> > etc., which tends to mangle such characters to death (e.g.
> > transliteration, adding of ZWSP or just '?').
> > - URL parameters are supported, providing support for future extensions
>
> IMO, any support for URL parameters should be dropped from this
> patch and then added later when we know what the parameters look
> like. Generally, we avoid adding extra code until we have actual
> use cases. Keeps things simple and reduces technical debt and dead
> code.
>

I think the minimum support Roland added (or what is left of it)
should remain. It covers read-only ("ro=3D1") and read-write ("rw=3D1")
attributes, which are clearly a property of the exported path.
exportfs -U generates nfs URLs with "?ro=3D1" for read-only exports, and
mount.nfs4 should treat such urls as the standard mandates, and not
either drop an attribute (which is a violation of rfc 1738) or reject
a mount request because support for "ro" parameter was dropped in this
patch.

...
> I wonder how distributions will test the ability to mount
> percent-escaped path names, though. Maybe not upstream's problem.

perl -MURI::Escape -e 'print URI::Escape::uri_escape($ARGV[0]) ; print
"\n"' "money_=E2=82=AC"
money_%E2%82%AC

I don't see that as a problem.
Roland also has a patch for exportfs to add nfs url output with -U

>
> > - This feature will not be provided for NFSv3
>
> Why shouldn't mount.nfs also support using an NFS URL to mount an
> NFSv3-only server? Isn't this simply a matter of letting mount.nfs
> negotiate down to NFSv3 if needed?

NFSv3 is obsolete. Redhat support keeps telling us that for almost ten
years now.

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

