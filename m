Return-Path: <linux-nfs+bounces-20944-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rhpDAHjV42m0LAEAu9opvQ
	(envelope-from <linux-nfs+bounces-20944-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Apr 2026 21:03:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FAA42202D
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Apr 2026 21:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84B8E302B394
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Apr 2026 19:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06832238150;
	Sat, 18 Apr 2026 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXxTrVUc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED5F30C35C
	for <linux-nfs@vger.kernel.org>; Sat, 18 Apr 2026 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776538996; cv=none; b=jGhS6ZKf5t9iMZfsnNzfjId4pmSAhA92uhCr6PkQV3LhF3wgCq84j/zGU7gs3hBe0dcHVMxtsasI7khGHzEFcTuHZ7sipTCGOz9n4sidGq/Kq9Uw/TDuYXHaQc12+w+1qdFt7+L0NK2oi5pYYoTbW0BC25FFIPgOqfXZqiPoom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776538996; c=relaxed/simple;
	bh=9DYNjKpuB5qgERQlqBDiZMOIjttooIpFFAwuyegsj5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TCijOsAvNlyZithvHQUfRraFJTGLujYW3ukluFRMG0p6kVXMt1D96aAOWxTDlPQcy4KeGVZOsdHB+tw15gQ3O3XBXAof5dbbZ4ycVttjc5X/ckvoVF2kx2rSjcYtKOQ0CRjv2UzioxBnB6qW/4eBaH1i31gyT8G6MOrQhT/9jnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXxTrVUc; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b4520f6b32so2125652eec.0
        for <linux-nfs@vger.kernel.org>; Sat, 18 Apr 2026 12:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776538994; x=1777143794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4+3Fqo1aUGRpUHMKskwUllOJaVwA3J8P60pHdff3Ltg=;
        b=hXxTrVUchNakPWHzYr8v51QV2HVWPCFDfy971cGy2Fx/Y91NCgaTKMWFLJTfq7ahTf
         IbYrb2k4U0lvkTsuITOGQwCfC8m80quOTdRM5ISaSh4izIV7ciGxmGn/fxN2ATWPhqCQ
         b9ftD5K94zSq4YWhadrSzsPHIDf8CBbKvuJ8TuD2smgfQR4bjVK3+7HBMJVIODBsO1yb
         k5FTcFYz/k2vJm9OXMYKmOBkTm9TRPRUm2GiRVxbR663GLGcEP8N79lWy1/CwxyUagWr
         bl+Fu1YmW8/dYBQ5M3TN2iUYrR5IwELLyIQuYe5D29Wd7OMzk2IJ3X8z1EfaTOF93l9V
         nzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776538994; x=1777143794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+3Fqo1aUGRpUHMKskwUllOJaVwA3J8P60pHdff3Ltg=;
        b=P8BPhh5OD+FModqZreXBTrqta8QVcPorJKG7/onEwofo/K8/m75LQxdNrAy00jcJeA
         wVPMv0XHeVAU/Y5SSzwEzpkH9iygjYDZS29NU1m3/u5v3zFbEv3nQW005mOdgJYOU1US
         1aHbkFiwrEd6vwHeKBt84cGimJA8uZ11CcgMRBiw3czRh0mNyi8Tj6s9RGsM2m+OXehD
         CUpDv/bcvUve72Mt8c/tGpK9sI6ekypv9OoqyJNnymwhlNeBxAypJoJxhMAZXAphpnq1
         bObPBCatJ2K5SHwxOpqh9eeLnFghcLlSo0HEELjvePGFs/jPRIEEDX8/AbWYpXrDNQFx
         zZLA==
X-Gm-Message-State: AOJu0YwRYERIcX3WEFkIWt1NsTHQK+2Fvp0ypaoz1DKLSOtfvX0CMd6w
	vqRQZD+ivnoGEv9+C5j2AQpdS7eNdZ2yajXKsKy7F8GB0pnkSs7OyIO08rcCLw==
X-Gm-Gg: AeBDiesqUsAKgJX7skO2i5CfstY9zbhKhi2dH6jEkZxOicPfcDU4cxfKriuSVFNrWZH
	nO74bObr5U1Tl1A5AJl2IQl1WQbZni2gjnXEdXw6EX6o+LAkCJTq5qWDfvj1bPp/0NHYiwV4dn4
	+H9He/drIiMnWVEwu/EuPvyofED4SFbAGHNUTFIs6nrkB4L+jBZ2/vx5Xw0tHeBMn+LnAQhMs+c
	vC/pceVy7S5u/hrhw2fsCj0rPS/qWOMMKfFLcSN30n0l7+LkuHwHVIEBpeezscrZ/bMsdemXvsV
	5StOKapM16D1OCHZ143xlx9YNuScUq+mklcupLT2ApV9/TgBIrxEU1LfqnWZMi9qLIoT7nKUVY3
	Y7+joWdmHl4xTsMAHDLhStSFwr2cyacc7U/HmB9iEOGYi477z23peSMlF/W6g0TYsnN3GQ8IZXj
	OJj+cjK5wN63IAVmGgBJ/0mhSiwSLG3e9GzddWcl/VwpcYFtEK6XZm/seGHIouffQ=
X-Received: by 2002:a05:7301:4185:b0:2e0:1f09:d924 with SMTP id 5a478bee46e88-2e464ea9aeemr3615388eec.5.1776538993674;
        Sat, 18 Apr 2026 12:03:13 -0700 (PDT)
Received: from shadow (c-174-160-87-152.hsd1.ca.comcast.net. [174.160.87.152])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2e53d8b3dd9sm7254785eec.27.2026.04.18.12.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 12:03:13 -0700 (PDT)
From: Tom Haynes <loghyr@gmail.com>
To: linux-nfs@vger.kernel.org
Cc: trondmy@kernel.org,
	anna@kernel.org,
	jlayton@kernel.org,
	chuck.lever@oracle.com
Subject: [PATCH 0/1] nfs: fix directory mtime staleness under directory delegation after local mutations
Date: Sat, 18 Apr 2026 12:03:00 -0700
Message-ID: <20260418190301.3661-1-loghyr@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20944-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[loghyr@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41FAA42202D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

A cross-parent rename(2) against a Linux NFSv4.2 server leaves the
client's cached mtime on both parent directories stale, even though
the server's in-memory inode mtime is updated correctly.  The bug is
entirely on the client side in the directory-delegation + mutation
interaction.

Server instrumentation (bpftrace on vfs_getattr + xfs_trans_ichgtime)
showed the backing XFS and knfsd path both advance mtime correctly
through vfs_rename -> xfs_dir_rename_children -> xfs_trans_ichgtime.
Subsequent vfs_getattr calls on the parent dirs on the server side
return the fresh mtime.

On the client:

 1. The local rename path calls nfs4_update_changeattr_locked() and
    marks NFS_INO_INVALID_NLINK | NFS_INO_INVALID_DATA on each parent.
 2. The next stat(2) enters __nfs_revalidate_inode() which early-exits
    on a held directory delegation, returning the cached (stale) mtime
    without sending a GETATTR RPC.

The delegation early-exit unconditionally trusts cached attrs, but the
rename/create/unlink paths have already flagged some attrs as stale.
This patch keeps the early-exit for the fast path but takes the
RPC when CHANGE/MTIME/CTIME is already marked invalid.

Minimal reproducer (client):

  mount -t nfs -o vers=4.2 SERVER:/export /mnt/x
  cd /mnt/x
  rm -rf src dst && mkdir src dst && touch src/f
  stat -c 'src_before: %y' src
  sleep 3
  mv src/f dst/f
  stat -c 'src_after:  %y' src

Before: src_after == src_before (stale).
After:  src_after advances by the sleep interval.

Verification
------------

 - Loopback (client and server on the same Linux 7.0 host): test
   passes after the patch with default directory_delegations=Y.
 - Separate physical client (Linux 7.0 with the patch) against
   a Linux 7.0 server: test passes with default settings.
 - Disabling directory_delegations on the client (echo N >
   /sys/module/nfsv4/parameters/directory_delegations) is a known
   workaround that also makes the test pass -- which is what led to
   the diagnosis.  The patch removes the need for the workaround.

Reproduces against every NFSv4 server we tested (multiple Linux knfsd
versions, reffs, FreeBSD NFS) which is consistent with a client-only
bug.

Test that surfaced it
---------------------

nfs-conformance op_rename_nlink case_parent_timestamps:
https://github.com/loghyr/nfs-conformance/blob/main/op_rename_nlink.c

Alternative fixes considered
----------------------------

An alternative would be to call nfs_update_delegated_mtime_locked() on
the directory from the rename_done path, treating the client as
authoritative for the delegated mtime (similar to what the write path
does for files via nfs_update_mtime).  That's more invasive and only
addresses the rename path; the __nfs_revalidate_inode fix in this
patch is defense-in-depth for any code path that marks an attr stale
without taking the delegation back.

Happy to rework if you'd prefer the call-update-mtime shape instead,
or if the guard should live in a helper next to
nfs_have_directory_delegation().

Thanks,
Tom

Tom Haynes (1):
  nfs: don't skip revalidate on directory delegation when attrs flagged
    stale

 fs/nfs/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.53.0


