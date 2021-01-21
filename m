Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC94F2FEE90
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 16:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbhAUP0q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 10:26:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732664AbhAUPZD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 10:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611242615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sOAERrhYJC7LE2L+v3+c7msAO4+qXCrOeYdko5uCkhQ=;
        b=iCNCpAIMABHrMRBqoFF0+1hoj+/6VE1rvU8eDXvS3fgsQiaZBcHsuGbNoZ3jF/W6z1Yxp6
        HiuQppcKefVHjwhSnzSNSpmhNAADmPNgO7VQd+qwXagRP2GS2t8H0qi6Pykzf5aUXaLCG5
        0YrprBXzDQDDa3AQCGemEpBlzaccEgQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-Zr6Yp5SaMGWM70fpPDXJoA-1; Thu, 21 Jan 2021 10:23:32 -0500
X-MC-Unique: Zr6Yp5SaMGWM70fpPDXJoA-1
Received: by mail-ed1-f72.google.com with SMTP id dg17so1324657edb.11
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 07:23:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=sOAERrhYJC7LE2L+v3+c7msAO4+qXCrOeYdko5uCkhQ=;
        b=GnwUJsN+T0ztMywBVasR9OwPjc6QtuvGU2+apK3T6GAbIoUqE3S/5H4+ybEOVcELdr
         RZLO5oPj590fuhqOQBZAneyECHsXrvHICkdPdsiw+1nFBMEK5dBgkDnDm4UMuUJ9YVkU
         g7I2Ib3pUtUpLpcv+jmXYynJ0n2/ZTmXlV/ufSC4Wo0eOHdFj+2kwCd5453645VxP9zi
         WVRiQDVhAmgnZDWaHq6pBpZ2ykhbdHy0HOHPd6gPV3vUVUKNPy/RQgouQlixQZtQf/Jt
         S84QbhDiQOQv+jxVhtIGCQ+ftnGE6nv1JKSgR/uoZjtDR/3i7dKysa4IRLmv2J3boKuB
         yoxg==
X-Gm-Message-State: AOAM532SrqEY+frH0nz+4WTTlSV/Zg1fL3+GmDjBD7xe0kVWElgGwT7G
        JW4MrWYjg00GFzCEVRAv3iBlt3w4eFaowzv7bxL93t47Y9LK0KrTmYbuYzXfZsELZ4yp7Qth1+G
        DF5gaj7nalOpWjvdoS++jEv6N9g6HNmVKeYwr
X-Received: by 2002:a05:6402:430c:: with SMTP id m12mr3023230edc.299.1611242611551;
        Thu, 21 Jan 2021 07:23:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+hBYlDtECf+DFO2bYitChCUjkJ8zajtJTNA35LZvNst+U5hC8Pm4EwLcQ8dOt2izsNyr/c3Q069o8c6FPxFc=
X-Received: by 2002:a05:6402:430c:: with SMTP id m12mr3023224edc.299.1611242611394;
 Thu, 21 Jan 2021 07:23:31 -0800 (PST)
MIME-Version: 1.0
References: <20210105220634.27910-1-dwysocha@redhat.com> <20210105220634.27910-3-dwysocha@redhat.com>
In-Reply-To: <20210105220634.27910-3-dwysocha@redhat.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 21 Jan 2021 10:22:55 -0500
Message-ID: <CALF+zO=BOOM0Og1d5tnMYt6nG1danK5zFtxSME5qrbb-SmSE_w@mail.gmail.com>
Subject: Re: [PATCH 2/2] SUNRPC: Handle 0 length opaque XDR object data properly
To:     linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 5, 2021 at 5:12 PM Dave Wysochanski <dwysocha@redhat.com> wrote:
>
> When handling an auth_gss downcall, it's possible to get 0-length
> opaque object for the acceptor.  In this case we should make sure
> simple_get_netobj() returns -EFAULT and does not continue to
> kmemdup() which will return a special pointer value of
> ZERO_SIZE_PTR.  If it just so happens that the rpcgss_context
> trace event is enabled, the kernel will crash as follows:
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
>  include/linux/sunrpc/xdr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> index 8ef788ff80b9..aca38bdb0059 100644
> --- a/include/linux/sunrpc/xdr.h
> +++ b/include/linux/sunrpc/xdr.h
> @@ -53,7 +53,7 @@ simple_get_netobj(const void *p, const void *end, struct xdr_netobj *dest)
>         if (IS_ERR(p))
>                 return p;
>         q = (const void *)((const char *)p + len);
> -       if (unlikely(q > end || q < p))
> +       if (unlikely(q > end || q <= p))
>                 return ERR_PTR(-EFAULT);
>         dest->data = kmemdup(p, len, GFP_NOFS);
>         if (unlikely(dest->data == NULL))
> --
> 2.25.2
>

Just following up on this as I got no response, but didn't see
it in anyone's tree yet.

After talking offline with Bruce about this, I think the above
approach is wrong and i'm going to do a v2 of this patch.

The short reason is, I don't think simple_get_netobj() should be
returning the -EFAULT in the case of a 0-length acceptor,
which I explain in the cover letter why that is valid as an
object.  Rather I think this patch should do a explicit check
for 0 length, and then fill in dest->data = NULL:

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 8ef788ff80b9..b4f5bf104405 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -55,9 +55,12 @@ struct xdr_netobj {
        q = (const void *)((const char *)p + len);
        if (unlikely(q > end || q < p))
                return ERR_PTR(-EFAULT);
-       dest->data = kmemdup(p, len, GFP_NOFS);
-       if (unlikely(dest->data == NULL))
-               return ERR_PTR(-ENOMEM);
+       if (len) {
+               dest->data = kmemdup(p, len, GFP_NOFS);
+               if (unlikely(dest->data == NULL))
+                       return ERR_PTR(-ENOMEM);
+       } else
+               dest->data = NULL;
        dest->len = len;
        return q;

