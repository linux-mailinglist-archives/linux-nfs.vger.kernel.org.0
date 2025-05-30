Return-Path: <linux-nfs+bounces-11995-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D70AC86D4
	for <lists+linux-nfs@lfdr.de>; Fri, 30 May 2025 05:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36753B1502
	for <lists+linux-nfs@lfdr.de>; Fri, 30 May 2025 03:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C2519C54F;
	Fri, 30 May 2025 03:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3kIvAFF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C4E155335;
	Fri, 30 May 2025 03:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748574192; cv=none; b=uDDzuWd9wdd2vmkMZT4qfDAE/f7ibh7mExfnWUZmBI/vkCAiwm+6Cp2TlTYWE6lhaR4zC0J2LK5S6ymJyw8YFvVPJ1h9BC/m1dx+F8lOZY/E4ix6T0ygC227NHtCzCA1cmDHSmFEABd5Ea9MAHb/XpUVNyNEd6SywbL7ade+YqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748574192; c=relaxed/simple;
	bh=fY2UoOoy29T8fOuG69Jaaa5QTGzSPBb8NXLKa12HEWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0+w+ED6hNHgC3dW9S5/917uYr7JWiDHwLVbnA+kFtnBjR4PePOy3tDd0U9a8AhpCzGN08iu4KcWwV9hwNe3BPI2elE7M2XKxYkg39nFKzOHGY3ewZ/Ps81UglH4h/tIL1AgEwHip+IdPR/4G099bp/U1Q2VF/BkITeQPpb5Xtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3kIvAFF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22d95f0dda4so19513185ad.2;
        Thu, 29 May 2025 20:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748574191; x=1749178991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byg1If193eSOY1N2Dud2MuR4SUJwfFVbrArGBlUduVk=;
        b=A3kIvAFFLOrPl4dWohuQxSYDHQpBKRUEXeWUhScnxs2VhKbSFA67quT8SSV01Mzt/F
         XP07nuqFT1isX3fRlL8rw/PH7SvfsAQ9sItfEHUQN8bnYelZD3Jao27eF5p4KwW5EDOj
         dFQ/DPMJWjAcIIk+NKLg6/rnIfONzazY1YqMS+7qnfPj8FAZBn0hikldnqTVburz/ypw
         M5RFMCJr2zZPEGSNbOx8NoC7ducvzt6Z+u4tNuCwZJ92OtSB0BSGrpgn0tIdGCb6EBV0
         X9K1uL51ZgE2nsb4q6ta6Z32lTDbEX7ivC20A6m41bSssQiuSYDMIFD+shuloqBuTsjo
         Z7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748574191; x=1749178991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byg1If193eSOY1N2Dud2MuR4SUJwfFVbrArGBlUduVk=;
        b=fsjWMQ8O8QRBz3JIV/fb6Trq052x8MUXU5UbPsO0FfIsqCgbs/PNBTCIMy66ToYcvw
         aByVnXtOglGdn4ZDmjyIyOuLpTm3f+GwpOg3A1KpFBx7EHZU5JapR4NKP3eSHWs1HteS
         efXPeC5dl/6NJcVzgiyYNn1AIzyQECOm73jui58vXB5lLrwqSdhP+5iT0S7xkXtVMk5t
         snIu4TJqPlsgJ0dIHtBow7L2MsrN4IcMar+TQEScXgcybiopjPooLjkwoBwc+tt1v0YQ
         6jj9XnlZ/lQ1O/1f+2+ESzZiSNe+/iK4V70bUGQIV6JqYeWwQoAaWPzjjGbg3CzIREme
         iuoA==
X-Forwarded-Encrypted: i=1; AJvYcCVteIGONq+ZKc29qUCXebDUpJS/sCK1Ulv1xgYyQ1tlQWrX5vCQJQdXo20FBz8BbjP/tcIfAEX7@vger.kernel.org, AJvYcCVz+FFI3H16JSVSKQjtBhoBW+WEszb7UCIdW+6XPNhdXQJJenJW84jxaH8aRYurXtUUYJePekwuFU4=@vger.kernel.org, AJvYcCXRfTvFR8rijg1eyvkEHz9AhBpFSbv4fUMjqblHe9ERIw1cSvjUjmDISXDrETVByK1IPOUyQnS8F5Vzxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp5vUJFJFQMmmphF9K376LdxZ+mH/9mLiqVtXr4pJc22ZvciHC
	HsVWXoFiydXCUrwsOH4K+djZ9aFglGLg070I9Qs54ukhrIQupZBT2Rk=
X-Gm-Gg: ASbGncsa2LXbb055Xz3g8WsNLSFnhCv6x9V+12a0B5lnbti9X4aSTKazQTvznRVfrJh
	pHP0WZXUOMWZyLzvoDb1zXT2X0JncDolYm/8+3PiWGZA7ofC5H9qZol/ktU9I5tTXQ1XKWgfLbq
	1dPeH6hEsAgkb+JmcQG4YJnKc570R28ohnB7HjR1Q56yrDE/vPcpppRBOQpoUhZp0M0gWq3Ffi5
	MYjmEgpNhC7RnKeT+n0Qu/XHke7O4kdAcnMBZUmkq+pFYUVAUbUep7QLUF2/HlUXplqarXd1m+l
	FlsA/6HKFXtyFMTStRGhb5xHjI1T5jFenub8MvE=
X-Google-Smtp-Source: AGHT+IH5+ZA6UonngWZ7LBmNIn34EiLQrTu0vlE4C8gBCmZnRcJjAS0SauUD8I/Jj4mLKSLrtUkOQg==
X-Received: by 2002:a17:902:ecd0:b0:235:5a9:976f with SMTP id d9443c01a7336-235291efe5fmr28715135ad.24.1748574190723;
        Thu, 29 May 2025 20:03:10 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bdc5f2sm18964755ad.96.2025.05.29.20.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 20:03:10 -0700 (PDT)
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
Subject: Re: [PATCH v2 net-next 6/7] socket: Replace most sock_create() calls with sock_create_kern().
Date: Thu, 29 May 2025 20:03:06 -0700
Message-ID: <20250530030308.3216933-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526053555.GG11639@lst.de>
References: <20250526053555.GG11639@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 26 May 2025 07:35:55 +0200
> On Fri, May 23, 2025 at 11:21:12AM -0700, Kuniyuki Iwashima wrote:
> > Except for only one user, sctp_do_peeloff(), all sockets created
> > by drivers and fs are not tied to userspace processes nor exposed
> > via file descriptors.
> > 
> > Let's use sock_create_kern() for such in-kernel use cases as CIFS
> > client and NFS.
> 
> So if sock_create is now almost unused and the special case, should
> it also be renamed to make that explicit and make people not accidentally
> use it by default?

I actually tried to to do so as sock_create_user() in the
previous series but was advised to avoid rename as the benefit
against LoC was low.

