Return-Path: <linux-nfs+bounces-22979-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HWy2EIYASGoXjAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22979-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 20:33:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84053704F47
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 20:33:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=stwm.de header.s=stwm-20170627 header.b=GfBLVgtz;
	dmarc=pass (policy=quarantine) header.from=stwm.de;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22979-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22979-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B314300229C
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jul 2026 18:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD652D63F8;
	Fri,  3 Jul 2026 18:30:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from email.studentenwerk.mhn.de (email.studentenwerk.mhn.de [141.84.225.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C839E211A09;
	Fri,  3 Jul 2026 18:30:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783103449; cv=none; b=ijSI3rnU/nJv+Rds5Npjd8XLfZUqfi0Gw2k5B4fqbw1dYC6KC/BxinmG6xeslOhHnxZ3o6d3BGpvMZI1StF1DesVZAf9sS2aZvQej81tjwXLepW6294OVdGZoAN5JroLiN1ir2g/kbNx6DMS/GbQbMNas/BOoWAkDVKsuaSzMWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783103449; c=relaxed/simple;
	bh=RV15ipwq4miWMw1ZfmGmZ1dsn7YXEXkRZbYMy4iRgws=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=f56MLDXPIh4FHrqtcRhrXo3xD9hZhWbYT28ENPj7UFP59qwZYoYOJ7nhtvFOHy6FqTvqBSefnFKByYA5ckZJedDxbozvPY4x+npS4ZHpXFGq5vY3gtIOlmVpFwKPe2ttGgOdCd88kNzH9ufVgtXPCVu6oYQAG2U7EpR2vdMsjM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de; spf=pass smtp.mailfrom=stwm.de; dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b=GfBLVgtz; arc=none smtp.client-ip=141.84.225.229
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
	by email.studentenwerk.mhn.de (Postfix) with ESMTPS id 4gsMkk21T7zRhRJ;
	Fri, 03 Jul 2026 20:30:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de; s=stwm-20170627;
	t=1783103438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94lQu3GW61jSH6v3zV2ia73X9muvR3oPlZ7JCXSRD+k=;
	b=GfBLVgtzh+2/DMkEt0bb4GGDzWl7g/acjN5Qg3lVkV+CV3Dx9AsSZcURLZfaW05XNp+W5F
	zek90wpI1tDgt6M8fzt/T+M8hOVRFHPDSGP/VNnijBq7oHCmVbpBDFqxEepLlMd/YdznfI
	++6MTTIrU979JG07H1IJnfrTHcuyCfHP5nesknClhSSehogi+aP7WGBBg37fRCFgvkxyee
	gtuf6Gi/4YUZOCzAVVvtW0ddbXF/3do82b7gh5ZIky7+svoEAG842Elp/X+n6Rfw7t5nGy
	RDP5ZPg4vetkV5kZ54/ZmQ0qHxIxveQOns0hG3wtEjxZ9/POfw+eQlOHBlE8xA==
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 03 Jul 2026 20:30:38 +0200
From: Wolfgang Walter <linux@stwm.de>
To: Chuck Lever <cel@kernel.org>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 patches@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, Alexandr
 Alexandrov <alexandr.alexandrov@oracle.com>, Yang Erkun
 <yangerkun@huawei.com>, linux-nfs@vger.kernel.org
Subject: Re: 6.18.37 has problems with nfs4 (server), 6.18.36 works
In-Reply-To: <20260703160306.1651327-1-cel@kernel.org>
References: <20260703160306.1651327-1-cel@kernel.org>
Message-ID: <3d80d1812ab903dbc831fef122d3cc75@stwm.de>
X-Sender: linux@stwm.de
Organization: =?UTF-8?Q?Studierendenwerk_M=C3=BCnchen_Oberbayern?=
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[stwm.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[stwm.de:s=stwm-20170627];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22979-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jlayton@kernel.org,m:alexandr.alexandrov@oracle.com,m:yangerkun@huawei.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[linux@stwm.de,linux-nfs@vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[stwm.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@stwm.de,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84053704F47

Hello Chuck,

Am 2026-07-03 18:03, schrieb Chuck Lever:
> Hi Wolfgang, and stable@ --
> 
> Short version for stable@: 6.18.37 does not need a revert of
> 95f9eb19d5e6 ("Revert 'NFSD: Defer sub-object cleanup in export
> put callbacks'").  That commit is correct for 6.18, and it is
> not the cause of Wolfgang's crash.  Please leave it in place.

Ok. I run v6.18.37 with the patch reverted since about a day (just for 
the record). But according to your analysis, that's just a coincidence.

> 
> The reasoning: 95f9eb19d5e6 touches only fs/nfsd/export.c,
> export.h, and nfsctl.c.  Wolfgang's oops is in
> remove_blocked_locks() -> __destroy_client() ->
> nfsd4_destroy_clientid(), entirely within fs/nfsd/nfs4state.c,
> which the revert does not modify.  That path is byte-for-byte
> identical across 6.18.36, 6.18.37, and current mainline, so the
> revert cannot have introduced the bug and no missing backport
> repairs it.  The 6.18.36-good / 6.18.37-bad split is a timing
> coincidence; I believe the same latent bug is present in both.
> 
> Because the defect is present upstream as well, the fix belongs
> in mainline first and is then backported to 6.18.y and the other
> affected trees.
> 
> Wolfgang - to confirm this and capture the allocation and free
> stacks, a KASAN-enabled kernel would settle it.  On a v6.18.37
> tree:
> 
>   1. Add to your .config (keep your usual CONFIG_DEBUG_INFO so
>      symbols resolve):
> 
>        CONFIG_KASAN=y
>        CONFIG_KASAN_GENERIC=y
>        CONFIG_KASAN_INLINE=y
>        CONFIG_STACKTRACE=y
> 
>   2. Build and boot that kernel.  Stay on 6.18.37 -- you do not
>      need the revert-the-revert build I suggested earlier; that
>      experiment no longer tells us anything.
> 
>   3. When it trips, KASAN prints a "BUG: KASAN: use-after-free"
>      report with "Allocated by" and "Freed by" call stacks.
>      That report, in full, is what I need -- it should land in
>      /var/log/messages just as the last oops did.
> 
> One caveat: KASAN roughly doubles memory use and adds CPU cost,
> so weigh that before running it on the production server.  If
> that is not practical, a full log from the first stall line
> onward, with all CPU backtraces, captured over netconsole or
> serial, is a useful second best.
> 
> I will draft a candidate upstream fix from the analysis so far
> and send it separately.  If KASAN on the production box is not
> an option, testing that patch may be the least disruptive way
> to confirm.
> 

I think the memory usage should not be a problem, higher cpu usage 
neither.

But as it is a coincidence the probability to catch that error is 
probably very low. We use v6.18 kernels since v6.18.1 on that fileserver 
and this error never occured before.

Or do you think it happens more often, but without symptoms, and KASAN 
would detect it?

So I will try running a v3.18.37 + your patch applied. This of course 
can not prove that it fixes the problem because it almost never happens, 
but probably this would detect if if the patch had side effects.

Regards,
-- 
Wolfgang Walter
Studierendenwerk München Oberbayern
Anstalt des öffentlichen Rechts

