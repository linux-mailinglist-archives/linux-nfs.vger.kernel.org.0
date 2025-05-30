Return-Path: <linux-nfs+bounces-11992-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7452FAC8656
	for <lists+linux-nfs@lfdr.de>; Fri, 30 May 2025 04:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4243BA8D4
	for <lists+linux-nfs@lfdr.de>; Fri, 30 May 2025 02:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB4E8633F;
	Fri, 30 May 2025 02:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdgOcePV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC13B2CCC9;
	Fri, 30 May 2025 02:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748573132; cv=none; b=TX+ESxuKzK1fFNkDLikiSi1Kg/VqPiiV5Yq0d5rhjM/Kn1DJCE3SjQTXS9/kEF9lIg5fO2WX8dlZ+t3GXa8uiNDAnLh0gdF0D5SLubqhDjp/Dgs07cjDG5cncfjva3VQD8oY/01f53l1Zt/ag3doYi3+mTnFQiCSUV789NVBc+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748573132; c=relaxed/simple;
	bh=x18HnVhVbRhIWKpmltEGD1wKR/IEN2lra4oEUH168vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+CC3Fp/iLEYxcwipsEUVPP6MOCnWuJ3WiwDiSS3gG0QXnlb6fJOg+3L2vwT8o5xbj3bgGMQ/61FAfoUa0nwxmBLifZfM6WqCvwSlLycS86K5hF2jJYoRlYKh7dWTx5rKcMiMhUK9alJlWfKHl74EZ6WTKJCgvuto08n19BG1RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdgOcePV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2351ffb669cso8502975ad.2;
        Thu, 29 May 2025 19:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748573130; x=1749177930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoOjhXLY+ZNHRcoN2faE2b66e3GkcsBbU+4gzMj9KqY=;
        b=NdgOcePVWex7lYBd6mm9ioSKYVsCCN/BB0yDPYfhoiKzjscBiQQ5b1T4B8Dq1Z+iAO
         a+UNL1yBbho2Ic9w8tiQW0iX7Kc3pZl0qb3SbHjg7NcGM4jEyeJXXKBlGoOQQFqJXi+p
         LwaFeWGJ8mSMxb/aWQJP5hQvdf8yb9xstT+PwxheOmk9tuHJnLXoOI4rD7qLCUrKHw5e
         MmYFJ6acFrU/i95KPz/DnKinzX5H6V7nNbzjOF2ByHR9hrRqOE5PTgfJKK3aedPWInwV
         7UdbZrfIexAMFTqDOfQuK8hKal6Gq7tdTKDbb4wnNJJYsTTMFy1GPgE01x08Sn9I/TIF
         BHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748573130; x=1749177930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoOjhXLY+ZNHRcoN2faE2b66e3GkcsBbU+4gzMj9KqY=;
        b=EtLlhyEw0NXzoi/R8dgBiPoOrC2EHKMP0E34j+CNBnbEwmG5cM99UaCYyQgVEvtOYl
         LoEuzSuxg71OHnmUk9rI3gewXA6T3OA8pzOyjOAH3dVAt8sh2RcwZbEX+2zlamLzDnWp
         lB1fZnqJu/OeASGuQp7wu3+z5ar1fTEaogKvHZTWF4A4D1ik6tDf/qBcgZwuKg4t2MiK
         MGFH0CwTWEtnda07QaxcOrjXWLNm71iVZ5Ymfyn0qv5knvqeaNkEfCRTCkg+FvCZWVHt
         dLHqPcN/pb6aakr5h2cFurJBIZEw86lcMJ6rAMMJS9+PT9aiwih1ZBMKDvyvpM9ZmqlK
         6XHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV60aSkNT5+2QfD6x7GJMS7g/zkKG+2MVQWcBoa4RAIO8s0PYBF4dkIUC/3n0RH63K0Dgi6WQbVLPQ=@vger.kernel.org, AJvYcCWDJ16BV7BlYergudNuUV8oXaotK01pn0AuK0Xw9xjV0xNb8u5UYoki+zFojP6yxspkZTkZ5asY@vger.kernel.org, AJvYcCWxVzAV7S7Rnt9dJxaRDXWVuTrmFV1P9eJRFvVTx3WxO/MDgjHyUSg3gZ6l8ZRKfiyIj+yzpcP7Gj4ueA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/vMR67MoKnUfj6oH42XoePJL1ARuvrl6vm9G7NZIKglW3Hi3n
	A8rL4QPu4oTibNMfFMPk+kHWrXOx0kp65hKFwE3RhenlXO9RI1VxnYU=
X-Gm-Gg: ASbGnctRbrU+HFjTofN4ZWSwBOYjwrEp3b2DgqAFqpPGQF3HNySHkb+aV+aRuXyEq4G
	2e5hqE5mIFv21nz5ns/NRb+qOrj6m3SiESrZS/iDKQi/qgJTgswOGuWbMnMPNoFVwW7E1/jqcF7
	q7FHUGYQnpzXTXKkGZg6TiRlFkKieCfoC6cbgXmcdrSeKtTgmPTrfAYiN0YE1ZvjJRPDTvKrbX1
	XOShHgiC687hB5cFvQPHsaUbLKyIcJ7YYjdCxfTMrti4k2WKFRcmeXrtsLqCsSgohN0ulq9k6rE
	VCX/AMPjE6S5hrIWsGZ68OljwTW/
X-Google-Smtp-Source: AGHT+IGmhneqjdBylW4JYpgbPUNRknu2JzSpNlC2hWsZcakXdR7Ir8On6/7pieVXkB9LlKcYsiVkBw==
X-Received: by 2002:a17:903:3ac8:b0:234:bfe3:c4a5 with SMTP id d9443c01a7336-235298ef7bfmr26925495ad.2.1748573129870;
        Thu, 29 May 2025 19:45:29 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf504asm18767775ad.178.2025.05.29.19.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 19:45:29 -0700 (PDT)
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
Subject: Re: [PATCH v2 net-next 2/7] socket: Rename sock_create_kern() to __sock_create_kern().
Date: Thu, 29 May 2025 19:45:26 -0700
Message-ID: <20250530024527.3206724-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526053013.GC11639@lst.de>
References: <20250526053013.GC11639@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 26 May 2025 07:30:13 +0200
> On Fri, May 23, 2025 at 11:21:08AM -0700, Kuniyuki Iwashima wrote:
> > Let's rename sock_create_kern() to __sock_create_kern() as a special
> > API and add a fat documentation.
> > 
> > The next patch will add sock_create_kern() that holds netns refcnt.
> 
> Maybe do this before patch 1 to reduce the churn of just touching a
> lot of the same callers again?

Makes sense, will do.

