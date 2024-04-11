Return-Path: <linux-nfs+bounces-2767-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 112A38A1EA6
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 20:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C4E1C24637
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 18:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151D753E36;
	Thu, 11 Apr 2024 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAtJrBJ7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC3053E2D
	for <linux-nfs@vger.kernel.org>; Thu, 11 Apr 2024 18:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859650; cv=none; b=UNg/TxvSkDWrPG3k50ODgCb82Byq0a5DOw0SDtMtGftw5NmJTI+nIRTwmZiLv2Dv8IYPO/HcIamiTwskYU9qDxXA8X8d4QyrwlsAqVodcS4RNDkdUyLKGDbAvZ4XM6dSd11TP67VDQOdBi5/tx0EN/PPcRM9QrcgHOlWbYwsmuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859650; c=relaxed/simple;
	bh=fWPcdrVuruTE7BJmuZZeKdfX4Wem7YZa3XVObcOI1+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQpjb5La7h7sC1Ca9q1eU+SbYVNvVeIbB6WE2d84vZJRNiJbt5XvhN34Go4Z2kiA8aiMlwpHXh++lEjqufdrNul7y7NhQX8/ZhYKJDrhHpTJXvzhK7s6hCViuUqwX4iluU8OIcg//0SgRlJHY7Gfm+5VHsMihn9lg2KK9+VCuLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZAtJrBJ7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712859647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVRGbK8WGUx9STMEDci0xeHmXB4wKU5q7KxMHo5tRAo=;
	b=ZAtJrBJ7/EJU9C7lHxa56hXsv5m/VGhgZ1aGZUzy0NiXuqudtTZqpBXsbw/CoGN0mHsBnn
	9pw/MGgIKebZ3KGVHBzFKQVYJ4b46ffiXhVLAJ/aQt8TVas4oHsMFzBwzJd98D8/AfNpe8
	teKME9oQiSbwb0+zjHMxhAYjr+0jucc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-hr91uJW9OWmEvZSQncOy0w-1; Thu,
 11 Apr 2024 14:20:45 -0400
X-MC-Unique: hr91uJW9OWmEvZSQncOy0w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 353DE293248B;
	Thu, 11 Apr 2024 18:20:45 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-15.rdu2.redhat.com [10.22.0.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 85BFB10E47;
	Thu, 11 Apr 2024 18:20:44 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Dan Aloni <dan.aloni@vastdata.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: mount options not propagating to NFSACL and NSM RPC clients
Date: Thu, 11 Apr 2024 14:20:43 -0400
Message-ID: <34B155CC-6E09-4C53-9CC0-3B9F0D2C97B9@redhat.com>
In-Reply-To: <20240411163628.jtnhu3pxgcskvel6@gmail.com>
References: <20231105154857.ryakhmgaptq3hb6b@gmail.com>
 <80B8993C-645D-4748-93B3-88415E165B87@redhat.com>
 <20231129132034.lz3hag5xy2oaojwq@gmail.com>
 <8FDECCA5-80E0-4CB4-B790-4039102916F0@redhat.com>
 <20240410143944.srhfeq6owfvdxcci@gmail.com>
 <5D6491EA-53CF-488C-B1D6-A77A8CDFFDC8@redhat.com>
 <20240411163628.jtnhu3pxgcskvel6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 11 Apr 2024, at 12:36, Dan Aloni wrote:

> On 2024-04-11 11:20:14, Benjamin Coddington wrote:
>>> So looks like the request is not being retransmitted. Just to be sure=
,
>>> if I cause the nfsd to drop the regular NFS3 prog I/Os like ACCESS an=
d
>>> LOOKUP, I only get the expected 5 seconds delay following a successfu=
l
>>> retry.
>>>
>>> Seems we only have an issue with the NFS3ACL prog.
>>
>> It looks like the client_acl program gets created with
>> rpc_bind_new_program() which doesn't setup the timeouts/retry strategy=
, and
>> there's nothing after the setup to do it either.
>>
>> I think the problem has existed since 331702337f2b2..  I think this sh=
ould
>> fix it up, would you like to test it?
>
> Please allow me to propose a different change, which I already tested.
>
> Looks to me that the 2012 change that I mentioned below is actually whe=
n
> the problem started happening, when the `kmemdup` call was removed, so
> since then we are simply just missing a field copy, and we are taking
> the timeout from transport-based default timeout globals instead.
>
> Also, I have a hunch that we need to do something different, because of=

> the following code in `rpc_new_client`:
>
>     clnt->cl_rtt =3D &clnt->cl_rtt_default;
>     rpc_init_rtt(&clnt->cl_rtt_default, clnt->cl_timeout->to_initval);
>
> Only setting `clnt->cl_timeout` _after_ client clone does not seem to b=
e
> right if there are `cl_rtt_default` calculations that depend on it. So
> may as well need to call `rpc_init_rtt` too.
>
> --
>
> From 55737f82a9bb3e490836d10491995c8082ebcf11 Mon Sep 17 00:00:00 2001
> From: Dan Aloni <dan.aloni@vastdata.com>
> Date: Thu, 11 Apr 2024 18:30:56 +0300
> Subject: [PATCH] sunrpc: fix NFSACL RPC retry on soft mount
>
> It used to be quite awhile ago since 1b63a75180c6 ('SUNRPC: Refactor
> rpc_clone_client()'), in 2012, that `cl_timeout` was copied in so that
> all mount parameters propagate to NFSACL clients. However since that
> change, if mount options as follows are given:
>
>     soft,timeo=3D50,retrans=3D16,vers=3D3
>
> The resultant NFSACL client receives:
>
>     cl_softrtry: 1
>     cl_timeout: to_initval=3D60000, to_maxval=3D60000, to_increment=3D0=
, to_retries=3D2, to_exponential=3D0
>
> These values lead to NFSACL operations not being retried under the
> condition of transient network outages with soft mount. Instead, getacl=

> call fails after 60 seconds with EIO.
>
> The simple fix is to copy `cl_timeout` and make sure `cl_rtt_default`
> is initialized from it.

Ah, good catch, and I think this means that the normal IO client
(server->client) hasn't been properly setting up its RTT estimator as wel=
l?

> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Benjamin Coddington <bcodding@redhat.com>
> Link: https://lore.kernel.org/all/20231105154857.ryakhmgaptq3hb6b@gmail=
=2Ecom/T/
> Fixes: 1b63a75180c6 ('SUNRPC: Refactor rpc_clone_client()')
> Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
> ---
>  net/sunrpc/clnt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index cda0935a68c9..75faf1f05a14 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -669,6 +669,9 @@ static struct rpc_clnt *__rpc_clone_client(struct r=
pc_create_args *args,
>  	new->cl_chatty =3D clnt->cl_chatty;
>  	new->cl_principal =3D clnt->cl_principal;
>  	new->cl_max_connect =3D clnt->cl_max_connect;
> +	new->cl_timeout =3D clnt->cl_timeout;
> +	rpc_init_rtt(&clnt->cl_rtt_default, clnt->cl_timeout->to_initval);
> +

So we'll end up doing rpc_init_rtt twice, first in rpc_new_client then he=
re.
Maybe we should be passing cl_timeout on .timeout from the parent in the
rpc_clone_client()'s rpc_create_args?

=2E. anyway - I'll stop "helping", you've clearly got this in hand.  :)

Ben


