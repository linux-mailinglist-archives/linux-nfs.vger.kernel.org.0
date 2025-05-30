Return-Path: <linux-nfs+bounces-11999-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89880AC8863
	for <lists+linux-nfs@lfdr.de>; Fri, 30 May 2025 08:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA9E188D987
	for <lists+linux-nfs@lfdr.de>; Fri, 30 May 2025 06:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8230E1F1302;
	Fri, 30 May 2025 06:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfDrnV1d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B891416B3B7;
	Fri, 30 May 2025 06:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748587716; cv=none; b=rA1RaGGg2IlgZM3OXjKb4z+f2efrgDnl6LKk2kNVsaqzU4Y/Upl2qbeESikBWy6BWQLCos/P51PmH9NNja4h7BjBJQRxhCNOk4lzT8wp9BvbOyG8/JvYDuIXYc9c0nhLs/4rV3Qr/UfzIYcvQUGlo1XDtOYP7t+Q7nO+f54naDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748587716; c=relaxed/simple;
	bh=OVd3ccRRjSS02LwNaHgCfZgft0/Z3cxj2pi99iPumfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJuwGwRPox/L5owBjz25mo3jU5iMJxHyWYiLNPpPIDWLvTme+AFuPNY/n9sLfgwdtJsgRDpU17Akxw0qtHAMd6LIiSD4U4vVAVs+qtW1B0TOhaUX+17nBtXv56lMiJ5v43iHDgAyJOPtRg1rz1aXD8N/9X1FviNanq/8Ic/sQzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfDrnV1d; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so17822825e9.1;
        Thu, 29 May 2025 23:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748587713; x=1749192513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXeEHdd/ecLGSL1wJsbS0R4oTX9iPXHDhaZvp+4M3y8=;
        b=OfDrnV1dObCTGzne1rYWe2dgOsvtBf2lFHPC/xPWeyido5amopbzEZOlmkFnpw6bSL
         IFB3jptCqJ4CNjKKWsTiCZuVbRv3O0G/MFLbfXExkx8BGdi76QXvF7hHrsv/Qq+aTPon
         FtAgsJpOMkaap61dte3DU3U64Tg0dVDhYp+LkmRSWE6L1ebnvd9iLgIdAThAur68IIuB
         VVl2wU3i003RyMsx17Sbhu3i1T78NZgP7h3aaTocR6TD32w2XHWFSxU+vXaUm/xjAWyI
         Y93w8LgWtTTahJxouwg8jLH9VQtwxOHoCjsZaRkZg583LF5rHThSHV2C23U5vvUciRix
         wqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748587713; x=1749192513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXeEHdd/ecLGSL1wJsbS0R4oTX9iPXHDhaZvp+4M3y8=;
        b=sIt6ej2RQU496tC2R5jWhWl0CtsYLYgCkcAi7LthLQFnV8XgPP0nHl5s/NUxmAEQlP
         mvCzQQowLw6EWNeRkblI1LdNXExQ6shzRj2ogZZMKiFOC4ntqfp1gM9Nv1z37DfG8Xi2
         k8Nd2kxcbZC8HDkGZcAE/I03lIQxHt0oF1vBOpsY36zOXqXgr9q2Lv7C778kVtRLUUeR
         IyVd65FhL7gAlRTQnprnz4mbyC4Uvvk5i8wjiZ4P8AQRkEQpOAvs7AS6VvAT9eUlLK5x
         IBeTZE4I7FQqWjLAv/EaIywT+1Zj00RD7O5NSwt3SAEFhebRyWo9DVivA23Nsrx8Vt5S
         8zMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhjvH+Yh/Qn/bfWbuJvO5KbV39UYPvgyiXSNks/fTzux0o8XqRZR7kqAMgDssafrnEGPUVrSFkwoQ=@vger.kernel.org, AJvYcCXEvMsTjVAdcU0Gof2pA68Zu3ommG3mcMiSD3n8M4Iwh5lxg/JnqxiCEu9hxxzC7FtfTI31zu7k@vger.kernel.org, AJvYcCXs505KcmLbjMzluHqisNk7S/aaSm9SJJ6BHg8fj9ftg8b720azCEt/s057dgUCwG41mHoA+gHZbHaQEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi3a3q92b6rQ8WugCjVjtGj8ul6F2n2xfoehdzghsfDhIFKav4
	MQepiQHM6N9+wss4LVUvkKsyfrAZ3n/AGMS4Pe7360d146iI9cYeJto/
X-Gm-Gg: ASbGncsvU8ZOWdpO57fFy6sAuiw7jgadj0wGLt0W2WT9iWNDKHLc1NAWqZsVXWrdlOn
	e0wWOjTNrOk40ONKKhQnsaXQ8X70oVsRUwK+o5xor07xiheG0qy2eXyuXcwdV5cfrwRUIdJ2HMf
	hDeIHjY+6C3VrI1Yyhc88IGu8khnWJUYS03LHwd1XzZvF9Z5BanZSorNs4gBBRjW8bwpSSrYMMP
	/Df8dKWi0Lp62RzF7sHZ4/d4IG173neQ3MCK0nQAp5sg63H0oI6JLfNPm05N4w0d+VT5f7dYUTz
	qvvtXLL2MAc1DVkOgFO0f7hL+13NnhzghsAV/xtUxgn7cNI3pVm2N5Zgx0TLWjEEuJNYbWeLkwm
	d7IujmqJywWxQzA==
X-Google-Smtp-Source: AGHT+IEaRQdrIbq47i1uTvqrOh3GYrjs1EZb1ZDSE8bNiRbo3NGeAP5Bc1VED5/Muuf7IvDxzlUr8A==
X-Received: by 2002:a05:600c:6219:b0:442:cab1:e092 with SMTP id 5b1f17b1804b1-450d64e0553mr19893275e9.11.1748587712835;
        Thu, 29 May 2025 23:48:32 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f8edf9sm9120305e9.3.2025.05.29.23.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 23:48:32 -0700 (PDT)
Date: Fri, 30 May 2025 07:48:31 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: axboe@kernel.dk, chuck.lever@oracle.com, davem@davemloft.net,
 edumazet@google.com, hch@lst.de, horms@kernel.org, jaka@linux.ibm.com,
 jlayton@kernel.org, kbusch@kernel.org, kuba@kernel.org, kuniyu@amazon.com,
 linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, pabeni@redhat.com, sfrench@samba.org,
 wenjia@linux.ibm.com, willemb@google.com
Subject: Re: [PATCH v2 net-next 2/7] socket: Rename sock_create_kern() to
 __sock_create_kern().
Message-ID: <20250530074831.76fd3931@pumpkin>
In-Reply-To: <20250530030547.3218450-1-kuni1840@gmail.com>
References: <20250529222911.37dc04f3@pumpkin>
	<20250530030547.3218450-1-kuni1840@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 May 2025 20:05:32 -0700
Kuniyuki Iwashima <kuni1840@gmail.com> wrote:

> From: David Laight <david.laight.linux@gmail.com>
> Date: Thu, 29 May 2025 22:29:11 +0100
> > On Mon, 26 May 2025 07:30:13 +0200
> > Christoph Hellwig <hch@lst.de> wrote:
> >   
> > > On Fri, May 23, 2025 at 11:21:08AM -0700, Kuniyuki Iwashima wrote:  
> > > > Let's rename sock_create_kern() to __sock_create_kern() as a special
> > > > API and add a fat documentation.
> > > > 
> > > > The next patch will add sock_create_kern() that holds netns refcnt.    
> > > 
> > > Maybe do this before patch 1 to reduce the churn of just touching a
> > > lot of the same callers again?  
> > 
> > You also really want untouched source files to fail to compile.
> > If nothing else it'll stop backports going badly awry.  
> 
> I didn't get what you wanted to say, but I remember the series
> passed make all{yes,mod}config.

One effect of the series seems to be changing sock_create_kern()
so that it 'holds' the network namespace.

Now if I backport one of the changed files to an old kernel version
it will still compile but won't work properly.
(Maybe you've removed the call where it acquired the 'hold'.)

So while the patch series bisects (assuming it all goes through
one tree - and it really needs to go through several) you are
relying on any backports picking up the changes.
(And also the changes to sock_create_kern() not being picked up
without all the other changes.)

Now backports ought to pick up the required dependant patches,
but it is much better to generate compile fails when patches
are missing.
Obscure run-time backport issues are annoying.

	David

