Return-Path: <linux-nfs+bounces-22783-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QcecBB6GOmoD/AcAu9opvQ
	(envelope-from <linux-nfs+bounces-22783-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 15:11:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2BC6B7583
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 15:11:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nowheycreamery.com header.s=fm2 header.b=Bgu2vsNs;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="Z w4/pDE";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22783-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22783-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B76AE3075012
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 13:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23C02DC79F;
	Tue, 23 Jun 2026 13:11:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4DD242D89
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2026 13:11:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782220309; cv=none; b=HAaQzchaoXVzW6LtF+rQyC+O/TTUT0lqBiudm5tZoRrv0WdAXlQ+PwhVQpL1ONxaCfJNJtBXNP8ZzzRCEOLOcEleRTy7yJ73hEq7mFCCrDsLJQIkuwBM7iZPLhw2lDzxRMduwo0gNhDDmXyH0wSUsMxm+vYDoTqZAH1DPHCp/7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782220309; c=relaxed/simple;
	bh=omYo2/FW6rLu5TSqOWPvM6yXP8ZzIIbAWJt0W6MjR6s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MEkgbUpIv83q2/yZJFRiqCc+C70WKQxcvk0HoSqggZpWwmRo/JDQl8vSBNHg9PhzB6+lYbKFza/jo8OemYqEPj3R6BOL7NQ422zQ2OkNX+KQcs609Aeq0FvGs62Prq7UAvcySJwa2rY2E+05VBh9odX6vQW1ZWn3W/r+jADeT1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nowheycreamery.com; spf=pass smtp.mailfrom=nowheycreamery.com; dkim=pass (2048-bit key) header.d=nowheycreamery.com header.i=@nowheycreamery.com header.b=Bgu2vsNs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zw4/pDEX; arc=none smtp.client-ip=103.168.172.146
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C5B33EC02EA;
	Tue, 23 Jun 2026 09:11:46 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Tue, 23 Jun 2026 09:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	nowheycreamery.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1782220306; x=1782306706; bh=YflKELMA7I
	LmlEPH7fzoSK/KSlvBvVgRN/MsbIn0B6E=; b=Bgu2vsNs6dW9mIipxxiGAX6xQZ
	6UEYWFxxEUuZzU+d77CEUtU/MsvEtVDJWnzOpj45u0YN0zKDJ9Dqkz+NVBhaZ8BR
	3iSsbnAEuhXi0tRIYTUKtCoPaV9VPK+znUDv8SDT7UoKlK4pRVZ/Y18nOg0eapih
	xlmct3CBMF/er0JxZzrelumShKAzqeUE9sEkB9op3clpChIsBFYxBWVIU6l+384C
	IyV57m5UPehcp1fD4rFdO0FbyiUbXSQBVy6nkbUjZizSqKN95GTPIDuLmexj7cnW
	wmwHGtbRwUAeP6/aTxQBz5VZLgXnqwVXMvz8+YuudzVqT1pcRpDnqzMrVXqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782220306; x=
	1782306706; bh=YflKELMA7ILmlEPH7fzoSK/KSlvBvVgRN/MsbIn0B6E=; b=Z
	w4/pDEXuy2Y9V0skTcMi69z0LjryNPSexzossW1/o7gKX5J4NNdGmk0sOOpI9bDH
	2eJK3Vn0C5HFawAvr7j3zGB3TyZxERrPhiQtIBSUeBI7NWeVjqqg/czlHUOnyw89
	nB5vEqmGJO487AaEDAhab+0Tctfs2xq3jdS0ApC7OTT8/zp2G4WjLvyI5vkgJAvF
	+dldRZik51F7HkgXmO7WZTu+FpC7gmDUtqK1GhN5zdf+s45NF1c7kZc8mnDn5A62
	fOx5USzqMtPUuHBOp9pVs5k5b0mydw4vVrFfECjDpf6ThkfnSkLrYSGXDkeTZdKS
	40BcTk4yebIZga3eLlxgA==
X-ME-Sender: <xms:EoY6ar97Np5mYSkvU6xuQK3WQNZqiW8mJfGRunodh8fTqqP_C_ANng>
    <xme:EoY6aigeA-KYg22jmCfL5biRK2Ka1Qr54A1ARBys82Ih5QYK453cpeFwvV0lgN2Vx
    GnCOGN0AV4QhefHd0jkOsSHrDYb6LEYIDJJT_jA53tJ49-0SuP2UwE>
X-ME-Proxy-Cause: dmFkZTFWKGbailvR4m67/J/g8Nj50rMGCOJ5Lqwr+6VBxOzpACmTSUjyOqivdb5Hx2lTlS
    A5a0HyIejR+J1hAMnKcqNQ0cxy2WB38Vc+esRHKXsfzR+S1xfo2yDEY9HuQvMBopHn+iPS
    wrqCm8/9T+6GqkxXFcfl2bm4xsLfj4ouLJaSJbW61ifvOwkX8FPFZMFPDW6/1IcSOP0krH
    /9LYGL5ZryJ6UQQQ3vBO26NcWeovZjd7aPgxZ/YZFxaPebdiogEV/Ylzd9Y1Z/Lw8R0mC7
    3gBlV3RYshAu01WzlkNKXbVfyNNk034cPy7/8+G3l8xt7YGdZfmqFU711su6/MPp061td7
    tcdENu4hRF3y/+gVT2vVCBkbxEHtsSUXx7pareP/J0i6d2pH8M77xEeKFf6GjdYSlPnQ89
    baJCZs3fMp+zv9kA+2EW4gf5u8k6HceSSEnSi1AyzufqgGRE4OWtzwUZE/mHtq71brYGln
    ha1HKiG5nudpx5MYvC6wsG30w+cEEkovOvcAeN5kQpXuv/lhjjLkprIACBA3XV2xqWK0dF
    GTgSKoMQEoIMA9D+4L2+F4wzhFUB1panj5tL+8pCAxl7t4VUeB4oa5msw7o5FCX40cwe+g
    CfCRjCAPKMmfd8RWJDKRz+PcuFjo26+2y4lOHZbnmULurd4MleCK8njjSp/Q
X-ME-Proxy: <xmx:EoY6anYipH-fQVsvk8kc-rPNqIxmzmejBJ7vtYqoFdPuoYH-7nqVRw>
    <xmx:EoY6arVlLfYRY-zEFvQL_5wX7jXux_PZYWV6nLBvhST-deFYj4buDQ>
    <xmx:EoY6auMbEdUgZvpZwwm-9tQSMxsrFP-aw_6AxIwqATIqfC4QWYGPOA>
    <xmx:EoY6ataHPLieuYTcGCD8UPVqt76b1OIeeZm-RZpnXFs_AXW0y6wyhg>
    <xmx:EoY6amUx1bx6S0SARP6HXBnWMu60vSEx5zGb7u0euR0jZDotN8PetSIZ>
Feedback-ID: i67c64855:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 25EB5B6006E; Tue, 23 Jun 2026 09:11:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJIJP0MPV-Ps
Date: Tue, 23 Jun 2026 09:11:25 -0400
From: "Anna Schumaker" <anna@nowheycreamery.com>
To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>,
 "Jeff Layton" <jlayton@kernel.org>
Cc: "Piyush Sachdeva" <s.piyush1024@gmail.com>,
 linux-nfs <linux-nfs@vger.kernel.org>, "Chuck Lever" <cel@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, sfrench@samba.org,
 sprasad@microsoft.com, vaibsharma@microsoft.com
Message-Id: <a9885b28-a3fb-4ec6-b6fb-1be78ef16b2e@app.fastmail.com>
In-Reply-To: <455619640.1622514.1782212671358.JavaMail.zimbra@desy.de>
References: <m2qzlx7eye.fsf@gmail.com>
 <0b39c1e01a92f99fe456c76523ec7f3aa5dc1a81.camel@kernel.org>
 <455619640.1622514.1782212671358.JavaMail.zimbra@desy.de>
Subject: Re: NFS delegations behavior analysis
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.15 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[nowheycreamery.com:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22783-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[nowheycreamery.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:tigran.mkrtchyan@desy.de,m:jlayton@kernel.org,m:s.piyush1024@gmail.com,m:linux-nfs@vger.kernel.org,m:cel@kernel.org,m:trondmy@kernel.org,m:sfrench@samba.org,m:sprasad@microsoft.com,m:vaibsharma@microsoft.com,m:spiyush1024@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[anna@nowheycreamery.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,samba.org,microsoft.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@nowheycreamery.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[nowheycreamery.com:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,samba.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D2BC6B7583



On Tue, Jun 23, 2026, at 7:04 AM, Mkrtchyan, Tigran wrote:
> ----- Original Message -----
>> From: "Jeff Layton" <jlayton@kernel.org>
>> To: "Piyush Sachdeva" <s.piyush1024@gmail.com>, "linux-nfs" <linux-nfs@vger.kernel.org>, "Chuck Lever" <cel@kernel.org>,
>> "trondmy" <trondmy@kernel.org>, sfrench@samba.org, sprasad@microsoft.com
>> Cc: vaibsharma@microsoft.com
>> Sent: Tuesday, 23 June, 2026 12:50:16
>> Subject: Re: NFS delegations behavior analysis
>
>> On Tue, 2026-06-23 at 15:31 +0530, Piyush Sachdeva wrote:
>>> Hi,
>>> Lately I have been running micro benchmarks around the `ls` command and
>>> reading through the code documentation of the NFS client to better
>>> understand the client side caching behavior with and without
>>> delegations.
>>> 
>>> Understanding so far:
>>> Delegations (both file and directory) are granted by the server to the
>>> client, indefinitely (until revoked or under the watermark) to cache
>>> attributes. The caching of data is a result of the attribute
>>> cache. Hence forth, a directory delegation will cache the directory
>>> attributes and the names of the files in the directory, and a file
>>> delegation will cache the attributes of the file and the file data.
>>> 
>>> Workload run:
>>> I focused on the 2 workloads below, doing 2 passes of a large flat
>>> directory (with close to 100K files) -
>>> a cold pass, and warm pass using the cache from the cold pass:
>>> - lslr - ls -lR on both runs
>>> - lsmix - ls -R (cold) and then ls -lR (warm)
>>> 
>>> I also played with the rdirplus behavior using both the default
>>> heuristic behavior and the `rdirplus=force` set at mount time.
>>> 
>>> Numbers:
>>> actimeo=5s, rdirplus=force, ACLs off, flat_dir
>>> ==================================================================
>>> 
>>>                  |         LSLR          |         LSMIX
>>>                  |  (ls -lR cold / warm) |  (p1 ls -R / p2 ls -lR)
>>> Operation        |  flat cold  | flat warm |   flat p1   | flat p2
>>> -----------------+-------------+-----------+-------------+---------
>>> READDIR calls    |    27       |     0     |   27        |    0
>>> READDIR recv B   | 23,603,024  |     0     | 23,603,024  |    0
>>>    call type     | readdirplus |    --     | readdirplus |    --
>>> LOOKUP           |     1       |     0     |    1        |    0
>>> GETATTR          |     3       |  100,000  |    2        | 100,001
>>> ACCESS           |     2       |     0     |    2        |    0
>>> -----------------+-------------+-----------+-------------+---------
>>> Elapsed (age)    |  ~14 s      |  ~62 s    |   ~16 s     |  ~63 s
>>> 
>>> 
>>> Observations:
>>> When doing `ls` or `ls -l` on a directory, due to the open(2) on the
>>> directory, the client gets a directory delegation - caching the
>>> directory attributes and file names. However, as we don't have file
>>> delegations due to no open(2) calls to any of the files. Henceforth,
>>> the cache of file attributes is governed by `actimeo`.
>>> Now here is the interesting bit, if the next `ls -l` is issued after
>>> the `actimeo`, a massive GETATTR storm hits the server, doing stat()
>>> calls for every file in the directory. As a result, the performance of
>>> this warm `ls -l` run ends up being worse than the cold pass. I am
>>> guessing this is most likely due to the compounded "rdirplus" being more
>>> efficient than stat() calls.
>>> 
>>> 
>>> Proposal:
>>> For large directories, this ends up being a massive problem, taking 1-2
>>> minutes when enumerating a directory on the warm passes.
>>> - An easier way to tackle this could be to do a rdirplus=[auto | forced]
>>>   instead of issuing the stat(2) storm to the server: When the client
>>>   notices that there are cache misses, which would be the case of file
>>>   attributes, instead of fetching file names from the directory-delegation
>>>   cache and attributes from GETATTR, the client does a READDIRPLUS to
>>>   the server, nonetheless.
>>> - A more tedious would be the to cache file attributes as well, as a part
>>>   of the directory delegation. This would end up requiring a change in the
>>>   NFS protocol spec though.
>>> - Bulk GETATTR calls: I am uncertain of the feasibility of this, but
>>>   what if, the client could do 1 GETATTR call for getting attributes
>>>   for multiple files.
>> 
>> 
>> ls is such a hard workload to get right, because we don't really get an
>
> 100% agree. And there were a couple of attempts to address this issue
> (second ls that is slow).
>
>> indication in the kernel of what userland's intentions are. It's
>> basically a readdir() call followed by a bunch of stat()'s, but at the
>> point where we're getting the readdir() call, we don't know if userland
>> intends to stat() those files or not. We have to make a guess about
>> that intention.
>> 
>> In this case, it sounds like the directory cache was valid, so the
>> client decided it didn't need to do a READDIR at all, but the
>> individual files had caches that timed out.
>> 
>> So imagine you're the kernel client and have been given that second
>> readdir() call: Why should you decide to do a READDIRPLUS at that point
>> instead of a regular READDIR?
>
> May we need some kind of client-side heuristics, like on the server side
> for open-delegations, where after seeing some `stats` for files in the
> In the same directory, the client will decide to switch to READDIR (v4)
> to get all attributes in one go.

We do something like that already. I don't think we'll ever have a readdir
plus heuristic that makes everybody happy without userspace somehow telling
us their intentions. I know a statx-based readdir plus system call probably
sounds crazy, but something like that would go a long way to take all the
guesswork out of things on our end.

Anna

>
> Best regards,
>    Tigran.
>
>> --
>> Jeff Layton <jlayton@kernel.org>
>
> Attachments:
> * smime.p7s

