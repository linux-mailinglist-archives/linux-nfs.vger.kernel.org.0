Return-Path: <linux-nfs+bounces-15426-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B43BF4374
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 03:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5D0F4EF9FA
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 01:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACE7220F5D;
	Tue, 21 Oct 2025 01:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf+6tmfG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1890C16CD33
	for <linux-nfs@vger.kernel.org>; Tue, 21 Oct 2025 01:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761008535; cv=none; b=RHEaC6lVqPdVhe05L6IbsVxYmpwBBxdXOjtAVal8XP5gCFa/sLuOvERzLDTYDeBnlQU2wiONILjB2HZOxr+jqz7leBhbDv3sUvsCAl9peaKy8Y+sPKQ7rMoI49bnjTY1Ue3JWmZWUtxu8DqjHfJgZzP/jhKzBK4Me1d7Rvp+8/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761008535; c=relaxed/simple;
	bh=qZLBj6arx9QOTLUUblWHZMf3JCAP1L/JUAsq+xSZU/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxypRPzonIWh7/pv+m+2D7s0Rxg4fMH5ZSSzOdyOhiAaVl6K2CAziebL83jI0XZj337gA93WL+OFSTp9LKPyTrVlEi/DtkyLAwNorZOlnMRzPw7GIbHwVWbealeBSsJQpxIOrUMmQgkB3M7c4pFvbGrrI3eVb8Ep5CbO5EgkYrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sf+6tmfG; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso884033666b.0
        for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 18:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761008531; x=1761613331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdrgppHkZAyxxVFGpYMxDncigVmTn7Xgn5GmJmM4fFM=;
        b=Sf+6tmfGpZDcI/M0c62kkU5qeaG/2FJJK5UAolk3tRNhBAOm9fD7xllxZXs93aSczH
         2DXzyVC6B75L7qaLqaqGSQSQ+gUXPllOtdPnS/BmxAccVCAa8WGt4D1l8vGuBXuiKdD+
         q5vbFhUvD1i8N52HiSj4F1TYmGeSlghHKiPMjDBdMMz50l4SoFnCOKfrNi0ZvSQ10nWQ
         dtw1kZ9GDeDIB7BIu+PRZXnxzALM/JhTUzSr6ohNGGhlVRxhercxLD8zeCKLqBI+zNTJ
         xCQwgAMz3szZQawuYe+Q8U6er4lCpu8VNS9mVGECfAw6ImjZOi1I9xox//02avtmC9fD
         e3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761008531; x=1761613331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdrgppHkZAyxxVFGpYMxDncigVmTn7Xgn5GmJmM4fFM=;
        b=IHjwUMtbz1pO1YKbq0uDJnF4NGPK2Lz1H5ihLrFPBzw+3q6kwE65upKHGM7py3Cn2j
         ADm6gGDiG+zv8Qp1WqODbfklt+KV8Qp+7Cck/LIPont4WCBJbznkB8LkmgqtZ0O5r9e6
         5kxklA4RU0paj9EcImb+ckvtcEgehF9qLzJ7BkJZF1mVqu7SXJpd5P5SZwvy8DAKXiUN
         vxV6FJFVcUuf5HoNLAWNPTWUdVRlWReIJ10TpyRWjnF/fff9cC0pDf4mW+aM/9JdW+6T
         jrTx6MpifWOE9Pajs505xggFDr2jODnJR38Ep5jp33Th+IVe1D1UPXddBpzRnS5WBzNG
         Q0oA==
X-Forwarded-Encrypted: i=1; AJvYcCVEDJu0EIS46ymTHTU29zU3HFBrkz67wcaFA2ijTxWKV7OikiAhhmkDL/2EpQqZY2z8Jztl1UK7gfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAhPYV4NDdjDCt5grMhNX75v52yheOIHoJwfMRkuEIQvNBRAnX
	uCgHbk/2rdBC7pPUuJeHh7Gr8mjGSniUzH+9j9emHH6G9qX6Q5VCrdSiVUASc9YOFsa6z8lTLL8
	VnlZaAu6aXLiq3BoNX5nvT7j1gnRn0ws=
X-Gm-Gg: ASbGncspEzeY8+yEB4B2oHo7UGeT6D+3ou2kLR3OLWQFGPrwyMbX+U69tNiE9ELDP2Z
	jwpn1p+9DCBHcqp+YYnztPC+vAnETd1hDrTq210Xn6nrfpbfHyr5d7kjSsz/0TeEpa6xcNEud2v
	hKqPmbo1c9vGaHvvKkG4nmMFuIbFrGoZBjx2TJ8BVqZqHRJgddQ0B4IWnZDqKwv8udd7Tg2Gtg2
	H2QmyYQk1CkxDTMOuBBIOnXTkjP1gfSIurtj9ph2bMjKsHh7mQ6b6puPTQW4LUz/UQRfKfd4Z9G
	mHO+j4nABGIHIio=
X-Google-Smtp-Source: AGHT+IEKUvPReN1WIc8WWqIkjL1j43sIvxC4HgtgT3kVUG9Iyo7fRBo0aTHcqpyZOi9DM/GsvtqbZf+qS2DkcF9tE4g=
X-Received: by 2002:a17:907:a07:b0:b3b:f19:ac7c with SMTP id
 a640c23a62f3a-b647443cef7mr1691282766b.36.1761008531342; Mon, 20 Oct 2025
 18:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017042312.1271322-1-alistair.francis@wdc.com> <fe16288e-e3f2-4de3-838e-181bbb0ce3ee@suse.de>
In-Reply-To: <fe16288e-e3f2-4de3-838e-181bbb0ce3ee@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Oct 2025 11:01:45 +1000
X-Gm-Features: AS18NWDiepjJ-jRwTWQwDakRt00NDvcpR1iprtqV_ILiMUcAXQFVJU3hWPRHcZA
Message-ID: <CAKmqyKP0eB_WTZtMqtaNELPE4Bs9Ln-0U+_Oqk8fuJXTay_DPg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] nvme-tcp: Support receiving KeyUpdate requests
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 3:46=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 10/17/25 06:23, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > The TLS 1.3 specification allows the TLS client or server to send a
> > KeyUpdate. This is generally used when the sequence is about to
> > overflow or after a certain amount of bytes have been encrypted.
> >
> > The TLS spec doesn't mandate the conditions though, so a KeyUpdate
> > can be sent by the TLS client or server at any time. This includes
> > when running NVMe-OF over a TLS 1.3 connection.
> >
> > As such Linux should be able to handle a KeyUpdate event, as the
> > other NVMe side could initiate a KeyUpdate.
> >
> > Upcoming WD NVMe-TCP hardware controllers implement TLS support
> > and send KeyUpdate requests.
> >
> > This series builds on top of the existing TLS EKEYEXPIRED work,
> > which already detects a KeyUpdate request. We can now pass that
> > information up to the NVMe layer (target and host) and then pass
> > it up to userspace.
> >
> > Userspace (ktls-utils) will need to save the connection state
> > in the keyring during the initial handshake. The kernel then
> > provides the key serial back to userspace when handling a
> > KeyUpdate. Userspace can use this to restore the connection
> > information and then update the keys, this final process
> > is similar to the initial handshake.
> >
>
> I am rather sceptical at the current tlshd implementation.
> At which place do you update the sending keys?

The sending keys are updated as part of gnutls_session_key_update().

gnutls_session_key_update() calls update_sending_key() which updates
the sending keys.

The idea is that when the sequence number is about to overflow the
kernel will request userspace to update the sending keys via the
HANDSHAKE_KEY_UPDATE_TYPE_SEND key_update_type. Userspace updates the
keys and initiates a KeyUpdate.

> I'm only seeing a call to 'gnutls_handhake_update_receiving_key()'.
>
> But I haven't found the matching function
> 'gnutls_handshake_update_sending_key()' in current gnutls.
> So how does updating of the sending keys work?

gnutls_session_key_update() calls update_sending_key() which updates
the sending keys.

When updating the sending keys we want to send a KeyUpdate request,
which is why it's a different flow.

Alistair

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

