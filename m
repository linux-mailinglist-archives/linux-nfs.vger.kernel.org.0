Return-Path: <linux-nfs+bounces-22025-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fsBEKpQpF2qn7gcAu9opvQ
	(envelope-from <linux-nfs+bounces-22025-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 19:27:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E69B55E84E3
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 19:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73BD330BB282
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 17:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67D244DB7F;
	Wed, 27 May 2026 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJaBIMgH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C008244A725
	for <linux-nfs@vger.kernel.org>; Wed, 27 May 2026 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779902429; cv=none; b=Tfj1i18zo5ZFvRwQ4Ts/WJhXeugRnrMGQ/qcC+GbBBmI/lt2lVG80yLgdMORwcoGCDzF2M2BpHO80itjm97fP1zvPvFC9lTFdxdED5m1tPJyvRFpvUeUy3H5iTaNBFp0owiiKKN/pHlJbqqhky9mTtMPExpUaNQgfuNZczI65VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779902429; c=relaxed/simple;
	bh=VH0RCcZQaVL3JWS8fb0Nu5tfGs6t/XFgeI+ODqn5mFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCXzNPOkozwE7d7sZrmpe2YQPMn+GKIyRZ3P3TkwYwqKJ8GyYlvi85e4dksy8RjLqygRW8mxDdqTXhOra/P13RZ5Ka4OPFepHaausoxMsdRdkVMOyp/JgqNIy/c2T/A7AQli0iP5CE3XeBUVLVrAvemUlwIyH45YOuxIgYJ1nyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJaBIMgH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAEF1F000E9;
	Wed, 27 May 2026 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779902426;
	bh=pJ7vDSjsYJJpfBtG5hCj9n+ejelcLCxD21pxOPHT8ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SJaBIMgHtVIhbsfKdSL3HuzJ4J8UyL0ADkRScSPK9chuKzyLZr4xw9iPw40ZUiyPp
	 2DP2DdspaI+8SSRzoFQUEnkvVeKx90vCtnZpeNweFBxQnT9ughUg3DdJVZpcCLznv/
	 mB431ah7kGuzZKI1Op3Wa3T6my8RJJNUswP7p4CEUwOpesCGL5WG8rJWIRT3bIEowk
	 zuQyuiyszvJtAQEkrD/tHM8ElSi8nuB8NoEWmrohNiMzFfu6mEzPcgrMNos30pQB3N
	 UqHjSwUt2nX2rHMAIEZbPA/C67iEKcETh0ZMJ+b0a3zpoL4u1oYV1MM4fzRqYDJPlo
	 LPkj8DBcZbNWQ==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neilb@ownmail.net>
Cc: Benjamin Coddington <bcodding@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] nfsd: fix possible fh_compose of wrong dentry in nfsd4_create_file()
Date: Wed, 27 May 2026 13:20:23 -0400
Message-ID: <177990236375.209507.4824520496797890812.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526053004.4014491-2-neilb@ownmail.net>
References: <20260526053004.4014491-2-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,ownmail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22025-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E69B55E84E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 26 May 2026 15:27:58 +1000, NeilBrown wrote:
> dentry_create() can hypothetically provide a different dentry than the
> one passed in.  This could happen, for example, if the exported
> filesystem is NFS, and the server return to OPEN a filehandle which
> matched a directory that was already in the dcache.  Clearly this would
> not be expected!
> 
> If this were to happen the dentry (child) that was already stored in
> resfhp could be freed and later dereferenced.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/2] nfsd: fix possible fh_compose of wrong dentry in nfsd4_create_file()
      commit: 2dfca2b82c375e2a534447331ecd7056cb139dce
[2/2] nfsd: ensure nfsd_file_to_acquire() does not use a non-opened file.
      (no commit info)

--
Chuck Lever <chuck.lever@oracle.com>

