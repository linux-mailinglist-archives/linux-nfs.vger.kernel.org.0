Return-Path: <linux-nfs+bounces-14916-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B16BB51FB
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Oct 2025 22:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E40B19C621B
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Oct 2025 20:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB28148830;
	Thu,  2 Oct 2025 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZcBZQjN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9033E134CB
	for <linux-nfs@vger.kernel.org>; Thu,  2 Oct 2025 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759437090; cv=none; b=iXQf5CMs1AERzps4NUGWwpXCli3FWOA3W+NlHHNJMpTJMQMgc049y8RgqYOiX19wO0R+baLIakx3wD1ekprjfd7tpx7OdeWsPlzbWAwne+ZW8GFm00qLTK5qnuRsz8PC6WiYEP+13EUe2XLNRerTD7vDdemg9bGUKgqHPSS97IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759437090; c=relaxed/simple;
	bh=6N63wn6e70V3PTLkkgJt8OJ0tYwmpFIiBABIS2bT6SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZkcwQ4FbeuuKSySdIvlrPWO1htJLAv7zGnMX9q8gwz1ZjEsOzP91ON8hbMJWqxQQ3u3gQ3sdE5p9TzdiOBIaH/z7X9/ncyyfDGj4nxjv/ZEzlAhMWQcB+XyVSRACDVP+CxUJr3NQ6+sVTPQ8rRrJ2XeJqBWPoiKgc79kIG8R5yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZcBZQjN; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57e03279bfeso1917317e87.0
        for <linux-nfs@vger.kernel.org>; Thu, 02 Oct 2025 13:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759437087; x=1760041887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HdvDy+jE9pUEVDpBETUNShqkuR03kLijcUSoRDrSlI8=;
        b=VZcBZQjN11PLgl8xxEAuRXgedSeFUz2OJtXwq+BgzETfP2xOhoGPLXP96+obeM3LJc
         UiWxpdrt75UhumVnNZJi46NjOZFsEQCISFbpue9v3QHePu5audI6vOREfcYvP6+Sgh7m
         zp+YcRKv5G+rElr4dMSOBZSZzAn5ur+ATFTQ1BJMdt/4xtCfVJvB0ZrgJjtWWSxkX8x6
         B2RGUo+731zLRE2mE+OE1KSS7zgYueTjYQ5yenpYNqVp23DVDk2IRfHX6/Mv04bpr4Nj
         /WI53PCXexClDtxwtCNDyGNAdBwu7OklP6HS4PHtPuUl2tkBGnXO3uA6fXdbCNyiQJEj
         5tsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759437087; x=1760041887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdvDy+jE9pUEVDpBETUNShqkuR03kLijcUSoRDrSlI8=;
        b=SpImyTxeq5gWoq74R7d3eUCMmVtTqWGn4FHo8xKMwModGZaPZqsAhqlFu2lkTsFtpD
         rK1UrfoJNWsq+sC0vc7qBNTCEwFYEcTNr3olNYcScyWyLTzTlDx7ofcrK5aBTRGpi01Z
         p4dXoia4Sj+K7dzFws7VDg9gXfo971r2A5xXiJSt4OE4E/UXivuLT4oBlUvyTRmX9lec
         IUebtEfeD9qXSWUo2X75TZms8yJJiD9RmkwN9sGAUz3WTKjdEIU5lWimT5xYoY6+CF6V
         /yHcv3X/ll+MVoe6FgXwmBRzT6TFfs5Hm5DFMdCML61LxOadyZx/cipFGNQe5KF2CO4y
         xMuw==
X-Gm-Message-State: AOJu0Yz10yz7LNeikaAcgeR7DcwP9lpR0zPqdQNhdh67znRr1gF7EZtS
	3NiXiLzPluDfK0+d+wnLuV/Rw77bC6q6s7Aw5GY5/Gwj49xmtS8ZNm6J
X-Gm-Gg: ASbGncvQpXCOBQjMhWthTva4DnZarMbOwtmJQINxXBRLJUTycx8KKqXvG0KUg/9NJh5
	aNXE4GOLzkZikaCOyFm10XHXBiSvpr8SOq1VJ+zCPCQS/IflbIBQwKizfZpFgyMaaxgfFkhY+oJ
	4Jgo03DgOq5+rcqWj8PsjOZAZvG+XcqzFaR2SPz/7mN8xCdm0P4K0W+NEKC2MonxLDDxPLaWQau
	hiCU7EmPpnSy3tv86jc3bMa/5XTvARfUmq5dCeAPITIIFCq2FcO5pPzQpEIEk6JC7DDw61KMwIb
	6/8ucbz23WxNm0EOcYWkZEiNl5o6rdwkUjJpjM07fBiJQqTrC12z3J8fxT6BMKHHJ5aPfflzCKP
	TAz+QUnC+bVU06L0bFDiXCegh2IWJFbhu52i4nvOu8rQEqner4WwLTlUi0NtMUFtZ6tBRKTuLRb
	U0
X-Google-Smtp-Source: AGHT+IF2b51SMZxRUPUPUFa256VtMpMUsH9rtl897bcO+/0ikiOpQMBUMwns5t1Wl68GpHWNFThBMg==
X-Received: by 2002:a05:6512:2397:b0:581:bdb8:6df9 with SMTP id 2adb3069b0e04-58b00b5eb3emr1513310e87.10.1759437086196;
        Thu, 02 Oct 2025 13:31:26 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.163.120])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0113f3ddsm1127316e87.52.2025.10.02.13.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:31:25 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH v2 0/4] NFSD: Impl multiple extents in block/scsi layoutget
Date: Thu,  2 Oct 2025 23:31:10 +0300
Message-ID: <20251002203121.182395-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support for multiple extents in the LAYOUTGET response
for two main reasons.

First, it avoids unnecessary RPC calls. For files consisting of many
extents, especially large ones, too many LAYOUTGET requests are observed
in Wireshark traces.

Second, due to the current limitation on returning a single extent,
the client can only reliably request layouts with minimum length set
to 4K. Otherwise, NFS4ERR_LAYOUTUNAVAILABLE may be returned if XFS
allocated a 4K extent within the requested range.

We are using the ability to request layouts with a minimum length
greater than 4K to fix/workaround a bug in the client. I will prepare
the client's patch for review too.

Below is an example of multiple extents in the LAYOUTGET response
captured using Wireshark.

Network File System, Ops(3): SEQUENCE, PUTFH, LAYOUTGET
    [Program Version: 4]
    [V4 Procedure: COMPOUND (1)]
    Tag: <EMPTY>
        length: 0
        contents: <EMPTY>
    minorversion: 2
    Operations (count: 3): SEQUENCE, PUTFH, LAYOUTGET
        Opcode: SEQUENCE (53)
        Opcode: PUTFH (22)
        Opcode: LAYOUTGET (50)
            layout available?: No
            layout type: LAYOUT4_BLOCK_VOLUME (3)
            IO mode: IOMODE_RW (2)
            offset: 0
            length: 10485760
            min length: 16384
            StateID
            maxcount: 4096
    [Main Opcode: LAYOUTGET (50)]

Network File System, Ops(3): SEQUENCE PUTFH LAYOUTGET
    [Program Version: 4]
    [V4 Procedure: COMPOUND (1)]
    Status: NFS4_OK (0)
    Tag: <EMPTY>
        length: 0
        contents: <EMPTY>
    Operations (count: 3)
        Opcode: SEQUENCE (53)
        Opcode: PUTFH (22)
        Opcode: LAYOUTGET (50)
            Status: NFS4_OK (0)
            return on close?: Yes
            StateID
            Layout Segment (count: 1)
                offset: 0
                length: 385024
                IO mode: IOMODE_RW (2)
                layout type: LAYOUT4_BLOCK_VOLUME (3)
                layout: <DATA>
                    length: 4052
                    contents: <DATA>
    [Main Opcode: LAYOUTGET (50)]
pNFS Block Layout Extents
    bex_count: 92
    BEX[0]
    BEX[1]
    BEX[2]
    ...

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
Changes in v2:
 - Reworded subject and description
 - Split the v1 patch into successive small changes
 - Removed kdoc comments for static functions
 - Removed subsegment and magic numbers
 - Patches are made on top of nfsd-testing

Sergey Bashirov (4):
  NFSD/blocklayout: Fix minlength check in proc_layoutget
  NFSD/blocklayout: Extract extent mapping from proc_layoutget
  NFSD/blocklayout: Introduce layout content structure
  NFSD/blocklayout: Support multiple extents per LAYOUTGET

 fs/nfsd/blocklayout.c    | 154 +++++++++++++++++++++++++++------------
 fs/nfsd/blocklayoutxdr.c |  36 ++++++---
 fs/nfsd/blocklayoutxdr.h |  14 ++++
 3 files changed, 147 insertions(+), 57 deletions(-)

-- 
2.43.0


