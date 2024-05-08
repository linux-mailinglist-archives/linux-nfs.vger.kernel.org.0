Return-Path: <linux-nfs+bounces-3199-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9688BFBFA
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 13:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B151F2228A
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 11:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D02E763EC;
	Wed,  8 May 2024 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrbiOOCL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D93076037
	for <linux-nfs@vger.kernel.org>; Wed,  8 May 2024 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167759; cv=none; b=KVIy9MFuO68GHalSIGPNPRNAHkcGW37T4b11LEgU+ryFAb2/yELIGapVV7kgetxAfJmfXbj/Faam59r3aXFFNSJRuu17MOLnlfF5ok5OxtTuwy2qs5ApMZtZ//eRNN0qWA+8f3VOHth9k4tHSgMgHs79529cKN1BYK+wkYu0fHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167759; c=relaxed/simple;
	bh=uv6xEVt/BZu13bQ3kEpVoKjXeQ3zJnR2yhNmFL1SocY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jU0QlmekJXvESCX/aTnhfY5gpRQKnJsSQdKyjw0hlCTC5O3UGEGraIrKgR75gw+Rqo3cu0Yl999r7OWpsmxN2gtxWF5eSg3Qv74oBGc24V3qmc/mzyfd7fSU+RgNj6p0QnG5TEqpgYPj8eodYPf9m0BCqR6L/6ubVIwoGBJkf7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrbiOOCL; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c9741777f0so968208b6e.0
        for <linux-nfs@vger.kernel.org>; Wed, 08 May 2024 04:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715167757; x=1715772557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uv6xEVt/BZu13bQ3kEpVoKjXeQ3zJnR2yhNmFL1SocY=;
        b=QrbiOOCLrt79Uo0iUjkSUfypRGlnys1s1SXHqdsuC90Uk9OV0yutli8rP18E0xLXRH
         EF9RhQnwnXsrG+MLGb8Tzx7UiSNDYIuWxtYEVGTvr4GQtQDDR5kMErcH5YNT2jrCSCaA
         WrHQIF/gFyFilwGxXQlngLLPdzMw9P6AuKz9u31C03Rco3SyBm2duHPWGtWoFWJBkVwt
         yWEgE84sv8xRxbuTbDTZu2yyHFfoug9Ljczt8/6MzW2KxJEoPNgDA9e1VtkQDE01Ic1v
         sMraIH3RbFr4e/k0xcpnqijSKUXT7WSTpVmBS+bkgry535UQ+/lAR31pmA3zwx+SdGB1
         Mx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715167757; x=1715772557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uv6xEVt/BZu13bQ3kEpVoKjXeQ3zJnR2yhNmFL1SocY=;
        b=bkXOGtv+0NaC7ck2Epuem48DyMhXzhZOUje9N68iRonsNrgk30YhbUZMt99o//Dkxu
         ToQFYPDRBp6igzOSTWqmvZEto15Ijq18eOGOBww42z0hR4GxI2W6jnLPK8pM7/6W/l7w
         KBl1FtZDaNlqnw9gJOhgpzxChHYR/5VAqU4ckYgFRmQNZrxAidEU3zX+XB0FtdJuytTN
         VTRjk0kpMhyHro7QEOX7Wd867iiCFVxNGYj+BMLYd8xPe0+rCxIg630sN/daW6MtcD59
         6ilvOFV39LXI0zy/7vDBejZtM5bK8Z3zTQU6M79kggMSKQT88EiUxsjzbUSggDYVQ8gV
         4wsw==
X-Gm-Message-State: AOJu0YyCl3TgndN/Oq4AEacNJ0JiKQHnmiTNjtBsNyY8SngFaZtF3ylu
	TBKolHWBH9Qy5vn8A9qIqy1tfUjXqCuvFpN86Yrrbi2j+8UhQg1UXSeVilPTKN25U15H7NxjOC4
	p8hL3EthHYdLAEwLIoP9Iv8rYlXc=
X-Google-Smtp-Source: AGHT+IGB1zadtR5ezKM1x848YRqrGKnSpt5mrIyORydxLx3/lpbXGeFr9Xa/sz+QKQ5RkerX+DPbUApKdl7eAtV350Q=
X-Received: by 2002:a05:6808:355:b0:3c9:5dbf:ac04 with SMTP id
 5614622812f47-3c9852c0436mr2340695b6e.18.1715167757115; Wed, 08 May 2024
 04:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjjaD4O6FYDrCz8o@tissot.1015granger.net>
In-Reply-To: <ZjjaD4O6FYDrCz8o@tissot.1015granger.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 8 May 2024 14:29:05 +0300
Message-ID: <CAOQ4uxjNK95-PgHoZ+HzBGE4F7BhZiC4sSPcJAR8e+gYmyN_dg@mail.gmail.com>
Subject: Re: long-term stable backports of NFSD patches
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 4:25=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com>=
 wrote:
>
> It's apparent that a number of distributions and their customers
> remain on long-term stable kernels. We are aware of the scalability
> problems and other bugs in NFSD in kernels between v5.4 and v6.1.
>

Chuck,

Are you able to share a partial list of scalability problems that were
fixed by this backport series?

Specifically, my interest is in the list of improvements to 5.15.y.

Thanks,
Amir.

