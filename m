Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CF539947D
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 22:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhFBUY1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Jun 2021 16:24:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53791 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229467AbhFBUY1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Jun 2021 16:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622665362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RV5B9SecNqfA5w5qhLW3zX5tzjiVHWrCQF7k/iSEL9Y=;
        b=RpBRkn/gE+rN5reLUmRKh3CBpGHxc3bwosXQnl11ebpKgnHznW069N+uIKKbEfeOlTvSe7
        UNunqUrQAT2U5wMoAqEUWcxpKrnjBl+BTCANqiqqWPbLIb5VB0goOp65khk4De8IwlCaJf
        lQsZYp3euDpPL1jOqKgNxx8ucLWRGvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-KSAJs4T8OUSbJtNThxV-Qg-1; Wed, 02 Jun 2021 16:22:41 -0400
X-MC-Unique: KSAJs4T8OUSbJtNThxV-Qg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC99780ED8D;
        Wed,  2 Jun 2021 20:22:40 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-114-18.rdu2.redhat.com [10.10.114.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 750CD60D43;
        Wed,  2 Jun 2021 20:22:40 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 935BE1A003D; Wed,  2 Jun 2021 16:22:39 -0400 (EDT)
Date:   Wed, 2 Jun 2021 16:22:39 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [nfs-utils PATCH v3 1/2] gssd: deal with failed thread creation
Message-ID: <YLfoj++3amTE2DG5@aion.usersys.redhat.com>
References: <20210527191102.590275-1-smayhew@redhat.com>
 <20210527191102.590275-2-smayhew@redhat.com>
 <CAN-5tyFbazw=bVtkmzDt3_Artnza4RZRgAbQezv4jjYruZW-Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyFbazw=bVtkmzDt3_Artnza4RZRgAbQezv4jjYruZW-Xw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 02 Jun 2021, Olga Kornievskaia wrote:

> On Thu, May 27, 2021 at 3:15 PM Scott Mayhew <smayhew@redhat.com> wrote:
> >
> > If we fail to create a thread to handle an upcall, we still need to do a
> > downcall to tell the kernel about the failure, otherwise the process
> > that is trying to establish gss credentials will hang.
> >
> > This patch shifts the thread creation down a level in the call chain so
> > now the main thread does a little more work up front (reading & parsing
> > the data from the pipefs file) so it has the info it needs to be able
> > to do the error downcall.
> >
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >  utils/gssd/gssd.c      |  83 +-----------------
> >  utils/gssd/gssd.h      |  11 ++-
> >  utils/gssd/gssd_proc.c | 188 +++++++++++++++++++++++++++++++++--------
> >  3 files changed, 164 insertions(+), 118 deletions(-)
> >
> > diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
> > index 1541d371..eb440470 100644
> > --- a/utils/gssd/gssd.c
> > +++ b/utils/gssd/gssd.c
> > @@ -364,7 +364,7 @@ out:
> >  /* Actually frees clp and fields that might be used from other
> >   * threads if was last reference.
> >   */
> > -static void
> > +void
> >  gssd_free_client(struct clnt_info *clp)
> >  {
> >         int refcnt;
> > @@ -416,55 +416,6 @@ gssd_destroy_client(struct clnt_info *clp)
> >
> >  static void gssd_scan(void);
> >
> > -static int
> > -start_upcall_thread(void (*func)(struct clnt_upcall_info *), void *info)
> > -{
> > -       pthread_attr_t attr;
> > -       pthread_t th;
> > -       int ret;
> > -
> > -       ret = pthread_attr_init(&attr);
> > -       if (ret != 0) {
> > -               printerr(0, "ERROR: failed to init pthread attr: ret %d: %s\n",
> > -                        ret, strerror(errno));
> > -               return ret;
> > -       }
> > -       ret = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
> > -       if (ret != 0) {
> > -               printerr(0, "ERROR: failed to create pthread attr: ret %d: "
> > -                        "%s\n", ret, strerror(errno));
> > -               return ret;
> > -       }
> > -
> > -       ret = pthread_create(&th, &attr, (void *)func, (void *)info);
> > -       if (ret != 0)
> > -               printerr(0, "ERROR: pthread_create failed: ret %d: %s\n",
> > -                        ret, strerror(errno));
> > -       return ret;
> > -}
> > -
> > -static struct clnt_upcall_info *alloc_upcall_info(struct clnt_info *clp)
> > -{
> > -       struct clnt_upcall_info *info;
> > -
> > -       info = malloc(sizeof(struct clnt_upcall_info));
> > -       if (info == NULL)
> > -               return NULL;
> > -
> > -       pthread_mutex_lock(&clp_lock);
> > -       clp->refcount++;
> > -       pthread_mutex_unlock(&clp_lock);
> > -       info->clp = clp;
> > -
> > -       return info;
> > -}
> > -
> > -void free_upcall_info(struct clnt_upcall_info *info)
> > -{
> > -       gssd_free_client(info->clp);
> > -       free(info);
> > -}
> > -
> >  /* For each upcall read the upcall info into the buffer, then create a
> >   * thread in a detached state so that resources are released back into
> >   * the system without the need for a join.
> > @@ -473,44 +424,16 @@ static void
> >  gssd_clnt_gssd_cb(int UNUSED(fd), short UNUSED(which), void *data)
> >  {
> >         struct clnt_info *clp = data;
> > -       struct clnt_upcall_info *info;
> > -
> > -       info = alloc_upcall_info(clp);
> > -       if (info == NULL)
> > -               return;
> >
> > -       info->lbuflen = read(clp->gssd_fd, info->lbuf, sizeof(info->lbuf));
> > -       if (info->lbuflen <= 0 || info->lbuf[info->lbuflen-1] != '\n') {
> > -               printerr(0, "WARNING: %s: failed reading request\n", __func__);
> > -               free_upcall_info(info);
> > -               return;
> > -       }
> > -       info->lbuf[info->lbuflen-1] = 0;
> > -
> > -       if (start_upcall_thread(handle_gssd_upcall, info))
> > -               free_upcall_info(info);
> > +       handle_gssd_upcall(clp);
> >  }
> >
> >  static void
> >  gssd_clnt_krb5_cb(int UNUSED(fd), short UNUSED(which), void *data)
> >  {
> >         struct clnt_info *clp = data;
> > -       struct clnt_upcall_info *info;
> > -
> > -       info = alloc_upcall_info(clp);
> > -       if (info == NULL)
> > -               return;
> > -
> > -       if (read(clp->krb5_fd, &info->uid,
> > -                       sizeof(info->uid)) < (ssize_t)sizeof(info->uid)) {
> > -               printerr(0, "WARNING: %s: failed reading uid from krb5 "
> > -                        "upcall pipe: %s\n", __func__, strerror(errno));
> > -               free_upcall_info(info);
> > -               return;
> > -       }
> >
> > -       if (start_upcall_thread(handle_krb5_upcall, info))
> > -               free_upcall_info(info);
> > +       handle_krb5_upcall(clp);
> >  }
> >
> >  static struct clnt_info *
> > diff --git a/utils/gssd/gssd.h b/utils/gssd/gssd.h
> > index 1e8c58d4..6d53647e 100644
> > --- a/utils/gssd/gssd.h
> > +++ b/utils/gssd/gssd.h
> > @@ -84,14 +84,17 @@ struct clnt_info {
> >
> >  struct clnt_upcall_info {
> >         struct clnt_info        *clp;
> > -       char                    lbuf[RPC_CHAN_BUF_SIZE];
> > -       int                     lbuflen;
> >         uid_t                   uid;
> > +       int                     fd;
> > +       char                    *srchost;
> > +       char                    *target;
> > +       char                    *service;
> >  };
> >
> > -void handle_krb5_upcall(struct clnt_upcall_info *clp);
> > -void handle_gssd_upcall(struct clnt_upcall_info *clp);
> > +void handle_krb5_upcall(struct clnt_info *clp);
> > +void handle_gssd_upcall(struct clnt_info *clp);
> >  void free_upcall_info(struct clnt_upcall_info *info);
> > +void gssd_free_client(struct clnt_info *clp);
> >
> >
> >  #endif /* _RPC_GSSD_H_ */
> > diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
> > index e830f497..ebec414e 100644
> > --- a/utils/gssd/gssd_proc.c
> > +++ b/utils/gssd/gssd_proc.c
> > @@ -80,6 +80,8 @@
> >  #include "nfslib.h"
> >  #include "gss_names.h"
> >
> > +extern pthread_mutex_t clp_lock;
> > +
> >  /* Encryption types supported by the kernel rpcsec_gss code */
> >  int num_krb5_enctypes = 0;
> >  krb5_enctype *krb5_enctypes = NULL;
> > @@ -723,22 +725,133 @@ out_return_error:
> >         goto out;
> >  }
> >
> > -void
> > -handle_krb5_upcall(struct clnt_upcall_info *info)
> > +static struct clnt_upcall_info *
> > +alloc_upcall_info(struct clnt_info *clp, uid_t uid, int fd, char *srchost,
> > +                 char *target, char *service)
> >  {
> > -       struct clnt_info *clp = info->clp;
> > +       struct clnt_upcall_info *info;
> > +
> > +       info = malloc(sizeof(struct clnt_upcall_info));
> > +       if (info == NULL)
> > +               return NULL;
> > +
> > +       memset(info, 0, sizeof(*info));
> > +       pthread_mutex_lock(&clp_lock);
> > +       clp->refcount++;
> > +       pthread_mutex_unlock(&clp_lock);
> > +       info->clp = clp;
> > +       info->uid = uid;
> > +       info->fd = fd;
> > +       if (srchost) {
> > +               info->srchost = strdup(srchost);
> > +               if (info->srchost == NULL)
> > +                       goto out_info;
> > +       }
> > +       if (target) {
> > +               info->target = strdup(target);
> > +               if (info->target == NULL)
> > +                       goto out_srchost;
> > +       }
> > +       if (service) {
> > +               info->service = strdup(service);
> > +               if (info->service == NULL)
> > +                       goto out_target;
> > +       }
> > +
> > +out:
> > +       return info;
> > +
> > +out_target:
> > +       if (info->target)
> > +               free(info->target);
> > +out_srchost:
> > +       if (info->srchost)
> > +               free(info->srchost);
> > +out_info:
> > +       free(info);
> > +       info = NULL;
> > +       goto out;
> > +}
> >
> > -       printerr(2, "\n%s: uid %d (%s)\n", __func__, info->uid, clp->relpath);
> > +void free_upcall_info(struct clnt_upcall_info *info)
> > +{
> > +       gssd_free_client(info->clp);
> > +       if (info->service)
> > +               free(info->service);
> > +       if (info->target)
> > +               free(info->target);
> > +       if (info->srchost)
> > +               free(info->srchost);
> > +       free(info);
> > +}
> >
> > -       process_krb5_upcall(clp, info->uid, clp->krb5_fd, NULL, NULL, NULL);
> > +static void
> > +gssd_work_thread_fn(struct clnt_upcall_info *info)
> > +{
> > +       process_krb5_upcall(info->clp, info->uid, info->fd, info->srchost, info->target, info->service);
> >         free_upcall_info(info);
> >  }
> >
> > +static int
> > +start_upcall_thread(void (*func)(struct clnt_upcall_info *), void *info)
> > +{
> > +       pthread_attr_t attr;
> > +       pthread_t th;
> > +       int ret;
> > +
> > +       ret = pthread_attr_init(&attr);
> > +       if (ret != 0) {
> > +               printerr(0, "ERROR: failed to init pthread attr: ret %d: %s\n",
> > +                        ret, strerror(errno));
> > +               return ret;
> > +       }
> > +       ret = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
> 
> Given that the goal of the 2nd patch is to join the threads then this
> doesn't make sense to me. Don't you want your upcall threads then
> instead be using PTHREAD_CREATE_JOINABLE state?

The second patch removes this call, so the threads will be joinable by
default after the second patch. 

If I would have done it in this patch, then I would have also had to
join the threads in this patch as well, which isn't the point of this
patch.  The point of this patch is to handle failures of
pthread_create().

> 
> Actually I'm not sure how this code works because documentation says
> "once a thread has been detached, it can't be joined with
> pthread_join(3) or be made joinable again".

I'm not joining threads in this patch, so they need to be detached.

All this patch is doing is shifting things around a bit so I have easier
access to the uid and the fd, so that I can do the error downcall to the
kernel if pthread_create() fails.  Otherwise the kernel thread that
initiated the upcall will be left hanging.

These patches accomplish two different things.  The first patch handles
pthread_create() failures and it's not necessary for the threads to be
joinable to do that.  The second patch adds the timeout, and in order to
do that the threads have to be joinable so I can see if they're still
running or not.

-Scott
> 
> 
> > +       if (ret != 0) {
> > +               printerr(0, "ERROR: failed to create pthread attr: ret %d: "
> > +                        "%s\n", ret, strerror(errno));
> > +               return ret;
> > +       }
> > +
> > +       ret = pthread_create(&th, &attr, (void *)func, (void *)info);
> > +       if (ret != 0)
> > +               printerr(0, "ERROR: pthread_create failed: ret %d: %s\n",
> > +                        ret, strerror(errno));
> > +       return ret;
> > +}
> > +
> > +void
> > +handle_krb5_upcall(struct clnt_info *clp)
> > +{
> > +       uid_t                   uid;
> > +       struct clnt_upcall_info *info;
> > +       int                     err;
> > +
> > +       if (read(clp->krb5_fd, &uid, sizeof(uid)) < (ssize_t)sizeof(uid)) {
> > +               printerr(0, "WARNING: failed reading uid from krb5 "
> > +                           "upcall pipe: %s\n", strerror(errno));
> > +               return;
> > +       }
> > +       printerr(2, "\n%s: uid %d (%s)\n", __func__, uid, clp->relpath);
> > +
> > +       info = alloc_upcall_info(clp, uid, clp->krb5_fd, NULL, NULL, NULL);
> > +       if (info == NULL) {
> > +               printerr(0, "%s: failed to allocate clnt_upcall_info\n", __func__);
> > +               do_error_downcall(clp->krb5_fd, uid, -EACCES);
> > +               return;
> > +       }
> > +       err = start_upcall_thread(gssd_work_thread_fn, info);
> > +       if (err != 0) {
> > +               do_error_downcall(clp->krb5_fd, uid, -EACCES);
> > +               free_upcall_info(info);
> > +       }
> > +}
> > +
> >  void
> > -handle_gssd_upcall(struct clnt_upcall_info *info)
> > +handle_gssd_upcall(struct clnt_info *clp)
> >  {
> > -       struct clnt_info        *clp = info->clp;
> >         uid_t                   uid;
> > +       char                    lbuf[RPC_CHAN_BUF_SIZE];
> > +       int                     lbuflen = 0;
> >         char                    *p;
> >         char                    *mech = NULL;
> >         char                    *uidstr = NULL;
> > @@ -746,20 +859,22 @@ handle_gssd_upcall(struct clnt_upcall_info *info)
> >         char                    *service = NULL;
> >         char                    *srchost = NULL;
> >         char                    *enctypes = NULL;
> > -       char                    *upcall_str;
> > -       char                    *pbuf = info->lbuf;
> >         pthread_t tid = pthread_self();
> > +       struct clnt_upcall_info *info;
> > +       int                     err;
> >
> > -       printerr(2, "\n%s(0x%x): '%s' (%s)\n", __func__, tid,
> > -               info->lbuf, clp->relpath);
> > -
> > -       upcall_str = strdup(info->lbuf);
> > -       if (upcall_str == NULL) {
> > -               printerr(0, "ERROR: malloc failure\n");
> > -               goto out_nomem;
> > +       lbuflen = read(clp->gssd_fd, lbuf, sizeof(lbuf));
> > +       if (lbuflen <= 0 || lbuf[lbuflen-1] != '\n') {
> > +               printerr(0, "WARNING: handle_gssd_upcall: "
> > +                           "failed reading request\n");
> > +               return;
> >         }
> > +       lbuf[lbuflen-1] = 0;
> > +
> > +       printerr(2, "\n%s(0x%x): '%s' (%s)\n", __func__, tid,
> > +                lbuf, clp->relpath);
> >
> > -       while ((p = strsep(&pbuf, " "))) {
> > +       for (p = strtok(lbuf, " "); p; p = strtok(NULL, " ")) {
> >                 if (!strncmp(p, "mech=", strlen("mech=")))
> >                         mech = p + strlen("mech=");
> >                 else if (!strncmp(p, "uid=", strlen("uid=")))
> > @@ -777,8 +892,8 @@ handle_gssd_upcall(struct clnt_upcall_info *info)
> >         if (!mech || strlen(mech) < 1) {
> >                 printerr(0, "WARNING: handle_gssd_upcall: "
> >                             "failed to find gss mechanism name "
> > -                           "in upcall string '%s'\n", upcall_str);
> > -               goto out;
> > +                           "in upcall string '%s'\n", lbuf);
> > +               return;
> >         }
> >
> >         if (uidstr) {
> > @@ -790,21 +905,21 @@ handle_gssd_upcall(struct clnt_upcall_info *info)
> >         if (!uidstr) {
> >                 printerr(0, "WARNING: handle_gssd_upcall: "
> >                             "failed to find uid "
> > -                           "in upcall string '%s'\n", upcall_str);
> > -               goto out;
> > +                           "in upcall string '%s'\n", lbuf);
> > +               return;
> >         }
> >
> >         if (enctypes && parse_enctypes(enctypes) != 0) {
> >                 printerr(0, "WARNING: handle_gssd_upcall: "
> >                          "parsing encryption types failed: errno %d\n", errno);
> > -               goto out;
> > +               return;
> >         }
> >
> >         if (target && strlen(target) < 1) {
> >                 printerr(0, "WARNING: handle_gssd_upcall: "
> >                          "failed to parse target name "
> > -                        "in upcall string '%s'\n", upcall_str);
> > -               goto out;
> > +                        "in upcall string '%s'\n", lbuf);
> > +               return;
> >         }
> >
> >         /*
> > @@ -818,21 +933,26 @@ handle_gssd_upcall(struct clnt_upcall_info *info)
> >         if (service && strlen(service) < 1) {
> >                 printerr(0, "WARNING: handle_gssd_upcall: "
> >                          "failed to parse service type "
> > -                        "in upcall string '%s'\n", upcall_str);
> > -               goto out;
> > +                        "in upcall string '%s'\n", lbuf);
> > +               return;
> >         }
> >
> > -       if (strcmp(mech, "krb5") == 0 && clp->servername)
> > -               process_krb5_upcall(clp, uid, clp->gssd_fd, srchost, target, service);
> > -       else {
> > +       if (strcmp(mech, "krb5") == 0 && clp->servername) {
> > +               info = alloc_upcall_info(clp, uid, clp->gssd_fd, srchost, target, service);
> > +               if (info == NULL) {
> > +                       printerr(0, "%s: failed to allocate clnt_upcall_info\n", __func__);
> > +                       do_error_downcall(clp->gssd_fd, uid, -EACCES);
> > +                       return;
> > +               }
> > +               err = start_upcall_thread(gssd_work_thread_fn, info);
> > +               if (err != 0) {
> > +                       do_error_downcall(clp->gssd_fd, uid, -EACCES);
> > +                       free_upcall_info(info);
> > +               }
> > +       } else {
> >                 if (clp->servername)
> >                         printerr(0, "WARNING: handle_gssd_upcall: "
> >                                  "received unknown gss mech '%s'\n", mech);
> >                 do_error_downcall(clp->gssd_fd, uid, -EACCES);
> >         }
> > -out:
> > -       free(upcall_str);
> > -out_nomem:
> > -       free_upcall_info(info);
> > -       return;
> >  }
> > --
> > 2.30.2
> >
> 

