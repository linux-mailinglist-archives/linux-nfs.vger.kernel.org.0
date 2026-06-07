Return-Path: <linux-nfs+bounces-22341-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id usw7O/viJGo/BAIAu9opvQ
	(envelope-from <linux-nfs+bounces-22341-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 07 Jun 2026 05:18:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAB464EBC1
	for <lists+linux-nfs@lfdr.de>; Sun, 07 Jun 2026 05:18:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dTcwXdOf;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22341-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22341-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8DFD3007298
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jun 2026 03:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03B528CF4A;
	Sun,  7 Jun 2026 03:18:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F54D2AF00;
	Sun,  7 Jun 2026 03:18:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780802294; cv=none; b=SnfVRJh4GWJjS/HHkVRa7Eok7M+tPnoJSUyJpuMYD3TActnnnsBV5tY9QqJ8/WD6vPFq/ZC+szpzqku+rnEDldE1q6eq0v7A9dPOZBGvTrq69GojOtmaH3eoOBxr1Po+vQDAVNUgzEr4PRIzU8qmsZsdq13KksZ7yhSlA2nlULw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780802294; c=relaxed/simple;
	bh=dfwSTvbnHGvgpLt+wnY+kAtzl81S678G2gZZxGXuO7k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qSTdeL7pf5vQvOJLHubKTxfdQW36v+yNpBkF3KGzX0LrqeoUlrw76U2jb0a2p4wSIoItszxZlcvvuxO/Vtu4CdoZM9wI0/ZY6P+xNkRrerfadnnlbGCeAr9zXQTg78AXKOzts1yOgF1BwGd7di2ThQuB77XYLwuha1mKEfoJKe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTcwXdOf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0406C1F00898;
	Sun,  7 Jun 2026 03:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780802293;
	bh=e+a3rt7IXpJQxeDsqJ3KaC9poX4kF/j5ljYl2cP8JA4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=dTcwXdOfQK/50WEYdu7SjQq8tlIDigumKc7YeIs0j5G1keJgMKbTPfSnJ9kUvy13F
	 hD5vL37DuoA/xnwSTtgsMSMQ7heyFvHn1G7JlgNNydO+abB3rSNj4jXFqwgumLaRaW
	 FzjdpTRy4tRKY7tuCrLhfAaJVFW/uuMr5Ur2Vs0sH99F/QHzdP3VtpQN4wAJzGwjRK
	 /pk4QWP6K598J9L7kAziGhEUbuU5fGp2PwX0IIerRWCDqCD1gN4+MgIWsse7xZShyL
	 6asKXsjpL62NvRoCcWNgFS/DZfyQlhUN1fB0anT1wRmipJ7MREnD7F1QuG5yeBoXtn
	 YHUN46K8sw/4g==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0B1B0F40083;
	Sat,  6 Jun 2026 23:18:12 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 06 Jun 2026 23:18:12 -0400
X-ME-Sender: <xms:8-Ikat5UJpX9AYNxqDkSmY611eIrg95bDeHclVuqp7UAwVQayH4ClQ>
    <xme:8-IkaltqyI31lri_nCeeTYqo5v6QDwrMn_feJKKgMxZO3YalFblAEhJNRH53Kcgap
    T25Vbl8LVp_673me4DxzLIQxIO9dbrVHjeyhA16jxfxTz86wCMjelOB>
X-ME-Proxy-Cause: dmFkZTGKPM1P5gY7wUdk9yZXrGE9fVFIMiG2HI6QMkwz6YchHHjaahLa9IkWjDTGHJk0D/
    pZX03WBGUJfS49s9w8yQX6J6uIhRjJ1lmP3DheNMvJ8LOF/P+ah8xuulnYtdO/qdZ6/q9L
    Byr3rLElgspOeJFuAWm7+o1A02xoqI8rKSWQ1BnyINH2Eod+abkwLZ9zBpQQN6VkNUv62r
    p9TzG1wIqRW361bI4t3dAz+0/GNZCFf5G9AadUVwrTjHKTTluaBvl0SvY9N+PId3JRdEpW
    wviZqYem67fX+0uzABEBk/bnXk8IiREFGxyR2GD3abdX7lB9NMDGoxjrDYpE588Uh8FMFr
    Ef5Dc7+K7I5tI3uazeBPpCi+MoKSuT14PkFRUpPmHPpKkZWe8n3vx1QrKAykbEvyAwCk40
    //Ekhj7wmWBiPmOa7uLQs4fYDgbyKNsdweApIquXS0Dt0tmynr1SM4MwZNKVZsx/a7MPeI
    UqIgZqCJLcMhXJ/vIEJ9w04DzKOVf7b3PLuqvLZgUw4C46rTvQFpLlvzKxiIjtZ6OWoZVA
    tn20ZOpLF0Lqk/lYtb5ZvsBXWotCZB43Z5dqoqJadFJ8E5FHrst4WGr1ZzjsAXJ9LPzet9
    rx5BeNF361lO5m8DqlkEK6dmf89AgU/hBC67wUu3d9XcyWgPF+svhNK6JBUw
X-ME-Proxy: <xmx:8-IkajGd8fAY_Wq6uiX-PTy0GElLsubugHBn0IDJ2G-jyclAmRL7Vw>
    <xmx:8-IkapRNQhXkTxSr1Ul_jGuLNnhTX4Ki-TIeIhPNPohgv9gwuvci2Q>
    <xmx:8-IkagtIl9Ejf4kwm1ROrP9WVyXwlkMF4kuShzGEU2hw1dsV5bfF6g>
    <xmx:8-IkahLQuBP3_tjYxI8bbt0aSl7erjY2727HzkMiOf2cULf0hnO9Hg>
    <xmx:9OIkalke_CUefLlq0pYEHYbnzqqBHqB6F0Z80U7y7ogfqzrocJAm2ERU>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DBBB8780070; Sat,  6 Jun 2026 23:18:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A0Y1o-4h3gmR
Date: Sat, 06 Jun 2026 23:17:51 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jonathan Flynn" <jonathan.flynn@hammerspace.com>,
 "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <096a2b91-7a19-48da-a06a-dc60e7150956@app.fastmail.com>
In-Reply-To: <65a2cdb132b0c28e69a29955e3bd37e7@mail.gmail.com>
References: <20260606035722.83175-1-cel@kernel.org>
 <65a2cdb132b0c28e69a29955e3bd37e7@mail.gmail.com>
Subject: Re: [PATCH] svcrdma: Cap Read sink allocations at PAGE_ALLOC_COSTLY_ORDER
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jonathan.flynn@hammerspace.com,m:snitzer@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22341-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBAB464EBC1



On Sat, Jun 6, 2026, at 1:35 PM, Jonathan Flynn wrote:
> I tested the PAGE_ALLOC_COSTLY_ORDER change on the same setup.
> Unfortunately, it did not improve the regression. Throughput was slightly
> worse than the previous GFP_NOWAIT test, measuring 25.4 GiB/s.
>
> Current results are:
> Original regressed build: ~30.3 GiB/s
> GFP_NOWAIT build: ~31.0 GiB/s
> PAGE_ALLOC_COSTLY_ORDER: 25.4 GiB/s
> Commit reverted: ~73.9 GiB/s
>
> I added the results to the shared bundle. (including flamegraph)
>
> The GFP_NOWAIT and the Original Commit flamegraphs are nearly identical.
> The dominant stack being:
> svc_recv()
> -> svc_rdma_build_read_segment_contig()
> -> alloc_pages_noprof()
> -> get_page_from_freelist()
> -> rmqueue_buddy()
>
> The PAGE_ALLOC_COSTLY_ORDER flamegraph is different. Time spent under
> alloc_pages_noprof() is reduced, but the reduction does not translate into
> improved throughput.
>
> The following percentages were observed:
>                                                    Original     GFP_NOWAIT
> COSTLY_ORDER
> svc_recv()                                 76.09%      75.99%
> 78.44%
> alloc_pages_noprof()             58.07%      57.99%               40.29%
> folios_put_refs()                        7.15%        7.19%
> 16.06%
> svc_rdma_read_complete()    7.18%        7.21%               16.08%
>
> In other words, the PAGE_ALLOC_COSTLY_ORDER change reduces time spent in
> the allocation path, but a larger fraction of CPU time then appears under
> svc_rdma_read_complete() and folios_put_refs(), while overall throughput
> decreases further.

The two failed fixes demonstrate that the current folio allocator is
not up to the task -- the problem appears to be on the release side,
where the individual pages have to be merged back into an order-4
compound page. I don't yet see a straightforward way to make it work.

Since we're right up against v7.1-rc7, I've added a patch to nfsd-next
to revert 18755b8c2f24 -- it will get pulled back into 7.1.y as soon as
the v7.2 merge window closes in three weeks.


-- 
Chuck Lever

