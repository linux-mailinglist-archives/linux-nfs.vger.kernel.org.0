Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC497195E69
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2020 20:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgC0TP1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Mar 2020 15:15:27 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:49011 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbgC0TP1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Mar 2020 15:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585336526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GJ+n7jWahHoaEclGgtBnFg7+JTbmFP57cfIpqdgiWzY=;
        b=c6yq0np6DoHfrBbMZ2oPRhfjpgGkq5EP8aQe8HlNKds4XbL3SrgL16RTF1HAtKKclHRLhn
        l9GjGQM5KSSUPnSwz5QjM1lBktf9enR0qhFy7WUm9bSewkRzTVW4CDcIXKZKua3/pir137
        whI0beTHU7fLkto7UW9c/RQIuDUFnMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-y4svL2z1PVKLxWYjugzUNg-1; Fri, 27 Mar 2020 15:15:24 -0400
X-MC-Unique: y4svL2z1PVKLxWYjugzUNg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8E48801E6D
        for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2020 19:15:23 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-114-250.phx2.redhat.com [10.3.114.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85C605DA75
        for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2020 19:15:23 +0000 (UTC)
Subject: Re: [PATCH] gssd: ignore pipe files that do not exist
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20200308192214.25071-1-steved@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <5a3d975f-53e7-efd5-32e2-b0479c28d7a0@RedHat.com>
Date:   Fri, 27 Mar 2020 15:15:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200308192214.25071-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/8/20 3:22 PM, Steve Dickson wrote:
> As part commit e0eb6ebb which cleaned up the
> dnotify to inotify conversion (commit 55197c98)
> ignore pipe files that don't exist
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-4-4-rc2)

steved.
> ---
>  utils/gssd/gssd.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
> index c38dedb..588da0f 100644
> --- a/utils/gssd/gssd.c
> +++ b/utils/gssd/gssd.c
> @@ -493,8 +493,8 @@ gssd_get_clnt(struct topdir *tdi, const char *name)
>  	clp->wd = inotify_add_watch(inotify_fd, clp->relpath, IN_CREATE | IN_DELETE);
>  	if (clp->wd < 0) {
>  		if (errno != ENOENT)
> -			printerr(0, "ERROR: inotify_add_watch failed for %s: %s\n",
> -			 	clp->relpath, strerror(errno));
> +			printerr(0, "ERROR: %s: inotify_add_watch failed for %s: %s\n",
> +			 	__FUNCTION__, clp->relpath, strerror(errno));
>  		goto out;
>  	}
>  
> @@ -523,8 +523,9 @@ gssd_scan_clnt(struct clnt_info *clp)
>  
>  	clntfd = openat(pipefs_fd, clp->relpath, O_RDONLY);
>  	if (clntfd < 0) {
> -		printerr(0, "ERROR: can't openat %s: %s\n",
> -			 clp->relpath, strerror(errno));
> +		if (errno != ENOENT)
> +			printerr(0, "ERROR: %s: can't openat %s: %s\n",
> +			 	__FUNCTION__, clp->relpath, strerror(errno));
>  		return -1;
>  	}
>  
> @@ -588,8 +589,8 @@ gssd_get_topdir(const char *name)
>  
>  	tdi->wd = inotify_add_watch(inotify_fd, name, IN_CREATE);
>  	if (tdi->wd < 0) {
> -		printerr(0, "ERROR: inotify_add_watch failed for top dir %s: %s\n",
> -			 tdi->name, strerror(errno));
> +		printerr(0, "ERROR: %s: inotify_add_watch failed for top dir %s: %s\n",
> +			 __FUNCTION__, tdi->name, strerror(errno));
>  		free(tdi);
>  		return NULL;
>  	}
> @@ -616,8 +617,9 @@ gssd_scan_topdir(const char *name)
>  
>  	dfd = openat(pipefs_fd, tdi->name, O_RDONLY);
>  	if (dfd < 0) {
> -		printerr(0, "ERROR: can't openat %s: %s\n",
> -			 tdi->name, strerror(errno));
> +		if (errno != ENOENT)
> +			printerr(0, "ERROR: %s: can't openat %s: %s\n",
> +			 	__FUNCTION__, tdi->name, strerror(errno));
>  		return;
>  	}
>  
> 

