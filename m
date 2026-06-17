Return-Path: <linux-nfs+bounces-22661-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xk6EKKnjMmrR6gUAu9opvQ
	(envelope-from <linux-nfs+bounces-22661-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 20:12:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DDF69BE3C
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 20:12:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="JuEJ/B0Z";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22661-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22661-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CE1C3041485
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 18:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA909377EC6;
	Wed, 17 Jun 2026 18:12:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F5C375F65;
	Wed, 17 Jun 2026 18:12:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719974; cv=none; b=Mwl41UCYF6bXtFi9jyV95WRtHOFG1CnZvuTLcfyz3RQQF1JPYzhaUctwNLlpoDlQ+GCtlGfVVKpl3Xkb6cXubyx/WNC+srAy3fQE0c5VTHHo3XMtz6ZBqOgMY1ykRdwTP/8GQEpdly75b6qMGtmw43i+FcdEpn46bDuXvaunFsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719974; c=relaxed/simple;
	bh=eotsXxAn3IXBBK2ZAaDCPtbefY47+PdPNkBjkwT3ZQ8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZM+XdUvoGwyrpQYcc9M9cuhDPkxCnuFjqa/56O4kChRM4RJvViIHH+moh+XaR8NVUue2j1ELsfy4E+YyJPm8JFtOnd9YzPsVTZ61VQTUyHt6CA3zHkB8Za3hSBD7U39KhWqSF07sPt3XuAjLMWHR0j+pZL1SU/stNPihDWiHa70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuEJ/B0Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4A41F000E9;
	Wed, 17 Jun 2026 18:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781719973;
	bh=y+duh9hZAmbOe6Df9SQbP2amENFZfCRANiWuLolB8sI=;
	h=From:Subject:Date:To:Cc;
	b=JuEJ/B0ZUvvgI8OY83b2MBCsaN6z0/Fo3I6FGD1cb212V0I09maATUBmMjcJklOSB
	 Q/85R1S4qG5YV9sf0EYqkZHzybP2XtA+egD0Fji5/u9Rr9UYeVrOSZR2Z5+wQmG0jL
	 wvsC8fnRy7AOZoR70TJTWzaSyFxfDT0/rcUGnD9b/BD794uo8qv3tiVze+9mUB9KHy
	 wBepmjbccgopyaQ49NCsOcTnd8jsW5GV7eWrXZWJvaK2FI1wDCuSE3Cxc80exUdho2
	 pruEF8SuWtLas4Y2PjwTzV6oCWBFm18Xxd9XINUWrxYDgqL5cUKBpwPzUOLRRyAbI8
	 Y9Yu34yweoPZg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/3] nfsd: follow-on fixes for CB_NOTIFY support
Date: Wed, 17 Jun 2026 14:12:28 -0400
Message-Id: <20260617-dir-deleg-fixes-v1-0-32b85b366c29@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3L0QpAMBSH8VfRuXZqxIxXkQu2vzkltJXU8u6Wy
 19fX6KIIIg0FIkCbolyHhlVWZDd5sODxWVTrWqtdNWxk8AOOzyv8iAy7GxNo/p2MQ3l6wr4Q57
 G6X0/7184h2EAAAA=
X-Change-ID: 20260617-dir-deleg-fixes-ecac84095b84
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=880; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=eotsXxAn3IXBBK2ZAaDCPtbefY47+PdPNkBjkwT3ZQ8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMuOcrMCD5w7cFZRmzXwwMuJDbvJdDclObpSL1
 XsjIwXEuvuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajLjnAAKCRAADmhBGVaC
 FdLND/98xZO4MTN0ERNfiLvYSLw4vshd6BMOSstqBMjFslsMJ4pml0bdYTm1vs+ABjf6EucEcL9
 VwK5uQtgM1A/16PWTcgwMzoCOTNYM/5orw/v4RBH5yHVOWAvqgmTR9+tersHX59UWhxim7C5lLd
 +RHqlOx3jlWSv7jstXKcgivpAaWBOC/XnvO+E5K6l/F5wd+6hW6Kje06k0ruVZj+dbUGLLACcAu
 OrJVXy03eX+irdmv/2XqteOJZZUzxDXYuEFg3pg9XDVfWk9vfzdVQLl5CUfCekjkWIxOAKamRyZ
 e7Zj01upQ5VCvhNhb/CP7a9A2zAqg+I0EmymzA5r6FTvJE8sNuDpju+3/cfUGEmlL8qCniBj3do
 d92hi4r5tucRqIgYj0s3GO/xKzDhQlGH7dWg7MmhxdZo0yaAiBmeYLfwzCUyYbKYiPXLMxJKCRv
 Hrxan4Sev3wIYmKzRwiSx3nPeRnzWkE3Q63leZa/QDQcqjEClE2VCoxeYwCcZ7CUjPdoV5qns5O
 DxYjTfC9BubFAvzwaaAnyL/wPwrn7pkKNju7/B52s/X7Jg4LmrRinXmrIA2brvT0JPMjCNP945c
 Sw0flEGgNnjfVKg0TM4JmaHa1mVcQhow3Prz5rp1GP7RENbwHxO+M1AhsHYcgzhmgzcZszqnH0k
 OYlqzfkK3pvwVJA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22661-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9DDF69BE3C

These are just some problems that Sashiko pointed out in review that
seem to be valid concerns. The Fixes: tags have commit IDs from my tree
that you probably don't have, but they should indicate which patches
these need to be folded into.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (3):
      nfsd: fix CB_NOTIFY workqueue loop when queue overflows
      nfsd: fix NULL deref / UAF of sc_export in setup_notify_fhandle
      nfsd: recall deleg if a requested dir attr change can't be encoded

 fs/nfsd/nfs4state.c | 63 ++++++++++++++++++++++++++++++++++-------------------
 fs/nfsd/nfs4xdr.c   | 29 +++++++++++++++++++-----
 2 files changed, 64 insertions(+), 28 deletions(-)
---
base-commit: fd0d6dde2a57d47d976c936586f0be24669471ec
change-id: 20260617-dir-deleg-fixes-ecac84095b84

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


