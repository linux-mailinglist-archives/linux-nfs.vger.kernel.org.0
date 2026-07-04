Return-Path: <linux-nfs+bounces-22982-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gf5aAItqSGoxqAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22982-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Jul 2026 04:06:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9287066D5
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Jul 2026 04:06:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WBLJwVmz;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22982-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22982-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E98630300D8
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jul 2026 02:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D339937472F;
	Sat,  4 Jul 2026 02:05:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AE63603C3;
	Sat,  4 Jul 2026 02:05:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130734; cv=none; b=Gw5s0Q79mSOkwmiHHu+cHV/qJW2OgZLbVU/yI+R1boI7FShe7X5n246TVQ6Flfr6zamadfFY5eAuDbonwStfM7dZolFXiFMy90UI8oVv/s5TRIkLKg6rvHv/TcVHifqEiydfw+xHN4kMQawLvKkocscLvLHtMOjTiTBOzlDKtDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130734; c=relaxed/simple;
	bh=2RRQ76tPpd+5FEVjxGy0CV4HLbpH92exkwZNxOq6Hlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2HhRWboQREjkcE4Puh8yctmnCat426fyZUrQua8TktHQWmwsTVgPbw7UXiHV1vy1bP5wCtSLobkRqb0ppdaseZJg/MxN5VaY3Hf+MvEJmO58+nZXCm6wAJli0tZ8eww4n3cdtxHvQS79CVkN0NI4WNG4oxZOHs1aLRlvrQJMC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBLJwVmz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17E41F00A3A;
	Sat,  4 Jul 2026 02:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130733;
	bh=b7giR4IIKgzUqtHYQP2Visi/y16Z1NoOhO57Ql1xkMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WBLJwVmzfdIC20G8E5ki2CZI3FbJt0l+BPnYMavBUm+HVhNjvoyFNx31/iboYpSEV
	 eRvBZOpDQuG4gnW+L2G/ODdqj+swUGh/Ir2ioNq9+xAD0EAn82aVUdsCFa1YHkxZAk
	 KmIupbmwMWxhmp2NvaGrkorZ50FVt5791fEjXLLK+6F5Vc6DOQKFO0B5RabZjuBNLo
	 D3arnOnxQk96enJsBTNETwSct0GbUWo98BH93U36Cf3s6wbxWM6qr6Y4eUwx6QHbfw
	 +f+NtlBULZvQj+Dyhu5ThdFRPpPVwAs1jnYLgog3XP2GOauHrnkFAYUowdBjJla1VE
	 ouAg6sncD4+eg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH 6.18.y 1/3] nfsd: update mtime/ctime on CLONE in presense of delegated attributes
Date: Fri,  3 Jul 2026 22:05:00 -0400
Message-ID: <2026070315-stable-reply-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702202409.1583677-1-cel@kernel.org>
References: <20260702202409.1583677-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:linux-nfs@vger.kernel.org,m:okorniev@redhat.com,m:cel@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22982-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: BF9287066D5

On Thu, Jul 02, 2026 at 04:24:07PM -0400, Chuck Lever wrote:
> From: Olga Kornievskaia <okorniev@redhat.com>
>
> commit 2863bac7f49c4acd80a048ce52506a2b9c8db015 upstream.

Queued the series for 6.18.y, with the author of 3/3 fixed up to Chris
Mason per your follow-up. Thanks!

-- 
Thanks,
Sasha

