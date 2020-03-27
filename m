Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92677195E70
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2020 20:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgC0TQT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Mar 2020 15:16:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49496 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbgC0TQS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Mar 2020 15:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585336577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m01KsthKL+/Mvp9JFUfJeA+j8AZaFE16hVxKyqZ6Ggc=;
        b=Dp9xIfHfPg775ZYfuwQNrUyg0dEbBmE5VgaBG5oCOSFd45Do46Vv/XGCkw44Z62YECiBlj
        XP6fWq062sy9eOxYNDoDWEfXmkQhLzhJ8MbS2uA8rzR6/Ty1Y6PUVvSzjO45K4futS2WTj
        jPdaPfnRfzfMtMVLKA3jGFqe42FZIR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-BzpkVDZAPpKFdfpHhjpEJA-1; Fri, 27 Mar 2020 15:16:15 -0400
X-MC-Unique: BzpkVDZAPpKFdfpHhjpEJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF98E800D53;
        Fri, 27 Mar 2020 19:16:14 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-114-250.phx2.redhat.com [10.3.114.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 657B9100EBA4;
        Fri, 27 Mar 2020 19:16:14 +0000 (UTC)
Subject: Re: [PATCH 1/2] nfsd(7): minimal updates
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
References: <20200319191532.GB2624@fieldses.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <7e58e3a8-5647-9343-6883-1eeed79c183a@RedHat.com>
Date:   Fri, 27 Mar 2020 15:16:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319191532.GB2624@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/19/20 3:15 PM, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> The nfsd(7) man page has some useful documentation of the files under
> /proc/fs/nfsd/ and proc/net/rpc, but it's many years out of date.
> 
> As a start, banish any discussion of the long-deprecated nfsctl
> systemcall to a NOTES section at the end, and admit that there are more
> than 3 files under /proc/fs/nfsd/.
> 
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Committed... (tag: nfs-utils-2-4-4-rc2)

steved.
> ---
>  utils/exportfs/nfsd.man | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/utils/exportfs/nfsd.man b/utils/exportfs/nfsd.man
> index 9efa29f9f01c..1392f3926053 100644
> --- a/utils/exportfs/nfsd.man
> +++ b/utils/exportfs/nfsd.man
> @@ -13,14 +13,8 @@ nfsd \- special filesystem for controlling Linux NFS server
>  The
>  .B nfsd
>  filesystem is a special filesystem which provides access to the Linux
> -NFS server.  The filesystem consists of a single directory which
> -contains a number of files.  These files are actually gateways into
> -the NFS server.  Writing to them can affect the server.  Reading from
> -them can provide information about the server.
> -.P
> -This file system is only available in Linux 2.6 and later series
> -kernels (and in the later parts of the 2.5 development series leading
> -up to 2.6).  This man page does not apply to 2.4 and earlier.
> +NFS server.  Writing to files in this filesystem can affect the server.
> +Reading from them can provide information about the server.
>  .P
>  As well as this filesystem, there are a collection of files in the
>  .B procfs
> @@ -38,13 +32,10 @@ filesystem mounted at
>  .B /proc/fs/nfsd
>  or
>  .BR /proc/fs/nfs .
> -If it is not mounted, they will fall-back on 2.4 style functionality.
> -This involves accessing the NFS server via a systemcall.  This
> -systemcall is scheduled to be removed after the 2.6 kernel series.
>  .SH DETAILS
> -The three files in the
> +Files in the
>  .B nfsd
> -filesystem are:
> +filesystem include:
>  .TP
>  .B exports
>  This file contains a list of filesystems that are currently exported
> @@ -191,6 +182,16 @@ number represents a bit-pattern where bits that are set cause certain
>  classes of tracing to be enabled.  Consult the kernel header files to
>  find out what number correspond to what tracing.
>  
> +.SH NOTES
> +This file system is only available in Linux 2.6 and later series
> +kernels (and in the later parts of the 2.5 development series leading
> +up to 2.6).  This man page does not apply to 2.4 and earlier.
> +.P
> +Previously the nfsctl systemcall was used for communication between nfsd
> +and user utilities.  That systemcall was removed in kernel version 3.1.
> +Older nfs-utils versions were able to fall back to nfsctl if necessary;
> +that was removed from nfs-utils 1.3.5.
> +
>  .SH SEE ALSO
>  .BR nfsd (8),
>  .BR rpc.nfsd (8),
> 

