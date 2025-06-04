Return-Path: <linux-nfs+bounces-12101-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 133C0ACE410
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 19:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00BAF7A509C
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 17:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FAA1CDFD5;
	Wed,  4 Jun 2025 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIVOAQ4z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BE41A42C4
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749059970; cv=none; b=mPxNOlxtxoK6vedUBNfCCWkHBUXGrhYfYdBerkd3AtkYvAB79YuGI9vL7TK8L6pqE2NMXXy0MuYYoXotks5aLEqEFSjGaY7IOBbvj/q9chJfKVeUIINLGS0UHZ8RGpN0toXJZuVKN5dhwPZEauTXodJDyFblceDmZ8h4l8Fd0Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749059970; c=relaxed/simple;
	bh=dfnR3Qwf8YKCCElKNPCY07yq2qCDYkomj8HtIsivlvQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UqjSX3flv2QizGaMuoJ4Q6vIN9ImnmJVVmvjz0JaVxAPvi9CjdQ9WvluExHQoYa+HBpi6hAYWUne2/qzZgLM3B/piM7gq6MCrstWQ1ykY0gpnQmXnOK3zID5Pgz/eNpNKm3IX6z93A7ZZKfoNoxILOU8sZf0aV9hrTxBzPxXDRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIVOAQ4z; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-311ef4fb43dso120674a91.3
        for <linux-nfs@vger.kernel.org>; Wed, 04 Jun 2025 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749059967; x=1749664767; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fRPicutNk9F+LXmdNTL/kOZe8gAbTRHyfU3GZG45p9s=;
        b=MIVOAQ4ze7UoS+HPj7pBNPcSZk8tMfy43YQ/+ki+phx/6Ra5VDCgIigE2qJx29CuFt
         q/Vbs1LjlBtp4WUJC/j3JrAUcdYB+/GDXBDWCxZguyLLOqD+H7rOM7buwWB70Pkcz46y
         D2GoiCoZMkfoJLOcCAIBR/vx7uOp1hbQMm7LIXLjCZfX0XMJTvyFcerFPwL/AbPKq/7n
         33fdK2AvSW/uKce+YmtTxUiXW5t/B1VSh5WFw+BVltkVzY753JG04swaf+Md4f6WAx9N
         ss3Q0p2KPp20TjZH06ROgE6JATFDsSxhmoq/nNTLNsAj7nj3MDGn4qwfyCUCWWxltzzD
         TuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749059967; x=1749664767;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fRPicutNk9F+LXmdNTL/kOZe8gAbTRHyfU3GZG45p9s=;
        b=w66AL843dajOAhoKP7fyh5R02GXovaiygXJDTGen6fqzsimvgerLIqjbaGaZNghR9K
         iLp7YFjMub1aNHtd90Bpza/1eijY7Z9xwwM43cMxioyE6wC5/h9stvkLV30V9+Q5EPa+
         3fokpyKatNPIUjggBoJgwV23JiF4+YzEdU78DY6fAV/kf4FddBn0zh3SxHUsPD6v2RvN
         o8iBJDm51mdaouX1G47Xn6d2jFu8dp3rptZajPaFyk8ySlgp/Es9j/t2d/xPHG2lDeeM
         NaUDjeqYHTBSE8WuFvwaQsPdRIj2K0QoNbEFxokVIgFcCG2qv++7pycwmYUtAnVdNV47
         XGOw==
X-Gm-Message-State: AOJu0YxeJIwSEV6V7fGVJZyURPLCF3ple7H/dkSwrSwR4Lka1RzEYj2T
	vScrn/Y5mBEiigV5FWpoASQLnKa8i/ZP4Rn5wSvSvkk/dcMsBTr84kmoyng360uiTYJSdKGkSwF
	JsyQ6EBEXMlyHIC0NRy0fH1p9ilmeiWrEPQ==
X-Gm-Gg: ASbGncvFVTjQkE5sxXqYtWs6htoSFtK6dqyebrzoZZC3SjvU/YJGuXcwYcxYBPL/ZOJ
	igW0wSFnXej2gdBhAPf/AnnXMEvfnx/KQZ0MLQlKxyap7Y4GqjMrrQr+1bvVZ005rV7s3QGtjJ7
	/HLBbTeJEfm8FFfwk+82ff6ybVNlKR6ijY
X-Google-Smtp-Source: AGHT+IF8J5zb0vs4ldFQe9toL31EwAPDIRwBtnIXwg6FqFkRaQ3W4wZuO6q0dK0clPmWdxK78qIQKfzepHUWDS5dHIQ=
X-Received: by 2002:a17:90b:3891:b0:312:1143:cf8c with SMTP id
 98e67ed59e1d1-3130cd98c00mr6264047a91.16.1749059967397; Wed, 04 Jun 2025
 10:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 4 Jun 2025 19:58:49 +0200
X-Gm-Features: AX0GCFvyHekQUJUs3JUM_lzCq0OEwEVrpxfOEeC1woxzr3f-k8owwHKuFzAIuY8
Message-ID: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
Subject: LInux NFSv4.1 client and server- case insensitive filesystems supported?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Good evening!

Does the Linux NFSv4.1 client and server support case insensitive
filesystems, e.g. exported FAT or NTFS?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

