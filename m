Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7710A2D76EB
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Dec 2020 14:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbgLKNuA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Dec 2020 08:50:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29265 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393863AbgLKNt1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Dec 2020 08:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607694481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3kMTnA2ovnwOcrpVo+FgKXiVOpUWU15f8szTilKLSrA=;
        b=UDEbQhhdRA+plPxOA/ofYhnDSu6fQxDbZGlPG2gRhKKxrRsgLFrcIKBPKBC0N/hVRCXkUj
        tANgDN352M+5MCoOU2RvnMsesMgr5I6f7uPUfxaYS9SogGCmhCmNHCHW8mRfTP9jQX9kia
        CpSnHFSroFuK0drRS+1kFUUvIc2h+QA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-G7LVtGgLNe6rUL9k22Vqww-1; Fri, 11 Dec 2020 08:47:59 -0500
X-MC-Unique: G7LVtGgLNe6rUL9k22Vqww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A0221007467
        for <linux-nfs@vger.kernel.org>; Fri, 11 Dec 2020 13:47:58 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-115-15.phx2.redhat.com [10.3.115.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1832C5D705
        for <linux-nfs@vger.kernel.org>; Fri, 11 Dec 2020 13:47:58 +0000 (UTC)
Subject: Re: [PATCH] exportfs: Ingnore export failures in nfs-server.serivce
 unit
From:   Steve Dickson <SteveD@RedHat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20201210182452.20898-1-steved@redhat.com>
Message-ID: <5684bb05-d139-fabf-dc90-377d0a71c415@RedHat.com>
Date:   Fri, 11 Dec 2020 08:48:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201210182452.20898-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 12/10/20 1:24 PM, Steve Dickson wrote:
> With some recent commits, exportfs will continue on trying to
> export filesystems even when an entry is invalid or does
> not exist, but will still have a non-zero exit to report
> the error.
> 
> This situation should not stop the nfs-server service
> from comingup so nfs-server.service file should
> ignore these types of failures
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed. (tag: nfs-utils-2-5-3-rc2)

steved.
> ---
>  systemd/nfs-server.service | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/systemd/nfs-server.service b/systemd/nfs-server.service
> index 06c1adb..b432f91 100644
> --- a/systemd/nfs-server.service
> +++ b/systemd/nfs-server.service
> @@ -21,13 +21,13 @@ After=rpc-gssd.service gssproxy.service rpc-svcgssd.service
>  [Service]
>  Type=oneshot
>  RemainAfterExit=yes
> -ExecStartPre=/usr/sbin/exportfs -r
> +ExecStartPre=-/usr/sbin/exportfs -r
>  ExecStart=/usr/sbin/rpc.nfsd
>  ExecStop=/usr/sbin/rpc.nfsd 0
>  ExecStopPost=/usr/sbin/exportfs -au
>  ExecStopPost=/usr/sbin/exportfs -f
>  
> -ExecReload=/usr/sbin/exportfs -r
> +ExecReload=-/usr/sbin/exportfs -r
>  
>  [Install]
>  WantedBy=multi-user.target
> 

