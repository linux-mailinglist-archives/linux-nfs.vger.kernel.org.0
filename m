Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D58583CED
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 13:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbiG1LP4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 07:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiG1LP4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 07:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7728E63912
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 04:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659006954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A5n2BUJMjQ7LATQQuPxN4M42EzWey4GzcjntO/ijx5k=;
        b=HHdonaXi4LqEBbwVK1jedOTIquRraigvAIkPbKkLUqxFcuyWlJsQNoT9bni8HtF9/L87nN
        gY0VPFysbRaVlgGLUSSiTVKe4O3qpjQ+07hEAFZYwv9rPBFDkWQbkTvKqijB29zJ253ulA
        UOAUJ6vmUhsVQTFNuB0yDhEG1X8sCic=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-hyJNnXeyNUSDHHD7udWr7Q-1; Thu, 28 Jul 2022 07:15:52 -0400
X-MC-Unique: hyJNnXeyNUSDHHD7udWr7Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6851A85A585
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 11:15:52 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FED7140EBE3;
        Thu, 28 Jul 2022 11:15:51 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Steve Dickson" <steved@redhat.com>
Cc:     "Linux NFS Mailing list" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] rpc-statd.service: Stop rpcbind and rpc.stat in an exit
 race
Date:   Thu, 28 Jul 2022 07:15:50 -0400
Message-ID: <E4C11B71-CBAC-4F1B-B4FF-270FD0EDADA9@redhat.com>
In-Reply-To: <20220727172441.6524-1-steved@redhat.com>
References: <20220727172441.6524-1-steved@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 27 Jul 2022, at 13:24, Steve Dickson wrote:

> From: Benjamin Coddington <bcodding@redhat.com>
>
> When `systemctl stop rpcbind.socket` is run, the dependency means
> that systemd first sends SIGTERM to rpcbind, then sigterm to rpc.statd.
>
> On SIGTERM, rpcbind tears down /var/run/rpcbind.sock.  However,
> rpc-statd on SIGTERM attempts to unregister from rpcbind
>
> systemd needs to wait for rpc.statd to exit before sending
> SIGTERM to rpcbind
>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2100395
> Signed-off-by: Steve Dickson <steved@redhat.com>
> ---
>  systemd/rpc-statd.service | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/systemd/rpc-statd.service b/systemd/rpc-statd.service
> index 095629f2..392750da 100644
> --- a/systemd/rpc-statd.service
> +++ b/systemd/rpc-statd.service
> @@ -5,7 +5,7 @@ Conflicts=umount.target
>  Requires=nss-lookup.target rpcbind.socket
>  Wants=network-online.target
>  Wants=rpc-statd-notify.service
> -After=network-online.target nss-lookup.target rpcbind.socket
> +After=network-online.target nss-lookup.target rpcbind.service
>
>  PartOf=nfs-utils.service
>  IgnoreOnIsolate=yes
> -- 
> 2.34.1

Hey Steve - thanks for patchifying this -  I should have sent a proper
patch, but the reason I didn't is that I didn't understand why we have the
rpcbind.socket unit, and why that unit isn't sufficient to enforce the
ordering.

I don't remember the history.  Will changing the After= here create a
problem where rpcbind.service is up, but the socket isn't there yet, and
then rpc.statd comes up and can't find the socket?

Ben

