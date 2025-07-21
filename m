Return-Path: <linux-nfs+bounces-13163-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C06FB0CAA2
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jul 2025 20:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403651AA0015
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jul 2025 18:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9412D836F;
	Mon, 21 Jul 2025 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4PnsTNz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506392D3EFD;
	Mon, 21 Jul 2025 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753123273; cv=none; b=FafEY8icm6f5a4SZoxDLeJaOpIEWVAGYb88QImp56GwQ+/ereddWBuLBQBwtu+ZDcxF71qFZLXsA1PRYWMcrHLhcvMVPQyfXoAVk/YLXo0L6Y4ZZv77jJnKU/Qhzip/3xaAOtavrijGJeNi7R8eBRCMNbUO7qAZbz9KRZrXLOMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753123273; c=relaxed/simple;
	bh=sK7XTwQ67pzWbmfSywltj714louiEDsSZGE1H5eBMNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bBd/luQDIXZGt4H53LgIbyTeF5Ol7nB686rXs/CdXh8AQipcJ7x/0w03K5spc5P6CzkXaf479DA+AH4Ws7Xmxr3ULnXDTHAO4BwaZpDZLa0Qjm33AOL1dBS0JFuShbGEp+IGQiUQS6X/nLKfdx92+S04FYHEL3CYIcFOjblpLC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4PnsTNz; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32f2947ab0bso37021441fa.3;
        Mon, 21 Jul 2025 11:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753123269; x=1753728069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wdyq2tpvsZ5THC0dzpncggcfY8P4bkW96QSBKK+E2MQ=;
        b=S4PnsTNzKEZxHI/1AvelGCyqfUeG+0YXChJCqowssmdyc4m6lwhNzXYmbPqiAeect6
         eaIZOrqwJKMygrNfS2HyCXToLEGkUzdjCrF6ODYWYQuRQBMN1mhhp9w4x0zCEwVqglnH
         SIdFFTooLr1HSoYUnN6hcQ3GAb9ZycZM3nFZTBvlkMoZ40Wr4EpTNoUHOr4nZ9iL6bvs
         qSx42GHKhGUQsUci4QXy1mA2Wec7v49gE6ate8Earw4ZBsh8zNZXRhu2HRCxgEMrdX/H
         WqanlYi7e1j3mmqB2g6+gYgX+5VwO1JjMvuADC4+jHBTFBKVZBOapblR8CePP+w8b3Xi
         A2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753123269; x=1753728069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wdyq2tpvsZ5THC0dzpncggcfY8P4bkW96QSBKK+E2MQ=;
        b=Z5hk23BvflrPT4tFAEbDXDd3hAa17B6wjbC2vaJLWq7oXOMbMv6s62qDPJjjMuBcD0
         lb44bEY8TYm/Ht1WAizMdimQrIwaQhhujhR0Oib3KSxAvRzb9q+0XlycjADU8s/8rcgC
         LysUeu5ms4v9xBd+ZM6AqxGNsE6uAQ339bkt9EZmNyGm32ZLL0GrTZaYu9k4F2iLqP0r
         VLSqElSvAZ5AoxV14QfOKgQw3dMQAPWWxIHgGfEtARen4AqNEzlIMse0QYusN5jhx859
         LPfwDDhSJeT6Z58rm1RAqB0uyqozE7w6qcAanUHJxT/qIqWmWn9zt3jjGpNQTnWuCBZj
         gKWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqziTz73VJPvDFpFEGpw7t0wt7NdptgX5r9F8ERpwedyMH2enP+N8bwlgSHFe+vFoZDE1bwsRfbIzd2zk=@vger.kernel.org, AJvYcCXNP3dVwEcafteMnAd6hDUPiLe6ySYWcRr44pQaouj5TLHrAy0JyTbO4FS05149sp1kZGAtCfp13I5L@vger.kernel.org
X-Gm-Message-State: AOJu0YzV/mjK3TArDCFjLWPa2G/30g5ha3RCtVYM1P9D88jNeEvArMpE
	oexbwO8OjRH71jp3ZNBUxKwS15PL1YTd0+7IlRZQ/TVl/ACLypk6/mzV
X-Gm-Gg: ASbGncv1E7H0DqmgCNRXRQk7tRAz01sf6OaLOBy+ZuKjZKnkj8tUGVifpXwqhJ9Kv6U
	UhJYx4FLQoSq8QInB0xRSKtqAS90VI5x/DWPf9cB9btqWg3wD6MSxhywjhS+MAUynlZQqkBVmFt
	mrgs9BThIYj+HKIdA3laHK7ID1n5BLBtbjKsocb72+qySEqjc5LYFG2sZupvlwQZBhMjdGHA3T+
	9+FhkpzdbLuY3cAW6WczNQQFk8tD53xFlhapFpVDqxZtBmUXAGsBNTYIhZQMCnRrvKDp3EimTO1
	oc+rmUTY36pXfbdBxzjFKCBB+NMa1rYTcucDMLhYJU0GIwSOy3MXdQ3vCn7o/I7NsOk+MBMGeZM
	NNQ6vIx8em0udzJl71OxT5PjrrBmFdYpdvaSQdCOEldMwwfSb
X-Google-Smtp-Source: AGHT+IHYyDZQ/G6omg/PsefAYKXbJ+Sj68rsNxzmIRu3tTjHWvhjHSm0/IY/728+Nz0A/Juqi/29Bg==
X-Received: by 2002:a2e:a7c1:0:b0:32c:e253:20cc with SMTP id 38308e7fff4ca-3308f4fc5a3mr50751511fa.11.1753123268996;
        Mon, 21 Jul 2025 11:41:08 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.122.38])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a910546bsm14116661fa.42.2025.07.21.11.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 11:41:08 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH 0/2] NFSD: Rebase dropped patches for block/scsi layout
Date: Mon, 21 Jul 2025 21:40:54 +0300
Message-ID: <20250721184105.137015-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series resubmits two patches that were dropped due to conflicts
after the deviceid4 handling rework. The first patch is rebased. Only
the decoding of bex.vol_id, which has the deviceid4 type, is updated.
The second patch doesn't change, it just depends on the first one.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
Sergey Bashirov (2):
  NFSD: Implement large extent array support in pNFS
  NFSD: Fix last write offset handling in layoutcommit

 fs/nfsd/blocklayout.c    | 25 ++++++------
 fs/nfsd/blocklayoutxdr.c | 83 +++++++++++++++++++++++++++-------------
 fs/nfsd/blocklayoutxdr.h |  4 +-
 fs/nfsd/nfs4proc.c       | 32 ++++++++--------
 fs/nfsd/nfs4xdr.c        | 11 +++---
 fs/nfsd/pnfs.h           |  1 +
 fs/nfsd/xdr4.h           |  3 +-
 7 files changed, 95 insertions(+), 64 deletions(-)

-- 
2.43.0


