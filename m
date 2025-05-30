Return-Path: <linux-nfs+bounces-11994-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D705AC86C8
	for <lists+linux-nfs@lfdr.de>; Fri, 30 May 2025 04:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D09C165793
	for <lists+linux-nfs@lfdr.de>; Fri, 30 May 2025 02:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E95191F91;
	Fri, 30 May 2025 02:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuuWTqNm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A4C78F52;
	Fri, 30 May 2025 02:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748573981; cv=none; b=lbmZwi2gDYv0l4ASVtEAknSSsZJdJQ1K8pZ1FiEChHUyOGDfyJxoupJzurZrdrslxsh30Eq4nwjab8a9dpihOKxBIe2+b18xCHGKEXQPrqiy7XRpRAjatG3FPKcIu9mLStCz1wQLh0zX3fObxZyWhE3QjacHozAPeUizuhEVD5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748573981; c=relaxed/simple;
	bh=dwlSDKJOBselJa1Xc6f39rzrzCGs8bColAIVJ55Jb8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q71BI09I/zXgaWMqeOaCp1sn2XdxbAPaf3LnYlbXJnfswl2tNZ3gYWSAnaOYb1D1mZNRKM0O+1aDM1XJoxO+W48nPBkDuMgNRQfqK2L2yPW4JYfejfZaSJ/5Ut8DJsiBuGscUPd0byOxFZqDHv+ZQMchvCE/mQ3HGQ5s1Fn6AWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuuWTqNm; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30e8feb1886so1579217a91.0;
        Thu, 29 May 2025 19:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748573979; x=1749178779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sVgqziKNXk1VKHFZ3xvpqcIL2UFykT0jMs8udwzfSE=;
        b=kuuWTqNmozAxpd/TGe/p2YXNY+hLxwBsSGWVKqJsOqH+A/RnEyInmf8+Jmi5oQyyKJ
         bC8cyU+EaohRJlDQbxigf5BuFsMjMnoBZMvS24k8DXgPNJE+zFxlWGQc3KoaR7fLP2rp
         6OehhTOPL9mbwqLI97f1/Cx+WjSgGI4ov5A6FcJ8vMojD1DYUeO4t5mAzhNJk9TBcXCl
         saA1jmJ4ydleIVaPrRsbeM3AwGcFn0ROiwg6uS6r1rFGzb8raMhgu/5B+VDc1ILrcto4
         bg3YlsLh78S0Jpy/DmZnagfMkMyhcno11HpqPHgOUulL34E1UtOT4SpwrKtGXdMzdEH5
         IhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748573979; x=1749178779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sVgqziKNXk1VKHFZ3xvpqcIL2UFykT0jMs8udwzfSE=;
        b=Vv17zVMCmeN4X0GHWWgRo7Y7Y1IIVEydIVWGHj0tfpikNEgm51BaM0/JB1STTrpuGS
         wAtGAgW8xNxfxxorZ3F/hHGlmjsciYRxaJEC7x2wNLAY1DIf0Iz83BqvZ25Qkb0ptUfA
         xQUqkidQ48uSJL22HnfgslkiHmV1pxX5ctfjlp8MQzrVtPJFmaa0SExVDZRkDP0qetlG
         N78wu8+L9W41keRyS53zdqxEoH3SR2dRfA98dgscnSbPXT2X00kzZwimLVUir/HlcEAo
         Yk9yHkcWv0GMNRjTALmZGz04rGvt1uA6Pzlk+JCd8YDsiotpCzVO/8jOj/NbV0bOqaIn
         q/Wg==
X-Forwarded-Encrypted: i=1; AJvYcCV0SLvp8+VCAd6w5Fwqis6yWqPHtq1mkd39FI89mz8oc6N9oOtrSFmwf6gqm7MQWXc6pD+4SWctrkrBpQ==@vger.kernel.org, AJvYcCVji1YBtz4i8TfmLPpqBCynaChsCe5X0yUwMmMjMW+8MVzfaToCYDSlDT4as2WtNYKdPY7JKWsp@vger.kernel.org, AJvYcCWlo9hNZtHgpJx1n4LoCsJUQuDX8MNsYfOe/nRsc3yrM5ijRL9o6G1+XaVge4oAiLZtq93jWQSclfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkwSZiizWlJzjfJgAsi8gHm1FiBdCKAjSNq3Wwbkmjjampts0h
	Lt4DTxeIRC5j75U8pCK+ixq/VaDiAubwa9XKuIpfCcykmhQ2z2OuGH0=
X-Gm-Gg: ASbGnctwTlNo65T+Sf8OmcAO0Q1eXZpdPk6aQQgSQrF0bell+NLlh3qwv1f7Bl1vURy
	4cIhAEfB7+NmUht0J3uebDw+ov3/P9vsBnH95gJQDUeUGpzP2wIGZrjncY8eg10sLsQe2O69wZ4
	i9/f151RBV+gE5T4XNEr/Nh+QTgaHREZS5YCOkcVyFMWZDHKdTJ/0X5y9Tat2j5SjwzcSSX0Guo
	HFwBp9h3RpDccWYOcX7/I0L7G8zkBvXUTjp5HgmT8Sunf3S7QjC8OUvZ7N8XnFyonqXLuuPZCog
	uLP0K2jTWo2N7ll3bjPXnP9O6Twb
X-Google-Smtp-Source: AGHT+IHAp+B0ti+QnJpuPvLDos14gktvJbY4vx5x1X1dIQardFp/ZXV7fELwwD6fMQPTpZOdVEzadQ==
X-Received: by 2002:a17:90a:e7cc:b0:311:b0ec:1352 with SMTP id 98e67ed59e1d1-3124152772cmr2869665a91.11.1748573979187;
        Thu, 29 May 2025 19:59:39 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f8aasm280977a91.8.2025.05.29.19.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 19:59:38 -0700 (PDT)
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
Subject: Re: [PATCH v2 net-next 5/7] socket: Remove kernel socket conversion except for net/rds/.
Date: Thu, 29 May 2025 19:59:33 -0700
Message-ID: <20250530025937.3214873-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526053321.GE11639@lst.de>
References: <20250526053321.GE11639@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 26 May 2025 07:33:21 +0200
> On Fri, May 23, 2025 at 11:21:11AM -0700, Kuniyuki Iwashima wrote:
> > Let's drop the conversion and use sock_create_kern() instead.
> 
> Please send a patch per subsystem that is converted to make the
> commit log better and help with bisectability.

Do you mean splitting this patch into per-subsystem patches
within the same series or sending non-netdev patches separately ?

The former is fine, but I think this change should be done in
the same series as the main goal of the series is the changes
in this patch, making kernel TCP sockets hold netns ref in a
single place.

