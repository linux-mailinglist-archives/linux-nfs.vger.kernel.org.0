Return-Path: <linux-nfs+bounces-11926-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838C3AC5A8F
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 21:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7F5C7A39AC
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 19:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE7028689C;
	Tue, 27 May 2025 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCeIfm0V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DCA284698
	for <linux-nfs@vger.kernel.org>; Tue, 27 May 2025 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748373542; cv=none; b=BSAkQpVXSdpU4+RvfYlBKSCDrrGSoHPm97qyN2Gs/B+c9pVs/2IMQTk18yJshWVKJceWFzEpZLsL0vUUc79+1Kj0sfS02O2bR3GgwC5jXhpLgzHgl7umkfIihYJmuj2kkZn75NHOOEviDtHSA/yQs3W8YlapEkLrDJmur1r9Pz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748373542; c=relaxed/simple;
	bh=Nzkd5uyq8G+T1hFolAHsImmKFRPiAu2XwikBz8I3qIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLJBMLIbr27ZgD6FNPda9UIzw7otxhYZ101waBMhRdhP5DkW8top8rBV4t/0y9dNa4gdxu0IJPbEQQ8XV51UuRjQOhQFmd/mwN/cdeI83rttVC1sN4eD/lSpLtWmfYR7cPFv8mUgmS9FY3PcAJ1XifzY8v+6nUMQFgx+RDuDGKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bCeIfm0V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748373540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nQ+Oy9UaPkE+jhtD7CZ1EWcGQTZaG99tebA3+kKiqkI=;
	b=bCeIfm0VPCN8egzSYX7PKquYNA5OvTTOJfFOgr7r/jHSfRtq8FnSckCMAY6KScINtCguaG
	GfHNScBDaqr201yh+w+Yyvu35xPNvoQ75AtsP45Fc5LJ9XUjMi9MyZtSlZSyGQi2VO4ZOv
	eL8lvEjgfII7ffjJXYZE8p9tkvCeB9U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-DmHK39cJMhqpkc_dOc3pNA-1; Tue,
 27 May 2025 15:18:57 -0400
X-MC-Unique: DmHK39cJMhqpkc_dOc3pNA-1
X-Mimecast-MFC-AGG-ID: DmHK39cJMhqpkc_dOc3pNA_1748373536
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E7CE19560BC;
	Tue, 27 May 2025 19:18:56 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.2])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3A4019560A3;
	Tue, 27 May 2025 19:18:54 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neil@brown.name>, Rick Macklem <rick.macklem@gmail.com>,
 Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>,
 Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
Date: Tue, 27 May 2025 15:18:52 -0400
Message-ID: <3DF74DD6-E300-4CDE-B8D9-EECD5F05BC8B@redhat.com>
In-Reply-To: <f679b62b-cbf3-4225-a163-870c65ff0c9b@oracle.com>
References: <> <d539c502-e776-460f-852c-8af9722ad9f8@oracle.com>
 <174821817646.608730.16435329287198176319@noble.neil.brown.name>
 <f679b62b-cbf3-4225-a163-870c65ff0c9b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 27 May 2025, at 11:05, Chuck Lever wrote:

> On 5/25/25 8:09 PM, NeilBrown wrote:
>> On Mon, 26 May 2025, Chuck Lever wrote:
>>> On 5/20/25 9:20 AM, Chuck Lever wrote:
>>>> Hiya Rick -
>>>>
>>>> On 5/19/25 9:44 PM, Rick Macklem wrote:
>>>>
>>>>> Do you also have some configurable settings for if/how the DNS
>>>>> field in the client's X.509 cert is checked?
>>>>> The range is, imho:
>>>>> - Don't check it at all, so the client can have any IP/DNS name (a mobile
>>>>>   device). The least secure, but still pretty good, since the ert. verified.
>>>>> - DNS matches a wildcard like *.umich.edu for the reverse DNS name for
>>>>>    the client's IP host address.
>>>>> - DNS matches exactly what reverse DNS gets for the client's IP host address.
>>>>
>>>> I've been told repeatedly that certificate verification must not depend
>>>> on DNS because DNS can be easily spoofed. To date, the Linux
>>>> implementation of RPC-with-TLS depends on having the peer's IP address
>>>> in the certificate's SAN.
>>>>
>>>> I recognize that tlshd will need to bend a little for clients that use
>>>> a dynamically allocated IP address, but I haven't looked into it yet.
>>>> Perhaps client certificates do not need to contain their peer IP
>>>> address, but server certificates do, in order to enable mounting by IP
>>>> instead of by hostname.
>>>>
>>>>
>>>>> Wildcards are discouraged by some RFC, but are still supported by OpenSSL.
>>>>
>>>> I would prefer that we follow the guidance of RFCs where possible,
>>>> rather than a particular implementation that might have historical
>>>> reasons to permit a lack of security.
>>>
>>> Let me follow up on this.
>>>
>>> We have an open issue against tlshd that has suggested that, rather
>>> than looking at DNS query results, the NFS server should authorize
>>> access by looking at the client certificate's CN. The server's
>>> administrator should be able to specify a list of one or more CN
>>> wildcards that can be used to authorize access, much in the same way
>>> that NFSD currently uses netgroups and hostnames per export.
>>>
>>> So, after validating the client's CA trust chain, an NFS server can
>>> match the client certificate's CN against its list of authorized CNs,
>>> and if the client's CN fails to match, fail the handshake (or whatever
>>> we need to do).
>>>
>>> I favor this approach over using DNS labels, which are often
>>> untrustworthy, and IP addresses, which can be dynamically reassigned.
>>>
>>> What do you think?
>>
>> I completely agree with this.  IP address and DNS identity of the client
>> is irrelevant when mTLS is used.  What matters is whether the client has
>> authority to act as one of the the names given when the filesystem was
>> exported (e.g. in /etc/exports).  His is exacly what you said.
>>
>> Ideally it would be more than just the CN.  We want to know both the
>> domain in which the peer has authority (e.g.  example.com) and the type
>> of authority (e.g.  serve-web-pages or proxy-file-access or
>> act-as-neilb).
>> I don't know internal details of certificates so I don't know if there
>> is some other field that can say "This peer is authorised to proxy file
>> access requests for all users in the given domain" or if we need a hack
>> like exporting to nfs-client.example.com.
>>
>> But if the admin has full control of what names to export to, it is
>> possible that the distinction doesn't matter.  I wouldn't want the
>> certificate used to authenticate my web server to have authority to
>> access all files on my NFS server just because the same domain name
>> applies to both.
>
> My thought is that, for each handshake, there would be two stages:
>
> 1. Does the NFS server trust the certificate? This is purely a chain-of-
>    trust issue, so validating the certificate presented by the client is
>    the order of the day.
>
> 2. Does the NFS server authorize this client to access the export? This
>    is a check very similar to the hostname/netgroup/IP address check
>    that is done today, but it could be done just once at handshake time.
>    Match the certificate's fields against a per-export filter.
>
> I would take tlshd out of the picture for stage 2, and let NFSD make its
> own authorization decisions. Because an NFS client might be authorized
> to access some exports but not others.
>
> So:
>
> How does the server indicate to clients that yes, your cert is trusted,
> but no, you are not authorized to access this file system? I guess that
> is an NFS error like NFSERR_STALE or NFS4ERR_WRONGSEC.
>
> What certificate fields should we implement matches for? CN is obvious.
> But what about SAN? Any others? I say start with only CN, but I'd like
> to think about ways to make it possible to match against other fields in
> the future.
>
> What would the administrative interface look like? Could be the machine
> name in /etc/exports, for instance:
>
> *,OU="NFS Bake-a-thon",*   rw,sec=sys,xprtsec=mtls,fsid=42
>
> But I worry that will not be flexible enough. A more general filter
> mechanism might need something like the ini file format used to create
> CSRs.

It might be useful to make the kernel's authorization based on mapping to a
keyword that tlshd passes back after the handshake, and keep the more
complicated logic of parsing certificate fields and using config files up in
ktls-utils userspace.  I'm imagining something like this in /etc/exports:

/exports *(rw,sec=sys,xprtsec=mtls,tlsauth=any)
/exports/home *(rw,sec=sys,xprtsec=mtls,tlsauth=users)

.. and then tlshd would do the work to create a map of authorized
certificate identities mapped to a keyword, something like:

CN=*                any
CN=*.nfsv4bat.org   users
SHA1=4EB6D578499B1CCF5F581EAD56BE3D9B6744A5E5   bob

I imagine more flexible or complex rule logic might be desired in the
future, and having that work land in ktls-utils would be nicer than having
to do kernel work or handling various bits of certificate logic or reverse
lookups in-kernel.

> What about pre-shared keys? No certificate fields there.

Same idea would work for those - list/map them to a keyword set on the
export.

Ben


