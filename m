Return-Path: <linux-nfs+bounces-14645-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D103B9ADAF
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 18:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 736CE7A889C
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 16:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EDD1EF091;
	Wed, 24 Sep 2025 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bZ3iO5BS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427730E823
	for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730857; cv=none; b=hPPMRSa6iTZ9VYFRWr3n1XjV2KQpqSAPL9gPWr8ERYLUccm4O/wPe74un2rOGa+SBJRQwTp3B94wmbLJCyK0WifUpU21JgvHpJ/8fcB6s6vNPPf7XGdZh/7htS8Z1i7fdxlvJ+YoRFMA8QyKgn2fitNPyjh3KdN+hIuApURq3Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730857; c=relaxed/simple;
	bh=CySMzGzSCqUmS4SSFyHKApxL6gM9+VDz0xPY1S1QTX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZvWEUeK4pojH/SP7EryZOr9wgKfUDh7wNpSlXerf2Hdn9NWMqbyDpROzL54QvAoSmwVU/C7qp/kdjLXftaGIZ2o2Egcad80ERR8Q4Rgj8O0DTXkUvftoHcXxCYS90Ynlmw4z7ZgDl/fda8/42A530ZJt9obee4fTNaJ0+sTsfRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bZ3iO5BS; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62f0702ef0dso2231562a12.1
        for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 09:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758730854; x=1759335654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=puuPG4gUmLRyy/MIYPZ/ZxGLmXzy4mhO+q5ILpbSehM=;
        b=bZ3iO5BSvTRwGJMQERu5y4Bsjtow5EtnVNmfNlUGfupIL1fkMCqSWHPrdhCFIgw9Iy
         onHSbJHpIzYXzU+KndV+JwhBnZ1/9Ua8HEsg1WQPBp5fMbMPZDNDBWEv4zaDiaJI+dFA
         nDepls43hpHnkDrJR/KtYePw+RlYEi/RH31MSyLRc8yecPiJ0s8Taa7+6CEYoOVkwnRK
         jENyxzrk/oJ2NYvDtkxUeDjTJe/NxZswoZbWJfZmGSiqDXhFyDqT1kedob3RAoD3mqz5
         Fc+BGXrTu0CbCi1K7lorQG+MmkqXcNbXELSvSCk0pQwtRTPkyNof2yPClxhYlbLFEAEC
         2+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758730854; x=1759335654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=puuPG4gUmLRyy/MIYPZ/ZxGLmXzy4mhO+q5ILpbSehM=;
        b=LFeTUQROdEGw+hIot9Q4/gdWKHfIEdSsB6sfpom1CPvu70+ujQgYpLMRCrnQvz5cI9
         slupcFxUeS+rQjcBHv5ZJADcq4RHF8c+FoS6eRFkdaw6nBr9pMM6LPyqLyKYO5apUXAI
         1MMcKKCTLft3iSYnu1koU3Oycb7EU3o6z79+b4Z4aKpOMk/8G42ZotA8g8KETq4vd7I6
         NCA3YGiHE2hHhCiwKlkxeXYTBfEFTxmo5ur7qwdzU6o4AgyXcp1Ic8QeULV4rdn59QYT
         34e6kOw0Wx2Y1ypdHbNq6HsjdBPG+oVwIWN0JA9AYIPsLhkobojroWIekcuXiD9mT237
         8ZFw==
X-Forwarded-Encrypted: i=1; AJvYcCWAyk92kAM+BBerLFCSBUobMYfkbgyfu1Crbnys+cQ9cnpXBC2zZKmdVyvaunaqyCaRxFaGAMlmkBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Y7XHuy0ESQ7owh29FmoH1WpNktrkx209ZH23bZvMp6s+wIhW
	R66fCZsDlzdNkYJ8igEmTINSVShaC3urYXz0LW9zoprBeroM47rDLG5k4/XA5DsP+uU=
X-Gm-Gg: ASbGncu1th25raMwqwjcB0QZGqLG6cL2QxDrtIhbJ+HwRJtCY4nvWp0euf5AgeDJstX
	q50WjG4ZoJniQ5Z9GJMwf+hFrJi3MFEP0I4gzhtXR1zB1HDR4lb0qRQz26Kpot5MDAiI+JOQ8HP
	XPdGTYQ1vuzfz6zzo0NECbvJ2lx2HP4J2G5u0BVkMno8Wik7HXklUBWk7OXRqSXOa89hz/uJJ2w
	YWq8Esy55nLCrOqW3oCFP6dQPTDZYJwTEG+08RDmVKAL66Wc13mwTsvIQbEfjZH2IW3J1IxKge2
	788ALbSNTd++mANSEH8hDMJOpqCkq//dsoMvRVv5GKF4tGK91gnnOARa8cVJgGlt3TXP9Bq/Riz
	yP/p4bhGpKk1ynCDGwyEIm24=
X-Google-Smtp-Source: AGHT+IE8yuGoASnDOUSES10OOohnZtfwmlyxm6hL6OBZkONdSLAXJGEkgz0XBP6oFi7D+HZa6La48g==
X-Received: by 2002:a17:907:60d4:b0:afe:ef8a:a48b with SMTP id a640c23a62f3a-b34cdb4fe23mr28792166b.30.1758730853670;
        Wed, 24 Sep 2025 09:20:53 -0700 (PDT)
Received: from localhost ([208.88.158.129])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b2cdbd3f824sm682456466b.69.2025.09.24.09.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 09:20:53 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v4 0/9] NFSv4/flexfiles: Add support for striped layouts
Date: Wed, 24 Sep 2025 16:20:41 +0000
Message-Id: <20250924162050.634451-1-jcurley@purestorage.com>
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
 - Fixes function parameter 'dss_id' not described in
   'nfs4_ff_layout_prepare_ds'

v2:
 - Fixes layout stat error reporting path for commit to properly
   calculate dss_id.

v3:
 - Fixes do_div dividend to be u64.

v4:
 - Use regular division operators for u32 commit path math.
 - Fix mirror null check in ff_rw_layout_has_available_ds.

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

 fs/nfs/flexfilelayout/flexfilelayout.c    | 778 +++++++++++++++-------
 fs/nfs/flexfilelayout/flexfilelayout.h    |  64 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 105 +--
 fs/nfs/write.c                            |   2 +-
 4 files changed, 635 insertions(+), 314 deletions(-)

-- 
2.34.1


