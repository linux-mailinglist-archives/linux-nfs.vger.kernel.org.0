Return-Path: <linux-nfs+bounces-22290-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rOdNHWvgIWpmQAEAu9opvQ
	(envelope-from <linux-nfs+bounces-22290-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 22:30:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 031A264359A
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 22:30:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Km0TEyby;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22290-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22290-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28AA630E52B9
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 20:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F8630F54B;
	Thu,  4 Jun 2026 20:24:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D54C9566
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jun 2026 20:24:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604647; cv=none; b=BcoX6tawRIeYM6vZhRQTHHzMQcoLXX2dAHmgzDOwTvRieaxo6pLs/9FdXYBIW1r4sq+GafIdl1/H5Pfr/8a5dXxiywzEBtABfnfRwCB6DOEuEghPKawjj/gekA9l6yDzz13vgdSPlQrVMAurSMjHKR0EmRgD7u8DaBHSo7/yXTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604647; c=relaxed/simple;
	bh=6as2mR1uyRlxfL7w2kAmCeiTzCnH6OunbeyaC3ok5kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C0arMIgiNl+lMu3iblvFoLVJtxNZeg2SpkYCKozCjxbtcRNEbr9YrgqeQTVDleeux6HZ99rR/f+CBbTuYFPra8vT0HrOAbGIYO8aG0BFW5L4l3VXT+aDqwf9iIberwALlmRV+lw8lTwYwFyIzVIEPKLP8dFo7GNVq3ukxl4iYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Km0TEyby; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0408A1F00893;
	Thu,  4 Jun 2026 20:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604645;
	bh=6Ln41w3VsViuanLSn3qI4d5vuuGcX8TtAOuyiMxrCmQ=;
	h=From:To:Cc:Subject:Date;
	b=Km0TEybyHXER3fBu5qo6zPZ3lYB8rRQmIwUvCwyeHVGxnaH1uzm7YtwiOT4k9ZzK/
	 vkZ9tx9E9gBcfUAujg3cdOPvSSLmOMoMyWY8QTEqLnOHitMXcY3FCriCKhQziEO1E2
	 SCf48CO/sSqzuLmzvP+GgPg6NE+2V7mi1WLTemtJwIIYt9yexP+E+2K9Xak15kAzui
	 2I4XPVZRKdJELfo++zDfSdLM+KxoLF24gy0F58n/yMgSDsFSSCJNvkFH/mxZQXgx/u
	 /Ks71B21K+gyuuzFD6MGPYlKoKxfyUCRGvrKQgeNs45HjITFCYW/NvMgMDdezyDBV4
	 CYQF7ecjcv/5w==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] NFSv4/flexfiles: fix unwanted in-band IO fallback from DS to MDS
Date: Thu,  4 Jun 2026 16:24:01 -0400
Message-ID: <20260604202403.20856-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22290-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 031A264359A

If FF_FLAGS_NO_IO_THRU_MDS flag is set then NFSv4 flexfiles should
never fallback to trying to issue IO directly to the MDS.

These patches fix 2 locations where FF_FLAGS_NO_IO_THRU_MDS should
inform the flexfiles client's behavior but it isn't considered.

A Hammerspace test that caused the time between layout return and get
to be much longer widened exposure for unwanted in-band IO to be
issued by flexfiles. The test allowed for these fixes to be developed
and the test now passes.

All review appreciated.

Thanks,
Mike

Mike Snitzer (2):
  NFSv4/flexfiles: honor FF_FLAGS_NO_IO_THRU_MDS on fatal DS connect errors
  NFSv4/flexfiles: honor FF_FLAGS_NO_IO_THRU_MDS in pg_get_mirror_count_write

 fs/nfs/flexfilelayout/flexfilelayout.c | 29 ++++++++++++++++++++++++++
 fs/nfs/flexfilelayout/flexfilelayout.h | 16 ++++++++++++++
 2 files changed, 45 insertions(+)

-- 
2.44.0


