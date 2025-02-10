Return-Path: <linux-nfs+bounces-10031-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AC9A2FBE8
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 22:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3FC41882F48
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 21:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A5B1C1F05;
	Mon, 10 Feb 2025 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BfeUSoha"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7841A1B87EF
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739222490; cv=none; b=TO2rZVXw42PfrEe0bXxKpE/fUyjBUg8jTG7BwY62mXHDuIsVgevIlKLfIBA4fkTfFLVQH14RcnYJs2hxnIFxNU9f1jk05nE2CzQr1Uv2Qsh5z7JkFW1Jv8MfOhB75aWwoeAsp3U1iUP7ID+G8aBJbQdQW731mJ9ciUvo7dypYzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739222490; c=relaxed/simple;
	bh=1U69GIN6qnAoPSfvFkd/r7IF5OHmunVBW3inc4Y3Rc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSNxwgkqCYzHrOfPVcPjkhrHZa5u1WX+4VlH0+NlsyzreODLuFKRUtQXV13CTCDOnjnTZODCDQ8n34W54oUhxCrjYm2Quti6GlpIfICGR916XTh1wo6uI1M82jlyzFwJk5tM3mGwFWWGLoOWAIgH1QKqqQrOKZOQ6n2Mgboa7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BfeUSoha; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1077003866b.1
        for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 13:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1739222486; x=1739827286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+ur8Y2RDidgzv399ZYRl0rKwDdGp/KVHGpz7jgUvSQY=;
        b=BfeUSohaCRTls1p5t758RJFYRfN3XYtMoyNOOVln9W4PhBrVKe5l4eo7mkoy8YjXUk
         wXH9Jv7jZYaxCkLU6iU3VmCmOI1PaKTQrp1sdRMuH19IWfgdfhNuAG5R6tSt9DthiVr7
         kY8KA2yhwDSYsjnmX+1f3GZX9SYQzLmik10Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739222486; x=1739827286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ur8Y2RDidgzv399ZYRl0rKwDdGp/KVHGpz7jgUvSQY=;
        b=uCfI5QlFjov1e0Wn4aMVsykO5ZA3KBqMaOkqDYbo0PrQ83WkqnjMRl69NLrqYhagDA
         EliDpBW3tMmj4qnR/J9o28mSfcRkm3gd+h5oRUKYYvsGenay4S7VMAKzzepafM4EGiXD
         rwMOhEUU8cDtuhurm7ktJdM01//IMs11WRdtKQyG4XgryAQiU4aSBw9c7FVJjJ1H5Z5T
         7aJTPLNak5tUTWg9QeYu0DRdRSgD3dRVcXcWhMgLuG+OZdwT/M0l/FCnkmBStGRMN03B
         /SHqWdAl0m5kuOz91g0H9Jg5eB3gliVlN957E6EvrEHMzimrYetF+LF303jhQr5H58rq
         HclA==
X-Forwarded-Encrypted: i=1; AJvYcCUt6f93Eeb4ePod0WMFQknQPwGxqKkCPe7pkA7c+I9hi3w7qJBLnv3giPhSJbILU2Z4/XjtWlWz5p8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNJLWtMf00kckzhRMmmBA/Ty8brSI/6qJhuVW9UlqLAUQesIAp
	Q2/AAmW1FuH54gghKou8jVKRkqaquTJx2awBYO5w43euQvwIPm53QkbkZioOw/2nymDcjETzmr5
	bieM=
X-Gm-Gg: ASbGnctuuFTPyATjYZrEfepC33Aps2L0LsQxpZn68XpTbvM8/yzvwiHs6YtezKxnXjJ
	vQgoD7m99EzSwEPXU5uLmrMXQ/40yNejyvLsfovJPbRuc8C2doX24oRZuy689llgFTKM6KUjKmK
	ZZAlwpOUOswq1h7fsCIGijhTJ/NIvyuBs/CFMQiTBNGqlQbYAUKp1Wndeqp2OiA3PNU//2kbjDi
	9UsftG6c5umRsQChQamK3vq1gb/rfh+UEtro5Qa9hKft7iQ31YxKls6HaZxQnN9u5KyEPAVi9fj
	gfCZoysfPytG04balSv/xUzU4z3imFDNP0uFUmYpYn4ZgPtcr0yAHPnQwjhQJxwU1Q==
X-Google-Smtp-Source: AGHT+IEcayz8kgU1lg3CQED9SzRy7IOs3wuB/Ml+gvvDjA+trwdQHPT4s+mimwcRFuLHht6hN7IbyA==
X-Received: by 2002:a17:907:1c8b:b0:ab7:d10b:e1e6 with SMTP id a640c23a62f3a-ab7d10be924mr284094566b.15.1739222486455;
        Mon, 10 Feb 2025 13:21:26 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7d8e320cbsm50434966b.44.2025.02.10.13.21.25
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 13:21:25 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1076999466b.1
        for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 13:21:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMSNUQszUUUnQ4iMbrmr7k27bDZTG5/V4d/AF80ehTpeB+uQb1BFtvdMqTbzyTSC7ecPaU5w/VFow=@vger.kernel.org
X-Received: by 2002:a17:907:7f08:b0:aae:fd36:f511 with SMTP id
 a640c23a62f3a-ab789d3431bmr1642178866b.47.1739222485565; Mon, 10 Feb 2025
 13:21:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210185905.116290-1-cel@kernel.org>
In-Reply-To: <20250210185905.116290-1-cel@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Feb 2025 13:21:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wimOy=E0bKyH99cL6H0+C-k4q_iZB45t56eSdQ+UM2umA@mail.gmail.com>
X-Gm-Features: AWEUYZnk7bMSa0BmCnMJslUX6eX3rst_B5BqTSQJA2g7L8qK79o-q0e4-ikc0H0
Message-ID: <CAHk-=wimOy=E0bKyH99cL6H0+C-k4q_iZB45t56eSdQ+UM2umA@mail.gmail.com>
Subject: Re: [GIT PULL] NFSD fixes for v6.14
To: cel@kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Feb 2025 at 10:59, <cel@kernel.org> wrote:
>
> Note that my GPG key expired a few days ago. I renewed it with no
> expiry and pushed it to pgp.mit.edu earlier today.

Thanks for the note. Can you send the update to kernel.org too, so
that the key repo there gets updated too? That tends to be my primary
way to get key updates, because the pgp keyservers are inevitably
flaky and unreliable as all heck, ie

  gpg: refreshing 1 key from hkp://pgp.mit.edu
  gpg: keyserver refresh failed: No keyserver available

and the pgp.mit.edu web interface seems to be broken too.

Anyway, I've done the pull, but this is just one reason I hate people
putting expiration dates on their keys: the key server infrastructure
has been so broken for years that it's just a pain.

              Linus

