Return-Path: <linux-nfs+bounces-22098-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LquN+3jGmqS9ggAu9opvQ
	(envelope-from <linux-nfs+bounces-22098-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 15:19:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E524260CEC7
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 15:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5F56300D78C
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 13:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE032DC357;
	Sat, 30 May 2026 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8xDnzER"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE402C187;
	Sat, 30 May 2026 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780147173; cv=none; b=eDsLo2cVZd55A/s8+ZWeLCiF1ux4G+RDnprVqDeTwYzf+iCpWo9XDYGEcwE1vtaiZc+RAQPsJWwdem0vP5+NygB4VOj3Pa2sTMqNffB25g74BtCsZk2o+cfqIAvKrFkmTuA9yvAaAglPRJfDlwQLHUicUMti7o2zff6+AcNvbXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780147173; c=relaxed/simple;
	bh=SP+OCQUU2AtxUP1nhqsYd1qu1it9vVMtevMT+aJBI/o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YVbT1zE+2EF3jfxSu107QHPRVzTGx4qLIOferZ/BEdO30nnRmrIs5nMcO9mE+2hgSwDsBsKoNa9gKG92iWeRLKopA8oA2k80ou4Y8C7r6GwUI37bPCA1EG9cEGXSR3kAPBV9wJ9P76E9MNr79NfR2/JMPHqP4uQOGpj+jdvotz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8xDnzER; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A181F00893;
	Sat, 30 May 2026 13:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780147172;
	bh=3MNF7ey9rhsqBOuNZeG2zzoq5Eilpcs4fPMYPNtNOV8=;
	h=From:Subject:Date:To:Cc;
	b=d8xDnzERNPPPcsCilM95g+SlNs5YbJC8/glQvHzkE4eAIMFdZa45LxCOx+gUXk5P+
	 GSRxOvhMXMCJYbYHE09z/UQV4x1trs0DHWE8028feiZrDs1W5F4yE5JcsmzDszAF1f
	 XO49v1cqohLyjIEngowbZw1tUjjWfOCTGUAaSyGY7iJIGpwtzLgcwk47lROoAJUYRA
	 k360VqPqoLYvYTl0kmjW/qOgQ3W5wQ5wRRY52tHKsvfDyY4exAi36U9c3tey2MtM/e
	 Da06Ay3zmbdUUk87TWiuXkrgHjr9fdEsFDurU2Nk37DNy2xRYo4OsA366ooq+UQHaK
	 WbcWCLgm70ong==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/9] nfsd: a pile of fixes for random bugs
Date: Sat, 30 May 2026 09:19:16 -0400
Message-Id: <20260530-nfsd-fixes-v2-0-f27e8eb4d974@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22MTQ6CMBBGr0Jm7ZjSBFpceQ/DgtApTDStmTFEQ
 3p3K2uX7/t5OygJk8Kl2UFoY+WcKthTA/M6pYWQQ2Wwxvamsx5T1ICR36Toh6mnjqyZhwD18BQ
 6irq/jZVX1leWz+He2l/6V7O1aJCcd8ZTjM6F650k0eOcZYGxlPIFlz2oDKUAAAA=
X-Change-ID: 20260528-nfsd-fixes-89a6e5e20c9d
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Scott Mayhew <smayhew@redhat.com>, 
 Trond Myklebust <Trond.Myklebust@netapp.com>, 
 Andreas Gruenbacher <agruen@suse.de>, Mike Snitzer <snitzer@kernel.org>, 
 Rick Macklem <rmacklem@uoguelph.ca>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2886; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=SP+OCQUU2AtxUP1nhqsYd1qu1it9vVMtevMT+aJBI/o=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqGuPccX/U6U+dp2UgDyc1Fgg4D31MbsDZgvMtU
 N/uTRyY482JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahrj3AAKCRAADmhBGVaC
 FcnEEACoZWTVyYFZZzVxnJgC3aEhTUbex6DTauX8Jxsy1B7UriDIE7OiT4m4d3Y3YWT/NoN339a
 4jmD29we5Vq+sIYUBuCdq+iqoQkCkiLqLHpxde0W0N6LYpxwcZv7RU2DvIDeRrCOJ/zsD2u8QTX
 Zwzsha7VaqR33u/2hD05D5ZfZ6W/006rD6L/CMExfUNM6xl5BTtUWqATqqSoGlbZBtPBWMnEQ8R
 h9HUCLiTdk7XlaKLREftsQH2x8knHgh6Nj0+1ZM1W9gg2c4edFGTctMeijKFqpAyv4fOlXFpkUU
 A3E9Z7FWAS7O1ATFmpTVwXLZG99tIqnzwXTbgK1wjxO/nco9tZjjb5QvnJic3C9YQNmzpMuEEFG
 HYhjmxCWmUHEW78HLL0ZjB2jQbanW1+wYk2R/M7QKlbhAZI6ALvyWLDMzuT1nP5L5ZtjxNfTd0B
 cJG6PmUUZf9pKWXTZ8vCXa7MmRTlGi3jSwv/WPMSirdlV+vs4Z/KyvYu260UDeM9chsM6nJBoaG
 0gsCon5mUtrfYGIVVWaF3prKus79ZDo2h7t+PrsUEWFk2XbYmNehDcMDMJqda/QHMLiOTnDvVVY
 WbZAn3pVRPbvaAI4ly7B+gtKFdmKXgkkwKgqsgZqyvrZwEvdWcsG14872/onj8ZiqF/S7/sc2ZR
 S/hpBUS4VdnJR2w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22098-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E524260CEC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These bugs were categorized as remotely-triggerable panics, UAFs, DoS's,
etc., but they aren't reliable. There are also a few protocol fixes in
here too, etc. It's a grab bag.

There are a number of substantial changes in this version. See the
changelog below:

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- dropped "NFSD: Enable return of an updated stable_how to NFS clients"
- dropped "nfsd: serialize nfsd4_end_grace() with atomic test-and-set";
  replaced with "nfsd: convert nfsd_net boolean flags to unsigned long
  flags word" which addresses the same race using test_and_set_bit.
- dropped "nfsd: drain callbacks and clear cl_cb_session"; replaced with
  "nfsd: RCU-protect cl_cb_session to fix use-after-free on session
  teardown" which uses RCU and kfree_rcu instead of synchronous draining
- "nfsd: validate symlink target length in NFSv4 CREATE": use
  NFS4_MAXPATHLEN instead of PATH_MAX for the length check
- "nfsd: cap decoded POSIX ACL count to bound sort cost": return
  nfserr_inval instead of nfserr_resource for over-limit count; return
  nfserr_jukebox instead of nfserr_resource on allocation failure; added
  comment explaining why NFS_ACL_MAX_ENTRIES is the right cap
- rework "nfsd: dedup nfs4_client_to_reclaim inserts" to use rwsem
  instead of memory barriers
- Link to v1: https://lore.kernel.org/r/20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org

---
Chris Mason (4):
      nfsd: convert nfsd_net boolean flags to unsigned long flags word
      nfsd: gate nfs3 setacl by argp->mask
      nfsd: fix partial-write detection in nfsd_direct_write
      nfsd: cap decoded POSIX ACL count to bound sort cost

Chuck Lever (1):
      NFSD: check truncate permission under inode lock

Jeff Layton (4):
      nfsd: fix BUG_ON in nfsd4_alloc_layout_stateid on racing delegation revoke
      nfsd: RCU-protect cl_cb_session to fix use-after-free on session teardown
      nfsd: dedup nfs4_client_to_reclaim inserts
      nfsd: validate symlink target length in NFSv4 CREATE

 fs/nfsd/netns.h        |  25 ++++++++----
 fs/nfsd/nfs3acl.c      |  17 +++++---
 fs/nfsd/nfs4callback.c | 109 ++++++++++++++++++++++++++++++++++++++++---------
 fs/nfsd/nfs4layouts.c  |  14 +++++--
 fs/nfsd/nfs4proc.c     |   2 +-
 fs/nfsd/nfs4recover.c  |  48 ++++++++++++++++------
 fs/nfsd/nfs4state.c    | 103 +++++++++++++++++++++++++++++++++++-----------
 fs/nfsd/nfs4xdr.c      |  15 ++++++-
 fs/nfsd/nfsctl.c       |   2 +-
 fs/nfsd/nfssvc.c       |  22 +++++-----
 fs/nfsd/state.h        |   3 +-
 fs/nfsd/trace.h        |  14 +++----
 fs/nfsd/vfs.c          |  35 ++++++++++------
 13 files changed, 299 insertions(+), 110 deletions(-)
---
base-commit: 2d0c1f87f37de51bd96df415c7c1d498989570ac
change-id: 20260528-nfsd-fixes-89a6e5e20c9d

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


