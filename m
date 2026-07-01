Return-Path: <linux-nfs+bounces-22925-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VXiWLjymRWrbDQsAu9opvQ
	(envelope-from <linux-nfs+bounces-22925-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 01:43:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 453566F26E6
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 01:43:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hKfOaJhL;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22925-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22925-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95C7B30098A2
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2026 23:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EA2239085;
	Wed,  1 Jul 2026 23:43:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9EE3C4B9A;
	Wed,  1 Jul 2026 23:43:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782949433; cv=none; b=BDuSF3OCvGKc5lLJJbkk0aXvRaMEUJiI48nfkuuhR5fCEuxoY6GkaZKvCJmK0uGZcVZI2BXsY4kVjx7fNvB7R9FJRTi7zNRCqVFAzgR6oxA2mnrPVMy7+HaGzQPMhga+KsNLuhJutkYibPA7w5c3zzQvW1ZV2ad4INFQAJLX/mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782949433; c=relaxed/simple;
	bh=gl9u03GzmoniZ7OZSeYovtoitz4mD9tqYPciBS7Ic2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zg+7O0kC5lrgYiVGtH3XjliLIM4EwbwnSsLWgOd2KoTJqwqmYHhDy9K5nYtANzJ3jRkkJtj0ipvNdbqoxFI1wONRmwEGDXVNaz9vJMwCDrkfZRuEb3p8nkoeAKqXMCFvSTmUYG8Xh8frkgi4J0pfPG+yBsgm/EDthrDhXOLccDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKfOaJhL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EA81F000E9;
	Wed,  1 Jul 2026 23:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782949432;
	bh=Xbt0n32toVSobX3TGaMk0D8N21r2TCZHCGTdW1Mhzeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hKfOaJhLA8U/uGYijaakG4xRlSjWgxNqND+EzbGyFZdaGtOuDcG/NN3nS1EsDdT0h
	 4w2mgKpJgdilSscRhJDUeKeCusMVsX21pz01KbRF5/L1GrPoobZIzfXpI2XCwb3ZFA
	 eotI/8IgUiQqQIWedVKTY/htvEUwNbNFpFd5uV7YWu2S+Z90iqvsRp9xx8E7OV33eM
	 yGKN9TG4UjCNmtxDl2KTWCZeShPaQoKLAwS/qBtnBzlUqt0V3yNa4NXPQ0Bo1GKjnl
	 yj+4p6DVAiU4KO/tPZEJHEwd8kqyz5tiqM8otoGGMHhT5apMugPjPBpm0CcE13sNLT
	 pMdYhnWPl6PKQ==
From: Chuck Lever <cel@kernel.org>
To: Wolfgang Walter <linux@stwm.de>
Cc: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Alexandr Alexandrov <alexandr.alexandrov@oracle.com>,
	Yang Erkun <yangerkun@huawei.com>,
	linux-nfs@vger.kernel.org
Subject: Re: 6.18.37 has problems with nfs4 (server), 6.18.36 works
Date: Wed,  1 Jul 2026 19:43:48 -0400
Message-ID: <20260701234349.354512-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <6eccafaaaa60651ef091257c3439c46b@stwm.de>
References: <6eccafaaaa60651ef091257c3439c46b@stwm.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22925-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux@stwm.de,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jlayton@kernel.org,m:alexandr.alexandrov@oracle.com,m:yangerkun@huawei.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 453566F26E6

Hi Wolfgang,

Thanks for the report, and for narrowing it to 6.18.36 vs 6.18.37.

You've picked the right commit to suspect: 95f9eb19d5e6 ("Revert
'NFSD: Defer sub-object cleanup in export put callbacks'") is the
*only* change to the NFS server between 6.18.36 and 6.18.37, so an
A/B test around it is exactly the right experiment. Two things would
let us pin this down.

1. The full kernel log. The trace you sent begins in the middle of a
register dump, and the task that actually triggered the stall isn't
in it -- the RCU stall names CPU 13 / PID 8887 (nfsd), and that
backtrace is above where your paste starts. Could you send the
complete log from the first "soft lockup" / "rcu ... stall" /
"hung task" line onward, with all CPU backtraces? The part before
what you already sent is the piece I need. If the machine wedges
hard, a serial console or netconsole capture (or pstore/ramoops read
back after reboot) will get the whole thing.

While you're at it: roughly what was the server doing (client count,
NFS version, and was an "exportfs -r", mount, or umount in play), and
does it reproduce or was it a one-off after ~1 day?

2. The revert test, if you're willing to spend the rebuild. On a
v6.18.37 tree:

    git revert --no-edit 95f9eb19d5e6

That reverts the revert -- i.e. restores the 6.18.36 behavior for this
code. If that build stays healthy, it strongly implicates the change;
if it still locks up, we've ruled it out and should look at the NFSv4
laundromat/grace-period path instead. One caveat: this also brings
back a separate problem the revert fixed (a lingering mount reference
that can make "exportfs -r" followed by umount fail with EBUSY), so
treat it as a diagnostic build, not something to run long term.

With the full backtrace I can usually tell quickly whether the export
cache change is even on the code path that hung, or whether 6.18.37
just happened to expose something else.

--
Chuck Lever

