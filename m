Return-Path: <linux-nfs+bounces-21849-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8SBuGZ0FEWp+ggYAu9opvQ
	(envelope-from <linux-nfs+bounces-21849-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 03:40:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6F05BC5BD
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 03:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1719300B9E3
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 01:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECFC26CE39;
	Sat, 23 May 2026 01:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkdwRd7d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B667921638D
	for <linux-nfs@vger.kernel.org>; Sat, 23 May 2026 01:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779500441; cv=none; b=UeKfIVAPEeLGwQz5cb4q6EU3zMQ27kdsZfLajXvEKnGWxfQgnxKfL1ZKDSZfr22T6vBZFY5aOmeJF8ODydLgF28iyLZO5JwtEDZ38N1mHTFIMdYnGi9SclVm+D73Fq9omO4obaDbdOP720pv5Ze4c+6V2j3F8Jn4HT6y9E1y4WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779500441; c=relaxed/simple;
	bh=Jrh2Ths5M2cZbexD4fdGj4nn4YBf8xzcRfAWuFjG/4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJfCgvbz7I7tGhPxFR82KClFv17NhfZTFC88loQK+1TF44DlEj0tF01DeOOGwmzROiHgupxkzgnvYSCONv7BC5/vfCMZ/ixJTwJddIqn8tD65g+DvevGjIrF6y+0Nky+Fe23iluWnTyWnTcYeDcoIVe0EMRh1fi7HLVOVShdTRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkdwRd7d; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-516d634956fso16368481cf.2
        for <linux-nfs@vger.kernel.org>; Fri, 22 May 2026 18:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779500439; x=1780105239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NBkz8uk++9agYLdO2eZoJHgoe4NIS1dR5QrU5vkKjfM=;
        b=FkdwRd7dMfHEmCtqhjZSX2DvsA/hhKDiVAvWLOLwiKhuSNMSAVoaNWd3AFlxM/t/rQ
         dzAxDSAqmI0xidi0ns1U9pMSktGQw6ClL86D6qAM9GrRPlAVSdvkUslUZF6IP09bFUhU
         jdoTQSHeUhMkvKOAXRWT/py8zzZ8JiWPeYTD3i/Q7SBz8MrS1VKppM+ep52ZpB6LQSF8
         J2PhoZs7F3SkGSw5Tl8KvdBNoJlLkKfHuwFjwpaGFj+lQjMBCYKxmMKH9KjA2HAB5N/0
         3IqlM85o2RaqkDtqZenQP5byD2rtemsGfkt1o0obv8rqP9FSP24mJRtF+myfUAmXLyqw
         19wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779500439; x=1780105239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBkz8uk++9agYLdO2eZoJHgoe4NIS1dR5QrU5vkKjfM=;
        b=D+fp1ISO7EYtOPvgeZFTMpqnKvXhqP7l1vT5H2RUwFR43TeRGlDjWi495r9EyaMQAn
         wc8rRpFxFGxPDF74/C6D1afjn+i36PB77bS6onD5Dfcr8CwN2WlHp4BbB8Wt5LkVF7Ax
         gMU14TgkdEPmI/Go28Yb2HOI7BrKdgF8pAz4HACs+ITlj4LK4yhgwG+RFi8KS1t2o9hp
         NyY+oHwnjus2mOZJ5T3qQxMFXdyQCQvjl2YM0juFJdu9IS7O4EMQjShb7NwnJWp4zxOQ
         Ix/iLsRsLIgGEACRCvtwdBPB8AhGLcR3L0ATGRqklhYgib4ju2ZCAlf+bSUzQQfRbrdq
         BKLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/07xtL7eh1hah+YzDkHf7Zs35Q9KbSabFRxarPH22rKcUzGb5YPj0eXYqYjU7s3JRCit5aHbJp/nM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL3UyQVTV2t6JuJ3Tkw5eTK3pQATiDIJ8LEtpUGDv2ZSerNzeC
	94cBJJHdlSoyoeDXSzjPhHfaDX85iniMiL8p6RFOV/JLxpfimANYL/Q2
X-Gm-Gg: Acq92OHYCMpNQ8pX8HiPtKRXGJxtAdRBdwcWx1FgaFtR6S08iseZEvj5ovjW8iYdNpQ
	nqtnxYmkobCRZEffW2RHAPUdQV9DAsCOwnhrRWIXSIoQzIIYC7Ch7ZXhZM2iDGVSfmDVtC4JXZH
	XoiTJosLMCwVRQU/Mm5FWO8kSDASmKC0Y6fUolGmp/a+c5tzCXdTgcp5W8gV9AHgPnEAdlegjhj
	MQt37OeT0toqqX6aazOaYHhkkAaA1Ii/TPG3ggFJWoY8PFwOMDcLKe/MjvrvOGpDZD4ONcLImbT
	QpElw49VfvQIs2Unlzq8OBiN9OuLK5FB98Kl71AXOfKrS5HPelfN/YowugkGrw10xgM4nehTW47
	leWGg1ICM2knbB2/kT4fzKPA4A75nCml9MpxaTs4aEYUVtRrbr7YSF2UOywqOvnPa4gGpbkI17w
	2pzVSz1an1+4kOa7N9GaiyfcGX+GS1O0+nt/bjWNCkNvVyEaZEfC2wiDXao37YvON0cnBb1hpor
	qeOtmBeEBpL551w9ewD
X-Received: by 2002:a05:622a:6115:b0:516:51da:ae52 with SMTP id d75a77b69052e-516d43cb30amr84067831cf.33.1779500438698;
        Fri, 22 May 2026 18:40:38 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b247c4sm28559031cf.7.2026.05.22.18.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 18:40:38 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Tom Haynes <Thomas.Haynes@primarydata.com>,
	Peng Tao <tao.peng@primarydata.com>,
	Kees Cook <kees@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] NFSv4/pNFS: fix client kernel panic from malformed GETDEVICEINFO
Date: Fri, 22 May 2026 21:40:31 -0400
Message-ID: <20260523014033.2459677-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-21849-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ED6F05BC5BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A malicious or compromised NFSv4.1+ pNFS metadata server can panic any
pNFS-flexfile client by returning a GETDEVICEINFO body with a
multipath-DS count of >= 3 and exactly one valid (netid, uaddr) pair.
The unbounded inner loop in nfs4_ff_alloc_deviceid_node() (and the
parallel site in nfs4_fl_alloc_deviceid_node() for the legacy file
layout) keeps iterating after the first netaddr is decoded, consuming
the trailing version_count / version / minor words of the body as
opaque netid + uaddr pairs.  Both come out as zero-length strings;
xdr_stream_decode_string_dup() sets *str = NULL and returns 0; the
caller in nfs4_decode_mp_ds_addr() only checks "< 0" and immediately
calls strrchr(NULL, '.').

A QEMU/KASAN reproducer is described in the second patch.  The
shortest crashing GETDEVICEINFO body is 56 bytes, the panic is 5/5
deterministic at multipath_count = 10, and it fires before any
user-level read can complete on the first pNFS file the client
touches.

Patch 1 closes the NULL dereference itself by changing the two
xdr_stream_decode_string_dup() return-value checks in
nfs4_decode_mp_ds_addr() from "< 0" to "<= 0".  Patch 2 promotes
NFS4_PNFS_MAX_MULTI_CNT to include/linux/nfs4.h so flexfile and the
legacy file layout can share it, bounds the inner mp_count loop in
both drivers against that cap, and breaks the loop on the first NULL
return from nfs4_decode_mp_ds_addr() so a hostile server cannot drive
the decoder past a single malformed entry.  Either patch alone closes
the panic; both together close the latent unbounded-decode class.

The unbound on mp_count predates the flexfile driver: the same loop
exists in the legacy file layout since 35124a0994fc ("Cleanup XDR
parsing for LAYOUTGET, GETDEVICEINFO", 2011) and was carried into
flexfile by d67ae825a59d ("pnfs/flexfiles: Add the FlexFile Layout
Driver", 2014).  The NULL-deref site was introduced by 6b7f3cf96364
("nfs41: pull decode_ds_addr from file layout to generic pnfs") when
the netaddr decode was unified.  Stable backporting wanted for all
three.

Cc: stable@vger.kernel.org

Michael Bommarito (2):
  NFSv4/pNFS: reject zero-length r_addr in nfs4_decode_mp_ds_addr
  NFSv4/flexfile,filelayout: bound multipath DS count in GETDEVICEINFO

 fs/nfs/filelayout/filelayout.h            |  2 +-
 fs/nfs/filelayout/filelayoutdev.c         |  7 +++++--
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 10 ++++++++--
 fs/nfs/pnfs_nfs.c                         |  4 ++--
 include/linux/nfs4.h                      |  3 +++
 5 files changed, 19 insertions(+), 7 deletions(-)

--
2.47.3

