Return-Path: <linux-nfs+bounces-22323-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7uP2NqFII2rXngEAu9opvQ
	(envelope-from <linux-nfs+bounces-22323-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 00:07:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CA964B8C2
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 00:07:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MeIsVr4j;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22323-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22323-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18AE8301A701
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2026 22:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE46932ED54;
	Fri,  5 Jun 2026 22:07:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC84071DA;
	Fri,  5 Jun 2026 22:07:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780697237; cv=none; b=XjmuwP3KNMTgokTVsqO2JTb95fUhrnmKdlg+NYcBlSaDheJun5YEKb1edDcHVIYCpR4waCBT1h6dcUrQgcnnHSYuKI86ULqvPc9Ww/xaPUI5UT1H7mWGZa0E0TSFCR4ToG65DNcOU30HoUFJauDulnNVsb0PX5BoRAdlsSRejBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780697237; c=relaxed/simple;
	bh=Y7Pg5fAh9/b5hmp7rfWDWVRBVVLAi2cd9RJLnka7Lmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grvAhH5mE2LSZxsEuX3jiJtLJ6rL8zqGu4EBxbzYzDIhO8FE2DucY2qdXDgxu6+HSH5vucDA97kgPdIESX9WKXGudq1inqKUYVxAZw/b4JfM8yLkKY8g4Vk3dxkIcxkF7EA2DrYBORr9TxjaeFSyN6dATKGdceLJV2RJbtbYawg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeIsVr4j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AC51F00893;
	Fri,  5 Jun 2026 22:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780697236;
	bh=m+mXMDeY7i9LI/iEgBGFnHjF6kqWb3xtVcPntuQ526Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MeIsVr4j5hVwn6+MWIlSgN5x+LeQ3FeifCYJV3/xzXIvAek4ekcjeIttlWgtypGwh
	 WD9G2G15LSZGB+oz6EcWuyrxi0CgbxufwBGgHs9lJ+yTEhqjeRjdYyaW8nNDus4VTI
	 Wkb6i5MobgWKxdRn90Z6z9mFJySR24kGLSFmyLyWw6ruvFh1r5qgeZkO8kIwsFw+0R
	 LfsfUiGJ0y/qTLo1It1aA4y45X4jX+ccUZY5HtbuJdaigpu28nzE5vbnYrkc/BeIDU
	 Lb56gcbugE7qG70YKNJhjPpHaWBEYzHSfEQYlAqlCiWrQEwaCS5LRpSFxIKYI1KfgO
	 t8Isa/Z1g5MUA==
Message-ID: <b9fd14e5-4692-419b-8a2a-1ae6c1c63435@kernel.org>
Date: Fri, 5 Jun 2026 15:07:15 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] NFS: named client identities for mTLS mounts and a
 per-namespace .nfs keyring
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 linux-nfs@vger.kernel.org
Cc: keyrings@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Christoph Hellwig <hch@lst.de>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
References: <20260602154740.49861-1-cel@kernel.org>
 <bb9a872a-d4aa-467a-b4c9-7bca174a6bbc@suse.de>
 <b38b0983-7a63-4e77-a549-2d8859752cb9@app.fastmail.com>
 <ab767baf-aa94-4ff7-81fb-c19804a7883d@grimberg.me>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <ab767baf-aa94-4ff7-81fb-c19804a7883d@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22323-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sagi@grimberg.me,m:hare@suse.de,m:linux-nfs@vger.kernel.org,m:keyrings@vger.kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:dhowells@redhat.com,m:jarkko@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37CA964B8C2

On 6/5/26 2:32 PM, Sagi Grimberg wrote:
> 
> 
> On 03/06/2026 17:27, Chuck Lever wrote:
>> On Tue, Jun 2, 2026, at 6:39 PM, Hannes Reinecke wrote:
>>> I am all for making keyrings namespace-aware. Logically I _think_ they
>>> should be tagged per user-namespace, as this really is about the
>>> filesystem (and as such would warrant to be tagged per mount ns).
>>> Tagging it per net-namespace is not a great fit (well, for me, at
>>> least), as also block devices might require keys to present the
>>> bdev (eg nvme authentication)
>> My understanding of the proposal is that there is one keyring on the
>> system for .nfs and the keys in it are visible only in the namespace
>> where they were created.
>>
>> Therefore the consumer (say, NFS, or NFSD) is running in a particular
>> network namespace. It will create keys on the one .nfs keyring, but
>> only the tlshd in that same network namespace will have access to
>> those keys.
> 
> Can tlshd run in multiple network namesapces today?

AIUI the netlink upcall in the kernel wants to use a netlink socket in
the current network namespace. So there has to be at least one tlshd
instance in each network namespace that wants to use in-kernel TLS
consumers.


-- 
Chuck Lever

