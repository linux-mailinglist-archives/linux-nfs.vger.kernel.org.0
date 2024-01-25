Return-Path: <linux-nfs+bounces-1424-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455C983CCF5
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 20:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6DB290392
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 19:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DDE1353F3;
	Thu, 25 Jan 2024 19:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M60BYX4t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4A1339B2
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212520; cv=none; b=Mb84wakEdr6Td7sGP289w3TZLPQQKtnL9AsMztLcJyTVkyn2UJBkO9MXuFmCihcJgrvnKs6w7TT1jbIaLxhv3f0piXySlN/2x11WSTQNX/h5J0A5UPd15mpmFbzPdpg+AgwPrjcbbspEwu3GRwJYkQxoulEd1fvwjlJ0yDgo/dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212520; c=relaxed/simple;
	bh=bRa75KwbHS6qiZpEoScP7Yzb0gmejqoP6tcYNhSh3j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8N+kdO2RBGqq94ENHWWX2S4opxVtgBIYBT+kDQk6BoQES90avvqOc5Cu4NeHXN/kBY4ML4YDBZ/qmWs2toAemOE0h2c12KLpn22S+ODUDZm3xreR/giw0qNeRJmcQlergYgoT3NVfPPRxGtSO0MVKQqi/xVouAi0bhcbSzusFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M60BYX4t; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a684acf92so33725a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 11:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706212517; x=1706817317; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CvSmyvOGjQzVgcXm0iQljOM121JoZFxckI/ebXRykGU=;
        b=M60BYX4tTf13qoWjETFkuu+KMyPVTYrtu776WDxO+Rh2fOUDYChPr53aw0N4nxYg/l
         fXaDzhSXP2BRYRgVgH5Cza3FsVYf/m+a+y1Tqo52CXpj4MkazB5El5+nL76kE0Bj8C9L
         9eK58KMiLhW/xr3UC+zCDCKg+CQGpkI2RtnxWtIb7/xkDZNiTdBaSvdDcepfqkgx5hPl
         ajrpzX1A350bIUuOfTP1Aiuv0sZUFIKEe4ePJNa/CMCTEY6onuOWRLEw2eLKR/G3IYf7
         yEw+fMUYVFjqMHLtF/Jk16/A5r1hNtca2P9jnTwyp+223C/yAah2FsZNIue6yZP0JR+T
         Lvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212517; x=1706817317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvSmyvOGjQzVgcXm0iQljOM121JoZFxckI/ebXRykGU=;
        b=HxhlklsjgdHMwVcJNqFTmfdlKPfJMV1VEWO1nhIhCJIrjjlZWmewr552oaBMyroylR
         Ux6HAWOC2Cerotafg3BRTpUJrfsHTu+m1kVuAsaO0g4MR309o+p31zjZk6sBVrL1YZpF
         c/BSAZyiXxyTZTY8ACQI29HY+WPJaQvWOnyG7DuNa9a1ByIAPA1vpympUs0pOMhSCkl7
         25l9GFCBvw0S7UNY69jgr7I+EovdLh7jZ9SJ5Ecc00yz9faUUXURPL9xS1qupSmAIIrn
         VUHm9DUyhd0Rs+SozZEc0ufSxZbnfq1wSgmkTu7FH2SJc0eJQaLClsESs7h0IP+pj23F
         sUCw==
X-Gm-Message-State: AOJu0YwYWFh9so5jdnVAcKNaPE5xKV+R0cUSuWAWkNKgyzExWsTzES4U
	Z9GY+mTN5ElXxJJOZX1wbq9sCj0H/kCAW+zlxS+ObTnKCFe9QMJjpP2qo+SceKeYqBXTsPUs79W
	juTR3pn6Gv1m7zWEbELtn0jY8luo=
X-Google-Smtp-Source: AGHT+IHeqsh4/hCjiKzK8QRwFlhhsQVONBu7hefrsp0Jm4Dfy4ghDI0n43JDDCOHb1kyL2jimJSfXE/UNT7v+shPbBY=
X-Received: by 2002:a05:6402:51d4:b0:558:252c:2776 with SMTP id
 r20-20020a05640251d400b00558252c2776mr77733edd.16.1706212517256; Thu, 25 Jan
 2024 11:55:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8a7bbc05b6515109692cb88ad68374d14fc01eca.camel@kernel.org>
In-Reply-To: <8a7bbc05b6515109692cb88ad68374d14fc01eca.camel@kernel.org>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Thu, 25 Jan 2024 20:54:40 +0100
Message-ID: <CALXu0UcV0b8OvH7_05tD7+GRgoXRcp9fd1aXuHjtF2OBDPmSJw@mail.gmail.com>
Subject: Re: Should we establish a new nfsdctl userland program?
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, 
	NeilBrown <neilb@suse.com>, Dai Ngo <dai.ngo@oracle.com>, 
	"olga.kornievskaia" <olga.kornievskaia@gmail.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jan 2024 at 20:41, Jeff Layton <jlayton@kernel.org> wrote:
>
> The existing rpc.nfsd program was designed during a different time, when
> we just didn't require that much control over how it behaved. It's
> klunky to work with.
>
> In a response to Chuck's recent RFC patch to add knob to disable
> READ_PLUS calls, I mentioned that it might be a good time to make a
> clean break from the past and start a new program for controlling nfsd.
>
> Here's what I'm thinking:
>
> Let's build a swiss-army-knife kind of interface like git or virsh:
>
> # nfsdctl stats                 <--- fetch the new stats that got merged
> # nfsdctl add_listener          <--- add a new listen socket, by address or hostname

Absolutely NOT "hostname". Please do not repeat the mistake AGAIN of
separating "host name" and "TCP port", as they are both required to
find the server. Every 10 or 15 years the same mistake is made by the
next generation of software engineers.

https://datatracker.ietf.org/doc/html/rfc1738 clearly defined
"hostport", and that is what should be used here.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

