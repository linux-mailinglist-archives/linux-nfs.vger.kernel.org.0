Return-Path: <linux-nfs+bounces-12106-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 707B5ACE471
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 20:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D72F7A6C1F
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 18:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BA21FE45B;
	Wed,  4 Jun 2025 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cnro/LL2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A87B7260F;
	Wed,  4 Jun 2025 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749062257; cv=none; b=Ad2QHaz4VU4gOat4laxlskrPVW87a5hyaqXz5G6/LlIdZwWBQdCU1ystoB6aCtryOLu2VH6XCl2ZefbWopBZjfHP5ZrEzgOj1KA3p4/hORbSAIjficjUYcJZk8qnPeqNhgFAC228riCH/3dNW5iGBcOmIe8nQ4lNAjfmpoOkOjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749062257; c=relaxed/simple;
	bh=kMacitpLXMv1GwpjR46stCcXET1RA/LYFLgeKG2ri0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NufkR24cZ5svXpKyzZVvxK3DEkur7RVatpHExwoCRgCiau1L1Nda70TwlLUYgPdnQSCkL1PBUw+U2eXRAH5D6eKccBR31esFmecm37coM7CLwCs+M41Lr7EgwiLQRTUqpa06lSP6If5MY1HKgbAdxi89m89tsKzt90NJ93yhxvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cnro/LL2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23526264386so1507005ad.2;
        Wed, 04 Jun 2025 11:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749062255; x=1749667055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMJKoOEyvjYK7yMgj6XYrB7SCgQJhbeYmY5wKASLWgQ=;
        b=Cnro/LL2772IgfPvBkcj02q0G22wGtxA8oVHUIfPS/6i5JI1niOK/8UGgZ5yyvbC85
         rGJg4XnWLiinbPfCbtheI1Mdn4no/w4kY7u/Gkxj+2nu3IgKzxFM5Ax01Cg5hDWvlErW
         wVHZXLXFy5/e79ZIPXde018nbAuY1j9yGon46cJX/icgcFSPPsyD5XcHO9R10UQqaOMV
         Gut+tNvjBwJwsSKJpOmrG15Ltc7t7Tkz7WoLrNAknPUPi5mq2/cnDWQGFfmreu2JPKSH
         j8ajrW8SptgYUUfY3l4R45g5/fswpIU2mb6szkeeBM3HduyWJLND3x72oA/Gk2LQ0V9T
         tUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749062255; x=1749667055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMJKoOEyvjYK7yMgj6XYrB7SCgQJhbeYmY5wKASLWgQ=;
        b=Lw1kkFEsEekJ3Y7k8xIHj9xdMCkofnl8AI9L3eu9W+Ae5rJAmFlfrA1xKdfvDiC7xc
         PWblmrm8ZQzCzxUNme9yK0Qgr9Oni8utLNUjfxapOWHKUfoqtJgIN56W9kIm4scRht1v
         yzN+uOds/EpbdbbsFWer4Z8gpDjZviGpLH7uVg4/10946ID+gJLQAGRm9DbnhxpXbS2E
         nIoohJf8mApE+K56SJGBcgCjEproiaS2zUm4X2pmTCNKTD7YlNCZIWbLLwteCvwruNqg
         g475KeITNL7GrBZ6GOsMgjsLMs0CZC43aaa3OHFJ+VBJnjLhD2bp7RCKj9OdTG4wyaYp
         GRzg==
X-Forwarded-Encrypted: i=1; AJvYcCVG4hxnkiB55tP5sF6bMSiUJtpjpeuNi7LFFI6jOB0ojvVc8sRzsAkbGn3RhKsLf2gFcbdOKA76gYfYig==@vger.kernel.org, AJvYcCX83t8MlTlH+cCwDOYTX0xKpWAtC2JpUnXHpnnSgRauHdl3nNNDAzeXXUcQ6mY+Sl0CMtRccf+UE6c=@vger.kernel.org, AJvYcCXsshSbWBN9N8PQNKFu8+WJ/mQrk9JwvoDOmIGw0vHifxRv1r+0gdng2v2dzJf6T/fyQD/0twNi@vger.kernel.org
X-Gm-Message-State: AOJu0YwdHtusHQPbf78sH4cpGmexl72o3d7TC225XVS0JSeiIemmARVW
	mBfEkE6J+JIv/T5kd2HywwYlLoANp6bQ137qR1NLWI4azb/YZXZZCac=
X-Gm-Gg: ASbGncto7WFhZHMIJzWX4FjNzENIxmr1umyKRKxGgxr/2WeaoVdwe2L7LFNFuo/Ybvu
	RmnryC2spEj5VuQE2YqDAti0dwVHgnQ+xPHbLvSOjFjmx/rs7/EWaZYRBg+/gG5fQdO8CzaH+wA
	I3spq6nHEKHZkzqyE63AtwhSjkeS6s3sZypbM5uCugCRahVKP4aQIx7SbZmHUpxTGi330IcqSuX
	Xm6VsJlaYU+FDECZBo0VrRhj4CpffCCIP+xOeKsMvRj52+1FGf6dE9YDt5IG7inZSlgLpD2zXmN
	D5+owXLg9YyuNr5xXOtz2Q8hI+i4
X-Google-Smtp-Source: AGHT+IHzeMlOG8WaEKyWojPC70HY/eTfvQSuJDc6Tquqle6do5jo7DuCE23TvCyOkWhB0uyKaHd7DQ==
X-Received: by 2002:a17:903:3d0b:b0:234:a033:b6f6 with SMTP id d9443c01a7336-235e11cb901mr52517545ad.31.1749062255383;
        Wed, 04 Jun 2025 11:37:35 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d14c63sm107254965ad.241.2025.06.04.11.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 11:37:34 -0700 (PDT)
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
Subject: Re: [PATCH v2 net-next 3/7] socket: Restore sock_create_kern().
Date: Wed,  4 Jun 2025 11:36:43 -0700
Message-ID: <20250604183733.135820-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603223020.3344d362@pumpkin>
References: <20250603223020.3344d362@pumpkin>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>
Date: Tue, 3 Jun 2025 22:30:20 +0100
> On Mon, 2 Jun 2025 07:08:17 +0200
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > On Thu, May 29, 2025 at 07:53:41PM -0700, Kuniyuki Iwashima wrote:
> > > In the old days, sock_create_kern() did take a ref to netns,
> > > but an implicit change that avoids taking the ref has caused
> > > a lot of problems for people who used to the old semantics.
> 
> That must have been a long time ago.
> Was it even long after the namespace code was added?
> (I don't have a system with the git tree up at the moment)

2007: 1b8d7ae42d02 ("[NET]: Make socket creation namespace safe.")
2015: 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns of kernel sockets.")

It's been long since the implicit change, but it's only _recently_ that
people started to notice the issue thanks?/due to k8s use cases, e.g.
fs mounted in netns (ef7134c7fc48, 1be52169c348 + b013b817f32f, etc).


> 
> > > 
> > > This series rather rolls back the change, so I think using
> > > the same name here is better than leaving the catchy
> > > sock_create_kern() error-prone.  
> > 
> > Ok.
> 
> Except that you are changing the semantics again.
> So you end up with the same problem the other way around.
> I can imagine code ending up with an extra reference to the ns.

I don't think so because it's rare case where we want to use
the no-refcnt version and it usually happens under net/ or
drivers/net.

Now we have SOCKET entry in MAINTAINERS so I can add sock_create
there so that we are always CCed to prevent such issues.


> 
> The obvious name a a function for general driver use would be
> kernel_socket() - matching the other functions that were added
> when set_fs(KERNEL_DS) was removed.

kernel_socket() doesn't fit here as kernel_XXX() takes struct
socket, not struct sock.


> 
> I definitely aim to end up where the existing code fails to
> compile - just to ensure all the code is found.

You can see the patch 2 renaming sock_create_kern() to __sock_create_kern()
does the job to find all users with the help of compilers.

