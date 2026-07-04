Return-Path: <linux-nfs+bounces-22987-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JVrGG71qSGpDqAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22987-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Jul 2026 04:06:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A77E70670C
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Jul 2026 04:06:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iaGCwTsq;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22987-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22987-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2361303EEA4
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jul 2026 02:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88603603C3;
	Sat,  4 Jul 2026 02:05:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB71B1A9F87;
	Sat,  4 Jul 2026 02:05:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130739; cv=none; b=kLS3owfyRXGP5lMMFw54U9Pf7K88X5ixWF3adjCGUgCXU5EcGZ5FrHG0084RH2IGXF3tpPSXZ36v5xHdiAMUFgvHMZV/GG+bNYFyokZlWguiifHBVItVIgRES534tcGEDc0Rd0Ik0C166a26DlLszHlktJOUu/mr+9lnE20Dwjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130739; c=relaxed/simple;
	bh=XzgOGwGPehfG/WRUed3ahxUGrLcgClNfBsb22Euby8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPsocXhphP4lD6SFfN11spVX7QFc6X+5s8FdqT2/l+zNkzi6qPDV5b4IyjxIJDcHlTIV446HmkyTcXRugyekXqnXA2jKvoF8OSKBTHOLaNfuiJvEH6WBxsOPaeEmb57UnrZ7vmWjtorBuirEjk4EqW7xB0Vs8C0D4M1eWYe1eyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaGCwTsq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EBF1F000E9;
	Sat,  4 Jul 2026 02:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130738;
	bh=RWcPWzNzjvh23hn9MaR4ON2sVnmrSmQb48jJ25ZOaq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iaGCwTsqyrCLvNosJdrB+KIp6GHzdp8fl1/uULXIK8LjIqZOXwPOWBkKZH6t7K0wZ
	 nUrIzJr1Jk3s75hkhda2gsYBlZuzyt2qQ9NVegOoaUc1Co/zChSkG4iAvlJNtNxByi
	 tgTXnIc/j7ihCcbLEEEUmKgVXIjHuXLfzpcVKn8jtUbXx8G7+udas9uIFBloND6zSz
	 19q3E3JWGE97bUcg+9K33mMLG1RYhj6vAayLrKLZNMwJ/q93JdfVx1/4j+uU4c1UBV
	 asv7jVAF1M0SKxec+iBX+5pmAcWiuIfVfR8P1ZM7nlXbi4gQ0bi6c1R7Lf8XZ9oV17
	 JOOcLhFn+S/ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@meta.com>,
	Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH 5.15.y] nfsd: reset write verifier on deferred writeback errors
Date: Fri,  3 Jul 2026 22:05:05 -0400
Message-ID: <2026070315-stable-reply-0011@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703033705.1572486-1-cel@kernel.org>
References: <20260703033705.1572486-1-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-22987-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 0A77E70670C

On Thu, Jul 02, 2026 at 11:37:05PM -0400, Chuck Lever wrote:
> From: Jeff Layton <jlayton@kernel.org>
>
> commit 2090b05803faab8a9fa62fbff871007862cac1b7 upstream.

Queued for 5.15.y, thanks!

-- 
Thanks,
Sasha

