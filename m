Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E26E195E6E
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2020 20:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgC0TQC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Mar 2020 15:16:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:21737 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbgC0TQC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Mar 2020 15:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585336561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yTKCs2p8OMxf0gh0ufmn7zdjss5f6UOxq2A6pE6iZFs=;
        b=ad85zN5frfI88nJPoxCJcbf3EbWUlA/BpmB23Gn9RpIoO3V2uAtcfaBNY2wMNu2igMQyb/
        wYlfMX78h7UyVxVjCy10mC3aQmsXtJSIcGD7Sv8FkbRqQRp/2dsQSbzYUqoB26cTZLmUfG
        TsljBk/Uu7TlJp2SYVp1dnE6FD4zqUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-PjYEQljwMyW3UoBbjo934w-1; Fri, 27 Mar 2020 15:15:59 -0400
X-MC-Unique: PjYEQljwMyW3UoBbjo934w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDF27107ACC4;
        Fri, 27 Mar 2020 19:15:58 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-114-250.phx2.redhat.com [10.3.114.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D4CE5DA75;
        Fri, 27 Mar 2020 19:15:58 +0000 (UTC)
Subject: Re: [PATCH 2/2] nfsd(7): minimal /proc/fs/nfsd/clients/ documentation
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
References: <20200319191532.GB2624@fieldses.org>
 <20200319191634.GC2624@fieldses.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <2bae970c-548c-bdfa-6daa-e5854470953b@RedHat.com>
Date:   Fri, 27 Mar 2020 15:15:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319191634.GC2624@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/19/20 3:16 PM, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> We should really say more, but this is at least a starting point.
> 
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Committed... (tag: nfs-utils-2-4-4-rc2)

steved.
> ---
>  utils/exportfs/nfsd.man | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/utils/exportfs/nfsd.man b/utils/exportfs/nfsd.man
> index 1392f3926053..514153f024fa 100644
> --- a/utils/exportfs/nfsd.man
> +++ b/utils/exportfs/nfsd.man
> @@ -81,6 +81,16 @@ for that path as exported to the given client.  The filehandle's length
>  will be at most the number of bytes given.
>  
>  The filehandle will be represented in hex with a leading '\ex'.
> +
> +.TP
> +.B clients/
> +This directory contains a subdirectory for each NFSv4 client.  Each file
> +under that subdirectory gives some details about the client in YAML
> +format.  In addition, writing "expire\\n" to the
> +.B ctl
> +file will force the server to immediately revoke all state held by that
> +client.
> +
>  .PP
>  The directory
>  .B /proc/net/rpc
> 

