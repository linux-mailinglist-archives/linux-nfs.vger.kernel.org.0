Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C67D399413
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 21:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhFBT5i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Jun 2021 15:57:38 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:45961 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhFBT5i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Jun 2021 15:57:38 -0400
Received: by mail-ej1-f42.google.com with SMTP id k7so5579193ejv.12
        for <linux-nfs@vger.kernel.org>; Wed, 02 Jun 2021 12:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vVVX3bFBu3RFp+htjlxFp4uphHSpWh+ZiFm+G3qnBaQ=;
        b=Bz6Xa3620GKO2koc1pCjS6gBDjPxrCMhEqbGeaRB2R7kQMaM3lqHw4jtMLHBv9dOyp
         ZDc4w1c9uU7mCIvpdQNz6JXROQjfsJ5yD/3YuF6jwe75WOS234OO3QnZHUAI8t0xaqZd
         cDcF8AZIgCH+g8oBAIGgyvLsdfFBR9IQDCQF7PpWR5HCuvYNkbVekPnWjKFnMVWCpoqp
         pBmVflEwyYmwnJWOJSHBM0WxUTcEh+lS0Nx52aHllJnRLECXKdEEHdqWFVhKCIvrFjs9
         7bhZi95ZijV4JxMA5J3kv/457Sfj49AFERAiDsntnqsesdg6moEO5800OOhC3SOWt6sg
         OsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVVX3bFBu3RFp+htjlxFp4uphHSpWh+ZiFm+G3qnBaQ=;
        b=bRkw/Ws0aZ2NP9+AMYOj8I+xnyfaL+5sUSJU6S+fbyLaEF30s4QGOi3dElTLDZ6khV
         zES95OksonSXbusMkdt1WNICPMKuhjLIlW78fXluGp4cEruja3+K7TA2ig8gG7xgvwLj
         DYiSSe51I/+rjYwHBfstwY9ubf1Xu7P700dYE10fe4V3sadYMZ58OdourHhBRzgw/LDg
         1iF66t/FJSK+sytlN0Y/ypdRG/C8HZGaCfeJb1OP/FPp1yiQEemAhYcUiaHV2iTHC7Wl
         ifl8ZlGqwZXFlEnBzb97jjHTJC0w8Sd48/fpKxHqwLK0/r9tubJZmIlbG2d5ngkSFJoQ
         TTfA==
X-Gm-Message-State: AOAM533OwD3ZxokNo20607BasqLyAOQcrUVI39+KpR2YP7w0nCGg9zNZ
        kgG57+dt3au3o1yru5DBIScQbJfc6yf6UT12ysM=
X-Google-Smtp-Source: ABdhPJwAz9LnCib8OmO41YX2H9+pKQYrs6ika6HrgKcZIBCrc4ayOEV6NOz7F+bX+Xg3f3bLNdJ6n7QAPBafNhLCEto=
X-Received: by 2002:a17:906:495:: with SMTP id f21mr17808707eja.510.1622663680175;
 Wed, 02 Jun 2021 12:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210527191102.590275-1-smayhew@redhat.com> <20210527191102.590275-2-smayhew@redhat.com>
In-Reply-To: <20210527191102.590275-2-smayhew@redhat.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 2 Jun 2021 15:54:28 -0400
Message-ID: <CAN-5tyFbazw=bVtkmzDt3_Artnza4RZRgAbQezv4jjYruZW-Xw@mail.gmail.com>
Subject: Re: [nfs-utils PATCH v3 1/2] gssd: deal with failed thread creation
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 27, 2021 at 3:15 PM Scott Mayhew <smayhew@redhat.com> wrote:
>
> If we fail to create a thread to handle an upcall, we still need to do a
> downcall to tell the kernel about the failure, otherwise the process
> that is trying to establish gss credentials will hang.
>
> This patch shifts the thread creation down a level in the call chain so
> now the main thread does a little more work up front (reading & parsing
> the data from the pipefs file) so it has the info it needs to be able
> to do the error downcall.
>
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  utils/gssd/gssd.c      |  83 +-----------------
>  utils/gssd/gssd.h      |  11 ++-
>  utils/gssd/gssd_proc.c | 188 +++++++++++++++++++++++++++++++++--------
>  3 files changed, 164 insertions(+), 118 deletions(-)
>
> diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
> index 1541d371..eb440470 100644
> --- a/utils/gssd/gssd.c
> +++ b/utils/gssd/gssd.c
> @@ -364,7 +364,7 @@ out:
>  /* Actually frees clp and fields that might be used from other
>   * threads if was last reference.
>   */
> -static void
> +void
>  gssd_free_client(struct clnt_info *clp)
>  {
>         int refcnt;
> @@ -416,55 +416,6 @@ gssd_destroy_client(struct clnt_info *clp)
>
>  static void gssd_scan(void);
>
> -static int
> -start_upcall_thread(void (*func)(struct clnt_upcall_info *), void *info)
> -{
> -       pthread_attr_t attr;
> -       pthread_t th;
> -       int ret;
> -
> -       ret = pthread_attr_init(&attr);
> -       if (ret != 0) {
> -               printerr(0, "ERROR: failed to init pthread attr: ret %d: %s\n",
> -                        ret, strerror(errno));
> -               return ret;
> -       }
> -       ret = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
> -       if (ret != 0) {
> -               printerr(0, "ERROR: failed to create pthread attr: ret %d: "
> -                        "%s\n", ret, strerror(errno));
> -               return ret;
> -       }
> -
> -       ret = pthread_create(&th, &attr, (void *)func, (void *)info);
> -       if (ret != 0)
> -               printerr(0, "ERROR: pthread_create failed: ret %d: %s\n",
> -                        ret, strerror(errno));
> -       return ret;
> -}
> -
> -static struct clnt_upcall_info *alloc_upcall_info(struct clnt_info *clp)
> -{
> -       struct clnt_upcall_info *info;
> -
> -       info = malloc(sizeof(struct clnt_upcall_info));
> -       if (info == NULL)
> -               return NULL;
> -
> -       pthread_mutex_lock(&clp_lock);
> -       clp->refcount++;
> -       pthread_mutex_unlock(&clp_lock);
> -       info->clp = clp;
> -
> -       return info;
> -}
> -
> -void free_upcall_info(struct clnt_upcall_info *info)
> -{
> -       gssd_free_client(info->clp);
> -       free(info);
> -}
> -
>  /* For each upcall read the upcall info into the buffer, then create a
>   * thread in a detached state so that resources are released back into
>   * the system without the need for a join.
> @@ -473,44 +424,16 @@ static void
>  gssd_clnt_gssd_cb(int UNUSED(fd), short UNUSED(which), void *data)
>  {
>         struct clnt_info *clp = data;
> -       struct clnt_upcall_info *info;
> -
> -       info = alloc_upcall_info(clp);
> -       if (info == NULL)
> -               return;
>
> -       info->lbuflen = read(clp->gssd_fd, info->lbuf, sizeof(info->lbuf));
> -       if (info->lbuflen <= 0 || info->lbuf[info->lbuflen-1] != '\n') {
> -               printerr(0, "WARNING: %s: failed reading request\n", __func__);
> -               free_upcall_info(info);
> -               return;
> -       }
> -       info->lbuf[info->lbuflen-1] = 0;
> -
> -       if (start_upcall_thread(handle_gssd_upcall, info))
> -               free_upcall_info(info);
> +       handle_gssd_upcall(clp);
>  }
>
>  static void
>  gssd_clnt_krb5_cb(int UNUSED(fd), short UNUSED(which), void *data)
>  {
>         struct clnt_info *clp = data;
> -       struct clnt_upcall_info *info;
> -
> -       info = alloc_upcall_info(clp);
> -       if (info == NULL)
> -               return;
> -
> -       if (read(clp->krb5_fd, &info->uid,
> -                       sizeof(info->uid)) < (ssize_t)sizeof(info->uid)) {
> -               printerr(0, "WARNING: %s: failed reading uid from krb5 "
> -                        "upcall pipe: %s\n", __func__, strerror(errno));
> -               free_upcall_info(info);
> -               return;
> -       }
>
> -       if (start_upcall_thread(handle_krb5_upcall, info))
> -               free_upcall_info(info);
> +       handle_krb5_upcall(clp);
>  }
>
>  static struct clnt_info *
> diff --git a/utils/gssd/gssd.h b/utils/gssd/gssd.h
> index 1e8c58d4..6d53647e 100644
> --- a/utils/gssd/gssd.h
> +++ b/utils/gssd/gssd.h
> @@ -84,14 +84,17 @@ struct clnt_info {
>
>  struct clnt_upcall_info {
>         struct clnt_info        *clp;
> -       char                    lbuf[RPC_CHAN_BUF_SIZE];
> -       int                     lbuflen;
>         uid_t                   uid;
> +       int                     fd;
> +       char                    *srchost;
> +       char                    *target;
> +       char                    *service;
>  };
>
> -void handle_krb5_upcall(struct clnt_upcall_info *clp);
> -void handle_gssd_upcall(struct clnt_upcall_info *clp);
> +void handle_krb5_upcall(struct clnt_info *clp);
> +void handle_gssd_upcall(struct clnt_info *clp);
>  void free_upcall_info(struct clnt_upcall_info *info);
> +void gssd_free_client(struct clnt_info *clp);
>
>
>  #endif /* _RPC_GSSD_H_ */
> diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
> index e830f497..ebec414e 100644
> --- a/utils/gssd/gssd_proc.c
> +++ b/utils/gssd/gssd_proc.c
> @@ -80,6 +80,8 @@
>  #include "nfslib.h"
>  #include "gss_names.h"
>
> +extern pthread_mutex_t clp_lock;
> +
>  /* Encryption types supported by the kernel rpcsec_gss code */
>  int num_krb5_enctypes = 0;
>  krb5_enctype *krb5_enctypes = NULL;
> @@ -723,22 +725,133 @@ out_return_error:
>         goto out;
>  }
>
> -void
> -handle_krb5_upcall(struct clnt_upcall_info *info)
> +static struct clnt_upcall_info *
> +alloc_upcall_info(struct clnt_info *clp, uid_t uid, int fd, char *srchost,
> +                 char *target, char *service)
>  {
> -       struct clnt_info *clp = info->clp;
> +       struct clnt_upcall_info *info;
> +
> +       info = malloc(sizeof(struct clnt_upcall_info));
> +       if (info == NULL)
> +               return NULL;
> +
> +       memset(info, 0, sizeof(*info));
> +       pthread_mutex_lock(&clp_lock);
> +       clp->refcount++;
> +       pthread_mutex_unlock(&clp_lock);
> +       info->clp = clp;
> +       info->uid = uid;
> +       info->fd = fd;
> +       if (srchost) {
> +               info->srchost = strdup(srchost);
> +               if (info->srchost == NULL)
> +                       goto out_info;
> +       }
> +       if (target) {
> +               info->target = strdup(target);
> +               if (info->target == NULL)
> +                       goto out_srchost;
> +       }
> +       if (service) {
> +               info->service = strdup(service);
> +               if (info->service == NULL)
> +                       goto out_target;
> +       }
> +
> +out:
> +       return info;
> +
> +out_target:
> +       if (info->target)
> +               free(info->target);
> +out_srchost:
> +       if (info->srchost)
> +               free(info->srchost);
> +out_info:
> +       free(info);
> +       info = NULL;
> +       goto out;
> +}
>
> -       printerr(2, "\n%s: uid %d (%s)\n", __func__, info->uid, clp->relpath);
> +void free_upcall_info(struct clnt_upcall_info *info)
> +{
> +       gssd_free_client(info->clp);
> +       if (info->service)
> +               free(info->service);
> +       if (info->target)
> +               free(info->target);
> +       if (info->srchost)
> +               free(info->srchost);
> +       free(info);
> +}
>
> -       process_krb5_upcall(clp, info->uid, clp->krb5_fd, NULL, NULL, NULL);
> +static void
> +gssd_work_thread_fn(struct clnt_upcall_info *info)
> +{
> +       process_krb5_upcall(info->clp, info->uid, info->fd, info->srchost, info->target, info->service);
>         free_upcall_info(info);
>  }
>
> +static int
> +start_upcall_thread(void (*func)(struct clnt_upcall_info *), void *info)
> +{
> +       pthread_attr_t attr;
> +       pthread_t th;
> +       int ret;
> +
> +       ret = pthread_attr_init(&attr);
> +       if (ret != 0) {
> +               printerr(0, "ERROR: failed to init pthread attr: ret %d: %s\n",
> +                        ret, strerror(errno));
> +               return ret;
> +       }
> +       ret = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);

Given that the goal of the 2nd patch is to join the threads then this
doesn't make sense to me. Don't you want your upcall threads then
instead be using PTHREAD_CREATE_JOINABLE state?

Actually I'm not sure how this code works because documentation says
"once a thread has been detached, it can't be joined with
pthread_join(3) or be made joinable again".


> +       if (ret != 0) {
> +               printerr(0, "ERROR: failed to create pthread attr: ret %d: "
> +                        "%s\n", ret, strerror(errno));
> +               return ret;
> +       }
> +
> +       ret = pthread_create(&th, &attr, (void *)func, (void *)info);
> +       if (ret != 0)
> +               printerr(0, "ERROR: pthread_create failed: ret %d: %s\n",
> +                        ret, strerror(errno));
> +       return ret;
> +}
> +
> +void
> +handle_krb5_upcall(struct clnt_info *clp)
> +{
> +       uid_t                   uid;
> +       struct clnt_upcall_info *info;
> +       int                     err;
> +
> +       if (read(clp->krb5_fd, &uid, sizeof(uid)) < (ssize_t)sizeof(uid)) {
> +               printerr(0, "WARNING: failed reading uid from krb5 "
> +                           "upcall pipe: %s\n", strerror(errno));
> +               return;
> +       }
> +       printerr(2, "\n%s: uid %d (%s)\n", __func__, uid, clp->relpath);
> +
> +       info = alloc_upcall_info(clp, uid, clp->krb5_fd, NULL, NULL, NULL);
> +       if (info == NULL) {
> +               printerr(0, "%s: failed to allocate clnt_upcall_info\n", __func__);
> +               do_error_downcall(clp->krb5_fd, uid, -EACCES);
> +               return;
> +       }
> +       err = start_upcall_thread(gssd_work_thread_fn, info);
> +       if (err != 0) {
> +               do_error_downcall(clp->krb5_fd, uid, -EACCES);
> +               free_upcall_info(info);
> +       }
> +}
> +
>  void
> -handle_gssd_upcall(struct clnt_upcall_info *info)
> +handle_gssd_upcall(struct clnt_info *clp)
>  {
> -       struct clnt_info        *clp = info->clp;
>         uid_t                   uid;
> +       char                    lbuf[RPC_CHAN_BUF_SIZE];
> +       int                     lbuflen = 0;
>         char                    *p;
>         char                    *mech = NULL;
>         char                    *uidstr = NULL;
> @@ -746,20 +859,22 @@ handle_gssd_upcall(struct clnt_upcall_info *info)
>         char                    *service = NULL;
>         char                    *srchost = NULL;
>         char                    *enctypes = NULL;
> -       char                    *upcall_str;
> -       char                    *pbuf = info->lbuf;
>         pthread_t tid = pthread_self();
> +       struct clnt_upcall_info *info;
> +       int                     err;
>
> -       printerr(2, "\n%s(0x%x): '%s' (%s)\n", __func__, tid,
> -               info->lbuf, clp->relpath);
> -
> -       upcall_str = strdup(info->lbuf);
> -       if (upcall_str == NULL) {
> -               printerr(0, "ERROR: malloc failure\n");
> -               goto out_nomem;
> +       lbuflen = read(clp->gssd_fd, lbuf, sizeof(lbuf));
> +       if (lbuflen <= 0 || lbuf[lbuflen-1] != '\n') {
> +               printerr(0, "WARNING: handle_gssd_upcall: "
> +                           "failed reading request\n");
> +               return;
>         }
> +       lbuf[lbuflen-1] = 0;
> +
> +       printerr(2, "\n%s(0x%x): '%s' (%s)\n", __func__, tid,
> +                lbuf, clp->relpath);
>
> -       while ((p = strsep(&pbuf, " "))) {
> +       for (p = strtok(lbuf, " "); p; p = strtok(NULL, " ")) {
>                 if (!strncmp(p, "mech=", strlen("mech=")))
>                         mech = p + strlen("mech=");
>                 else if (!strncmp(p, "uid=", strlen("uid=")))
> @@ -777,8 +892,8 @@ handle_gssd_upcall(struct clnt_upcall_info *info)
>         if (!mech || strlen(mech) < 1) {
>                 printerr(0, "WARNING: handle_gssd_upcall: "
>                             "failed to find gss mechanism name "
> -                           "in upcall string '%s'\n", upcall_str);
> -               goto out;
> +                           "in upcall string '%s'\n", lbuf);
> +               return;
>         }
>
>         if (uidstr) {
> @@ -790,21 +905,21 @@ handle_gssd_upcall(struct clnt_upcall_info *info)
>         if (!uidstr) {
>                 printerr(0, "WARNING: handle_gssd_upcall: "
>                             "failed to find uid "
> -                           "in upcall string '%s'\n", upcall_str);
> -               goto out;
> +                           "in upcall string '%s'\n", lbuf);
> +               return;
>         }
>
>         if (enctypes && parse_enctypes(enctypes) != 0) {
>                 printerr(0, "WARNING: handle_gssd_upcall: "
>                          "parsing encryption types failed: errno %d\n", errno);
> -               goto out;
> +               return;
>         }
>
>         if (target && strlen(target) < 1) {
>                 printerr(0, "WARNING: handle_gssd_upcall: "
>                          "failed to parse target name "
> -                        "in upcall string '%s'\n", upcall_str);
> -               goto out;
> +                        "in upcall string '%s'\n", lbuf);
> +               return;
>         }
>
>         /*
> @@ -818,21 +933,26 @@ handle_gssd_upcall(struct clnt_upcall_info *info)
>         if (service && strlen(service) < 1) {
>                 printerr(0, "WARNING: handle_gssd_upcall: "
>                          "failed to parse service type "
> -                        "in upcall string '%s'\n", upcall_str);
> -               goto out;
> +                        "in upcall string '%s'\n", lbuf);
> +               return;
>         }
>
> -       if (strcmp(mech, "krb5") == 0 && clp->servername)
> -               process_krb5_upcall(clp, uid, clp->gssd_fd, srchost, target, service);
> -       else {
> +       if (strcmp(mech, "krb5") == 0 && clp->servername) {
> +               info = alloc_upcall_info(clp, uid, clp->gssd_fd, srchost, target, service);
> +               if (info == NULL) {
> +                       printerr(0, "%s: failed to allocate clnt_upcall_info\n", __func__);
> +                       do_error_downcall(clp->gssd_fd, uid, -EACCES);
> +                       return;
> +               }
> +               err = start_upcall_thread(gssd_work_thread_fn, info);
> +               if (err != 0) {
> +                       do_error_downcall(clp->gssd_fd, uid, -EACCES);
> +                       free_upcall_info(info);
> +               }
> +       } else {
>                 if (clp->servername)
>                         printerr(0, "WARNING: handle_gssd_upcall: "
>                                  "received unknown gss mech '%s'\n", mech);
>                 do_error_downcall(clp->gssd_fd, uid, -EACCES);
>         }
> -out:
> -       free(upcall_str);
> -out_nomem:
> -       free_upcall_info(info);
> -       return;
>  }
> --
> 2.30.2
>
