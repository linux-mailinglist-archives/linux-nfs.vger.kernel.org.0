Return-Path: <linux-nfs+bounces-11993-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B32AC86C6
	for <lists+linux-nfs@lfdr.de>; Fri, 30 May 2025 04:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C22C18830FF
	for <lists+linux-nfs@lfdr.de>; Fri, 30 May 2025 02:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390B2227EB9;
	Fri, 30 May 2025 02:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fr6KTlTi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9323B227B9F;
	Fri, 30 May 2025 02:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748573646; cv=none; b=QVegVo+ZojKtBQ4UyRm7VN/nXSK2KU3CSi3fE/x51nDLLuEhyFUdgykeSaxgi7i/RtsuLJ8uhzN5gE5dwU7y2WnQh6GFNlNDXsv6O93CCO8sX4w8LTuooVWZ27yuLZH/f3mT4X/BsfyHEfe9S8h3UYyLNbJloQGSQLuc/iEgEuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748573646; c=relaxed/simple;
	bh=ru9a6sY4ZvkfZZSCB/5pKAsVZvCUON0+3IAKLW5UIfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=soh74iyDsiqXtAX3ZnG2qRAMA67uh0CWj6KfV4bXxxSXLzaiim2xwfShf+cvXG5cQlIGWGLtVewQ+sBuT5xOoS7eS1OVU58AFaxuDcHL8DqqbHRAMOIhrLzg/En+Kmy8/OgTVNO5h91ApwiVYp/pvw/s0TinB2etf9MwBu7lC4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fr6KTlTi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234c5b57557so15693835ad.3;
        Thu, 29 May 2025 19:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748573644; x=1749178444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWyxMFb5cX5nYvnzZ8Z+1Eedymi4rZCZ/8P/Gr9oFgw=;
        b=Fr6KTlTiCzSWtuLO1aDqK5QkyiSaJXvtz4yaKWkDDq1l4DQGK74UwNZ/U+VNFoPOQj
         gww4Vcahj8xRIoACeH32wCOTu6WIak38OGvCF2okQfUeWYI3jWQdnK+XEM8Fels5QKCD
         BGi9F6kS91KxnjYWyJVExSsoJ3ih08e1qCZM4i+xvqh4kUJljY8jl4Fx3X/epWx7EBna
         zIIxRHAHeXtOH855d5YHundxXo/igm75kNIQl8Z7u+FUjVSb8AKUfA13QVUAUXUmgIIr
         lMyomjeI1EqKh7jM2G1eCuMVna0L6qw3MQEGKBHE3rtZOlmo3FY+sK6wPkrBIBrBTKdc
         yZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748573644; x=1749178444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWyxMFb5cX5nYvnzZ8Z+1Eedymi4rZCZ/8P/Gr9oFgw=;
        b=pRxMTSUvq88S7Rq24g0e542N9qFccJE2l9NV5X4sG6xUierydRm1aAR+pGGAdVBb4a
         96nGmx83FtP4jl+0Sr6t1am79qAQyb0HKUGaF23lpqjumNZtWNuVG/uT6Mi6B15JhI+O
         MK+6YHmrOMV50k3i3ZEtIB7R8jOhtVe0e/aDuzXqvUJaSPimvdIDZIfvbSNR/lTIJtTv
         /p7QHgKTPeXlVZ38lz9A4h/O/BK/9UN4Sy4JyQqbXiA6ptULhEv204S4WNUnLk2nr08d
         vwhz0c2Y+SVAGOA6yX9BVOGdR3JZDUWaDRb5TdWQ59mGKB0+09fU32cf06rX1IntBtyY
         q4lw==
X-Forwarded-Encrypted: i=1; AJvYcCVcmZkwkBZTEhvSDjSVHXyQ09UxNILdEjWPD+L/a2/ozJ9yEb7fCBewiRVGbpNiHCjjERQeuQjOLKSjDg==@vger.kernel.org, AJvYcCVdddSKESgLFp/efSZajIF4E0sA3SIgUiTFCjkQ7xrjX3diwIPRoY+4/On6nwYggWdpD0Z/QVSWDiw=@vger.kernel.org, AJvYcCXxNsBylGi9DIaGi8Hd33c+eQxoqv5UOtb9NcZpzWFWUqojAJicD5BaEIgp1dUAMj7c3kVHS33O@vger.kernel.org
X-Gm-Message-State: AOJu0YwY135nvtgo4gDN1V0fffWlQXDiLFciBWeMi/MAskknqYC4Av78
	VnjFzEC/1e9YGtiNcamO5XCOAFqoT+Wg32VybS6jaCIh/xDXwyo872k=
X-Gm-Gg: ASbGncvJt97fK7B4gSGaZ80Cg+YnD7m44pxajvQkSysIxxf0idNw4jHarhhoVnxWW6C
	OYJbbWMBNLRbbPfwEPpWNO5byvhw1hhsrHkNmSU0wVBKvPHVkSGgnkojVf35oBZOF9nsISQq7Su
	jeiRINfA0nvfqZl62jMZSUCYykEGn08QHVPeaMCpw3SWkBAj0cXOCZ4qXPadq+4+7VPPn93np8A
	YBh0tpzbt0wJUUFlEdJeyeGocJMYg/8FHDYJQVIxpMNnnmrpaX1bPqHi432w+l/zF8GZSQN39Y4
	dfjlyqfBaWZ//ltNPt4AOPSAmBXY
X-Google-Smtp-Source: AGHT+IGgDezX7cz1uOZykPYiPInz+eIk19WtpZF+nVK4hwKpEI92osR/Nx6vpb7wz1AjRVv5hZda0w==
X-Received: by 2002:a17:902:d544:b0:224:10a2:cae7 with SMTP id d9443c01a7336-235396cb241mr8527095ad.40.1748573643807;
        Thu, 29 May 2025 19:54:03 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf9380sm18830305ad.203.2025.05.29.19.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 19:54:03 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: hch@lst.de
Cc: axboe@kernel.dk,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
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
Date: Thu, 29 May 2025 19:53:41 -0700
Message-ID: <20250530025401.3211542-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526053227.GD11639@lst.de>
References: <20250526053227.GD11639@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 26 May 2025 07:32:27 +0200
> On Fri, May 23, 2025 at 11:21:09AM -0700, Kuniyuki Iwashima wrote:
> > Let's restore sock_create_kern() that holds a netns reference.
> > 
> > Now, it's the same as the version before commit 26abe14379f8 ("net:
> > Modify sk_alloc to not reference count the netns of kernel sockets.").
> > 
> > Back then, after creating a socket in init_net, we used sk_change_net()
> > to drop the netns ref and switch to another netns, but now we can
> > simply use __sock_create_kern() instead.
> > 
> >   $ git blame -L:sk_change_net include/net/sock.h 26abe14379f8~
> > 
> > DEBUG_NET_WARN_ON_ONCE() is to catch a path calling sock_create_kern()
> > from __net_init functions, since doing so would leak the netns as
> > __net_exit functions cannot run until the socket is removed.
> 
> Is reusing the name as the old sock_create_kern a good idea?  It can
> lead to bugs by people used to the old semantics.

In the old days, sock_create_kern() did take a ref to netns,
but an implicit change that avoids taking the ref has caused
a lot of problems for people who used to the old semantics.

This series rather rolls back the change, so I think using
the same name here is better than leaving the catchy
sock_create_kern() error-prone.


> It's also
> not really an all that descriptive name for either variant.  I'm
> not really a net stack or namespace expert, but maybe we can come
> up with more descriptive version for both this new sock_create_kern
> and the old sock_create_kern/__sock_create_kern?

