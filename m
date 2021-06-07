Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB8A39E8D5
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Jun 2021 23:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhFGVFl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Jun 2021 17:05:41 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:39738 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhFGVFk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Jun 2021 17:05:40 -0400
Received: by mail-ed1-f42.google.com with SMTP id dj8so22043143edb.6
        for <linux-nfs@vger.kernel.org>; Mon, 07 Jun 2021 14:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KddZ93uWj1IR0G4sTIiEz7L3bkeZYDq7VLvNktL4Llo=;
        b=DvIUVKfCl7L8EuTr4sMALVgm+SVIiCv86gkh5bQAB+jtO72xUm2aYQHpXN0IxpM5DN
         VcIcFJpsrTD8EGbrHehlmbbF/uPNPGG3SpMFe5Zkc4yAUT3vFYx+F7CbxGiRyBGHCDMC
         7TAiy10kbdYWaH48c0iOhjHJ9jPvezpUbFg7bD9cvu9pkKaiypOu/MaU6nqaWHKhPZwN
         mVLRmqxLx7+q7dd6rCMfeBD6OfYTsFYiszeDTkp+1NxNBS90GRq6vpIaT77rlhUvcsfu
         yO+4YlUH0OVtCi0K42mLbxxIczvFhwaldyhlbx3k88uS9mpDiuUN8EbOoQUkXUKmY8mk
         slqg==
X-Gm-Message-State: AOAM533QhJ2rsnGCmIga73T5Ede/RKtsC5kjnMamESQNnGIwDfctGDST
        WzRkhOUP4j9zMQctwuZArDv9ITPq8aEiWnMe44g=
X-Google-Smtp-Source: ABdhPJxK1YlyfyqSvm0YwL/tKlioMrmh+XhCj1u7g8s5qvhS2jTSQ/7yIbRziVJm94Zj3ZkxbJ/uNWD3Ylcu4gf/tJQ=
X-Received: by 2002:aa7:c1da:: with SMTP id d26mr21819861edp.92.1623099827896;
 Mon, 07 Jun 2021 14:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210603222039.19182-1-olga.kornievskaia@gmail.com> <20210603222039.19182-11-olga.kornievskaia@gmail.com>
In-Reply-To: <20210603222039.19182-11-olga.kornievskaia@gmail.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Mon, 7 Jun 2021 17:03:31 -0400
Message-ID: <CAFX2Jf==uZQmZfySwWKZZr8PHHwJB5PvfTyyys334c2AWpSiWw@mail.gmail.com>
Subject: Re: [PATCH v9 10/13] sunrpc: add dst_attr attributes to the sysfs
 xprt directory
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga,

On Thu, Jun 3, 2021 at 6:23 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> From: Olga Kornievskaia <kolga@netapp.com>
>
> Allow to query and set the destination's address of a transport.
> Setting of the destination address is allowed only for TCP or RDMA
> based connections.
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  include/linux/sunrpc/xprt.h |  1 +
>  net/sunrpc/sysfs.c          | 99 +++++++++++++++++++++++++++++++++++++
>  net/sunrpc/xprt.c           |  4 +-
>  net/sunrpc/xprtmultipath.c  |  2 -
>  4 files changed, 103 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
> index 8360db664e5f..13a4eaf385cf 100644
> --- a/include/linux/sunrpc/xprt.h
> +++ b/include/linux/sunrpc/xprt.h
> @@ -414,6 +414,7 @@ void                        xprt_conditional_disconnect(struct rpc_xprt *xprt, unsigned int cookie);
>
>  bool                   xprt_lock_connect(struct rpc_xprt *, struct rpc_task *, void *);
>  void                   xprt_unlock_connect(struct rpc_xprt *, void *);
> +void                   xprt_release_write(struct rpc_xprt *, struct rpc_task *);
>
>  /*
>   * Reserved bit positions in xprt->state
> diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
> index 20f75708594f..4a14342e4d4e 100644
> --- a/net/sunrpc/sysfs.c
> +++ b/net/sunrpc/sysfs.c
> @@ -4,8 +4,23 @@
>   */
>  #include <linux/sunrpc/clnt.h>
>  #include <linux/kobject.h>
> +#include <linux/sunrpc/addr.h>
> +
>  #include "sysfs.h"
>
> +struct xprt_addr {
> +       const char *addr;
> +       struct rcu_head rcu;
> +};
> +
> +static void free_xprt_addr(struct rcu_head *head)
> +{
> +       struct xprt_addr *addr = container_of(head, struct xprt_addr, rcu);
> +
> +       kfree(addr->addr);
> +       kfree(addr);
> +}
> +
>  static struct kset *rpc_sunrpc_kset;
>  static struct kobject *rpc_sunrpc_client_kobj, *rpc_sunrpc_xprt_switch_kobj;
>
> @@ -43,6 +58,81 @@ static struct kobject *rpc_sysfs_object_alloc(const char *name,
>         return NULL;
>  }
>
> +static inline struct rpc_xprt *
> +rpc_sysfs_xprt_kobj_get_xprt(struct kobject *kobj)
> +{
> +       struct rpc_sysfs_xprt *x = container_of(kobj,
> +               struct rpc_sysfs_xprt, kobject);
> +
> +       return xprt_get(x->xprt);
> +}
> +
> +static ssize_t rpc_sysfs_xprt_dstaddr_show(struct kobject *kobj,
> +                                          struct kobj_attribute *attr,
> +                                          char *buf)
> +{
> +       struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
> +       ssize_t ret;
> +
> +       if (!xprt)
> +               return 0;
> +       ret = sprintf(buf, "%s\n", xprt->address_strings[RPC_DISPLAY_ADDR]);
> +       xprt_put(xprt);
> +       return ret + 1;
> +}
> +
> +static ssize_t rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
> +                                           struct kobj_attribute *attr,
> +                                           const char *buf, size_t count)
> +{
> +       struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
> +       struct sockaddr *saddr;
> +       char *dst_addr;
> +       int port;
> +       struct xprt_addr *saved_addr;
> +
> +       if (!xprt)
> +               return 0;
> +       if (!(xprt->xprt_class->ident == XPRT_TRANSPORT_TCP ||
> +             xprt->xprt_class->ident == XPRT_TRANSPORT_RDMA)) {
> +               xprt_put(xprt);
> +               return -EOPNOTSUPP;
> +       }
> +
> +       if (wait_on_bit_lock(&xprt->state, XPRT_LOCKED, TASK_KILLABLE)) {
> +               count = -EINTR;
> +               goto out_put;
> +       }
> +       saddr = (struct sockaddr *)&xprt->addr;
> +       port = rpc_get_port(saddr);
> +
> +       dst_addr = kstrndup(buf, count - 1, GFP_KERNEL);
> +       if (!dst_addr)
> +               goto out_err;
> +       saved_addr = kzalloc(sizeof(*saved_addr), GFP_KERNEL);
> +       if (!saved_addr)
> +               goto out_err_free;
> +       saved_addr->addr =
> +               rcu_dereference_raw(xprt->address_strings[RPC_DISPLAY_ADDR]);
> +       rcu_assign_pointer(xprt->address_strings[RPC_DISPLAY_ADDR], dst_addr);
> +       call_rcu(&saved_addr->rcu, free_xprt_addr);
> +       xprt->addrlen = rpc_pton(xprt->xprt_net, buf, count - 1, saddr,

The "count - 1" has been there since the beginning to account for NULL
terminated strings (like those passed using `echo` into the file). Now
that I'm working on the userspace side of things, I've realized this
isn't necessarily always the case. I'm wondering if it would make
sense to only decrement count if buf[count - 1] is "\0", but otherwise
leave it alone?

I found this by writing "192.168.111.186" through python, but the
resulting dstaddr was "192.168.111.18" when I tried reading it back.

Anna

> +                                sizeof(*saddr));
> +       rpc_set_port(saddr, port);
> +
> +       xprt_force_disconnect(xprt);
> +out:
> +       xprt_release_write(xprt, NULL);
> +out_put:
> +       xprt_put(xprt);
> +       return count;
> +out_err_free:
> +       kfree(dst_addr);
> +out_err:
> +       count = -ENOMEM;
> +       goto out;
> +}
> +
>  int rpc_sysfs_init(void)
>  {
>         rpc_sunrpc_kset = kset_create_and_add("sunrpc", NULL, kernel_kobj);
> @@ -106,6 +196,14 @@ static const void *rpc_sysfs_xprt_namespace(struct kobject *kobj)
>                             kobject)->xprt->xprt_net;
>  }
>
> +static struct kobj_attribute rpc_sysfs_xprt_dstaddr = __ATTR(dstaddr,
> +       0644, rpc_sysfs_xprt_dstaddr_show, rpc_sysfs_xprt_dstaddr_store);
> +
> +static struct attribute *rpc_sysfs_xprt_attrs[] = {
> +       &rpc_sysfs_xprt_dstaddr.attr,
> +       NULL,
> +};
> +
>  static struct kobj_type rpc_sysfs_client_type = {
>         .release = rpc_sysfs_client_release,
>         .sysfs_ops = &kobj_sysfs_ops,
> @@ -120,6 +218,7 @@ static struct kobj_type rpc_sysfs_xprt_switch_type = {
>
>  static struct kobj_type rpc_sysfs_xprt_type = {
>         .release = rpc_sysfs_xprt_release,
> +       .default_attrs = rpc_sysfs_xprt_attrs,
>         .sysfs_ops = &kobj_sysfs_ops,
>         .namespace = rpc_sysfs_xprt_namespace,
>  };
> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> index 20b9bd705014..fb6db09725c7 100644
> --- a/net/sunrpc/xprt.c
> +++ b/net/sunrpc/xprt.c
> @@ -55,6 +55,7 @@
>  #include <trace/events/sunrpc.h>
>
>  #include "sunrpc.h"
> +#include "sysfs.h"
>
>  /*
>   * Local variables
> @@ -443,7 +444,7 @@ void xprt_release_xprt_cong(struct rpc_xprt *xprt, struct rpc_task *task)
>  }
>  EXPORT_SYMBOL_GPL(xprt_release_xprt_cong);
>
> -static inline void xprt_release_write(struct rpc_xprt *xprt, struct rpc_task *task)
> +void xprt_release_write(struct rpc_xprt *xprt, struct rpc_task *task)
>  {
>         if (xprt->snd_task != task)
>                 return;
> @@ -1812,6 +1813,7 @@ void xprt_free(struct rpc_xprt *xprt)
>         put_net(xprt->xprt_net);
>         xprt_free_all_slots(xprt);
>         xprt_free_id(xprt);
> +       rpc_sysfs_xprt_destroy(xprt);
>         kfree_rcu(xprt, rcu);
>  }
>  EXPORT_SYMBOL_GPL(xprt_free);
> diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
> index e7973c1ff70c..07e76ae1028a 100644
> --- a/net/sunrpc/xprtmultipath.c
> +++ b/net/sunrpc/xprtmultipath.c
> @@ -86,7 +86,6 @@ void rpc_xprt_switch_remove_xprt(struct rpc_xprt_switch *xps,
>         spin_lock(&xps->xps_lock);
>         xprt_switch_remove_xprt_locked(xps, xprt);
>         spin_unlock(&xps->xps_lock);
> -       rpc_sysfs_xprt_destroy(xprt);
>         xprt_put(xprt);
>  }
>
> @@ -155,7 +154,6 @@ static void xprt_switch_free_entries(struct rpc_xprt_switch *xps)
>                                 struct rpc_xprt, xprt_switch);
>                 xprt_switch_remove_xprt_locked(xps, xprt);
>                 spin_unlock(&xps->xps_lock);
> -               rpc_sysfs_xprt_destroy(xprt);
>                 xprt_put(xprt);
>                 spin_lock(&xps->xps_lock);
>         }
> --
> 2.27.0
>
