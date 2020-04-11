Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADA281A4D98
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Apr 2020 05:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDKDKB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Apr 2020 23:10:01 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43135 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgDKDKB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Apr 2020 23:10:01 -0400
Received: by mail-vs1-f68.google.com with SMTP id u11so2399157vsu.10;
        Fri, 10 Apr 2020 20:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=LBgDv84I3ckmgTu3ivHx5w10eRA7knmGI/Q+O2z8ngw=;
        b=R/IbJQOTjiM4hal2cRECDmtHgGQCG+By9rF/T6UR+EWbEnbVZi6QgZz1rb380ObGRj
         pTRu1oqdrJKECunBHG6RkZv1qxum38kTlRAbxEn6O9v6VqvEC5ek8kVhtSjv7hoaORTo
         UGsu9IrJYxE71aHtX1XI4BnV23r4IC1kvVTw9xiQIvGBsUMzGbsFFZF/s3zxIup7iiz+
         /xe9LeYUsZHxEnSpCj5ngYAXQ54j+sNmb/qnKKpRYnCjTbtq4h3R/ZQDhdUefwwot5p9
         /wibG1I8Yp8+FBUj0/yriAQgjR9ZoviHZ2OWlKpr5EVYYJe+4Zt1Vn7yz7nosp172E+K
         3Ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=LBgDv84I3ckmgTu3ivHx5w10eRA7knmGI/Q+O2z8ngw=;
        b=Ep3NqGeVQfjNnDQKsJEV+8rgkikPGTUGXFJ4/YWMj9zKG1fkWhB0Fp3dCvpZx4RLFr
         w6/EwljxUZtEcFaiGbrU5kwJqy4rxCUqLQmkns7+AgTfqs+H6nLP3Cmp5buA9AiWpii+
         TSV4eOU6retL1qfwfHkiVJ0894sFC/utD0d6cUMt3lYgjx5NhvJnfxMZHgRX1lPUzwY0
         iySqiKkspxLO1RMqou7rHl+lpSNjxE8fWVJz/qgKwtM+3Yac1HVkrJs8fbxAKfR8KqmB
         LeIyoIUn6NtpYOVgscNrwcphVXlLpdsKX5d5beqHraEgtZLYPIBf5AK5FdOBC7c70g4l
         3FCg==
X-Gm-Message-State: AGi0Pubof7MfM0o0RwiWuc7ADxZCSLB6XdfATwYWW2P4ptpprctzqvo9
        ppJ0LlL57lf+S0Ja1EHBSWQxhHjuMp+kE+HUd1o=
X-Google-Smtp-Source: APiQypLC+W5JRo/N5QbvzguBalfA4Emtz7qqt8+oBlAWKtQjIeCcUTKoOpCOj6iLsmce8sjFcxtYjlKU25diri8bjwE=
X-Received: by 2002:a05:6102:107:: with SMTP id z7mr6073849vsq.235.1586574600188;
 Fri, 10 Apr 2020 20:10:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f985:0:0:0:0:0 with HTTP; Fri, 10 Apr 2020 20:09:59
 -0700 (PDT)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Sat, 11 Apr 2020 11:09:59 +0800
Message-ID: <CAABZP2yNZoSGr+t6T6KdFhu_3xM1HsM_ft1rK=gHRyyRTbCUMw@mail.gmail.com>
Subject: ping: [PATCH v3] NFS:remove redundant call to nfs_do_access
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        paulmck@linux.ibm.com, paulmck@linux.vnet.ibm.com, neilb@suse.com
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>, 340442286 <340442286@qq.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

ping

On 3/6/20, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> In function nfs_permission:
> 1. the rcu_read_lock and rcu_read_unlock around nfs_do_access
> is unnecessary because the rcu critical data structure is already
> protected in subsidiary function nfs_access_get_cached_rcu. No other
> data structure needs rcu_read_lock in nfs_do_access.
>
> 2. call nfs_do_access once is enough, because:
> 2-1. when mask has MAY_NOT_BLOCK bit
> The second call to nfs_do_access will not happen.
>
> 2-2. when mask has no MAY_NOT_BLOCK bit
> The second call to nfs_do_access will happen if res == -ECHILD, which
> means the first nfs_do_access goes out after statement if (!may_block).
> The second call to nfs_do_access will go through this procedure once
> again except continue the work after if (!may_block).
> But above work can be performed by only one call to nfs_do_access
> without mangling the mask flag.
>
> Tested in x86_64
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> ---
>  fs/nfs/dir.c |    9 +--------
>  1 files changed, 1 insertions(+), 8 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 193d6fb..37b0c10 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2732,14 +2732,7 @@ int nfs_permission(struct inode *inode, int mask)
>  	if (!NFS_PROTO(inode)->access)
>  		goto out_notsup;
>
> -	/* Always try fast lookups first */
> -	rcu_read_lock();
> -	res = nfs_do_access(inode, cred, mask|MAY_NOT_BLOCK);
> -	rcu_read_unlock();
> -	if (res == -ECHILD && !(mask & MAY_NOT_BLOCK)) {
> -		/* Fast lookup failed, try the slow way */
> -		res = nfs_do_access(inode, cred, mask);
> -	}
> +	res = nfs_do_access(inode, cred, mask);
>  out:
>  	if (!res && (mask & MAY_EXEC))
>  		res = nfs_execute_ok(inode, mask);
> --
> 1.7.1
>
>
