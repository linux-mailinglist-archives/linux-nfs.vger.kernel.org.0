Return-Path: <linux-nfs+bounces-10867-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3E3A70AA4
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 20:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A0D16E635
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 19:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47333198851;
	Tue, 25 Mar 2025 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx6F1mXL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4161F0E33
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 19:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742931655; cv=none; b=M45sZDSQ8OlkVQ6Mv8UqJ6NnWwuMICysT4EIpCtoNKao8Wu4Wk9i5vt9zLt6rWzWvdIA5UeTSEO5tUPa+lim79BkDU8Dr3L8JA3j/BIELte7iqRIRSFwGUoG5wf8JRE/v0l7QjxhPr0gwhoMSoRvHMsCzaZxMh4LYnvNKsz0cqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742931655; c=relaxed/simple;
	bh=+6azFkAHiitoL2Mik2x9LuUgtpr6AaiAAem0n4pny8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uWnJGHxAlo9/zrT4jRXc5HpyEcjb0o4xLugMRWbs0RyOPf30ejiX3D4hfSe9N0R1Tt3i5IT11Py5w6EzakOfceI9r4T+0bgi4MX6zubgLvzDjNyY0PHh3vP3lrN+OuoeT5ZVI7RWFXhAQnZVezjcJ2WaP0AFBHW9rwS3DLtz6LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wx6F1mXL; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5e34f4e89so10998529a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 12:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742931650; x=1743536450; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xmlEmnHml3aLq9AQKixQs44/4gFzD8THY2JFMeGIBvg=;
        b=Wx6F1mXL5OQhtloMJHAG/zndl48v0SRMmNjrGkEPv1CCVT7xR2UfGSxOoniRtp/CV3
         jz+Al4WAEuC415vfhzRZFKnG3NbPtzy8/KVK32tsjds53YQqSLIhzF0kysbryXsHkvdm
         KGr/AyP9GbOa9ThDu9fqvMYMQsLKDHH940SgL4iRIJoBs6pm1hlPAnBA9qzkeYQ6DCZ+
         Y9ouZFFPNWaUKdV+YwhSFv9rxgRpuiz8lc/0R/uuOMnFv8FGBpDrTi6Ikpj/5Kx7NsFX
         Ni/LZp+PGDKBiRFq+nFzvxDS97/fqCJyiWrxtPyuIF3GI4Uc4LBINIRT2omxA3H8tm/b
         bEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742931650; x=1743536450;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmlEmnHml3aLq9AQKixQs44/4gFzD8THY2JFMeGIBvg=;
        b=rgH4C9S4FuYRVDpF9nRFRdbUATPKFh0fWVntqdOlKLmW+xa9cHNlSoOoU67QuCcrmM
         R4pecPQjW55y34c602h3MPc+i2KQ71n2jlU060JKfmHEqjMLkU6ELHgCj9DTfrBeGTkF
         FgBl66F/JmGN6qE3km3UFpbiafqUSq91ILmVxkgj0KZbCrWCkqCyIYW4bPEbWmfRwAFH
         HEupinjE9J+uNV1+yIAzp+DA6HQFrqwTl74f9Cig5+VTYI8UMRJ4lge2aFNF6SHtkTti
         fke31knuOvdXrbDaXJcw3MYsR9ygXExytXNmlb5plQj80JO+wCqsXZuSYuQHLOuD8wmV
         elLg==
X-Gm-Message-State: AOJu0YxcLL0ULiqszXGu6Gs4cw7aOATZEL46L7V1X8T/SRnz7A4oIRhU
	rhCyTRk3wa7SelVZZQhELOhOz9E3IZJTIUOSm//XN2PagKFCewRMhaTouhe6Wxi0AB17NVOVh2H
	0Dzfx4fJC2rwJkHeRTVFRhSOQdJjIbXVCeSI=
X-Gm-Gg: ASbGncuvK6Mrmcsfd4O4pmbWhlMuQmcV7tNd6qFF2xOfp6ssD522L3N9PpcIc7mvP5P
	4WgbADpRpQ7o5p7j97okk1r16FyKm3oi4mI5o7i8t0kX5QQV/BY3wetJjauWFcpJDbvn8cOT6S/
	ZWvIVbB0oXl+GaGnYYm7cNyV/GMQ==
X-Google-Smtp-Source: AGHT+IGNmONot7AmWOIi5UqMx9n+Zqa48O3HxpzUCVpIBdGTS3B5v9uAfryJiFokPdxZvwxoqrNQCbStFQxVGNnnmho=
X-Received: by 2002:a05:6402:2102:b0:5ed:1c64:be9a with SMTP id
 4fb4d7f45d1cf-5ed1c64bf01mr2789764a12.2.1742931649676; Tue, 25 Mar 2025
 12:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742919341.git.trond.myklebust@hammerspace.com>
In-Reply-To: <cover.1742919341.git.trond.myklebust@hammerspace.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Tue, 25 Mar 2025 20:40:00 +0100
X-Gm-Features: AQ5f1JqWEpy4qFtGTkwQHmdKWGwreTWQJfi4EBAYaA6OAO4ZLiscoK6VS74ATDY
Message-ID: <CAPJSo4W2y4gF1tP9LSmqXkSr+TEz9COLPePcJVDxoJB79QUeJQ@mail.gmail.com>
Subject: Concerns about ENETUNREACH patch series Re: [PATCH v2 0/4] Ensure
 that ENETUNREACH terminates state recovery
To: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 17:19, <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> With the recent patch series that caused containerised mounts which
> return ENETUNREACH or ENETDOWN errors to report fatal errors, we also
> want to ensure that the state manager thread also triggers fatal errors
> in the processes or threads that are waiting for recovery to complete.
>
> ---
> v2:
>  - Return EIO instead of ENETUNREACH in nfs4_wait_clnt_recover()
>
> Trond Myklebust (4):
>   SUNRPC: rpcbind should never reset the port to the value '0'
>   SUNRPC: rpc_clnt_set_transport() must not change the autobind setting
>   NFSv4: clp->cl_cons_state < 0 signifies an invalid nfs_client
>   NFSv4: Treat ENETUNREACH errors as fatal for state recovery
>
>  fs/nfs/nfs4state.c     | 14 +++++++++++---
>  net/sunrpc/clnt.c      |  3 ---
>  net/sunrpc/rpcb_clnt.c |  5 +++--
>  3 files changed, 14 insertions(+), 8 deletions(-)

1. Can this "ENETUNREACH or ENETDOWN are fatal" feature be turned off?

2. We have concerns about this feature - what will happen if a switch
or router gets rebooted? What will happen if you unplug your laptop?
What will happen if you enable/disable your VPN software on a machine
or container? What will happen if you switch WIFIs on your laptop?

All these scenarios will trigger a temporary ENETUNREACH or ENETDOWN,
and should NOT be fatal for mounts or containers.

Lionel

