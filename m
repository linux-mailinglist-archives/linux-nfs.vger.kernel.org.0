Return-Path: <linux-nfs+bounces-22989-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5ZA5M8hqSGpKqAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22989-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Jul 2026 04:07:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B26706719
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Jul 2026 04:07:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Q8JFdaXy;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22989-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22989-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68F8930422C0
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jul 2026 02:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68B321638D;
	Sat,  4 Jul 2026 02:05:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DC43431EF;
	Sat,  4 Jul 2026 02:05:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130741; cv=none; b=Wqj8d9WriHBezR6YK7AXZju5PRo72o01Hv36+inqqLnWUnnH1eb0eKMvKevofeO1vCsL0BU6BxOR185UtKBcCRyxKRkNsGnDYjqfCBsuRcwkS4L1l6+d7bwZM7Q4R2k+dOmsRqRJthxEdsYzCzW8eSYq6wezrE86vnukCLutXsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130741; c=relaxed/simple;
	bh=+MZspb6jd4NigXbMKEVUSzPCyi1i15734/YNShGq9MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pw8o9M9nfKcSFIx0h0LwHZMkhPPXcnFSM3utLHcigCU7b/h+/VxKApkdzlE+624tqEBkY1e2Gv3Gjd42y1hD5UXBtCblp1cbgwheGiPOnyJ3TR8QN0NLw5cmdWEK+FwHhtqLLepgrIJynPZztHP/VmLjeYuLSpRBhcefmzjMPUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8JFdaXy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79BE1F000E9;
	Sat,  4 Jul 2026 02:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130740;
	bh=9WM2YU7j6aR0eN08qNnm30jRmphyDgOmQCl47Pwzp44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q8JFdaXya6+gkUnjqcPfJ/NdSb0n+ZEWE4VMNWxjxQ20GJOYGkUiN2LsZkzYjKFkH
	 VGpQW0TDDO3vx2+Pe8e25LXyH/JjlG7j7of1CufT/vrWW4YCnUrvZzsZFXnRHJo6EQ
	 Y7x2e7tzmopPtfLomoAsCMLfS1C+oZ3OGH0QT2F6oo+1OXs7/XI4yNStADtQ7x6gXx
	 8roVetGIldApXJddDH2aSknhb7HR8SCHOoT8RdmEzVJk1aA+2ouQ3ac2LlMkZmofAk
	 T80AudWVCwB8qiQVRUQWESKe7XXG372yeMCy7cjHNweQTjF6HN9HKVHvyuMJlUodEF
	 KGGepx2T7gK7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@meta.com>,
	Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH 5.10.y] nfsd: reset write verifier on deferred writeback errors
Date: Fri,  3 Jul 2026 22:05:07 -0400
Message-ID: <2026070315-stable-reply-0013@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703034048.1602590-1-cel@kernel.org>
References: <20260703034048.1602590-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:clm@meta.com,m:cel@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22989-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72B26706719

On Thu, Jul 02, 2026 at 11:40:48PM -0400, Chuck Lever wrote:
> From: Jeff Layton <jlayton@kernel.org>
>
> commit 2090b05803faab8a9fa62fbff871007862cac1b7 upstream.

Queued for 5.10.y, thanks!

-- 
Thanks,
Sasha

