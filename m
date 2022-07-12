Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA3857217E
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jul 2022 19:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiGLRAR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jul 2022 13:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiGLRAR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jul 2022 13:00:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27A13CC031
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657645215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wNTyfY0yH1P/DlUzwoNuiHlRbz+BZPjC+6G9cgZvBpk=;
        b=cu5VlgtknRyoZgVmmBfNqMCGaI/rs9+N09dmZKdFoyam2sriNBhNMOqUnR5kRtPtaGLCTD
        fsA1SwyoeFE3YR+N+m6ZWTOW7kl9HTXTydpAq9GlFW0jjKg50wyYu6q+biAypMVNFxHmOP
        DElnGBMgJPQ8Fipj0ekuk1+tMF9ZrqQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-Mx6dhJLJM_OMrIRGaakdIw-1; Tue, 12 Jul 2022 13:00:11 -0400
X-MC-Unique: Mx6dhJLJM_OMrIRGaakdIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85B221C01B23;
        Tue, 12 Jul 2022 17:00:11 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 112D8C1D38B;
        Tue, 12 Jul 2022 17:00:10 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, trondmy@hammerspace.com
Subject: Re: [PATCH v2 12/15] SUNRPC: Add RPC-with-TLS support to xprtsock.c
Date:   Tue, 12 Jul 2022 13:00:09 -0400
Message-ID: <5139CEB0-DA0C-495B-911E-E1459154559B@redhat.com>
In-Reply-To: <165452710606.1496.14773661487729121787.stgit@oracle-102.nfsv4.dev>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
 <165452710606.1496.14773661487729121787.stgit@oracle-102.nfsv4.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6 Jun 2022, at 10:51, Chuck Lever wrote:

> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/xprtsock.h |    1
>  net/sunrpc/xprtsock.c           |  243 =

> ++++++++++++++++++++++++++++++++-------
>  2 files changed, 201 insertions(+), 43 deletions(-)
>
> diff --git a/include/linux/sunrpc/xprtsock.h =

> b/include/linux/sunrpc/xprtsock.h
> index e0b6009f1f69..eaf3d705f758 100644
> --- a/include/linux/sunrpc/xprtsock.h
> +++ b/include/linux/sunrpc/xprtsock.h
> @@ -57,6 +57,7 @@ struct sock_xprt {
>  	struct work_struct	error_worker;
>  	struct work_struct	recv_worker;
>  	struct mutex		recv_mutex;
> +	struct completion	handshake_done;
>  	struct sockaddr_storage	srcaddr;
>  	unsigned short		srcport;
>  	int			xprt_err;
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index a4fee00412d4..63fe97ede573 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -48,6 +48,7 @@
>  #include <net/udp.h>
>  #include <net/tcp.h>
>  #include <net/tls.h>
> +#include <net/tlsh.h>

Ah, maybe helpful to others to note this depends on the RFC "net/tls: =

Add support for PF_TLSH":

https://lore.kernel.org/linux-nfs/165030059051.5073.16723746870370826608.=
stgit@oracle-102.nfsv4.dev/

=2E. which (of course) exists in the topic branch in the cover-letter.

Ben

