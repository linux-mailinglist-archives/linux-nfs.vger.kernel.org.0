Return-Path: <linux-nfs+bounces-22980-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IE7OAMwiSGrdmgAAu9opvQ
	(envelope-from <linux-nfs+bounces-22980-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 22:59:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FE3705A9A
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 22:59:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LZT3RHFk;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22980-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22980-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11C65300F0C9
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jul 2026 20:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CDA35A933;
	Fri,  3 Jul 2026 20:59:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE7B34C990;
	Fri,  3 Jul 2026 20:59:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783112388; cv=none; b=pYVm2MHUGzx5aHdLilDTb/LEC2xc7dkWXPw96x50uUp+4h0RcimtgkaJFie6NllVkasXRfNORdNJO4anbL+s9NVi1Ex3B5FgzlMA9KYWpHQs0Nis4KgjWzybPf1X+e+kAc6s2W0eAc+g/SWWXUVKzAKpPnZV3Zj0eDzw8TiSkDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783112388; c=relaxed/simple;
	bh=A71QVY+Cp7VPv9rgoww0UCOYY2oiORrWhqzvLtbx/QA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ji/YivWSD97JwQfHO8X/+kmLc2MLyW8kV/ZQeU1f/PlfEMGzAHR2RdU/N3BmZXak/RGK/+v+EHrRE7RM9u6ZXHloyhldX6uBV0eDQI0ASjQ0GafSSKtQpRqRKx/gJVyM3R5D8dWO309KtLUzHgK0NsDU8/QByKyVDNoLdfb3DnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZT3RHFk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07BB1F00A3A;
	Fri,  3 Jul 2026 20:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783112387;
	bh=BfuXr9H6YzXwCCCoYsHNuPnXbN+h+qaE0JpFIz1KEWY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=LZT3RHFkLAoICb90fWe4fd5+DpwaDwBeu3oubLyFoeYA/tjBqKAvU0Vn+/HMVK9FC
	 PvTPVl4vJaQ/z4hlmEwn0HGI3ha4RFqV/4eJqPepn9HdSS9OHNHJBEK0MSxHeBVFFL
	 GsjlsW1hPVw2f5PhghhCt4E174Jummhax93rC52X8TExjCft9zIpedJZyhGeIDHUcb
	 FvbUe1O8RXnvhXcbLvZDPkLtlVJSjPRKQ/JajZUtasGCXqsfqkmW8uVhBXXsUX8nzX
	 0SbQxsd+BxSxA1LLXLnIhlJ1q8Kieh1fqtL3mg8RTw68TBxPnElfTdWJIRgfl9CD02
	 gVEjY5f+C2+xw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B6F98F40068;
	Fri,  3 Jul 2026 16:59:45 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 03 Jul 2026 16:59:45 -0400
X-ME-Sender: <xms:wSJIaqNV3AAnjczM_nK2csD2znW6ZTXyfl_lKrX-Q6PSI27lE3mPwg>
    <xme:wSJIajy8k3qsxoFc1ZfNQcMcUHpGWI5M8hcDILBG1vTorRMKYWzDxXwQ72ku2a4xs
    qRvZW5RCrpDTfagHL5LsTLokGQbKsq2iLrrQ6p3lpD3eGi3IBApBB0>
X-ME-Proxy-Cause: dmFkZTGviJ5Hbr3mAoTh2jR51lHjouG5uW9woJzqrDUAqwMdE6q4pJyv591OBkQ2Il1u/f
    0SQunAdJI9bo1ZdYvLao9lfugXE0Vlyy2RoKurBBLsIrGT6IsT2ir3i2aYV37ua+bkS8z+
    rY+ndqjQBgi7dUl/pzILUeXPolqGOIFx7rYyx/SJLKaxs9vo/ZA0JD7nZE0qWutxBRaHzr
    PNBJ9+0+m4IT1cXkbylifxKxkVkJGJwKeZmW4+78qMUQBnVX3vbGWEQQG278Ajo2VEn2Pu
    ienTT+4Wl2SE8LkQG82cQfDE/9AmuodCJKok57JAI3b5rGdEunKCE0umlvTp9pTX852fdq
    Gp7pMc40/W4ofPEvHzpTFJ5ZYk0ZpLMN9LU7B09E9oP9Z3HUXZJIhueO/zcU8q1LddFJEp
    HAxw8x3o6diABNY1oUettvTymQUa9uUhViybPsWqIVrF6uJ4EC2ebR4gerqJZ5FiX6qdH5
    UG9x7RZIfkDH4nam0Qx5FLg5vV+AqYAbprsNu0zE6VX8b6uydmp4eeLD5hGbFH5wJOcXrV
    3zbotKw+aKs6y2/70bA3pejLVqDqJ7v6aNbk3BpwxaGinv0cm5r2W6ngltSNrUZZ9Z7SSq
    XA79gsxx0TX7xFStTV3sWx69b+D1k4g2f9ql8i8OJi5MdJLL/Ol5IZE39VVQ
X-ME-Proxy: <xmx:wSJIau9Dn1MrBwGpnmA2wFHlTKjtHJj9Wtq8BirWAdfxYr-xn-Ohvg>
    <xmx:wSJIahSH4MYlAWQBWN9Ln5Sa1vpWEladoqAEtcQRKxfrkjleuM9fAA>
    <xmx:wSJIanpQg8wlwyguSxDiL5b4_txplRLqtMt9fIMjUD2xYPDTCzdEIQ>
    <xmx:wSJIammVOxj_9ABQ8ah934yIYY6XkiW48YP7IznlR9M40moaDaaMzQ>
    <xmx:wSJIaocj5yVPMtwKPoM-K75jFvhc7DZ2tXOYGma7FHdND53VzORUFhbf>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 874CD780AB5; Fri,  3 Jul 2026 16:59:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVhOwI0RYJaZ
Date: Fri, 03 Jul 2026 16:59:25 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Wolfgang Walter" <linux@stwm.de>
Cc: stable@vger.kernel.org, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 patches@lists.linux.dev, "Jeff Layton" <jlayton@kernel.org>,
 "Alexandr Alexandrov" <alexandr.alexandrov@oracle.com>,
 yangerkun <yangerkun@huawei.com>, linux-nfs@vger.kernel.org
Message-Id: <ad301582-cb44-42cd-ab3f-c90f7c3dc11a@app.fastmail.com>
In-Reply-To: <3d80d1812ab903dbc831fef122d3cc75@stwm.de>
References: <20260703160306.1651327-1-cel@kernel.org>
 <3d80d1812ab903dbc831fef122d3cc75@stwm.de>
Subject: Re: 6.18.37 has problems with nfs4 (server), 6.18.36 works
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22980-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux@stwm.de,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jlayton@kernel.org,m:alexandr.alexandrov@oracle.com,m:yangerkun@huawei.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01FE3705A9A



On Fri, Jul 3, 2026, at 2:30 PM, Wolfgang Walter wrote:
> Hello Chuck,
>
> Am 2026-07-03 18:03, schrieb Chuck Lever:
>> Hi Wolfgang, and stable@ --
>> 
>> Short version for stable@: 6.18.37 does not need a revert of
>> 95f9eb19d5e6 ("Revert 'NFSD: Defer sub-object cleanup in export
>> put callbacks'").  That commit is correct for 6.18, and it is
>> not the cause of Wolfgang's crash.  Please leave it in place.
>
> Ok. I run v6.18.37 with the patch reverted since about a day (just for 
> the record). But according to your analysis, that's just a coincidence.
>
>> 
>> The reasoning: 95f9eb19d5e6 touches only fs/nfsd/export.c,
>> export.h, and nfsctl.c.  Wolfgang's oops is in
>> remove_blocked_locks() -> __destroy_client() ->
>> nfsd4_destroy_clientid(), entirely within fs/nfsd/nfs4state.c,
>> which the revert does not modify.  That path is byte-for-byte
>> identical across 6.18.36, 6.18.37, and current mainline, so the
>> revert cannot have introduced the bug and no missing backport
>> repairs it.  The 6.18.36-good / 6.18.37-bad split is a timing
>> coincidence; I believe the same latent bug is present in both.
>> 
>> Because the defect is present upstream as well, the fix belongs
>> in mainline first and is then backported to 6.18.y and the other
>> affected trees.
>> 
>> Wolfgang - to confirm this and capture the allocation and free
>> stacks, a KASAN-enabled kernel would settle it.  On a v6.18.37
>> tree:
>> 
>>   1. Add to your .config (keep your usual CONFIG_DEBUG_INFO so
>>      symbols resolve):
>> 
>>        CONFIG_KASAN=y
>>        CONFIG_KASAN_GENERIC=y
>>        CONFIG_KASAN_INLINE=y
>>        CONFIG_STACKTRACE=y
>> 
>>   2. Build and boot that kernel.  Stay on 6.18.37 -- you do not
>>      need the revert-the-revert build I suggested earlier; that
>>      experiment no longer tells us anything.
>> 
>>   3. When it trips, KASAN prints a "BUG: KASAN: use-after-free"
>>      report with "Allocated by" and "Freed by" call stacks.
>>      That report, in full, is what I need -- it should land in
>>      /var/log/messages just as the last oops did.
>> 
>> One caveat: KASAN roughly doubles memory use and adds CPU cost,
>> so weigh that before running it on the production server.  If
>> that is not practical, a full log from the first stall line
>> onward, with all CPU backtraces, captured over netconsole or
>> serial, is a useful second best.
>> 
>> I will draft a candidate upstream fix from the analysis so far
>> and send it separately.  If KASAN on the production box is not
>> an option, testing that patch may be the least disruptive way
>> to confirm.
>> 
>
> I think the memory usage should not be a problem, higher cpu usage 
> neither.
>
> But as it is a coincidence the probability to catch that error is 
> probably very low. We use v6.18 kernels since v6.18.1 on that fileserver 
> and this error never occured before.
>
> Or do you think it happens more often, but without symptoms, and KASAN 
> would detect it?
>
> So I will try running a v3.18.37 + your patch applied. This of course 
> can not prove that it fixes the problem because it almost never happens, 
> but probably this would detect if if the patch had side effects.

Correct: your reproduction of the crash does not appear to
be strongly correlated with any particular kernel release. I
based my analysis strictly on the additional stack trace data
you sent earlier today.

I think it's more likely that your 50 client workload hit a
particular race that exposed a pre-existing UAF. KASAN will
change execution timing, certainly, but I can't predict
whether it will make the race window bigger.

So you can only test whether my patch causes new regressions,
not whether it prevents your crasher. :-(


-- 
Chuck Lever

