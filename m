Return-Path: <linux-nfs+bounces-2884-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 416B78A8B20
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 20:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15D42874A1
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 18:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECCD8821;
	Wed, 17 Apr 2024 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bV0+jZl2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCCC1CD38
	for <linux-nfs@vger.kernel.org>; Wed, 17 Apr 2024 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713378631; cv=none; b=LK54sNtnkOWlq4/Q8o4ziakczm46LxugRf7KcBtlqyfkud8uDPaIk/ZdEGibwQCx6wqnmuplbI3fieuzdAf4XgPAULxbPgiQt9NYD+kF9ARFDyObFPfsrs+9pVom35S+4Ed53BKVilpeXOETwbniRjmVavONSlmQqZnzFYBdzUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713378631; c=relaxed/simple;
	bh=uo9RxHiecfvswW097Fp061G0TgFrS/stB+OYR3FrxTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxlG8KNeLoekiP2Qt3vxuLkqsoYHCb/QIWoDSJGe0ROwpOIuMJPSBT7gqLgwAoZ+78K7dE6l8bLNXFSxrKg7csgK8y0sYUsgqIWxuSm36Hvy4fNFWhl/Ow1LzEp0Yx/1LoO+xDtgIhzQX0GOqrrC2HSh8+8ee8tU/SxUqcerB5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bV0+jZl2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713378628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8imcLssB4c2a6Zu087kXR2qSlHZKETA1tZPm//Rx0qE=;
	b=bV0+jZl2EgjV6b4iT0fD22jsHFBHgEazMRk65jUebmEGkb0J39g+msDwW4B7zXHXhbRQdg
	tzU3iXsFk4L4dATmpP7bMMhADvvrDT4yXRLUBThoYgwZCR6WRveo/AF6ymRCtZo1vURBVx
	m6j8JpHNQ6MEQpEcxL8P4bgmYBOqnv0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-VH7ZkDlENMWZ_W9IZYl_qA-1; Wed, 17 Apr 2024 14:30:25 -0400
X-MC-Unique: VH7ZkDlENMWZ_W9IZYl_qA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74417104B507;
	Wed, 17 Apr 2024 18:30:25 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-6.rdu2.redhat.com [10.22.0.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CD217C2595D;
	Wed, 17 Apr 2024 18:30:24 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [bug report] NFSv4: Fix free of uninitialized nfs4_label on
 referral lookup.
Date: Wed, 17 Apr 2024 14:30:23 -0400
Message-ID: <749EE32A-D89E-4F3A-884C-54A788B9D1C2@redhat.com>
In-Reply-To: <ae7bbc2e-49c6-46df-8876-06b11dd551e5@moroto.mountain>
References: <ae03a217-e643-4127-bb4a-4993ad6a9d00@moroto.mountain>
 <13EE0F08-5567-48B8-A7C2-88A086FBDA89@redhat.com>
 <7c4df27b-9698-4d49-a35f-9395b75348d3@moroto.mountain>
 <F0002E44-B2E9-4DE3-BF3B-771F814A8EE1@redhat.com>
 <ae7bbc2e-49c6-46df-8876-06b11dd551e5@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 17 Apr 2024, at 11:08, Dan Carpenter wrote:

> On Wed, Apr 17, 2024 at 09:51:48AM -0400, Benjamin Coddington wrote:
>> On 17 Apr 2024, at 8:40, Dan Carpenter wrote:
>>
>>> On Wed, Apr 17, 2024 at 08:00:04AM -0400, Benjamin Coddington wrote:
>>>> On 15 Apr 2024, at 4:08, Dan Carpenter wrote:
>>>>
>>>>> [ Why is Smatch only complaining now, 2 years later??? It is a myst=
ery.
>>>>>   -dan ]
>>>>>
>>>>> Hello Benjamin Coddington,
>>>>
>>>> Hi Dan!
>>>>
>>>>> Commit c3ed222745d9 ("NFSv4: Fix free of uninitialized nfs4_label o=
n
>>>>> referral lookup.") from May 14, 2022 (linux-next), leads to the
>>>>> following Smatch static checker warning:
>>>>>
>>>>> 	fs/nfs/nfs4state.c:2138 nfs4_try_migration()
>>>>> 	warn: missing error code here? 'nfs_alloc_fattr()' failed. 'result=
' =3D '0'
>>>>>
>>>>> fs/nfs/nfs4state.c
>>>>>     2115 static int nfs4_try_migration(struct nfs_server *server, c=
onst struct cred *cred)
>>>>>     2116 {
>>>>>     2117         struct nfs_client *clp =3D server->nfs_client;
>>>>>     2118         struct nfs4_fs_locations *locations =3D NULL;
>>>>>     2119         struct inode *inode;
>>>>>     2120         struct page *page;
>>>>>     2121         int status, result;
>>>>>     2122
>>>>>     2123         dprintk("--> %s: FSID %llx:%llx on \"%s\"\n", __fu=
nc__,
>>>>>     2124                         (unsigned long long)server->fsid.m=
ajor,
>>>>>     2125                         (unsigned long long)server->fsid.m=
inor,
>>>>>     2126                         clp->cl_hostname);
>>>>>     2127
>>>>>     2128         result =3D 0;
>>>>>                  ^^^^^^^^^^^
>>>>>
>>>>>     2129         page =3D alloc_page(GFP_KERNEL);
>>>>>     2130         locations =3D kmalloc(sizeof(struct nfs4_fs_locati=
ons), GFP_KERNEL);
>>>>>     2131         if (page =3D=3D NULL || locations =3D=3D NULL) {
>>>>>     2132                 dprintk("<-- %s: no memory\n", __func__);
>>>>>     2133                 goto out;
>>>>>                          ^^^^^^^^
>>>>> Success.
>>>>>
>>>>>     2134         }
>>>>>     2135         locations->fattr =3D nfs_alloc_fattr();
>>>>>     2136         if (locations->fattr =3D=3D NULL) {
>>>>>     2137                 dprintk("<-- %s: no memory\n", __func__);
>>>>> --> 2138                 goto out;
>>>>>                          ^^^^^^^^^
>>>>> Here too.
>>>>
>>>> My patch was following the precedent set by c9fdeb280b8cc.  I believ=
e the
>>>> idea is that the function can fail without an error and the client w=
ill
>>>> retry the next time the server says -NFS4ERR_MOVED.
>>>>
>>>> Is there a way to appease smatch here?  I don't have a lot of smatch=

>>>> smarts.
>>>
>>> Generally, I tell people to just ignore it.  Anyone with questions ca=
n
>>> look up this email thread.
>>>
>>> But if you really wanted to silence it, Smatch counts it as intention=
al
>>> if the "result =3D 0;" is within five lines of the goto out.
>>
>> Good to know!  In this case, I think the maintainers would show annoya=
nce
>> with that sort of patch.  A comment here about the successful return c=
ode on
>> an allocation failure would have avoided this, and I probably should h=
ave
>> recognized this patch might create an issue and inserted one.  Thanks =
for
>> the report.
>
> To me ignoring it is fine or adding a comment is even better, but I als=
o
> think adding a bunch of "ret =3D 0;" assignments should not be as
> controversial as people make it out to be.
>
> It's just a style debate, right?  The compiler knows that ret is alread=
y
> zero and it's going to optimize them away.  So it doesn't affect the
> compiled code.
>
> You could add a comment /* ret is zero intentionally */ or you could
> just add a "ret =3D 0;".  Neither affects the compile code.  But to me,=
 I
> would prefer the code, because when I see the comment, then I
> immediately start scrolling back to see if ret is really zero.  I like
> when the code looks deliberate.  When you see a "ret =3D 0;" there isn'=
t
> any question about the author's intent.
>
> But again, I don't feel strongly about this.

I think we could refactor to try the allocation into a local variable, th=
at
should make smatch happier.  Something like:

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 662e86ea3a2d..5b452411e8fd 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2116,6 +2116,7 @@ static int nfs4_try_migration(struct nfs_server *se=
rver, const struct cred *cred
 {
        struct nfs_client *clp =3D server->nfs_client;
        struct nfs4_fs_locations *locations =3D NULL;
+       struct nfs_fattr *fattr;
        struct inode *inode;
        struct page *page;
        int status, result;
@@ -2125,19 +2126,16 @@ static int nfs4_try_migration(struct nfs_server *=
server, const struct cred *cred
                        (unsigned long long)server->fsid.minor,
                        clp->cl_hostname);

-       result =3D 0;
        page =3D alloc_page(GFP_KERNEL);
        locations =3D kmalloc(sizeof(struct nfs4_fs_locations), GFP_KERNE=
L);
-       if (page =3D=3D NULL || locations =3D=3D NULL) {
-               dprintk("<-- %s: no memory\n", __func__);
-               goto out;
-       }
-       locations->fattr =3D nfs_alloc_fattr();
-       if (locations->fattr =3D=3D NULL) {
+       fattr =3D nfs_alloc_fattr();
+       if (page =3D=3D NULL || locations =3D=3D NULL || fattr =3D=3D NUL=
L) {
                dprintk("<-- %s: no memory\n", __func__);
+               result =3D 0;
                goto out;
        }

+       locations->fattr =3D fattr;
        inode =3D d_inode(server->super->s_root);
        result =3D nfs4_proc_get_locations(server, NFS_FH(inode), locatio=
ns,
                                         page, cred);

I don't have a great way to test this code, though.  Seems mechanically
sane.

Ben


