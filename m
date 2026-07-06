Return-Path: <linux-nfs+bounces-23119-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fsyZL1cVTGpngAEAu9opvQ
	(envelope-from <linux-nfs+bounces-23119-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 22:51:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F4A7158B5
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 22:51:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=R3q2v8Ni;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23119-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23119-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C4B53010CE5
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 20:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEE83D646B;
	Mon,  6 Jul 2026 20:50:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331CF3C3C0C;
	Mon,  6 Jul 2026 20:50:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371053; cv=none; b=pQWEKPfqiP1sZv41QxagZUaE19zocpDDarfqlgb/GoX1V8Y5defEbuLxpwMgcNuu26kNMIvxz6mrAWvbA2NktYYy2yuEffIQvGIka0vArMTF1Fl7xlYx6WTkdAkrnpxRABzhWTvTvrWEzFd/Oski0RaSlsJdfbE83gpQDFIcSr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371053; c=relaxed/simple;
	bh=ttXfcZcqzRmqdNi99/dP+I/JEJS6UuTKJ97SyR1AdHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fB1c4PJlUeVW9JDLX1jUT80D5bF4yEhfgF17v+Fs9CKwk1BoajoGj41PU5izzTJJ2xt7UMWzJHKjJhAbyzXpeWGdy5OVdrdL5g74Lopv0M45JZVit+O+fy0wTlyUUB/MdJAofuqQjv7Q+BCLhXC44VhWpMbpwicPGQWbU9uFkSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3q2v8Ni; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C151F000E9;
	Mon,  6 Jul 2026 20:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783371051;
	bh=66d8tsxlbloJEBgmrcausbM+o2xvg8AHk4c1SBMMT9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R3q2v8NiyCcquyZ4kQQn8pH8tB4CFWI/qV4T3y7TvpXTeDRdWsFVdkoOAAEghRx6F
	 LJLC79blykxMh1YDHX8aJKM6OHHFYawFMzbRoGHdFSnpLhdOYtM56J11ND/QlzftvL
	 kvh0/PL9C2VXDNIsvooXKvYPgHUgEHC3jBtplzkIOQKG1c6V1SDq6a16pOcGrr0T7e
	 j0A2oxGfs+GKeSRgVxNb4qCcVK5EtYNxVqzivfcPcRjbYXv7zmy4W/2czSel6mufFL
	 VrcjAwg/40phj+Pq/GdJXv934Y3H3dy0VNZyK7vkX1mW1pnyxQseQ8b6jAJ9QMXgGZ
	 6VmVg+C2ilYoA==
From: Chuck Lever <cel@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NeilBrown <neilb@ownmail.net>
Subject: Re: [PATCH v5 0/5] sunrpc: hardcode pool_mode to pernode, remove other modes
Date: Mon,  6 Jul 2026 16:50:47 -0400
Message-ID: <178337103119.1752692.17102361450604849930.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706-sunrpc-pool-mode-v5-0-6c4ee7cd89aa@kernel.org>
References: <20260706-sunrpc-pool-mode-v5-0-6c4ee7cd89aa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23119-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:neilb@ownmail.net,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ownmail.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4F4A7158B5

On Mon, 06 Jul 2026 09:29:20 -0400, Jeff Layton wrote:
> This has a few small fixes and comment cleanups and also implements
> Neil's suggestion to remove serv.sv_nrpools:
> 
> Patches #1 and #3 address what is a shortcoming of the existing code --
> namely that the server can be configured to schedule RPCs to pools with
> no threads in them.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/5] sunrpc: route to a populated pool in svc_pool_for_cpu()
      commit: abf002b5412b282ce825cf0ada22f0278ae7f408
[2/5] sunrpc: hardcode pool_mode to pernode, remove other modes
      commit: cb4ab2c71e09f8c958ecc7bf07270ae78584f85a
[3/5] sunrpc: guarantee a thread per pool when auto-distributing
      commit: c972bef38717f27c282592bca22890f49233ec0a
[4/5] sunrpc: tear down pool counters before dropping the pool map reference
      commit: 9b6f69571d09627b8b4303be0f257c0e36d9d3fd
[5/5] sunrpc: derive the pool count instead of caching it in sv_nrpools
      commit: 9435623ac560654825a62ee4b628ae4bbaa87920

--
Chuck Lever


