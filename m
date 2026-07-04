Return-Path: <linux-nfs+bounces-22984-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kYgIBJhqSGo2qAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22984-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Jul 2026 04:06:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FDD7066EB
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Jul 2026 04:06:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TtGtnY4r;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22984-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22984-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F01333015630
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jul 2026 02:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C578E1F3B8A;
	Sat,  4 Jul 2026 02:05:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0F13603C3;
	Sat,  4 Jul 2026 02:05:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130736; cv=none; b=oeX+tzsh69VOHIxLsiLIJXiLiqxg5T4Av7vBdmpB658fKhSsvA+k7+DMdYxHINeyKfZJnogVxSPy5680pDzt6VToayhF0nBoUMfx9U+Woj1wZWL97cWC8sOI5X5p7R5YmdgZbL1ueQCf+xYuPnFczb85UiMOWQ/humSf774wytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130736; c=relaxed/simple;
	bh=iNSHtNtDCYhKS4qjASMsL3fPguj6ybt2uZqYtV3k3CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfCHE+2HQPCQR5N2xpTpDOE3JhSlNDychvu049+mSnXzNE10LJNDbabjYJaTyHBuUefpI0aKS0ubpNxLdPPhkkfcnICC74bz9JwlzfmY5GNMhABkTSHVv1h5Sq2QRlupCYbCrteZ8/k6h5rvs4BM7gkWeDcLsl17pnvoQOw+ufI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtGtnY4r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04BF1F00A3F;
	Sat,  4 Jul 2026 02:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130735;
	bh=6GCNlj9MTFZEj6SPqOFrCxxnUojhEQz9BikUHyWdTk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TtGtnY4rolNFlelW6ECAXDTyxtIUQUyN14Xp/cDCb8xdVY/aeUKKjU1QBKLrZEkM9
	 hLNOAOFYnyHxFHF0DSzQ9jrTTo9+LiAWNpd0AZsA2Ig6IpvmENxffC+zsJtnR8c7YK
	 M58XygNgHV/v4dkeXuSynjMpcME4f93Xs9J7KI571G8E4e2OdVYgAiEPL7qixcrP2v
	 6iaX+AQmrOuHrXKF1ule8LbE6SpgD+wD7E2aqRXVttQD3FNavzfDFUCVAu/ttOZXwl
	 O0YEsn6hzgZjw0hPZvjiqlZklLG38xA8Nxpzm+g4+K/dbGGT7AEji9hYiO/jQOnLsO
	 eW3+dUIWjKV2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-nfs@vger.kernel.org,
	Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH 6.6.y 1/2] nfsd: release layout stid on setlease failure
Date: Fri,  3 Jul 2026 22:05:02 -0400
Message-ID: <2026070315-stable-reply-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702214135.533354-1-cel@kernel.org>
References: <20260702214135.533354-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
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
	TAGGED_FROM(0.00)[bounces-22984-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95FDD7066EB

On Thu, Jul 02, 2026 at 05:41:34PM -0400, Chuck Lever wrote:
> From: Chris Mason <clm@meta.com>
>
> commit 30d55c8aabb261bc3f427d6b9aae7ef6206063f9 upstream.

Queued the series for 6.6.y, thanks!

-- 
Thanks,
Sasha

