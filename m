Return-Path: <linux-nfs+bounces-5114-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C140E93E96E
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 22:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B971C2121C
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 20:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACCA745CB;
	Sun, 28 Jul 2024 20:41:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3EA54BD4
	for <linux-nfs@vger.kernel.org>; Sun, 28 Jul 2024 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722199270; cv=none; b=AFATmmDTVznyNxxCIwKou8EbeGOU8wi9EhEqSex+dYyFD445iwRIbNLsjWWZ95lfKyqvTmM1hbxHwcqhwdacLRK/1nEAdSh3mMOeBOXHCe8xjd+QqB+ptFVN5Qr+LszKHSuJviHSlwLO1Jl6OfQvmm7kQ200l0y7muLBiFf0yho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722199270; c=relaxed/simple;
	bh=Uj93k/9ZOtr6Qkjl2SX6xL/CVcRCdXBRIyz1o5+a5CY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XyjTpneA6+PWGQuQIRop7LgVvxinene79imfO9Paw1pbT40ElxAUd6cmy+PKcccigkvfxss/OcXMcrzNOWxLr4/6PY0VoqSHYUxAICNlgDz5wAC/xcZHS0A0dJVu66nVgA+8FA8gyIjUJqoKx4mtBkMwCi4ThWePQC2SiU+QI2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4281da2cdaeso30205e9.2
        for <linux-nfs@vger.kernel.org>; Sun, 28 Jul 2024 13:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722199266; x=1722804066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+PIZl691eBF5XvwPpxAiG4wXyd1cBNswfKWOb5WtNc=;
        b=bu2zkYMdT5Cia6vCygKv5inl6QGu17vpItrOtyMqKPEE93ipXvcJsFNWIilNQgs8SK
         8YaBHrRObUKjQpsZLWsrq/xYv39Bur4mjgOi8S9BsT339bCoNFTlrxF4D/KevFqiiDul
         j3VovKavbb8KSJBdk7tvT7o6enB1xizlVZQk/vBSE+iDVxF2BrySOuMihhVTg13c8hEk
         +H/a7y54eVO6F6KOBunSkzlc2cpCVhWzmHavm3Hqxmp0N+YYYe1PXmiJw7mfp293Y7nL
         48R8DOHPUQGAQBa9UFmb0om7Nvc1NYZgIYA/tQVz2f8bu+BydRujZIdalLEafeukGxS7
         bU5g==
X-Forwarded-Encrypted: i=1; AJvYcCUwO3X5C73VZaiWplqeC3bi3qlX0YsbKRXlSUV1KxMDEzPAOYgxWvlJcwHWdWVFjABxoa1cdJk7Ofg=@vger.kernel.org
X-Gm-Message-State: AOJu0YybMpmNsYQXiZ8GMUI9ldUMigSunZUQdS2mQe06MeAXKtoVtRzJ
	annCrX0IMTuGWfvYB6Wbb1mhmbcEaOoPwx1CqZaJ+mcQvSoVxRDi
X-Google-Smtp-Source: AGHT+IFOw0j0i/h7T1OBWUGtqqKOL2Hbwtr9GIIJ4aqEmqL5FsZMqFu8UghgCoQ5Vs+zjo2KzIr8ug==
X-Received: by 2002:a05:600c:4fc2:b0:427:9f6c:e4bd with SMTP id 5b1f17b1804b1-42805713af0mr51119445e9.6.1722199266299;
        Sun, 28 Jul 2024 13:41:06 -0700 (PDT)
Received: from localhost.localdomain (89-138-69-172.bb.netvision.net.il. [89.138.69.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280d13570bsm98701395e9.7.2024.07.28.13.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 13:41:05 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Dai Ngo <dai.ngo@oracle.com>,
	Olga Kornievskaia <aglo@umich.edu>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/3] Offer write delegations for O_WRONLY opens
Date: Sun, 28 Jul 2024 23:41:01 +0300
Message-ID: <20240728204104.519041-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since some known workloads do open files with O_WRONLY can benefit
from write delegations, we want to allow them.

The patch set is based on the initial attempt by Dai Ngo in:
https://lore.kernel.org/linux-nfs/1688089960-24568-3-git-send-email-dai.ngo@oracle.com/

THe problem back then was a reported breakage in pynfs test that exercises
reads using anonymous stateids.

Changes from v1:
- collected review tags
- remove f_mode tinkering and instead open locally a file as rw in case
  the client opened the file as wronly and got a write delegation
- splitted the anonymous stateid read conflict handling to a separate patch

Sagi Grimberg (3):
  nfsd: don't assume copy notify when preprocessing the stateid
  nfsd: Offer write delegations for o_wronly opens
  nfsd: resolve possible conflicts of reads using special stateids and
    write delegations

 fs/nfsd/nfs4proc.c  | 25 +++++++++++-
 fs/nfsd/nfs4state.c | 95 ++++++++++++++++++++++++++++++++-------------
 fs/nfsd/state.h     |  2 +
 fs/nfsd/xdr4.h      |  2 +
 4 files changed, 95 insertions(+), 29 deletions(-)

-- 
2.43.0


