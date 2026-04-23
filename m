Return-Path: <linux-nfs+bounces-21058-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJtPIEFi6mmrygIAu9opvQ
	(envelope-from <linux-nfs+bounces-21058-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 20:17:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D516455FDC
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 20:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71BF2307B105
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 18:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B499C3A9619;
	Thu, 23 Apr 2026 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuNruzrp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9238F3A7848
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968108; cv=none; b=Vq44KiI32+okWt9IsdjdxgR7ATMsITxx9o/YdDH2WQ3iih0D/EJlZJYEh0bkeoMQdIqcX7e36LjEutopsmWwfz8pkhPqq89vD5312GSzCpB7WL0BeRs5az8ImhfxGcIA9BP1jfsclKh+XlIew2VKSo/H9UND3inj8MLTLmnd1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968108; c=relaxed/simple;
	bh=OR01UjxMfYJFy4n90PyrT9M9f1Gyxjz+d0pOAFtLJ0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=smb7M+GH0QNHLdHxtRi2CEfBU6f1no7gTZyL4YBfaGLpDg38rR/6tMEEE/Tb0HhR44eaer+qGEXpufouF0IgrMnS4vBMlmvXBcrJA/8+tf5/eNB8429Df9PNAQN30z/PLxFEWx54StXMPBH5dVrjs3bOR4ee/K6ORZFfGbba0LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuNruzrp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822D9C2BCAF;
	Thu, 23 Apr 2026 18:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776968108;
	bh=OR01UjxMfYJFy4n90PyrT9M9f1Gyxjz+d0pOAFtLJ0w=;
	h=From:To:Cc:Subject:Date:From;
	b=BuNruzrpfRQ7DVFIQYPOiNR37KDxKieTWkzVSqT+cYB3FytupMWa/CsVJQViWwVVV
	 zsDYByXhNIRGvu64bpmffZOdme6CLpwbsyGCx1QAjF5k99x2ejeqQNwhoWofFCe+DI
	 QGoXmYYcZKtD3TSsBZkyzWedK8NyNURRVJQv9dydAQWLkY6x+NX5UIVcLIl6jDedww
	 OPHj1vGurboNcWPqDGbt287lZChMs78IAITnIsxm3Yj14ZNc+KTvvmt3Jeuf78/ayH
	 SeCPOKFPmlQtIVF5GlvGTMQ73f0YpAETHtVzsx9ngRZcdlqTNftvk8SwxBSPfoHAH9
	 Tge0BQyu1ix3w==
From: Chuck Lever <cel@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 0/4] cleanup block-style layouts exports v3
Date: Thu, 23 Apr 2026 14:15:00 -0400
Message-ID: <20260423181505.742554-1-cel@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21058-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D516455FDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Following up on https://lore.kernel.org/linux-nfs/20260401144059.160746-1-hch@lst.de/#r

Here is the current version of Christoph's patches that are in
nfsd-testing. Christian prefers to see them taken through the VFS
tree. Once the patches are applied there, I will rebase nfsd-next
and nfsd-testing on that tree and drop these.

Christoph Hellwig (4):
  nfsd/blocklayout: always ignore loca_time_modify
  exportfs: split out the ops for layout-based block device access
  exportfs: don't pass struct iattr to ->commit_blocks
  exportfs,nfsd: rework checking for layout-based block device access
    support

 MAINTAINERS                    |  2 +-
 fs/nfsd/blocklayout.c          | 37 +++++++-------
 fs/nfsd/export.c               |  3 +-
 fs/nfsd/nfs4layouts.c          | 29 ++++-------
 fs/xfs/xfs_export.c            |  4 +-
 fs/xfs/xfs_pnfs.c              | 44 ++++++++++++-----
 fs/xfs/xfs_pnfs.h              | 11 ++---
 include/linux/exportfs.h       | 25 ++++------
 include/linux/exportfs_block.h | 88 ++++++++++++++++++++++++++++++++++
 9 files changed, 162 insertions(+), 81 deletions(-)
 create mode 100644 include/linux/exportfs_block.h

-- 
2.53.0


