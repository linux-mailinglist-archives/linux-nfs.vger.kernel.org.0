Return-Path: <linux-nfs+bounces-23213-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QdlcKTfyT2rFqwIAu9opvQ
	(envelope-from <linux-nfs+bounces-23213-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:10:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF9E734C82
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:10:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ilbC6kS4;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23213-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23213-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21013306B8DE
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 19:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A9643FD31;
	Thu,  9 Jul 2026 19:02:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DEA43F8A5
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2026 19:02:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623769; cv=none; b=OYfzI7tMQ6orpjGyvcdzBCfU9bB5UrqDw2IRfoguNnoycK52tv0FfEe57AgBNMMJ+pltCPpT275nPmuY82jByFcVX05+S0PM6CrbiKBP20gBtKaJZx7NT8KJ3IJQP4PSWbiDUgaL2URFJG9ZjtLky66MSJr7lKpLjlfybjxKOpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623769; c=relaxed/simple;
	bh=mGGzn3yxI1B8hWEKIAK7R6gWhLPBTn8rq41BPJyUD4M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q16AuHyRUvelOa6x42rDOI71kYntjmr8WN/7l1h+H3J8WzuU9IM2B86ef9fOsXR9J0hEpvd3z9Pnnk/I9ivcTZHzg6W7XgtfBzYko1r20wlzwJYhWhPuadEm9ZSA3eAJnj1b31n+VuecFBwYA8K75YBuKZwy54xDlkdZFBgJ5lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilbC6kS4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31BF1F00A3A;
	Thu,  9 Jul 2026 19:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783623766;
	bh=DiiCNeh1hmRq5RYEgzcaZ5qz1f1ONfdycUqRxQ3A2jc=;
	h=From:Subject:Date:To:Cc;
	b=ilbC6kS4K3B1XVP8hleKCmphF155V0bv87Wgc7SeW6CLsp3L3oCtQ/expiCzS8lZG
	 FVddB2IcGgqmx43bxsH6XiuEBR4zoUCuBlecEMJBf6+aTTUOv4/7l1rjsKvLyLi+NL
	 CAnP/+g9G/CNn+5/M3OrfZd/Wcb+Wl8zvreRIgBNrWDfIfZSeWV77bBzm/1A2WF8/t
	 p2AjvQTYdIdLPtKMNOs+D5QaV9hAYhz+DpRMFxhDzshlQPz8vAa/bc5m2419mpaCyD
	 SBiNtMJAblr3y4mcJ55rVdSzWAKYeG2S1C+PSVykJ347fgo0nD2NyrCNIUsjqNTBSM
	 Ts2eC5JVkiCvA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH pynfs 00/13] server41tests: add some tests for copy offload
Date: Thu, 09 Jul 2026 15:02:28 -0400
Message-Id: <20260709-copy-v1-0-849bf581d7cb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwNL3eT8gkrdlDRj46QkY8NUC4tkJaDSgqLUtMwKsDHRSgWVeWnFSrG
 1tQBbCldXXQAAAA==
X-Change-ID: 20260709-copy-df33bb31e88c
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1867; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=mGGzn3yxI1B8hWEKIAK7R6gWhLPBTn8rq41BPJyUD4M=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqT/BMPpW63a7mglPWI4AGUVpsy7Pb7S0utTt0D
 ilMdu9/qrmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCak/wTAAKCRAADmhBGVaC
 FSTED/4lzv4gIq8tztqMDvWXE1vX162/XUgEX+NW1KmWC6SrFJe4ejJ1PK+yckQiJ74vMbvEsVj
 Bn0h4OsOQESIiFbUyZa7s0UsxQxru6qp1MpwSjn71wSRYYAPhkP3GW9+Bfd0bEiU5QYxpRdeplC
 lQcDH8SVXoPbO3HAGbm4u85q4SX/V1Fqd+XrvGkBBsTb78IqpGMl/LXgVLtzfkp61sDooOxiwQM
 LZvGxYOkciu2QbDi2jNNeb+HD0VViwhdI3/nk3db3Dl9EK5ed7g9Ddl+rTZZX5TEMqOragD1dfo
 2ud3xNMSaDt4G+XWWNhQvgGkzoFwuf56Vac/Pghm2jylk4L4VjWeegG58pkBFpQT3EXsOCTmyY6
 0Iuj7DJvlXHT+O2YQPfyeB8+ypR3/pLXmuWnvhC8mHzeEIAULipK0eA3vYs7BBpo5pr/bkVFhoF
 ogXdU0H/3R0PMVOAyJRjUgeH3+jTMzWWI5Cd1ljDHM4uKCJRKiehP3XbiJ+Apt4/jpEH5NXA3Kw
 uDfg+Z+SGfaJPAgey/fkN+I34jrLuLhGpY6eIAwP9GLL0wu47cW5Z0LrlvyZRQk0CIycK6pEdQi
 sRKTYd+lBmB0eXXjoLyNlm7oEfRPTXZzbfBGRdePXvYWGZipKaJO0jWOg4ZndZU309dKQX9mh/l
 4jm3D53YnrypqHw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23213-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:calum.mackay@oracle.com,m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,claude.md:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FF9E734C82

This patchset adds a number of tests for copy offload. Most of them are
normal single-server testcases, but the last one adds a test of an
actual server-to-server copy from one server to another. This requires
a new command-line option for specifying the source server. When
omitted, the test is skipped.

This is based on top of my dir delegation pynfs tests, but I don't think
they touch much of the same code.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (13):
      server41tests: add helpers and basic synchronous COPY test
      server41tests: test COPY with non-zero offsets
      server41tests: test async COPY with OFFLOAD_STATUS polling
      server41tests: test OFFLOAD_STATUS persists after async copy completes
      server41tests: test OFFLOAD_CANCEL on async copy
      server41tests: test COPY with bad source stateid
      server41tests: test COPY with bad destination stateid
      server41tests: test OFFLOAD_STATUS with fabricated stateid
      server41tests: test COPY within same file
      nfs4.1: fix COPY_NOTIFY args union arm name in XDR
      server41tests: test COPY_NOTIFY
      server41tests: support a second server for inter-server copy
      server41tests: test inter-server COPY

 CLAUDE.md                                          | 100 +++++
 ...ts-add-a-test-for-rename-within-a-dir-wit.patch |  55 +++
 nfs4.1/server41tests/environment.py                | 127 ++++--
 nfs4.1/server41tests/st_copy.py                    | 488 ++++++++++++++++++++-
 nfs4.1/testserver.py                               |  14 +
 nfs4.1/xdrdef/nfs4.x                               |   2 +-
 6 files changed, 740 insertions(+), 46 deletions(-)
---
base-commit: 95d7055e00ab861fb16f750d244dacc57a30ca19
change-id: 20260709-copy-df33bb31e88c

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


