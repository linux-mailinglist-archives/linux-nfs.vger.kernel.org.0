Return-Path: <linux-nfs+bounces-12436-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05481AD8A98
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 13:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD81189BED8
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 11:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402182E2EEC;
	Fri, 13 Jun 2025 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/CULjJe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853822D5C79
	for <linux-nfs@vger.kernel.org>; Fri, 13 Jun 2025 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814421; cv=none; b=Fm6zQlb1MNV2JP+c6AEw5h2LmzUVW6G2JMB57NTYCwa5FObgiqOmvUl0UwsPDCH6QNzVc9L73B/XAXF4mTWyWesyqCy59ejVAvZdi/9Y0yNSTcgHAXS7LYhCmbGo94pu7abBaBy0S5f+Lk9m8/OuZ8I9z+jKKis6C9qraQeqgPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814421; c=relaxed/simple;
	bh=lfynEmycBcTUhYS2//mGCt+9+hiekxvpfMXULeOUjqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOtosUJ4lYHe3rlPIm8R6Q3D4LqKS9hojozW/sT1BPrS8TBHQqKrhniZBwF9/DyFmnDHkqhHFT8AEYGUe/8KxxqcWMDXDJ1xO8PnZWL8DFcmzakpxA2Dzjw7VY6ZMwHmfJMOTCDh4RkiwvDvlauIGcmYfnc3al/M2QZR+MHlbLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/CULjJe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749814418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4I9CYam3FITVcfvZRQPJD4i6p9XAy84R0dLNBapStE=;
	b=D/CULjJex4XEc2t9EIIGfC8xbjtGbzxjxf0PCGfRp8xRVcQnpCrAfsQxlryp5riDXBM9qE
	LGlWfq68BFbMa9/juK48OVOXUGI/Yi/UkclQGkZwkV6QYMM8wqS6cz829t9Xl+qhFIq2py
	wdO3tfRiOfy8v+OhWSkDpoZTD4I3qHY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-s700-o_5NmuVtHYdjSzeJQ-1; Fri,
 13 Jun 2025 07:33:35 -0400
X-MC-Unique: s700-o_5NmuVtHYdjSzeJQ-1
X-Mimecast-MFC-AGG-ID: s700-o_5NmuVtHYdjSzeJQ_1749814410
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 847B21800281;
	Fri, 13 Jun 2025 11:33:29 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9651230044CC;
	Fri, 13 Jun 2025 11:33:24 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] nfsd: use threads array as-is in netlink interface
Date: Fri, 13 Jun 2025 07:33:22 -0400
Message-ID: <7DCDEBE1-1416-4A93-B994-49A6D21DC065@redhat.com>
In-Reply-To: <38f1974c-f487-49b0-9447-74ed2db6ca7e@oracle.com>
References: <20250527-rpc-numa-v1-0-fa1d98e9a900@kernel.org>
 <20250527-rpc-numa-v1-1-fa1d98e9a900@kernel.org>
 <a8d4c4cffe1a35ea831110ce1c7beea649352238.camel@kernel.org>
 <ae18305b-167d-4f27-bc3b-3d2d5f216d85@oracle.com>
 <1cd4d07f7afbd7322a1330a49a2cc24e8ff801cd.camel@kernel.org>
 <38f1974c-f487-49b0-9447-74ed2db6ca7e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 12 Jun 2025, at 12:42, Chuck Lever wrote:

> On 6/12/25 12:15 PM, Jeff Layton wrote:
>> On Thu, 2025-06-12 at 12:05 -0400, Chuck Lever wrote:
>>> On 6/12/25 11:57 AM, Jeff Layton wrote:
>>>> On Tue, 2025-05-27 at 20:12 -0400, Jeff Layton wrote:
>>>>> The old nfsdfs interface for starting a server with multiple pools
>>>>> handles the special case of a single entry array passed down from
>>>>> userland by distributing the threads over every NUMA node.
>>>>>
>>>>> The netlink control interface however constructs an array of length=

>>>>> nfsd_nrpools() and fills any unprovided slots with 0's. This behavi=
or
>>>>> defeats the special casing that the old interface relies on.
>>>>>
>>>>> Change nfsd_nl_threads_set_doit() to pass down the array from userl=
and
>>>>> as-is.
>>>>>
>>>>> Fixes: 7f5c330b2620 ("nfsd: allow passing in array of thread counts=
 via netlink")
>>>>> Reported-by: Mike Snitzer <snitzer@kernel.org>
>>>>> Closes: https://lore.kernel.org/linux-nfs/aDC-ftnzhJAlwqwh@kernel.o=
rg/
>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>> ---
>>>>>  fs/nfsd/nfsctl.c | 5 ++---
>>>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>>> index ac265d6fde35df4e02b955050f5b0ef22e6e519c..22101e08c3e80350668=
e94c395058bc228b08e64 100644
>>>>> --- a/fs/nfsd/nfsctl.c
>>>>> +++ b/fs/nfsd/nfsctl.c
>>>>> @@ -1611,7 +1611,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_b=
uff *skb,
>>>>>   */
>>>>>  int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info=
 *info)
>>>>>  {
>>>>> -	int *nthreads, count =3D 0, nrpools, i, ret =3D -EOPNOTSUPP, rem;=

>>>>> +	int *nthreads, nrpools =3D 0, i, ret =3D -EOPNOTSUPP, rem;
>>>>>  	struct net *net =3D genl_info_net(info);
>>>>>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>>>>>  	const struct nlattr *attr;
>>>>> @@ -1623,12 +1623,11 @@ int nfsd_nl_threads_set_doit(struct sk_buff=
 *skb, struct genl_info *info)
>>>>>  	/* count number of SERVER_THREADS values */
>>>>>  	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
>>>>>  		if (nla_type(attr) =3D=3D NFSD_A_SERVER_THREADS)
>>>>> -			count++;
>>>>> +			nrpools++;
>>>>>  	}
>>>>>
>>>>>  	mutex_lock(&nfsd_mutex);
>>>>>
>>>>> -	nrpools =3D max(count, nfsd_nrpools(net));
>>>>>  	nthreads =3D kcalloc(nrpools, sizeof(int), GFP_KERNEL);
>>>>>  	if (!nthreads) {
>>>>>  		ret =3D -ENOMEM;
>>>>
>>>> I noticed that this didn't go in to the recent merge window.
>>>>
>>>> This patch fixes a rather nasty regression when you try to start the=

>>>> server on a NUMA-capable box.
>>>
>>> The NFSD netlink interface is not broadly used yet, is it?
>>>
>>
>> It is. RHEL10 shipped with it, for instance and it's been in Fedora fo=
r
>> a while.
>
> RHEL 10 is shiny and new, and Fedora is bleeding edge. It's not likely
> either of these are deployed in production environments yet. Just sayin=

> that in this case, the Bayesian filter leans towards waiting a full dev=

> cycle.

We don't consider it acceptable to allow known defects to persist in our
products just because they are bleeding edge.

>>> Since this one came in late during the 6.16 dev cycle and the Fixes: =
tag
>>> references a commit that is already in released kernels, I put in the=

>>> "next merge window" pile. On it's own it doesn't look urgent to me.
>>>
>>
>> I'd really like to see this go in soon and to stable. If you want me t=
o
>> respin the changelog, I can. It's not a crash, but it manifests as los=
t
>> RPCs that just hang. It took me quite a while to figure out what was
>> going on, and I'd prefer that we not put users through that.
>
> If someone can confirm that it is effective, I'll add it to nfsd-fixes.=


I'm sure it is if Jeff spent time on it.

We're going to try to get this into RHEL-10 ASAP, because dropped RPCs
manifest as datacenter-wide problems that are very hard to diagnose.  Its=
 a
real pain that we won't have an upstream commit assigned for it.

Ben


