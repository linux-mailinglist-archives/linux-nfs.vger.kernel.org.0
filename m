Return-Path: <linux-nfs+bounces-1043-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3889A82B411
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 18:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06C31F24281
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 17:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4210E52F73;
	Thu, 11 Jan 2024 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rh1BTKJQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D5710A20
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ccbc328744so67356621fa.3
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 09:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704994110; x=1705598910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0OhxMTSx9Uaoz+vGjcZhMglIMRAQzH5/86pj3D0j3dE=;
        b=Rh1BTKJQRQXBly9E52sffgsi8W19WgiYLqHRcHoPUk5MqgJIMMagIkg4ddURQdl/c6
         Yq3HE417wmBseOm5+LYOjS7AxRTlFtPWINams5Hp1sT7I8qnKMT1e7x1kHXZQ80dXP+e
         Rjm3LbdB2aXOWMFYR23ZgpctdNfIkiCduLK4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704994110; x=1705598910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OhxMTSx9Uaoz+vGjcZhMglIMRAQzH5/86pj3D0j3dE=;
        b=MQStEcvgqQNB+1S0NwAUYbdUAoBHdWclvX1iBmWA5NUhdMNL7pKROL33i6qI+Hx9PF
         n8e6BDlRNOJRtav1Zxgiog6mG3zj4TfJnuSoyTaP3mvi31UVOoE7rgyLqqNxp3iZAJwi
         jiBXpHXNkrxOsVc/XkutjPQVkhPAmsr64/opsCRG/vrlkvcISBR++Yt2qxjZTvjsZP5n
         nst/MU2kc5lr08QNVeWRCnCPJA7L86JPykXrWxCUE7SPkLzVv6v79IJZRncMQDasSNBD
         w5XUahcC9pnYhc041tX/F/3YCA/oHN4EM5a8YMYVWCc2/FPtBJVJCQazXBVTDXOgvDix
         KM4g==
X-Gm-Message-State: AOJu0YzjXeWffnTp1rf65phsQOrkbx9gHzmOY389iZeVLEXFo122OZOD
	GOKVp39embHqCVrO8mH3gV4dViy83kRXsWSMmAtgqOwIrfPTF5cu
X-Google-Smtp-Source: AGHT+IGXtUn89Eb9TQMWuEzDCsx0WEcfbmvMNKBaRtwkJxVK7kpOZLvm0HkMVR+fR14o95rglqoNLg==
X-Received: by 2002:a2e:7819:0:b0:2cc:e379:88bb with SMTP id t25-20020a2e7819000000b002cce37988bbmr45006ljc.19.1704994110434;
        Thu, 11 Jan 2024 09:28:30 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 7-20020a0564021f4700b00557de30e1f1sm811602edz.74.2024.01.11.09.28.29
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 09:28:29 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26f73732c5so660361666b.3
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 09:28:29 -0800 (PST)
X-Received: by 2002:a17:907:908c:b0:a28:e2d7:b41d with SMTP id
 ge12-20020a170907908c00b00a28e2d7b41dmr19346ejb.0.1704994109438; Thu, 11 Jan
 2024 09:28:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110214314.36822-1-anna@kernel.org> <CAHk-=whbDyOVyNKKhq44PZx0fDA61mHuk=QMc0-mRD2XHp1Zaw@mail.gmail.com>
 <CAFX2Jfmk=9LhNaCZqsXaBTqsS866q_zCzozjsdDPmhg_xxzUgw@mail.gmail.com>
In-Reply-To: <CAFX2Jfmk=9LhNaCZqsXaBTqsS866q_zCzozjsdDPmhg_xxzUgw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jan 2024 09:28:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh6XZOOi2O1yPPHp1YdUdr7PacF=ibHQK7nvzmE-xoeKA@mail.gmail.com>
Message-ID: <CAHk-=wh6XZOOi2O1yPPHp1YdUdr7PacF=ibHQK7nvzmE-xoeKA@mail.gmail.com>
Subject: Re: [GIT PULL] Please Pull NFS Client Updates for Linux 6.8
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 07:40, Anna Schumaker <anna@kernel.org> wrote:
>
> Thanks for the heads up about this! Looks like I updated the key
> locally in November, but I guess the MIT keyserver choked on it. I've
> emailed the updated key to Konstantin like you requested, so that
> should be updated now too.

Thanks, looks good on my end now.

             Linus

