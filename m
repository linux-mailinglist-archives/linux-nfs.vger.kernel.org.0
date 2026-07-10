Return-Path: <linux-nfs+bounces-23242-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qMogE2ZNUWp6CAMAu9opvQ
	(envelope-from <linux-nfs+bounces-23242-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 21:52:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F3973DF43
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 21:52:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ofOJRGVa;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23242-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23242-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D6393004612
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 19:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D251137647B;
	Fri, 10 Jul 2026 19:52:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15FD2E7394;
	Fri, 10 Jul 2026 19:51:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783713120; cv=none; b=KuTM4Lh0Ozh0zteijTmuc1mMOxKwQ4Zpm10vdpds9zEi5AOm0CdmoTWyIvQo+IUHsBpkBq8yRaqdGYDTvEkKWPPB6SUe1jTS3JLd4cjm7g7A2D1IUUlu0Hj0e+rgRXDtSa/qsVlJwssFKRtdvrr5Ox/k2tl30xNYUHvMqCQ+8vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783713120; c=relaxed/simple;
	bh=FDpm1mkuSo1w7TyKHUKoK1nnbVMoH95ahHccAVHNcKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GdY3ngm5dUV7al3savcaU5rebdwSoEDk4RuD3DgIIPB2mTDG2m8VCganiV7HUKC47dgDZlggqA2TyE0OV86pwTbx0gaOkB3Eg4j8jIi0xTZjWk4Y2DG485pOIr0dwUn966GO0z8eXe5n1UCK2M1l0uK/Wh/a29oYnIbPo6PcOgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofOJRGVa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7A11F00A3A;
	Fri, 10 Jul 2026 19:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783713119;
	bh=dswdJqdyyLehMDU6x0rjBEhJUMCOAo3KbOtfnsVAcQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ofOJRGVacKIkwuVUR33Vyx+gIpEsJ8sa5ptd18xsRQpMKVEgBTF7TBS/E6P5LDFXf
	 KYDoAqQ3Ed+DTHmo24ZtSAcLu3AzPPCEmwvGenhSltwy8QyjGy50+bRFL4du+Pbf9A
	 MHq5XaYrB8du9LWNAAiTSFYCRgkI0Kxm9rxOg/Ro0azliB2aRvP97dLiU3rumICuib
	 l651u55/zf140VxpXXquyADOzI9TVkYRIkhbcio7a7Gnl1rm6Xt5hyytfd5SxDvdTb
	 b5yyd/UMBbmXm1vVDColQmAYPbR1T2xZagesTFcSRHa942a7YtrR1Tial8GyruydoX
	 GylJHR2BOE9zQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] nfsd: copy offload fixes
Date: Fri, 10 Jul 2026 15:51:55 -0400
Message-ID: <178371305588.2007097.11587521927052686944.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710-nfsd-testing-v3-0-a0ff7db6aa3e@kernel.org>
References: <20260710-nfsd-testing-v3-0-a0ff7db6aa3e@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-23242-lists,linux-nfs=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:jlayton@kernel.org,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35F3973DF43

On Fri, 10 Jul 2026 10:00:04 -0400, Jeff Layton wrote:
> This version fixes a couple of problems noticed by Sashiko.
> 
> These patches fix bugs in inter-server copy offload code noticed by LLM
> inspection. The first 3 were found via kres, and the next 4 fix problems
> that were flagged in agentic review of those patches (and some via
> testing).
> 
> [...]

Applied to nfsd-testing, thanks!

[01/10] nfsd: fix cpntf publish race in nfs4_init_cp_state
        commit: 2644ead835d12198cceef3c407c25ed94717b378
[02/10] nfsd: fix UAF in async copy cancel and shutdown
        commit: a3cddbf9713ae5ac03915b29975dc200ea6493fe
[03/10] nfsd: fix stale s2s_cp_stateids IDR entry for async COPY
        commit: 527c422ddaa3e0a452658faca10d1634f151ca6b
[04/10] nfsd: initialize copy-notify stateid before publishing it
        commit: 23fc79d2a8869ab25f0de5642a0f10d030d67d05
[05/10] nfsd: check client ownership when cancelling a copy-notify stateid
        commit: ee6c8255190685955762f66d23a887c4f86d24c6
[06/10] nfsd: revoke copy-notify stateids before dropping their reference
        commit: 24dd7409daafc00a0f19b61cb91d8f051cdc6b4b
[07/10] nfsd: return NFS4ERR_NOTSUPP for unsupported netloc4 types
        commit: 673c92979f3ab32c92df687625eee76ce42e55ed
[08/10] nfsd: split nfsd4_copy into transient and durable async copy objects
        commit: bf9b4f03a032cc111a6ec707627964f23c9b1209
[09/10] nfsd: make the copy offload stateid a first-class nfs4_stid
        commit: 74d681696ac194f355a2fc21693a44c816715bd2
[10/10] nfsd: drop dead COPY-vs-COPYNOTIFY type handling from s2s stateid IDR
        commit: 9b33df55dcac6950d1e176c7bb02a127d2d3dc1f

--
Chuck Lever


