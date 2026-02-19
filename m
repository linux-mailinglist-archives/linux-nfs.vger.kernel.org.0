Return-Path: <linux-nfs+bounces-19040-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBeVCqCFl2mwzgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19040-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 22:50:24 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F254162F38
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 22:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3108B3006390
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 21:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61552D9ECA;
	Thu, 19 Feb 2026 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQJQl1lw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B235F2D9EC2
	for <linux-nfs@vger.kernel.org>; Thu, 19 Feb 2026 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771537821; cv=none; b=uWAng/EIAXle9BuZtyS7PXOG+9jPrP+qqtABKb7vq1aMr45vpyxopuW1/8yErdk4kBvuUYzveBuZtOoWnAklki8BTk4prMCLMqAR2023XRcmF8lX/k93FOWtAJJPz1tHjCTx24RGvP433THrEr4TSitbQH5M9sq/TqgiQd2GN14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771537821; c=relaxed/simple;
	bh=Yo0GkVwaNf6uUiyAu8h/g9xV07lovlb5WOjO3iEblJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PvrIE7e2kaEQgkKgnxHuogM7Uuncobl1hIllb4pK9mkAswHbbCkTOk9N5USrvcnQ3mCORPMd5zlNMTqqu8LCCoCFdq40hbGFc2PwhLg6K8B+ske1HifsyyMv8NIXRiF19HWOvze3oQEgbrLicVzYfnx6cigHL+BAvAodwyAZ+QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQJQl1lw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AA0C4CEF7;
	Thu, 19 Feb 2026 21:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771537821;
	bh=Yo0GkVwaNf6uUiyAu8h/g9xV07lovlb5WOjO3iEblJQ=;
	h=From:To:Cc:Subject:Date:From;
	b=MQJQl1lwCZdywXi0zmNvHKegxqx5/QuX4ttEuz0nf1NZHrq/rFpU4vdXgoDfdbZc0
	 r9CaPNQ9z+H8WSPFkAipvhE6zOCfhVJebwZrN32JX79WKQPBGc+avZ1vp/6rLXvo0m
	 tDgSehQowEvrEOtlNVjtwjabh0obCCtAtvHPRumxGAjP7KOwcAOXd7s/afYAbGcOQz
	 VHcFrh4Zro+yG+ir+WktOHZTPdgHzHiPeQ4/oXBicXOQSrHReXDRABP+sJzd30wmAL
	 t6Fce7X7J9/9U8sfJW9XypV50iuKIbQ2UQFipDhezFNJw7xBwphbBxX3NWXfl65NP0
	 5l1Gmey16HH7w==
From: Chuck Lever <cel@kernel.org>
To: misanjum@linux.ibm.com,
	NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 0/2] Address UAF in sunrpc cache show callbacks
Date: Thu, 19 Feb 2026 16:50:15 -0500
Message-ID: <20260219215017.1769-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19040-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.ibm.com,ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 9F254162F38
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Attempt to address three crashes reported here:

https://lore.kernel.org/linux-nfs/dcd371d3a95815a84ba7de52cef447b8@linux.ibm.com/

These are compile-tested and regression-tested, but as I do not have
a PowerPC system handy, I will need someone who has one to test
whether they actually address the crashes.

Chuck Lever (2):
  NFSD: Defer sub-object cleanup in export put callbacks
  NFSD: Hold net reference for the lifetime of /proc/fs/nfs/exports fd

 fs/nfsd/export.c | 63 +++++++++++++++++++++++++++++++++++++++++-------
 fs/nfsd/export.h |  7 ++++--
 fs/nfsd/nfsctl.c | 22 ++++++++++++++---
 3 files changed, 78 insertions(+), 14 deletions(-)

-- 
2.53.0


