Return-Path: <linux-nfs+bounces-36-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E837F5451
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Nov 2023 00:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6FAA1C203B7
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Nov 2023 23:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E6F1D559;
	Wed, 22 Nov 2023 23:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWYY1L0x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2521AB
	for <linux-nfs@vger.kernel.org>; Wed, 22 Nov 2023 15:10:59 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-544455a4b56so422585a12.1
        for <linux-nfs@vger.kernel.org>; Wed, 22 Nov 2023 15:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700694657; x=1701299457; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umYZG4o4asl5GTSKUOet+bFf4MSEtCJAXeDIEtwaNTU=;
        b=RWYY1L0xcEZXYkKRaSPeFD4KvqFFuobhvvs9cMC2vjZvqXRYwrpomKLU4LgYj9gSQm
         xJaKWPnDcu1eKTtMaFLwl0YZucEz4TWODYtNNGPpjscOa9Bv+uUK8gtRtuZt/ooIHKbK
         C155NpKJNrrBiGuhbTksHAOVCGWYdR9/gewqIyGEUAxmaCEnIU2U7Tnnm3zSVUCoUxnU
         Ew9lXiiVz8fJqH9Bh6zPwVhoblZSWSLCm+8xFITGMlFMZPEakwd+O0JxKe6VOh0XqOTS
         ArW2TA+rFNkY6atYYIpRr4/VTYv3/6XRN/L7HMzofOtESIn8Vgtp8oU/mewJQE77xOmL
         9fAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700694657; x=1701299457;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umYZG4o4asl5GTSKUOet+bFf4MSEtCJAXeDIEtwaNTU=;
        b=LDZ88Fp+AHkRuqt9rJqFUAyAef8OM+ExkBKStLG78ybPBJbW56tANB3VxCsn1Q9KQ8
         h4tw7eJRzs+QkVbQjDY9INqUXnsKyPy/ASs4w68Pnj5DI9KqGqcIVzG3BdGpiuSV210s
         cfAyQ+ZsfekrD7CewhLt8QZft5rwqDCcFyDr7gP82mpBBhLLkweJeKIwt8Oks4rkRDF9
         B/x2DPNBiOmF9IG5FxfmyS57YG2qEF88wQ35NwNMx0ZzucgbzgCXXKPd1Us/HBkGyghM
         w4E9kAhd+dR9Lz3Gw9+TnkK1lzmGQzRbbA9a4yewIQm/HLsI/7MpE4baFK/GRRFummN6
         nYOg==
X-Gm-Message-State: AOJu0YyewCX/JTclePQ5OLev6ZS4CcfxDcUo1XStwADw+a+PTemh14Ny
	e+6myvgtSI8BxhIVzOa4k5aE9M7mE7S34hW8phw9ejxd87E=
X-Google-Smtp-Source: AGHT+IGRvHdydVHUD+P2B0LoTwpfBDCK7hlOE6TJyBcJLzTZ51mJm4PqtsmS9Xtd1RifpfsM2Hb/Xfd/vTHC8NQNgZc=
X-Received: by 2002:a50:ef05:0:b0:53e:4762:9373 with SMTP id
 m5-20020a50ef05000000b0053e47629373mr2857726eds.18.1700694657343; Wed, 22 Nov
 2023 15:10:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0Uc7zHasg2damr4nhRZZF7xBbFc0ghdjop87+5vHa8bBHg@mail.gmail.com>
 <CAN-5tyFBZibge52iZtjnz5j6S2GrTXTWdzaDxLVQcr+G8HegvQ@mail.gmail.com>
 <CALXu0UfiCrcDciLX5A1tvG0DiPwAXPg=GikPakKW16UhZ4X-Nw@mail.gmail.com> <d18ee0e1-c52d-48af-acc0-366bd27764c1@oracle.com>
In-Reply-To: <d18ee0e1-c52d-48af-acc0-366bd27764c1@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Thu, 23 Nov 2023 00:10:21 +0100
Message-ID: <CALXu0Ucy4qK1T9-WMssYaxSvhSBSyyxiwP2sjLgMD_wXQs43Qw@mail.gmail.com>
Subject: Re: TCP_KEEPALIVE for Linux NFS client?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Nov 2023 at 00:03, Calum Mackay <calum.mackay@oracle.com> wrote:
>
> hi Ced,
>
> On 22/11/2023 10:48 pm, Cedric Blancher wrote:
> > On Mon, 20 Nov 2023 at 03:57, Olga Kornievskaia <aglo@umich.edu> wrote:
> >>
> >> Hi Ced,
> >>
> >> Why do you think it doesn't use it? Have you looked at a network trace
> >> of an idle connection? I seem to recall seeing keep-alive being used.
> >
> > Well, I don't see a setsockopt(TCP_KEEPALIVE) in the libtirpc code?
>
> We have this, in the kernel RPC code:
>
>         https://elixir.bootlin.com/linux/latest/source/net/sunrpc/xprtsoc=
k.c#L2257
>
> which might be it.

Yay, But how does the kernel get the fd from libtirpc?

Also, how can I turn this:

/* TCP Keepalive options */
sock_set_keepalive(sock->sk);
tcp_sock_set_keepidle(sock->sk, keepidle);
tcp_sock_set_keepintvl(sock->sk, keepidle);
tcp_sock_set_keepcnt(sock->sk, keepcnt);

/* TCP user timeout (see RFC5482) */
tcp_sock_set_user_timeout(sock->sk, timeo);

into setsockopt() from userland code? Does the BSD socket library have
such options?

Ced

>
> cheers,
> calum.
>
> >
> > Ced
> >
> >>
> >> On Fri, Nov 17, 2023 at 8:02=E2=80=AFPM Cedric Blancher
> >> <cedric.blancher@gmail.com> wrote:
> >>>
> >>> Good morning!
> >>>
> >>> Why does the Linux NFS client not use TCP_KEEPALIVE for its TCP
> >>> connections? What are the pro and cons of using that for NFS TCP
> >>> connections?
> >>>
> >>> Ced
> >>> --
> >>> Cedric Blancher <cedric.blancher@gmail.com>
> >>> [https://plus.google.com/u/0/+CedricBlancher/]
> >>> Institute Pasteur
> >
> >
> >
>
> --
> Calum Mackay
> Linux Kernel Engineering
> Oracle Linux and Virtualisation
>


--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

