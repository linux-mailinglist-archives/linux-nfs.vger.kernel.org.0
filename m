Return-Path: <linux-nfs+bounces-21605-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCK/BDuuBGp6NAIAu9opvQ
	(envelope-from <linux-nfs+bounces-21605-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 19:00:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9866E5379B4
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 19:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E96F73115F1A
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 16:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCE644A724;
	Wed, 13 May 2026 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+9IEJss"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDF538E5DC
	for <linux-nfs@vger.kernel.org>; Wed, 13 May 2026 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689624; cv=none; b=WoegFj8uSFzzfZISxFtr2qwwZ/CvtW+wR6OeVpBakHeb+7bGVUKQcNrBVS1QVzjWFfnvy/JsrGDEWaAcUKmitqg5BovD4IE/i5cTgD8+Jli134Opy3FUy1VcgG7F2EOHm49E8yrxgQER9wdPlsbPMiyg1dJNkHkNl4MmKZd8+sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689624; c=relaxed/simple;
	bh=1Tf8GD7hNNWG8xahlBD8lwqjTs0z1eG+SJCYPZwqQ2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ap5YtsvTnRAScMQzcKCwS/zqNPIUzoI8YUPfO3+C2vEAJH81RX+yWG8wcxaXWFrKpFY0MP4DNw6VXWyfzD59uFvuktidc+0rwnvFkc/xZuDXeCGBj1AD7ebkyXmOjVGvk9z2p89vkrxYOd67on3qzlKDjyPgTEeAGlsLsQVtm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+9IEJss; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6530287803cso7284731d50.1
        for <linux-nfs@vger.kernel.org>; Wed, 13 May 2026 09:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778689622; x=1779294422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=thxx6ku9Wln+mOsXRC9FEHvxvuNlRpZBrOsxLGTNx78=;
        b=o+9IEJssSK+hgU5SrKLTFigbxuL3ShBBWdGETUkFFw4F0imfKG8MGQCaGtXV82D3GF
         tg6odP2SWirQNdvp03RtpKu3szqc7BdYd8pPiHBdVmqutJXBiDPsUGFNtCxKLZDmkJDe
         CnKr4dpRAS7XzUuJq92cdV9Gy/7P0VeM+omJpZReU8lDAzd1L8zbMvY1liLUvrpct1yr
         iqAh05B2/nMTRYiVibYZnL0GCsEF+fYguvFKUNaqqK1WM5ADb6nIjZgiq6HTLeglqo2/
         wcz0WnqvF5xGGcEd7A5nf8BHzcgqU42fR4cINJX2eeka/NLO5bBMK5vQAaNk1HcEqgz8
         Lv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689622; x=1779294422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thxx6ku9Wln+mOsXRC9FEHvxvuNlRpZBrOsxLGTNx78=;
        b=FB4KkPo8Bjv2hhR+KwE00JpCVh7aLgND8Ah59YzpcMH1oFoIAVCcQrSFLqriwMDNtt
         OXZnfCcPtjSPCUv4QOLKi8nvpEANfLDMZZGbn9hr/cm9ZGziJOej7HALNS3UFljfsb5d
         1cbc43b68jtPkiJ0aeW4fXaM0PobV4S8hpolgr7uAj256fjU5DDC5P3kihtpOhHUxpPR
         f+E8/z6i8d0bQLeWPgNvx+e2bzHra9AnTH5JOO13mksBskWYocMNjHhdtm4A75KyVPMp
         oU0CQ3wFTOyoRAMRDxZMxFNRA56sR/APj6Ux+xr4FQP3+4Mz+FF9lS5LIjgBTihh1kxg
         /Nwg==
X-Forwarded-Encrypted: i=1; AFNElJ/82VumsHVedR/DAMDgZ+LgfmiAqz9a90S54zpneJFVevmDVJx8lVK920jSZ+LURHpxNABbWOgNbyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6PF7FI1II399KO6JWTdReWlA4wXww5znhh9Vvm2/Wbar7aDm5
	F2+8jM/rqM3ilaQWJVqnFXTiKixuV8wzIebfI24tsm5WWuqyt5fnFW79
X-Gm-Gg: Acq92OFOmEw1jA2PQwmQrS8meoyRMbdbM5cQluob1LE5eC65KaOHRW155R1gfaCQA0U
	MSm4DbjokrcTv1AL8v/G5KBGOjnL8bvf0kSf/0GLsmr2qoc5e2dROEhXKXEIqpV05HbPj0eM3xg
	/l42Elcd4UF/jnSN90dCccZoQWFhc3NsL5KaW9sWqXtv+a3tR/5onHpxMhjYmbkqqbfaJf8MQK6
	K/UpjTJggqmhitKvW/Ftl5IDELyUrVpmo3yezXQa1HS4XWDv83YgncCG6OsVxG0mDGSk0Eo0g66
	R51mGHEl4cdrYSEjOomUj4UWP92zog0PFTK4jQrkjkUdECrpudm0Vp179LvsPMwr08JNJHP8SGC
	UyjnLb4st3RAZuD47dOSZMzgjDY0wlKkC8ecksng2Y1lbqekhwqNDtqhKG0lu+uwmsyQBV21pma
	Kp/rOz5G5Zs3nA7asj7bwOqWyIcxkrAEEqcgUUPHzFU7gMPmZOQMReI3k4pNL0wUUhgAPExpuCo
	LKbWBzUerBqaP2Vmmxa5bqnqgyXITXeZbKz1KnJ2A4=
X-Received: by 2002:a05:690c:e3ca:b0:7b8:bc4e:a54 with SMTP id 00721157ae682-7c6ada505dcmr42441367b3.29.1778689621713;
        Wed, 13 May 2026 09:27:01 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd7d849afesm165696547b3.49.2026.05.13.09.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:27:01 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
	Kees Cook <kees@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	Tom Haynes <loghyr@primarydata.com>,
	Weston Andros Adamson <dros@primarydata.com>,
	Tao Peng <bergwolf@primarydata.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] NFSv4/flexfiles: reject zero filehandle version count
Date: Wed, 13 May 2026 12:26:56 -0400
Message-ID: <20260513162656.1896434-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9866E5379B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21605-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-nfs@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ff_layout_alloc_lseg() decodes the filehandle-version array count
from the flexfiles layout body. The value is used as the count for
kzalloc_objs(), and the current code only rejects NULL.

A zero count yields ZERO_SIZE_PTR, which can be stored in
dss_info->fh_versions even though later flexfiles paths assume that at
least one filehandle version exists.

Reject fh_count == 0 before the allocation, matching the existing zero
version_count validation in the flexfiles GETDEVICEINFO parser.

A QEMU/KASAN run with a malformed flexfiles layout hit:

  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:ff_layout_encode_ff_layoutupdate.isra.0+0x15f/0x750
  ff_layout_encode_layoutreturn+0x683/0x970
  nfs4_xdr_enc_layoutreturn+0x278/0x3a0
  Kernel panic - not syncing: Fatal exception

The patched kernel rejects the malformed layout without KASAN/oops/panic,
and a valid fh_count=1 regression still opens, reads, and unmounts cleanly.

Cc: stable@vger.kernel.org
Fixes: d67ae825a59d ("pnfs/flexfiles: Add the FlexFile Layout Driver")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 8b1559171fe3..e22a8e0daf2c 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -551,6 +551,10 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 			if (!p)
 				goto out_err_free;
 			fh_count = be32_to_cpup(p);
+			if (fh_count == 0) {
+				rc = -EINVAL;
+				goto out_err_free;
+			}
 
 			dss_info->fh_versions =
 			    kzalloc_objs(struct nfs_fh, fh_count, gfp_flags);
-- 
2.53.0


