Return-Path: <linux-nfs+bounces-2140-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4494A86E66D
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 17:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C511F294EA
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 16:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D19C2570;
	Fri,  1 Mar 2024 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="OdkMyky0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE032A8D3
	for <linux-nfs@vger.kernel.org>; Fri,  1 Mar 2024 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311831; cv=none; b=pW2wrvnf7Pe/74vb/wbFvKm2fjTSUFjnarIFCGGGDP/jC18jloCV9y5fiu88tByU7BRoLABJimm6LCRL3loThD5Z4Dd5nUYRTmBLD1trNIXd+QPvNBVKDKVmKTzgWmzpEETNlb8Sur/mstV0XrRnDlf0EW65tAksPR3uHo/8358=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311831; c=relaxed/simple;
	bh=vJUH/HqFQuEle4pRuhySVQp753SvqKULpIXAU4Rveak=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kgabP2zflB6uMwKvhh7YM3zWuaqIZQ8Z99xhZzVthFA4kyrXUIjBm/TVFKsLWhA8H9thpRZES8Nx8k4IUS7SrBajnbBaNnRCz2yR/mPeDUjg207rtFXZNacPcWtRfMeaLMl4ma8YNli7Z8YvKeZN/7IFvu2DKH9KEo3beKr+bzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=OdkMyky0; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-788153bb79fso1734985a.0
        for <linux-nfs@vger.kernel.org>; Fri, 01 Mar 2024 08:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1709311828; x=1709916628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HEq30T8zNRgXFzfgCXj/aGMoWyR3v1Uzp/vBUfafTAc=;
        b=OdkMyky0JOymGPk0k6uGTORWU1sgCgAp+qKAsriFUnWKq2RmqUODSBCVnSIKMluZDT
         G94ISpfuzMeKriUVZxupLf30b3qGbT7lOITx9mpeh4dPdJO78XREQDuGi5nXfDVBkIMi
         MxA5vNo3yMde2fhDVt9BN5jZjogSsu0c1HPt1cRa6SKUtvEA0SyKy3xlrzcEiPZAKv+Q
         yL1HU1zkLg18PSttjz3j7eggXqa0norXHEzVcn1e3Odz7CpsjLzHnlyNUuwav/lrAw3e
         /d4iPe5o7TP/r0++gedvXyyXR9OUQQn92hMQP4zhVHt+CptEDMosmwv0x9ow7/vVm8W5
         +1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709311828; x=1709916628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEq30T8zNRgXFzfgCXj/aGMoWyR3v1Uzp/vBUfafTAc=;
        b=tME1qsJrM53yYKPt1DAFkAcnFP4wWDEHNCNNL8+T7WtqLS73T84Y59l0jmuZ9koc8N
         PoTu9AeYQWEg2RIOMJ7PzqqfP/5TC7QtKSjRWXcjK+07ICBnJaOMrcZMkZNLOaVcaCB1
         7BW48Jx1HrApJF0wRdHqb+HUAxFS4xqH1NttEfo11sX83B33sohTlVMn8Q9IPq+iiWkV
         qCqStkGdK5UgrMUTIoiIleKg+zHtD9cyssumjwpHyerdZiNuJHRp4kZCvOI/mGmcjEmv
         HaBkqW0jm97QYToOL9dkh6AcorrGndO7mIWjc1rUG9P6ViNGe/Xs8n6dG/dgTPdskMbt
         UPVg==
X-Forwarded-Encrypted: i=1; AJvYcCVAxoGMKJN0MZtoxxDL0sDzeM2vK0uMMVHPdMfGI1/L/gW+W3I5Zdr6p4FHqQJrRAUOwS8iRVTmrRub9Q2aaP3pgdBXHTccqAYd
X-Gm-Message-State: AOJu0Yz34OWvsFvNJhRg0jmVzjWvqYWdNp5gDoqY5PXzYs1Ny2v0M+zO
	ATE8R3b+M/65ayqOuc1e5hz1F2He1D3eX4hGWGnIESjDzU1fNPbCSwhSSdi4TnHkHVCmVdvnEz6
	K
X-Google-Smtp-Source: AGHT+IEbSpYwl1I0XKsWbCpJxXmpH0Yrp8NFKzfuL7SrpwZlVcskOMRX0TRzgnXW8lp+z4Glea9n5Q==
X-Received: by 2002:a05:620a:1791:b0:788:46e:b1cb with SMTP id ay17-20020a05620a179100b00788046eb1cbmr6247211qkb.32.1709311828320;
        Fri, 01 Mar 2024 08:50:28 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m20-20020a05620a221400b00787ec0fc392sm1798290qkh.21.2024.03.01.08.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 08:50:27 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] nfs: fix UAF in direct writes
Date: Fri,  1 Mar 2024 11:49:55 -0500
Message-ID: <cover.1709311699.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Here are two patches to address a UAF we've been seeing in our stress testing
with NFS internally.  The first one is to clean up the accesses to the
nfs_direct_req fields which is more a matter of correctness than an actual
observed problem.  The second patch is to address the problem itself.  I've been
running these patches on my stress test for a few hours now, I would appreciate
feedback and review to see if this is the correct way to fix the problem.
Thanks,

Josef

Josef Bacik (2):
  nfs: properly protect nfs_direct_req fields
  nfs: fix UAF in direct writes

 fs/nfs/direct.c        | 18 +++++++++++++++---
 fs/nfs/write.c         |  2 +-
 include/linux/nfs_fs.h |  1 +
 3 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.43.0


