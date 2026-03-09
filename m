Return-Path: <linux-nfs+bounces-19877-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDiAEsSwrmkSHwIAu9opvQ
	(envelope-from <linux-nfs+bounces-19877-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 12:36:36 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A46FF23800C
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 12:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CF46303A5C4
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2026 11:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCB421FF23;
	Mon,  9 Mar 2026 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2eKoRIA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B28347504
	for <linux-nfs@vger.kernel.org>; Mon,  9 Mar 2026 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056134; cv=none; b=UnwDUsruebX4YutFudY1ui0LQkgtJmYdsp+qpMCPRiQ9iiTOlwgkkTo6T8DKek3K/7wrQYI0A7A7SzEbac2Z0otvv/bIOFc5Gjxdr63hl5AMGAKdWZ1ttEfKM4mRGkSUTtziCJMxYwCenQ2JRCnTC8A4XrFtgdV4VEvvo0CmDPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056134; c=relaxed/simple;
	bh=ElAeZ7oU7QXMxtGAoDH6YPzDPJSUZeEcXVjZ1ePL8MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZpUtwk36SJQShokDbhXE1D5ugXWgi0xAGQfT/EjFT03VxvOZQvpffFGnDWOJ8A0J1qSZJsBwZ6a47dPOsdprXSCq6yZK18LcLYW+F6fq1BcNDqRlONLrctI1OPyi3fc++RtM4AUDCJuEIXCx3kzjVQbzxgRxMPTXgS3SppX7H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2eKoRIA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48540355459so2729965e9.3
        for <linux-nfs@vger.kernel.org>; Mon, 09 Mar 2026 04:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773056130; x=1773660930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FqNAhn11Xh7FzklS7fF5yJqQsvr76T5xJYaiWOCrw98=;
        b=C2eKoRIAeFQuL639a4knn+zO8iYZxiqPumMGD6tZsAvakHSQTq6e36Ydv9Lz2a42bH
         qChACUBD+8ID9+j0R+2ExFNcMY6W1tL1HZB7kwgEWPeCewN5cPWUO4y5VHOT69VS9w4B
         wTfDUDXMHaFCcJS3f3DHLx/4Q3mhxm+CF5I5dfaXkdQyomjku/ki1oUwHmu/xN8U0gYg
         oNN5lxljidEIsabU5YXBrnAV2zI+SQrYYt6Z45a6Vpy+gHmAkqiAYNAdPcAUjEpC5nWg
         AvWOmx8YPumYttXtEQmwfh9yv6Wu4AfTQKrNTN9LLx3HQ2n7Vcvr+e813DhRnKAOkDKt
         0YBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773056130; x=1773660930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqNAhn11Xh7FzklS7fF5yJqQsvr76T5xJYaiWOCrw98=;
        b=Z1OdQMQKCDKqCmwy5f11fCZOPhuslrpa7PNB8x6OkVec2/iZ+fdRNUB1Z64YIGLM6A
         mTqs2bpx1IwChr1UPyEPG3SAa63jA3Ffp3o4rSj7jPMUMC/wy+ls+Br/UN5+l5Yqmb+N
         gc5dvQMX1nMCGDtY5VsBGTnOlf8u7IheBdwqBKW2AtaoCvNucdyUalb0iFmjA3caGeht
         6L+A8A8iZfNFasVfy7yXq8YaCQWzblkZ+i8PVU3h3ozrrafubQH4s6U0kSqH/m1qUNdh
         BhdNPDwoHvlC5mcXGed2sfxkGEmv8rhh9yRICrE/rlezFGqNoBWT3kD5RsSS6YcDz6LW
         2cBg==
X-Gm-Message-State: AOJu0YySLTrQumGeQBxe9jQmPttDTWvb3HCTxYds4MgwOM4cs/qVBvkj
	K1ukc96MU4izGqT/qDrHRxykLvLu2I24PG4jea8I+5tUzn3zb+EPk9JdRDL7ag==
X-Gm-Gg: ATEYQzyVYRNGV7qKG+5vFw7tLOfcgoeWjN93ZXMHVPIJUwIGY25HIFe767skOEcON2F
	T8SIrtG1W9LiBh3FtnJI+Jp+VN9xOnUp5hm2bO6XDWrM3RCm0OPVX5d0cTtDHh2m63NBD4FpE4i
	yNtHjtF3jfac8WG2flIcmv4H9WOM3C0+p6estYw/SrAdFfR4X2nQduhdDKiIq1By28KDgEiFE7Y
	yEXcO0IApZ26MgDHVmKEfGlbptl9M4lJ4vcI9FCjcBOQYDgTyZWjsxRFfxHsK53UR0bABbFPG2j
	VQHARIP1rnjtWgCmUUAS8XrfkbL72brtheEWDaTSYfNZTq/8TKcVU0Eu6pfLLW5f2wXn5plyHc1
	r3FK3BKxj6EPKk4wBbrZoV0BaGO7GW7NBlPeJqPEuMSmX1sQsAQ60oxpmdBDZavftNRHdwxZSYl
	cradZrp1T9sQroC12ZmRdJiPXlXb1fgqTJBcT6QpsOCN2c0g900q9ReMATKARcZVR2LbhIgYKjX
	1WTHG6XZUk=
X-Received: by 2002:a05:600c:3492:b0:485:3e19:9e01 with SMTP id 5b1f17b1804b1-4853e19a14cmr27263535e9.28.1773056129341;
        Mon, 09 Mar 2026 04:35:29 -0700 (PDT)
Received: from [192.168.0.125] (cdmjno2.plus.com. [31.125.38.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852378de92sm131846435e9.0.2026.03.09.04.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 04:35:28 -0700 (PDT)
Message-ID: <73c13ef8-8191-45e1-a110-2392feff96a4@gmail.com>
Date: Mon, 9 Mar 2026 11:35:27 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fscache/NFS re-export server lockup
To: linux-nfs@vger.kernel.org, netfs@lists.linux.dev
Cc: Daire Byrne <daire@dneg.com>, dhowells@redhat.com,
 trondmy@hammerspace.com, okorniev@redhat.com,
 Mike Snitzer <snitzer@kernel.org>
References: <CADFF-zeNJUPLaVcogSBt=s4+o2Lty45-DueSYKJmCgZw6hraEg@mail.gmail.com>
 <CAPt2mGOV+ZxVLkFFXRKX3Cr9vZ-pd=5QeN=cxwc_msGFtpPN=Q@mail.gmail.com>
 <CADFF-zcFgycZ7c0KC_5eUafjvba_ZxhzED0a7yDR4oip4_KxbA@mail.gmail.com>
 <aWIgdDImfFg6fgxn@kernel.org>
 <CADFF-zf1qypwRDYkCPH9MFVLoPgsJxsNXZ7-qEbiMLo-L3Ldsg@mail.gmail.com>
 <c6dc98cc-df27-4a37-9b15-c4543e199ad0@gmail.com>
 <aWlh7XAoR0NENXNo@kernel.org>
Content-Language: en-US
From: Mike Owen <mjnowen@gmail.com>
In-Reply-To: <aWlh7XAoR0NENXNo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A46FF23800C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-19877-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjnowen@gmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.883];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-nfs.org:url]
X-Rspamd-Action: no action

For anyone following this thread, the solution was a broad set of parameter tuning (mkfs/mount options, block device tuning, and VM sysctls) combined with switching from EXT4 to XFS.
Some sizeable performance jumps were gained as well across the stack. No issue with FS-Cache here as previously implied.
Thanks to those who provided feedback.
-Mike

On 15/01/2026 21:53, Mike Snitzer wrote:
> On Thu, Jan 15, 2026 at 03:20:24PM +0000, Mike Owen wrote:
>> Hi Mike S,
>>
>> On 12/01/2026 15:16, Mike Owen wrote:
>>> Ah, this looks promising. Thanks for the info, Mike!
>>> Whilst we wait for the necessary NFS client fixes PR, I'll look to add
>>> the patch to 6.19-rc5 and report back if this fixes the issue we are
>>> seeing.
>>> I'll see what I can do internally to advocate Canonical absorbing it as well.
>>> ACK on my log wrapping. My bad.
>>> Thanks again!
>>> -Mike
>>>
>>> On Sat, 10 Jan 2026 at 09:48, Mike Snitzer <snitzer@kernel.org> wrote:
>>>>
>>>> Hi Mike,
>>>>
>>>> On Fri, Jan 09, 2026 at 09:45:47PM +0000, Mike Owen wrote:
>>>>> Hi Daire, thanks for the comments.
>>>>>
>>>>>> Can you stop the nfs server and is access to /var/cache/fscache still blocked?
>>>>> As the machine is deadlocked, after reboot (so the nfs server is
>>>>> definitely stopped), the actual data is gone/corrupted.
>>>>>
>>>>>> And I presume there is definitely nothing else that might be
>>>>> interacting with that /var/cache/fscache filesystem outside of fscache
>>>>> or cachefilesd?
>>>>> Correct. Machine is dedicated to KNFSD caching duties.
>>>>>
>>>>>> Our /etc/cachefilesd.conf is pretty basic (brun 30%, bcull 10%, bstop 3%).
>>>>> Similar settings here:
>>>>> brun 20%
>>>>> bcull 7%
>>>>> bstop 3%
>>>>> frun 20%
>>>>> fcull 7%
>>>>> fstop 3%
>>>>> Although I should note that the issue happens when only ~10-20% of the
>>>>> NVMe capacity is used, so culling has never had to run at this point.
>>>>>
>>>>> We did try running 6.17.0 but made no difference. I see another thread
>>>>> of yours with Chuck: "refcount_t underflow (nfsd4_sequence_done?) with
>>>>> v6.18 re-export"
>>>>> and suggested commits to investigate, incl: cbfd91d22776 ("nfsd: never
>>>>> defer requests during idmap lookup") as well as try using 6.18.4, so
>>>>> it's possible there is a cascading issue here and we are in need of
>>>>> some NFS patches.
>>>>>
>>>>> I'm hoping @dhowells might have some suggestions on how to further
>>>>> debug this issue, given the below stack we are seeing when it
>>>>> deadlocks?
>>>>>
>>>>> Thanks,
>>>>> -Mike
>>>>
>>>> This commit from Trond, which he'll be sending to Linus soon as part
>>>> of his 6.19-rc NFS client fixes pull request, should fix the NFS
>>>> re-export induced nfs_release_folio deadlock reflected in your below
>>>> stack trace:
>>>> https://git.linux-nfs.org/?p=trondmy/linux-nfs.git;a=commitdiff;h=cce0be6eb4971456b703aaeafd571650d314bcca
>>>>
>>>> Here is more context for why I know that to be likely, it fixed my
>>>> nasty LOCALIO-based reexport deadlock situation too:
>>>> https://lore.kernel.org/linux-nfs/20260107160858.6847-1-snitzer@kernel.org/
>>>>
>>>> I'm doing my part to advocate that Red Hat (Olga cc'd) take this
>>>> fix into RHEL 10.2 (and backport as needed).
>>>>
>>>> Good luck getting Ubuntu to include this fix in a timely manner (we'll
>>>> all thank you for that if you can help shake the Canonical tree).
>>>>
>>>> BTW, you'd do well to fix your editor/email so that it doesn't line
>>>> wrap when you share logs on Linux mailing lists:
>>>>
>> ...
>>
>> We deployed 6.19-rc5 + kernel patch: "NFS: Fix a deadlock involving nfs_release_folio()" but unfortunately this has not fixed the issue. The KNFSD server becomes wedged (as far as NFSD is concerned, can still login) and we get the attached dmesg log. I attempted an analysis/RCA of this circular dependency/deadlock issue to try and assist getting this resolved (see attached). Any other patches to try?
>> -Mike
> 
>> [Thu Jan 15 10:37:38 2026] md127: array will not be assembled in old kernels that lack configurable LBS support (<= 6.18)
>> [Thu Jan 15 10:37:38 2026] md127: detected capacity change from 0 to 29296345088
>> [Thu Jan 15 10:38:46 2026] EXT4-fs (md127): mounted filesystem cc12ea7f-34f9-445a-b8ad-a9f1a122c51d r/w with ordered data mode. Quota mode: none.
>> [Thu Jan 15 10:38:46 2026] netfs: FS-Cache loaded
>> [Thu Jan 15 10:38:46 2026] CacheFiles: Loaded
>> [Thu Jan 15 10:38:46 2026] netfs: Cache "mycache" added (type cachefiles)
>> [Thu Jan 15 10:38:46 2026] CacheFiles: File cache on mycache registered
>> [Thu Jan 15 10:39:07 2026] NFSD: Using nfsdcld client tracking operations.
>> [Thu Jan 15 10:39:07 2026] NFSD: no clients to reclaim, skipping NFSv4 grace period (net effffff9)
>> [Thu Jan 15 10:39:28 2026] audit: type=1400 audit(1768473568.836:130): apparmor="STATUS" operation="profile_replace" info="same as current profile, skipping" profile="unconfined" name="rsyslogd" pid=8112 comm="apparmor_parser"
>> [Thu Jan 15 10:40:39 2026] hrtimer: interrupt took 10300 ns
>> [Thu Jan 15 10:42:35 2026] loop4: detected capacity change from 0 to 98480
>> [Thu Jan 15 10:42:35 2026] audit: type=1400 audit(1768473755.481:131): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/snap/snapd/25935/usr/lib/snapd/snap-confine" pid=9736 comm="apparmor_parser"
>> [Thu Jan 15 10:42:35 2026] audit: type=1400 audit(1768473755.482:132): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/snap/snapd/25935/usr/lib/snapd/snap-confine//mount-namespace-capture-helper" pid=9736 comm="apparmor_parser"
>> [Thu Jan 15 10:42:40 2026] loop5: detected capacity change from 0 to 8
>> [Thu Jan 15 10:42:40 2026] audit: type=1400 audit(1768473760.184:133): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="/snap/snapd/25935/usr/lib/snapd/snap-confine" pid=10068 comm="apparmor_parser"
>> [Thu Jan 15 10:42:40 2026] audit: type=1400 audit(1768473760.194:134): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="/snap/snapd/25935/usr/lib/snapd/snap-confine//mount-namespace-capture-helper" pid=10068 comm="apparmor_parser"
>> [Thu Jan 15 10:42:40 2026] audit: type=1400 audit(1768473760.201:135): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="snap.amazon-ssm-agent.amazon-ssm-agent" pid=10071 comm="apparmor_parser"
>> [Thu Jan 15 10:42:40 2026] audit: type=1400 audit(1768473760.201:136): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="snap.amazon-ssm-agent.ssm-cli" pid=10072 comm="apparmor_parser"
>> [Thu Jan 15 10:42:40 2026] audit: type=1400 audit(1768473760.207:137): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="snap-update-ns.amazon-ssm-agent" pid=10070 comm="apparmor_parser"
>> [Thu Jan 15 11:59:09 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
>> [Thu Jan 15 11:59:09 2026] netfs: O-cookie c=0000df95 [fl=6124 na=1 nA=2 s=L]
>> [Thu Jan 15 11:59:09 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
>> [Thu Jan 15 11:59:09 2026] netfs: O-key=[32] 'f360d67b060000003414386507000000ffffffff000000000200c10901000000'
>> [Thu Jan 15 11:59:10 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
>> [Thu Jan 15 11:59:10 2026] netfs: O-cookie c=0000e07f [fl=6124 na=1 nA=2 s=L]
>> [Thu Jan 15 11:59:10 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
>> [Thu Jan 15 11:59:10 2026] netfs: O-key=[32] 'f360d67b0600000020301c6207000000ffffffff000000000200c10901000000'
>> [Thu Jan 15 11:59:10 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
>> [Thu Jan 15 11:59:10 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
>> [Thu Jan 15 11:59:10 2026] netfs: O-cookie c=0000e1a1 [fl=6124 na=1 nA=2 s=L]
>> [Thu Jan 15 11:59:10 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
>> [Thu Jan 15 11:59:10 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
>> [Thu Jan 15 11:59:10 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
>> [Thu Jan 15 11:59:10 2026] netfs: O-cookie c=0000e01c [fl=6124 na=1 nA=2 s=L]
>> [Thu Jan 15 11:59:10 2026] netfs: O-cookie c=0000e14d [fl=6124 na=1 nA=2 s=L]
>> [Thu Jan 15 11:59:10 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
>> [Thu Jan 15 11:59:10 2026] netfs: O-key=[32] 'f360d67b0600000071149ebc06000000ffffffff000000000200c10901000000'
>> [Thu Jan 15 11:59:10 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
>> [Thu Jan 15 11:59:10 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
>> [Thu Jan 15 11:59:10 2026] netfs: O-cookie c=0000b381 [fl=6124 na=1 nA=2 s=L]
>> [Thu Jan 15 11:59:10 2026] netfs: O-key=[32] 'f360d67b06000000bfd9ce3407000000ffffffff000000000200c10901000000'
>> [Thu Jan 15 11:59:10 2026] netfs: O-cookie c=0000df8c [fl=6124 na=1 nA=2 s=L]
>> [Thu Jan 15 11:59:10 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
>> [Thu Jan 15 11:59:10 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
>> [Thu Jan 15 11:59:10 2026] netfs: O-key=[32] 'f360d67b060000006b7a9b3a07000000ffffffff000000000200c10901000000'
>> [Thu Jan 15 11:59:10 2026] netfs: O-key=[32] 'f360d67b06000000317d6c3207000000ffffffff000000000200c10901000000'
>> [Thu Jan 15 11:59:10 2026] netfs: O-cookie c=0000dbbc [fl=6124 na=1 nA=2 s=L]
>> [Thu Jan 15 11:59:10 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
>> [Thu Jan 15 11:59:10 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
>> [Thu Jan 15 11:59:10 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
>> [Thu Jan 15 11:59:10 2026] netfs: O-cookie c=0000b2c0 [fl=6124 na=1 nA=2 s=L]
>> [Thu Jan 15 11:59:10 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
>> [Thu Jan 15 11:59:10 2026] netfs: O-key=[32] 'f360d67b0600000038c7f06f06000000ffffffff000000000200c10901000000'
>> [Thu Jan 15 11:59:10 2026] netfs: O-key=[32] 'f360d67b06000000e1483c3807000000ffffffff000000000200c10901000000'
>> [Thu Jan 15 11:59:10 2026] netfs: O-key=[32] 'f360d67b06000000e811572e07000000ffffffff000000000200c10901000000'
>> [Thu Jan 15 11:59:11 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
>> [Thu Jan 15 11:59:11 2026] netfs: O-cookie c=0000dc24 [fl=6124 na=1 nA=2 s=L]
>> [Thu Jan 15 11:59:11 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
>> [Thu Jan 15 11:59:11 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
>> [Thu Jan 15 11:59:11 2026] netfs: O-cookie c=0000c542 [fl=6124 na=1 nA=2 s=L]
>> [Thu Jan 15 11:59:11 2026] netfs: O-key=[32] 'f360d67b06000000af19d78706000000ffffffff000000000200c10901000000'
>> [Thu Jan 15 11:59:11 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
>> [Thu Jan 15 11:59:11 2026] netfs: O-key=[32] 'f360d67b060000003d594c7508000000ffffffff000000000200c10901000000'
>> [Thu Jan 15 11:59:11 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
>> [Thu Jan 15 11:59:11 2026] netfs: O-cookie c=0000cea9 [fl=6124 na=1 nA=2 s=L]
>> [Thu Jan 15 11:59:11 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
>> [Thu Jan 15 11:59:11 2026] netfs: O-key=[32] 'f360d67b0600000016b7ae5907000000ffffffff000000000200c10901000000'
>> [Thu Jan 15 12:01:08 2026] INFO: task kcompactd0:170 blocked for more than 122 seconds.
>> [Thu Jan 15 12:01:08 2026]       Tainted: G           OE       6.19.0-rc5-knfsd #1
>> [Thu Jan 15 12:01:08 2026] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [Thu Jan 15 12:01:08 2026] task:kcompactd0      state:D stack:0     pid:170   tgid:170   ppid:2      task_flags:0x210040 flags:0x00080000
>> [Thu Jan 15 12:01:08 2026] Call Trace:
>> [Thu Jan 15 12:01:08 2026]  <TASK>
>> [Thu Jan 15 12:01:08 2026]  __schedule+0x481/0x17d0
>> [Thu Jan 15 12:01:08 2026]  ? __pfx_radix_tree_node_ctor+0x10/0x10
>> [Thu Jan 15 12:01:08 2026]  ? cgroup_writeback_by_id+0x4b/0x200
>> [Thu Jan 15 12:01:08 2026]  ? xas_store+0x5b/0x7f0
>> [Thu Jan 15 12:01:08 2026]  schedule+0x20/0xe0
>> [Thu Jan 15 12:01:08 2026]  io_schedule+0x4c/0x80
>> [Thu Jan 15 12:01:08 2026]  folio_wait_bit_common+0x133/0x310
>> [Thu Jan 15 12:01:08 2026]  ? __pfx_wake_page_function+0x10/0x10
>> [Thu Jan 15 12:01:08 2026]  folio_wait_private_2+0x2c/0x60
>> [Thu Jan 15 12:01:08 2026]  nfs_release_folio+0x61/0x130 [nfs]
>> [Thu Jan 15 12:01:08 2026]  filemap_release_folio+0x68/0xa0
>> [Thu Jan 15 12:01:08 2026]  __folio_split+0x178/0x8e0
>> [Thu Jan 15 12:01:08 2026]  ? post_alloc_hook+0xc1/0x140
>> [Thu Jan 15 12:01:08 2026]  __split_huge_page_to_list_to_order+0x2b/0xb0
>> [Thu Jan 15 12:01:08 2026]  split_folio_to_list+0x10/0x20
>> [Thu Jan 15 12:01:08 2026]  migrate_pages_batch+0x45d/0xea0
>> [Thu Jan 15 12:01:08 2026]  ? __pfx_compaction_alloc+0x10/0x10
>> [Thu Jan 15 12:01:08 2026]  ? __pfx_compaction_free+0x10/0x10
>> [Thu Jan 15 12:01:08 2026]  ? asm_exc_xen_unknown_trap+0x1/0x20
>> [Thu Jan 15 12:01:08 2026]  ? __pfx_compaction_free+0x10/0x10
>> [Thu Jan 15 12:01:08 2026]  migrate_pages+0xaef/0xd80
>> [Thu Jan 15 12:01:08 2026]  ? __pfx_compaction_free+0x10/0x10
>> [Thu Jan 15 12:01:08 2026]  ? __pfx_compaction_alloc+0x10/0x10
>> [Thu Jan 15 12:01:08 2026]  compact_zone+0xb3f/0x1200
>> [Thu Jan 15 12:01:08 2026]  ? psi_group_change+0x1f8/0x4c0
>> [Thu Jan 15 12:01:08 2026]  ? kvm_sched_clock_read+0x11/0x20
>> [Thu Jan 15 12:01:08 2026]  compact_node+0xaf/0x130
>> [Thu Jan 15 12:01:08 2026]  kcompactd+0x374/0x4d0
>> [Thu Jan 15 12:01:08 2026]  ? __pfx_autoremove_wake_function+0x10/0x10
>> [Thu Jan 15 12:01:08 2026]  ? __pfx_kcompactd+0x10/0x10
>> [Thu Jan 15 12:01:08 2026]  kthread+0xf9/0x210
>> [Thu Jan 15 12:01:08 2026]  ? __pfx_kthread+0x10/0x10
>> [Thu Jan 15 12:01:08 2026]  ret_from_fork+0x25c/0x290
>> [Thu Jan 15 12:01:08 2026]  ? __pfx_kthread+0x10/0x10
>> [Thu Jan 15 12:01:08 2026]  ret_from_fork_asm+0x1a/0x30
>> [Thu Jan 15 12:01:08 2026]  </TASK>
> 
> OK, my deadlock was blocked in wait_on_commit whereas you've
> consistently shown folio_wait_private_2 in your stack traces (I
> originally missed that detail).  So I'm not aware of what is different
> in your setup.. devil is in the details, but maybe its your use of
> fscache?
> 
>> # Analysis of KNFSD/CacheFiles Deadlock
>>
>> This document provides an analysis of a deadlock issue observed on Ubuntu 24.04 KNFSD nodes
>> running a custom Linux kernel 6.19-rc5. The deadlock involves the NFS server (nfsd),
>> CacheFiles/netfs layer, ext4 journaling, and memory compaction.
>>
>> ## Summary
>>
>> The system enters a deadlock state where:
>>
>> 1. Multiple **nfsd threads** are blocked waiting for ext4 inode rw-semaphores
>> 2. Those rw-semaphores are held by **kworker threads** (writers)
>> 3. The **jbd2 journal thread** for the cache filesystem is blocked waiting for updates
>> 4. **kcompactd** (memory compaction) is blocked waiting for an NFS folio to release fscache state
>> 5. The **fscache cookie state machine** is timing out
> 
> David Howells may be able to inform his fscache-specific vantage point
> by having a look at Trond's fix that I pointed to earlier?
> 
> Mike
> 
> ps. solid effort with your below analysis, but its quite fscache
> specific so I think it'll best help inform David:
> 
>>
>> ## Environment
>>
>> - **Kernel**: Linux 6.19.0-rc5-knfsd (custom build)
>> - **Platform**: Amazon EC2 (24 CPUs, 192GB RAM)
>> - **Configuration**: 256 nfsd threads
>> - **Cache Filesystem**: ext4 on md127 RAID array
>>
>> ## Detailed Breakdown
>>
>> ### 1. Initial Symptom: Cookie State Timeouts (11:59:09)
>>
>> The first warning signs appear as fscache cookie state timeout errors:
>>
>> ```text
>> netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
>> ```
>>
>> These errors indicate that fscache operations are waiting for cookies to transition to the
>> correct state (`FSCACHE_COOKIE_STATE_ACTIVE`), but the state transitions are stalled.
>>
>> ### 2. The Deadlock Chain (12:01:08)
>>
>> #### kcompactd0 (memory compaction daemon)
>>
>> ```text
>> folio_wait_private_2+0x2c/0x60
>> nfs_release_folio+0x61/0x130 [nfs]
>> filemap_release_folio+0x68/0xa0
>> __folio_split+0x178/0x8e0
>> ```
>>
>> The compaction daemon is trying to migrate/split NFS folios but is blocked in
>> `folio_wait_private_2()`. This waits for the `PG_fscache` flag to clear, which happens when
>> fscache completes its I/O operations on the folio. However, fscache operations are stuck.
>>
>> #### jbd2/md127-8 (ext4 journal for cache filesystem)
>>
>> ```text
>> jbd2_journal_wait_updates+0x6e/0xe0
>> jbd2_journal_commit_transaction+0x26e/0x1730
>> ```
>>
>> The journal commit is waiting for outstanding updates to complete, but those updates are
>> blocked.
>>
>> #### nfsd threads (multiple patterns)
>>
>> **Pattern A** - Blocked on ext4 inode rwsem:
>>
>> ```text
>> rwsem_down_read_slowpath+0x278/0x500
>> down_read+0x41/0xb0
>> ext4_llseek+0xfc/0x120            <-- needs inode->i_rwsem for SEEK_DATA/SEEK_HOLE
>> vfs_llseek+0x1c/0x40
>> cachefiles_do_prepare_read        <-- checking what's cached
>> ```
>>
>> The kernel logs explicitly identify the blocking relationship:
>>
>> - `nfsd:7300 <reader> blocked on an rw-semaphore likely owned by task kworker/u96:8:37820 <writer>`
>>
>> **Pattern B** - Blocked on jbd2 transaction:
>>
>> ```text
>> wait_transaction_locked+0x87/0xd0
>> add_transaction_credits+0x1e0/0x360
>> jbd2__journal_start
>> ext4_dirty_inode                  <-- updating atime on cache file
>> cachefiles_read
>> ```
>>
>> ### 3. The Circular Dependency
>>
>> ```text
>>   nfsd read request
>>        │
>>        ▼
>>   nfs_readahead → netfs_readahead → cachefiles_prepare_read
>>        │
>>        ▼
>>   ext4_llseek (needs i_rwsem READ lock)
>>        │
>>        ▼
>>   BLOCKED: kworkers hold i_rwsem as WRITER
>>        │
>>        ├─────────────────────────────────────────────┐
>>        │                                             │
>>        ▼                                             ▼
>>   Those kworkers are likely doing              jbd2 waiting for
>>   cachefiles write operations                  updates to complete
>>        │                                             │
>>        ▼                                             │
>>   Waiting for journal                                │
>>        │                                             │
>>        └──────────────────►◄─────────────────────────┘
>>                            │
>>                            ▼
>>                     Memory pressure triggers
>>                     kcompactd which needs to
>>                     release NFS folios
>>                            │
>>                            ▼
>>                     nfs_release_folio waits for
>>                     fscache (PG_fscache/private_2)
>>                            │
>>                            ▼
>>                     fscache operations are stuck
>>                     waiting for the blocked operations above
>> ```
>>
>> ## Root Cause Analysis
>>
>> 1. **ext4_llseek holding i_rwsem**: When CacheFiles uses `SEEK_DATA`/`SEEK_HOLE` to check
>>    what's cached, it takes the inode's rw-semaphore. If writers (kworkers doing cache writes)
>>    hold this semaphore, readers (the prepare_read path) block.
>>
>> 2. **Journal contention**: The ext4 journal on the cache filesystem (md127) is under heavy
>>    load. With 256 nfsd threads all potentially doing cache operations, journal contention
>>    is severe.
>>
>> 3. **Memory pressure + folio release**: When memory compaction tries to free NFS folios that
>>    have active fscache state, it must wait for fscache to complete—but fscache is blocked
>>    on ext4.
>>
>> 4. **Cookie state machine stalls**: The fscache cookie state transitions are blocked because
>>    the underlying I/O can't complete, leading to the timeout messages.
> 


