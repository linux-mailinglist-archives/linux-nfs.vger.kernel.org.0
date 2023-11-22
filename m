Return-Path: <linux-nfs+bounces-34-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 653257F53B1
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Nov 2023 23:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C623BB20D6C
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Nov 2023 22:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A455B1D559;
	Wed, 22 Nov 2023 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRs9/d9h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE7592
	for <linux-nfs@vger.kernel.org>; Wed, 22 Nov 2023 14:49:22 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50aab20e828so325508e87.2
        for <linux-nfs@vger.kernel.org>; Wed, 22 Nov 2023 14:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700693360; x=1701298160; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcRHUmuOoLcaQ6/TPyk5l4T+zlR8C8GaJAqrkPIaMAs=;
        b=CRs9/d9h7jMM7ZeS6jFpiqGspMqIltcN2JxQ+DJAX20mgLAC6MiSwyWQgFeD+iS7jF
         Pq5cLZBX+hwtidmS81GUHb0mMnIlFLzl5SvPUc6yuY++2pxjwv10Wb7OPjH8HRjLaIOw
         JVjKQbn3qdhGTPi659uSg7AE9lkujYPfOrILXRK6AqAirenU+t2eyuGPpoYwY27VGg/d
         nwfYBcygZOR1T3eT13cVmn9fOfvlDcbWejI/7CPBfP6j/FM0wHwI3c8v1Y8uHWOK7o2X
         DrLWvFNB3gAd+iWOdQ897ZoygzeEf0afncZgnP7g2Kvr8w7EmUop3/INXP8j2Vh67ojP
         cBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700693360; x=1701298160;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcRHUmuOoLcaQ6/TPyk5l4T+zlR8C8GaJAqrkPIaMAs=;
        b=YY34G+BgYT/rQrR7Dd0Jlh94HN9QAIoqSMokf9Z4gpXybsmW7Ur9n0e8hmgksn6twB
         aVtR/gP9RorvS26f9Nle+hkWurHprpIME4p2+1OMXQmeA7CXLIuGXQ6CZElean5ESk+9
         XcgxTLXA7UVPgoq8NgZmTUrJB7ASi6FZ585507cI2hZY+XvMx+pdciUtFOLZnNghnbo/
         B9V7e2T7/CmUsZDtbYSH0iJYMi/OzMqyml9hNtZYSBXivH9/UAbi8prNOHfyiYmMmBxw
         kPAhWiASSoJq2SsH7zgV4x1mNaJY//LhS8PLj+htoQAR59GOabZXKrhHqI+tnrozPWQB
         2TtA==
X-Gm-Message-State: AOJu0YzTRloNR+K4BHQhvVLe4FeezyFfzvjq/og0m2G5esyeDxDoOw2E
	0epWtRaYdKD6umgRcmZd65R0cXJh4xm8TZ1XXZtxgPbD
X-Google-Smtp-Source: AGHT+IE032r2AR1V9NWD3X9s8urAIyjj0tBl2Xs3v8WIFHiuakJp51sequdoVCJ9uN53hoyKCK1cLbdgnziIVWOe1Jo=
X-Received: by 2002:a05:6512:23a5:b0:4ff:a04c:8a5b with SMTP id
 c37-20020a05651223a500b004ffa04c8a5bmr3886203lfv.47.1700693359797; Wed, 22
 Nov 2023 14:49:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0Uc7zHasg2damr4nhRZZF7xBbFc0ghdjop87+5vHa8bBHg@mail.gmail.com>
 <CAN-5tyFBZibge52iZtjnz5j6S2GrTXTWdzaDxLVQcr+G8HegvQ@mail.gmail.com>
In-Reply-To: <CAN-5tyFBZibge52iZtjnz5j6S2GrTXTWdzaDxLVQcr+G8HegvQ@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 22 Nov 2023 23:48:42 +0100
Message-ID: <CALXu0UfiCrcDciLX5A1tvG0DiPwAXPg=GikPakKW16UhZ4X-Nw@mail.gmail.com>
Subject: Re: TCP_KEEPALIVE for Linux NFS client?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Nov 2023 at 03:57, Olga Kornievskaia <aglo@umich.edu> wrote:
>
> Hi Ced,
>
> Why do you think it doesn't use it? Have you looked at a network trace
> of an idle connection? I seem to recall seeing keep-alive being used.

Well, I don't see a setsockopt(TCP_KEEPALIVE) in the libtirpc code?

Ced

>
> On Fri, Nov 17, 2023 at 8:02=E2=80=AFPM Cedric Blancher
> <cedric.blancher@gmail.com> wrote:
> >
> > Good morning!
> >
> > Why does the Linux NFS client not use TCP_KEEPALIVE for its TCP
> > connections? What are the pro and cons of using that for NFS TCP
> > connections?
> >
> > Ced
> > --
> > Cedric Blancher <cedric.blancher@gmail.com>
> > [https://plus.google.com/u/0/+CedricBlancher/]
> > Institute Pasteur



--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

