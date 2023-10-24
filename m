Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A207D5A0D
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Oct 2023 20:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343769AbjJXSBq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Oct 2023 14:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343883AbjJXSBo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Oct 2023 14:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA0610CF
        for <linux-nfs@vger.kernel.org>; Tue, 24 Oct 2023 11:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698170458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/rRUTdijOYZODyhIUu5lwhM1sh+LeLiZh2xcrppa9E0=;
        b=g0kXDZdK6tuZE3YVa8YtZJYcc5DRRJIjV7Ehv2q1gpeV2b2sCtJs8e3YelLofZTOEqtvTF
        2eAhVk1Tn6ePo/l6gFRwXFRYFLTRiWTcZhWhhII2obxcu6wVlc/XvjDcugzLzgMJFKPkEF
        VHGnsrOhpyPdBh5stb69FEgUB+SQpEY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-qDrhfe1EOneTbvC3vZXt9Q-1; Tue, 24 Oct 2023 14:00:57 -0400
X-MC-Unique: qDrhfe1EOneTbvC3vZXt9Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34D82857A86;
        Tue, 24 Oct 2023 18:00:56 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 883682026D4C;
        Tue, 24 Oct 2023 18:00:54 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfs: derive f_fsid from server's fsid
Date:   Tue, 24 Oct 2023 14:00:53 -0400
Message-ID: <41F5B54F-0345-4C44-99FB-6E2A6C9F365C@redhat.com>
In-Reply-To: <CAOQ4uxho0ryGuq7G+LaoTvqHRR_kg2fCNL2sGMLvNujODA8YPQ@mail.gmail.com>
References: <20231024110109.3007794-1-amir73il@gmail.com>
 <1CFE0178-CE91-4C99-B43E-33EF78D0BEBF@redhat.com>
 <CAOQ4uxhe5pH3yRxFS_8pvtCgbXspKB6r9aacRJ8FysGQE2Hu9g@mail.gmail.com>
 <2382DA9B-D66B-41D9-8413-1C5319C01165@redhat.com>
 <CAOQ4uxho0ryGuq7G+LaoTvqHRR_kg2fCNL2sGMLvNujODA8YPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 24 Oct 2023, at 13:12, Amir Goldstein wrote:
> On Tue, Oct 24, 2023 at 6:32 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>> Yes, but if the specific export is on the same server's filesystem as the
>> "root", you'll still get zero.  There are various ways to set fsid on
>> exports for linux servers, but the fsid will be the same for all exports of
>> the same filesystem on the server.
>>
>
> OK. good to know. I thought zero fsid was only for the root itself.

Yes, but by "root" here I always mean the special NFSv4 root - the special
per-server global root filehandle.

...

>> I'm not familiar with fanotify enough to know if having multiple fsid 0
>> mounts of different filesystems on different servers will do the right
>> thing.  I wanted to point out that very real possibility for v4.
>>
>
> The fact that fsid 0 would be very common for many nfs mounts
> makes this patch much less attractive.
>
> Because we only get events for local client changes, we do not
> have to tie the fsid with the server's fsid, we could just use a local
> volatile fsid, as we do in other non-blockdev fs (tmpfs, kernfs).

A good way to do this would be to use the nfs_server->s_dev's major:minor -
this represents the results of nfs_compare_super(), so it should be the same
value if NFS is treating it as the same filesystem.

> I am not decisive about the best way to tackle this and since
> Jan was not sure about the value of local-only notifications
> for network filesystems, I am going to put this one on hold.
>
> Thanks for the useful feedback!

Sure!

Ben

