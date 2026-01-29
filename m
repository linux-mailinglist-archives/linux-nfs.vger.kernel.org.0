Return-Path: <linux-nfs+bounces-18603-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID9AFTQwe2n2CAIAu9opvQ
	(envelope-from <linux-nfs+bounces-18603-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 11:02:28 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E23AE549
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 11:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 653BF30093B8
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 10:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1598E2F4A05;
	Thu, 29 Jan 2026 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj40/k3x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2AD37F0F0
	for <linux-nfs@vger.kernel.org>; Thu, 29 Jan 2026 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769680938; cv=none; b=WEFpx0nn9160qExME0tnnUBmROPQsX+hNCvWOIaTdE7ZOiDwDsx8DFysNUsFuxQE8vCFRPp7EDVwZJrygPAflZTTjOy71dPzYLa8qbw5/EqzEGn1/HFamruKt3YYNOZ+5sn7MxLwsw7NkvhIUe0dE00KAkgyD/mpbWaUtYcQ+qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769680938; c=relaxed/simple;
	bh=N8CoUqnMYZ7QSAR/ducsKL3rx3I7wiUS+KVe3IW/pFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSncH8g2OLKw6iu+OfYQUBX2d9BAXDvsgJe+Z1luPvfO4G4A6MuLhnZOVIw2BlET3JPk46I7cyTIAZGDPWXiUZcHdL0OuHX+pBihgaW45ndkII6ERvV9Mf+cScZVzTx8s760AckR/H0rgzNOeSh3Y+1EJSgxA8pSr8yOClG5tj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj40/k3x; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-6505d3adc3aso1115946a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jan 2026 02:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769680935; x=1770285735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+A5PA2QuPZwYWlbPtFj9y2qIk4W2THrdGdKigGUGxc=;
        b=Yj40/k3xWyVigscQ28BvhsHjcDNgMMI0fN70Aq9w1Nv1aKw9n0MJRbGR/bQ+50iQRp
         1+/6IAgpKTg3yBsvkKJ2Bo6MF08spz72e9sNWtQoC2KjZrABMKjTBUo1EngNK4hBvtxN
         H1forTeO8AJ/4WDDrwdmGDyn6UtemzEJNSwGUAe646VgAvNUYQ1KM1hrZRoM9UVmejKX
         fQ5DW+X13+rJWB+M6nIgoaJkNVb2kUm/v6od7kC5IiEZCQyIPplW1pHgR2Ktff8naruz
         xxNHu9GmwXVBEZi0FJM29CExDym6bRLvKCb88S9+YNbPa1d99Dm+7hGHtU04FwSurBoL
         ZGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769680935; x=1770285735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1+A5PA2QuPZwYWlbPtFj9y2qIk4W2THrdGdKigGUGxc=;
        b=IJLCFjMvGzbm3de74/biJ5hXyjWAHSxbeyc+5KaKUIjaJk+kx7RoOY4Xe+z9VY153N
         X2Z1U8muQvuRmRh/mwS5N7MaWssjvhCzextKIpyNhV1btakIIjsP4u616+iLPiy/mwx5
         whivLttCWtM/jxh+Y7soHqKAWN4cF9bWBKDSInsRKFksFbb/dvBuzEVHqFq0u/CxEBg8
         66cLd/NiNV60Y3+ZFgxkMtYPXmM/ga+O/dadyjV7sXYe+TY4XNWtBCofJPuF8+yw2rIg
         N1VKL/8qqD4pb0Va7aPJ7nweu32A4mKak3vtBT6YrKupXJJ8X6oR28kCZQfLmQes9R5t
         /WiA==
X-Forwarded-Encrypted: i=1; AJvYcCWvJO6RiZx9yIr8EF/mfPOtCMyYVM6VAEofpdquS83sjNux6+SpnZvJ40NDUaW3iJjBb1wFTL5NEVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4OWdcoMBySK1N/xHpolXqr4sdRK4y+7y2vtLfxe3ISMB5Nlfs
	onc+lyjqmWaG2Z9w65GNLG63X668tN7TsoJOZgccbWCZt11Su8e/3YR7
X-Gm-Gg: AZuq6aINdYTjQALopwTR0eDJmyIIyf69Huskji+DR7olV0q8OyIqPHrxcBlFlZWPKgp
	CTXFLJeRcI7gyt//Hho+RwOfd5tTNRFd7bwyWwDN+kMEQ18wtPggAsCHJYBVFJW0j2GJn59sJw7
	KRj78Zc8wDZRKawGnM3m+xzfIpZB5MhnYwW9EFF6wqWdBNwJi80iU4mMCaYs7dcW+OuLnwqQ90M
	z7TxMaDjOODLFx0pSJCFHetmlbDxOc/vVjDxv9bs+7Eo/gaWO2Tre8arCz4/KSjA4Df+HMK2tQQ
	Q7bUjqVS7jKuB68tMTiXPOUzFmOa+7DpuUw2sAfjYJS/0+2YPm4JyM+elJUAj/qlXkumIi209pz
	0T1EbcCC1fI/MC7D9ESC4IP+FjOdzhFfTf/d8HTMgDbuf6fBtGDB8HXCxT2pXhgZfPodXI8TN59
	QDXvorW9jStqT2/QJ3KuMm4GK2q+e6nNeCr3Dt4I+d8xuR0mz6nP5b1WoRDnOKVUFtTA9t5ucpS
	agzgKPbIj88MLBg
X-Received: by 2002:a05:6402:5213:b0:64b:58c0:a393 with SMTP id 4fb4d7f45d1cf-658a60c3da9mr5373004a12.30.1769680934810;
        Thu, 29 Jan 2026 02:02:14 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-983a-6411-8910-8120.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:983a:6411:8910:8120])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b4691db4sm2608438a12.22.2026.01.29.02.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 02:02:14 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Neil Brown <neil@brown.name>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 1/2] exportfs: clarify the documentation of open()/permission() expotrfs ops
Date: Thu, 29 Jan 2026 11:02:11 +0100
Message-ID: <20260129100212.49727-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129100212.49727-1-amir73il@gmail.com>
References: <20260129100212.49727-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-18603-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38E23AE549
X-Rspamd-Action: no action

pidfs and nsfs recently gained support for encode/decode of file handles
via name_to_handle_at(2)/open_by_handle_at(2).

These special kernel filesystems have custom ->open() and ->permission()
export methods, which nfsd does not respect and it was never meant to be
used for exporting those filesystems by nfsd.

Update kernel-doc comments to express the fact the those methods are for
open_by_handle(2) system only and not compatible with nfsd.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/exportfs.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 262e24d833134..0660953c3fb76 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -200,6 +200,10 @@ struct handle_to_path_ctx {
  * @get_parent:     find the parent of a given directory
  * @commit_metadata: commit metadata changes to stable storage
  *
+ * Methods for open_by_handle(2) syscall with special kernel file systems:
+ * @permission:     custom permission for opening a file by handle
+ * @open:           custom open routine for opening file by handle
+ *
  * See Documentation/filesystems/nfs/exporting.rst for details on how to use
  * this interface correctly and the definition of the flags.
  *
@@ -244,10 +248,14 @@ struct handle_to_path_ctx {
  *    space cannot be allocated, a %ERR_PTR should be returned.
  *
  * @permission:
- *    Allow filesystems to specify a custom permission function.
+ *    Allow filesystems to specify a custom permission function for the
+ *    open_by_handle_at(2) syscall instead of the default permission check.
+ *    This custom permission function is not respected by nfsd.
  *
  * @open:
- *    Allow filesystems to specify a custom open function.
+ *    Allow filesystems to specify a custom open function for the
+ *    open_by_handle_at(2) syscall instead of the default file_open_root().
+ *    This custom open function is not respected by nfsd.
  *
  * @commit_metadata:
  *    @commit_metadata should commit metadata changes to stable storage.
-- 
2.52.0


