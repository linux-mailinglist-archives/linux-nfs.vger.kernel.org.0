Return-Path: <linux-nfs+bounces-21155-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAg/CrPr7mms0gAAu9opvQ
	(envelope-from <linux-nfs+bounces-21155-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:53:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B1246D199
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADF913006B6A
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 04:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D092E2850;
	Mon, 27 Apr 2026 04:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="gSEr4ON8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B428287E;
	Mon, 27 Apr 2026 04:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777265572; cv=none; b=PGZkwSBGj4dQoTcSRWHKX/yc5JHFj6zKya7vTR93mbh2Yo1GcaGT4qzinoJZriqpvH2zwuuAsvbHeSGU5i+14QDbxBSt22rystk7ODvkodNZAI9p5pcUQO0IK0zEOi59VvXDGu1oDoTWk0FMAjg7wNJgZf8dLw3DTUwNkfli9cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777265572; c=relaxed/simple;
	bh=2E/gt99rDneHqZlnyr5iOm1KQLLuTNRA8XbBfN1A8wQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=I3UwlDmEMvpxPN64Eo6t8LOJz01NL8foiT2Lwc7L2EfOJuqWaiVSgzMNDubosVKnaZOEeuXNXtLOF7pMNLvOOkJYxLtTd21ZztTDseiPUlJVELADA+VMWVorVKBdpzGl3hEZp1yfWVw8WptvickdbxZXG+6WSG9ndsoCt2dMPlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=gSEr4ON8; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1777265561;
	bh=uhqX77ULMkFhfbXHWiyYYnT7BbfYIN8BHXvhFkkoPSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gSEr4ON8h5GXos7MGbOqHXeslJJmiLyvJaZQZlVVO1Ho5EF4FO+6LtvQbP677LosG
	 GFVTp3WpxKusEuPWQob03gMcu4FnTgfuxy0wUuYvLe0/N9dWXCm2+Jtv+B8h8PkEU4
	 sAi/efhaNUXXxOosnb6WpSeg2v8LScuf4d/e/Lx0=
Received: from ubuntu2404.. ([103.244.59.3])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id D2698AD1; Mon, 27 Apr 2026 12:52:38 +0800
X-QQ-mid: xmsmtpt1777265558tpn10y6ba
Message-ID: <tencent_C198D1548F26ACCF529CC312888839694E05@qq.com>
X-QQ-XMAILINFO: NwU6Bou9okj/r5MsqRS+QprO5G7GcgvjQtJtkGcweuwe0jtgN7ShR/kOvSVG0p
	 jMc6hQ/xbRfJSazNkJ5EIv+UUMBXIa3M7RxbXvjX2W1mRVxTGQ/kd1nLTKVs7FsmhwBYOzcc9YQi
	 mbhLEjOH5k5kJn4/lhhCoIirUzWOdiM+ZsjMSwj8otZN9ZMoEungtEnl/VKDZyW0ljiQsnVnh7vi
	 ZA6JXKASNEz+OMTkXhW1i7kq0apvcjzBZ7DoNH5hX8y5VIivo2Z/jC8R3tlrWZvCpMkeSvkiKbvn
	 Dv77kfPWwFEZ2gIHjs09gSFjGC4gL03Jh71FlF4uJPg46saD0CddsQ7M3Dxyc8/PAXEHzodSSF5V
	 2dZ5N4VT2Xv208exEdF7ni0NfcrgM/CaPOKMix3Xjjextu3nwF+e6fE/RLImNW3s2vF12cUEp20K
	 Pp9zIZj8+GWDp9Wvj/P9cnwmZ5QVJoqVtmxyOdSX3AcHY/veOL37TbU6wT3QvJk6wnElB4qL4x/3
	 dmG4XIuFDcOMEvjDDxvp4YiQts7gOs9/oW0i4pHWLCrv2DmUkPXJ/rx1Zq5cksgsT5NgNPbB6GOd
	 0MxjTU+kEUX3d/A8BAvXX1O2pmQy8/9cJAfNZ5We6Pn6NXanxipHLtN3cxZW9iAoJCeOebUh0+J0
	 yEBjDVdSGEFAKCyZcdur0uvd/HooFZjhJPDoIvN9zHwQrPt9fZFSIdBwUFOoteW92ggH+aYNRQ9B
	 WZYOSiwopucc/LLZEGA1aTTib7dT4C4ztJHtsEhanDD+dsQNocQ5AouqTID/vSNivmbhoDpiwvx1
	 CMxOHLGieN2qtIJFfpq8fdqehtgplX7f9xU8wMOq7YyPUop+Wc1hHJfj1NGZkPfx+xq0bjWuWMb8
	 fj7iqibf3yjEqgDhmeBqX0Xb5/PMMAl3Q9j/+5J2NYjmcn+VvTriuuPq1I1j6CSRup+nywdzkZlc
	 3pXRHbjtRTzPxem0Om8vRXKWpBLEDr7g6iYVogEOSK9VF3DCfN11d9TzRObrnkaRUoH0yDFcI6Iu
	 ArmJE+8+8hRCln9Jvc
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Lei Yin <cybeyond@foxmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yinlei2@lenovo.com
Subject: Question about "Not Applicable" status for [PATCH v2] NFSv4.1/pNFS: fix LAYOUTCOMMIT retry loop on OLD_STATEID
Date: Mon, 27 Apr 2026 04:52:35 +0000
X-OQ-MSGID: <20260427045235.32524-1-cybeyond@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_BF5118C8B480E6BFEF401CC2B287682FC905@qq.com>
References: <tencent_BF5118C8B480E6BFEF401CC2B287682FC905@qq.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 31B1246D199
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21155-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cybeyond@foxmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi,

Sorry for the confusion in the previous submissions. Due to an editing
mistake, the first two versions of this patch were not sent as one
proper series.

My patch "[PATCH v2] NFSv4.1/pNFS: fix LAYOUTCOMMIT retry loop on
OLD_STATEID" was marked as Not Applicable. I would like to ask for
clarification on the reason.

This patch is intended to handle the case where LAYOUTCOMMIT gets
NFS4ERR_OLD_STATEID in nfs4_layoutcommit_done(). The change refreshes
data->args.stateid via nfs4_layout_refresh_old_stateid(), updates the
layout stateid in the inode layout header when appropriate, and restarts
the RPC only after the refresh succeeds.

The purpose is to avoid retrying LAYOUTCOMMIT indefinitely with the same
stale stateid after OLD_STATEID.

The issue was reproduced on NFSv4.2. The most reliable way I found to
reproduce it is:

1. Run a workload with relatively high concurrent I/O on the client.
2. Kill the client-side I/O process with kill -9 while those I/Os are still
  in flight.
3. In that situation, there is roughly a 50% chance that a subsequent
   LAYOUTCOMMIT is sent with an old stateid.
4. Since LAYOUTCOMMIT does not handle NFS4ERR_OLD_STATEID in this path, the
  same stale stateid may continue to be retried.
5. This can lead to an infinite retry loop, and the affected file then
   appears to become unresponsive.

Using kill without -9 makes this problem much harder to reproduce.
However, even without kill -9, the same issue can still occasionally be
observed under sufficient concurrency and stress testing.

So my understanding of the bug is:

- kill -9 makes the stale stateid window much easier to hit;
- ordinary concurrency/stress testing can still trigger it occasionally;
- because LAYOUTCOMMIT does not recover from OLD_STATEID here, the RPC
  can loop indefinitely with the stale stateid;
- once this happens, operations on the corresponding file may stop
  making progress.

Could you please let me know whether the Not Applicable status means:

1. an equivalent fix is already present in the target tree,
2. the patch was sent against the wrong tree or branch, or
3. there is some issue with the problem analysis or the proposed fix?

If needed, I can resend the patch against the appropriate branch or adjust
the description accordingly.

Thanks,
Lei Yin


