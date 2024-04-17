Return-Path: <linux-nfs+bounces-2879-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9129B8A8551
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 15:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C56F28238F
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 13:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB5913E049;
	Wed, 17 Apr 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QH9woyJx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1CC140360
	for <linux-nfs@vger.kernel.org>; Wed, 17 Apr 2024 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361919; cv=none; b=ubLsID/aAqVmsUWvXe1UNKktQVWCJ5O59EsbeReV/ZCo0d0FLjrGpm+l/Uib7va17DZcACVlywm7Gdt7KGkwAvdVkkzCqtuLz/FRqF3IBbkpGeLLHAhXImqa56YXF9lgFDSIGP44VkKsSy5y2T7kpqoDr1GV3uCRypnyi7k7tSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361919; c=relaxed/simple;
	bh=doTZgNGyANzH/31znETt6sRCY6HSeKd8t61HBIGc+xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VcK9LPIqnbIAuRNXzCMvujRa63t3hEOqQkZsU7phCWFE+Qj2XAhkAeN2QgZT7UESVTekIU3mfGFp92LQZcwpxZ3BqXyWu7fqZ5FchlPjvMk4z42WEBB8xmDVLgTq2F8xKIBzf6M1AGxodOfsgr3YRlUyYRAGQWCZfUfXuPGjZi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QH9woyJx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713361915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUkidvkR8fAFJWLFZBeksHWi3hNhANqwYoB/YpH7zPc=;
	b=QH9woyJxwevE7XQeuEHTJXRKHFv7gPwvtLwjfm9QvGuyHiRT9DKpMJn9WxuIQdP8pGLypk
	jTdp07KmqAChs4S8nRx6TeLabJNgq/XxR6EPptpV2xQaKxe3PYNZTkTHFLjMtlUqqSleCo
	aCMLWsuM6MipLy58vXd4POYJMV9s2X4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-k4ykGEfzMLCbbc3aG2_EBg-1; Wed, 17 Apr 2024 09:51:51 -0400
X-MC-Unique: k4ykGEfzMLCbbc3aG2_EBg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2537806528;
	Wed, 17 Apr 2024 13:51:50 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-6.rdu2.redhat.com [10.22.0.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CC9A492BD4;
	Wed, 17 Apr 2024 13:51:50 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [bug report] NFSv4: Fix free of uninitialized nfs4_label on
 referral lookup.
Date: Wed, 17 Apr 2024 09:51:48 -0400
Message-ID: <F0002E44-B2E9-4DE3-BF3B-771F814A8EE1@redhat.com>
In-Reply-To: <7c4df27b-9698-4d49-a35f-9395b75348d3@moroto.mountain>
References: <ae03a217-e643-4127-bb4a-4993ad6a9d00@moroto.mountain>
 <13EE0F08-5567-48B8-A7C2-88A086FBDA89@redhat.com>
 <7c4df27b-9698-4d49-a35f-9395b75348d3@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 17 Apr 2024, at 8:40, Dan Carpenter wrote:

> On Wed, Apr 17, 2024 at 08:00:04AM -0400, Benjamin Coddington wrote:
>> On 15 Apr 2024, at 4:08, Dan Carpenter wrote:
>>
>>> [ Why is Smatch only complaining now, 2 years later??? It is a myster=
y.
>>>   -dan ]
>>>
>>> Hello Benjamin Coddington,
>>
>> Hi Dan!
>>
>>> Commit c3ed222745d9 ("NFSv4: Fix free of uninitialized nfs4_label on
>>> referral lookup.") from May 14, 2022 (linux-next), leads to the
>>> following Smatch static checker warning:
>>>
>>> 	fs/nfs/nfs4state.c:2138 nfs4_try_migration()
>>> 	warn: missing error code here? 'nfs_alloc_fattr()' failed. 'result' =
=3D '0'
>>>
>>> fs/nfs/nfs4state.c
>>>     2115 static int nfs4_try_migration(struct nfs_server *server, con=
st struct cred *cred)
>>>     2116 {
>>>     2117         struct nfs_client *clp =3D server->nfs_client;
>>>     2118         struct nfs4_fs_locations *locations =3D NULL;
>>>     2119         struct inode *inode;
>>>     2120         struct page *page;
>>>     2121         int status, result;
>>>     2122
>>>     2123         dprintk("--> %s: FSID %llx:%llx on \"%s\"\n", __func=
__,
>>>     2124                         (unsigned long long)server->fsid.maj=
or,
>>>     2125                         (unsigned long long)server->fsid.min=
or,
>>>     2126                         clp->cl_hostname);
>>>     2127
>>>     2128         result =3D 0;
>>>                  ^^^^^^^^^^^
>>>
>>>     2129         page =3D alloc_page(GFP_KERNEL);
>>>     2130         locations =3D kmalloc(sizeof(struct nfs4_fs_location=
s), GFP_KERNEL);
>>>     2131         if (page =3D=3D NULL || locations =3D=3D NULL) {
>>>     2132                 dprintk("<-- %s: no memory\n", __func__);
>>>     2133                 goto out;
>>>                          ^^^^^^^^
>>> Success.
>>>
>>>     2134         }
>>>     2135         locations->fattr =3D nfs_alloc_fattr();
>>>     2136         if (locations->fattr =3D=3D NULL) {
>>>     2137                 dprintk("<-- %s: no memory\n", __func__);
>>> --> 2138                 goto out;
>>>                          ^^^^^^^^^
>>> Here too.
>>
>> My patch was following the precedent set by c9fdeb280b8cc.  I believe =
the
>> idea is that the function can fail without an error and the client wil=
l
>> retry the next time the server says -NFS4ERR_MOVED.
>>
>> Is there a way to appease smatch here?  I don't have a lot of smatch
>> smarts.
>
> Generally, I tell people to just ignore it.  Anyone with questions can
> look up this email thread.
>
> But if you really wanted to silence it, Smatch counts it as intentional=

> if the "result =3D 0;" is within five lines of the goto out.

Good to know!  In this case, I think the maintainers would show annoyance=

with that sort of patch.  A comment here about the successful return code=
 on
an allocation failure would have avoided this, and I probably should have=

recognized this patch might create an issue and inserted one.  Thanks for=

the report.

Ben


