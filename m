Return-Path: <linux-nfs+bounces-17365-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA00CEB050
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1ACB301585C
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEE854763;
	Wed, 31 Dec 2025 02:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nlo9el3W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EDA4C97
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767146453; cv=none; b=jcOv8vWP7DtnPzn6i4IqLRDJhIkFoytKk+ZcZa96yfP5CQ8DfNTWn7adSr6HGJO0F/kd+BjPOIopeQwuslYX32VltGNtSSQ1hvhoxrL9QOMd9+PBDSpqxhJ2kq95TiAVFheZPmnGX8h3XTqcZWWUqfyZXyzNXdgNSwPVPN2jXTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767146453; c=relaxed/simple;
	bh=qcEKullHtwBfYH1V1OhAqOMeVi19kDwW09TvJzTNyKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=riC60j3aXzVtPzB2SCqUymjA2JB2/AyPIyPJK74cKox0Cus4LB5Sx5mPtRakPsjR2a8tzmgbqJcDtRB1+eIfJE6EgNNHQPyiH9XAa+s35sAWCZAgKw/He6buCaFLDYDmK2IsN/2GhwfFk1sRaBN1j8DW/8dgv9QHGgZu6l5gII4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nlo9el3W; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29f1bc40b35so181189955ad.2
        for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 18:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767146452; x=1767751252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1b7z7x2mFl+2D+PHUfV3mbEgZQlPkQ/9B1xt6Gy0EEw=;
        b=Nlo9el3W1cJR6PwOiGSIr6gNRoX2L9xA/ljXkAidh6Uz/Nj3gUS74npzg71qxb2O7G
         /IB+nuaH620KLqoUd7L4Hcn49Jpu7WatK+tBUAkru+z2/pCh0piBxWzYteQRbFfbK1oN
         LFSUELEpyDS1Y1fk4zKemcSuDhgXJfPH5EMif+OEmfDk+N+x5tzo+qJI7FS7Xt4Bd9Pi
         ecCnXb9arn9earEpnBJFzPVo3Zt6GtZ0ETFS0hOOILzf+H5as1eFtf+b7HVJAEbHzZAK
         h+gWBOndEo7wTQSqFP+bslfimK0TpuIjVj6mqti7tROYSk9x1lTCdRwRoYBTnzcUNxYn
         vuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767146452; x=1767751252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1b7z7x2mFl+2D+PHUfV3mbEgZQlPkQ/9B1xt6Gy0EEw=;
        b=m+vpTAz2FHvBMigmjlCbzmQYCToWgerGmMjQxzuM2yXVosaIM22Wik22JK8SP6umRb
         4Tr+FJ2Fte+3G3hwGVt/RwyNFW91iBmo5kyJVXiDV6J+ZJZlmSL461uWze8HcnXwDyBx
         aNw03mq0GdAfYcBxe1OuNlR52NHhuh8/ofTVuxlcXaHAplPXYaiUPftEZ1Q6UDKJ0HHG
         4QQzvvTCnYcXrl6ohHMDWL9I3f6no+pfk9dXmUyZgGD18OY5Tqt8w196VpjtdLljBh2T
         L4O3VhUrKRSJO0qEEWF+5yLZTeMSImIVDUz0OD/7YwUclGPxyFIv94oVSL2jSKeTJNBE
         ZrKw==
X-Gm-Message-State: AOJu0Yzy1J2JHEzwjQbBe7/uUX/a/gKu85sKnyABKgCVRYbxrmF8X9Us
	pyfE4P3DUkhRHkq/nFeoBLikUwzOrF6iObVEdxSC0QVm0UiHDoJu8WNpMSY1DXs=
X-Gm-Gg: AY/fxX4fmcUA2Ns4bPfTSnJfWJOIY/eCTnQ5Ep0dLocHQmtAmICt66Wpn36Xz7+KQd7
	nSabvwo6s3ZwKOFPmxyaLSQIolgky5LwHhur/CZqIglf6FnY2aSwwcQ5a+67jLpMarZeHuXzXAc
	pbNpAGYrdW8yQGaRTmYrnuAefywZXUBs2EjF14s2ESpAyAAEte29b3s9iz8U355SkznWjqaoIed
	6ur9XWhdZHlgKz5krihh0rJ8ZIgATfkuNEXZh5STtr9RsDzLLa1W9hLMlF7HVj5pEjTB1whcS9e
	NGTwfBBcrlyg4Cjx9dZjUYpXP8WJuDSGVddmOpp43qUC3Ww3mFPASJD9xNOzHyQpO7gsg2QqxDX
	5NdmrBMBHWD1OJXrIG+5I3JPlpJ7RH6XYfIzcysDBcLhYIzM589a35mKBpzKYS6vzi2PIBF1UYY
	4MoRbnkz6pdheLQjlmtpDGj6XWaXzhMlcKCO3dUp6TWvFf5JSbyyNul8YX
X-Google-Smtp-Source: AGHT+IHvV0j3mviMj+vRFJK4WCsDlm4qbN3fudK9IkhqwxmLjMPNZ0S7Z7DI2UOagOIHwWm7KHa8Qg==
X-Received: by 2002:a17:902:f542:b0:2a0:c20e:e4d6 with SMTP id d9443c01a7336-2a2f283de1amr321032905ad.39.1767146451587;
        Tue, 30 Dec 2025 18:00:51 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cbcfsm315979555ad.50.2025.12.30.18.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:00:51 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 00/17] A test message
Date: Tue, 30 Dec 2025 18:00:07 -0800
Message-ID: <20251231020007.1684-1-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

Just a test. Please ignore.

Rick Macklem (17):
  Add definitions for the POSIX draft ACL attributes
  Add a new function to acquire the POSIX draft ACLs
  Add a function to set POSIX ACLs
  Add support for encoding/decoding POSIX draft ACLs
  Add a check for both POSIX and NFSv4 ACLs being set
  Add na_dpaclerr and na_paclerr for file creation
  Add support for POSIX draft ACLs for file creation
  Add the arguments for decoding of POSIX ACLs
  Fix a couple of bugs in POSIX ACL decoding
  Improve correctness for the ACL_TRUEFORM attribute
  Make sort_pacl_range() global
  Call sort_pacl_range() for decoded POSIX draft ACLs
  Fix handling of POSIX ACLs with zero ACEs
  Fix handling of zero length ACLs for file creation
  Do not allow (N)VERIFY to check POSIX ACL attributes
  Set the POSIX ACL attributes supported
  Change a bunch of function prefixes to nfsd42_

 fs/nfsd/acl.h        |   3 +
 fs/nfsd/nfs4acl.c    |  35 ++++-
 fs/nfsd/nfs4proc.c   | 126 +++++++++++++++--
 fs/nfsd/nfs4xdr.c    | 312 ++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfsd.h       |   8 +-
 fs/nfsd/vfs.c        |  34 ++++-
 fs/nfsd/vfs.h        |   2 +
 fs/nfsd/xdr4.h       |   6 +
 include/linux/nfs4.h |  37 +++++
 9 files changed, 536 insertions(+), 27 deletions(-)

-- 
2.49.0


