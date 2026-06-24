Return-Path: <linux-nfs+bounces-22807-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ovXPKUIXPGoKjwgAu9opvQ
	(envelope-from <linux-nfs+bounces-22807-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:43:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCA36C0730
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:43:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eMfbGZPS;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22807-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22807-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ACE730416F6
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 17:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80A53DD849;
	Wed, 24 Jun 2026 17:42:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F61D3DD533
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 17:42:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322927; cv=none; b=Z87E70/KYoWCZy7inLU/yK4d58tGAeITiAVOpHJHTPetMORdAr3pvlie72WXRjYPbiP4ycLbKY0gmfsgQ1VzsWF83J8ml5AWZOuhxNDb0yWNXnEdT7dkj9WyZM/Is+xDbKXD/1soveyMhN78ctlSxIlSXKJXpp7Wy2URJ9o3QCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322927; c=relaxed/simple;
	bh=WTjwk46A+BMdtIArupqEU46BpPjELJr6jDd/XybuHJ0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pggFK5Rj3uAFjMSdw2Wy9ql+VF23yG1o1yLnbh+k417ahlf6fh5ljUxq4e9caUV8SfsY+ClakBVKRl9j54fxEl/JwXhIvkcuvyaxmO71isEfSEUr1ICdINRZpauqcV0bsRm6px6p/cYHK7Nbq5btOAtTcMRFpSpntC1JInRlFuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMfbGZPS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009D51F00A3A;
	Wed, 24 Jun 2026 17:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782322926;
	bh=WTjwk46A+BMdtIArupqEU46BpPjELJr6jDd/XybuHJ0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=eMfbGZPSb3tRKCLFpiA+tUDx4NMXSTBd7c9zsbOgdPpidYAio2lAcaCUIMV6zfePs
	 ib2JrCeAnmXXXqvk8LjRNo3IE6wIQBw1i+rKjB7Ed1684pTpYUcDiSORC8aPPzTblO
	 M7ClGM735rL3EwDpfZvJTljYER+UjBKqJh6pLD44BaCvxdMS70GvSfllFWqhUWwcJT
	 so6oCFl0qxrxh8VuMhMMUL9pwLia/z/zUZXzclE1BzSYv0LydDa1wgIGVIJijDd0As
	 1ar2m1RqRbLugryAtG+qW8TBhZnmGbK01ZH6OrIcPwSHz5ap1C9GRYNCRznyVoha6c
	 hwQ+KBaU6rCKA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 522F7F4006E;
	Wed, 24 Jun 2026 13:42:05 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Wed, 24 Jun 2026 13:42:05 -0400
X-ME-Sender: <xms:7RY8akQJFYFjzkAwewTI3K0v02c0Oi9-MzB0iAjuQkpGpbTMdWSVlw>
    <xme:7RY8asndhjpK4jdLjJ7a9gJlDS1CtFkHPife3LKWlSXMy4NHQEoCzFxBtu37POBNn
    7FoI5LDjIvESa9ePxi02wZeuL9Tx2_fVE5YJnXQylP7RJREu5WL8E0>
X-ME-Proxy-Cause: dmFkZTGoSxs57QAWMhzZfO4b3OKJG7FeUrAUvebBzQdmsvnZjCLY5UzC8cHKIaGiN/OE9N
    fWz94v6CPQqKy7Bdc2iI6M8WyPKJ3VgOJNkH3o8RLo3sCNCaf++j5ysE/sxnUcaX2iljao
    pHAL2aetSQuekXqfDyc1LOIMYztZDzTL8nkWDmQKwjzxNVxwYO0tUl9+WN0Qe1BDKh3i7P
    +vEeU8n2Qn/PhK6KYiUcFMdXCYLRZv6J31nV1VxA4dBmlIR4Qf0FJbdlZuad7Htvj4PIHc
    U/pOpcFIiLDqiXx22LG41lJdUpdSoMvNMaNCclXUD4upmId4zndU9XQNe9KPzgi7yEyBe9
    zXf0pkO3tsQ642jA43dQo/y7W0uJSdRy2Ag4vtQaZZF9PGEEwce5jprZv76As/UPaRJ20N
    W5ZlPWw8wr4u29OxbKYBET91aGYqG9K88vG4dvAqTGaE8OQmtVeqj8hqDdNw+s+SGnCvL+
    NLX9i0lWB2MJsD5MYmxW7zdKuZt3rXA0PD+O0WZynp8x6ltdp4LkMj7nXzFom5CgIuLron
    L45mbB6/gA+QmliJLIVerv2av38FR+CNHg3g1JhEg6/i7GXgKl/0THg07V/XrfYqJcrGci
    8WkNPWN7dwL5G58yX/CwhRjmlqK/pHvwHUOcNuPU04TEYFIJzMuVnWAjZLwQ
X-ME-Proxy: <xmx:7RY8ap2O3qryohzi8Sz6batkM0LmkotkV-2ZtWc43D3LKRib2twD0A>
    <xmx:7RY8ar-ZhErO8yDA9Ap1JXX15t8xYH3fTHLPF02bXofT2slesMt-VQ>
    <xmx:7RY8am4rdgpnQs4DDzMHxJ_Cbpq2H0W0stpjioecyuVjTALmZlbmzg>
    <xmx:7RY8aru87slJ9SSUPaqqh0kUigNpZD8KVYGXRZwCFcaStjCcNZvqbw>
    <xmx:7RY8ag2X62ZLngaMkgHVuHaXDXUTx6iGPXTEGT2UC-qNXLlBZdxfIVKC>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 33826B6006E; Wed, 24 Jun 2026 13:42:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AB7Sbl20cpvN
Date: Wed, 24 Jun 2026 13:41:44 -0400
From: "Anna Schumaker" <anna@kernel.org>
To: "Chuck Lever" <cel@kernel.org>, "Trond Myklebust" <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Michael Nemanov" <michael.nemanov@vastdata.com>,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <70d8524c-f85f-4e84-9975-e795b2f652a0@app.fastmail.com>
In-Reply-To: <20260624165228.2920869-1-cel@kernel.org>
References: <20260504-sunrpc-tls-clnt-pin-v1-0-197f359c6072@oracle.com>
 <20260624165228.2920869-1-cel@kernel.org>
Subject: Re: [PATCH 0/2] Fix a few memory bugs in RPC-with-TLS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22807-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,app.fastmail.com:mid,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:trondmy@kernel.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:michael.nemanov@vastdata.com,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFCA36C0730

Hi Chuck,

On Wed, Jun 24, 2026, at 12:52 PM, Chuck Lever wrote:
> Gentle ping on this series, posted seven weeks ago. Michael
> Nemanov reviewed and tested both patches the following day; he is
> the reporter of the use-after-free that patch 2 addresses on an
> mTLS mount whose client certificate the server rejected.
>
> Could one of you queue these for an upcoming release? I am glad
> to repost against a current base if that is easier to apply.

I don't remember seeing these patches when they came in initially. Sorry
about that! I'll take a look soon, and try to include them in a bugfixes
pull request.

Anna

>
> --
> Chuck Lever

