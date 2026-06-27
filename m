Return-Path: <linux-nfs+bounces-22869-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3hhMCiH8P2r/awkAu9opvQ
	(envelope-from <linux-nfs+bounces-22869-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jun 2026 18:36:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D78F96D24C2
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jun 2026 18:36:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PyJa+V3p;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22869-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22869-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 590B83038165
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jun 2026 16:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013B2314B9D;
	Sat, 27 Jun 2026 16:35:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAC42BEC2E;
	Sat, 27 Jun 2026 16:35:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782578143; cv=none; b=VyBUVwLs8b9XF8tJHIbtfoGlwEOed1YhWpFNListw8ow4cLBIDh6cPWFn5sjEq1wj2vPGkBS2hPTAHiVMnqHDhFjlz8AFFI/reI3bKGecT2JRhcyuywo+a56/LkD2p7GGjoyZwLNAH+XihTAf0zRDJ1WM2mlQpXcwvrLbN1NvzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782578143; c=relaxed/simple;
	bh=zTN0q2glhrsJYPew7PDgqVnYg1W1zHDewxL8xD1PklU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5ukkq70m2HLw763M4gLU70odP8lVGzpSDCjP6M82q3QZEvzRWe71xwIGtXylhxJgKIBNOQxsXqt52QZuUXCD6GLLFe1k7izf3Ja7bp0PkOVYVWa0KqmDIE3Pzse1Wiu7w+tPC6XK/CzHLSbhfsvtovJh0ig4e8vCPgsYKWMLWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyJa+V3p; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479D51F00A3A;
	Sat, 27 Jun 2026 16:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782578142;
	bh=L86NcFVsGNYxp1VrAP0RC6+4a+4d3KBmXI+tfRjqWEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PyJa+V3ptU5C/7VUSnAhyx4Fg2J64zYgrsfz7MylGVxRLUUyMIzzZdhKwSjoCu2kM
	 mK5Iaa7s7+cWUdvAuLijJN8mpiDwbfmWzXjyIXR1lKCumCjlSKEs8T8HJVfWEXYFzq
	 i2Ddia9IkFnwJAQjHUJnUBoEe1kxZBEvdoyKw6xVwfYVYIEfB6Bjk7RClWDQcZ8Zwf
	 MM50ew5eIHkcVhqdUSh37u40ORI8sx+zmlG1pNyJzJaffwjq9Wne8heXdGHxleeGiM
	 h3CvumYCUx+MOL1Km9PfT/owakjELAzO+3cN+F7UH6osoGsp2IVbNPFFlBi0JCTAgB
	 3dOpPguaQD6VQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-nfs@vger.kernel.org,
	NeilBrown <neil@brown.name>,
	Tj <tj.iam.tj@proton.me>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH 6.18.y] lockd: fix TEST handling when not all permissions are available.
Date: Sat, 27 Jun 2026 12:35:29 -0400
Message-ID: <stable-reply-item014-lockd-618-20260627162226@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626143122.71386-1-cel@kernel.org>
References: <20260626143122.71386-1-cel@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22869-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:linux-nfs@vger.kernel.org,m:neil@brown.name,m:tj.iam.tj@proton.me,m:jlayton@kernel.org,m:cel@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,linux-nfs@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D78F96D24C2

On Fri, 26 Jun 2026 10:31 -0400, Chuck Lever <cel@kernel.org> wrote:
> [PATCH 6.18.y] lockd: fix TEST handling when not all permissions are available.

Queued for 6.18.

-- 
Thanks,
Sasha

