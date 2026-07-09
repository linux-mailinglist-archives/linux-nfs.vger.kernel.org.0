Return-Path: <linux-nfs+bounces-23202-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6eqJBbjvT2q+qgIAu9opvQ
	(envelope-from <linux-nfs+bounces-23202-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:00:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 091A7734AA4
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:00:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="m4MK0U/i";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23202-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23202-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D901430C6278
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 18:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7374499A3;
	Thu,  9 Jul 2026 18:47:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AE144999D;
	Thu,  9 Jul 2026 18:47:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622873; cv=none; b=O1L0WIhnbRX+mYMfRGtAEgO/7sVhPlfJ1dgbpbLR7P96fs7N1Rl+g3cnlRRBIk8xb5FFjeUB372b6UQ0f7lKKtR0X/PZN8giJ6zyci9a7EL25oGsRKY9sPaDB3W9UE9hGdeKvPPjT/6cyMwqBRsd+dzF2tetMPbxznHVVaRdVzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622873; c=relaxed/simple;
	bh=41pRsp9r0JGb8rDMYmMIEWYkYsL1N+fSd4PQvDWDU8Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RNVohyPsudoIFIiL6vpM4mlqiLYf4ypzMMzx19ciK4lwRkT4GP4Odx/cTwAtJe+1KBQCD0DZvLVjaQGt9vGqn944J9d33OXCDqgMfrmhIsvNnnRAaiJXX5Fz9sc6bqdoj1XBYaMTHFNLiyGI3aWJcOO8VPIs7LKyoQ19UrcmQUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4MK0U/i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F8F1F000E9;
	Thu,  9 Jul 2026 18:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783622871;
	bh=nIppYcLoUEXPgTkH2Jjr4r/B4v+Nd0U5ta3wkAs82Fo=;
	h=From:Subject:Date:To:Cc;
	b=m4MK0U/idWZaHoLnuK0CQOIQxdRF/kCFjlbcxkcTKaTTQo2pHL65gD3rBoH+WmU5Z
	 MMSe6NqWIUCXnjE7fHvwRV9loiq7WGgGbng+Jn6DTKe9nftRNjT2+uN+1uYPCZwqd3
	 3m5oIGFwUWEqAAvy2OCwe0gijSDUgaon6u1uLilKHq/aqfcuU5+OV19uYT70jYlIcj
	 mywKpoVTb4chPqR5WGtH1gOyMnRB5I5HZxfpZz0ieF3iYneBtcT+gzyeWUNWjoVRFd
	 vse1fsDEKko1hJtvx6eVmgVDZlB4h879rvAvkyxwpWC7u8e4mNquBOWbIt6a1pO/3U
	 qJYt73TJjA2sw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 00/10] nfsd: copy offload fixes
Date: Thu, 09 Jul 2026 14:47:37 -0400
Message-Id: <20260709-nfsd-testing-v2-0-0a1ba233bf87@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMQQrCMBCF4auUWRtJJmmorryHdGHtJB2UVCalK
 CV3N3bv8n/wvg0yCVOGc7OB0MqZ51QDDw3cp1uKpHisDajRa49OpZBHtVBeOEXVOXsK2nhrDUK
 9vIQCv3fu2teeOC+zfHZ9Nb/1D7QapdXQda2lAZFce3mQJHoeZ4nQl1K+xwPtA6kAAAA=
X-Change-ID: 20260624-nfsd-testing-8439f0163312
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Andy Adamson <andros@netapp.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2304; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=41pRsp9r0JGb8rDMYmMIEWYkYsL1N+fSd4PQvDWDU8Y=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqT+zPedTim6BzVNLQw+b86QHyQR58inqsFejUY
 LIcsh6dbhqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCak/szwAKCRAADmhBGVaC
 FZjJD/wPyC2xe0IIN11q41Ye/c8XhKF9p0wMwhYtBmfvfYR+3c8jJ0YtOr6NA7nf7l4wG7AMycH
 zgLfleCt2VzLz97IdK+/fPPFD+Qgwcz/O+4xB9hO5l/a4rDSIwAv30wwLeOGdrlEBtdEA868xHc
 xCOU37Qc6ZR6uKOe1j4dD3UKqLcnALpo0wchOgl91e/lTCvzF5dqkitsUnJ737qT6BYamcA+fAU
 xeChHw5RanGuWKvQCd7qvYWsqdssKQYXi4lgYIHMaYqhv6zSpZbVkhB1E9aN02qxx5bN6WXIL7Z
 n/tLxBtKrAu+G40l/ThAikvxHthoiHaGzoG2t84bG0dbzsrh8zFe4RcRtvswlm2e6iaxr9Leg5a
 NIIxN3fvOAOmtUGNc4EcA9zcV72bvGANdGU2LFM3FZK2J/2IFi8UG3VoXwzAlOVXBNlx1uruENi
 mBfve5TiWrGR6kDdUIwsc4LprtVAy5T8r7Qqt04bbRtZEkvNyDOEVQpc549QYki76bXH0KgJCPd
 LMEzUbvkcintxYEOaRSowIpUCfURtI9FZAuyrwmjZtnJ/3seMuj7L2E8XZjQ7gOYxxhxv57pKs/
 F6B/felfFTMYTiEZx9ygIbYS5nR77WaRT1yWdCjmOypG3bJmryy0o9CxewQoFRGTXHUpOWqSDti
 cP9h4L0hQAB1MpQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23202-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:andros@netapp.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 091A7734AA4

These patches fix bugs in inter-server copy offload code noticed by LLM
inspection. The first 3 were found via kres, and the next 5 were
problems that were flagged in agentic review of those patches and some
via testing.

The last 3 patches attempt to rework the code to be less problematic in
the future. It breaks up the nfsd4_copy object into two separate objects
with well-defined lifetimes, and then integrates the COPY stateids into
the normal nfs4_stid model. The idea is to bring clarity to the copy
object lifetimes that was the underlying cause of most of these bugs.

As part of this work, I've had Claude cook up a set of pynfs tests for
COPY that I'll post separately.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- Add new patches to fix neighboring bugs found via testing and LLM review
- Fix error return when given NL_NAME or NL_URL netlocs
- Split nfsd4_copy into transient and durable async copy objects
- Rework COPY stateids to use normal stateid infrastructure
- Link to v1: https://lore.kernel.org/r/20260624-nfsd-testing-v1-0-b8853eb22e45@kernel.org

---
Chris Mason (1):
      nfsd: fix cpntf publish race in nfs4_init_cp_state

Jeff Layton (9):
      nfsd: fix UAF in async copy cancel and shutdown
      nfsd: fix stale s2s_cp_stateids IDR entry for async COPY
      nfsd: initialize copy-notify stateid before publishing it
      nfsd: check client ownership when cancelling a copy-notify stateid
      nfsd: revoke copy-notify stateids before dropping their reference
      nfsd: return NFS4ERR_NOTSUPP for unsupported netloc4 types
      nfsd: split nfsd4_copy into transient and durable async copy objects
      nfsd: make the copy offload stateid a first-class nfs4_stid
      nfsd: drop dead COPY-vs-COPYNOTIFY type handling from s2s stateid IDR

 fs/nfsd/nfs4proc.c  | 311 ++++++++++++++++++++++++++++++++++------------------
 fs/nfsd/nfs4state.c | 224 +++++++++++++++++++++++++++++--------
 fs/nfsd/nfs4xdr.c   |  15 +++
 fs/nfsd/state.h     |   6 +-
 fs/nfsd/xdr4.h      |  33 ++++--
 5 files changed, 429 insertions(+), 160 deletions(-)
---
base-commit: bc7d6a41a6282da7c175c1638bdfef69c10f78d5
change-id: 20260624-nfsd-testing-8439f0163312

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


