Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246A32FCA3B
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jan 2021 06:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbhATFAP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jan 2021 00:00:15 -0500
Received: from namei.org ([65.99.196.166]:50792 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbhATE7p (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 19 Jan 2021 23:59:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 6BA181BC;
        Wed, 20 Jan 2021 04:57:56 +0000 (UTC)
Date:   Wed, 20 Jan 2021 15:57:56 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
cc:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        David Quigley <dpquigl@davequigley.com>
Subject: Re: [PATCH] NFSv4.2: fix return value of
 _nfs4_get_security_label()
In-Reply-To: <20210115174356.408688-1-omosnace@redhat.com>
Message-ID: <2d85fd54-5c4d-391e-f01b-1537017aafa@namei.org>
References: <20210115174356.408688-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 15 Jan 2021, Ondrej Mosnacek wrote:

> An xattr 'get' handler is expected to return the length of the value on
> success, yet _nfs4_get_security_label() (and consequently also
> nfs4_xattr_get_nfs4_label(), which is used as an xattr handler) returns
> just 0 on success.
> 
> Fix this by returning label.len instead, which contains the length of
> the result.
> 
> Fixes: aa9c2669626c ("NFS: Client implementation of Labeled-NFS")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  fs/nfs/nfs4proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 2f4679a62712a..28465d8aada64 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -5971,7 +5971,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
>  		return ret;
>  	if (!(fattr.valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL))
>  		return -ENOENT;
> -	return 0;
> +	return label.len;
>  }


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

