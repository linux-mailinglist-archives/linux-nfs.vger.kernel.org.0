Return-Path: <linux-nfs+bounces-19809-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFhRKZSoqWlSBwEAu9opvQ
	(envelope-from <linux-nfs+bounces-19809-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 17:00:20 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFE02150CA
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 17:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F91330054C3
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2026 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7312145355;
	Thu,  5 Mar 2026 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVAC+8/g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE30E3C3C03
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726396; cv=none; b=IPMcvhyfeUNr4lYGOxPnPvotKmLn79qZRexKDG1jA/hj6ZirT4FH5dR0YqjgPsm2sGjls40f9sBRpXPRT9BfnQHkOAxpIyuN9Mjrd3F5kE2HrPUVjrhduk+VmZ7s3TU2aenAo+kYXpvxgNvADKej2DUK/5fTTMJn8GtvQpxqh7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726396; c=relaxed/simple;
	bh=zmndLWg9xshhq2GajtmbQq/hVG0MJOSZYUL4a1XI+qQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Z9/vQc9q/m/4HddEKeLd0UPoAhkJyutsIgvxiqpBLjRRpBuSTgMAZaql1pxR2W4iDT4gVskrMrBEO8ZbWPRqoZt0/r0nHn2jwCA7NfiFYB7lfrQMo/bM4UCGWlswxRlZ5/vjJL7piSgQEfB/jEdWwhv4TZ4BoGpofM8crHzs4m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVAC+8/g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772726391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hJDGWPRnMwfGzGuRS8D6JqAOlwPWwOpdEW8p2kR+7N4=;
	b=aVAC+8/gw3cs+mRheLTKCY4mayFrOPmhRsHk0aJvBIZGko/zUFxFAcvSdIrVFN73dZ9yzR
	q1cmgewSFWusrVWPymLyIt2fv7w5i0elJU405eEATg1tCt9aRot/E0ylDuipHb5/TI1Pbd
	E8sKOJ8P7c3ee3GhE57vuCjdpKnoAIk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-GP0lUYtgMf-Rt185Ub3huQ-1; Thu,
 05 Mar 2026 10:59:50 -0500
X-MC-Unique: GP0lUYtgMf-Rt185Ub3huQ-1
X-Mimecast-MFC-AGG-ID: GP0lUYtgMf-Rt185Ub3huQ_1772726389
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 923B31956059
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 15:59:49 +0000 (UTC)
Received: from bighat.com (steved-laptop.mht.redhat.com [10.17.16.21])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B226180075E
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 15:59:49 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 0/4] rpc.mountd CVE-2025-12801 announcement
Date: Thu,  5 Mar 2026 10:59:44 -0500
Message-ID: <20260305155948.11261-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 6AFE02150CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-19809-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-0.993];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Vulnerability discovered in rpc.mountd in the nfs-utils package

A vulnerability was recently discovered in the rpc.mountd daemon in the
nfs-utils package for Linux, that allows a NFSv3 client to escalate the
privileges assigned to it in the /etc/exports file at mount time. In
particular, it allows the client to access any subdirectory or subtree
of an exported directory, regardless of the set file permissions, and
regardless of any 'root_squash' or 'all_squash' attributes that would
normally be expected to apply to that client.

The vulnerability does affect all known instances of the Linux kernel
NFS server exporting the NFSv2 and/or NFSv3 protocols. It does not
affect those Linux kernel NFS servers that only export filesystems
using the NFSv4 protocol.

This issue has been fixed in nfs-utils 2.8.6 and later, with an upgrade
advised for all users.

Trond Myklebust (4):
  mountd: Minor refactor of get_rootfh()
  mountd: Separate lookup of the exported directory and the mount path
  support: Add a mini-library to extract and apply RPC credentials
  Fix access checks when mounting subdirectories in NFSv3

 aclocal/libtirpc.m4         |  12 +++
 nfs.conf                    |   1 +
 support/include/Makefile.am |   1 +
 support/include/nfs_ucred.h |  44 ++++++++++
 support/include/nfsd_path.h |   8 ++
 support/misc/Makefile.am    |   2 +-
 support/misc/nfsd_path.c    |  59 +++++++++++++
 support/misc/ucred.c        | 162 ++++++++++++++++++++++++++++++++++++
 support/nfs/Makefile.am     |   2 +-
 support/nfs/ucred.c         | 147 ++++++++++++++++++++++++++++++++
 utils/mountd/mountd.c       | 111 +++++++++++++++++++-----
 utils/mountd/mountd.man     |  26 ++++++
 12 files changed, 552 insertions(+), 23 deletions(-)
 create mode 100644 support/include/nfs_ucred.h
 create mode 100644 support/misc/ucred.c
 create mode 100644 support/nfs/ucred.c

-- 
2.53.0


