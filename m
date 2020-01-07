Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95271132512
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2020 12:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgAGLl7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jan 2020 06:41:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39611 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726937AbgAGLl7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jan 2020 06:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578397318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/WO9qiPku6vZN0YiO+Pnb8FzJOqs+ZBTxjQFgMA2mJI=;
        b=db/ycZN9v2jTm+lalT0FygtaHBPWTSxh9rIyQdjtKWSgJK+HKZO85itNNhlmxV9QZDh49m
        59CcY2vlr6+nVOzs0lMfWAERyIumz9uWDIW9whdTQ/oTgDVsXQ/TIDcl5gxDN7WvcKtkaa
        hEG5MTMuPolS8Cyrl1l8+FRblhmMllA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-I-viOXfOOGaC2rnx7DBEMg-1; Tue, 07 Jan 2020 06:41:55 -0500
X-MC-Unique: I-viOXfOOGaC2rnx7DBEMg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C8C1801E76;
        Tue,  7 Jan 2020 11:41:53 +0000 (UTC)
Received: from localhost (dhcp-12-196.nay.redhat.com [10.66.12.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 154EF7FB53;
        Tue,  7 Jan 2020 11:41:52 +0000 (UTC)
Date:   Tue, 7 Jan 2020 19:41:51 +0800
From:   Murphy Zhou <xzhou@redhat.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] generic/529: use an ACL that doesn't confuse NFS
Message-ID: <20200107114151.lqk2dkqq2rc2aqgc@xzhoux.usersys.redhat.com>
References: <20191219223336.GC12026@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219223336.GC12026@fieldses.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 19, 2019 at 05:33:36PM -0500, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> For historical reasons having to do with Solaris ACL behavior, the Linux
> client treats an ACL like the one used as an example here as equivalent
> to a mode, causing listxattr to report that no ACL is set on the file.
> 
> (See the comment at the top of fs/nfs_common/nfsacl.c in the kernel
> source for details, and the "bogus ACL_MASK entry" comment in the same
> source file.)  This causes a spurious generic/529 failure on NFS.

Thanks Bruce very much for the fix!

Murphy

> 
> As far as I can tell any ACL should trigger the original XFS problem.
> So, modify it so as not to hit this odd NFS corner case.
> 
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  src/t_attr_corruption.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/t_attr_corruption.c b/src/t_attr_corruption.c
> index e7d435b1791f..b5513d44a288 100644
> --- a/src/t_attr_corruption.c
> +++ b/src/t_attr_corruption.c
> @@ -59,7 +59,7 @@ int main(int argc, char *argv[])
>  		.e = {
>  			{htole16(1), 0, 0},
>  			{htole16(4), 0, 0},
> -			{htole16(0x10), 0, 0},
> +			{htole16(0x10), htole16(4), 0},
>  			{htole16(0x20), 0, 0},
>  		},
>  	};
> -- 
> 2.24.1
> 

