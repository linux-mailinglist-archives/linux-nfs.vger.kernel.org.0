Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12AD2FF317
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 19:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbhAUSZY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 13:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387656AbhAUST7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 13:19:59 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87F8C061756
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 10:19:02 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7CB2A6EA0; Thu, 21 Jan 2021 13:19:01 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7CB2A6EA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1611253141;
        bh=5cuGKuXBZ48kEj1enZQmZmABSIPqWP+zr761laGgWZw=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=CaUjsDDbdIKmLsLxPcPHDYHmj7WBxLDWXql56LQgb8vX/wTfHfv4nJGta1m98aHYO
         5UNku52tiZee6sdPR7F6QGdRX8MNvRUfUVWbe+ajyTnXOrKygAsXLcTscPB/vbEIly
         pqxy16QAI1saopMiA/53sIh0SaDhhNb0iYThhRpo=
Date:   Thu, 21 Jan 2021 13:19:01 -0500
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] SUNRPC: Handle 0 length opaque XDR object data
 properly
Message-ID: <20210121181901.GD20964@fieldses.org>
References: <1611246016-21129-1-git-send-email-dwysocha@redhat.com>
 <1611246016-21129-3-git-send-email-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611246016-21129-3-git-send-email-dwysocha@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 21, 2021 at 11:20:16AM -0500, Dave Wysochanski wrote:
> When handling an auth_gss downcall, it's possible to get 0-length
> opaque object for the acceptor.  In the case of a 0-length XDR
> object, make sure simple_get_netobj() fills in dest->data = NULL,
> and does not continue to kmemdup() which will set
> dest->data = ZERO_SIZE_PTR for the acceptor.

Thanks, sounds safe to me.--b.

> 
> The trace event code can handle NULL but not ZERO_SIZE_PTR for a
> string, and so without this patch the rpcgss_context trace event
> will crash the kernel as follows:
> 
> [  162.887992] BUG: kernel NULL pointer dereference, address: 0000000000000010
> [  162.898693] #PF: supervisor read access in kernel mode
> [  162.900830] #PF: error_code(0x0000) - not-present page
> [  162.902940] PGD 0 P4D 0
> [  162.904027] Oops: 0000 [#1] SMP PTI
> [  162.905493] CPU: 4 PID: 4321 Comm: rpc.gssd Kdump: loaded Not tainted 5.10.0 #133
> [  162.908548] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> [  162.910978] RIP: 0010:strlen+0x0/0x20
> [  162.912505] Code: 48 89 f9 74 09 48 83 c1 01 80 39 00 75 f7 31 d2 44 0f b6 04 16 44 88 04 11 48 83 c2 01 45 84 c0 75 ee c3 0f 1f 80 00 00 00 00 <80> 3f 00 74 10 48 89 f8 48 83 c0 01 80 38 00 75 f7 48 29 f8 c3 31
> [  162.920101] RSP: 0018:ffffaec900c77d90 EFLAGS: 00010202
> [  162.922263] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000fffde697
> [  162.925158] RDX: 000000000000002f RSI: 0000000000000080 RDI: 0000000000000010
> [  162.928073] RBP: 0000000000000010 R08: 0000000000000e10 R09: 0000000000000000
> [  162.930976] R10: ffff8e698a590cb8 R11: 0000000000000001 R12: 0000000000000e10
> [  162.933883] R13: 00000000fffde697 R14: 000000010034d517 R15: 0000000000070028
> [  162.936777] FS:  00007f1e1eb93700(0000) GS:ffff8e6ab7d00000(0000) knlGS:0000000000000000
> [  162.940067] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  162.942417] CR2: 0000000000000010 CR3: 0000000104eba000 CR4: 00000000000406e0
> [  162.945300] Call Trace:
> [  162.946428]  trace_event_raw_event_rpcgss_context+0x84/0x140 [auth_rpcgss]
> [  162.949308]  ? __kmalloc_track_caller+0x35/0x5a0
> [  162.951224]  ? gss_pipe_downcall+0x3a3/0x6a0 [auth_rpcgss]
> [  162.953484]  gss_pipe_downcall+0x585/0x6a0 [auth_rpcgss]
> [  162.955953]  rpc_pipe_write+0x58/0x70 [sunrpc]
> [  162.957849]  vfs_write+0xcb/0x2c0
> [  162.959264]  ksys_write+0x68/0xe0
> [  162.960706]  do_syscall_64+0x33/0x40
> [  162.962238]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  162.964346] RIP: 0033:0x7f1e1f1e57df
> 
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> ---
>  include/linux/sunrpc/xdr.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> index 8ef788ff80b9..b4f5bf104405 100644
> --- a/include/linux/sunrpc/xdr.h
> +++ b/include/linux/sunrpc/xdr.h
> @@ -55,9 +55,12 @@ struct xdr_netobj {
>  	q = (const void *)((const char *)p + len);
>  	if (unlikely(q > end || q < p))
>  		return ERR_PTR(-EFAULT);
> -	dest->data = kmemdup(p, len, GFP_NOFS);
> -	if (unlikely(dest->data == NULL))
> -		return ERR_PTR(-ENOMEM);
> +	if (len) {
> +		dest->data = kmemdup(p, len, GFP_NOFS);
> +		if (unlikely(dest->data == NULL))
> +			return ERR_PTR(-ENOMEM);
> +	} else
> +		dest->data = NULL;
>  	dest->len = len;
>  	return q;
>  }
> -- 
> 1.8.3.1
