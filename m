Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80463142ED2
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2020 16:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgATPfl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jan 2020 10:35:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52668 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726876AbgATPfl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jan 2020 10:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579534539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2V6aPXYbZq02qwGUdx0n+iG7vEqKtgW18a5h4f6Xsk=;
        b=NOrz98MFlU5iPOaYj/FFy5TctwSlqSlKJuwMmbg8fG7hQ/WRzQMKfC2aRQ9eHNFgDjSdL1
        Nk8QBQBRtf+SF0snx3qqOEorMiN1VMjuFfSsBjdimICnPYk+P897+TrCSoxtSPtA64Xt/z
        8DNnp65DqWD/3APjhFStSTKHOOtD72Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-YZNZj5AINeSI0cT_0er-RA-1; Mon, 20 Jan 2020 10:35:33 -0500
X-MC-Unique: YZNZj5AINeSI0cT_0er-RA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 871A7DB22;
        Mon, 20 Jan 2020 15:35:32 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-35.phx2.redhat.com [10.3.117.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C00E384DB6;
        Mon, 20 Jan 2020 15:35:31 +0000 (UTC)
Subject: Re: [PATCH 1/1] NFSv4.0 allow nconnect for v4.0
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
References: <20200116190857.26026-1-olga.kornievskaia@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <81b8fd1b-6882-5edf-fcab-1a7d4c9d4d47@RedHat.com>
Date:   Mon, 20 Jan 2020 10:35:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116190857.26026-1-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 1/16/20 2:08 PM, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/nfs4client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index 460d625..4df3fb0 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -881,7 +881,7 @@ static int nfs4_set_client(struct nfs_server *server,
>  
>  	if (minorversion == 0)
>  		__set_bit(NFS_CS_REUSEPORT, &cl_init.init_flags);
> -	else if (proto == XPRT_TRANSPORT_TCP)
> +	if (proto == XPRT_TRANSPORT_TCP)
>  		cl_init.nconnect = nconnect;
>  
>  	if (server->flags & NFS_MOUNT_NORESVPORT)
> 
Tested-by: Steve Dickson <steved@redhat.com>

With this patch v4.0 mounts act just like v4.1/v4.2 mounts
But is that a good thing. :-)  

Here is what I've found in my testing...

mount -onconnect=12 172.31.1.54:/home/tmp /mnt/tmp

Will create 12 TCP connections and maintain those 12 
connections until the umount happens. By maintain I mean 
if the connection times out, it is reconnected 
to maintain the 12 connections 

# mount -onconnect=12 172.31.1.54:/home/tmp /mnt/tmp
# netstat -an | grep 172.31.1.54 | wc -l
12
# netstat -an | grep 172.31.1.54        
tcp        0      0 172.31.1.24:901         172.31.1.54:2049        ESTABLISHED
tcp        0      0 172.31.1.24:667         172.31.1.54:2049        ESTABLISHED
tcp        0      0 172.31.1.24:746         172.31.1.54:2049        ESTABLISHED
tcp        0      0 172.31.1.24:672         172.31.1.54:2049        ESTABLISHED
tcp        0      0 172.31.1.24:832         172.31.1.54:2049        ESTABLISHED
tcp        0      0 172.31.1.24:895         172.31.1.54:2049        ESTABLISHED
tcp        0      0 172.31.1.24:673         172.31.1.54:2049        ESTABLISHED
tcp        0      0 172.31.1.24:732         172.31.1.54:2049        ESTABLISHED
tcp        0      0 172.31.1.24:795         172.31.1.54:2049        ESTABLISHED
tcp        0      0 172.31.1.24:918         172.31.1.54:2049        ESTABLISHED
tcp        0      0 172.31.1.24:674         172.31.1.54:2049        ESTABLISHED
tcp        0      0 172.31.1.24:953         172.31.1.54:2049        ESTABLISHED

# umount /mnt/tmp
# netstat -an | grep 172.31.1.54 | wc -l
12
# netstat -an | grep 172.31.1.54
tcp        0      0 172.31.1.24:901         172.31.1.54:2049        TIME_WAIT  
tcp        0      0 172.31.1.24:667         172.31.1.54:2049        TIME_WAIT  
tcp        0      0 172.31.1.24:746         172.31.1.54:2049        TIME_WAIT  
tcp        0      0 172.31.1.24:672         172.31.1.54:2049        TIME_WAIT  
tcp        0      0 172.31.1.24:832         172.31.1.54:2049        TIME_WAIT  
tcp        0      0 172.31.1.24:895         172.31.1.54:2049        TIME_WAIT  
tcp        0      0 172.31.1.24:673         172.31.1.54:2049        TIME_WAIT  
tcp        0      0 172.31.1.24:732         172.31.1.54:2049        TIME_WAIT  
tcp        0      0 172.31.1.24:795         172.31.1.54:2049        TIME_WAIT  
tcp        0      0 172.31.1.24:918         172.31.1.54:2049        TIME_WAIT  
tcp        0      0 172.31.1.24:674         172.31.1.54:2049        TIME_WAIT  
tcp        0      0 172.31.1.24:953         172.31.1.54:2049        TIME_WAIT 

Is this the expected behavior? 

If so I have a few concerns...

* The connections walk all over the /etc/services namespace. Meaning
using ports that are reserved for registered services, something
we've tried to avoid in userland by not binding to privilege ports and
use of backlist ports via /etc/bindresvport.blacklist

* When the unmount happens, all those connections go into TIME_WAIT on 
privilege ports and there are only so many of those. Not good during mount 
storms (when a server reboots and thousand of home dirs are remounted).

* No man page describing the new feature.

I realize there is not much we can do about some of these
(aka umount==>TIME_WAIT) but I think we need to document 
what we are doing to people's connection namespace when 
they use this feature. 

steved.

