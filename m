Return-Path: <linux-nfs+bounces-22983-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J5DBFo5qSGoyqAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22983-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Jul 2026 04:06:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFFD7066DA
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Jul 2026 04:06:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=i5zYa+b1;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22983-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22983-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 290FF3036FE9
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jul 2026 02:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A928F37268D;
	Sat,  4 Jul 2026 02:05:35 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DBB37206B;
	Sat,  4 Jul 2026 02:05:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130735; cv=none; b=fT761247eYwAU24pICu3yq8Wvgc2nqrwAt2vboJT8gE47sS5RRxG7CGPnvUgzTwxhgJ5kXmgrBadscv2YOEeK4xP2Ij60wK/n0zifDZQ6asVt8qerIFt5xy41DxTSDsaRrmU4chavn1j1QMj+Ey9IZUrgnAAQCx8EHzuK/HKztI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130735; c=relaxed/simple;
	bh=0jfMMJrWKSlejEzxOviOsFRyPzWdH45kMalhh1eF3+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RiANbQn9/mlziT/PyMQ9UVac5GzxCJkZrliD9VMIWQob+060b1iSXZzaG/2yV2kq+eoAMIgcKDtL0rNWM2uwfLay2du7+YGe4Fgd4CGGCUwtIL7XtCU11q8wKFEmFMAAod/xGHYpb8iH2zTpa0FPkp+Ta7yzi2K2vZPA9dqMpwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5zYa+b1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24EE1F00A3D;
	Sat,  4 Jul 2026 02:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130734;
	bh=NzSI7Hp/TPkbYa0oo/N23lmOA1/lH/sLGOornU2wAQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i5zYa+b1oeFZ5Lk+4Q9DaisUYc0UhKQjAVUM24R8j1XqFXRD28MXhA2g4ya+C8OI9
	 8NjtVfXcZO26YPlU+BRWM8Oxp90Q+PQwYMNywYuAOnEyxQla2eC3zEKXLnU27IOkr/
	 p2BwCotDfONp0EsUjLaLxwzCcLObX44x52YI/Y03/6EdCe1A1Dfvbd/JuxDtkIfpO0
	 us/trdV3AthXtvuVPutsJsPvXy4ZT3JazLSWQPWJH8q5WU8MPghbAgbjgAwD7Zu9zk
	 M8R/axCmP87mTg1e2FPBqh5Azzf0JB8oymPbs9BHCjPdVpc3KV7f8z4j22GkZzzix/
	 Gj+FD3/iWSJ5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-nfs@vger.kernel.org,
	Scott Mayhew <smayhew@redhat.com>,
	Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH 6.12.y 1/2] nfsd: fix file change detection in CB_GETATTR
Date: Fri,  3 Jul 2026 22:05:01 -0400
Message-ID: <2026070315-stable-reply-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702202749.1618630-1-cel@kernel.org>
References: <20260702202749.1618630-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:linux-nfs@vger.kernel.org,m:smayhew@redhat.com,m:cel@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22983-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BFFD7066DA

On Thu, Jul 02, 2026 at 04:27:48PM -0400, Chuck Lever wrote:
> commit 304d81a2fbf2b454def4debcb38ea173911b72cd upstream.

Queued the series for 6.12.y, with the author of 2/2 fixed up to Chris
Mason per your follow-up. Thanks!

-- 
Thanks,
Sasha

