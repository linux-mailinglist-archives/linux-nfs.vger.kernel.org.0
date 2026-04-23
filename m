Return-Path: <linux-nfs+bounces-21066-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGUyGJhi6mmrygIAu9opvQ
	(envelope-from <linux-nfs+bounces-21066-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 20:19:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0463456032
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 20:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB4F7300611B
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 18:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1593AE18D;
	Thu, 23 Apr 2026 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgoOX0iJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFDE387371
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968340; cv=none; b=jN12COKIHMSH0Rsy7X5wkPwpJfKAQD56ySE4yyba5IkUzI0lNFaFr9wsh8D3vwnKvx7siCTI53YAt6jU2ZYFPFgxVDtg+9Q6PYhAjHjyfuONCaUc/L7HoLxEODWvaGKUSiIiVcmKxl5fG6EDBLU9sNGBkKBwscQLjWRjzLTtrCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968340; c=relaxed/simple;
	bh=OR01UjxMfYJFy4n90PyrT9M9f1Gyxjz+d0pOAFtLJ0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jMjdoHu+akPoPE0z0bPMKj6svZDFKforOMoNBSchxJcb2KOZtF9gCl2enl5SCAs0n69Hv4qSYzpoUfmNZ63aS9nfFdpE1rv7Q8uIRJBQIHti0RpUt6+sqUcGKxUxxgZtEkowzeusIY2SdOYlFh9/dv5jYYODn03/OacZCZXxhj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgoOX0iJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65CEC2BCAF;
	Thu, 23 Apr 2026 18:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776968340;
	bh=OR01UjxMfYJFy4n90PyrT9M9f1Gyxjz+d0pOAFtLJ0w=;
	h=From:To:Cc:Subject:Date:From;
	b=jgoOX0iJR8v+PwK8Ul96NhKCx54hf7CnnPnupo+b/Vzxqb9vNWAnZP5EmAD+LnVKF
	 uzYMkTXIjXabpKj03oaBJ6/Md3zXHoy2F905BOd7FVRF2NZP2w211rjRR3JaHGHjG2
	 28tl+SIxM47Qt62drIiPpk4JS/EbPnB0mmivXKgm9MwPkkbx0ygfB2UdEDPoka2Rnj
	 nW8uLmhA4CIrMImC8A7voCNCE/XURGm+Xry4zmjoYqwOWRBS/c5HNUbBCdkeUEJjly
	 uwIZq16rR2z54sKi7oE3H230/XkulkJEJnN1TaldRWAdpGe/DybAxodsoGO6adbtyG
	 Wh0XllG8Zou/A==
From: Chuck Lever <cel@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 0/4] cleanup block-style layouts exports
Date: Thu, 23 Apr 2026 14:18:50 -0400
Message-ID: <20260423181854.743150-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21066-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0463456032
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


