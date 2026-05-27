Return-Path: <linux-nfs+bounces-22019-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MjfHCIOF2o12wcAu9opvQ
	(envelope-from <linux-nfs+bounces-22019-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 17:30:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CA15E6E33
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 17:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 667033036343
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 15:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D9E24CEEA;
	Wed, 27 May 2026 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPM8UB88"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EC037B016
	for <linux-nfs@vger.kernel.org>; Wed, 27 May 2026 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895632; cv=none; b=hcAtufP7R8U4gMO4rtIjRMRpr7lae76kgqZ2EkS5sR2sZI5N2t+fbveZJjjba+YFUdG/6Fm6eHJ799eRP3Y05FboPXWPVdB6KGMyiO/rrSE6Tn3R+lGFlr+4yx3hX9cWmRqKVfiWYTCktR9l3NB+AEIy0fc5cWagLLpvSaRX2PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895632; c=relaxed/simple;
	bh=aWB5CxG+UAflS/Vt+mYZ3wO28NJdRc+/AmDkKmgpGPI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lIVR4jMIyeDjK4Jp49c8WsHmiP5MKj9mpU9GwbQHh1PUAYSUDYLdhzIRQuExVDOu7c2C5WCxD+G5m8DNY0n8kX3SNwrD/qsHlyD4GxXSrZLTXpvPezhLlV0lBeaaPIQpvubXlxCLXbYcNpYn4wmPEq2FJIFHFzUj09i1x7fpS0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPM8UB88; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADC01F00A3D
	for <linux-nfs@vger.kernel.org>; Wed, 27 May 2026 15:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779895631;
	bh=GX/ZIYsD5PpXguhl3j4kHVR9vHh5a9B9jnYi3eJegWc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=TPM8UB880YByLr2pUYFkJ9+clZterRJyAAWOGB1qUgDmPKhIgAMJyxnAlCW4MgE77
	 KFLdSvwI03PLS6zuX/jONm5bhjK9aBqXtNo6p768iIKFBBf0iphgfecTLCUIPpoTB4
	 HCI0daK8f6miDGgCt/vJ/meFQM1cUejJXKO5Y2ITCE9YZSte4ctLTSqsWHia0Jtktv
	 qWerUtMVZOFtJ/aVGYHCyP/YKrTxeLRzky6URJqiz8zydKZ1ao3SpoGH891tR//gjm
	 Baxy/4rN1W5ABcH0n1iwebJaQ/9Sp56cUqK/JdPX4kzemMmtH8HNuTeX32ghPdzRD4
	 W7OLrCT4rd31Q==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2A4D1F40068;
	Wed, 27 May 2026 11:27:10 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 27 May 2026 11:27:10 -0400
X-ME-Sender: <xms:Tg0XalBevCyh9ultlGdl1VRxlPoffNgNElnoml5axYzbhzZpFmVQ6A>
    <xme:Tg0XauXbPnbnKAfQZF7dSpvgx69nWeBkpmpLLNUC5Uuq7EhaRustuSA_77eiFnpxT
    7DIX8pK-ZvCw746NKxaqPf9YD5zhvsBCBMsntZ_cVU4jofw4digSx9K>
X-ME-Proxy-Cause: dmFkZTFGwBYBoy3P029salNuAVQ8RQHIhip8Ayqm6mNrj38bcmqqdfI31r2HhQsltOotAQ
    pIwSI6cUYPTfIK73SroNqa8G9wC1fNNEslRtcyurwfYSl6B04tjyAljNyzSMIopNpJRyWw
    PF2Cc3YkYeD0g/4d4YmYZVBuhhoQiCbRQ21GTqxDdjvRmX/h8I3n+386iU6vD6Dg1f2CtB
    0fnMk1VK2SQTczA6xxHBz5/M7rCKiAk+EJR0EDUu28LzsG3NAXF+kN7hJUw7NUIzyTteiq
    5oF3hk1QOhRSAa+MKGjoC+JhRcU3dxww0DwjDJuk94GPahHBwbtoajk7KqyKT/5F1tMGDP
    4hFrttKvA4dWyPmVcnDVE1CVq+8gsdVbAJwBOFmkxB21wGnX4XS77UXUd5lX6kSoub0PS9
    P/4CRLkJYIZhBaf5WwjCF7wIWSOftaZI9p60+AonFzog3YNy8Ccqh7emeznp8w4gX4pDU2
    kQh2T3/M7hZ9LgGJatXoNkD9PCNFf3WZTCV4Cicox0PycZj2KrVH8SyhDJQRhxLUWjn/yd
    BsVMk/bKrBF5qgVEKyoaTcQ5rAl37EGEeGT4dd/+2hFJKAiBxY/CyGbsSsaxQ6VwfiBmoM
    VD5vRMJpBOFVDcX7T5uUJNLYPJBe6jbrGgUuuwam7p1PpUxRNOfB99wpmh7Q
X-ME-Proxy: <xmx:Tg0XavrWUKVB51WvgLTD3pUZ94mKlI8P0NyTJhnlFNMEQSn5GveeQw>
    <xmx:Tg0XancyKNihZhzZjAWAeyIM12UUJaidXyltv2g8wv4ee5dgYHHe5A>
    <xmx:Tg0XamqcaYtmpPPj4agcAtn7HURtmjUf1z107kR5Ps4BTMGrMC4CBg>
    <xmx:Tg0XagEjzarWttRbFmPDntQXKlEbJ1-3kvtU2p6Psx0alap7Kgjirg>
    <xmx:Tg0XauvgobFyTOq5wV6ehzZxZlQ-PzSP6tcz5ZcmmuB-9htnS-3k_a0T>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 08E5B780075; Wed, 27 May 2026 11:27:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGShp_p4hdAB
Date: Wed, 27 May 2026 11:26:49 -0400
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Benjamin Coddington" <bcodding@hammerspace.com>, linux-nfs@vger.kernel.org
Message-Id: <8086a201-c74e-4a9b-9179-6e0df19a04c9@app.fastmail.com>
In-Reply-To: <0b482fc8-324c-4ea4-87e0-9e3131b08347@app.fastmail.com>
References: <20260526053004.4014491-1-neilb@ownmail.net>
 <40cb481d-105b-408d-969c-9aed9199708c@app.fastmail.com>
 <177983232870.3379282.1364318067313942375@noble.neil.brown.name>
 <0b482fc8-324c-4ea4-87e0-9e3131b08347@app.fastmail.com>
Subject: Re: [PATCH 02/] nfsd: fix minor issues with atomic_create() use in
 dentry_create()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-22019-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url,app.fastmail.com:mid];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 69CA15E6E33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Tue, May 26, 2026, at 9:50 PM, Chuck Lever wrote:
> On Tue, May 26, 2026, at 5:52 PM, NeilBrown wrote:
>> On Tue, 26 May 2026, Chuck Lever wrote:
>>>=20
>>> On Tue, May 26, 2026, at 1:27 AM, NeilBrown wrote:
>>> > https://sashiko.dev/#/patchset/177969022571.3379282.16448744624428=
323496@noble.neil.brown.name?part=3D1
>>> >
>>> >  reported a couple of edge-case problems with the use of atomic_op=
en()
>>> >  in dentry_create(), called from nfsd4_create_file.
>>> >
>>> >  These patches attempt to address those issues.
>>> >
>>> > NeilBrown
>>> >
>>> >
>>> >  [PATCH 1/2] nfsd: fix possible fh_compose of wrong dentry in
>>> >  [PATCH 2/2] nfsd: ensure nfsd_file_to_acquire() does not use a
>>>=20
>>> Hi Neil -
>>>=20
>>> These do not apply to nfsd-testing. Where should I apply them?
>>
>> I created them against nfsd-next, but I just tried applying them ti
>> nfsd-testing with "patch -p1".
>> The first works perfectly.  The second works with
>>    Hunk #1 succeeded at 1181 (offset -46 lines).
>>
>> Is that what you mean by "does not apply" ??
>
> $ b4 am https://lore.kernel.org/ yada yada
> $ stg import -M <mbox file>
>
> The first patch applied, the second didn=E2=80=99t. Since you didn=E2=80=
=99t specify
> a base commit, it=E2=80=99s always best to ask.

This comment is directed both to you and to the room:

The second patch doesn't apply to nfsd-testing without conflicts.
It's not just a "Hunk succeeded" issue for me. That's a red flag.

Also, any tool that tries to retrieve these patches directly from
lore (like "curl") is blocked by Anubis. So the "b4 am" then "git
apply" or "stg import" flow is the only one that is reliable. Also
"b4 am" does DKIM checking of the email sender.

I will apply these two by hand, but that really isn't scalable for
me.

Going forward, I prefer that you base your patches on current
nfsd-testing so that I can leverage the careful checking that all
the scripts do. I believe that is how contribution is documented
in nfsd-maintainer-entry-profile.rst.


--=20
Chuck Lever

