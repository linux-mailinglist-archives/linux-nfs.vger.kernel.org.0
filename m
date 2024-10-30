Return-Path: <linux-nfs+bounces-7576-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2846F9B666F
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 15:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED3B1F21B08
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B843F1F4FDD;
	Wed, 30 Oct 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VX4YR7Mn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF41F4FDA;
	Wed, 30 Oct 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299734; cv=none; b=NavMl9rSinXUXXy6Mdfc4wBvu5AN4KW8V2Ey0Pc0TVs7389iQXhg6Z0taxoGvJRY4eG8N/fjoEIYUmXsklcFFz9aj5dUzZyODTonNNmJ9ERDUfZI/kpBEM50zzJ0rU5L1WEcofgd6ZT4nEY3avCN4zI6w0YO22T6lTSWKrlZJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299734; c=relaxed/simple;
	bh=+fvXUWE8BMuCsxYuxzEUcmsJ0iKlRSPEARJz3kBuGHg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z9Fqq4Tl38mgefd6UmRKoEOwPSeOaY21cDZSmeqhEsOw32MSUqQHUPM6/S2YzCA+xCE6R4s3qQs/qjzeyXVwAQAag6i5yPT4ZINWrcd+VOcXE08D4pvENNuqH7wu08KiKKWENTgxaed+oxhjVU8yJjQuppUQhGhJQW2op7hyilc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VX4YR7Mn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69801C4CECF;
	Wed, 30 Oct 2024 14:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730299734;
	bh=+fvXUWE8BMuCsxYuxzEUcmsJ0iKlRSPEARJz3kBuGHg=;
	h=From:Subject:Date:To:Cc:From;
	b=VX4YR7MnQuykdu9PXGXXIX2pfyuBZS7JDePlHsvSJ6IbaK7EzY8979ZGLOmZrd6EH
	 ot/o8Y0efT0Bbbi4AwEKUep5wiaNi8Q8CfHGPemjbOpQNFbq+2MqQ4NUkic7zVgfK/
	 MrV+1cRcQYfiyf+07LJAhlnOMYoPLk3+24kLjJbahioeNTtMD1GCMDNaoEoKxQDQbm
	 KSc0/xApc8UFmM7pyM9APGCFkN99d0W1ZgCljalyFR7L8JGIh2t2qbs4+A8XVfMYso
	 ghkJD5ZhzUmOj8lqgvuZamW6/gyVWSNDyQTFOpyu3UiZcrKtG27I564vFgnbIFchAA
	 V/8Q3nWMhUm1g==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 0/2] nfsd: allow the use of multiple backchannel slots
Date: Wed, 30 Oct 2024 10:48:45 -0400
Message-Id: <20241030-bcwide-v3-0-c2df49a26c45@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE1HImcC/2WNyw6CMBREf4V0bc3thfJw5X8YF7S9QKMB0pqqI
 fy7hRgDcTmTM2cm5slZ8uyUTMxRsN4OfQzpIWG6q/uWuDUxMwTMBKDkSj+tIZ4rU1Cm8tQoZBE
 eHTX2tYou15g76x+De6/eIJb2TxEEB24QIC1IZlDr841cT/fj4NpF+eXLHQ9UyLpEURkNW375D
 Lj9qX475IJTBQJUTo2UZreb5/kDub39qwUBAAA=
X-Change-ID: 20241025-bcwide-6bd7e4b63db2
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+fvXUWE8BMuCsxYuxzEUcmsJ0iKlRSPEARJz3kBuGHg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnIkdQ1Vp3A4Enbm1pIJQmxWXgplGgmpi/ASHL/
 keRwJ66yCaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZyJHUAAKCRAADmhBGVaC
 FWLXEACIq0POZXJRBbbrbvPC1J7WbM/+Zd2iqnWTavr2UgRCy3CS+sgVMJJJvxxdEQSbDRF3ek1
 //OO4ozbpb2vwyk+8WjhwtuK6EpQG1Hxu6PWdCtP28XXIwrCl0fAhIOCRlwR9A/oJUJutzMrMUc
 dtl0jq9RbtLlJQY7RcmWObgXDRyI62+rYeM9fzRvfXU/x7KKkqv7ogTh8Rt+1HIhz/BuIrTpLnZ
 kh2RBmRFdR8axT6qRkX+LAzu3kbNDTD+qcnXtVQJ6zpEp3xx2PMYtM6rL2fKbgZtsXDXVFr1GnG
 6TAeKzSHmVns1+SNDUrwnyCVKyC6HliazMwdOH+zar4L3qNdyUgISmH6BHz+wpifXO43dOWaGZe
 5RS8T3G5uHMA0g16T4wggVyWhl2Gsig94zVWqPs3I675bcDdjNVVzsCjhhPLtYilGb/OVTaxvGq
 gdiwRCbbduG/oInQe8LP98bHBDhsFo5ULAH3mlW6dsqkPhHmOJLRDU0421VtSC2vYuw4vJgLxYk
 Xkj0CLti7kVUKTi2BIAxWH0Vm2x/FviCJSeRXP+ZlyrMnNTjUyOGDAvG2PxVHqk83yN0LcYjPOZ
 ogOSo+aO/rC9QU+8mBdPupzesooR7MmtaT7ol8o0/WDk/UbBwBYK1AlGUHyoHFp4EL7gkYzBHqn
 5itQOabWGV8yaEg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

A few more minor updates to the set to fix some small-ish bugs, and do a
bit of cleanup. This seems to test OK for me so far.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v3:
- add patch to convert se_flags to single se_dead bool
- fix off-by-one bug in handling of NFSD_BC_SLOT_TABLE_MAX
- don't reject target highest slot value of 0
- Link to v2: https://lore.kernel.org/r/20241029-bcwide-v2-1-e9010b6ef55d@kernel.org

Changes in v2:
- take cl_lock when fetching fields from session to be encoded
- use fls() instead of bespoke highest_unset_index()
- rename variables in several functions with more descriptive names
- clamp limit of for loop in update_cb_slot_table()
- re-add missing rpc_wake_up_queued_task() call
- fix slotid check in decode_cb_sequence4resok()
- add new per-session spinlock

---
Jeff Layton (2):
      nfsd: make nfsd4_session->se_flags a bool
      nfsd: allow for up to 32 callback session slots

 fs/nfsd/nfs4callback.c | 108 ++++++++++++++++++++++++++++++++++---------------
 fs/nfsd/nfs4state.c    |  17 +++++---
 fs/nfsd/state.h        |  19 ++++-----
 fs/nfsd/trace.h        |   2 +-
 4 files changed, 98 insertions(+), 48 deletions(-)
---
base-commit: 06c049d2a81a81f01ff072c6519d0c38b646b550
change-id: 20241025-bcwide-6bd7e4b63db2

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


