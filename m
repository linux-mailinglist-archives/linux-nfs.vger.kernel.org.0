Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA56A4A7087
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Feb 2022 13:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239241AbiBBMNr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Feb 2022 07:13:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231929AbiBBMNq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Feb 2022 07:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643804026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7gaU2Z9cpWAmzMDzFx0jFF5c+fnzCN369K/gfMxI7y8=;
        b=a29Oz0Vzar3WG2Hc7NeZk7ZUy38uL4Fg1LI9gIGkize47N83u0sjUcDkW+CD5db2x4KGdg
        aOCd9gD+z+1OkLj7+SMVFWUoPIBxUF5h6j5IAXQm2IeOOGGjfYf3Cg+on4Lqy2DmJP4cTs
        ZJTVID+FviB96xN2aKgQ8soEsrWGD0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-7oS90jDmPJG3y7k8eFN1eg-1; Wed, 02 Feb 2022 07:13:45 -0500
X-MC-Unique: 7oS90jDmPJG3y7k8eFN1eg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A4431006AA3;
        Wed,  2 Feb 2022 12:13:44 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC1772376E;
        Wed,  2 Feb 2022 12:13:43 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Simon Kirby" <sim@hostway.ca>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: Cache flush on file lock
Date:   Wed, 02 Feb 2022 07:13:42 -0500
Message-ID: <C5E4C867-7156-453E-B22C-75FAF5246D92@redhat.com>
In-Reply-To: <20220202014111.GA7467@hostway.ca>
References: <20220202014111.GA7467@hostway.ca>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 1 Feb 2022, at 20:41, Simon Kirby wrote:

> Hello!
>
> I noticed high traffic in an NFS environment and tracked it down to some
> users who moved SQLite databases over from previously-local storage.
>
> The usage pattern of SQLite here seems particularly bad on NFSv3 clients,
> where a combination of F_RDLCK to F_WRLCK upgrading and locking polling
> is entirely discarding the cache for other processes on the same client.
>
> Our load balancing configuration typically sticks most file accesses to
> individual hosts (NFS clients), so I figured it was time to re-evaluate
> the status of NFSv4 and file delegations here, since the files could be
> delegated to one client, and then maybe the page cache could work as it
> does on a local file system. It turns out this isn't happening...
>
> First, it seems that SQLite always opens the file O_RDWR. knfsd does not
> seem to create a delegation in this case; I see it only for O_RDONLY.
>
> Second, it seems that do_setlk() in fs/nfs/file.c always nfs_zap_caches()
> unless there's a ->have_delegation(inode, FMODE_READ). That condition has
> changed slightly over the years, but the basic concept of invalidating
> the cache in do_setlk has been around since pre-git.
>
> Since it seems like there's the intention to preserve cache with a read
> delegation, I wrote a simplified testcase to simulate SQLite locking.
>
> With the open changed to O_RDONY (and F_RDLCK only), the v3 mount and
> server show "POSIX ADVISORY READ" in /proc/locks. The v4 mount shows
> "DELEG ACTIVE READ" on the server and "POSIX ADVISORY READ" on the
> client.
>
> With O_RDONLY, I can see that cache is zapped following F_RDLCK on v3 and
> not zapped on v4, so this appears to be working as expected.
>
> With O_RDWR restored, both server and client show "POSIX ADVISORY READ"
> with v3 or v4 mounts, and since there is no read delegation, the cache
> gets zapped.
>
> RFC 8881 10.4.2 seems to talk about locking when an OPEN_DELEGATE_WRITE
> delegation is present, so it seems this was perhaps intended to work.
>
> How far off would we be from write delegations happening here?

The linux server doesn't have write delegations implemented yet, I suspect
that's why you're not seeing them.

Ben

