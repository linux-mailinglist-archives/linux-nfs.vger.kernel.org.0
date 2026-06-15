Return-Path: <linux-nfs+bounces-22564-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dlAFIb9YMGrJRwUAu9opvQ
	(envelope-from <linux-nfs+bounces-22564-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 21:55:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 822D16899E9
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 21:55:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KJ9uDez2;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22564-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22564-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF860300AD70
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 19:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE343AA4E1;
	Mon, 15 Jun 2026 19:55:24 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED793B42EF
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jun 2026 19:55:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553324; cv=none; b=BfKeLfWzRsq86owASJ5YzDbpmCtaXAecGNPVDnOgITVlCLvAEPQxDQ9yvs0xEQylkNJ7+zzzWjubC9UycDUAhcu8E9vEv19hEMgYglyUJUMAYLxhZIexDCFbOIH18zlgShl3veJDb8WDRLgp2vlJrD3qNTmsJfXl4QR2NPeMaSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553324; c=relaxed/simple;
	bh=GWr6p7bXfZk0NQDxqWyV/PoBB4jWosMTvJgnM9ZxLLI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kJhAiNbVv6EBhGzaqCA/18IvCeMVtfoEsJSv175DDmIwF09Hqy6KXTY+US/RUkWSqhXE97yPU0Y4E5ogQfZSXXvesidxpBXu1xm0tzu//XMKfRrWTQ+0DIxHYMj5WXK/Bvk7uaiXQgH8wu+bHIMaIN4ArXWR15+8+VMa/oW6/Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJ9uDez2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D621F00A3A;
	Mon, 15 Jun 2026 19:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553323;
	bh=VD9HUxinTdurSmXu10vPi4x3ac7Dcgy7SlbXLtFh7vY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=KJ9uDez2UEvJBv7W6j0Xy5YFQnvP3kRaWzpU/lNUi0vJjHfPH0gAOgypWW5VTOflx
	 bY/NtoUsj7Vb2tbmxfBeBpErOH/FnxoddYFET8vYmfG4ZBz1PHUpknJIAb3oWpY+0p
	 1WkKxZLImFk38hmyUsGgfGFNnUmHvx/ywePBxwR2+drKeBisRINU5UZawwAuNuk+qP
	 m434SY2qOOcCExAT4BAZ1FYGDqTnxe0EEPnoYy1iGvX+/OdjIfwOaJQZperqv3dCez
	 6SQN9IyhsUYT4F0s7B4V+8xNri2KMDmxYCRdtubL0E4WkRAnb0jPGcDKBaRvsbldgt
	 xNNUcFe2YKJpA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2EB7BF40076;
	Mon, 15 Jun 2026 15:55:22 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 15 Jun 2026 15:55:22 -0400
X-ME-Sender: <xms:qlgwalHVvZ7i_APK78wzyc4SpI7DH3kCVrwIEyrRBcHxFycegX6TWA>
    <xme:qlgwalJtteQjqhaipFcQKBhXB4pHiYQwDTmxFtPQdzI-LoXeVa4PXItzn0Al7h309
    daSsBeAuwXcbgMXQQQD6M0P71M4EMmCEinyxozNiNiE0dlVHLvrnmQ>
X-ME-Proxy-Cause: dmFkZTGZktuhFxccPjeshbTlsSSqRW9XkXDA9cMQxnpwObVWOCQ6EsQQImuokDvwMOpxBG
    6/t6c8nsRnSraNDSpy8Y08NBK+/ZBpbvGM/yAGyP7YwFz97CoktKc07YeumCMtXm3dRI38
    Rh2W3iL1Muvu1rUjLUC2zu1g9KmS6VLsuR2Ix+Gdhl1sJGrmwX+nvg5aRaJn+pK9mb/NWE
    Sc42sOO2DBcBsw17f1fno6LgNCvVfdurMxiLxWGibg4gn6MtGJa1A9Re4NjVwfTvk1SvLe
    hIb3q7fh0VGoRldi2k2/Prpg9X8yKks1mdiMeWzNXdqGR2qz5gEWJazsr6cptuwKLhRNt2
    gDp4W93H7dolhdDUhpMdDdapHWYjD7hDzHJMbW+tJnkdDIpf66bgRR17a93oJDbKgx5a70
    Sd+wcpYGIQeoTwh4Y50v+xMB871bdwFd4iAOxsbE/UIki29jeo3GU9cq9I9Ep1cJstSkmF
    oPlQz3Ji05eRZS0lAeF8f2axV1AgqMm5W4Gk1b2pF22rz397cx6D0zXMQG1jnhovqxUx1F
    gpkFHwf28uo+lwVqTRW91ONXRLGqfrNO82WYjKeRYlHM/y1H2dGIEL8w6S0FvU5PbBs0lB
    H60os006LbuOascBQPXWI1ZZSbaeavdhB59atJhDSylao1ZWv1Z3kgoWKWHQ
X-ME-Proxy: <xmx:qlgwahiTo4NGCX58nPT4PRH87NH9mGLZp_kwN3XixyveeFSoKYTf-w>
    <xmx:qlgwaq_meXrOV_kCIdJqJvbyL48sIJ2rN7Mgobt5aETNCnJ2HyOMPw>
    <xmx:qlgwalWi_JdGQxJUIyOTFvkKWcrs8x6Hxvojb2udWrjUCbKk-YfwvA>
    <xmx:qlgwamAyZx7eTyAwFZFfjJ7lfDRlp-1MvyNQUYPeOueRIWR13Rndng>
    <xmx:qlgwaiGvuSJcHof6prhX8tGKCiXVU98kekWvD_q4nI4G3wCXqfr261wb>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 03D8D780070; Mon, 15 Jun 2026 15:55:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHm78Q_YUE1c
Date: Mon, 15 Jun 2026 15:55:01 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <ben.coddington@hammerspace.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>,
 "Jonathan Flynn" <jonathan.flynn@hammerspace.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <59fd9314-432a-4738-bcff-578797e2802f@app.fastmail.com>
In-Reply-To: <D17494D7-20C8-4763-84B1-9B587B180A7A@hammerspace.com>
References: <20260610-nfsd-slot-growth-clamp-v1-0-7b966700df0b@kernel.org>
 <D17494D7-20C8-4763-84B1-9B587B180A7A@hammerspace.com>
Subject: Re: [PATCH 0/5] RFC: Stop NFSv4.1 slot-growth heuristic from rewarding busy
 clients
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22564-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,app.fastmail.com:mid];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ben.coddington@hammerspace.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:jonathan.flynn@hammerspace.com,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 822D16899E9



On Mon, Jun 15, 2026, at 2:12 PM, Benjamin Coddington wrote:
> On 10 Jun 2026, at 21:58, Chuck Lever wrote:
>
>> This series grew out of Ben Coddington's fair-queueing RFC and the
>> discussion it prompted with Neil Brown: a single busy NFSv4.1 client,
>> opening many connections against a large slot table, can keep enough
>> requests in flight to monopolize the nfsd thread pool and starve its
>> peers [1]. Where fair queueing itself belongs is still being worked
>> out. One change, though, holds no matter which design wins -- the
>> server should not actively widen the gap, and today it does.
>>
>> nfsd4_sequence() grows a session's slot table by 20% every time the
>> client reaches its highest slot, so it hands the client already
>> keeping the most threads busy a still larger table; one session can
>> climb toward 2048 slots on a server with far fewer threads to run
>> them. This series caps that growth where added slots stop buying
>> concurrency, and leaves the dynamic-slot machinery otherwise intact.
>>
>> Two design points are worth checking against the diffs.
>>
>> The cap is per session, not per namespace, and deliberately so. A
>> budget shared across a namespace's sessions breaks at the floor:
>> every active session permanently holds slot 0, which the shrinker
>> never reclaims, so once the session count alone reaches the thread
>> ceiling those floors exhaust a shared budget and pin the one busy
>> client small while the pool sits idle. Making that floor explicit is
>> a self-contained accounting cleanup -- nfsd_total_target_slots gains
>> the full-target meaning its name implies, and the never-reclaim-slot-0
>> correction moves to the one place that reads it, the shrinker's count
>> callback. Since a session cannot use another's slots, capping each
>> independently against the ceiling is the natural choice.
>>
>> The ceiling is a sunrpc-owned quantity. Maximum sustainable
>> concurrency is a property of svc_serv and svc_pool, so
>> svc_serv_maxthreads() lives in sunrpc, and nfsd_nrthreads()'s
>> open-coded sum is converted to it rather than nfsd carrying a second
>> copy. It sums each pool's configured maximum, not the running thread
>> count: nfsd sizes its pool dynamically, and gating on the live count
>> would deny a client resuming from idle the slots it needs before the
>> pool scales back up.
>>
>> This removes a perverse incentive; it is not slot admission control.
>> A client still sizes its sessions at CREATE_SESSION, and per-client
>> fairness against thread starvation belongs in the dispatch layer,
>> where the larger discussion continues.
>>
>> [1] https://lore.kernel.org/linux-nfs/cover.1780498019.git.bcodding@hammerspace.com/
>>
>> ---
>> Chuck Lever (5):
>>       SUNRPC: Add svc_serv_maxthreads() to report the thread ceiling
>>       NFSD: Count slot 0 in nfsd_total_target_slots
>>       NFSD: Clean up documenting comment for reduce_session_slots()
>>       NFSD: Document and rename the NFSv4.1 session slot shrinker callbacks
>>       NFSD: Bound on-demand DRC slot growth by the thread ceiling
>>
>>  fs/nfsd/nfs4state.c        | 115 +++++++++++++++++++++++++++++++--------------
>>  fs/nfsd/nfssvc.c           |  12 +++--
>>  include/linux/sunrpc/svc.h |   1 +
>>  net/sunrpc/svc.c           |  23 +++++++++
>>  4 files changed, 113 insertions(+), 38 deletions(-)
>> ---
>> base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
>> change-id: 20260610-nfsd-slot-growth-clamp-ca03e338678c
>
> Nice!
>
> Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>
>
> I'm pretty late to review this, especially as it lands right in the same
> zone I was exploring.  Sorry about that..

No worries. These are sitting in nfsd-testing, and will be for a while
since the merge window is now open.

I added your R-b.


> Do you want me to rebase the fair-queue series on top of this once it's in
> nfsd-testing and re-run the A/B through the harness with this as the
> baseline?

Rebase on nfsd-testing whenever you are ready to post for me to merge.


> Happy to follow up with a Tested-by.

That would be great if you can!


> The work I have yet to do on the fair-queue series is to show a prototyped
> burst-allowance.


-- 
Chuck Lever

