Return-Path: <linux-nfs+bounces-22220-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YPKVKiOjH2pwoQAAu9opvQ
	(envelope-from <linux-nfs+bounces-22220-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 05:44:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B31634086
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 05:44:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=R8grUZnO;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22220-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22220-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 738533026A87
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 03:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE7A3382EC;
	Wed,  3 Jun 2026 03:44:31 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07142F3621
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 03:44:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780458271; cv=none; b=p5prvQtqjHnxiH20+3zFR4bbuNBWH/FPdqVT0fXmhFfrCjv7Rd2Um/1QahMTym2ssIrSqwwYZfMnswousEDxlzm6S+Masf0sMBlX5EpKwI0v3urBkf5YC8AiMxJgoa303bgKSaaurIPtqDw04OD/mt5ymmibt7w7TOofXz2ucw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780458271; c=relaxed/simple;
	bh=Ma6VQUT0hT3gkiRh3qstlFZLI8nW0YY/8No5v3c0AAg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Rk190dANzMN2zqzYptcNelLnYIgXbriOSgUdHM58z3W/w/vhsQliFPD4HqjKHzfw7RpFAX+YrF42AV7arRTcLDfLKAFD8vriVWndsswb1JdyOANMQ9fx2OGIx+0LdUPPl5OaMVmWyLUcVB0KOkF03GZwkRMnX8kb0VXD6DiLJOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8grUZnO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528261F00893
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 03:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780458270;
	bh=9Vd/tR93h1LyQtueJWJsxfuFwPgzBMwt7CI/UBlbxxo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=R8grUZnOsAonJdvV6KiSTyRTmZ4kFA3TvtnwSXMl+Vwl9b5RGy/Mh3F6Vb33wXfx6
	 ozL3KN9rAOIcJyX1Loc/ZOkXQKTt9hXUnSCpa+QY79jKjWZz9daJGFwR/aEPc1BC7X
	 BlovyRuAmsE28jiad0W8KmgjVBwzy0RjqQDCpjipp/zEE0vIZhgTFEtokFK9HbXWL/
	 Uemf5/fgSQv800jbq6gCVPHgxQuk3NpnzhGNX+UTieaFFd8E+ae2dvtcXEICEWjP0q
	 Zj3ep0akuvK1o6ekg9kcJnjkkNNYP4/wnnI/53KfXFtbEm+9v06H/ncfKqlBsIIJdj
	 DyKdtXU+wMGKw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 678B6F40075;
	Tue,  2 Jun 2026 23:44:29 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 02 Jun 2026 23:44:29 -0400
X-ME-Sender: <xms:HaMfal6mz0xzxjuAibpjYeYA84MQfEnY6jD0ZCf3nkG4DVbSYqj9SQ>
    <xme:HaMfatsdGQIMmLfcDWTEiGtGZO-czfrtMYtUDL8dydklhrtR2Ia2k2B9jxaVGVa8I
    WfFPEClXKycWTEylCgqh44hepR9ofF9w6AywNKiCFVgtwVGXTFDsg>
X-ME-Proxy-Cause: dmFkZTGMY/+llDb7sTQoF++aWRVQKmIchezE6Amfq3M580XZh4aKvBbKjir3ghn1XBjo2j
    VJtCKL/y1fQnBmpEENB0gtxTCAQtLre+hR0csT+rQqwHerygtD7/mnpq79KveQD5P4Ek3s
    RKN7BUm3Zoj594ZoIq69Y0+O0XW8SysYw9AHDXZS+9e/Zk8kWQXq14IAr05j4c/CJTgtPQ
    8usnBGZAgctRGUQsspPK54OVm5kchMncYzophGO7akvMn8uGkHiaZSRTDayqdINmIUyzP8
    L+2w6McwwgRl0S0taRLUUxZiTRXsdFVxQxPbG96RJ02T55z4ys+jODBrrLP8KC/ZATnHE1
    cWR9AhrTC7d9G6/KEFhRwoo61LjaKTqJnGgqUWeXxmHh46v0Ap7JGaockub2WU/+KoXTra
    8vuJQ+zQe8ZiCxU6+zNeTKs+GWd784MA/oprKTbGgvhMPNzHDJr1EO79/sZQ/2AfqbuLi4
    DRZjkt2RUUu1sLYE++J6+z8MXrVyxCax0MQvF0iH+zO8qAtf61whH/hmmEP3hF1EaW/ACX
    ern2KdkvkPfTTaC6UzNeY4AeGQ7wG9Dl3scBPvBqxW8hOvai5nph4dyftXSBAtdDZUT/3s
    7mF1Mes547NBX+QIy/bwLnJFI1d12NzQqvFHkhvtNUHzmwN4O75YGv8BpZlw
X-ME-Proxy: <xmx:HaMfaigJ1cjBS5zd2O2WkA7CCh0hjEuciZjFhgW3SpzGjkgCnLNO4g>
    <xmx:HaMfag3k7uJCy6xx8rrEbg2PlIRnaNmaWygfxxFCDLjg1frF5UZpGA>
    <xmx:HaMfakj912-wZjDUXH0Ae9M0k4vv9hb0q8UsUNUBVS8ZBPOKRNy1Iw>
    <xmx:HaMfaofVe-mLLgdVyvPxZDafSLHrP1SPam45NZHCML9AEG6iStISzQ>
    <xmx:HaMfavlH8B12D0KxDMqaI6BtSn1xLirWG2tiT1X8wk02q3VR-l74Rjx3>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4767D780070; Tue,  2 Jun 2026 23:44:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 02 Jun 2026 20:44:08 -0700
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: "Benjamin Coddington" <ben.coddington@hammerspace.com>,
 "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Message-Id: <561e9ac6-348f-4d6d-b896-38dbe5ede3bc@app.fastmail.com>
In-Reply-To: <178044079821.2082204.6117918610145832039@noble.neil.brown.name>
References: <D33770A1-9098-4F1A-93EF-590E6C0B7638@hammerspace.com>
 <473e337b-fabc-4884-a6c4-0f04b6874d0b@app.fastmail.com>
 <3AB7EB6A-B207-4B91-A695-66C4704D0E31@hammerspace.com>
 <4c5dbb98-0209-4572-8eac-1578536bbd78@app.fastmail.com>
 <AED22AED-E97D-40E3-9839-BF8307EF8B65@hammerspace.com>
 <1a5c70d8-e7f4-4671-a29a-023be7c107fc@app.fastmail.com>
 <178044079821.2082204.6117918610145832039@noble.neil.brown.name>
Subject: Re: [RFC] knfsd: per-client fair scheduling to prevent single-client
 starvation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22220-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:ben.coddington@hammerspace.com,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06B31634086



On Tue, Jun 2, 2026, at 3:53 PM, NeilBrown wrote:
> On Wed, 20 May 2026, Chuck Lever wrote:
>>=20
>> On Tue, May 19, 2026, at 6:02 PM, Benjamin Coddington wrote:
>> > On 19 May 2026, at 14:44, Chuck Lever wrote:
>> >
>> >> On Tue, May 19, 2026, at 5:08 PM, Benjamin Coddington wrote:
>> >>> Just to be clear - the issue I'm exploring isn't the same as when=
 all the
>> >>> kNFSD threads are slow due to their workload.  This is very much a
>> >>> multi-client dynamic where one client (or a group of automated cl=
ient
>> >>> instances) are able to easily starve another simply because they =
create the
>> >>> most connections.
>> >>>
>> >>> That's different from the other problem that we've discussed a bu=
nch at
>> >>> bakeathon and on the list previously.
>> >>>
>> >>> This is not so much a deadlock issue as it is an issue
>> >>> of per-client fairness.  I think this problem is in a different c=
lass.
>> >>
>> >> Does dynamic svc thread creation have any impact?
>> >
>> > I haven't tested it - I think it would just pin to max-threads for =
the
>> > workload in question.
>>=20
>> If the aggregate workload consumes all the threads, then that doesn=E2=
=80=99t
>> sound like xprt scheduling is the bottleneck. But I should look at
>> numbers instead of speculating.
>>=20
>> Are you seeing connection loss in these scenarios?
>>=20
>>=20
>> > I'm probably not understanding you here, because for the problem I'm
>> > interested in fair would look like prioritizing each client's reque=
st
>> > queue equally, no matter how many xprts each client has.
>>=20
>> Then for NFSv4.1 and later, NFSD might schedule work on the session, =
and
>> manage each session=E2=80=99s workload by raising and lowering the nu=
mber of slots
>> in its slot table.
>
> I agree that managing slot numbers is likely to be a good approach.
> It doesn't make much sense to allocate to any client more slots than t=
he
> maximum number of threads - does it?
>
> We already have code to reduce slots numbers based on memory pressure.
> We could extend that to reduce based on demand compared to number of
> threads.
>
> e.g. let every client have a least one unused slot until the total slo=
ts
> across all clients reaches the maximum number of threads.  Then apply
> pressure evenly like we do for memory shortage.

Sensible!

But these days the number of threads isn=E2=80=99t fixed. As load goes u=
p the
number of threads increases.


> Idle clients will get pushed back to 1 slot, active client will tend
> towards a "fair" share based on how comparatively busy they are.
>
> This wouldn't help for v3 of course but I don't think we need these
> advanced features for v3.

Ben=E2=80=99s employer might disagree with that :-)

I think NFSD might also need to consider LOCALIO workloads.

--=20
Chuck Lever

