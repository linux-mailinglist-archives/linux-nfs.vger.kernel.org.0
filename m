Return-Path: <linux-nfs+bounces-21580-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BpzpKo2xA2ql9AEAu9opvQ
	(envelope-from <linux-nfs+bounces-21580-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 01:02:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4E752B2A3
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 01:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D90143042943
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 23:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535F7342524;
	Tue, 12 May 2026 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFh31unI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF6F3EDE6B
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778626953; cv=pass; b=es8E8Ab5SHzHFAi68/pps8OCDE7EsGvvCRpC5cNVTSwgk6q8b0+XbKBFvlOtj6od+HkmNIdPSAYAZZT93kx/NHxJ9fhXYXcMUR+/210/YSQN25IG99k6U7L8Znu+PF3GJ0OvzwFUhaTReS8pBjIzQQeqXHUPRRxAOWBnmva9v2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778626953; c=relaxed/simple;
	bh=HoNxRNlsxI1FC4FXfFgcmaYznbNssV8oHmGwTnmulr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7LG5z94gt+ztYuXpk4+5NKsZHlxTM9UWn5Eas9RbJzyj9sMa/7kOYqzBGsy7lMPNQQDTaCgu5Mpt3fnyOgAf1mqguLaFcSihIc+5aheAWo2aA0gMjpFc3B2Y9lI9w162gckHe8FiD5vxCHsT+zoJuiVVEeX7mdiZ1aATYMHwqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFh31unI; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67cd93d8affso7445686a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 16:02:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778626950; cv=none;
        d=google.com; s=arc-20240605;
        b=E2mzQNOFiYqd4HoHQuSLilTkuU5DlKyqKsRreNJcpRykjiPwFfktKxfSnYTnqpZgXu
         kbwTtFOtif5k7lUlB2daYQPGnOMwG172famDXJ0NyKQ1rDsCw5ZlR1nCQt/CE59s6WnZ
         9MMulVooZTJNC8XLGMhI30P+ZKhMjbz7fh7JEhXjwBwD/w7POgBc5QTk3TPc7E+DA1oK
         G4tA9cfMSjLpB/u/Zz09lzyt98Y1qtNH/+5avrxUY1eYLgARRVQl8HMtYUMhihHxWDxK
         nFLiLXbIoJpP5fqDMpfQC4Fvkhnkdr3lwK4sMcG+bVoSA+uO82IZDVBGyETsQuUtpmBa
         /Lkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bNY9SCIbNLAVH9vwRR1PgmY6IO7bRgmo5mWrYhHNtAY=;
        fh=iQLWJSAzkdE8z4/OfiugcK7BClbYLsXXzhWnN6eRP8s=;
        b=eZVX8mJA/lwFQLRSBAwVdYKc0kKG3vszfKs8LdH/mIlyWOO02mrfHhKki1Px2JoPWe
         +/jmKlOg8ORChje1XumutveL5Phz8OO/kfPtaouF6lSmNL+dDKbQkPRihwhuohmxJ684
         VellMfQApfIC9Itv9/z5bOO4OzPVF6CGPbcO1mMZVgS3/vfN0rW0Niw4zNu3rHSzVqDH
         3vCEFxMQ0ljPAr3I0zyboJ8nOkHL8Huo0RvEH9fU2setMFG+NXS/zm4gqosysW733Xf6
         ZdzwUNHw95b1PHYJ0IgmcpUmGE3v6G2gPThEFhhez4HFGCchwPfOptL+kTYNW/Y/pSJ6
         6YQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778626950; x=1779231750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNY9SCIbNLAVH9vwRR1PgmY6IO7bRgmo5mWrYhHNtAY=;
        b=eFh31unI6PH0zHnIWkf89n5D+qkv7wTnr7vZXWSpehiumaZaj7G427dH+UTBdQ13Ti
         RfxJa/zRNaNIl30ybMzdFaH4X94b97XRqXTOLGcAsXYylfI1OBLRHIDqXZ+12wM8+nFX
         iEIjf47/4WjqI2oRVdUCsCw/XuayHrY+TiWqibef0PXWKalW1wibtcivyGML2fTy6Q3F
         muu1EOgkn+d+ZrmCxQ1YTvBX8cHzLXZg+HVU4s3CvOnDnNbSfU2/ChHjEeCetecnotTq
         irVdRd+7ET3Rm3/Lf2j2cOmDVUcSvojSjZvgv1Zts0cwY7CA7Sivq91UfV/FGqceAFVT
         O6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778626950; x=1779231750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bNY9SCIbNLAVH9vwRR1PgmY6IO7bRgmo5mWrYhHNtAY=;
        b=rRYf43trDExvvPGIvgzuEAi42inqRSiQLUTvRP/ojLwQOYIm7N3jGi2o2e2C1WBFby
         Gl/h+BVHC91rVQLEcN/EP/Pi0C2f2asp69gROBFqyN6QOHsH6tJu7R/jr6gh3GZPz3il
         98z5dZv9Tu3IZJGS2EOIjdFRF2tgOCrJa0/yortAXF5o5HllrhOTDrDFREGHytUA/7i+
         TmmJSfIM5fTTxZYlG/lr/NVtbb56bEjFd8CEQJe+CivlWz972soXA/1lgSB9u2tz/RYB
         XmZXoxmPQHpjW3S5qp0MUfip4oNpWAtlGS49Vc5Q7RxQ6KwW1G9OSCPAMbhgClsfFdDl
         PakQ==
X-Gm-Message-State: AOJu0YwXfBGvU0jzYHB1lBkITxWc09P5abV26wyxLrncG7D7sf58J8o7
	GB5uVMyqKSWruuENB6lXNiKZ1H1vtjK82YtSMMrEhQfI+UlN+etH9SXW4IHjWkcGEx5IszlvZdI
	4AHpD7S3W72i6BT/2laVnGDEydgr4e+e4
X-Gm-Gg: Acq92OGYX3yWewRPkfIBZwcsrGGyqVefmHRo9IPJScMshwVDmbpQOMY8cD2fTH4TI8P
	QoS+Ytid88GJtVRpfENIGH8Af7fLUF9wimnAat9zhu1dBeK0USi6KIYjUn8+wp+eG/0kCF53LTe
	nvTYYHoCuK/lheAZoQvBZyiRmfkwRbUIi9pv3MYlcKqLk9P+g89RYSey/HGSIOkR/B6xzMYFMsX
	kDFRleSEKE3ZINFQTs1J5LsHy0Xm2TRayQqO6MKhQK1xRGxqyq0MCXc22bLH6DA+2PKHLrlwH2C
	XNS1rvizoaIV89Z5N21DcUrJSZCiIqeXnB6TzThV
X-Received: by 2002:a05:6402:428f:b0:671:c31a:575a with SMTP id
 4fb4d7f45d1cf-682a792084fmr86413a12.23.1778626949869; Tue, 12 May 2026
 16:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UdOR8mVr=8pwNP95FnOsOk1w1A2=DcayKk3YnDfS+PzUA@mail.gmail.com>
 <5acaa8e7-0691-4cbd-b501-c26831a7be81@app.fastmail.com> <CAM5tNy7GG0awNYYJWv0968e5CMoUstr0GcrNwuNKP4x3Yrp3JQ@mail.gmail.com>
 <CALXu0UckL3YYXVLz5Qn0shoZ+TU8uOxRy2FCpL5mAhLniinJyg@mail.gmail.com>
In-Reply-To: <CALXu0UckL3YYXVLz5Qn0shoZ+TU8uOxRy2FCpL5mAhLniinJyg@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 12 May 2026 16:02:16 -0700
X-Gm-Features: AVHnY4JYIwb2ftdKoUw_Jke9Zwp9wMsVnR2O1v_mDesYKm4hcfov_4QqSIkelVo
Message-ID: <CAM5tNy76P-1Q2EhJ4zXUtc=EwRYgke8ZqJEYvM=sRyY77rxHLA@mail.gmail.com>
Subject: Re: Increase FreeBSD NFSv4 nfsd buffer size? Re: Increase default
 NFSv4 server size "max_block_size" to 4MB
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, freebsd-hackers@freebsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1F4E752B2A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21580-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rickmacklem@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 6:18=E2=80=AFAM Cedric Blancher
<cedric.blancher@gmail.com> wrote:
>
> On Tue, 17 Mar 2026 at 00:35, Rick Macklem <rick.macklem@gmail.com> wrote=
:
> >
> > On Mon, Mar 16, 2026 at 5:41=E2=80=AFAM Chuck Lever <cel@kernel.org> wr=
ote:
> > >
> > >
> > > On Mon, Mar 16, 2026, at 3:51 AM, Cedric Blancher wrote:
> > > > As debated a while ago, can the default NFSv4 server size for
> > > > "max_block_size" be increased to 4MB, please?
> > >
> > > There is an administrative setting to raise this limit for
> > > recent versions of the kernel. Can you report your experience
> > > when you raise the limit? Hiccups, performance issues, etc? I
> > > would kind of like this exercise to be data-driven.
> > >
> > > What is still unknown to me is which NFS client implementations
> > > can support 4MB or 8MB. Without client support, an increase in
> > > the default in NFSD doesn't mean anything. Rick, Anna, Roland?
> > Although it has not seen much testing, it is possible to do a > 1Mbyte =
NFSv4
> > mount in FreeBSD.
> > For a 2Mbyte mount, (the only size > 1Mbyte I've tried) the settings wo=
uld be..
> > In /boot/loader.conf
> > kern.maxphys=3D2097152
> > vfs.maxbcachebuf=3D2097152
> >
> > and in /etc/sysctl.conf
> > kern.ipc.maxsockbuf=3D9455616
> >
> > Then a mount will use 2Mbytes if the server supports it.
>
> How can I verify that the FreeBSD NFSv4 nfsd now uses 2M for NFS buffers?
The default is 128K. (You can see what it is via "sysctl vfs.nfsd.srvmaxio"=
.)

With "main", you can increase that up to 4M by putting
nfs_server_maxio=3DN (where N can be up to 4194304 for "main" and 1048576 f=
or 15)
- adding an entry in /etc/sysctl.conf for a larger value for kern.ipc.maxso=
ckbuf
  (It will tell you the recommended minimum setting if you boot after
   putting nfs_server_maxio=3DN in /etc/rc.conf.)

rick

>
> Ced
> --
> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur

