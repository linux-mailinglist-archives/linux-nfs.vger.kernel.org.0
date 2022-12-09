Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C4664825D
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Dec 2022 13:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiLIMaG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Dec 2022 07:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIMaF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Dec 2022 07:30:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D92D62E9A
        for <linux-nfs@vger.kernel.org>; Fri,  9 Dec 2022 04:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670588951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UdpWADGxUJULB+Grel1l/uWk7Aipi59wSrKELfRDGzQ=;
        b=GGs3Uhn4QUDDdGKU4oJmXJ8hVGg9xdurXHiY8FghpkbLLGKZ4FvYbnY69RCPTTeTNYEYne
        EPwvh0xudy2eQPhpZdxnxv66Yru/SpPYYCrTic9pU5yBKrywIUcyfixGdznSF8lL7OJoAM
        sWZZzIZrEv4hMqtZbO9yULsB25CYkjk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-RGqp6tIfMgSM5iIVtCvDHQ-1; Fri, 09 Dec 2022 07:29:08 -0500
X-MC-Unique: RGqp6tIfMgSM5iIVtCvDHQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7376802A6A;
        Fri,  9 Dec 2022 12:29:07 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 620DE2166B26;
        Fri,  9 Dec 2022 12:29:06 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        yusongping@huawei.com, hukeping@huawei.com, artem.kuzin@huawei.com
Subject: Re: [PATCH] NFSv4.1: Fix memory leakage
Date:   Fri, 09 Dec 2022 07:29:02 -0500
Message-ID: <5EDDEEF3-59C6-4297-9E55-3528E6E015FE@redhat.com>
In-Reply-To: <20221209021823.1232874-1-konstantin.meskhidze@huawei.com>
References: <20221209021823.1232874-1-konstantin.meskhidze@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 8 Dec 2022, at 21:18, Konstantin Meskhidze wrote:

> This commit fixes potential memory leakage of 'calldata' memory chunk
> in _nfs41_proc_sequence() function.
>
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> ---
>  fs/nfs/nfs4proc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 86ed5c0142c3..b7aa66167341 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -9416,8 +9416,10 @@ static struct rpc_task *_nfs41_proc_sequence(str=
uct nfs_client *clp,
>  	task_setup_data.callback_data =3D calldata;
>
>  	ret =3D rpc_run_task(&task_setup_data);
> -	if (IS_ERR(ret))
> +	if (IS_ERR(ret)) {
> +		kfree(calldata);
>  		goto out_err;
> +	}
>  	return ret;
>  out_put_clp:
>  	nfs_put_client(clp);
> -- =

> 2.25.1

Did you observe this leak, or find it by code inspecton?

I don't think there's a leak here because there's no way rpc_run_task() c=
an
return an error withouth also doing rpc_call_ops->rpc_release, which shou=
ld
free the calldata.

Ben

