Return-Path: <linux-nfs+bounces-7110-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 519E799AE12
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 23:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C531F254EC
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 21:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480691D151F;
	Fri, 11 Oct 2024 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="caijQmlS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6291CFEBB
	for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2024 21:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728682474; cv=none; b=lGplsHs/EVwORm3XezWgXLCncwKGKfjyj4NAfRfGRsaC9HFv6svC2fjkx1Gmue5d9PSFlnI7ZIL6+0ek9KUCtqF/zSE4LvRw3xZW3S9YH+BJR4HC+DQCSI8iIRSJLFYCH/rPQ+8gH2xmm3u9IxHiFKB20PTplwiVKHRo5A8tPaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728682474; c=relaxed/simple;
	bh=yn68VGQgjuF57lFPHzPET93dI/gFBtZI+3oFtACRqdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiAK8goU5uob81aTUTm75BlkQPc/fmsApvcfHugJZjM57tYvqMFTBT5K0lo21hHpMszSpKJwICt+1iK2CwoYyF530kAWNUPN9A+ollpK25yB8AqpGCXci6mBJhyGedCSW6ug0ezn4WAkYoERDXgXF1Dgc2h9bG8m2oAXzwz+74Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=caijQmlS; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e291cbbf05bso1305492276.2
        for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2024 14:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728682471; x=1729287271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuJ38S9WNQES8UxG5Eg7yjwtIJRWC+46hl/pmxrvCWM=;
        b=caijQmlSLH6Mn6V9Bh5OtPmtrih6HODYry4AeeeOsNhI2lrdPj2P8CJcgedFPsFYnN
         9grM3LwYNldCHZawBfBC10tYjsH23tLkAMx86mX+dkgE/7e0mGpcGu+7U6E2HYBrdDqc
         dCUzZ3/4GQ30K5F4OsU9m1jbcF9YnVModAx/RdB1tIaYXbyt8LZw/trWf196QbIMkTnU
         +1hAWpqaXYsMBAw/4J1C3dOhLws2hKV12prYbtqY4ylJhHI4VlkhXU68mqDD57X/nicz
         5MGJjVhgKTGNyRIYt9DQCOTQxOWlOG51E3SVBTY65E8s19rVFXbYAfSPcJ3MiO3PJW37
         7lnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728682471; x=1729287271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuJ38S9WNQES8UxG5Eg7yjwtIJRWC+46hl/pmxrvCWM=;
        b=kQ+P02RmOi8Xy5i8YqUHPNtvbryJLo50PQ8r37sSwe/tYRsybR1LFv1/v8sM2vzIoi
         hDx3NoAp1w6Ft0y/8tnXdT/yf/IXbMkqrOHL4trwsDR2tkacPJvbFuZhbhR52O/pvzRb
         PH43+wmG00hQTUiuFKPu+ZyX8Ow7/+a2ndyxEy3pTTRVV6g5FsiWHLrU9yMAFLAMW5Ir
         B06jr8lk88XKiW4V5vMV0O2wSgadS8x063V2Vk+pEHOzNqc+ncYJU10eKCEQuJVIwLfU
         dCYXhGpoZlRGtXj4Ru4ScwDvfOl4nn49Ua7Q5J/f+53k/8dOqnQw1JHLQ0Cjob6wdAq/
         BBqg==
X-Forwarded-Encrypted: i=1; AJvYcCX03r8gP8Mb6fvz6xl2b33YDS/bdK/RDHgeRfC3+j/eP6jK/q+P8VkVRnix+XobP8A2IePwII0+Afw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTaqX/YEG3lJBy094d36S6NDRhYN1sP/EpD9uM9g+VSlDjCZqE
	iCLYhWlkB5dn7TQLRhTEcSbFPL7/aErOIThJLCcij2ZguXGH+U6KlrPT22zJ0FLT/LM5yq2kdxI
	5TacjaYgK7fZV88TXRayGW4+HZMGDEk6L+xiS4yknDkfKRrw=
X-Google-Smtp-Source: AGHT+IFrYhiJio4X4+ywyBra47qcZ6SUO4xvjf/kfaS0SLCEASRbGZElMMGFLK5PU9YPz4TciK+hv+7VEGUf5UKSZ1k=
X-Received: by 2002:a05:6902:11ca:b0:e29:18e2:622c with SMTP id
 3f1490d57ef6-e2919ffb611mr3143224276.56.1728682471609; Fri, 11 Oct 2024
 14:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010152649.849254-1-mic@digikod.net> <20241010152649.849254-2-mic@digikod.net>
In-Reply-To: <20241010152649.849254-2-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Oct 2024 17:34:21 -0400
Message-ID: <CAHC9VhR8AFZN4tU1oAkaHb+CQDCe2_4T4X0oq7xekxCYkFYv6A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/7] audit: Fix inode numbers
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 11:26=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> Use the new inode_get_ino() helper to log the user space's view of
> inode's numbers instead of the private kernel values.
>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Eric Paris <eparis@redhat.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  security/lsm_audit.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

While answering some off-list questions regarding audit, I realized
we've got similar issues with audit_name->ino and audit_watch->ino.
It would be nice if you could also fix that in this patchset.

--=20
paul-moore.com

