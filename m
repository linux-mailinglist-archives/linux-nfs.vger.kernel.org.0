Return-Path: <linux-nfs+bounces-11996-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA230AC86D9
	for <lists+linux-nfs@lfdr.de>; Fri, 30 May 2025 05:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7FD17D7DA
	for <lists+linux-nfs@lfdr.de>; Fri, 30 May 2025 03:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A66019307F;
	Fri, 30 May 2025 03:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6JD25fv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213AE8633F;
	Fri, 30 May 2025 03:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748574351; cv=none; b=LgyZ/3IyMhTrELLGOcWdhC2+5octyLjNprMcGGONs4c1DPsVwPnJkVZwgKEOIJMWLuoUckHuXceqj595oTr7rqCIDWjVTLTRxq/BP88m1tz1U9EwQ8YcYvtJ8pwjvQ8Cb0dKyf9a+dJJwt+iTXWWxbKOoQeBaG/s8qgR6fnifU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748574351; c=relaxed/simple;
	bh=edBmpu2EbuwPVO0Ul9xbaj2VkJit3GU9D4yzE59NprM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tr9KokLbA5HguEKQfyqIsdwrMGUt/TZyDvz1tfH99nu4qK8154E6omJcYv4S2I/PgPFDL1/FNihba4ks4CZZWWpsyHEf0Ojkg7o9Ojwtjkyg/Wm+4SNVCqB5NlUF4lmBWcuWG2fbn3bz2wMIUWTs3JIbwkBR0lhOoK1CSJmFyY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6JD25fv; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30820167b47so1348674a91.0;
        Thu, 29 May 2025 20:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748574349; x=1749179149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmPcB9BfcVMhwEccIgDzRrLtI3gadYfq3Hb6mk/3dV0=;
        b=D6JD25fvmiNfbjc5nXouATSP5jQNbNy5aI1aaiWG2HEQe3ysx2oRlP3CAzcyW0SGCA
         ESB/34gMwwXt5sC6yNWhE7RNLT2jNrrcQgtxvizWRoP9yi6SaBgmbkzygCsCaE8E1wLv
         7b/XxBhez8yAv4a9CM3Apnhq/e9pksb36tlWW4m0RtHh+D0H/9gkxWPSXu0PsS4A5IXJ
         dcgtwjsIEVNOPUIHCGHWJHq34d4rw2e8Xekuv/lKtd5i30BDlC4tLZmk0seF/TPqdWEP
         SajDI7k5LzLz/fHsBkp5w6hewNhC5cgbbzIjD9EvEMIHQdzvHXaWIrcdZI9MqvJWAi1Q
         d1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748574349; x=1749179149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmPcB9BfcVMhwEccIgDzRrLtI3gadYfq3Hb6mk/3dV0=;
        b=WfBp+tWbX4FH+20Eo+6oskRmmffudEIwTiouoMLM5DVAbs5OJPVO/w44JysRsmvugP
         wQCfjfKf+hxVU5TVaHyBAxYHammBJP3gOnUXw2zP3cbFg1/X7voGCFQfnqA7aude5U0w
         jFOvyrjxZrnGiJLPGU0pN/l9+H5Z2w9n2E0CHu61ijSYGWzyx62Dy70FoFi8w2qwfMwL
         CVyG7kZeqUoIBBh1vCe2UwF1/bKtyNwh6TCDDdFvyzfYgGfDortV/XW8c2du7j3y55Pv
         KSviRbdQg5j9IsJVSwJobBLugUYqlvWQkJ0Zrm2eBbqQQr0fLC8nSTs/knPfx5Bt9zVO
         CPMg==
X-Forwarded-Encrypted: i=1; AJvYcCW8DJKeksjFaa4rfDyZQH5NTd+wpjnGVSNo4cQZiV7wFWzowg4A6UUpjokejZ1GUi/kRwRCBGBSRws=@vger.kernel.org, AJvYcCWZQgWRpO03kwuQF8MzKR9noVTNcNuoY+DYfB+HZzy8Geti+oViCh7vIf9jWlvHPql6gCn4xNe6@vger.kernel.org, AJvYcCWs+Ud7LQXO7BY5ltfKK5IXThsWAM5wORvA9ZsZnqe5oepyJj1YdU5edBV6h/1BdYdp5MilCYfOAfySZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuwwV440MV8BC7LD1UOgJeO1B2qK4oy3ZkLGtgQ0QXBWLyOyRe
	C16vOrSh0tKCWkGHBNV5lvd4eS1P7mdMPRvx+3aX5W+ms0B6TUvNYSw=
X-Gm-Gg: ASbGncszKkZraa8fnB6KJiPOs9nVpaZbhm4KrDun3OtMsjR+vGqUMX3DcdbB+auF2T6
	r1rKnwi8VLwODNFls02qrPqaXYspuBxN8SF+ilM1LfcdZWXUOGpJ9I9F/gPA6MHF9WmDuPSVzUW
	GVD1BOixhlZzOKVU0eoQwyaYLJW1rqBw4dyEuBMiCdQExa3PuafS9ib+GnWOotXFrqDK0HcYqOt
	xqq5WTlmPVGZI4It4H/CiLrFib/jy9J9WGbynlTtXlDJODylsDLU2blAspLXeV/dF2qVpfwkHXp
	dd111cY0FkWGoebN2PIZ1K3aa0+7
X-Google-Smtp-Source: AGHT+IEcl2OlOzz1UB82Nu7h/Z9cH4Jj1R69n+B/6JvMm9cqj47inVhScwG6zaOc33eUuhbAG+o3GA==
X-Received: by 2002:a17:90b:2f03:b0:30a:9feb:1e15 with SMTP id 98e67ed59e1d1-31214e2efabmr10028386a91.8.1748574349270;
        Thu, 29 May 2025 20:05:49 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e30c705sm244715a91.37.2025.05.29.20.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 20:05:48 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: david.laight.linux@gmail.com
Cc: axboe@kernel.dk,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	hch@lst.de,
	horms@kernel.org,
	jaka@linux.ibm.com,
	jlayton@kernel.org,
	kbusch@kernel.org,
	kuba@kernel.org,
	kuni1840@gmail.com,
	kuniyu@amazon.com,
	linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sfrench@samba.org,
	wenjia@linux.ibm.com,
	willemb@google.com
Subject: Re: [PATCH v2 net-next 2/7] socket: Rename sock_create_kern() to __sock_create_kern().
Date: Thu, 29 May 2025 20:05:32 -0700
Message-ID: <20250530030547.3218450-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529222911.37dc04f3@pumpkin>
References: <20250529222911.37dc04f3@pumpkin>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>
Date: Thu, 29 May 2025 22:29:11 +0100
> On Mon, 26 May 2025 07:30:13 +0200
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > On Fri, May 23, 2025 at 11:21:08AM -0700, Kuniyuki Iwashima wrote:
> > > Let's rename sock_create_kern() to __sock_create_kern() as a special
> > > API and add a fat documentation.
> > > 
> > > The next patch will add sock_create_kern() that holds netns refcnt.  
> > 
> > Maybe do this before patch 1 to reduce the churn of just touching a
> > lot of the same callers again?
> 
> You also really want untouched source files to fail to compile.
> If nothing else it'll stop backports going badly awry.

I didn't get what you wanted to say, but I remember the series
passed make all{yes,mod}config.

