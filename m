Return-Path: <linux-nfs+bounces-3217-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8268C0E67
	for <lists+linux-nfs@lfdr.de>; Thu,  9 May 2024 12:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69FD1C20B40
	for <lists+linux-nfs@lfdr.de>; Thu,  9 May 2024 10:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A7114A8C;
	Thu,  9 May 2024 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vq3Jmpyh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB2B12F582
	for <linux-nfs@vger.kernel.org>; Thu,  9 May 2024 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251663; cv=none; b=BGcZ8AB1nKzSTM2XsEFlBXvy4C4lc942b4mh6kgLB7/mbZu/X0b6BGs4I+8p421LKGINWQxMgDcKlz2fzOPRfTlNJDvRhk+rV+cnFK5GG07+/cxVMm/uXR82PnQWcU1bCVF2TjWFEKc9ms6kDkoVJeql8ubEmA6FvFT3+Gdt0kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251663; c=relaxed/simple;
	bh=rm5tKlmmzDvxykhjXtAahnY24hMhcwI+5x2kT/7OVE0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rlRNzFgWBhhZYXI5U7Cw5EjmhP7KStNT0wKtGito6lP9ZylcSBInzY4WJLGDB89WadcKwG1g4L8+J9Qd+bDPTNJZzyMaBkYynCWCC7lgcw6I5g0lMjuWz+zGyuOlDpBU72EQbVM/pm9xGspIL7biwCPTfTciu6gM7r093dFc460=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vq3Jmpyh; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59cdf7cd78so185107066b.0
        for <linux-nfs@vger.kernel.org>; Thu, 09 May 2024 03:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715251660; x=1715856460; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1rUGSw1BOvy4nSCnLDtXwjmmz6sz4Fg4JvkDjn2tH+U=;
        b=vq3JmpyhZRc3TR4cEjBGRDbyb7flDs1B9zCrNJi8ceyjfew37YYFlILBv7Y4aOX3NN
         QzeIZuLN4JjUglakAYoh2qa0uWv7E8ZsGChseMCjfvQCU6m8CaERDYjKiFSdtJNOTH5T
         9QdlQPQJuuM3+22NubkXiFgC4RXmot0Awl+etVOpw6Q/UePzy2Nhgokt5n51Zw+uXLW1
         fApW7tHj88rCSIlbqk76hpwS6MdMl4h4JKxU8GGOwur7EwZOIA1d4LhZecY5Z2dg7lNf
         Z31Me0l785CTrTJ602WjYqgMDTEe6z5NHLEuQVyFmydKASh2Eed5LrWKebbClikTIlu1
         K/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715251660; x=1715856460;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1rUGSw1BOvy4nSCnLDtXwjmmz6sz4Fg4JvkDjn2tH+U=;
        b=g7dVfAbV6coM8OlJynQP0SeMpOn3bQh808XrnmwDJvXgnB3GEQIU3FqL9sQMBUzGS1
         yL+LrAkzuWmx/chY6hm5MXCj1oxUXn99wlAfpB2HxMzHvAPZkK5fEa5ln2I09+BTKO2/
         4ui1HeKOPrytFqpuN2bMWYHN6fhVw7v3UawTSsl1ep6gF8t1eb9ePn2QZboH75vW6iDL
         jIjU3DlSlb1ZKc8BbBVagMvXCtgUcPNoylinksNVIKrSsL1V3gl9SKw2/oyczvTDVj8R
         fGGJ88GdyEO7Avcnj9l0MbixRSAy/R8RXseLit14MASS+FUCcQvg2A3VxT3VPaJWRs8n
         Oq8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUU5hojKRSQGn3xLKejSa59gX8mg6Liv+i2201qAFW/iBUu9XjBuxxilvrr3ssMeL/4C1WXEUhaOakagBzSv6zKYauR1F4+OmWf
X-Gm-Message-State: AOJu0YyB8uklgQ6nat0RWmpxEaruc6iLxhbwc26+/xNmLRWpA3fGxZxo
	c5IfoFB69k0QgEUdbfqMmHI+Pat4yikvXJIQUrA7FouHowMcY+sBRGK4qHHbYog=
X-Google-Smtp-Source: AGHT+IH93eb6t4ZGZhsfBVUwyJEUTNQ9gpPokGEI/RTskChoPPUKWX5A9Rf3MAwsN76xfbFTLzj1Sw==
X-Received: by 2002:a50:8d41:0:b0:571:bed1:3a27 with SMTP id 4fb4d7f45d1cf-5731da9edfdmr3363456a12.38.1715251660386;
        Thu, 09 May 2024 03:47:40 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bebb6bfsm564708a12.28.2024.05.09.03.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 03:47:40 -0700 (PDT)
Date: Thu, 9 May 2024 13:47:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 0/2] NFSD: prevent integer overflows
Message-ID: <332d1149-988e-4ece-8aef-1e3fb8bf8af4@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

There is a potential for integer overflows in svcxdr_dupstr()
and svcxdr_tmpalloc() and XDR_QUADLEN().  I believe the fixing the
overflow in XDR_QUADLEN() would fix the bug, but it's safer to be
more thourough.

Dan Carpenter (2):
  SUNRPC: prevent integer overflow in XDR_QUADLEN()
  NFSD: harden svcxdr_dupstr() and svcxdr_tmpalloc() against integer
    overflows

 fs/nfsd/nfs4xdr.c          | 12 ++++++------
 include/linux/sunrpc/xdr.h |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.43.0

