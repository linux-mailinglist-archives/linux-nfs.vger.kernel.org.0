Return-Path: <linux-nfs+bounces-19138-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GsWDLKLnGl8JQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19138-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 18:17:38 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C983D17A92B
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 18:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70DB7316CEF7
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 17:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414E2327C09;
	Mon, 23 Feb 2026 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBt7ncO4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02505329E56;
	Mon, 23 Feb 2026 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866618; cv=none; b=Yl7Yt+9yt/Vwr88aZj+clnjCTKBcyfd0fqTuS+tGrc9W6h+d8hb/r2Jq9TgNU054mUZvMC8fEYXvAlIzBnLeTXyJoY5SE2EmfkNTpeLWLiM3DmwHs5Wkyxi0PmjCHq8PRlgA5EFWWXLMUmscj6E+Z1kFs98TPNqbjEoDmGa/GSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866618; c=relaxed/simple;
	bh=+3hPFAempSsx15KzcGGSFWNynFsWTG7kcMUzs7TivxQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MZ0vGRFo+AswA1sm3rK4d8ifDCSTEuHQ3ufs8xIsqa2clMQ9sqm7+KYsTs3WUwHN8dMHf7+/WckN7xkgJAsW48XgurR/uX2pMH2MvIHqHMKTRP8VWiX8/NXRtsr/Qyk81S2DFsuFydkDdA+qx3vpwwUGhLOo2dlHl8uyRqBDzVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBt7ncO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C68C19423;
	Mon, 23 Feb 2026 17:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771866617;
	bh=+3hPFAempSsx15KzcGGSFWNynFsWTG7kcMUzs7TivxQ=;
	h=From:Subject:Date:To:Cc:From;
	b=MBt7ncO4LRTbdyENK1/RUFLtiAzDqWUSAMen9WpCoEDB8tfubqlFuZr0LGScgTJfo
	 ksiFzQaqoOq54lQ5sr4Tnj/knc1lvhcmOm1K7/ylfmID2rDN08Uj/KpdIdwgNXGEtz
	 lufHq0pYtw70OjnoMHyQ35vbqOeiP9za/b3K2sscmvgOIumXai+LPJlO9OtdH0m03b
	 YmKggaXBZdc2N5/7EsVhclo5mO5vsEwxbiyEfymxWv+16qmHufBaS6V4ZM4904xyBk
	 Kwdx5wwFi+w4o5A/dMgZYy8dZQDUuaLGj5xBu2PHveGyKNcnxVn/Tb4Dxuc36YabfQ
	 VLhpegs53zUBQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/4] sunrpc: cache infrastructure scalability
 improvements
Date: Mon, 23 Feb 2026 12:09:57 -0500
Message-Id: <20260223-sunrpc-cache-v2-0-91fc827c4d33@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMQQrCMBCF4auUWTuSpKOCK+8hXZRk2gQlKZMal
 JK7G7t3+T943waZJXCGa7eBcAk5pNjCHDqwfowzY3CtwShzVsYozK8oi0U7Ws84MVlHRLp3PbT
 LIjyF987dh9Y+5DXJZ9eL/q1/oKJRIV2cIqXJGjrdHiyRn8ckMwy11i98Ly4zqQAAAA==
X-Change-ID: 20260220-sunrpc-cache-fe4cd44413d3
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@ownmail.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+3hPFAempSsx15KzcGGSFWNynFsWTG7kcMUzs7TivxQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpnInxUSOosFLGglvxcLG5ngUmE3XdlMwermcIZ
 8R7bjjNNvOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaZyJ8QAKCRAADmhBGVaC
 FYlcD/9jGq9wy6KzdffEFQPt05K5UlgIqqaFylaCzfUlBUKiIIx/RwNu0Q8X+2T569rDzbgmWuw
 zEliPAYp8M6W9DV4Zov1doEXHJhHCEYYUKTQf6KWdmwaMsTXy7NRLIJk+Z0mzgHxXrWmoNrQavy
 aKCwXKn6jUbaulgkWOmq/JdYVImn0+BCkoaVTLOKUHqYxKImFyzqFQ0noT/73JGfRjymbVYMn/t
 rNwU6lgbhioQwkNe6VebmLz8/xPMnv+9D52fQf4RA3fktGgHMf6bv7MeQCz4CyhqSNz52NFm0B5
 aHf4Efy3fKFc8ZUlnhyZIFHlo6Tlst3ZrZkjdETXhrFepLkJB4Ifm9Tm80MUG19ClWucG0520eC
 exrHY/jBu3MC6zNdzmEcfasIEnwrYOIXlzeGDpQ1Zp1wbKBVL1zVAsghl+5ocxgI5vmAt7Xg2IX
 IR2uSMBgZIf8R8QR+QVX0ibnr33jTBWYeq0kCiNlrXnagmzuB7qVaRzKJJWzwXanVaGFDuJXxnf
 pW+0Hpn9IM2wNsjVvEkKXwXqxAKRBme+rbhVgy/9fX70nN/kpl4FTE+gTd+DS2t8dlaafou9MwK
 D+xB5xe+5ID7aGWrqI78ZMYxcqIQiVphozN7a5+yDO9oDENVE+U1KJErd4+T0YSh5SYHpJuhGnR
 91eCuqJ7yR61I/Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,ownmail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19138-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C983D17A92B
X-Rspamd-Action: no action

The first patch fixes a pre-existing bug that Neil spotted during the
review of v1. The next two patches convert the global spinlock and
waitqueue to be per-cache_detail instead.

The last patch splits up the cache_detail->queue into two lists: one to
hold cache_readers and one for cache_requests. This simplifies the code,
and the new sequence number that helps the readers track position may
help with implementing netlink upcalls.

Please consider these for v7.1.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- Don't spinlock around rp->next_seqno updates
- Fix potential cache_request leak in cache_release()
- Link to v1: https://lore.kernel.org/r/20260220-sunrpc-cache-v1-0-47d04014c245@kernel.org

---
Jeff Layton (4):
      sunrpc: fix cache_request leak in cache_release
      sunrpc: convert queue_lock from global spinlock to per-cache-detail lock
      sunrpc: convert queue_wait from global to per-cache-detail waitqueue
      sunrpc: split cache_detail queue into request and reader lists

 include/linux/sunrpc/cache.h |   7 +-
 net/sunrpc/cache.c           | 189 ++++++++++++++++++++-----------------------
 2 files changed, 95 insertions(+), 101 deletions(-)
---
base-commit: 8fd7d969255c89fb28cd9f34e0d729150da79d68
change-id: 20260220-sunrpc-cache-fe4cd44413d3

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


