Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DE16367A6
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Nov 2022 18:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbiKWRuh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Nov 2022 12:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239267AbiKWRuN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Nov 2022 12:50:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A32AEA6A
        for <linux-nfs@vger.kernel.org>; Wed, 23 Nov 2022 09:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669225756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rsAMOUXepEnJIhAN4V1Pv6Dlf2eanLN0uoZgg0e1ZrE=;
        b=SDeN6nT8/3DoIPek5b1ec7/YXAxkFh4rrIRJth3amGmfnRAM8CRjoJT/3RAqrskspx1ZZv
        5pG1zFLueVNswypx9TFUsvltSXzCe4uJgLRGQPsOPdLTOA+NWDiJSVC9Xg1faIrhrTCY2H
        1l8WfE/mkuuWlwBiaOdiJl67U/LZ/sA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-w6P7b-snMbyGairNAw2xew-1; Wed, 23 Nov 2022 12:49:11 -0500
X-MC-Unique: w6P7b-snMbyGairNAw2xew-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48B62381494C;
        Wed, 23 Nov 2022 17:49:10 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D6FC94A9254;
        Wed, 23 Nov 2022 17:49:08 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Anders Blomdell <anders.blomdell@control.lth.se>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: Kernel 6.0.5 breaks virtual machines that boot from nfs mounted
 qcow2 images
Date:   Wed, 23 Nov 2022 12:49:04 -0500
Message-ID: <A0F05ED3-14B0-4AE7-B4F7-82398033CA34@redhat.com>
In-Reply-To: <0abaa41e-79e1-3c0c-6d1b-47d4e21f2296@control.lth.se>
References: <65115206-ec17-443e-8495-91661a2fd9be@control.lth.se>
 <0abaa41e-79e1-3c0c-6d1b-47d4e21f2296@control.lth.se>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 23 Nov 2022, at 5:08, Anders Blomdell wrote:

> Our problems turned out to be a fallout of Al Viros's splice rework, wh=
ere nfsd reads with non-zero offsets and not ending
> on a page boundary failed to remap the last page. I belive that this is=
 a decent fix for that problem (tested on v6.1-rc6,
> 6.0.7 and 6.0.9)
>
> ---- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -873,7 +873,7 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, str=
uct pipe_buffer *buf,
>         unsigned offset =3D buf->offset;
>          page +=3D offset / PAGE_SIZE;
> -       for (int i =3D sd->len; i > 0; i -=3D PAGE_SIZE)
> +       for (int i =3D sd->len + offset % PAGE_SIZE; i > 0; i -=3D PAGE=
_SIZE)
>                 svc_rqst_replace_page(rqstp, page++);
>         if (rqstp->rq_res.page_len =3D=3D 0)        // first call
>                 rqstp->rq_res.page_base =3D offset % PAGE_SIZE;


Does anyone have insight into how we could possibly have caught this in t=
esting?

I have been unable to make my knfsd hit this problem: it returns unaligne=
d READs all day long, no problems.

Ben

