Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1AD7CB52E
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Oct 2023 23:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjJPVRB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Oct 2023 17:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPVRA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Oct 2023 17:17:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9491DAB
        for <linux-nfs@vger.kernel.org>; Mon, 16 Oct 2023 14:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697490971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3SAiQPWvobnJto4O41BfA3AiFFWeyo/r47R6J0AOHwI=;
        b=OM+MoNYfCySD5Imoxogqk7XOJp8q7uvtXL+dGrH9oj8mN/gKx4LaPmeTSbGyjT19CtTENo
        HOryqGXq3Y+hSWzKZBB1BJ8/M4+LYQelHVH8yW+n1TjvFUocTOMj7ewDETv+eG/W+/Q7hT
        xIAnVa9Co0p607wBAN+NwkJFaiuBpMg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-t7KphYJbOD-QLBESvVMFOw-1; Mon, 16 Oct 2023 17:16:09 -0400
X-MC-Unique: t7KphYJbOD-QLBESvVMFOw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 463C7185A79B;
        Mon, 16 Oct 2023 21:16:07 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28779492BFA;
        Mon, 16 Oct 2023 21:16:04 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v3 2/2] sunrpc: Use no_printk() in dfprintk*()
 dummies
Date:   Mon, 16 Oct 2023 17:16:03 -0400
Message-ID: <AF5F4E44-08DE-4F4F-9BA0-3D7FC26554EF@redhat.com>
In-Reply-To: <180fd042261dcd4243fad90660b114b8f0a78dcd.1697460614.git.geert+renesas@glider.be>
References: <cover.1697460614.git.geert+renesas@glider.be>
 <180fd042261dcd4243fad90660b114b8f0a78dcd.1697460614.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 16 Oct 2023, at 9:09, Geert Uytterhoeven wrote:

> When building NFS with W=3D1 and CONFIG_WERROR=3Dy, but
> CONFIG_SUNRPC_DEBUG=3Dn:
>
>     fs/nfs/nfs4proc.c: In function =E2=80=98nfs4_proc_create_session=E2=
=80=99:
>     fs/nfs/nfs4proc.c:9276:19: error: variable =E2=80=98ptr=E2=80=99 se=
t but not used [-Werror=3Dunused-but-set-variable]
>      9276 |         unsigned *ptr;
> 	  |                   ^~~
>       CC      fs/nfs/callback.o
>     fs/nfs/callback.c: In function =E2=80=98nfs41_callback_svc=E2=80=99=
:
>     fs/nfs/callback.c:98:13: error: variable =E2=80=98error=E2=80=99 se=
t but not used [-Werror=3Dunused-but-set-variable]
>        98 |         int error;
> 	  |             ^~~~~
>       CC      fs/nfs/flexfilelayout/flexfilelayout.o
>     fs/nfs/flexfilelayout/flexfilelayout.c: In function =E2=80=98ff_lay=
out_io_track_ds_error=E2=80=99:
>     fs/nfs/flexfilelayout/flexfilelayout.c:1230:13: error: variable =E2=
=80=98err=E2=80=99 set but not used [-Werror=3Dunused-but-set-variable]
>      1230 |         int err;
> 	  |             ^~~
>       CC      fs/nfs/flexfilelayout/flexfilelayoutdev.o
>     fs/nfs/flexfilelayout/flexfilelayoutdev.c: In function =E2=80=98nfs=
4_ff_alloc_deviceid_node=E2=80=99:
>     fs/nfs/flexfilelayout/flexfilelayoutdev.c:55:16: error: variable =E2=
=80=98ret=E2=80=99 set but not used [-Werror=3Dunused-but-set-variable]
>        55 |         int i, ret =3D -ENOMEM;
> 	  |                ^~~
>
> All these are due to variables that are set unconditionally, but are
> used only when debugging is enabled.
>
> Fix this by changing the dfprintk*() dummy macros from empty loops to
> calls to the no_printk() helper.  This informs the compiler that the
> passed debug parameters are actually used, and enables format specifier=

> checking as a bonus.
>
> This requires removing the protection by CONFIG_SUNRPC_DEBUG of the
> declaration of nlmdbg_cookie2a() in fs/lockd/svclock.c, as its referenc=
e
> is now visible to the compiler, but optimized away.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

