Return-Path: <linux-nfs+bounces-22988-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3ypCNsJqSGpEqAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22988-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Jul 2026 04:06:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDA870670F
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Jul 2026 04:06:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OeFAP0pT;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22988-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22988-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84AE53040C4B
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jul 2026 02:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EEC373BF1;
	Sat,  4 Jul 2026 02:05:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDBA372EEE;
	Sat,  4 Jul 2026 02:05:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130740; cv=none; b=SOkwPmpHaG5Uij6Oy1ealeu0P62XGyAD9/xzVgN6QFi8XQ6LtrIYj+071KW9huoSJet73zhauf2wCYHV0T5FjpPoqi+ixJfXLuEvtG/ls65stZfP60CdadxlGIW26r8tEDyKNfLlxZnlWXgtEIDADTOCkc/8XI/Hp2g4paLTvjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130740; c=relaxed/simple;
	bh=Fo2SNl3WiRSCFV6uKCXzWoQmzx9lOUi1m/poFPkA544=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXallEsb75jAqvsnf0Oxc77mSSNJi2EmJvx6asoC6phbA9BM/xY1G78/qvjhU+4BGVOrnU1LBDFYmxPuwyRcA+gy/dQEjndXWNZuBncOnvH+3jImjWrjZpW7NpWECdJz8ZAdJjXqCYq6kZyV3g5T6/Nj9Dxt9/uR/0wgvRaCzCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeFAP0pT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C8E1F00A3A;
	Sat,  4 Jul 2026 02:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130739;
	bh=76fzJZQMN3aLIBNZ+Pzbf0nTDBaVFx1fV3JNVFQtLII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OeFAP0pTnNanusy2krWR12QwIQFh8ULLdbVdYVd5Zt1LtKxixpnpUP9DOOEQzSUQV
	 QhvNEG4tm4L19ELqImRfgA1WeDl+BjkpU1+SA0gK+KWu6sVyjxxXkrzmdJ4HHW6M0u
	 EJRro9QN9JISxhZRxC0BK+i5NSkg08MeRBO3/HlqbvH0sc8oytlazOxxtEu+raw7t/
	 zO/Coafw2H2ui4JcJJ/popXZyOnlBPqi4jSxZuOyMX3lhrYJwEUPVnHvtrkAJHNVs4
	 B9QZ58ZFyIXEbMboIpLKhhBmBjrgO2P7plfHtydA6n5VnxHDxrHgD7by0z7doiqQQN
	 e+pu66L6kOY0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-nfs@vger.kernel.org,
	Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH 5.10.y] nfsd: release layout stid on setlease failure
Date: Fri,  3 Jul 2026 22:05:06 -0400
Message-ID: <2026070315-stable-reply-0012@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703033954.1602126-1-cel@kernel.org>
References: <20260703033954.1602126-1-cel@kernel.org>
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
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:linux-nfs@vger.kernel.org,m:clm@meta.com,m:jlayton@kernel.org,m:cel@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22988-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EDA870670F

On Thu, Jul 02, 2026 at 11:39:54PM -0400, Chuck Lever wrote:
> From: Chris Mason <clm@meta.com>
>
> commit 30d55c8aabb261bc3f427d6b9aae7ef6206063f9 upstream.

Queued for 5.10.y, thanks!

-- 
Thanks,
Sasha

