Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E00B3A0577
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 23:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbhFHVFX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 17:05:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46232 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233959AbhFHVFX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 17:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623186209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wgwzQeYzF2U3DxVcbwq7elji6MiiyMu51zrQBJinESg=;
        b=iXPOg87w3hZGkHzdqs29dIjpeOa8sQ31PZ8B9NpTf+8GvK7jMBiVaAe3B8Ga8vfJXinm6s
        tsamB2eRc8Auy8GmlT0Pxx6ioyV0BijbbB7tULDxb7wtfJ2xN/A4a7r3XzF6xr9EwWujQb
        P1GGmRFsGgcjtN88xYfGA/b12e9VEL4=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-9XXNWIMsPjyhFdn4CZAmSQ-1; Tue, 08 Jun 2021 17:03:28 -0400
X-MC-Unique: 9XXNWIMsPjyhFdn4CZAmSQ-1
Received: by mail-il1-f199.google.com with SMTP id g12-20020a056e021a2cb02901dfc46878d8so16127954ile.4
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 14:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wgwzQeYzF2U3DxVcbwq7elji6MiiyMu51zrQBJinESg=;
        b=dcR8HrHvKjPag5qJJajDWk5daL3if4jj4FmwxTlywPXy/+EbTXvRN17eiQ865i8ySG
         U+Wk4VSooLWtPqtHR1cjlpShuvRCwMFty2UkhOn9SA+q/uIUfJm4LvAwUiGKmslOVRsO
         R5B38dImEHST+FGiaTIUoTRFyb2AjoTA5p93X7vjHNGUI+OeDD+YNmSjX5NRV2ZkUp52
         nGXM4xK8kn3QQhpqpqHv7pZXPaWAyN6LOQQUNs1RpmJ8aZqjIMchZo1ZxSDJA5/tVw/D
         1YeveSqpPamwlS1YYVnUXFfDxJgdvB7BYFva1JuqRt8qXv8YqL61IcuzPtes5Z9gyZ5x
         4wzQ==
X-Gm-Message-State: AOAM530MrftUPCm2g/LpYzlbxXAD9lj5jq/1EMs5u28XtwoVWzBCkDMB
        5sMawx/A6dGjY5yU/fkHon8ToCxDsLoH6FW4uGI2w9LLD0S9rGROfQpKqs+my0wGQMGjm7cHNxS
        OPhCf7CmpKUJJCthpIha86nitTMiLvPPdldyM
X-Received: by 2002:a5d:948f:: with SMTP id v15mr20684494ioj.28.1623186207677;
        Tue, 08 Jun 2021 14:03:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwfNmW3upGXJ5Dve4Ej9WBccBXA4QinwdWTxjQZOfwjWS64lkmPpJPrRs/IwQ0cW8sqNkKdXyXf3uAs6HhDcY=
X-Received: by 2002:a5d:948f:: with SMTP id v15mr20684477ioj.28.1623186207488;
 Tue, 08 Jun 2021 14:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAK-6q+hS29yoTF4tKq+Xt3G=_PPDi9vmFVwGPmutbsQyD2i=CA@mail.gmail.com>
 <87pmwxsjxm.fsf@suse.com> <CAH2r5msMBZ5AYQcfK=-xrOASzVC0SgoHdPnyqEPRcfd-tzUstw@mail.gmail.com>
 <35352ef0-86ed-aaa5-4a49-b2b08dc3674d@samba.org>
In-Reply-To: <35352ef0-86ed-aaa5-4a49-b2b08dc3674d@samba.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 8 Jun 2021 17:03:16 -0400
Message-ID: <CAK-6q+g3_9g++wQGbhzBhk2cp=0fb3aVL9GoAoYNPq6M4QnCdQ@mail.gmail.com>
Subject: Re: quic in-kernel implementation?
To:     Stefan Metzmacher <metze@samba.org>
Cc:     Steve French <smfrench@gmail.com>,
        =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Leif Sahlberg <lsahlber@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

On Tue, Jun 8, 2021 at 3:36 AM Stefan Metzmacher <metze@samba.org> wrote:
...
>
> > 2) then switch focus to porting a smaller C userspace implementation of
> > QUIC to Linux (probably not msquic since it is larger and doesn't
> > follow kernel style)
> > to kernel in fs/cifs  (since currently SMB3.1.1 is the only protocol
> > that uses QUIC,
> > and the Windows server target is quite stable and can be used to test against)> 3) use the userspace upcall example from step 1 for
> > comparison/testing/debugging etc.
> > since we know the userspace version is stable
>
> With having the fuse-like socket before it should be trivial to switch
> between the implementations.

So a good starting point would be to have such a "fuse-like socket"
component? What about having a simple example for that at first
without having quic involved. The kernel calls some POSIX-like socket
interface which triggers a communication to a user space application.
This user space application will then map everything to a user space
generated socket. This would be a map from socket struct
"proto/proto_ops" to user space and vice versa. The kernel application
probably can use the kernel_FOO() (e.g. kernel_recvmsg()) socket api
directly then. Exactly like "fuse" as you mentioned just for sockets.

I think two veth interfaces can help to test something like that,
either with a "fuse-like socket" on the other end or an user space
application. Just doing a ping-pong example.

Afterwards we can look at how to replace the user generated socket
application with any $LIBQUIC e.g. msquic implementation as second
step.

- Alex

