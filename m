Return-Path: <linux-nfs+bounces-19816-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFwGCmLRqWmYFgEAu9opvQ
	(envelope-from <linux-nfs+bounces-19816-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 19:54:26 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF0A217273
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 19:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F28EE302EEB0
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2026 18:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5167B2DC334;
	Thu,  5 Mar 2026 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emUF4QBL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDC62D7DD3;
	Thu,  5 Mar 2026 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772736794; cv=none; b=uADl8qDjUinchpiXc3142RKpEgzb8wrxYwAn8BXRkAKc470RnF7Ng1sOmUJ+TZ4dZvT2xiWYc6uKPEVwcYQHytvxCkjsywJ9xsab+Bp9cfUlx8LImrpnOtjlTRcZowxl4hGTGudvjbX6wKmKtI2YFQ55mL0Akd+N/l2/IuI+HcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772736794; c=relaxed/simple;
	bh=8llgFzqH+0lujClTg+GW8zEBwQeD1b8ZHgQb7pUst8M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tUHfUolAZ1pKyKLKb5c1g2hBHdd0PU5VaRlruSeiqda795gwsS+F1XDvKagqxxDAnBxOSlFlOtSwXtwOn4zbEJ0yBdTH/Cx5VxiK+RQQQOuGKvcb7m+VF2y76wfX3HXUUP+ASCZ9cRtcxO3JNT8bmElzPCgxvxRLoNwCMR/jjMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emUF4QBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACEAC116C6;
	Thu,  5 Mar 2026 18:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772736793;
	bh=8llgFzqH+0lujClTg+GW8zEBwQeD1b8ZHgQb7pUst8M=;
	h=From:Subject:Date:To:Cc:From;
	b=emUF4QBL4cPr89sZdsM3I5oRpR6IrAOf5BpfKt40btZ2UbeB2DuGlQNn2EuLNHR0F
	 6nkoR+sWaPR7uwmcMR5Mqk/WLrrrxePN8pP843eUxM4JFL2mo/0FkjW7ibQLyPf1fU
	 lsiAv+SsF3aLEhRM6crn5aGL9rn/AeVXAc1HqvvZ1YELTGtBxLNIGT0iRYPcJYY3Wl
	 P3OH3fJPX9QBBpmpgG1+lGuvPRSWQtSn3P1LnsDnW1vqOrcK3A0bwFowWHhPL6qtk0
	 7qf1y4dF1eN4HlspaBpW4DDDH3920hXHKH0yMf48Go2xUAfvvF1irdldhhFw4KkDDb
	 YnNw6+ircR3Mg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] nfs: delegated attribute fixes
Date: Thu, 05 Mar 2026 13:53:02 -0500
Message-Id: <20260305-nfs-7-1-v1-0-e2200f69e543@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwNT3by0Yl1zXUNdyzRzw6TklFRTi2RTJaDqgqLUtMwKsEnRsbW1AOw
 d3+pZAAAA
X-Change-ID: 20260305-nfs-7-1-9f71bcde58c5
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=703; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=8llgFzqH+0lujClTg+GW8zEBwQeD1b8ZHgQb7pUst8M=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpqdEUw1SnQU91ZgEYWUZixHtgxOOtO/y3NvEe6
 iM9B+hMsMWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaanRFAAKCRAADmhBGVaC
 FZE0EAC5MKPKdo4HzpKVmQXw+Og5sV5BIpkB3zhcx77iKUKcXqsedgzdno8gdv3giKEDGlRdhR7
 /x9uQ14qhNzhsdqph9hdOaW75Rm2PFiQ68FDrr6oYIgPkJT3W9LmAsVUmZWJge7FKWobdKP62gG
 Z79PXLmZXodkvNKwW4IW4W65exRx63aTo4ExkOjJnVgRWurSwsy04xTtqsNSiLjqvOlaYjgUMih
 GiFd0n39PC8o9jaPjRa3UhtuuFocFq32192d/Y8Hc/jPSpHom3lEyYYeVt+f/1x2Q9Z4l5NlI5u
 Bmk3ql8AEHvGw9oRRVSnP8rKrwn4U0ePHHY3Z4AmLnkLtYkmvcAxZuxcKfNDqZ7Az10prRnpPMe
 9DvEmF1Z8OAHNwIt/noV5nedXvW/6WjmLR6b614i3hEvaKGL61Ad7t7cq+pDb6ixoFKr6KRPlb/
 YZkrcAqyMHaRIz9sadIL/6UMNQiJhqQ6NDueuk64QZy4QGqLsQNHEKeRHcm5fiHFJKBoFwW4Qe8
 j7oaTuW2Lljb5LVSYySEpBXjyBqo2JKkPvDRMuRGpSkq7VgzSuWiSklmn/ezDGNBch9N7W6b6yc
 C1+s7yGjA1XITuohCKtM82gDWsWeKo2Y83wMRucB0GCik8YLhEynoaHVHl57Uv5kz59SyAefM0C
 Y+XPRA9/Wdi7/Uw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: BCF0A217273
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19816-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This patchset fixes a couple of test failures in xfstests when delegated
timestamps are enabled. Please consider for v7.1!

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      nfs: fix utimensat() for atime with delegated timestamps
      nfs: update inode ctime after removexattr operation

 fs/nfs/inode.c          |  9 +--------
 fs/nfs/nfs42proc.c      | 18 ++++++++++++++++--
 fs/nfs/nfs42xdr.c       | 10 ++++++++--
 include/linux/nfs_xdr.h |  3 +++
 4 files changed, 28 insertions(+), 12 deletions(-)
---
base-commit: c107785c7e8dbabd1c18301a1c362544b5786282
change-id: 20260305-nfs-7-1-9f71bcde58c5

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


