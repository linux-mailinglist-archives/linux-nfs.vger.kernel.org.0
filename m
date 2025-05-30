Return-Path: <linux-nfs+bounces-11991-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1286AC864E
	for <lists+linux-nfs@lfdr.de>; Fri, 30 May 2025 04:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89219E2B60
	for <lists+linux-nfs@lfdr.de>; Fri, 30 May 2025 02:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD0B15A864;
	Fri, 30 May 2025 02:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcsVB4kv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FF24A1D;
	Fri, 30 May 2025 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748572962; cv=none; b=GYrsAWGPvZpnK/1zGkzJDhbC3P+Qy2lZaWkTuxgRRI6RLuPelVvhhgBDTqqy0X/2+aYUkgysIsKDxP0B1AfFbc+5hSNbcY76MMdVtGwuZIYLhMey15Q7w5K7S8OyB80x+MGN3MbhYxvL3RSU4slDx/HJ47IsnelB6ffNCe2rJfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748572962; c=relaxed/simple;
	bh=ucWRPuZCVVXkBVEMMoVPY9Ji8+XQrgpQRlTZCU6HR9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFHzAleEAuI6TsHNh9PbE8+aQvs7J3egE5n7Y/SVEGKzVSWmTrEQWZxPNrW3d7EffmnKh72NTCiT09k9VjUTHZNZZbVVhtEUXUeoPrIk/effO441WaG+iTNCCgUpspPCkorGaRLOT4X5RsMBscWipdYlkoX+/I5+XILG2dus6kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcsVB4kv; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742af84818cso1019845b3a.1;
        Thu, 29 May 2025 19:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748572960; x=1749177760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EClwhMe2iqOJ1ZDRb/9izffcTJfL5lARyZSrEoMKU5k=;
        b=NcsVB4kvamhgkYw+evZZcrG/L7PjqT5oEKC+O+HDB9PkiBSk8XBV0hnEm8jVA7EC+k
         ivf7N6+Ny6yAWjQTdOp1U/19gbYFDm4k3tHLldXto6/Q5hmuXeW5IoJamjrBMIr3Wt3x
         SsIxJQlvKIKYPffadR5eT3jDDQZF67nBEL10S4T0Ok7qSrrYof2+Y5/8PO8Prq59S4M0
         P4loKZMkByn7t8lBYyRRPYC/qmebaifY1IsY8FZV7NjLHJc6SZBgSuael0OH2UXI7dMZ
         JfdRt+gt56NQO3gt6/xjZstb//dPipE1y83v4M36M4TdCSD3L1lhq0JCZSz5nDiJEMzO
         PxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748572960; x=1749177760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EClwhMe2iqOJ1ZDRb/9izffcTJfL5lARyZSrEoMKU5k=;
        b=Gg1a3nTU+hCwRJZDcND4ULqOEJs072Cikct3kjRqzbBLV4ZcRa+pTGSHLJWresVq4h
         ccntQ6oRMFRU+4IdUrs18CbLlmCoDUjH1KaRaNbYZEZFYmppPpm3Sc1/HxMlMXAwxeQm
         WL5JoKckmx63lMgurGqspxDggNII5KG1uwXOtiz38vl2F0AWmCNTK2kFB3Vq0BD93v+N
         XklKLNw64bBOYFN6RIkPzVI7LC78lN0qPT3BbJ7URke7KTnKldHVEcKSdhDkX2mzQ0Y7
         w/REvac9z4fxjBbbi1tz9G/aNRTgBHFoUBOBmIfFbmOgpbKym+MMWD29IifTr4a0n3+w
         TX6g==
X-Forwarded-Encrypted: i=1; AJvYcCUCc1it7FnZH/AlNySjfSuDPFmB8LK1E2usEwKPlluk/wI2d75wOgRIfBeTu9dZi5Qtuwx/OjPJupU=@vger.kernel.org, AJvYcCUzaZjXWXCtwaDbqUX6tMbd8ChewW6q0cdHqyzqo6kAbof+hjpqC2ozSjyMgU/9bvLs3g21ik9R@vger.kernel.org, AJvYcCVKNmWClL7LDplQIVcq3Pjc4TvavSNlTKhKI/PNkBmBbgmBK9Kj2Y9UAGSP0FqzjN6X5QHGBxlXA8aVFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPyQKSKmwPsU4r+se+CQGaInn5US96btXIymApNqjXMCe3ujyk
	lx+/bd7shdSeQRuy57egQaYt35sf5/mIjDefmRZOQQyUlWfwXmaxlwk=
X-Gm-Gg: ASbGnctIQcfDnMvfxHzaOuDaLLVIOsIyX5NfDxQf7K/3xTQoar4aqLsFWDvGh8YJD/4
	Rl79uIJkRkGF0Hn5WPs15eNrUnBQY0vp75M1MhVKEvARHNiTfOjs5OfBfKuQeSJ7CY1aIq7xFly
	SfSan3C2QToOT3A8q56C8xp9l1fR1qgu+9RGgrW+y5RKTf97tjpZHXpsBrZKnpk2wCI7LOT8bQ5
	cB8BpR51C18QB3MpzB9tzfJRIqn1t0LjiquUpLbEbe++K8qCf3P3MhWfeYJft1MvxpYp1l04B71
	0OAEBIC01Julg+nvFzEfHtaTEDvsA97mmLSVfXg=
X-Google-Smtp-Source: AGHT+IFkZ59DZl7jNU5F1Sz5H/4ysdqwbjBZOu4yMdNd5hJYzri98sUVF1rBQfHwd3ScQ9DgsM8UVQ==
X-Received: by 2002:a05:6a00:4fcd:b0:736:5753:12f7 with SMTP id d2e1a72fcca58-747bd94deb2mr2658447b3a.3.1748572960442;
        Thu, 29 May 2025 19:42:40 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeab0c4sm2019092b3a.48.2025.05.29.19.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 19:42:39 -0700 (PDT)
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
Subject: Re: [PATCH v2 net-next 1/7] socket: Un-export __sock_create().
Date: Thu, 29 May 2025 19:42:36 -0700
Message-ID: <20250530024238.3205130-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526052907.GB11639@lst.de>
References: <20250526052907.GB11639@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 26 May 2025 07:29:07 +0200
> On Fri, May 23, 2025 at 11:21:07AM -0700, Kuniyuki Iwashima wrote:
> > Since commit eeb1bd5c40ed ("net: Add a struct net parameter to
> > sock_create_kern"), we no longer need to export __sock_create()
> > and can replace all non-core users with sock_create_kern().
> > 
> > Let's convert them and un-export __sock_create().
> 
> The changes looks good, but the commit log including subject line
> is rather confusing.  What you do is to replace all uses of
> __sock_create with sock_create_kern, which works because
> sock_create_kern just calls __sock_create with the last argument set
> to 1 as those callers do it.  This then allows marking __sock_create
> static because all outside users are gone.
> 
> Please state that, i.e.

Will do so.

Thanks!

> 
> Subect: use sock_create_kern insteadf of opencoding it
> 
> Replace all callers of __sock_create that set the kernel argument to 1
> with sock_create_kern, which is the improve interface for that.
> Mark __sock_create static now that all users outside of socket.c
> are gone.

