Return-Path: <linux-nfs+bounces-12822-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7A9AEE6D5
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Jun 2025 20:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87FEE1BC153C
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Jun 2025 18:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3437A19994F;
	Mon, 30 Jun 2025 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWHV0FJm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E522F4A;
	Mon, 30 Jun 2025 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751308557; cv=none; b=XLi5fqmPHdeS3Aj85x1VjcnRijWoTzrEOme39fUIKdvfyT4SxUndTnHcFoz+KFl/WRp9HovlrxU1wAY99xjF0RaCADDZgBcxLDF8yC7F4PbB+/yd6AJVLYV7GOk5T6z15BKQIOwM2Nz+BvQwc6qAXP6YbwL4mv/LsapRvhkERy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751308557; c=relaxed/simple;
	bh=8evBLTppL9/5yGFQweagI4TfTELrinIqsbdwGMumKRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BxHJVJAZHND7omi1NBZKy/yliF5b8fyRfNOxH05JktuGDTQReOyh0PzkSMlJMKXcXftyxWfbII9Wl/3zyf9v+Pav9U9yH7KwJF6R4BSxebdmLSMr8i2O0T6CsZWnmcnsRA/iXccc77RwqzNDzrh6McnAwPcvCyCg4izLPZK97y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWHV0FJm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553bcf41440so4868226e87.3;
        Mon, 30 Jun 2025 11:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751308553; x=1751913353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ON8oZaGcpeY5pePYM92VB+BnuhASO6Q5A7mIIlnuRbI=;
        b=QWHV0FJmYY+/7VRohYHaluaw48qBxWlKMpeZJHvJRdygRpPHOVX+maPzOd8chiaMu7
         MXA9rutMmjnTVqXdNHrw2VY6SH8//MNuNQXlrl4m5usW26Bk+fhWcY/SPegGNNMBbwpM
         qsxjcHaDK+GHlXEMfhO4fSHHIqTkeesySHOeMl8DGU1fLA3vMMzMf1x5GoCsb+fxyR4r
         QSOaRTRxYYIIpZP+LBg1xHldsJZ3nqyYhyjDCgFpNLfxrt6kGyeJqEOxmNDfXFzW9yIF
         KE6xHg7z6GmWrZRNAsR5rQo/3DXxs4a3G67J/H25O56GCB1Q4peDmnzhufyg4XpHqTLo
         7U/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751308553; x=1751913353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ON8oZaGcpeY5pePYM92VB+BnuhASO6Q5A7mIIlnuRbI=;
        b=Uz4LAZwxiblMYxsmPLy/LpVtJr3x/ApDn5GcAuD//xLlQcbGuOhLdWurPZl+L9eTeM
         HJ4qELpmqKmB48hTL6ATK+9FZWkJLqD388o+70DtdFBPHKdHGjgPOQIiUmkSeyCGO2Lg
         GGDWOrgkDszfcHWgHi1Y4RTQJ4TqvBL7CNZuROKMSWsTTv6vKWzh5ysyFRA6YLakmjBF
         OPr/TUiPLwmy3RNUhv3Bpai6f5xtBBMI5UWKgSbsGkrwAc8cnEKnq8nLbrQJkbnTcQQY
         xNCEG+Mi2W4nxjaa0z3cmcBNYLVbPmRd8gO8kW2mAJIxQ8etSFQ9y9jq791x3emu+yxQ
         99+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwhZV2cKlUSzXzrZugqvxvN944Z2n58yU4uTv7LoECv+1QQy0S3DhqJbZvposQ1cq7o0D3Jwr2H8eI6ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YycooGZK6hBr/j+QypSxyi2/SpqhMGhuKFtnxKGz5SPVjWWn/VS
	bRl8oOHEtfW4O69zyTobU/XVmGI5PChz+WMufETGAJFteBe0BdOjcXgl
X-Gm-Gg: ASbGncukDsKqShgJmFr+2FAC49c35hWrt3gS7ZfptG70CkE8nJwgA7CM007deeNY4Sm
	IQqVw2gRfJ4ES3TPG14Lac766lmA9aW7UgbRqksCQoqdvmFrP4xfTr+HSqmenhFIckbP5aTEfzn
	3Q/VIbGRnwDqjMObWtTDDosEr0z0Rtrf7/8ikeSz/lD4NzYd90a5M7tUuNrhtekWdLsNjS1QH9n
	wT5Repyqsc1ZmOhxW5kemQj/SX7rgx3cCxYtFES5QQlhqAv7mM6o2lCO62ikaEldjyzB07h4t3y
	XnTjstC/eI3bJsjWekw+uXeu7Nbe4Q1TRVqRBR5bXG7O+JubH5DRgkTKbVFnVS6wvZ0/LF4qESx
	/4ZiweDqaFD3ooQ==
X-Google-Smtp-Source: AGHT+IGOplx9txkVEEiUlMRaBEoDRvEh8uzo2l1LThGqDynfNqfgL+OnxdXQqCNqzLzs/7QtCBkDIA==
X-Received: by 2002:a05:6512:108c:b0:553:23f9:bb3b with SMTP id 2adb3069b0e04-5550ba2ea04mr4435949e87.49.1751308553047;
        Mon, 30 Jun 2025 11:35:53 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.230.218])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b255a51sm1530793e87.88.2025.06.30.11.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:35:52 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH 0/4] pNFS: Fix layoutcommit handling in block/scsi driver
Date: Mon, 30 Jun 2025 21:35:25 +0300
Message-ID: <20250630183537.196479-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depending on the allocation scheme and size, some files may have a large
number of extents. This series fixes the handling of large extent arrays
and allows the pNFS client to split large layoutcommits that exceed the
maximum RPC size accepted by the server into multiple requests.

Manually tested for the block layout driver:
sudo mount.nfs4 -v -o minorversion=2,sync,hard,noatime,  \
                      rsize=16384,wsize=16384,timeo=600, \
                      retrans=2 192.168.1.1:/mnt/export /mnt/pnfs
sudo fio --name=test --filename=/mnt/pnfs/test6.raw --size=10M \
         --rw=randwrite --ioengine=libaio --direct=1 --bs=4k   \
         --iodepth=128 --fallocate=none --verify=sha1
Trace:
    fio-1580  [012]  1258.595866: bl_ext_tree_prepare_commit:
        ret=-28, found 372 ranges, lwb=1531903, not all ranges encoded
    fio-1580  [012]  1258.609534: bl_ext_tree_prepare_commit:
        ret=-28, found 372 ranges, lwb=3104767, not all ranges encoded
    fio-1580  [012]  1258.655556: bl_ext_tree_prepare_commit:
        ret=-28, found 372 ranges, lwb=4644863, not all ranges encoded
    fio-1580  [012]  1258.699603: bl_ext_tree_prepare_commit:
        ret=-28, found 372 ranges, lwb=6176767, not all ranges encoded
    fio-1580  [012]  1258.743650: bl_ext_tree_prepare_commit:
        ret=-28, found 372 ranges, lwb=7708671, not all ranges encoded
    fio-1580  [012]  1258.787605: bl_ext_tree_prepare_commit:
        ret=-28, found 372 ranges, lwb=9236479, not all ranges encoded
    fio-1580  [012]  1258.817439: bl_ext_tree_prepare_commit:
        ret=0, found 295 ranges, lwb=10485759

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
Sergey Bashirov (4):
  pNFS: Fix uninited ptr deref in block/scsi layout
  pNFS: Fix extent encoding in block/scsi layout
  pNFS: Add prepare commit trace to block/scsi layout
  pNFS: Handle RPC size limit for layoutcommits

 fs/nfs/blocklayout/extent_tree.c | 104 +++++++++++++++++++++++++++----
 fs/nfs/nfs4trace.c               |   1 +
 fs/nfs/nfs4trace.h               |  34 ++++++++++
 fs/nfs/pnfs.c                    |  11 +++-
 4 files changed, 134 insertions(+), 16 deletions(-)

-- 
2.43.0


