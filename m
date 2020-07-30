Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8DFE233885
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jul 2020 20:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgG3SjH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jul 2020 14:39:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32538 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726343AbgG3SjG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jul 2020 14:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596134344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bC63TVgc/Qu3+3GWEkVlIf/23VH1H3WmghGbbFToBz8=;
        b=dQ6c6ZMuVlolGD2bCZIPZ7KoMpOXxeR5ZLUbkL5UMHYDzzP3GkaNSzV3qk0ZT+ZB/QCv6V
        a4EnAR3Ny6AWoUkDFjje7nXYTzsSYWORNOZMVjZERx6Waxyv386ZUiBvp4vVkw27QJlYko
        vr9jwDOXjuTG1FEIwdWTfoy/E7/S5V0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-D0K3jKVzOJCJ2sX3j5Xh9Q-1; Thu, 30 Jul 2020 14:39:03 -0400
X-MC-Unique: D0K3jKVzOJCJ2sX3j5Xh9Q-1
Received: by mail-qk1-f198.google.com with SMTP id 1so5944685qki.22
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jul 2020 11:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=bC63TVgc/Qu3+3GWEkVlIf/23VH1H3WmghGbbFToBz8=;
        b=O39QpSNu0yXUHfXVE2WRVSTQi4BDRQvppY437kRS+zQJXt5bf7RBmMvcWfDFEIZT87
         Pwz9ZugQpU0r+WOJMrrYh0LtsLiw1xfnvjadMLXxQ25mFQoK4UyQIHCzIn/XVhDrYp+r
         fYX1BMHppR49lxhS5zhrowNWPalhZZuwyX7g2yGeOoRwZ1Dzsb4qZZcfRzHY0uMxP0fd
         3sUwDsbmS+nZoYJElVDyy8TYz5r70LaMah2hS7qdij8MTtOvMLlkAhTeckV88R+Mf/Fb
         554zZeOYeM+4CrPXyb+s5ouKhucIBI23ioQseOpR0qwEuS7nGp1NTNHtequsiG/oPtNk
         23ZA==
X-Gm-Message-State: AOAM533uVcgb8ZnMnw2Q1ZtNy/3Xc4oinAEPNnux7ASIS522QSi3EvGn
        AMNdIFVnoDjFwWL9PkJ1n4rk7h57MIqoU39Av7uQD61eImo5Lsl9jKkeN+5IKjydWxtNqdWCUdU
        pDoRtkQwxHaKKHe+OBw7n
X-Received: by 2002:ac8:4248:: with SMTP id r8mr41917qtm.218.1596134342762;
        Thu, 30 Jul 2020 11:39:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6PeiwQqkUEEnLdLCKeP0MSGaMW8G2D4oq644FeFVF6w6wOFBFxARtOS+vQffEypNOsNe87w==
X-Received: by 2002:ac8:4248:: with SMTP id r8mr41901qtm.218.1596134342573;
        Thu, 30 Jul 2020 11:39:02 -0700 (PDT)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id 94sm5291212qtc.88.2020.07.30.11.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 11:39:02 -0700 (PDT)
Message-ID: <43e8a8ff1ea015bb7bd335d5616268d36155327a.camel@redhat.com>
Subject: Re: [Linux-cachefs] [RFC PATCH v2 13/14] NFS: Call
 fscache_resize_cookie() when inode size changes due to setattr
From:   Jeff Layton <jlayton@redhat.com>
To:     Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Date:   Thu, 30 Jul 2020 14:39:01 -0400
In-Reply-To: <1596031949-26793-14-git-send-email-dwysocha@redhat.com>
References: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
         <1596031949-26793-14-git-send-email-dwysocha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2020-07-29 at 10:12 -0400, Dave Wysochanski wrote:
> Handle truncate / setattr when fscache is enabled by calling
> fscache_resize_cookie().
> 
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> ---
>  fs/nfs/inode.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 45067303348c..6b814246d07d 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -667,6 +667,7 @@ static int nfs_vmtruncate(struct inode * inode, loff_t offset)
>  	spin_unlock(&inode->i_lock);
>  	truncate_pagecache(inode, offset);
>  	spin_lock(&inode->i_lock);
> +	fscache_resize_cookie(nfs_i_fscache(inode), i_size_read(inode));
>  out:
>  	return err;
>  }

truncate can happen even when you have no open file descriptors on the
file and therefore w/o the cookie being "used". In the ceph vmtruncate
handling code, I do an explicit use/unuse around this call. Do you need
to do the same here?
-- 
Jeff Layton <jlayton@redhat.com>

