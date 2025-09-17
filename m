Return-Path: <linux-nfs+bounces-14525-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDA1B81D3D
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 22:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693441C22C43
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 20:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F2D9478;
	Wed, 17 Sep 2025 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XTGr15zW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1E427A92D
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 20:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142113; cv=none; b=c2hv3NEbJo08qIeBsoOat8rx0iuToK4oeoo5cvsWAWzsVQf/YtSTZbpqDayFAbOi+dewlYAIMHUHZwuUdbKoQ97+MsYWpu9wHb1F1+owrpZD26vnFTeyTXPYbGf+DI0iPrz6j6AgR2NdDa2/iEdYhl1ncn43BWmkLbCkwsemVmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142113; c=relaxed/simple;
	bh=AxqRKz3eA48ph826fnBdpFVe7MMAtvt1VZv/eTYFVaI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LWKTew2thWlpdagiqkKq7QWjehZFbNuyKG9ZTNaOa9gdMdecpcWkMQY91/gbaDZjsJ8cc0DEaFg/1WHY4S8vau4WYaI0qxbgfCKxLyrKBeILXG/JdmWH8I03dPD3oMaYxyXPvLKsmc+UJHEAI2Dz6RlxGa3MxtBG0iXkQVx6oNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XTGr15zW; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso330354a12.3
        for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758142110; x=1758746910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=35qjjGAJKDn0K9qQpxc6vWIVoNZhWZ4EPFnBMDSRYzA=;
        b=XTGr15zW/wbXj2be6ET1nULBGdlr8ee3ybpB5xVu7UvE6UP6NAbIAE+OUOWAidrq2e
         ZF3He7o1you3uuKSgIP9eEO0TIqG6RO7utS8jMqWJJcC3Tkf3mdSBDpeFm+pkPjKu01f
         hlOfMAuTvh6DKtZ5AnFV1s6UaxwNt9873o1wg039/vBB5zsOueuzfnHAOgTfep0/ilZq
         dx/YLQ98ZaQOabjf2z5vDQPKQ0HMiGXA7FTZ9PiGeXf/Ijtk29OTDoLi/xbzn36pbPCO
         H3Nlk0piLw+GF/OJ15fSOH6qYUYL3YpFWkHtG3Pk3WtTNBw3EZMOzkgXgyEpuXgocr28
         zBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758142110; x=1758746910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=35qjjGAJKDn0K9qQpxc6vWIVoNZhWZ4EPFnBMDSRYzA=;
        b=b9zw2Wn1XOnF/vgPW6/qzjiCYPsOutjd8b0U473qrPZXuefqZ1qjY6Mq62CXWW6gNn
         U4T5gIsGgqjfMeAwDazb1pYcPgvBnKzxmbRoGrtH7H12YU929DSDrxS2LKED9Ww26NNN
         hYsSnnT/NmpFyH63xez7aJXfEAYw+nCM4eCbIfTzk/wxuhTci2NwrWtV5/rMcvwiFXbN
         Dsy0YhyfF9IFwPIXQQj9XKC+z1yP0yu+SUnyRCvkemVHWM8WcAV/4USgwzzQCmTW4VGv
         lyQIRp/N5lLRNTA72VDtKizZSVcvGH4O/e42QkZ4fhB8JFFNuDp58qIrhYD2PigsiQ7y
         9QxA==
X-Forwarded-Encrypted: i=1; AJvYcCVZTepvJLUbrc6kustVVTjSPzXZzjYbeUlJF6kzKiwlruvBtce5Gw/4DjkruPjV5EWYdirwjfbOIiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Z1r/Z1ivbvbk5TYJozRx2VWWBZ+zl8HiMvXs7OnW3nMTj4Rl
	eb2nuiB+IWcTz+owkQKfO5LTeylCyKWGbsAD9jf4RuBQNUqU9ZCPKjh6MK/KuDrYnKA+j4kB7XH
	ZcvNA
X-Gm-Gg: ASbGncvk/pGaINXFqtKSDRJ4DhW2/qUFhqEDHulIITcgHoyRKGu43SxVZesoniDNBfV
	mq6JBn9u1c/FR4zUXJk4aPx1/udHdJ+Lykn1YVI2juKa4fBLFp3uyGwfp4p6pks/0xwdiNdA5fe
	MbXpaOBVzX6TRNeVETiTRBNoUNcdCpBXavKrBOGx58fAF7kfMjP6YelG1EphzvMRVyKGOSalhsf
	JVOfJlbtmwLZdzRpQZfBGTcWo+U+auaa6LrfV2uiXGQpcX1MtzLxEa8iVKzost5Qp1UF3eHmMQ9
	RdsjWRNZPoix2l7cYILoufNawyrb6r3wqEtEM/fdYR8934nMyARwoqQ3tkigJGNk0P+R3nm8UqI
	fBGJZvGy/fkO4+7Bst6OKfXZ1h6wJoEFTewTbiee8rA==
X-Google-Smtp-Source: AGHT+IETKAaEWwaJ9R+qzNEx1lQbI9xnawBCANv0/NAMjUJbQv2gl3opkpaYZK+1Wytvq404u2IedQ==
X-Received: by 2002:a05:6402:1e88:b0:62a:a4f0:7e5f with SMTP id 4fb4d7f45d1cf-62f8468c083mr3518968a12.34.1758142110321;
        Wed, 17 Sep 2025 13:48:30 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62fa5f123b7sm204356a12.33.2025.09.17.13.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 13:48:30 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 0/9] NFSv4/flexfiles: Add support for striped layouts
Date: Wed, 17 Sep 2025 20:48:18 +0000
Message-Id: <20250917204827.495253-1-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces support for striped layouts:

The first 2 patches are simple preparation changes. There should be
no logical impact to the code.

The 3rd patch refactors the nfs4_ff_layout_mirror struct to have an
array of a new nfs4_ff_layout_ds_stripe type. The
nfs4_ff_layout_ds_stripe has all the contents of ff_data_server4 per
the flexfile rfc. I called it ds_stripe because ds was already taken
by the deviceid side of the code.

The patches 4-8 update various paths to be dss_id aware. Most of this
consists of either adding a new parameter to the function or adding a
loop. Depending on which is appropriate.

The final patch 9 updates the layout creation path to populate the
array and turns the feature on.

v1:
 - Fixes function parameter 'dss_id' not described in 'nfs4_ff_layout_prepare_ds'

v2:
 - Fixes layout stat error reporting path for commit to properly calculate dss_id.

Jonathan Curley (9):
  NFSv4/flexfiles: Remove cred local variable dependency
  NFSv4/flexfiles: Use ds_commit_idx when marking a write commit
  NFSv4/flexfiles: Add data structure support for striped layouts
  NFSv4/flexfiles: Update low level helper functions to be DS stripe
    aware.
  NFSv4/flexfiles: Read path updates for striped layouts
  NFSv4/flexfiles: Commit path updates for striped layouts
  NFSv4/flexfiles: Write path updates for striped layouts
  NFSv4/flexfiles: Update layout stats & error paths for striped layouts
  NFSv4/flexfiles: Add support for striped layouts

 fs/nfs/flexfilelayout/flexfilelayout.c    | 786 +++++++++++++++-------
 fs/nfs/flexfilelayout/flexfilelayout.h    |  64 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 111 +--
 fs/nfs/write.c                            |   2 +-
 4 files changed, 645 insertions(+), 318 deletions(-)

-- 
2.34.1


