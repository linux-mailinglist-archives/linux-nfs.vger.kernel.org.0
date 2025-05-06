Return-Path: <linux-nfs+bounces-11481-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 737BFAAC0EA
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 12:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E017416DA5E
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 10:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22BE2472A6;
	Tue,  6 May 2025 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b="SFiyeawu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from aye.elm.relay.mailchannels.net (aye.elm.relay.mailchannels.net [23.83.212.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5361A9B48
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746526065; cv=pass; b=p+ExvfUewPYblwnNKNPwZhQ/YyTZ/DKKnl2OnnlV3ZNRXgIHq99ONnORpNrOhOsG+ofoSvVZ+aDYdMiGnV70vyOlXgQ1rGgv1A1f+7dNoBDjMKYjBR+lxXAzd9wX25N+EQnOwnOrX3Suo9v/QJ531AA1fe5vmZkWnwdfqphWSCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746526065; c=relaxed/simple;
	bh=JHu+NcIUA9xd7GCeKqLbKRiOIgHbZOrqYgr9R69UO1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=qY4VlL/k2n4jfpRciHDfQMqOKqvr523FhWemjA/K9rOFNyRuXkHvA89HFrDjVgZv0TIKh1erjrYv+SBoJBkj5ky6k6O2qqReqjT09YdiVeGY9pL6iuiVGSPYNS6nyawqJGCUt0KzoShHaS/f43i3ZKOPEnKnAeTRmQW4WcDlwCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=nrubsig.org; dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b=SFiyeawu; arc=pass smtp.client-ip=23.83.212.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6A1921A537A
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 09:32:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a258.dreamhost.com (trex-8.trex.outbound.svc.cluster.local [100.117.24.235])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 186E71A5A73
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 09:32:35 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1746523955; a=rsa-sha256;
	cv=none;
	b=togT9oZf0SwPDNAMc2J1Hia2H52DkB5PtMq9cxjNVQUdn8vjvWeqs4AyFSUkgN5g9dbfOc
	ljYeqZpbLg0+W71DZJP6Ou98mGURezZmlKtoyLeWsNGvI3g5itw3iQJhIESyG4mokbI3xF
	T47pdSdZxu/5rhAaTFYFZKNBKYNbBqWsT5ngGc2WEhhH+90p3y/Y9sr5goTQX3K6ONsvne
	qO8yMvneZUndV5vYeE8i/TSS0DYAodQfVVyj9iocBeyL7QNQMywAXZkymTXwnfO8+pcWw7
	k/E6LoprTCQ+8ehLi6NipVmUX0OMAYXP0S+66OrPzfim440yMfUyXpwCwI7snw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1746523955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=UTI7q2Cz8dtKtJmD0m9vLMw1kNK+c4u5WTcol3fTtzY=;
	b=UTx5fRLgY8FcjYd+vyoxo5OoD7RsQwkiPRQPiObYxtIB8lX61KrpvN/FW3Ppje0dyOwd9y
	tGo/D/wU5qmAgKZKGtDa2lPR4tmIm7ESLi47N6FCAzb/Gh9zyyoa2kFj5YAK1M0jv79n17
	BB38wykumJ9l/kTiOAUx42Ak1L/NUzfKKdvpSdGAfpkqAzlJOcd1UhJErdaiDRpUlkJW4B
	IXqeL5cmHMqqMmw80nnJsFTkprFnpvssApNdmLaWOnhAx9FlFLO6YenYxVO5shOGbuvHeN
	SXT98vC6aQN5HpMrOVICBdP0Qx/X2Xnn7pxj3cAofwuIPyoyIkBa4/MDeZDZ8Q==
ARC-Authentication-Results: i=1;
	rspamd-6954bcdf67-nrc8d;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=roland.mainz@nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|gisburn@nrubsig.org
X-MailChannels-Auth-Id: dreamhost
X-Coil-Little: 4237ee3327057e77_1746523955299_665108045
X-MC-Loop-Signature: 1746523955299:3250285548
X-MC-Ingress-Time: 1746523955299
Received: from pdx1-sub0-mail-a258.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.24.235 (trex/7.0.3);
	Tue, 06 May 2025 09:32:35 +0000
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gisburn@nrubsig.org)
	by pdx1-sub0-mail-a258.dreamhost.com (Postfix) with ESMTPSA id 4ZsCq66sqQzMy
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 02:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nrubsig.org;
	s=dreamhost; t=1746523954;
	bh=UTI7q2Cz8dtKtJmD0m9vLMw1kNK+c4u5WTcol3fTtzY=;
	h=From:Date:Subject:To:Content-Type:Content-Transfer-Encoding;
	b=SFiyeawudVIl95nyPQB8aBFw6w1y5/jW83lcZg5ChUFdmVJMeh7cuhiA5UjIhIKJQ
	 pynlCCods1LSmoHIQ+GiOxcF9fhpg7eF3MkZiBD8uviSwLtj/zefrJ8x/XULK7LJA2
	 eCKcMcVf8/HCf3N51osfSy0pf7gkIJ/YgZudV1ouU/Jo2MRDg2dt2ql+LyTNGwbHfp
	 36GdzoQGuEuxpMSDacJ0gnxHBPGDzReP5ga/OV5dgluOJookMCcTQ2+tsvw/mAYE2Y
	 lGs/r6cHk1VzOLB4meeBO9/YO4m6bqm5RJHVNSIlZlrCT2cmXoyMyZVx1ZzCR9cu5J
	 Ea2iKk4c8zL5Q==
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso5777157f8f.0
        for <linux-nfs@vger.kernel.org>; Tue, 06 May 2025 02:32:34 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz5ascJCKp9ko6h3J5zdTLLQDBkcuD2LW8nm9+zUGATVGj9dEc6
	yYdobWuuPJh579TODOfA16lOqnIj60QURLSYhBEpVw1kFcKX7TvR6WJqt0gj3sEMlXGQ85ZuBIZ
	IBxAx4+WrfyC/3AgvFXJDHAFW6uk=
X-Google-Smtp-Source: AGHT+IGmtZaYlpPCW87l9n4j7nZqGvfqsmFgMjiduDhFlWK3lS0/U5d19D+4BO1qSebny6cPFryRcmcXGgyi1jvQiUs=
X-Received: by 2002:adf:ed82:0:b0:3a0:ac5a:61c8 with SMTP id
 ffacd0b85a97d-3a0ac5a6513mr1379288f8f.5.1746523953682; Tue, 06 May 2025
 02:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250427163914.5053-1-cel@kernel.org> <aBnD6Wj1yq9MP8ZB@infradead.org>
In-Reply-To: <aBnD6Wj1yq9MP8ZB@infradead.org>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Tue, 6 May 2025 11:31:56 +0200
X-Gmail-Original-Message-ID: <CAKAoaQn+E_6z4KK_1nfWuf1FQKGY-jKJt+XiNgFW4JUGaQb2ZQ@mail.gmail.com>
X-Gm-Features: ATxdqUH5PmH8xEVphB1N_FNdXd4ii7pxlvL8S6YjB27hXQyNpQglM-ZJStbbNZ8
Message-ID: <CAKAoaQn+E_6z4KK_1nfWuf1FQKGY-jKJt+XiNgFW4JUGaQb2ZQ@mail.gmail.com>
Subject: Re: [PATCH] NFSD: Implement FATTR4_CLONE_BLKSIZE attribute
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 10:10=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
> On Sun, Apr 27, 2025 at 12:39:14PM -0400, cel@kernel.org wrote:
> > NFSD can return 0 here, as at least one client implementation we
> > are aware of (the Linux NFS client) treats 0 as meaning "CLONE has
> > no alignment restrictions".
>
> Usuaully clone does have a restriction, though.
>
> > Meanwhile we need to consult the nfsv4 Working Group to clarify the
> > meaning and use of the value of this attribute.
>
> Yeah, the attribute seems to be severly underspecified, i.e. it does
> not even provide a unit that the value is in.

My preference would be that it counts in bytes, basically the same
what the Windows API |FSCTL_DUPLICATE_EXTENTS_TO_FILE| (see
https://learn.microsoft.com/en-us/windows/win32/api/winioctl/ni-winioctl-fs=
ctl_duplicate_extents_to_file)
does.

> I think the only sane way out is an errate that makes 0 mean
> "not specified" and then provides the byte unit and maybe some
> other quirks.

I agree, Technically not even an "errata", it's just logic... :-)

FATTR4_CLONE_BLKSIZE=3D=3D0 ----> no info
FATTR4_CLONE_BLKSIZE=3D=3D1 ----> no alignment restrictions
FATTR4_CLONE_BLKSIZE>1 ----> use this alignment value

One thing to consider would be to make |FATTR4_CLONE_BLKSIZE|
perr-filesystem *AND* per-file, since modern filesystems may have a
per-file *preferred* block size.

> > +     /* Linux filesystems have no clone alignment restrictions */
>
> That is absolutely untrue as said above.

FYI I've implemented Win32 |FSCTL_DUPLICATE_EXTENTS_TO_FILE| support
in the Windows ms-nfs41-client NFSv4.2 driver via NFS CLONE, and so
far didn't hit any alignment restrictions with Linux 6.6 exporting a
btrfs filesystem...

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

