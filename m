Return-Path: <linux-nfs+bounces-20063-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Jg/BX7CsmmvPAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20063-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 14:41:18 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 638A9272C51
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 14:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C575C3068254
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 13:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E85E3876B0;
	Thu, 12 Mar 2026 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWNQ2/pQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF711E1C02;
	Thu, 12 Mar 2026 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322812; cv=none; b=qtl0uOMqYKnmUyB95mboTrhxkcwIjxkbFFQY3U4nN/BCvP/nrsT1sM8k1UF5Y0veHoRNVUotMjI8RTSn168xE+Tx40X4Sb1Sv6BvqBIggHvHEckdoBxcVobJWOzMWPJg4zR/3cJ67AErBhVJX4/FAW8HwDtMYcP99rH0ZVHRPpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322812; c=relaxed/simple;
	bh=NAQQQ4XCwdK4jorQMuJg8WmK5muqJKwiYeyxhApv0yE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NUomWOOmCsPw4W8X3PMZC+PgtBhilrvLX8B8TiBjO0x29PjKMo1lKBs1P24C4qtzfJJBJNI1W9bA7GsdaZc5GojSQUuld6vrtr2O06X8Rgnghgnv+nOsG8eWkT9YSfZP5bUTKoWuH0bEXIIF0yeWUE4SjnVbC1Y+dIgoROGXK3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWNQ2/pQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2344C4CEF7;
	Thu, 12 Mar 2026 13:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773322811;
	bh=NAQQQ4XCwdK4jorQMuJg8WmK5muqJKwiYeyxhApv0yE=;
	h=From:To:Cc:Subject:Date:From;
	b=rWNQ2/pQNpEtVigYTlQ0sIQCEDScj4mHKZdORFyoRC8ZCdW5fB0ZrZztnAxVFdhlo
	 DbxCSCtRIrxSs70gX9VBzK62B8P4RostfKsNh08vf5P/GBUwY0QJV8GurXJBkZG4cn
	 FqzpiHX4E3MwQUQ4XZB+WjB/1Qg+nLGVc4WEzDFw4thxhmdVE4j/LpwViD3+NuzjtA
	 ZdzSiYTAYY0fNFmgBGs4EJg5hWcZvREH/MbpB7V+oeAglD54yyzt13MHJB9Hi4Cb8t
	 7lmkh/XCC+khTyOFsYNnqsjp7msvBXRv0B6JdypxSkbPPj44Kud3cXcBafIkJqW4eH
	 bZ9VABe8EE1bA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/2] RDMA/rw: Fix MR pool exhaustion in bvec RDMA READ path
Date: Thu, 12 Mar 2026 09:40:06 -0400
Message-ID: <20260312134008.7387-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20063-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,lst.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 638A9272C51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

This series now carries the original fix with review comments
addressed, and a proposal for using contiguous pages for RDMA Read
sink buffers in svcrdma. IMO the fix patch should go into 7.0-rc,
and the RDMA Read behavior change can wait for the next merge
window.

Base commit: v7.0-rc3
---
Changes since v1:
- Clarify code comments
- Allocate contiguous pages for RDMA Read sink buffers

Chuck Lever (2):
  RDMA/rw: Fix MR pool exhaustion in bvec RDMA READ path
  svcrdma: Use contiguous pages for RDMA Read sink buffers

 drivers/infiniband/core/rw.c      |  16 ++-
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 220 ++++++++++++++++++++++++++++++
 2 files changed, 229 insertions(+), 7 deletions(-)

-- 
2.52.0


