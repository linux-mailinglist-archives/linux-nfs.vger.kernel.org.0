Return-Path: <linux-nfs+bounces-3568-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAC98FD0E7
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 16:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59BC91C22B00
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630E919D889;
	Wed,  5 Jun 2024 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="PHWr0kvN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7994719D8A1
	for <linux-nfs@vger.kernel.org>; Wed,  5 Jun 2024 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717598090; cv=none; b=AkpWazFUoSrX2zoPzBs/apyw50hOTD5lpWFDyLVlyUl/HLe4v0pabtYI3Qs5nAJzb6SuxrSqm14KB++Jmwe/KelX3JrQ/h/VBRI45VO3/IBkMgBNfQD7iZ7udZGHOXSPNc7q+v2sXkPD7P/7EPjEFOkdLNmYSglFMOph3OyC53A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717598090; c=relaxed/simple;
	bh=V3QKKacYN81rshEYG9SMCV0yC26w6QEaUtenYZcNmB0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Jo4S6yCN5qxT5wyRavyQ6L6wqBO2QlE9Rg642WBeErCgQtTxzb5BjJgy7YNuhs17Q/5Wos+uVMUQ7mmb43jeEGlhBYM2EtY6P/lGX+knFjCGNuZqyguhzzFJ+fMy4Ney/E8GCnZPINwF7MRktJJ4r3j9fMG02csvIET7ldIve3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=PHWr0kvN; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ea9610eca7so6294721fa.0
        for <linux-nfs@vger.kernel.org>; Wed, 05 Jun 2024 07:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1717598086; x=1718202886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V3QKKacYN81rshEYG9SMCV0yC26w6QEaUtenYZcNmB0=;
        b=PHWr0kvNgSnVrcYOljV4aSd0TIRRqrvckZb3VQpLOQEiyP7LAzetujscWSXBZ2DNxE
         sJwCeVXKMxHK5LeOK6vSKMyhKyDLW5wdprF/kDCawdjiB/jTx2VEVuTA9lndEL2gCsCv
         vXG8RRXhb/e0blehBA2kCj7sV6ixPgClOoiGpDbr7T1KGgNw2kERF0F5sHEgSnYfbOPo
         uurRTW4VKXenYRPT16B+nfs6z97Zhk1MqHIk1masRYQwDMa+JTeRl6wUGi+FGWfykYLc
         k09UTaWoBJ8toLpFigy8EwI/NFW6vrqKgqzaB5YOGWHMyI2j7Ajw3rrqeZ6FigGzeBCM
         QUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717598086; x=1718202886;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V3QKKacYN81rshEYG9SMCV0yC26w6QEaUtenYZcNmB0=;
        b=gHijKpFL8zY2j4Vo9rLLC8tLU0JSICqPSOAn1nmrScsouFM6hVwZDQ3qCbzZy6OYxD
         pot7WZVlFAJa3YaBcCE4ehtakEOdmtTOQEfOGvybGLCHbvUc66cAtjjjEvsf7lfJC+um
         JHCGT7ObPlR+hnLpjRg8Ab76Lv0m3x/29CosHysBoHw4JamB0PE2xN3aAjYggi85JVbB
         R3pkndpm6CukkJlzAH4Bz0y/dsAR220Y4YF5Sqh43ZzgsOLLxOLtHtdKTMh+R3YS0SeN
         NzGI/6TXDU3kJzwJgYavHsL30gQXFr1Ry6WE4zTk2k5IQXB0LUOZzV7WW1F0FAPAC+KE
         gMGw==
X-Gm-Message-State: AOJu0YyD5sNAsDKYXF3nRV7Ae/yOvMi4RCZXzZMbVEAWBW4TvLeDRBK9
	7yJV5EATo3XMiuMR33RQ239fD+rTPR1jWQxQ4W63hBSC5Ei3WEa7R4zt4b2Q8sa0bwoedE97XaC
	wfn7XpGIP4Ng08bAbEU7TdLVCUeo=
X-Google-Smtp-Source: AGHT+IFY69NxP6/geg8INvCDiHuFvR13Dqs/+vaWZpH4wqJARShSZdowBiYHYKoYvaXBbQOROm/cEuRi1U6eaZ7P4tc=
X-Received: by 2002:a2e:a98c:0:b0:2e5:2aa1:a76a with SMTP id
 38308e7fff4ca-2eac7ab9f6amr18195301fa.5.1717598086284; Wed, 05 Jun 2024
 07:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 5 Jun 2024 10:34:34 -0400
Message-ID: <CAN-5tyHghLR_eSoPq_z18_XvdySKNrWpPKjuAd2c97KKqYGjFg@mail.gmail.com>
Subject: NFS with TLS on 4.0
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Chuck,

I noticed an interesting behaviour by the linux server. If I were to
mount the linux server with vers=4.0,sec=sys,xprtsec=tls, acquire a
delegation, and trigger a CB_RECALL, then it is done with gss
integrity. Why is that? I thought callback is supposed to be done with
the same security flavor as the forechannel. But then also callback
isn't done over TLS. Should the callback be done over TLS (and it's a
future implementation to do for client/server)? Or is this a spec
restriction/limitation?

Thank you.

