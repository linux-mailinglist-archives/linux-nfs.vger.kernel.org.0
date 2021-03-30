Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0338134E36E
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Mar 2021 10:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhC3Iny (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Mar 2021 04:43:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231600AbhC3Ins (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Mar 2021 04:43:48 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-LgDxU002M_WsYx2CqLDouQ-1; Tue, 30 Mar 2021 04:43:29 -0400
X-MC-Unique: LgDxU002M_WsYx2CqLDouQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF48980732F
        for <linux-nfs@vger.kernel.org>; Tue, 30 Mar 2021 08:43:28 +0000 (UTC)
Received: from yoyang-pc.usersys.redhat.com (unknown [10.66.61.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E3F21001281;
        Tue, 30 Mar 2021 08:43:27 +0000 (UTC)
Date:   Tue, 30 Mar 2021 16:43:23 +0800
From:   Yongcheng Yang <yongcheng.yang@gmail.com>
To:     steved@redhat.com
Cc:     Roberto Bergantinos Corpas <rbergant@redhat.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] exportfs: make root unexportable
Message-ID: <20210330084323.GA4033@yoyang-pc.usersys.redhat.com>
References: <20210329105435.17431-1-rbergant@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329105435.17431-1-rbergant@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi SteveD,

This is a real problem introduced by my previous update. Sorry for it.

How about also adding this tag:
    Fixes: a9a7728d (exportfs: Deal with path's trailing "/" in unexportfs_parsed())

Thanks,
Yongcheng

On Mon, Mar 29, 2021 at 12:54:35PM +0200, Roberto Bergantinos Corpas wrote:
> If root of the filesystem is exported, it cannot be explicitly
> unexported, since unexportfs_parsed, in order to deal with trailing
> '/', will leave nlen at 0 for root exported case
> 
> Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
> ---
>  utils/exportfs/exportfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> index 9fcae0b3..9b6f4f5a 100644
> --- a/utils/exportfs/exportfs.c
> +++ b/utils/exportfs/exportfs.c
> @@ -372,7 +372,7 @@ unexportfs_parsed(char *hname, char *path, int verbose)
>  	 * so need to deal with it.
>  	*/
>  	size_t nlen = strlen(path);
> -	while (path[nlen - 1] == '/')
> +	while ((path[nlen - 1] == '/') && (nlen > 1))
>  		nlen--;
>  
>  	for (exp = exportlist[htype].p_head; exp; exp = exp->m_next) {
> -- 
> 2.21.0
> 

