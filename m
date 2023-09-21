Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312167AA26C
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Sep 2023 23:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjIUVRI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Sep 2023 17:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjIUVPn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Sep 2023 17:15:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22659005
        for <linux-nfs@vger.kernel.org>; Thu, 21 Sep 2023 10:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695315939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hR3mF7MJEijT29cqf3NUsmjuXwPHm62/tFp0nkWOtU8=;
        b=UhqH+97PiO2PJRnuzvTi544pcdBczdlzN2RL4gQAwcueJZ1HLUsSBFnA7LOHt60UC4d9Nw
        wOTwx5WBgtm196WzlrPsjY16uGSe9fkOyKSEhWY71X9WhRYi5gnqXAZnJTkdj+RsBi9TfC
        91ig83I4mv24+BO8Ub4HHyCrZvhVCtM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-2DABMSmNPJ6eSE5MsuYXKg-1; Thu, 21 Sep 2023 09:49:54 -0400
X-MC-Unique: 2DABMSmNPJ6eSE5MsuYXKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A2C92802520;
        Thu, 21 Sep 2023 13:49:54 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3D8651E3;
        Thu, 21 Sep 2023 13:49:53 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Charles Hedrick <hedrick@rutgers.edu>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: bad info in NFS context
Date:   Thu, 21 Sep 2023 09:49:52 -0400
Message-ID: <650954F9-F67D-4F62-AD7B-4D16DF45E168@redhat.com>
In-Reply-To: <PH0PR14MB5493AB9814249EC5D66E635DAAF8A@PH0PR14MB5493.namprd14.prod.outlook.com>
References: <PH0PR14MB5493ED33985C95FEBE4DA808AAF9A@PH0PR14MB5493.namprd14.prod.outlook.com>
 <B7D023CD-2810-4BD6-8570-AB0C0EE95287@redhat.com>
 <PH0PR14MB5493AB9814249EC5D66E635DAAF8A@PH0PR14MB5493.namprd14.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 21 Sep 2023, at 9:36, Charles Hedrick wrote:

> this is a web app. What is it about logging out and logging in that cle=
ars the cache? We'll need to make sure that the web app does it.

There's a very real performance tradeoff to perform NFS ACCESS operations=
 for every part of a tree walk vs. caching the results of previous ACCESS=
 calls.  There's not a sane way for the client to know when a user's grou=
p membership has changed in order to invalidate the cache, since the chan=
ge to the user's group membership is not reflected on the inodes themselv=
es.  So, the NFS client will keep caching the result of previous calls to=
 unchanged inodes until it notices that the process' oldest parent with t=
he same user/credential has a task start_time that is older than the curr=
ently cached entries.

TL;DR - you probably want to restart the web server.

Ben


> ________________________________
> From: Benjamin Coddington <bcodding@redhat.com>
> Sent: Thursday, September 21, 2023 6:44 AM
> To: Charles Hedrick <hedrick@rutgers.edu>
> Cc: linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>
> Subject: Re: bad info in NFS context
>
> On 20 Sep 2023, at 19:14, Charles Hedrick wrote:
>
>> Ubuntu 22 client and server (5.15). Mount is 4.2, sec=3Dsys. I add a u=
ser to a group, but they can't see things that the group should be able t=
o see. /proc/net/rpc/auth.unix.gid/content shows that the nfs group cache=
 has their group membership. Doing a mount -o vers=3D4.1 works (4.1 to fo=
rce a different context). Other users that didn't try before work. It's b=
een several hours, and 4.2 still won't work for this user.
>>
>> What do I need to flush?
>>
>> Note that I'm using gssproxy on the server.
>
> Have the user log out and then back in again after the group change, th=
at
> should cause the user's NFS ACCESS cache to clear.
>
> Ben

