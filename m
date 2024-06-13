Return-Path: <linux-nfs+bounces-3729-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B702906340
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 07:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214D21F2355C
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 05:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910DE132104;
	Thu, 13 Jun 2024 05:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlmzgJjU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B757E1
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 05:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718255226; cv=none; b=YJfdTkSX0//SNeknce4P5ZS9eXFDnwmyARhfzXx0R06+15GmQ2Me7CfXQHj01wNRlQBIX0ax6zYlEjePyM5WazZ1XelZCw2/Quy/34LilH71ZLyqTBT5ae7al4ojBH45Gr5eDxxhJypoq7stFYC5ERFd3Mlm4V32zm0JcbAhXqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718255226; c=relaxed/simple;
	bh=SKpP9OXc9bIdGhPw2zDlBaJ00M0ktLILUWuZe+bc2qI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CkRN1LCiAfs6e7ct8GFcAjOAS6KiyWNDxJy44QR/6wYfB1Lt9WLNx427UNjCViWfyotvcgbSr374JurdIVLkYPDYpcQIN02I54RlLlKTejWM7Na9Vp2ffKICUCX7KWPGVox9BrnIN5BpQOCPhszb7Jf0f1GCExgVvUlO300xQZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlmzgJjU; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dff06b3f413so184980276.3
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 22:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718255223; x=1718860023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QX+FsEvGifcGixAdnbG77BIjmGQ/YLV7MjAMpp0GaDo=;
        b=BlmzgJjUxj0qomVKgxBhWLQcEOIWrE2JOrxsfibVa2NH/6hJWIemJytQFhssvhghel
         uyrFrMC8eCc8Gfz5JcxTRZ7uWZtAyLh8aOwJUtHlJ0QJXo5/bFORAYwBfiqPT78cCDlz
         W8J8mpPnSGboRRmWCjnXy+nE4rEPiVDvmi+OIqjJjPayJHfUxy0Gm3wrW+SdDrRE7DlF
         hbckh0CVELXZ6MVM36YB8nZFU3YAS67QBv42coqiEz83nOlU1ZaoWtE1/04BjS4vaitN
         Kil7wjnXfTzO+6MaNu80Nd9abM1NNw0U33Bm1fIAhzPvGSzX7hV2FfDjFUyYI/VlHLkh
         d97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718255223; x=1718860023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QX+FsEvGifcGixAdnbG77BIjmGQ/YLV7MjAMpp0GaDo=;
        b=ry8VDaLHkMJT1HR+x/X0bERR4irVKlzGDHIU5QirY5c7nEcxUybFidzNHZzE3uay7K
         jJekZP2j87lMNuFwCUab2T1kFxvP1nO5mnNC/5dmfBnaPCOS7agEPkIJQsrnmSZSrbDY
         D5rdPYd5r/vKTV1Z0wir/1q41BXAPvoqQPM/xnuec38qHulBzM4yAA+PYu748L/gmDRC
         eB0W714k6wr4ZAGm4NXJYAKSJRbnnGyJh8P7eRxdWhmp4Oyt4EWt6y3TW5XU5RVmyiSj
         G+6/I7LuWVsPdFEy/VVB5qNoScPAyx4cqTzOo6zpQZYbqVM7hlUL9AB1qHbCpGNe5RNd
         t6Gg==
X-Gm-Message-State: AOJu0Yxv1FINnEJpY9lWJ3NKlweymJm6rldMzl9cZI/V8gISOTs2+Rjj
	YrMdpgHJMORWzslV9/cTh/7wz34gLwrRXUVb7edDlmT/wJB+M/CkoxTu
X-Google-Smtp-Source: AGHT+IEKa/l+4V8ucmktNoOgbJxl+fdQPDx3Q506syXd9xpkPAI5/KZ8rVg5fIDNAK5bT6xTeNddeg==
X-Received: by 2002:a25:aa70:0:b0:dfe:e98:be37 with SMTP id 3f1490d57ef6-dfe68435fd7mr4068037276.42.1718255223451;
        Wed, 12 Jun 2024 22:07:03 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ed4527sm3079036d6.101.2024.06.12.22.07.02
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 22:07:03 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 00/11] LAYOUTRETURN on reboot
Date: Thu, 13 Jun 2024 01:00:44 -0400
Message-ID: <20240613050055.854323-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Now that https://datatracker.ietf.org/doc/draft-ietf-nfsv4-layrec/ is
mostly done with the review process, I'd like to move the final patches
for the client implementation upstream.

The following patch series therefore adds support to the flexfiles pNFS
driver so that if a metadata server reboot occurs while a client has
layouts outstanding, and is performing I/O, then the client will report
layoutstats and layout errors through a LAYOUTRETURN during the grace
period, after the metadata server comes back up.
This has implications for mirrored workloads, since it allows the client
to report exactly which mirror data instances may have been corrupted
due to the presence of errors during WRITEs or COMMITs.

Trond Myklebust (11):
  NFSv4/pnfs: Remove redundant list check
  NFSv4.1: constify the stateid argument in nfs41_test_stateid()
  NFSv4: Clean up encode_nfs4_stateid()
  pNFS: Add a flag argument to pnfs_destroy_layouts_byclid()
  NFSv4/pnfs: Add support for the PNFS_LAYOUT_FILE_BULK_RETURN flag
  NFSv4/pNFS: Add a helper to defer failed layoutreturn calls
  NFSv4/pNFS: Handle server reboots in pnfs_poc_release()
  NFSv4/pNFS: Retry the layout return later in case of a timeout or
    reboot
  NFSv4/pnfs: Give nfs4_proc_layoutreturn() a flags argument
  NFSv4/pNFS: Remove redundant call to unhash the layout
  NFSv4/pNFS: Do layout state recovery upon reboot

 fs/nfs/callback_proc.c                 |   5 +-
 fs/nfs/flexfilelayout/flexfilelayout.c |   2 +-
 fs/nfs/nfs4_fs.h                       |   3 +-
 fs/nfs/nfs4proc.c                      |  53 ++++--
 fs/nfs/nfs4state.c                     |   4 +-
 fs/nfs/nfs4xdr.c                       |   7 +-
 fs/nfs/pnfs.c                          | 223 +++++++++++++++++++------
 fs/nfs/pnfs.h                          |  30 +++-
 include/linux/nfs_fs_sb.h              |   1 +
 include/linux/nfs_xdr.h                |   2 +-
 10 files changed, 249 insertions(+), 81 deletions(-)

-- 
2.45.2


