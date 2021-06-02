Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A25399495
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 22:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhFBUfO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Jun 2021 16:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhFBUfN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Jun 2021 16:35:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34171C06174A
        for <linux-nfs@vger.kernel.org>; Wed,  2 Jun 2021 13:33:15 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id k25so282122eja.9
        for <linux-nfs@vger.kernel.org>; Wed, 02 Jun 2021 13:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcttRZv1UGIBWobv1C2wkQQzRVPYCm6HxBE086RySSU=;
        b=XUiniq74v2S9isjLeKPaAH7PImaMTzHl44YzKNIKAMjgZ74b0E2MSHhsBbK7e13nld
         SetW4QiBbDO92w5Qaubk7yqw3IQ5K5axeq9I+0aYPg3i/19i4cxvesKn+eIXN9FAAI6A
         8VWvqF5vGN0xdaOuzT37YX8D3DZawXtPxrZRt608MHRM2qznDlaJw9Vv9CW/h6bCgPT2
         H4azKUM3Zy7g7YByAo4aUzwV4QnB6tjg5+cjyl4szTB/cl/j7zyvnOBB6vFah8yse8yM
         IM6j42fiCneyKMOM99KbRP8OYXbO84mqDh3Ai0LZuJpRMobVQMYVw0y+VCYG5YbB03JD
         Tjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcttRZv1UGIBWobv1C2wkQQzRVPYCm6HxBE086RySSU=;
        b=Y8Kf5dEN9B8fJckHFeJrijibJyCZFPZ2HlCdd/cwh4rD7rw/kSQvZsPNMS+3LNUwI/
         6jUeNBq7A113Jpgyjhj/wZ9YyQesI458bvVG6WEda38dxkamxe8Fe+sDHg+kN8Et/vN+
         DleaQrDuJuNMBENKqrzMoT7RAJbn0qTZhN++dPSDqbDfmY4ZbIGj/pku00wBXIPXW5u5
         LvSyJ9nUgMFiwTvKa+VWisZmJcVLGKXBqYMS1px+waXppDjlI3KM6jkI4X+f6MT+3yJL
         Byefm1Up5TC05aGY4ra7FRdu66fXwCiH0HeYX1WmvRRSdBUdi5vInylKJeJvV9uc0CYF
         TTTA==
X-Gm-Message-State: AOAM533E9bBazJgbjQodapzd1yeq8T9Yy/D0qNuXHXqc3A526l9qZI30
        jNQHNZMgqqu1zJJcHGvl8pj/mTaB9gobtIp43FTOt9AB
X-Google-Smtp-Source: ABdhPJzYsGhSAJmjGENgJGCyou0Iyizv6OJM/f9W0DIoc1CGGW3RgnXgiKCzGE8Z2Dy7/UxXecOQwha/8GJtRAgQgnE=
X-Received: by 2002:a17:906:495:: with SMTP id f21mr17927110eja.510.1622665993436;
 Wed, 02 Jun 2021 13:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210527191102.590275-1-smayhew@redhat.com> <20210527191102.590275-3-smayhew@redhat.com>
 <CAN-5tyHsehgWwgnymRnTH=Bz5+HdOt6mWiTCtb2b9SkXQPfmTQ@mail.gmail.com>
In-Reply-To: <CAN-5tyHsehgWwgnymRnTH=Bz5+HdOt6mWiTCtb2b9SkXQPfmTQ@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 2 Jun 2021 16:33:02 -0400
Message-ID: <CAN-5tyFRv0EKrr99r3_wG9BD7u4dXqFKYDR4-X=afOQ4FGf5fw@mail.gmail.com>
Subject: Re: [nfs-utils PATCH v3 2/2] gssd: add timeout for upcall threads
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 2, 2021 at 4:01 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Thu, May 27, 2021 at 3:15 PM Scott Mayhew <smayhew@redhat.com> wrote:
> >
> > Add a global list of active upcalls and a watchdog thread that walks the
> > list, looking for threads running longer than timeout seconds. By
> > default, an error message will by logged to the syslog.
> >
> > The upcall timeout can be specified by passing the -U option or by
> > setting the upcall-timeout parameter in nfs.conf.
> >
> > Passing the -C option or setting cancel-timed-out-upcalls=1 in nfs.conf
> > causes the watchdog thread to also cancel timed-out upcall threads and
> > report an error of -ETIMEDOUT to the kernel.
> >
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >  nfs.conf               |   2 +
> >  utils/gssd/gssd.c      | 179 ++++++++++++++++++++++++++++++++++++++++-
> >  utils/gssd/gssd.h      |  18 +++++
> >  utils/gssd/gssd.man    |  31 ++++++-
> >  utils/gssd/gssd_proc.c | 138 +++++++++++++++++++++++++------
> >  5 files changed, 340 insertions(+), 28 deletions(-)
> >
> > diff --git a/nfs.conf b/nfs.conf
> > index 31994f61..8c714ff7 100644
> > --- a/nfs.conf
> > +++ b/nfs.conf
> > @@ -25,6 +25,8 @@
> >  # cred-cache-directory=
> >  # preferred-realm=
> >  # set-home=1
> > +# upcall-timeout=30
> > +# cancel-timed-out-upcalls=0
> >  #
> >  [lockd]
> >  # port=0
> > diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
> > index eb440470..4ca637f4 100644
> > --- a/utils/gssd/gssd.c
> > +++ b/utils/gssd/gssd.c
> > @@ -96,8 +96,29 @@ pthread_mutex_t clp_lock = PTHREAD_MUTEX_INITIALIZER;
> >  static bool signal_received = false;
> >  static struct event_base *evbase = NULL;
> >
> > +int upcall_timeout = DEF_UPCALL_TIMEOUT;
> > +static bool cancel_timed_out_upcalls = false;
> > +
> >  TAILQ_HEAD(topdir_list_head, topdir) topdir_list;
> >
> > +/*
> > + * active_thread_list:
> > + *
> > + *     used to track upcalls for timeout purposes.
> > + *
> > + *     protected by the active_thread_list_lock mutex.
> > + *
> > + *     upcall_thread_info structures are added to the tail of the list
> > + *     by start_upcall_thread(), so entries closer to the head of the list
> > + *     will be closer to hitting the upcall timeout.
> > + *
> > + *     upcall_thread_info structures are removed from the list upon a
> > + *     sucessful join of the upcall thread by the watchdog thread (via
> > + *     scan_active_thread_list().
> > + */
> > +TAILQ_HEAD(active_thread_list_head, upcall_thread_info) active_thread_list;
> > +pthread_mutex_t active_thread_list_lock = PTHREAD_MUTEX_INITIALIZER;
> > +
> >  struct topdir {
> >         TAILQ_ENTRY(topdir) list;
> >         TAILQ_HEAD(clnt_list_head, clnt_info) clnt_list;
> > @@ -436,6 +457,138 @@ gssd_clnt_krb5_cb(int UNUSED(fd), short UNUSED(which), void *data)
> >         handle_krb5_upcall(clp);
> >  }
> >
> > +/*
> > + * scan_active_thread_list:
> > + *
> > + * Walks the active_thread_list, trying to join as many upcall threads as
> > + * possible.  For threads that have terminated, the corresponding
> > + * upcall_thread_info will be removed from the list and freed.  Threads that
> > + * are still busy and have exceeded the upcall_timeout will cause an error to
> > + * be logged and may be canceled (depending on the value of
> > + * cancel_timed_out_upcalls).
> > + *
> > + * Returns the number of seconds that the watchdog thread should wait before
> > + * calling scan_active_thread_list() again.
> > + */
> > +static int
> > +scan_active_thread_list(void)
> > +{
> > +       struct upcall_thread_info *info;
> > +       struct timespec now;
> > +       unsigned int sleeptime;
> > +       bool sleeptime_set = false;
> > +       int err;
> > +       void *tret, *saveprev;
> > +
> > +       sleeptime = upcall_timeout;
> > +       pthread_mutex_lock(&active_thread_list_lock);
> > +       clock_gettime(CLOCK_MONOTONIC, &now);
> > +       TAILQ_FOREACH(info, &active_thread_list, list) {
> > +               err = pthread_tryjoin_np(info->tid, &tret);
> > +               switch (err) {
> > +               case 0:
> > +                       /*
> > +                        * The upcall thread has either completed successfully, or
> > +                        * has been canceled _and_ has acted on the cancellation request
> > +                        * (i.e. has hit a cancellation point).  We can now remove the
> > +                        * upcall_thread_info from the list and free it.
> > +                        */
> > +                       if (tret == PTHREAD_CANCELED)
> > +                               printerr(3, "watchdog: thread id 0x%lx cancelled successfully\n",
> > +                                               info->tid);
> > +                       saveprev = info->list.tqe_prev;
> > +                       TAILQ_REMOVE(&active_thread_list, info, list);
> > +                       free(info);
> > +                       info = saveprev;
> > +                       break;
> > +               case EBUSY:
> > +                       /*
> > +                        * The upcall thread is still running.  If the timeout has expired
> > +                        * then we either cancel the thread, log an error, and do an error
> > +                        * downcall to the kernel (cancel_timed_out_upcalls=true) or simply
> > +                        * log an error (cancel_timed_out_upcalls=false).  In either case,
> > +                        * the error is logged only once.
> > +                        */
> > +                       if (now.tv_sec >= info->timeout.tv_sec) {
> > +                               if (cancel_timed_out_upcalls && !(info->flags & UPCALL_THREAD_CANCELED)) {
> > +                                       printerr(0, "watchdog: thread id 0x%lx timed out\n",
> > +                                                       info->tid);
> > +                                       pthread_cancel(info->tid);
>
> I believe if the thread were to be canceled it needs to have been
> created with its cancelability state set to true.  I might have missed
> it in the previous patch but I dont think I saw calls to
> pthread_setcancelstate().

Nevermind. You are doing this in this patch.

>
> > +                                       info->flags |= (UPCALL_THREAD_CANCELED|UPCALL_THREAD_WARNED);
> > +                                       do_error_downcall(info->fd, info->uid, -ETIMEDOUT);
> > +                               } else {
> > +                                       if (!(info->flags & UPCALL_THREAD_WARNED)) {
> > +                                               printerr(0, "watchdog: thread id 0x%lx running for %ld seconds\n",
> > +                                                               info->tid,
> > +                                                               now.tv_sec - info->timeout.tv_sec + upcall_timeout);
> > +                                               info->flags |= UPCALL_THREAD_WARNED;
> > +                                       }
> > +                               }
> > +                       } else if (!sleeptime_set) {
> > +                       /*
> > +                        * The upcall thread is still running, but the timeout has not yet
> > +                        * expired.  Calculate the time remaining until the timeout will
> > +                        * expire.  This is the amount of time the watchdog thread will
> > +                        * wait before running again.  We only need to do this for the busy
> > +                        * thread closest to the head of the list - entries appearing later
> > +                        * in the list will time out later.
> > +                        */
> > +                               sleeptime = info->timeout.tv_sec - now.tv_sec;
> > +                               sleeptime_set = true;
> > +                       }
> > +                       break;
> > +               default:
> > +                       /* EDEADLK, EINVAL, and ESRCH... none of which should happen! */
> > +                       printerr(0, "watchdog: attempt to join thread id 0x%lx returned %d (%s)!\n",
> > +                                       info->tid, err, strerror(err));
> > +                       break;
> > +               }
> > +       }
> > +       pthread_mutex_unlock(&active_thread_list_lock);
> > +
> > +       return sleeptime;
> > +}
> > +
> > +static void *
> > +watchdog_thread_fn(void *UNUSED(arg))
> > +{
> > +       unsigned int sleeptime;
> > +
> > +       for (;;) {
> > +               sleeptime = scan_active_thread_list();
> > +               printerr(4, "watchdog: sleeping %u secs\n", sleeptime);
> > +               sleep(sleeptime);
> > +       }
> > +       return (void *)0;
> > +}
> > +
> > +static int
> > +start_watchdog_thread(void)
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
> > +       if (ret != 0) {
> > +               printerr(0, "ERROR: failed to create pthread attr: ret %d: %s\n",
> > +                        ret, strerror(errno));
> > +               return ret;
> > +       }
> > +       ret = pthread_create(&th, &attr, watchdog_thread_fn, NULL);
> > +       if (ret != 0) {
> > +               printerr(0, "ERROR: pthread_create failed: ret %d: %s\n",
> > +                        ret, strerror(errno));
> > +       }
> > +       return ret;
> > +}
> > +
> >  static struct clnt_info *
> >  gssd_get_clnt(struct topdir *tdi, const char *name)
> >  {
> > @@ -825,7 +978,7 @@ sig_die(int signal)
> >  static void
> >  usage(char *progname)
> >  {
> > -       fprintf(stderr, "usage: %s [-f] [-l] [-M] [-n] [-v] [-r] [-p pipefsdir] [-k keytab] [-d ccachedir] [-t timeout] [-R preferred realm] [-D] [-H]\n",
> > +       fprintf(stderr, "usage: %s [-f] [-l] [-M] [-n] [-v] [-r] [-p pipefsdir] [-k keytab] [-d ccachedir] [-t timeout] [-R preferred realm] [-D] [-H] [-U upcall timeout] [-C]\n",
> >                 progname);
> >         exit(1);
> >  }
> > @@ -846,6 +999,9 @@ read_gss_conf(void)
> >  #endif
> >         context_timeout = conf_get_num("gssd", "context-timeout", context_timeout);
> >         rpc_timeout = conf_get_num("gssd", "rpc-timeout", rpc_timeout);
> > +       upcall_timeout = conf_get_num("gssd", "upcall-timeout", upcall_timeout);
> > +       cancel_timed_out_upcalls = conf_get_bool("gssd", "cancel-timed-out-upcalls",
> > +                                               cancel_timed_out_upcalls);
> >         s = conf_get_str("gssd", "pipefs-directory");
> >         if (!s)
> >                 s = conf_get_str("general", "pipefs-directory");
> > @@ -887,7 +1043,7 @@ main(int argc, char *argv[])
> >         verbosity = conf_get_num("gssd", "verbosity", verbosity);
> >         rpc_verbosity = conf_get_num("gssd", "rpc-verbosity", rpc_verbosity);
> >
> > -       while ((opt = getopt(argc, argv, "HDfvrlmnMp:k:d:t:T:R:")) != -1) {
> > +       while ((opt = getopt(argc, argv, "HDfvrlmnMp:k:d:t:T:R:U:C")) != -1) {
> >                 switch (opt) {
> >                         case 'f':
> >                                 fg = 1;
> > @@ -938,6 +1094,12 @@ main(int argc, char *argv[])
> >                         case 'H':
> >                                 set_home = false;
> >                                 break;
> > +                       case 'U':
> > +                               upcall_timeout = atoi(optarg);
> > +                               break;
> > +                       case 'C':
> > +                               cancel_timed_out_upcalls = true;
> > +                               break;
> >                         default:
> >                                 usage(argv[0]);
> >                                 break;
> > @@ -1010,6 +1172,11 @@ main(int argc, char *argv[])
> >         else
> >                 progname = argv[0];
> >
> > +       if (upcall_timeout > MAX_UPCALL_TIMEOUT)
> > +               upcall_timeout = MAX_UPCALL_TIMEOUT;
> > +       else if (upcall_timeout < MIN_UPCALL_TIMEOUT)
> > +               upcall_timeout = MIN_UPCALL_TIMEOUT;
> > +
> >         initerr(progname, verbosity, fg);
> >  #ifdef HAVE_LIBTIRPC_SET_DEBUG
> >         /*
> > @@ -1068,6 +1235,14 @@ main(int argc, char *argv[])
> >         }
> >         event_add(inotify_ev, NULL);
> >
> > +       TAILQ_INIT(&active_thread_list);
> > +
> > +       rc = start_watchdog_thread();
> > +       if (rc != 0) {
> > +               printerr(0, "ERROR: failed to start watchdog thread: %d\n", rc);
> > +               exit(EXIT_FAILURE);
> > +       }
> > +
> >         TAILQ_INIT(&topdir_list);
> >         gssd_scan();
> >         daemon_ready();
> > diff --git a/utils/gssd/gssd.h b/utils/gssd/gssd.h
> > index 6d53647e..c52c5b48 100644
> > --- a/utils/gssd/gssd.h
> > +++ b/utils/gssd/gssd.h
> > @@ -50,6 +50,12 @@
> >  #define GSSD_DEFAULT_KEYTAB_FILE               "/etc/krb5.keytab"
> >  #define GSSD_SERVICE_NAME                      "nfs"
> >  #define RPC_CHAN_BUF_SIZE                      32768
> > +
> > +/* timeouts are in seconds */
> > +#define MIN_UPCALL_TIMEOUT                     5
> > +#define DEF_UPCALL_TIMEOUT                     30
> > +#define MAX_UPCALL_TIMEOUT                     600
> > +
> >  /*
> >   * The gss mechanisms that we can handle
> >   */
> > @@ -91,10 +97,22 @@ struct clnt_upcall_info {
> >         char                    *service;
> >  };
> >
> > +struct upcall_thread_info {
> > +       TAILQ_ENTRY(upcall_thread_info) list;
> > +       pthread_t               tid;
> > +       struct timespec         timeout;
> > +       uid_t                   uid;
> > +       int                     fd;
> > +       unsigned short          flags;
> > +#define UPCALL_THREAD_CANCELED 0x0001
> > +#define UPCALL_THREAD_WARNED   0x0002
> > +};
> > +
> >  void handle_krb5_upcall(struct clnt_info *clp);
> >  void handle_gssd_upcall(struct clnt_info *clp);
> >  void free_upcall_info(struct clnt_upcall_info *info);
> >  void gssd_free_client(struct clnt_info *clp);
> > +int do_error_downcall(int k5_fd, uid_t uid, int err);
> >
> >
> >  #endif /* _RPC_GSSD_H_ */
> > diff --git a/utils/gssd/gssd.man b/utils/gssd/gssd.man
> > index 9ae6def9..2a5384d3 100644
> > --- a/utils/gssd/gssd.man
> > +++ b/utils/gssd/gssd.man
> > @@ -8,7 +8,7 @@
> >  rpc.gssd \- RPCSEC_GSS daemon
> >  .SH SYNOPSIS
> >  .B rpc.gssd
> > -.RB [ \-DfMnlvrH ]
> > +.RB [ \-DfMnlvrHC ]
> >  .RB [ \-k
> >  .IR keytab ]
> >  .RB [ \-p
> > @@ -17,6 +17,10 @@ rpc.gssd \- RPCSEC_GSS daemon
> >  .IR ccachedir ]
> >  .RB [ \-t
> >  .IR timeout ]
> > +.RB [ \-T
> > +.IR timeout ]
> > +.RB [ \-U
> > +.IR timeout ]
> >  .RB [ \-R
> >  .IR realm ]
> >  .SH INTRODUCTION
> > @@ -275,7 +279,7 @@ seconds, which allows changing Kerberos tickets and identities frequently.
> >  The default is no explicit timeout, which means the kernel context will live
> >  the lifetime of the Kerberos service ticket used in its creation.
> >  .TP
> > -.B -T timeout
> > +.BI "-T " timeout
> >  Timeout, in seconds, to create an RPC connection with a server while
> >  establishing an authenticated gss context for a user.
> >  The default timeout is set to 5 seconds.
> > @@ -283,6 +287,18 @@ If you get messages like "WARNING: can't create tcp rpc_clnt to server
> >  %servername% for user with uid %uid%: RPC: Remote system error -
> >  Connection timed out", you should consider an increase of this timeout.
> >  .TP
> > +.BI "-U " timeout
> > +Timeout, in seconds, for upcall threads.  Threads executing longer than
> > +.I timeout
> > +seconds will cause an error message to be logged.  The default
> > +.I timeout
> > +is 30 seconds.  The minimum is 5 seconds.  The maximum is 600 seconds.
> > +.TP
> > +.B -C
> > +In addition to logging an error message for threads that have timed out,
> > +the thread will be canceled and an error of -ETIMEDOUT will be reported
> > +to the kernel.
> > +.TP
> >  .B -H
> >  Avoids setting $HOME to "/". This allows rpc.gssd to read per user k5identity
> >  files versus trying to read /.k5identity for each user.
> > @@ -350,6 +366,17 @@ Equivalent to
> >  Equivalent to
> >  .BR -R .
> >  .TP
> > +.B upcall-timeout
> > +Equivalent to
> > +.BR -U .
> > +.TP
> > +.B cancel-timed-out-upcalls
> > +Setting to
> > +.B true
> > +is equivalent to providing the
> > +.B -C
> > +flag.
> > +.TP
> >  .B set-home
> >  Setting to
> >  .B false
> > diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
> > index ebec414e..60f61836 100644
> > --- a/utils/gssd/gssd_proc.c
> > +++ b/utils/gssd/gssd_proc.c
> > @@ -81,11 +81,24 @@
> >  #include "gss_names.h"
> >
> >  extern pthread_mutex_t clp_lock;
> > +extern pthread_mutex_t active_thread_list_lock;
> > +extern int upcall_timeout;
> > +extern TAILQ_HEAD(active_thread_list_head, upcall_thread_info) active_thread_list;
> >
> >  /* Encryption types supported by the kernel rpcsec_gss code */
> >  int num_krb5_enctypes = 0;
> >  krb5_enctype *krb5_enctypes = NULL;
> >
> > +/* Args for the cleanup_handler() */
> > +struct cleanup_args  {
> > +       OM_uint32       *min_stat;
> > +       gss_buffer_t    acceptor;
> > +       gss_buffer_t    token;
> > +       struct authgss_private_data *pd;
> > +       AUTH            **auth;
> > +       CLIENT          **rpc_clnt;
> > +};
> > +
> >  /*
> >   * Parse the supported encryption type information
> >   */
> > @@ -184,7 +197,7 @@ out_err:
> >         return;
> >  }
> >
> > -static int
> > +int
> >  do_error_downcall(int k5_fd, uid_t uid, int err)
> >  {
> >         char    buf[1024];
> > @@ -608,13 +621,50 @@ out:
> >  }
> >
> >  /*
> > + * cleanup_handler:
> > + *
> > + * Free any resources allocated by process_krb5_upcall().
> > + *
> > + * Runs upon normal termination of process_krb5_upcall as well as if the
> > + * thread is canceled.
> > + */
> > +static void
> > +cleanup_handler(void *arg)
> > +{
> > +       struct cleanup_args *args = (struct cleanup_args *)arg;
> > +
> > +       gss_release_buffer(args->min_stat, args->acceptor);
> > +       if (args->token->value)
> > +               free(args->token->value);
> > +#ifdef HAVE_AUTHGSS_FREE_PRIVATE_DATA
> > +       if (args->pd->pd_ctx_hndl.length != 0 || args->pd->pd_ctx != 0)
> > +               authgss_free_private_data(args->pd);
> > +#endif
> > +       if (*args->auth)
> > +               AUTH_DESTROY(*args->auth);
> > +       if (*args->rpc_clnt)
> > +               clnt_destroy(*args->rpc_clnt);
> > +}
> > +
> > +/*
> > + * process_krb5_upcall:
> > + *
> >   * this code uses the userland rpcsec gss library to create a krb5
> >   * context on behalf of the kernel
> > + *
> > + * This is the meat of the upcall thread.  Note that cancelability is disabled
> > + * and enabled at various points to ensure that any resources reserved by the
> > + * lower level libraries are released safely.
> >   */
> >  static void
> > -process_krb5_upcall(struct clnt_info *clp, uid_t uid, int fd, char *srchost,
> > -                   char *tgtname, char *service)
> > +process_krb5_upcall(struct clnt_upcall_info *info)
> >  {
> > +       struct clnt_info        *clp = info->clp;
> > +       uid_t                   uid = info->uid;
> > +       int                     fd = info->fd;
> > +       char                    *srchost = info->srchost;
> > +       char                    *tgtname = info->target;
> > +       char                    *service = info->service;
> >         CLIENT                  *rpc_clnt = NULL;
> >         AUTH                    *auth = NULL;
> >         struct authgss_private_data pd;
> > @@ -624,11 +674,13 @@ process_krb5_upcall(struct clnt_info *clp, uid_t uid, int fd, char *srchost,
> >         gss_name_t              gacceptor = GSS_C_NO_NAME;
> >         gss_OID                 mech;
> >         gss_buffer_desc         acceptor  = {0};
> > +       struct cleanup_args cleanup_args = {&min_stat, &acceptor, &token, &pd, &auth, &rpc_clnt};
> >
> >         token.length = 0;
> >         token.value = NULL;
> >         memset(&pd, 0, sizeof(struct authgss_private_data));
> >
> > +       pthread_cleanup_push(cleanup_handler, &cleanup_args);
> >         /*
> >          * If "service" is specified, then the kernel is indicating that
> >          * we must use machine credentials for this request.  (Regardless
> > @@ -650,6 +702,7 @@ process_krb5_upcall(struct clnt_info *clp, uid_t uid, int fd, char *srchost,
> >          * used for this case is not important.
> >          *
> >          */
> > +       pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
> >         if (uid != 0 || (uid == 0 && root_uses_machine_creds == 0 &&
> >                                 service == NULL)) {
> >
> > @@ -670,15 +723,21 @@ process_krb5_upcall(struct clnt_info *clp, uid_t uid, int fd, char *srchost,
> >                         goto out_return_error;
> >                 }
> >         }
> > +       pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
> > +       pthread_testcancel();
> >
> > +       pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
> >         if (!authgss_get_private_data(auth, &pd)) {
> >                 printerr(1, "WARNING: Failed to obtain authentication "
> >                             "data for user with uid %d for server %s\n",
> >                          uid, clp->servername);
> >                 goto out_return_error;
> >         }
> > +       pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
> > +       pthread_testcancel();
> >
> >         /* Grab the context lifetime and acceptor name out of the ctx. */
> > +       pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
> >         maj_stat = gss_inquire_context(&min_stat, pd.pd_ctx, NULL, &gacceptor,
> >                                        &lifetime_rec, &mech, NULL, NULL, NULL);
> >
> > @@ -690,37 +749,35 @@ process_krb5_upcall(struct clnt_info *clp, uid_t uid, int fd, char *srchost,
> >                 get_hostbased_client_buffer(gacceptor, mech, &acceptor);
> >                 gss_release_name(&min_stat, &gacceptor);
> >         }
> > +       pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
> > +       pthread_testcancel();
> >
> >         /*
> >          * The serialization can mean turning pd.pd_ctx into a lucid context. If
> >          * that happens then the pd.pd_ctx will be unusable, so we must never
> >          * try to use it after this point.
> >          */
> > +       pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
> >         if (serialize_context_for_kernel(&pd.pd_ctx, &token, &krb5oid, NULL)) {
> >                 printerr(1, "WARNING: Failed to serialize krb5 context for "
> >                             "user with uid %d for server %s\n",
> >                          uid, clp->servername);
> >                 goto out_return_error;
> >         }
> > +       pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
> > +       pthread_testcancel();
> >
> >         do_downcall(fd, uid, &pd, &token, lifetime_rec, &acceptor);
> >
> >  out:
> > -       gss_release_buffer(&min_stat, &acceptor);
> > -       if (token.value)
> > -               free(token.value);
> > -#ifdef HAVE_AUTHGSS_FREE_PRIVATE_DATA
> > -       if (pd.pd_ctx_hndl.length != 0 || pd.pd_ctx != 0)
> > -               authgss_free_private_data(&pd);
> > -#endif
> > -       if (auth)
> > -               AUTH_DESTROY(auth);
> > -       if (rpc_clnt)
> > -               clnt_destroy(rpc_clnt);
> > +       pthread_cleanup_pop(1);
> >
> >         return;
> >
> >  out_return_error:
> > +       pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
> > +       pthread_testcancel();
> > +
> >         do_error_downcall(fd, uid, downcall_err);
> >         goto out;
> >  }
> > @@ -786,36 +843,69 @@ void free_upcall_info(struct clnt_upcall_info *info)
> >  }
> >
> >  static void
> > -gssd_work_thread_fn(struct clnt_upcall_info *info)
> > +cleanup_clnt_upcall_info(void *arg)
> >  {
> > -       process_krb5_upcall(info->clp, info->uid, info->fd, info->srchost, info->target, info->service);
> > +       struct clnt_upcall_info *info = (struct clnt_upcall_info *)arg;
> > +
> >         free_upcall_info(info);
> >  }
> >
> > +static void
> > +gssd_work_thread_fn(struct clnt_upcall_info *info)
> > +{
> > +       pthread_cleanup_push(cleanup_clnt_upcall_info, info);
> > +       process_krb5_upcall(info);
> > +       pthread_cleanup_pop(1);
> > +}
> > +
> > +static struct upcall_thread_info *
> > +alloc_upcall_thread_info(void)
> > +{
> > +       struct upcall_thread_info *info;
> > +
> > +       info = malloc(sizeof(struct upcall_thread_info));
> > +       if (info == NULL)
> > +               return NULL;
> > +       memset(info, 0, sizeof(*info));
> > +       return info;
> > +}
> > +
> >  static int
> > -start_upcall_thread(void (*func)(struct clnt_upcall_info *), void *info)
> > +start_upcall_thread(void (*func)(struct clnt_upcall_info *), struct clnt_upcall_info *info)
> >  {
> >         pthread_attr_t attr;
> >         pthread_t th;
> > +       struct upcall_thread_info *tinfo;
> >         int ret;
> >
> > +       tinfo = alloc_upcall_thread_info();
> > +       if (!tinfo)
> > +               return -ENOMEM;
> > +       tinfo->fd = info->fd;
> > +       tinfo->uid = info->uid;
> > +
> >         ret = pthread_attr_init(&attr);
> >         if (ret != 0) {
> >                 printerr(0, "ERROR: failed to init pthread attr: ret %d: %s\n",
> >                          ret, strerror(errno));
> > -               return ret;
> > -       }
> > -       ret = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
> > -       if (ret != 0) {
> > -               printerr(0, "ERROR: failed to create pthread attr: ret %d: "
> > -                        "%s\n", ret, strerror(errno));
> > +               free(tinfo);
> >                 return ret;
> >         }
> >
> >         ret = pthread_create(&th, &attr, (void *)func, (void *)info);
> > -       if (ret != 0)
> > +       if (ret != 0) {
> >                 printerr(0, "ERROR: pthread_create failed: ret %d: %s\n",
> >                          ret, strerror(errno));
> > +               free(tinfo);
> > +               return ret;
> > +       }
> > +       tinfo->tid = th;
> > +       pthread_mutex_lock(&active_thread_list_lock);
> > +       clock_gettime(CLOCK_MONOTONIC, &tinfo->timeout);
> > +       tinfo->timeout.tv_sec += upcall_timeout;
> > +       TAILQ_INSERT_TAIL(&active_thread_list, tinfo, list);
> > +       pthread_mutex_unlock(&active_thread_list_lock);
> > +
> >         return ret;
> >  }
> >
> > --
> > 2.30.2
> >
