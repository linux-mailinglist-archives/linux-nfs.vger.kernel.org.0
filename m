Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96E88195E68
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2020 20:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgC0TPM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Mar 2020 15:15:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32285 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbgC0TPM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Mar 2020 15:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585336511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SzUmzT8sPmWy6WzmPf5sB1omR2vIAepli/By1hmsH6k=;
        b=KQGDmvilqNIHkw/eOAJ5tNdg4mXJAWTSAKCXJ8rbjskh1F4I36IYOFFXg1HhGxmTO5eUmw
        U5w99LE9OeIL3bxw8mlh8rjIduKI8iu3OFnDZLuQLcd8MmEnCdiYwOJYyogrg+tuMFdgZR
        4kha+TBaLIg4rpPp93F/dkRPq9HMCEc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-Pn9GJNiBNPObGVZifolrhg-1; Fri, 27 Mar 2020 15:15:09 -0400
X-MC-Unique: Pn9GJNiBNPObGVZifolrhg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 693A38017CC;
        Fri, 27 Mar 2020 19:15:08 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-114-250.phx2.redhat.com [10.3.114.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E84A35C1D4;
        Fri, 27 Mar 2020 19:15:07 +0000 (UTC)
Subject: Re: [nfs-utils PATCH 1/1] error.c: Put string for EOPNOTSUPP on
 single line
To:     Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
References: <20200302140855.19453-1-pvorel@suse.cz>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <253ac076-7137-f172-900a-f87cfb99e384@RedHat.com>
Date:   Fri, 27 Mar 2020 15:15:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302140855.19453-1-pvorel@suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/2/20 9:08 AM, Petr Vorel wrote:
> to help people find it when search for common NFS error:
> mount.nfs: requested NFS version or transport protocol is not supported
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
Committed... (tag: nfs-utils-2-4-4-rc2)

steved.

> ---
>  utils/mount/error.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/utils/mount/error.c b/utils/mount/error.c
> index 986f0660..73295bf0 100644
> --- a/utils/mount/error.c
> +++ b/utils/mount/error.c
> @@ -210,8 +210,7 @@ void mount_error(const char *spec, const char *mount_point, int error)
>  		nfs_error(_("%s: an incorrect mount option was specified"), progname);
>  		break;
>  	case EOPNOTSUPP:
> -		nfs_error(_("%s: requested NFS version or transport"
> -				" protocol is not supported"),
> +		nfs_error(_("%s: requested NFS version or transport protocol is not supported"),
>  				progname);
>  		break;
>  	case ENOTDIR:
> 

