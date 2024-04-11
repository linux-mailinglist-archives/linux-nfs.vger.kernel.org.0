Return-Path: <linux-nfs+bounces-2756-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0966D8A1881
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 17:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9DDDB289B1
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC230DF6C;
	Thu, 11 Apr 2024 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDJ4baxJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB439D52E
	for <linux-nfs@vger.kernel.org>; Thu, 11 Apr 2024 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848821; cv=none; b=VlCFjrOKdviuzYDatMZ64vUXgb5unp55lbtuFFjtF/7w2SM6OUUa7F2QjAld1zlkmen7+5bTA8B8t9aetnXJ5DQsU4navtrL8DXZhsHMay8gS4z7xu+/P4TRdwXy7TCn8RcL7Rxv+0m4+Yit4OUB5nWDQ4Qid4kVQ2+prwk41Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848821; c=relaxed/simple;
	bh=mMGSKvyxuwdFX/EORP5+8SuWAygeJ5r95hJAvY96DSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISdW87QooW0RkxzAQNVOH+WXCgjqM5xWk7/bdIJbrCqbgUl73hztKSuJFaEqC5a0UWYo8KkiSzkOBTiK0ddrJuYCsXDCB8HYStVaiVcGoloKtemOuh8i9+91usA915eBJl9S75SJ8kYZywmH43kL4DeQ2xY3Sf46nX7PEofdDko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDJ4baxJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712848818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vi/4Mo2ijkY+CckSSUKtVfLKGhtKQtvTpAQY2d0PAVk=;
	b=ZDJ4baxJWuOXOHXpoH+cDXcUDu7odfjw1A1o7AOd9p2pS7jKlyLEWsZCKt9WJXtP2bVsLM
	amkddEKDs8l9gpHQF7t8TihLirmo2pOlNQSnfRfTcMwWsbLJ9lQnqTnmiXulwrkckH/aZu
	4zi2p6WgZMFtQpztdm1/ZbbcPiji9IM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-50PuzRgHPIWyzGY5WckQmQ-1; Thu, 11 Apr 2024 11:20:16 -0400
X-MC-Unique: 50PuzRgHPIWyzGY5WckQmQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A89858007BA;
	Thu, 11 Apr 2024 15:20:16 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-15.rdu2.redhat.com [10.22.0.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 320C0C13FB4;
	Thu, 11 Apr 2024 15:20:16 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Dan Aloni <dan.aloni@vastdata.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: mount options not propagating to NFSACL and NSM RPC clients
Date: Thu, 11 Apr 2024 11:20:14 -0400
Message-ID: <5D6491EA-53CF-488C-B1D6-A77A8CDFFDC8@redhat.com>
In-Reply-To: <20240410143944.srhfeq6owfvdxcci@gmail.com>
References: <20231105154857.ryakhmgaptq3hb6b@gmail.com>
 <80B8993C-645D-4748-93B3-88415E165B87@redhat.com>
 <20231129132034.lz3hag5xy2oaojwq@gmail.com>
 <8FDECCA5-80E0-4CB4-B790-4039102916F0@redhat.com>
 <20240410143944.srhfeq6owfvdxcci@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 10 Apr 2024, at 10:39, Dan Aloni wrote:

> On 2023-11-30 09:30:52, Benjamin Coddington wrote:
>>> Actually my concern is the NFSACL prog. With `cl_softrtrt =3D=3D 1` a=
nd
>>> `to_initval =3D=3D to_maxval`, does it mean retires will not happen
>>> regardless of `to_retries` and `to_increment`?
>>
>> Possibly?  I'm not exactly certain of what should happen in that case.=

>>
>>> I encountered a situation where the NFSACL program did not retry but
>>> could have had, whereas NFS3 did successfully. Not sure regarding NSM=
,
>>> but it seems to me that it would make sense at least for NFSACL to
>>> behave the same as NFS3.
>>
>> I agree, but I could be missing something -- maybe its a bug.  There's=
 the
>> sunrpc:rpc_timeout_status tracepoint that might be helpful.  If you tu=
rn
>> that up can you see rpc_check_timeout() getting called from
>> call_transmit_status()?
>
> Sorry, took awhile to get a test working while busy on other stuff.
>
> So it looks really like a bug, here are the details.
>
> Server: nfsd with extra fault injection code that calls `svc_drop()` on=
ly once
> on a single NFS GETACL request.
> Client: Linux v6.8, NFS mount with `soft,timeo=3D50,retrans=3D16,vers=3D=
3`.
>
> I trace client execution with the following:
>
>     sudo perf trace -e sunrpc:rpc_task_timeout -e sunrpc:xprt_retransmi=
t
>
> A simple `ls -l` gets stuck and shows an IO failure:
>
>     [root@client export]# ls -l
>     ls: file: Input/output error
>     total 0
>     -rw-r--r-- 1 root root 0 Apr 10 10:02 file
>
> I get a single event out of the tracing above:
>
> ```
> kthreadd/7926 sunrpc:rpc_task_timeout(task_id: 203, client_id: 6, xprt_=
id: 3, action: 0xffffffffc0accc60, runstate: 22, flags: 35456)
> ```
>
> So looks like the request is not being retransmitted. Just to be sure,
> if I cause the nfsd to drop the regular NFS3 prog I/Os like ACCESS and
> LOOKUP, I only get the expected 5 seconds delay following a successful
> retry.
>
> Seems we only have an issue with the NFS3ACL prog.

It looks like the client_acl program gets created with
rpc_bind_new_program() which doesn't setup the timeouts/retry strategy, a=
nd
there's nothing after the setup to do it either.

I think the problem has existed since 331702337f2b2..  I think this shoul=
d
fix it up, would you like to test it?

Ben

---

=46rom 54a35f530d78a8042dc6fb8ff522f5a4a33fa50b Mon Sep 17 00:00:00 2001
Message-ID: <54a35f530d78a8042dc6fb8ff522f5a4a33fa50b.1712848680.git.bcod=
ding@redhat.com>
From: Benjamin Coddington <bcodding@redhat.com>
Date: Thu, 11 Apr 2024 11:03:06 -0400
Subject: [PATCH] NFS: Set v3 ACL client default timeout values

It appears the client_acl rpc_clnt doesn't take any timeout values, so
retries for the ACL procedures are never attempted.  Set them based on th=
e
mount's default timeout values.

Reported-by: Dan Aloni <dan.aloni@vastdata.com>
Fixes: 331702337f2b ("NFS: Support per-mountpoint timeout parameters.")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs3client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index b0c8a39c2bbd..66bb1f56c5d9 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -33,6 +33,7 @@ static void nfs_init_server_aclclient(struct nfs_server=
 *server)
        if (IS_ERR(server->client_acl))
                goto out_noacl;

+       server->client_acl->cl_timeout =3D &server->client->cl_timeout_de=
fault;
        nfs_sysfs_link_rpc_client(server, server->client_acl, NULL);

        /* No errors! Assume that Sun nfsacls are supported */
-- =

2.44.0


