Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F0231D259
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Feb 2021 22:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhBPVsW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Feb 2021 16:48:22 -0500
Received: from mail-ej1-f44.google.com ([209.85.218.44]:40550 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhBPVry (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Feb 2021 16:47:54 -0500
Received: by mail-ej1-f44.google.com with SMTP id b14so12986281eju.7
        for <linux-nfs@vger.kernel.org>; Tue, 16 Feb 2021 13:47:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W6FwiDChSQJK8iWKsUJ7NhcOXbmxWJ2sYAPiDgApT/s=;
        b=kApeFlh4xf06+MGr2YHxyGJzDZJm5g7GlUsgVaeo3pOpqwtId2YHo7Ea0rsP3shnUO
         x3bORfP/9pLMGeUWFJhVWATVo80KkEDomaGpiw+7eZ0P4ODNNdPZP+0w943NKhH0CRx3
         wcOLrRfNcF1j+cuVI5u6pfC9ys6OaX9sQhCUJlcErGXxkskl0ziPIGCfECo2DZ3xlClu
         gztK3w/1m/qLRf8MfV+FfSdYf1zXdYnyHMXA4QI68A7PE5wVI/lLQ5ZWWxfhMMAl+I+i
         UVY4TMdThu+28X3cSYpy55Y/628rUutQBmTMS1A5+VIrEjILAwiiVAS6QcPiUg0lCyvA
         VUzw==
X-Gm-Message-State: AOAM530T7/z4p7r+em8jaczU0gBrp4YJtufCbhC4EUfNFDwZYSIpXgRr
        KctATC89MfYZKriZfKpY/wurV/DMBdVBAw2PWmF8Rq9AMPZ4dQ==
X-Google-Smtp-Source: ABdhPJyxa/MQPjM2e1GRRsSAvO85ABdzbRmxwdksA/cLttYoBWGi66LtczwI1D/yYyCLbi/uZzglHvVVZh8KjMgdNrI=
X-Received: by 2002:a17:906:5655:: with SMTP id v21mr4310181ejr.264.1613512031206;
 Tue, 16 Feb 2021 13:47:11 -0800 (PST)
MIME-Version: 1.0
References: <20210215174002.2376333-1-dan@kernelim.com> <20210215174002.2376333-4-dan@kernelim.com>
In-Reply-To: <20210215174002.2376333-4-dan@kernelim.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Tue, 16 Feb 2021 16:46:55 -0500
Message-ID: <CAFX2JfkkYA=6gg9UzyT1=nuKrYJ+0c+Jd4BhasAgCR=T5Rgokw@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] sunrpc: add a directory per sunrpc xprt
To:     Dan Aloni <dan@kernelim.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dan,

On Mon, Feb 15, 2021 at 12:42 PM Dan Aloni <dan@kernelim.com> wrote:
>
> This uses much of the code from the per-client directory, except that
> now we have direct access to the transport struct. The per-client
> direct is adjusted in a subsequent commit.

Just a heads up that I've changed the per-client functions a bit, so
you'll probably need to adjust for that once I post v3 of my patches.


>
> Signed-off-by: Dan Aloni <dan@kernelim.com>
> ---
>  include/linux/sunrpc/xprt.h |   1 +
>  net/sunrpc/sysfs.c          | 131 ++++++++++++++++++++++++++++++++++--
>  net/sunrpc/sysfs.h          |   9 +++
>  net/sunrpc/xprt.c           |   3 +
>  4 files changed, 139 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
> index fbf57a87dc47..df0252de58f4 100644
> --- a/include/linux/sunrpc/xprt.h
> +++ b/include/linux/sunrpc/xprt.h
> @@ -260,6 +260,7 @@ struct rpc_xprt {
>                                                  * items */
>         struct list_head        bc_pa_list;     /* List of preallocated
>                                                  * backchannel rpc_rqst's */
> +       void                    *sysfs;         /* /sys/kernel/sunrpc/xprt/<id> */
>  #endif /* CONFIG_SUNRPC_BACKCHANNEL */
>
>         struct rb_root          recv_queue;     /* Receive queue */
> diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
> index 3fe814795ed9..687d4470b90d 100644
> --- a/net/sunrpc/sysfs.c
> +++ b/net/sunrpc/sysfs.c
> @@ -9,6 +9,7 @@
>  #include "sysfs.h"
>
>  struct kobject *rpc_client_kobj;
> +struct kobject *rpc_xprt_kobj;
>  static struct kset *rpc_sunrpc_kset;
>
>  static void rpc_netns_object_release(struct kobject *kobj)
> @@ -48,13 +49,24 @@ int rpc_sysfs_init(void)
>         rpc_sunrpc_kset = kset_create_and_add("sunrpc", NULL, kernel_kobj);
>         if (!rpc_sunrpc_kset)
>                 return -ENOMEM;
> +
>         rpc_client_kobj = rpc_netns_object_alloc("client", rpc_sunrpc_kset, NULL);
> -       if (!rpc_client_kobj) {
> -               kset_unregister(rpc_sunrpc_kset);
> -               rpc_sunrpc_kset = NULL;
> -               return -ENOMEM;
> -       }
> +       if (!rpc_client_kobj)
> +               goto err_kset;
> +
> +       rpc_xprt_kobj = rpc_netns_object_alloc("transport", rpc_sunrpc_kset, NULL);
> +       if (!rpc_xprt_kobj)
> +               goto err_client;
> +
>         return 0;
> +
> +err_client:
> +       kobject_put(rpc_client_kobj);
> +       rpc_client_kobj = NULL;
> +err_kset:
> +       kset_unregister(rpc_sunrpc_kset);
> +       rpc_sunrpc_kset = NULL;
> +       return -ENOMEM;
>  }
>
>  static ssize_t rpc_netns_dstaddr_show(struct kobject *kobj,
> @@ -118,6 +130,7 @@ static struct kobj_type rpc_netns_client_type = {
>
>  void rpc_sysfs_exit(void)
>  {
> +       kobject_put(rpc_xprt_kobj);
>         kobject_put(rpc_client_kobj);
>         kset_unregister(rpc_sunrpc_kset);
>  }
> @@ -166,3 +179,111 @@ void rpc_netns_client_sysfs_destroy(struct rpc_clnt *clnt)
>                 clnt->cl_sysfs = NULL;
>         }
>  }
> +
> +static ssize_t rpc_netns_xprt_dstaddr_show(struct kobject *kobj,
> +               struct kobj_attribute *attr, char *buf)
> +{
> +       struct rpc_netns_xprt *c = container_of(kobj,
> +                               struct rpc_netns_xprt, kobject);
> +       struct rpc_xprt *xprt = c->xprt;
> +
> +       if (!(xprt->prot & (IPPROTO_TCP | XPRT_TRANSPORT_RDMA))) {

We might want to change these restrictions later on, so if we're going
to put this into each function then maybe it would make sense to have
a quick inline to check protocol support?

I do the same check in the setup function for my patches, so if you
want I can add the inline function and then it'll just be there for
you to use.

> +               sprintf(buf, "N/A");
> +               return 0;

I'm guessing the point of putting "N/A" here is so userspace tools
don't have to guess which files exist or not for each protocol type?
Should I change my patches to match this style too?

Anna

> +       }
> +
> +       return rpc_ntop((struct sockaddr *)&xprt->addr, buf, PAGE_SIZE);
> +}
> +
> +static ssize_t rpc_netns_xprt_dstaddr_store(struct kobject *kobj,
> +               struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +       struct rpc_netns_xprt *c = container_of(kobj,
> +                               struct rpc_netns_xprt, kobject);
> +       struct rpc_xprt *xprt = c->xprt;
> +       struct sockaddr *saddr = (struct sockaddr *)&xprt->addr;
> +       int port;
> +
> +       if (!(xprt->prot & (IPPROTO_TCP | XPRT_TRANSPORT_RDMA)))
> +               return -EINVAL;
> +
> +       port = rpc_get_port(saddr);
> +
> +       xprt->addrlen = rpc_pton(xprt->xprt_net, buf, count - 1, saddr, sizeof(*saddr));
> +       rpc_set_port(saddr, port);
> +
> +       kfree(xprt->address_strings[RPC_DISPLAY_ADDR]);
> +       xprt->address_strings[RPC_DISPLAY_ADDR] = kstrndup(buf, count - 1, GFP_KERNEL);
> +
> +       xprt->ops->connect(xprt, NULL);
> +       return count;
> +}
> +
> +static void rpc_netns_xprt_release(struct kobject *kobj)
> +{
> +       struct rpc_netns_xprt *c;
> +
> +       c = container_of(kobj, struct rpc_netns_xprt, kobject);
> +       kfree(c);
> +}
> +
> +static const void *rpc_netns_xprt_namespace(struct kobject *kobj)
> +{
> +       return container_of(kobj, struct rpc_netns_xprt, kobject)->net;
> +}
> +
> +static struct kobj_attribute rpc_netns_xprt_dstaddr = __ATTR(dstaddr,
> +               0644, rpc_netns_xprt_dstaddr_show, rpc_netns_xprt_dstaddr_store);
> +
> +static struct attribute *rpc_netns_xprt_attrs[] = {
> +       &rpc_netns_xprt_dstaddr.attr,
> +       NULL,
> +};
> +
> +static struct kobj_type rpc_netns_xprt_type = {
> +       .release = rpc_netns_xprt_release,
> +       .default_attrs = rpc_netns_xprt_attrs,
> +       .sysfs_ops = &kobj_sysfs_ops,
> +       .namespace = rpc_netns_xprt_namespace,
> +};
> +
> +static struct rpc_netns_xprt *rpc_netns_xprt_alloc(struct kobject *parent,
> +                                                  struct net *net, int id)
> +{
> +       struct rpc_netns_xprt *p;
> +
> +       p = kzalloc(sizeof(*p), GFP_KERNEL);
> +       if (p) {
> +               p->net = net;
> +               p->kobject.kset = rpc_sunrpc_kset;
> +               if (kobject_init_and_add(&p->kobject, &rpc_netns_xprt_type,
> +                                        parent, "%d", id) == 0)
> +                       return p;
> +               kobject_put(&p->kobject);
> +       }
> +       return NULL;
> +}
> +
> +void rpc_netns_xprt_sysfs_setup(struct rpc_xprt *xprt, struct net *net)
> +{
> +       struct rpc_netns_xprt *rpc_xprt;
> +
> +       rpc_xprt = rpc_netns_xprt_alloc(rpc_xprt_kobj, net, xprt->id);
> +       if (rpc_xprt) {
> +               xprt->sysfs = rpc_xprt;
> +               rpc_xprt->xprt = xprt;
> +               kobject_uevent(&rpc_xprt->kobject, KOBJ_ADD);
> +       }
> +}
> +
> +void rpc_netns_xprt_sysfs_destroy(struct rpc_xprt *xprt)
> +{
> +       struct rpc_netns_xprt *rpc_xprt = xprt->sysfs;
> +
> +       if (rpc_xprt) {
> +               kobject_uevent(&rpc_xprt->kobject, KOBJ_REMOVE);
> +               kobject_del(&rpc_xprt->kobject);
> +               kobject_put(&rpc_xprt->kobject);
> +               xprt->sysfs = NULL;
> +       }
> +}
> diff --git a/net/sunrpc/sysfs.h b/net/sunrpc/sysfs.h
> index ab75c3cc91b6..e08dd7f6a1ec 100644
> --- a/net/sunrpc/sysfs.h
> +++ b/net/sunrpc/sysfs.h
> @@ -11,12 +11,21 @@ struct rpc_netns_client {
>         struct rpc_clnt *clnt;
>  };
>
> +struct rpc_netns_xprt {
> +       struct kobject kobject;
> +       struct net *net;
> +       struct rpc_xprt *xprt;
> +};
> +
>  extern struct kobject *rpc_client_kobj;
> +extern struct kobject *rpc_xprt_kobj;
>
>  extern int rpc_sysfs_init(void);
>  extern void rpc_sysfs_exit(void);
>
>  void rpc_netns_client_sysfs_setup(struct rpc_clnt *clnt, struct net *net);
>  void rpc_netns_client_sysfs_destroy(struct rpc_clnt *clnt);
> +void rpc_netns_xprt_sysfs_setup(struct rpc_xprt *xprt, struct net *net);
> +void rpc_netns_xprt_sysfs_destroy(struct rpc_xprt *xprt);
>
>  #endif
> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> index e30acd1f0e31..4098cb6b1453 100644
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
> @@ -1768,6 +1769,7 @@ struct rpc_xprt *xprt_alloc(struct net *net, size_t size,
>                 xprt->max_reqs = num_prealloc;
>         xprt->min_reqs = num_prealloc;
>         xprt->num_reqs = num_prealloc;
> +       rpc_netns_xprt_sysfs_setup(xprt, net);
>
>         return xprt;
>
> @@ -1780,6 +1782,7 @@ EXPORT_SYMBOL_GPL(xprt_alloc);
>
>  void xprt_free(struct rpc_xprt *xprt)
>  {
> +       rpc_netns_xprt_sysfs_destroy(xprt);
>         put_net(xprt->xprt_net);
>         xprt_free_all_slots(xprt);
>         xprt_free_id(xprt);
> --
> 2.26.2
>
