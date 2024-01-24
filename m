Return-Path: <linux-nfs+bounces-1311-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9565383B257
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 20:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4687228320A
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 19:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5593C132C1F;
	Wed, 24 Jan 2024 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="v+xQn8Um"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B3E131E39
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125035; cv=none; b=GZZSeCGsFKS0Tzbu3X8n//SRDiO4AOag5kZzWDQeYjUjd9pnlnzESrW5JNMm0cefR8evmEd7Wg6aMMGjhOi6HbEnbVLICPqacqaMQRCYWXLYSP5YbCDVPBwukNtoFrQIoXCNMRsWMCGMwR4jfp59CdgrKxm40fVB87AXLJp1uL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125035; c=relaxed/simple;
	bh=sMWcgSEgudzdCona3/EdxutJGTDvNyXy+sXrOf8HJ/w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=g3RhnK4BDXxuTtEHk1ygw93kVH0q8qkQwtdlj6cxAQyFMsbv/7A8i3hfiTDVwN3wcKkbNwsFcsz8tGtp0+OTdP+GtqLr1ZSmP+wDRHUoGRqQ+4t1R1Ll3u5VefdYogx9wCAsEZwCrPfJft005KsDK2LXo+QTlB8ywUYWwG0NWgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=v+xQn8Um; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc22597dbfeso6250831276.3
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 11:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706125032; x=1706729832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4GahZx2IQzR+vF9WNYFQFA1KWqotFUDfJ31QZe/Diys=;
        b=v+xQn8Ums0/R0vgM9Pu4haNDEUHPBfb4qAa6GrQIqGFf9UyH5mfTH26nTuVuo268hl
         eX/Ph+aIkUYxA1rkmSRjZO94mwoSVltWvwC6FaR85wdz0b+TRVTrSVtZ8Me6eTZdfMeG
         qpQ8WjrY5N8hM4pkgVYcQi1+R66Q4Lc8tvOPM7ZcJj47dAqpHkOBm9VZcZH2eqVGVQXk
         aq/QNKFPnleiFO2kkMzfaioSx+5G+nnSgu1C133c7ywoEGmV4sHtgl1aW9q3rkMwHG1c
         T24qvSbgIE3YNvf/iqQuUYoby9Q/tD7lykl6+ZK3GN03dSi9CqemhAuFOVv3YH7hykNE
         3LXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706125032; x=1706729832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4GahZx2IQzR+vF9WNYFQFA1KWqotFUDfJ31QZe/Diys=;
        b=j6Taepy1eDPFeea3bHWio4hHIazJTw26MHwchAAkUKiPKW23nSc1TwQcSuloflfCe8
         6APOqwc1kCYccPSSVGKRG8g/bijwU0WKlBJhbz0k2IQtcgasA4sEWynUh+sHYi32rHZH
         hgLlV7A069JvTfDFm3w2B5wMxQ/Pr99A0ZWGiW66VFJuunEU3NLlQGyedTq3aSwuVVlY
         YMAvIrqtJWpEkHpNyRB7cIiDtEfc1mqHdJ0z1HzxV7k4fev6Ivgw5oMRkjReUv8wS767
         BXokbXOExvKVPHC61quaa0G+hdGD5FVgi+xvfG5Q9jJAm2mVVovCAhO6yg/fYUc7tRsH
         qKjQ==
X-Gm-Message-State: AOJu0Yxwkk/cb8iZZJBPWDikuLruIIU+2MSgcj8ILIHiXIv0lSGUJKlH
	flDDqH3pCtigFSPtCusMLY1rG4/coAHd3nyF2BONVy2qm96LnvsxDOz13LdnzeAAcNLgHexCnXJ
	y
X-Google-Smtp-Source: AGHT+IFdKlJ8HZ/QV7gN4fVbnlusmslNa3GMePmiJl1gsk2Bk2AJ/J/QbZ9a1qCSMABGySeJO/w6aA==
X-Received: by 2002:a05:6902:10d:b0:dc6:19bf:1b99 with SMTP id o13-20020a056902010d00b00dc619bf1b99mr315949ybh.91.1706125032128;
        Wed, 24 Jan 2024 11:37:12 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d82-20020a254f55000000b00dbd9eee633dsm3035999ybb.59.2024.01.24.11.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 11:37:11 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/2] Make nfs and nfsd stats visible in network ns
Date: Wed, 24 Jan 2024 14:36:58 -0500
Message-ID: <cover.1706124811.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

We're currently deploying NFS internally and have run into some oddities with
our usage of containers.  All of the services that mount and export NFS volumes
run inside of containers, specifically all the namespaces including network
namespaces.  Our monitoring is done on a per-container basis, so we need access
to the nfs and nfsd stats that are under /proc/net/sunrpc.  However these are
only tied to the init_net, which makes them invisible to containers in a
different network namespace.

Fix this so that these files are tied to the network namespace.  This allows us
to avoid the hack of bind mounting the hosts /proc into the container in order
to do proper monitoring.  Thanks,

Josef

Josef Bacik (2):
  nfs: expose /proc/net/sunrpc/nfs in net namespaces
  nfsd: expose /proc/net/sunrpc/nfsd in net namespaces

 fs/nfs/inode.c   |  6 ++----
 fs/nfsd/nfsctl.c |  8 +++++---
 fs/nfsd/stats.c  | 21 ++++++---------------
 fs/nfsd/stats.h  |  6 ++++--
 4 files changed, 17 insertions(+), 24 deletions(-)

-- 
2.43.0


