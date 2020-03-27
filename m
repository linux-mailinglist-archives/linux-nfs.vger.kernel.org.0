Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C372195E6D
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2020 20:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgC0TPp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Mar 2020 15:15:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39203 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbgC0TPo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Mar 2020 15:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585336543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KKlNOHJdbVHhcERxdknINJYTU56HMzryso3AlCuyhiA=;
        b=QhiRFHSrg+iHG0ib9FM/YSTgFeuldEsoJ3c72QHp4RPKP3HN4JyFg0m5iMtJmGKdpkwayR
        GTW7/Uaj/hrRo6z9xi1s20Uzl1CdLzzKz3LVnx5CqMQOJw+rJH3MWpmHkUKyp8nnEyeYZr
        YhDEazEwd0QU5dIGAzS+IdrGAzJ73P8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-gDhrgAajN_mv_4Alo8Nd1A-1; Fri, 27 Mar 2020 15:15:42 -0400
X-MC-Unique: gDhrgAajN_mv_4Alo8Nd1A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5618D8017CC;
        Fri, 27 Mar 2020 19:15:40 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-114-250.phx2.redhat.com [10.3.114.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAF9B19C7F;
        Fri, 27 Mar 2020 19:15:39 +0000 (UTC)
Subject: Re: [PATCH] exports man page: warn about subdirectory exports
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
References: <20200316210146.GJ6938@fieldses.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <b1934589-28f1-6da7-7803-eb5bee71e878@RedHat.com>
Date:   Fri, 27 Mar 2020 15:15:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316210146.GJ6938@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/16/20 5:01 PM, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> Subdirectory exports have a number of problems which have been poorly
> documented.
> 
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Committed... (tag: nfs-utils-2-4-4-rc2)

steved.
> ---
>  utils/exportfs/exports.man | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
> index e3a16f6b276a..1d1718494e83 100644
> --- a/utils/exportfs/exports.man
> +++ b/utils/exportfs/exports.man
> @@ -494,6 +494,33 @@ export entry for
>  .B /home/joe
>  in the example section below, which maps all requests to uid 150 (which
>  is supposedly that of user joe).
> +
> +.SS Subdirectory Exports
> +
> +Normally you should only export only the root of a filesystem.  The NFS
> +server will also allow you to export a subdirectory of a filesystem,
> +however, this has drawbacks:
> +
> +First, it may be possible for a malicious user to access files on the
> +filesystem outside of the exported subdirectory, by guessing filehandles
> +for those other files.  The only way to prevent this is by using the
> +.IR no_subtree_check
> +option, which can cause other problems.
> +
> +Second, export options may not be enforced in the way that you would
> +expect.  For example, the
> +.IR security_label
> +option will not work on subdirectory exports, and if nested subdirectory
> +exports change the
> +.IR security_label
> +or
> +.IR sec=
> +options, NFSv4 clients will normally see only the options on the parent
> +export.  Also, where security options differ, a malicious client may use
> +filehandle-guessing attacks to access the files from one subdirectory
> +using the options from another.
> +
> +
>  .SS Extra Export Tables
>  After reading 
>  .I /etc/exports 
> 

