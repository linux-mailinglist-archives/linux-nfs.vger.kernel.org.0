Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A5031D204
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Feb 2021 22:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhBPVZl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Feb 2021 16:25:41 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42]:40121 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhBPVZk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Feb 2021 16:25:40 -0500
Received: by mail-ej1-f42.google.com with SMTP id b14so12912152eju.7
        for <linux-nfs@vger.kernel.org>; Tue, 16 Feb 2021 13:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jzO9qgNyOPu9Fw9JEQI0EzSS2ZOB9hVpq6PlP4/WO+c=;
        b=TRyosQ5FoxydGhJpYvOsZZI/BsX4cdyXcIXw0y2l1VNlPFAgNWtIhws43JIEO2Zwjm
         8ULCeThYOCDM7a1tu4caSmIFj+YYjZpfjlnftyxh1BbZLU5WTyF6akxMYVmjKXnOuY8p
         ZGqAfZusEtHmJVCrXDiYu5ZOZPZdj4hGM6/dx/9TSAtQZsghbM3MhdvZqYKM/Cuab1v/
         9R4RMk7BkkEwDvpW9yP86xi3s95q7nN7Y8vvLx6PHEDzwczXdTt1w17/svSj8eoW+/Jj
         ZZyg5xjDTBljbJH6d6/kwkef/o0GXUqEnN/pl6hc//AvvbB4OMOol9pRz7XyxhKg80so
         bzCQ==
X-Gm-Message-State: AOAM533qeLBYBfX9x987FDqyS1FiAkO4kkRtwgI7S+QxbtdH1KI8zgo7
        Ir0SnJH6tRRVJwqmIrRxTYGrJ8XVV1KEwshgyfrPo/24ZAJB8Q==
X-Google-Smtp-Source: ABdhPJygtJpSGs7HpApLNO3+sF0UHaA72+iRcAloM6NzNr0NnIf8k33WzcZkzvxpY9nlIwLMiwa2KIfcpzGyIBiIY1U=
X-Received: by 2002:a17:906:a28a:: with SMTP id i10mr22721684ejz.422.1613510697589;
 Tue, 16 Feb 2021 13:24:57 -0800 (PST)
MIME-Version: 1.0
References: <20210215174002.2376333-1-dan@kernelim.com> <20210215174002.2376333-2-dan@kernelim.com>
In-Reply-To: <20210215174002.2376333-2-dan@kernelim.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Tue, 16 Feb 2021 16:24:41 -0500
Message-ID: <CAFX2JfkPRQ0o2BXgUhO+LEB6SBpUF5nivwAXQz5VAoH6iVTVXQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] sunrpc: rename 'net' to 'client'
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
> This is in preparation to adding a second directory to keep track
> of each transport.

I initially named the directory "net" to match how NFS's sysfs
directories are created (/sys/fs/nfs/net). If naming it "client" makes
more sense then I should probably introduce it that way in my patches.

Thoughts?
Anna

>
> Signed-off-by: Dan Aloni <dan@kernelim.com>
> ---
>  net/sunrpc/clnt.c  |  8 ++++----
>  net/sunrpc/sysfs.c | 22 +++++++++++-----------
>  net/sunrpc/sysfs.h |  4 ++--
>  3 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 02905eae5c0a..0a4811be01cd 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -301,7 +301,7 @@ static int rpc_client_register(struct rpc_clnt *clnt,
>         int err;
>
>         rpc_clnt_debugfs_register(clnt);
> -       rpc_netns_sysfs_setup(clnt, net);
> +       rpc_netns_client_sysfs_setup(clnt, net);
>
>         pipefs_sb = rpc_get_sb_net(net);
>         if (pipefs_sb) {
> @@ -329,7 +329,7 @@ static int rpc_client_register(struct rpc_clnt *clnt,
>  out:
>         if (pipefs_sb)
>                 rpc_put_sb_net(net);
> -       rpc_netns_sysfs_destroy(clnt);
> +       rpc_netns_client_sysfs_destroy(clnt);
>         rpc_clnt_debugfs_unregister(clnt);
>         return err;
>  }
> @@ -736,7 +736,7 @@ int rpc_switch_client_transport(struct rpc_clnt *clnt,
>
>         rpc_unregister_client(clnt);
>         __rpc_clnt_remove_pipedir(clnt);
> -       rpc_netns_sysfs_destroy(clnt);
> +       rpc_netns_client_sysfs_destroy(clnt);
>         rpc_clnt_debugfs_unregister(clnt);
>
>         /*
> @@ -883,7 +883,7 @@ static void rpc_free_client_work(struct work_struct *work)
>          * so they cannot be called in rpciod, so they are handled separately
>          * here.
>          */
> -       rpc_netns_sysfs_destroy(clnt);
> +       rpc_netns_client_sysfs_destroy(clnt);
>         rpc_clnt_debugfs_unregister(clnt);
>         rpc_free_clid(clnt);
>         rpc_clnt_remove_pipedir(clnt);
> diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
> index 8b01b4df64ee..3fe814795ed9 100644
> --- a/net/sunrpc/sysfs.c
> +++ b/net/sunrpc/sysfs.c
> @@ -9,7 +9,7 @@
>  #include "sysfs.h"
>
>  struct kobject *rpc_client_kobj;
> -static struct kset *rpc_client_kset;
> +static struct kset *rpc_sunrpc_kset;
>
>  static void rpc_netns_object_release(struct kobject *kobj)
>  {
> @@ -45,13 +45,13 @@ static struct kobject *rpc_netns_object_alloc(const char *name,
>
>  int rpc_sysfs_init(void)
>  {
> -       rpc_client_kset = kset_create_and_add("sunrpc", NULL, kernel_kobj);
> -       if (!rpc_client_kset)
> +       rpc_sunrpc_kset = kset_create_and_add("sunrpc", NULL, kernel_kobj);
> +       if (!rpc_sunrpc_kset)
>                 return -ENOMEM;
> -       rpc_client_kobj = rpc_netns_object_alloc("net", rpc_client_kset, NULL);
> +       rpc_client_kobj = rpc_netns_object_alloc("client", rpc_sunrpc_kset, NULL);
>         if (!rpc_client_kobj) {
> -               kset_unregister(rpc_client_kset);
> -               rpc_client_kset = NULL;
> +               kset_unregister(rpc_sunrpc_kset);
> +               rpc_sunrpc_kset = NULL;
>                 return -ENOMEM;
>         }
>         return 0;
> @@ -119,18 +119,18 @@ static struct kobj_type rpc_netns_client_type = {
>  void rpc_sysfs_exit(void)
>  {
>         kobject_put(rpc_client_kobj);
> -       kset_unregister(rpc_client_kset);
> +       kset_unregister(rpc_sunrpc_kset);
>  }
>
>  static struct rpc_netns_client *rpc_netns_client_alloc(struct kobject *parent,
> -                                               struct net *net, int clid)
> +                                                      struct net *net, int clid)
>  {
>         struct rpc_netns_client *p;
>
>         p = kzalloc(sizeof(*p), GFP_KERNEL);
>         if (p) {
>                 p->net = net;
> -               p->kobject.kset = rpc_client_kset;
> +               p->kobject.kset = rpc_sunrpc_kset;
>                 if (kobject_init_and_add(&p->kobject, &rpc_netns_client_type,
>                                         parent, "%d", clid) == 0)
>                         return p;
> @@ -139,7 +139,7 @@ static struct rpc_netns_client *rpc_netns_client_alloc(struct kobject *parent,
>         return NULL;
>  }
>
> -void rpc_netns_sysfs_setup(struct rpc_clnt *clnt, struct net *net)
> +void rpc_netns_client_sysfs_setup(struct rpc_clnt *clnt, struct net *net)
>  {
>         struct rpc_netns_client *rpc_client;
>         struct rpc_xprt *xprt = rcu_dereference(clnt->cl_xprt);
> @@ -155,7 +155,7 @@ void rpc_netns_sysfs_setup(struct rpc_clnt *clnt, struct net *net)
>         }
>  }
>
> -void rpc_netns_sysfs_destroy(struct rpc_clnt *clnt)
> +void rpc_netns_client_sysfs_destroy(struct rpc_clnt *clnt)
>  {
>         struct rpc_netns_client *rpc_client = clnt->cl_sysfs;
>
> diff --git a/net/sunrpc/sysfs.h b/net/sunrpc/sysfs.h
> index 137a12c87954..ab75c3cc91b6 100644
> --- a/net/sunrpc/sysfs.h
> +++ b/net/sunrpc/sysfs.h
> @@ -16,7 +16,7 @@ extern struct kobject *rpc_client_kobj;
>  extern int rpc_sysfs_init(void);
>  extern void rpc_sysfs_exit(void);
>
> -void rpc_netns_sysfs_setup(struct rpc_clnt *clnt, struct net *net);
> -void rpc_netns_sysfs_destroy(struct rpc_clnt *clnt);
> +void rpc_netns_client_sysfs_setup(struct rpc_clnt *clnt, struct net *net);
> +void rpc_netns_client_sysfs_destroy(struct rpc_clnt *clnt);
>
>  #endif
> --
> 2.26.2
>
