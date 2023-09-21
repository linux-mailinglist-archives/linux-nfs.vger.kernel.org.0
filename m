Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA4D7A9AE2
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Sep 2023 20:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjIUSv1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Sep 2023 14:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjIUSvS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Sep 2023 14:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050C597964
        for <linux-nfs@vger.kernel.org>; Thu, 21 Sep 2023 10:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695318888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31Z/EDGw5AlOugCZk18IqlXvRlDqh5WnTJ1E9l/ruoE=;
        b=gycl4yMHmZ8M4m+A0tukAfNIPcY1Dymo/v4dtRYNel7Tqnt/aNH12qhkar4ghkIvhzckkT
        nz8P2Q3RD4le4R8dPjhZLgW24rBQloqa51gqBQL0cpaHeXBZufvs3yZg1wAoic3uhn8ce2
        xeODvHM2Wq8Eb1glQ3Vi4J453jbrUjs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-yMMbKJVsPGGBzL9Od6q7aw-1; Thu, 21 Sep 2023 10:38:24 -0400
X-MC-Unique: yMMbKJVsPGGBzL9Od6q7aw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DE9B185A797;
        Thu, 21 Sep 2023 14:38:24 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9311A1054FC0;
        Thu, 21 Sep 2023 14:38:23 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Charles Hedrick <hedrick@rutgers.edu>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: bad info in NFS context
Date:   Thu, 21 Sep 2023 10:38:22 -0400
Message-ID: <7B541D75-296B-4264-92BC-6154B84F2557@redhat.com>
In-Reply-To: <PH0PR14MB5493A8657F42289DBC301CC2AAF8A@PH0PR14MB5493.namprd14.prod.outlook.com>
References: <PH0PR14MB5493ED33985C95FEBE4DA808AAF9A@PH0PR14MB5493.namprd14.prod.outlook.com>
 <B7D023CD-2810-4BD6-8570-AB0C0EE95287@redhat.com>
 <PH0PR14MB5493AB9814249EC5D66E635DAAF8A@PH0PR14MB5493.namprd14.prod.outlook.com>
 <650954F9-F67D-4F62-AD7B-4D16DF45E168@redhat.com>
 <PH0PR14MB5493A8657F42289DBC301CC2AAF8A@PH0PR14MB5493.namprd14.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 21 Sep 2023, at 9:56, Charles Hedrick wrote:

> thanks. I can work with that info. Restarting the server isn't practica=
l. This is a large-scale system serving hundreds of students. We generall=
y keep it up uninterrupted for a whole semester.

By web server, I mean the process not the system.  Though, it must have a=
 lot of local state if you don't have it load-balanced and redundant, so =
maybe even restarting the process is impractical.

Without trying this, we're still guessing that it's the ACCESS cache.  Yo=
u should be able to do something like "sudo su - webserveruser" and that =
/should/ count as a login for that process, and so that process /should/ =
gain the access you need from the new membership.  Its worth a test to ma=
ke sure we're not actually dealing with a different problem.

>> =C2=A0So, the NFS client will keep caching the result of previous call=
s to unchanged inodes until it notices that the process' oldest parent wi=
th the same user/credential has a task start_time that is older than the =
currently cached entries.
>
> I trust you mean newer. This is jupyterhub, which likes to keep user pr=
ocesses around after logout and reattach when they login. But as long as =
we know what's going on, there's a way for a user to kill their processes=
 manually.

There's been some attempts to add an "fasc" or "nofasc" mount option to u=
pstream NFS client, which would modify the behavior of the client.  That'=
s not had a lot of traction (I think because the patch wants to change th=
e default behavior again).

It's possible to submit work to add a sysfs knob to flush the access cach=
e.. that could look like a full cache flush for everyone, or maybe upon w=
riting a uid to a sysfs file, a flush for cached entries.

Have to tried talking to your NFS client vendor about this problem?

Ben

