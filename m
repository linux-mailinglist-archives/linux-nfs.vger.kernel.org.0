Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D37375950
	for <lists+linux-nfs@lfdr.de>; Thu,  6 May 2021 19:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbhEFRau (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 May 2021 13:30:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236254AbhEFRau (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 May 2021 13:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620322191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZaSkxoeZoG9Q4ZTGGUbFi0937IiN3xJOV7wdDv3l6VA=;
        b=Jb7tP3bJpuwsVIPgFUdYXLQD2wgvb6u681ylhm5IXSRpasgcD4qLkEXMYBNxWLPvJQw6ht
        E+JZpYBoIyjp3SlynpBDNf0dOTojg5oYt6I37cw428BJ1vymcs9QTEanQcYFOUVWMCf+MS
        9Mze783iIMkQTTFeod0oM7Zz3qOlolc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-HtGU5CesOLCNv_5TA4reXg-1; Thu, 06 May 2021 13:29:48 -0400
X-MC-Unique: HtGU5CesOLCNv_5TA4reXg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23C13C7400;
        Thu,  6 May 2021 17:29:47 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-61.phx2.redhat.com [10.3.112.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B80EE19D61;
        Thu,  6 May 2021 17:29:46 +0000 (UTC)
Subject: Re: [PATCH 1/1] mountd/exports: Fix typo in the man page
To:     Yongcheng Yang <yongcheng.yang@gmail.com>
Cc:     NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org
References: <20210415091938.24021-1-yongcheng.yang@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <eaa0250b-db1a-7c3a-4359-06d17d957872@RedHat.com>
Date:   Thu, 6 May 2021 13:32:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210415091938.24021-1-yongcheng.yang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/15/21 5:19 AM, Yongcheng Yang wrote:
> Signed-off-by: Yongcheng Yang <yongcheng.yang@gmail.com>
> ---
> Hi SteveD and Neil,
> 
> Please check if I understand it correctly.
> 
> Thanks,
> Yongcheng
Committed (tag: nfs-utils-2-5-4-rc3)

steved.
> 
>  utils/exportd/exportd.man | 4 ++--
>  utils/mountd/mountd.man   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/utils/exportd/exportd.man b/utils/exportd/exportd.man
> index b238ff05..fae434b5 100644
> --- a/utils/exportd/exportd.man
> +++ b/utils/exportd/exportd.man
> @@ -14,7 +14,7 @@ is used to manage NFSv4 exports.
>  The NFS server
>  .RI ( nfsd )
>  maintains a cache of authentication and authorization information which
> -is used to identify the source of each requent, and then what access
> +is used to identify the source of each request, and then what access
>  permissions that source has to any local filesystem.  When required
>  information is not found in the cache, the server sends a request to
>  .B nfsv4.exportd
> @@ -134,7 +134,7 @@ listing exports, export options, and access control lists
>  .BR exports (5),
>  .BR showmount (8),
>  .BR nfs.conf (5),
> -.BR firwall-cmd (1),
> +.BR firewall-cmd (1),
>  .sp
>  RFC 7530 - "Network File System (NFS) Version 4 Protocol"
>  .br
> diff --git a/utils/mountd/mountd.man b/utils/mountd/mountd.man
> index 1155cf94..77e6299a 100644
> --- a/utils/mountd/mountd.man
> +++ b/utils/mountd/mountd.man
> @@ -19,7 +19,7 @@ clients and provides details of access permissions.
>  The NFS server
>  .RI ( nfsd )
>  maintains a cache of authentication and authorization information which
> -is used to identify the source of each requent, and then what access
> +is used to identify the source of each request, and then what access
>  permissions that source has to any local filesystem.  When required
>  information is not found in the cache, the server sends a request to
>  .B mountd
> 

