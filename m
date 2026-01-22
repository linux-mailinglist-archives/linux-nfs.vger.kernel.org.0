Return-Path: <linux-nfs+bounces-18337-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BLcNCGfcmm/ngAAu9opvQ
	(envelope-from <linux-nfs+bounces-18337-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 23:05:21 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC356E0AD
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 23:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A07F30053A2
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 22:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0593BE4B3;
	Thu, 22 Jan 2026 22:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyGS6Vds"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17AB30FF29;
	Thu, 22 Jan 2026 22:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119482; cv=none; b=HwZ2kSBEly7vAvoGZAzR98kadIwQTo0tdhvmo8HVZf4cbID+ZuBOVrcPZqRpbEIE7VP+t6cKmuPUIuJRelU9PsHSHiHcQKLwEU5aTfidVjcf/Y5jHO8fP2MaeA1osTePoJT/GfcUOp60PGZ+nQHOyF+H0dMiR1P6kHvVKSUB1gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119482; c=relaxed/simple;
	bh=gYV+1uXjBuVLLKT05D/6On0kOkZH/jo4MHQ+ujFmeSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXpBSvQuZSV/h6Tg//wepjDZcZuRBQlY0eYTDRGSXkkDEwyFzr6b8wCAhrv9nRTltMjDQGlVEbH9r1XGwYwxx+m6eI/ZTMG78EFkLdpt8LFAJCZwUK7+FYNxf0WJbiWC0LYTkHt/8Meis3Z4+LbMiwbt1ZZfuDLs23HDsEdPm+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyGS6Vds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B600C116C6;
	Thu, 22 Jan 2026 22:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769119481;
	bh=gYV+1uXjBuVLLKT05D/6On0kOkZH/jo4MHQ+ujFmeSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QyGS6VdsvAsVKPRScUfLRq0K55bUS+mJTyzhgJDw1Se4vYFwyWCi2zfsd/eCNmyHV
	 uvHkUkIQuqo2UcW8s5PsW7frKzgWkd5aNetoopYh5MfjkLKkYZHYOnl2zW1Tu7soeu
	 AoB8N+hP16aApLOlMYqOD8pP3V++XAMzPSUv/i+vLAHU16cUKxywqLmOjAVSCgfvCV
	 tdzQxkWLxdo3W8XLv/cK9q3DQaAd3X8Ki2ow8DnGvA7zAHJmDRcgK4MC138/5yZEg3
	 Z7qeprccjWTFMXaRyTIkHOdew8LM8vlPdaVfsQo0QYD+QyXDL4enlpWQJkRGegONG0
	 g52CoIYPJ262w==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] nfsd: move delegated timestamps to being runtime disabled instead of compile time
Date: Thu, 22 Jan 2026 17:04:37 -0500
Message-ID: <176911946777.1143362.852891163114456306.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122-delegts-v1-0-40fbb180556c@kernel.org>
References: <20260122-delegts-v1-0-40fbb180556c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18337-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: 5EC356E0AD
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>


On Thu, 22 Jan 2026 13:59:14 -0500, Jeff Layton wrote:
> The delegated timestamp code seems to be working well enough that want
> to just always enable it. There is a chance though that some clients or
> workloads could still see problems, so this also adds a debugfs switch
> to allow disabling them at runtime.
> 
> 

Applied, thanks!

[1/2] nfsd: add a runtime switch for disabling delegated timestamps
      (no commit info)
[2/2] nfsd: remove NFSD_V4_DELEG_TIMESTAMPS Kconfig option
      (no commit info)

Best regards,
-- 
Chuck Lever


