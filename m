Return-Path: <linux-nfs+bounces-21995-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEfWFyROFmqxkgcAu9opvQ
	(envelope-from <linux-nfs+bounces-21995-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 03:51:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 633DE5DE63E
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 03:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF3D83007AC9
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 01:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBAE8F4A;
	Wed, 27 May 2026 01:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5xgWpMs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFDD32AAA8
	for <linux-nfs@vger.kernel.org>; Wed, 27 May 2026 01:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846671; cv=none; b=FhF492JfeldDqMgwWOpiGRINCnGb+a3uJlhnJpo5BOpBWQeoNOvt9SJzEzCDNrA4rdLDOMlQlcKUpeLQ2Lc36r3v1JL4Lo10qZMfwxDlar7sRs5NcFOrnLmoUyfKkCqcIq231rFBF7CwwjwGCsrukKUUNo/NxdDqZTjAWeXMXLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846671; c=relaxed/simple;
	bh=ghmXM7A2fHSN4Emz6PIbMUIcKGDt40p5J75DU4wQ9AI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=d5vMonxbRobk0hyf0suT+skmxUdnXXUewEGSAPwEGHKbYrb4ik9RmVOozTCjTDLExla1Uk348yF1wJh8dkbOrM0m2NhJQn2KdlM/oZN/AM/cPMXjcR2ETYfETPD4mroBox/frL+GPbCYA8sGXijQGwNDiYWjh/VxFaQXw6+uwYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5xgWpMs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C81A1F000E9;
	Wed, 27 May 2026 01:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779846669;
	bh=iagz4A07MCGUfeaNDsGdKDCQCJb+ehL5snEiAS3yUdI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=i5xgWpMstpL83nOE809yrRjuQdINYChu/TuD+tItQuX1vYtPT3xlW4aVyfkdrSE4M
	 KNLaQ0SlqvHDemsiQeE1tHHYErrwMdXAQ1UhqRwxxATxaNTQOn2cuGBiihYhQ/lpDJ
	 A7IIVzuBnRw5wL6iPSYQSY6jsPDigziqSRtemhMzyjmAoqyNeSsLny83bBUttLAbcm
	 v3ennZc/PNK7w263q1WQWg7bKYT+uci1afH0QbBcGs9a9treakKuURWcGB8+7ZKEHH
	 0+vAGbGpz80J25ZmoVAY1wcyUnJaXXeuFJNEAF/jJdmct+SPvrNZ5ZlMnHMyN0fF1K
	 cXOOk59jtfleQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8D134F40074;
	Tue, 26 May 2026 21:51:08 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 26 May 2026 21:51:08 -0400
X-ME-Sender: <xms:DE4WasI3omGHJybfBhm47RMszZpHmVJ5J7AQqKJmMbblPhCnawh_Lg>
    <xme:DE4Wam_dkM6yLR3hbTkbQWITRNqqQbeOEkXtVe3T0x5BdCxV_wILIr2hPJpxWJT-Z
    btjhed6JIF2BjtGyIuV3_IGQE0FYWdAncBDuCFBj-ZccNc3kTRcD7A>
X-ME-Proxy-Cause: dmFkZTEalR73X1qw3fAt4jK6FDBpy08DLcMuRSo4lhWmy29eVGwNAjGBs/x4d3qARVOGKi
    F3EfJSUAiaOMCYFk2RtCPkJhsR0DZ0hsTj3Klo1YhDxx7Q1rYk8Cv5h0PWV/Ktrvk962Sf
    3x+v1z1dCv5+iKnFgNXVsqg3h8qxIZ+hVCNKkIdglH8s18QWJJTaFCrnCa7IUkcSZK/Xwz
    11uof3MPG8k8IKamloosO8sPI++po27rmWXnmMp/wDJgQTBTt/dp8xDy+P5xEaFep2Rwl1
    tqPae0OySTkCX5tgsBACq97Kl3aODhcKNX5Q+SlkRAv8a2SNFVdiSQX6jZ6tDPZ8R7ztqp
    PJspUjOLovkbuN183moFpk8qt2nvVy32amNj75nqWTNnA6+NLIg+GHrmeVVPR9n32KwLsd
    32PWuAm6yxxgTFQDj+fdf7mRGHrW7w0QaSMAtXBuo0AxOZluG8QNmZ9MLj72yoX7BY3EkK
    2jIsytVfqxeW5wMB1ByJlAin+GwREgygvU0pwx09nsRIQLzHi/RSznGwHNkp+/Vn63kUNS
    Q2SQRWKMakGMZ+545QBFBtiy0X6iFHtBdKfdDYzL6omoIevmi8FsBG13wiozX1ScX/4ZGz
    vuZGfC+kY47aOoFYftMiUB6CqhmSTulqB6XiZWvCgcgffueLQrFQR9eNovtw
X-ME-Proxy: <xmx:DE4WakxuYdujrT3XvhzTgmeH7egcm9pJSfQ7sJt9VXlCq2Rm5g7SAg>
    <xmx:DE4WamFMxGBqT5HLvOPNAYMNG0BoISa1hMyrKkt52BGLyhx9oPWFCw>
    <xmx:DE4Wagzh4MRDxZHwXHicfC4k-jN8aI0nqq7FsTbjrhkfV5WmMoioNw>
    <xmx:DE4Wavvnlgso-UNXdHPtIuqI8L74sPDV7NSFGdvzFTjA24MHNzlNcg>
    <xmx:DE4Wal1b-5A4dSwCKdhiUbLO4SspvWLdEaJQDnCFrCmM5Oi30iiNDBtY>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6D8D5780075; Tue, 26 May 2026 21:51:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 26 May 2026 21:50:48 -0400
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Benjamin Coddington" <bcodding@hammerspace.com>, linux-nfs@vger.kernel.org
Message-Id: <0b482fc8-324c-4ea4-87e0-9e3131b08347@app.fastmail.com>
In-Reply-To: <177983232870.3379282.1364318067313942375@noble.neil.brown.name>
References: <20260526053004.4014491-1-neilb@ownmail.net>
 <40cb481d-105b-408d-969c-9aed9199708c@app.fastmail.com>
 <177983232870.3379282.1364318067313942375@noble.neil.brown.name>
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
	TAGGED_FROM(0.00)[bounces-21995-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,app.fastmail.com:mid];
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
X-Rspamd-Queue-Id: 633DE5DE63E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, May 26, 2026, at 5:52 PM, NeilBrown wrote:
> On Tue, 26 May 2026, Chuck Lever wrote:
>>=20
>> On Tue, May 26, 2026, at 1:27 AM, NeilBrown wrote:
>> > https://sashiko.dev/#/patchset/177969022571.3379282.164487446244283=
23496@noble.neil.brown.name?part=3D1
>> >
>> >  reported a couple of edge-case problems with the use of atomic_ope=
n()
>> >  in dentry_create(), called from nfsd4_create_file.
>> >
>> >  These patches attempt to address those issues.
>> >
>> > NeilBrown
>> >
>> >
>> >  [PATCH 1/2] nfsd: fix possible fh_compose of wrong dentry in
>> >  [PATCH 2/2] nfsd: ensure nfsd_file_to_acquire() does not use a
>>=20
>> Hi Neil -
>>=20
>> These do not apply to nfsd-testing. Where should I apply them?
>
> I created them against nfsd-next, but I just tried applying them ti
> nfsd-testing with "patch -p1".
> The first works perfectly.  The second works with
>    Hunk #1 succeeded at 1181 (offset -46 lines).
>
> Is that what you mean by "does not apply" ??

$ b4 am https://lore.kernel.org/ yada yada
$ stg import -M <mbox file>

The first patch applied, the second didn=E2=80=99t. Since you didn=E2=80=
=99t specify
a base commit, it=E2=80=99s always best to ask.


--=20
Chuck Lever

