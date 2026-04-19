Return-Path: <linux-nfs+bounces-20952-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHMGFJcD5WlCdQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20952-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 18:32:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEF4424B87
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 18:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB4FD3036608
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 16:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693A8253B42;
	Sun, 19 Apr 2026 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIRMvujm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC462D0C7B
	for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2026 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616306; cv=none; b=PTPSVzXTUQQ1az/2Ai8Pa4kEijQ3bPTTipHP24/TskUMpOziujdtpB5lWHqN1KzL4CsQ7AlwrNecTkL60WvT6T9WsSaJqfwvsZFjGCNUtxp8ZoPNZ1ekb/Zynljt2jsiwdI1mO428hbbU4JUKsfEcCTuWdqvoJDH+5nXR3woKeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616306; c=relaxed/simple;
	bh=K9aG0GkuRPtI9qykUJU9LEUVRNU2MyLh6kudgjsxmok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tXf5C5b9MZdapRZK8Yk8064YwzJU6yeGcqwCieads14ggDU2iQTkeI4jUo+KsIO5PWJGYRjpryAVournZjD8GNuibSok6nI/LSO7HOnYF5dxWGHdARKGLR08a7fmbWG/cAiq0/eLpnvKGucT18SvZgbjq88shIb2vkVo46LI42Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rIRMvujm; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35fb7c1a455so909125a91.3
        for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2026 09:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776616304; x=1777221104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dk/Wp1KdQIFnzpWc0d2XsrP6Fi/zl8G2FZCTBjOxsA8=;
        b=rIRMvujmHtAonjAQnZVSu/4ry12nXIFjIqTMHcodq87AUEEZJqJi2W7fs7l7yNSLh6
         7Y7MXit6weT0lQKWNQGAbHePBHNjL/pFk7XUHrrOaM2VN5eWoIyjvpd8aRpMJTNfUkd7
         VVkp3GdPa1Nra2dZ7tB/nQzPMw8GDzoUPmCQawl5lZRnoBCDC6uRCrslpBQVFhL1ypwo
         zs8u6AhpctmRVOGz0fBX5Nl0WFJ/0XuxSsslqvho+TpMTebZUO4UkGDwDdg/Yl+h2tM/
         grLnZ9zV7t6WIwuPX3m94lAyFurBbACYT53ctE1RamNaHYBqdsVax7wwdo7IRxHoOBcB
         l04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776616304; x=1777221104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dk/Wp1KdQIFnzpWc0d2XsrP6Fi/zl8G2FZCTBjOxsA8=;
        b=ouPyC7iBVhyHqcToyQy4ya3VHH3IUFN8+3Oq8FHZyDAVIdAuSYzFQlV0t29YUMWcGp
         topLspo4PS5LiqBAGG/NaG0p7nGcas9eaHmqxJZlXtho7Ti09NP+yVBzCERjBVerOtjR
         lZnH4FNBN4709XhO5Os8euIHc80fcZBH6tkXgRZ/ij0yBXhPqW5BQNaYX941smPdtyDD
         mBjBv0bFx7kmjqMAhd+qi4ad3z/VFfJs/EAYEpmjzYDQNs/COJDo3GTzPidRRy/La9AZ
         yTcfDw7vLQrRfGTC2I4aZlj+vqtt9N00fqQ0vnlfSrIlKrX3op8vEj3eCkekTla5rhjo
         ISbg==
X-Forwarded-Encrypted: i=1; AFNElJ/CSp/XNDw4kLwhmNttt0KFYd5RBpGf1w6r1RMkJTM0HCFH/eD7NL2NuuVHzuq7AODrmkatggeeUNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZF6bBrnYj0wo7IYOx+ABV+MzgfMAR1PAd0x4FgFDOn/CvUmwV
	A67OzLFUh/9DaIIVLX+3bYWM40p0ycPkSKBJuMC9cbG0sV/QTemNtBN9
X-Gm-Gg: AeBDiet8aK+VelNFzy56UBmlRMJUW0EGfE8ODodBoumx6UDuibZbl52dRI8AVfxm0Rm
	18ISqrsC13EosMGEmz6Dp3o9xGjHkaPhqdBwbTBhaQo0uk79PghJHpQL/PpgCFYgI6jdBb3X2U+
	pKGJed6HbsUXPDwSq2XcxjR07Iu2GxIuOP2pXemA2qClcFE6I74CxUKq2Lf/uCT24soHZiRmqiR
	xhG1ik9o6Edk7QTSOuCsS+/rqLVyRp3EzpY9TOpWqpQYzwD4GEKRTBeGUtq5O8PfPW5Wdhua5wC
	FVTD0P0B0Xm6dv2223NVm08QS9YoI1cupwbMu7pWd/4KKJpHEbXf2iGfxkNF0g3TyYLlgxGIF+I
	Km/tTDv6x33ia4JJr9xG+Y7p2QFoLN+qy5dwtfH/N2X9UJakHKiSqbxj7SFQly6IUf7R5obxQTg
	9p/oq7m12Kdk8CeYn3v/EBmNnOz2EKd6/bOROPG5yZ19P7CGisBigisAqMKpEYA4Z4+Fb4eWJnj
	E7dSNjcndUVaecPjDuIfTrDkSNX4Q==
X-Received: by 2002:a17:90a:e7ca:b0:35d:8fdb:4f36 with SMTP id 98e67ed59e1d1-3614048a21bmr10856704a91.18.1776616304105;
        Sun, 19 Apr 2026 09:31:44 -0700 (PDT)
Received: from localhost.localdomain (1-160-233-238.dynamic-ip.hinet.net. [1.160.233.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361417748aesm7814196a91.0.2026.04.19.09.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 09:31:43 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Benjamin Coddington <ben.coddington@hammerspace.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v3 0/2] NFS: fix RCU and tracing pointer safety
Date: Mon, 20 Apr 2026 00:31:36 +0800
Message-ID: <20260419163138.26963-1-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-20952-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AAEF4424B87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series addresses two Sparse static analysis warnings in the NFS
client related to RCU safety and pointer attributes.

The first patch resolves a "dereferencing noderef expression" warning 
within the nfs_page_class tracepoint by removing a redundant __private 
attribute that was causing Sparse to complain during trace-buffer 
assignments.

The second patch fixes an RCU-unsafe dereference in nfs_compare_super_address.
It wraps cl_xprt access with rcu_read_lock() and rcu_dereference(). 
Following reviewer feedback, the RCU critical section is kept minimal, 
covering only the transport and network namespace checks.

v3:
  - Patch 2: Removed the redundant XPRT_CONNECTED and pointer existence
    checks as suggested by Benjamin Coddington. Since the comparison is
    performed while holding sb_lock, the transport's existence is guaranteed,
    and its connection state does not affect the server's identity.

v2:
  - Patch 1: Instead of changing the 'req' field type to unsigned long (as in v1),
    simply remove the redundant __private attribute. This resolves the
    Sparse warning while preserving the original pointer type.
  - Patch 2: Reduced RCU read-side critical section scope to cover only
    the necessary transport/net-ns checks, as suggested by reviewers.

Sean Chang (2):
  NFS: remove redundant __private attribute from nfs_page_class
  NFS: Fix RCU dereference of cl_xprt in nfs_compare_super_address

 fs/nfs/nfstrace.h |  2 +-
 fs/nfs/super.c    | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.43.0


