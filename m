Return-Path: <linux-nfs+bounces-9220-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7805DA123E3
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 13:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B551164D3B
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 12:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7951BEF9E;
	Wed, 15 Jan 2025 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b="rTFXIt7e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from shrimp.cherry.relay.mailchannels.net (shrimp.cherry.relay.mailchannels.net [23.83.223.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104592475C7
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736944738; cv=pass; b=hRxck+vfSNKJApxSSJ77YF4ITCSEjJMP+N9mChAqs4TH0ZkZvQuuspa8+an4m6BRntpBxZS0x6bnARf/IHLdOW2KklQ2M0bkk4VL3BJ4gLLYF5JdGPI53lPoDPOB3jOMGyrYtZHF6sU7Tty7Q35vcV9S0V8/+eE8rQE5TMNVVgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736944738; c=relaxed/simple;
	bh=2ozHutiBf20o1fbs50DU188oKrzxXO2HwSOveAmioD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=NXaOcrppVSwTo0pUQrzzV9Ft73n4s0Dnn4qUpzpmhheefr1bV0mkhTX8aRueeFkCUTOSz/LtCyYXsom6HD2vBIHeILIBIzoh3iIxeT+Wu8Rfeu6PoRTzh2m/vBkAvUZTqD8BrCmoSMdnDdL5TOV+NALo6SMkIiYsQV2J8k37uKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=nrubsig.org; dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b=rTFXIt7e; arc=pass smtp.client-ip=23.83.223.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C4B8B24AB3
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 12:31:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a259.dreamhost.com (trex-7.trex.outbound.svc.cluster.local [100.109.217.76])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4EC41242CD
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 12:31:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1736944284; a=rsa-sha256;
	cv=none;
	b=0vcfjTYw97yAWjyjcI5epWc/JAWdMdO38RX52v1cmhbEU9kzI7/KWX11599J7O3/z4/GI5
	6Y9RSiEe2kWACzC+LgUGr7IpjzdQ8rw+sHqo0aTddlYQE9WWLjfnQ8NxRr7wOQd4uvcei1
	VHbBG3ByVfWuD8/Q6KOsSi1UTxRl4XXSHgFA5VTtk3LdSgMrYOEaHKWpFJqBQBvUmHdKSa
	EALQx5RVn6nADeUq7udN81EMwSYM/MCBpI2qqkistUXkqJeOVPp//Aiwxs5FlEFPh3MxCk
	Poxz6zFxzL1J49LO7CkNv4WCaDwJFPsd2HqIJgEPwEZxJUc7h/V53dEXDz5Q5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1736944284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=IA8nXJw59zgnglQP9IkSVTLTg5XToxazwu3GiYJXlMI=;
	b=l094J6sAVxCf6hSV81POUKFGocvm2ix++gQR8FAsPBznfJeLD/YZaO5wN1s2E+JFFmorIx
	h17cqwdLjLiRfzP3Y3NvcQmJ605RhFH53dzTP86S4zrq86x/HF/j1c0nY4a4bQa9TeLWHe
	hZSIXowp+Pd7OBmllxUiU3jffGHdO+t7jl+LDbJqAstm30ei9OS4JQdKAQ3KvZlOa1/KQN
	s/mRhiBsSfMMHRIcGiQ++hV9ih3v+SWt0PsZXGq3Rb1G6ncoR4MzqT/hLgVEJQAZnmWLWJ
	JER3VPBk7vJLDDdQKHeMq/xFy/YKvyxLcZ8GjyV9ms3vJfZ1U47jRDTstt7icg==
ARC-Authentication-Results: i=1;
	rspamd-b5645c5d4-g45n4;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=roland.mainz@nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|gisburn@nrubsig.org
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Trail: 08acc3284bb92e3b_1736944284530_1972896737
X-MC-Loop-Signature: 1736944284530:298954594
X-MC-Ingress-Time: 1736944284530
Received: from pdx1-sub0-mail-a259.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.217.76 (trex/7.0.2);
	Wed, 15 Jan 2025 12:31:24 +0000
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gisburn@nrubsig.org)
	by pdx1-sub0-mail-a259.dreamhost.com (Postfix) with ESMTPSA id 4YY52f1vpnzGq
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 04:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nrubsig.org;
	s=dreamhost; t=1736944282;
	bh=IA8nXJw59zgnglQP9IkSVTLTg5XToxazwu3GiYJXlMI=;
	h=From:Date:Subject:To:Content-Type:Content-Transfer-Encoding;
	b=rTFXIt7eefLd8WKhNGKxjDPUYhBJPVepIG2GxpMGE+w3pSAkqDS/X/v6QWO4MOKfH
	 rUKts7A/3k06L6F/KM+rjalutb7aXg+Hwez41hEydlevz9p53BCh0PbrptEw3H1aUE
	 5xBbyZWPH6CsH3QK2AbAbq3yliX5EZ02AANarYj4F/ejgfeEPOWv4xGq6w6DEoMvhX
	 UGkqmhtWJTslVdfcDJcfwSUJwA83oVxd8EexnssRKgN/uRR5/upUK55c24DYOzJv3j
	 aBpFx0DiYW1TmX3U0so4bUWKV8VBJDoPRmEe38dHlOM/RyGUFrN4hCTn8zuy8wh0hG
	 LL0tDBx1vsVnQ==
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so475122f8f.0
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 04:31:22 -0800 (PST)
X-Gm-Message-State: AOJu0Ywi+s03jQMOI7qmh7GooLv48fNb+JD0OEIMV+DwzNnm2ALXyBGu
	W26/kEn9E8McpSf2U2Mka2kz4d1Mk0erLaqsr0ib8A3xR3QxPbaKHxmI9K4/NxxV3ZjVyg3zwbG
	wZPnovOXINsRoevfibfpzuwqSzUI=
X-Google-Smtp-Source: AGHT+IFQzhv8V/vDot4XummhfKGKDynELxhONqOcb/nkCmGHtFxZSPkvBmZiN0VcoB4iYaVP+xxdLl1l3dGIDdfKQnA=
X-Received: by 2002:a05:6000:4712:b0:38a:8b34:76b0 with SMTP id
 ffacd0b85a97d-38a8b3476c0mr20104335f8f.27.1736944279354; Wed, 15 Jan 2025
 04:31:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
In-Reply-To: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Wed, 15 Jan 2025 13:30:52 +0100
X-Gmail-Original-Message-ID: <CAKAoaQ=WEgJGRJ8LtDw+sKMeAo3i8ppirFnkHCwpiT5NLebR5w@mail.gmail.com>
X-Gm-Features: AbW1kvbSkWBkSEmetVsxvcVoIBLRAJQLktbYg4ldt0VYBgVU10bpho1oRAHulqo
Message-ID: <CAKAoaQ=WEgJGRJ8LtDw+sKMeAo3i8ppirFnkHCwpiT5NLebR5w@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Implementing the NFS v4.2 WRITE_SAME
 operation: VFS or NFS ioctl() ?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 10:38=E2=80=AFPM Anna Schumaker
<anna.schumaker@oracle.com> wrote:
>
> I've seen a few requests for implementing the NFS v4.2 WRITE_SAME [1] ope=
ration over the last few months [2][3] to accelerate writing patterns of da=
ta on the server, so it's been in the back of my mind for a future project.=
 I'll need to write some code somewhere so NFS & NFSD can handle this reque=
st. I could keep any implementation internal to NFS / NFSD, but I'd like to=
 find out if local filesystems would find this sort of feature useful and i=
f I should put it in the VFS instead.
>
> I was thinking I could keep it simple, and model a function call based on=
 write(3) / pwrite(3) to write some pattern N times starting at either the =
file's current offset or at a user-provide offset. Something like:
>     write_pattern(int filedes, const void *pattern, size_t nbytes, size_t=
 count);
>     pwrite_pattern(int filedes, const void *pattern, size_t nbytes, size_=
t count, offset_t offset);
>
> I could then construct a WRITE_SAME call in the NFS client using this inf=
ormation. This seems "good enough" to me for what people have asked for, at=
 least as a client-side interface. It wouldn't really help the server, whic=
h would still need to do several writes in a loop to be spec-compliant with=
 writing the pattern to an offset inside the "application data block" [4] s=
tructure.
>
> But maybe I'm simplifying this too much, and others would find the additi=
onal application data block fields useful? Or should I keep it all inside N=
FS, and call it with an ioctl instead of putting it into the VFS?

API questions:
1. Can WRITE_SAME requests be split up if the adb_pattern (see
https://datatracker.ietf.org/doc/html/rfc7862#section-15.12.1) is very
large (e.g. 50MB), e.g. turn one WRITE_SAME request into two requests,
where each half request writes only 1/2 of the pattern ?

2. Is it possible to write patterns with WRITE_SAME, but skip a number
of bytes which is larger than the size of the pattern ?
Example: Repeat writing adb_pattern=3D"X" (size=3D1), start at file
position 0, and write four times at every 2nd position, e.g. turn
"abcdefghijklm"
into
"XbXdXfXhijklm"

Can the API do that ?

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

