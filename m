Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3976F6FCA09
	for <lists+linux-nfs@lfdr.de>; Tue,  9 May 2023 17:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbjEIPRX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 May 2023 11:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbjEIPRW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 May 2023 11:17:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C0444BB
        for <linux-nfs@vger.kernel.org>; Tue,  9 May 2023 08:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683645392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MDzfBWP3pjVUkb9AGu0G6Wtedp0sdaxtshvvGxbi+yI=;
        b=h607FpYFhyhh3wT5wu64rYoBURz/TmV45C09o9xT/ayzrwRGL4LdE9EFtidUagxlZPYKxK
        iHIZLWu3VFTkp4KDei/GzBRyqhdfKXHSQqVQKq6XY1aReZlorOAgJ3aIFZKhHW9cW2Hvo5
        U0dDoIgnKvsaqdhzK87jPHg8TVkP4Vk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-r1aQFDHuN0SFkV1Y2ICV-Q-1; Tue, 09 May 2023 11:16:26 -0400
X-MC-Unique: r1aQFDHuN0SFkV1Y2ICV-Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80FD1895689;
        Tue,  9 May 2023 15:16:25 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F243C15BA0;
        Tue,  9 May 2023 15:16:24 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Chengen Du <chengen.du@canonical.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NFS: Add mount option 'nofasc'
Date:   Tue, 09 May 2023 11:16:23 -0400
Message-ID: <B9E03B97-F67C-48FC-B5EE-5B02E288C227@redhat.com>
In-Reply-To: <CAPza5qee7vHKwjwhS27xB8xXTgAFHEmv7eiFk6zGTUUc4s8=TQ@mail.gmail.com>
References: <20230411030248.53356-1-chengen.du@canonical.com>
 <CAPt2mGNqqDeRMeCSVh6oX_=nS0UcGCfhBfVcuaVG9HpdwVSzVg@mail.gmail.com>
 <CAPza5qee7vHKwjwhS27xB8xXTgAFHEmv7eiFk6zGTUUc4s8=TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 24 Apr 2023, at 21:41, Chengen Du wrote:

> Hi,
>
> May I ask if there are any concerns or opinions regarding the
> introduction of the new mount option?
> If there is a more suitable solution, we can discuss it, and I can
> work on implementing it.

I suspect there's some weariness of mount options, we have a lot of them and
they are not easily removed once implemented.  Additionally, requests to add
them usually can show the appropriate changes to the nfs-utils mount.nfs and
man pages required.  Incompleteness here may be the reason you're not
hearing back from a maintainer.

However, without guidance from a maintainer, you might end up doing extra
work trying to meet unclear standards.

There's a couple of other ways to address the access cache performance
"degradation" that was introduced by the changes that other folks
desperately needed for correctness.

We can change nfs_access_login_time to have a module parameter modifying
the behavior.  The downside is this would affect every mount.

We can grow a sysfs knob to change the behavior.  Downside is we only have
very preliminary sysfs scaffolding as of yet.

However, if you want to keep pushing for the mount option, I'd suggest doing
a v2 with the userspace patches, and if that gets ignored then do a "PATCH
RESEND" on that a month or so before each mainline merge window.

I've found that bump-replying to old patches isn't as effective at getting
work merged here.  I believe the maintainers want to see that you're
rebasing as mainline progresses, and you have active ownership over the work
to fix bugs that may follow or address other fallout from the community.

Ben

