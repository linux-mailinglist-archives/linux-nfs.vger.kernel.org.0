Return-Path: <linux-nfs+bounces-2873-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DB18A82AC
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 14:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736881F21327
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 12:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8DB13CA9E;
	Wed, 17 Apr 2024 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMDh8XPM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6904A13CF94
	for <linux-nfs@vger.kernel.org>; Wed, 17 Apr 2024 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355213; cv=none; b=fHXn8ylD3lPdV761QKYUdDm36QFbC6dbs/V1dRa93JN6jTu5R+e7aydEEPWi7ruLMb4/wjiRKdO07Qf52RMdnWbXqMxzjAdsLp+XWi/qy2omtqt2Rccbi0ODyCrr02ef/2MkiM9gBiEmmfs/YVWJCD9jMmnDODLiqJLl8LkFte4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355213; c=relaxed/simple;
	bh=aRxMVm4dnPLJtjJcJ2b8vTZhKprQmDPGJPUnDo3YCus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=goviSmexeQgX7Pyl0/agT1zMRy6g3KbrYKWJYmn8vgnDbM8UoDy1R2vAQFh6vU693ADW1Oy5vVj1eO3jeIF4LfccNsnHNzDC2+MEm9wwHpf2lrWpHK+IV1FUmp/gRx/GmupFf0QIl0tyAalwalqx6Thh7rK/j7XRSoPFHz1Vc2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMDh8XPM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713355210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SpGL5oiHNymfpDBqRk6qFuboZq9jV5jtp3Gg9K4gvNo=;
	b=SMDh8XPMD96VejwkJ6B6/kJJYNdjC7vow4uhyr4Zvflf+/lhfNNPiz+/cYObJiS9f+T2/e
	zQX6npz/NaudOmJQryIwEiF2fHRVacWa85tFx4LIjnt6Ii/gOQ17UQPlmDeb7SsqDabB9U
	Q+ilmxMYxbEEbxgAowpu8HJklkcVlsk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-HK0yOyxVNj-XxJ9DXQGKCw-1; Wed,
 17 Apr 2024 08:00:06 -0400
X-MC-Unique: HK0yOyxVNj-XxJ9DXQGKCw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5017F3810D43;
	Wed, 17 Apr 2024 12:00:06 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-6.rdu2.redhat.com [10.22.0.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C4FA1C06667;
	Wed, 17 Apr 2024 12:00:05 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [bug report] NFSv4: Fix free of uninitialized nfs4_label on
 referral lookup.
Date: Wed, 17 Apr 2024 08:00:04 -0400
Message-ID: <13EE0F08-5567-48B8-A7C2-88A086FBDA89@redhat.com>
In-Reply-To: <ae03a217-e643-4127-bb4a-4993ad6a9d00@moroto.mountain>
References: <ae03a217-e643-4127-bb4a-4993ad6a9d00@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 15 Apr 2024, at 4:08, Dan Carpenter wrote:

> [ Why is Smatch only complaining now, 2 years later??? It is a mystery.
>   -dan ]
>
> Hello Benjamin Coddington,

Hi Dan!

> Commit c3ed222745d9 ("NFSv4: Fix free of uninitialized nfs4_label on
> referral lookup.") from May 14, 2022 (linux-next), leads to the
> following Smatch static checker warning:
>
> 	fs/nfs/nfs4state.c:2138 nfs4_try_migration()
> 	warn: missing error code here? 'nfs_alloc_fattr()' failed. 'result' = '0'
>
> fs/nfs/nfs4state.c
>     2115 static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred)
>     2116 {
>     2117         struct nfs_client *clp = server->nfs_client;
>     2118         struct nfs4_fs_locations *locations = NULL;
>     2119         struct inode *inode;
>     2120         struct page *page;
>     2121         int status, result;
>     2122
>     2123         dprintk("--> %s: FSID %llx:%llx on \"%s\"\n", __func__,
>     2124                         (unsigned long long)server->fsid.major,
>     2125                         (unsigned long long)server->fsid.minor,
>     2126                         clp->cl_hostname);
>     2127
>     2128         result = 0;
>                  ^^^^^^^^^^^
>
>     2129         page = alloc_page(GFP_KERNEL);
>     2130         locations = kmalloc(sizeof(struct nfs4_fs_locations), GFP_KERNEL);
>     2131         if (page == NULL || locations == NULL) {
>     2132                 dprintk("<-- %s: no memory\n", __func__);
>     2133                 goto out;
>                          ^^^^^^^^
> Success.
>
>     2134         }
>     2135         locations->fattr = nfs_alloc_fattr();
>     2136         if (locations->fattr == NULL) {
>     2137                 dprintk("<-- %s: no memory\n", __func__);
> --> 2138                 goto out;
>                          ^^^^^^^^^
> Here too.

My patch was following the precedent set by c9fdeb280b8cc.  I believe the
idea is that the function can fail without an error and the client will
retry the next time the server says -NFS4ERR_MOVED.

Is there a way to appease smatch here?  I don't have a lot of smatch
smarts.

Ben


