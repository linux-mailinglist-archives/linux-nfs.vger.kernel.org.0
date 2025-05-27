Return-Path: <linux-nfs+bounces-11928-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2796AC5B55
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 22:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7A73B4FB3
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 20:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5059C207A25;
	Tue, 27 May 2025 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDaAMxVX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AD4207A2A
	for <linux-nfs@vger.kernel.org>; Tue, 27 May 2025 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748377546; cv=none; b=V/82RAkJ9UqF2thfF2yLhebTuCY6eyAZFDuSNW6QdZKoKIwZx7JlCNxWLL/aZSXdsUK4e1IYKKp1xi7SD/tyEstS3z2k5H6FZLSF3WJjQs7SaBi1FyiD9fNF52gfZ6D+7kqmo8KAt81YsoFVeBTX4X3skznGcWo1wzH3Ej4O3m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748377546; c=relaxed/simple;
	bh=B0VloNkP1xXahX72tyAMvFMAN4+obwt0bKOCtOkLNDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udIo470+FlvZBp+60A+NvMvKl1waeq5D36rXQs0LodMhSooBkoS04Aktj2KV8tRpL5Rlp0Xqo2zqmNvDzoviDRAc6hsQ57aODvFnDtxaxZRaG581yi/4NAisXokNtYDZgbBeUmjVAftr4qqLh8qcN6xFS1c+0NvUOPVjmXFr53w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDaAMxVX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748377543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ra3cTfvlsW8PM3KunOvPNGL3wrneMiZi7XmySQmX35c=;
	b=ZDaAMxVXFy64FRAOXOznFiFbY1wJUfbtl7rdxT8gTedy3RUh7Dr4waONX1eA9TrGHaLfFm
	ku2D08UWNbA7h1km3THKPAQ8Ge880XwTN4bnwJlGC/83elBgbGPfxUtuSI4wmJD4KrPUqy
	B4cH7WIHeJIIQh6Ub+xcbpqmkl738dc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-EfYH61XxOleQg9UOpMkm1w-1; Tue,
 27 May 2025 16:25:40 -0400
X-MC-Unique: EfYH61XxOleQg9UOpMkm1w-1
X-Mimecast-MFC-AGG-ID: EfYH61XxOleQg9UOpMkm1w_1748377539
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 053F3194510C;
	Tue, 27 May 2025 20:25:39 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.2])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58E3719560AB;
	Tue, 27 May 2025 20:25:37 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neil@brown.name>, Rick Macklem <rick.macklem@gmail.com>,
 Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>,
 Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
Date: Tue, 27 May 2025 16:25:34 -0400
Message-ID: <93C75052-1CC8-4660-B760-F2FAAAA0393A@redhat.com>
In-Reply-To: <e6daff16-2949-4413-b801-58393d9cb993@oracle.com>
References: <> <d539c502-e776-460f-852c-8af9722ad9f8@oracle.com>
 <174821817646.608730.16435329287198176319@noble.neil.brown.name>
 <f679b62b-cbf3-4225-a163-870c65ff0c9b@oracle.com>
 <3DF74DD6-E300-4CDE-B8D9-EECD5F05BC8B@redhat.com>
 <e6daff16-2949-4413-b801-58393d9cb993@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 27 May 2025, at 15:41, Chuck Lever wrote:

> On 5/27/25 3:18 PM, Benjamin Coddington wrote:
>> On 27 May 2025, at 11:05, Chuck Lever wrote:
>>
>>> On 5/25/25 8:09 PM, NeilBrown wrote:
>>>> On Mon, 26 May 2025, Chuck Lever wrote:
>>>>> On 5/20/25 9:20 AM, Chuck Lever wrote:
>>>>>> Hiya Rick -
>>>>>>
>>>>>> On 5/19/25 9:44 PM, Rick Macklem wrote:
>>>>>>
>>>>>>> Do you also have some configurable settings for if/how the DNS
>>>>>>> field in the client's X.509 cert is checked?
>>>>>>> The range is, imho:
>>>>>>> - Don't check it at all, so the client can have any IP/DNS name (a mobile
>>>>>>>   device). The least secure, but still pretty good, since the ert. verified.
>>>>>>> - DNS matches a wildcard like *.umich.edu for the reverse DNS name for
>>>>>>>    the client's IP host address.
>>>>>>> - DNS matches exactly what reverse DNS gets for the client's IP host address.
>>>>>>
>>>>>> I've been told repeatedly that certificate verification must not depend
>>>>>> on DNS because DNS can be easily spoofed. To date, the Linux
>>>>>> implementation of RPC-with-TLS depends on having the peer's IP address
>>>>>> in the certificate's SAN.
>>>>>>
>>>>>> I recognize that tlshd will need to bend a little for clients that use
>>>>>> a dynamically allocated IP address, but I haven't looked into it yet.
>>>>>> Perhaps client certificates do not need to contain their peer IP
>>>>>> address, but server certificates do, in order to enable mounting by IP
>>>>>> instead of by hostname.
>>>>>>
>>>>>>
>>>>>>> Wildcards are discouraged by some RFC, but are still supported by OpenSSL.
>>>>>>
>>>>>> I would prefer that we follow the guidance of RFCs where possible,
>>>>>> rather than a particular implementation that might have historical
>>>>>> reasons to permit a lack of security.
>>>>>
>>>>> Let me follow up on this.
>>>>>
>>>>> We have an open issue against tlshd that has suggested that, rather
>>>>> than looking at DNS query results, the NFS server should authorize
>>>>> access by looking at the client certificate's CN. The server's
>>>>> administrator should be able to specify a list of one or more CN
>>>>> wildcards that can be used to authorize access, much in the same way
>>>>> that NFSD currently uses netgroups and hostnames per export.
>>>>>
>>>>> So, after validating the client's CA trust chain, an NFS server can
>>>>> match the client certificate's CN against its list of authorized CNs,
>>>>> and if the client's CN fails to match, fail the handshake (or whatever
>>>>> we need to do).
>>>>>
>>>>> I favor this approach over using DNS labels, which are often
>>>>> untrustworthy, and IP addresses, which can be dynamically reassigned.
>>>>>
>>>>> What do you think?
>>>>
>>>> I completely agree with this.  IP address and DNS identity of the client
>>>> is irrelevant when mTLS is used.  What matters is whether the client has
>>>> authority to act as one of the the names given when the filesystem was
>>>> exported (e.g. in /etc/exports).  His is exacly what you said.
>>>>
>>>> Ideally it would be more than just the CN.  We want to know both the
>>>> domain in which the peer has authority (e.g.  example.com) and the type
>>>> of authority (e.g.  serve-web-pages or proxy-file-access or
>>>> act-as-neilb).
>>>> I don't know internal details of certificates so I don't know if there
>>>> is some other field that can say "This peer is authorised to proxy file
>>>> access requests for all users in the given domain" or if we need a hack
>>>> like exporting to nfs-client.example.com.
>>>>
>>>> But if the admin has full control of what names to export to, it is
>>>> possible that the distinction doesn't matter.  I wouldn't want the
>>>> certificate used to authenticate my web server to have authority to
>>>> access all files on my NFS server just because the same domain name
>>>> applies to both.
>>>
>>> My thought is that, for each handshake, there would be two stages:
>>>
>>> 1. Does the NFS server trust the certificate? This is purely a chain-of-
>>>    trust issue, so validating the certificate presented by the client is
>>>    the order of the day.
>>>
>>> 2. Does the NFS server authorize this client to access the export? This
>>>    is a check very similar to the hostname/netgroup/IP address check
>>>    that is done today, but it could be done just once at handshake time.
>>>    Match the certificate's fields against a per-export filter.
>>>
>>> I would take tlshd out of the picture for stage 2, and let NFSD make its
>>> own authorization decisions. Because an NFS client might be authorized
>>> to access some exports but not others.
>>>
>>> So:
>>>
>>> How does the server indicate to clients that yes, your cert is trusted,
>>> but no, you are not authorized to access this file system? I guess that
>>> is an NFS error like NFSERR_STALE or NFS4ERR_WRONGSEC.
>>>
>>> What certificate fields should we implement matches for? CN is obvious.
>>> But what about SAN? Any others? I say start with only CN, but I'd like
>>> to think about ways to make it possible to match against other fields in
>>> the future.
>>>
>>> What would the administrative interface look like? Could be the machine
>>> name in /etc/exports, for instance:
>>>
>>> *,OU="NFS Bake-a-thon",*   rw,sec=sys,xprtsec=mtls,fsid=42
>>>
>>> But I worry that will not be flexible enough. A more general filter
>>> mechanism might need something like the ini file format used to create
>>> CSRs.
>>
>> It might be useful to make the kernel's authorization based on mapping to a
>> keyword that tlshd passes back after the handshake, and keep the more
>> complicated logic of parsing certificate fields and using config files up in
>> ktls-utils userspace.
>
> I agree that the kernel can't do the filtering.
>
> But it's not possible that tlshd knows what export the client wants to
> access during the TLS handshake; no NFS traffic has been exchanged yet.
> Thus parsing per-export security settings during the handshake is not
> possible; it can happen only once tlshd passes the connected socket back
> to the kernel.
>
> And remember that ktls-utils is shared with NVMe and now QUIC as well.
> tlshd doesn't know anything about the upper layer protocols. Therefore
> adding NFS-specific authorization policy settings to ktls-utils is a
> layering violation.

Here tlshd doesn't need to know anything about the upper layer protocols, it
merely uses its mapping rules to match the certificate to a keyword it
passes back to the kernel in the successful handshake downcall.  The kernel
then can decide what that keyword means.  If not implemented in-kernel it
can merely be ignored.

> What makes the most sense is that the handshake succeeds, then NFSD
> permits the client to access any export resources that the server's
> per-export security policy allows, based on the client's cert.
>
>
>> I'm imagining something like this in /etc/exports:
>>
>> /exports *(rw,sec=sys,xprtsec=mtls,tlsauth=any)
>> /exports/home *(rw,sec=sys,xprtsec=mtls,tlsauth=users)
>>
>> .. and then tlshd would do the work to create a map of authorized
>> certificate identities mapped to a keyword, something like:
>>
>> CN=*                any
>> CN=*.nfsv4bat.org   users
>> SHA1=4EB6D578499B1CCF5F581EAD56BE3D9B6744A5E5   bob
>
> I think mountd is going to have to do that, somehow. It already knows
> about netgroups, for example, and this is very similar.

That sounds.. complicated.

Ben


