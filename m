Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A514C392CE3
	for <lists+linux-nfs@lfdr.de>; Thu, 27 May 2021 13:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbhE0Llx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 May 2021 07:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233044AbhE0Llw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 May 2021 07:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622115618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=plp7rwyKeMhQntmoIiAZ/iGHcSPEZejBiK9oVv00e0A=;
        b=JRDjSb2sXgZMkvjjnM4BQzAbX08W3U3MWcnlMqoxHO7bomux1ZsGrFgq0TF/IsIjmeqS2I
        cakmrMRJEK26OAV78QLVe8jvZsyal/AXEpS8+3mdyVATqzs923V9VZj7hUb1LNanWTPo6u
        nkydZM/zUd1DDIsycZZwa4zB+q0xtmE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-OfGQ7A4zPtezj3cAuzVBqw-1; Thu, 27 May 2021 07:40:17 -0400
X-MC-Unique: OfGQ7A4zPtezj3cAuzVBqw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9572E802575
        for <linux-nfs@vger.kernel.org>; Thu, 27 May 2021 11:40:16 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-114-18.rdu2.redhat.com [10.10.114.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FE6719D9B;
        Thu, 27 May 2021 11:40:16 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 2AFBB1A003D; Thu, 27 May 2021 07:40:15 -0400 (EDT)
Date:   Thu, 27 May 2021 07:40:15 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Steve Dickson <SteveD@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils RFC PATCH 2/2] gssd: add timeout for upcall threads
Message-ID: <YK+FH7T/ljFbuIsH@aion.usersys.redhat.com>
References: <20210525180033.200404-1-smayhew@redhat.com>
 <20210525180033.200404-3-smayhew@redhat.com>
 <490b45eb-0142-24de-e05f-79751891ddf9@RedHat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <490b45eb-0142-24de-e05f-79751891ddf9@RedHat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 26 May 2021, Steve Dickson wrote:

> Hey!
> 
> Again... a few very small teaks 
> 
> On 5/25/21 2:00 PM, Scott Mayhew wrote:
> > Add a global list of active upcalls and a watchdog thread that walks the
> > list, looking for threads running longer than timeout seconds.  By
> > default, the watchdog thread will cancel these threads and report an
> > error of -ETIMEDOUT to the kernel.  Passing the -C option or setting
> > cancel-timed-out-upcalls=0 in nfs.conf disables this behavior and
> > causes the watchdog thread to simply log an error message instead.  The
> > upcall timeout can be specified by passing the -U option or by setting
> > the upcall-timeout parameter in nfs.conf.
> > 
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >  nfs.conf               |   2 +
> >  utils/gssd/gssd.c      | 125 +++++++++++++++++++++++++++++++++++++++-
> >  utils/gssd/gssd.h      |  15 +++++
> >  utils/gssd/gssd.man    |  31 +++++++++-
> >  utils/gssd/gssd_proc.c | 127 ++++++++++++++++++++++++++++++++---------
> >  5 files changed, 270 insertions(+), 30 deletions(-)
> > 
> > diff --git a/nfs.conf b/nfs.conf
> > index 31994f61..7a987788 100644
> > --- a/nfs.conf
> > +++ b/nfs.conf
> > @@ -25,6 +25,8 @@
> >  # cred-cache-directory=
> >  # preferred-realm=
> >  # set-home=1
> > +# upcall-timeout=30
> > +# cancel-timed-out-upcalls=1
> >  #
> >  [lockd]
> >  # port=0
> > diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
> > index eb440470..54a1ea3f 100644
> > --- a/utils/gssd/gssd.c
> > +++ b/utils/gssd/gssd.c
> > @@ -95,9 +95,15 @@ static bool use_gssproxy = false;
> >  pthread_mutex_t clp_lock = PTHREAD_MUTEX_INITIALIZER;
> >  static bool signal_received = false;
> >  static struct event_base *evbase = NULL;
> > +pthread_mutex_t active_thread_list_lock = PTHREAD_MUTEX_INITIALIZER;
> > +
> > +int upcall_timeout = DEF_UPCALL_TIMEOUT;
> > +static bool cancel_timed_out_upcalls = true;
> >  
> >  TAILQ_HEAD(topdir_list_head, topdir) topdir_list;
> >  
> > +TAILQ_HEAD(active_thread_list_head, upcall_thread_info) active_thread_list;
> > +
> >  struct topdir {
> >  	TAILQ_ENTRY(topdir) list;
> >  	TAILQ_HEAD(clnt_list_head, clnt_info) clnt_list;
> > @@ -436,6 +442,100 @@ gssd_clnt_krb5_cb(int UNUSED(fd), short UNUSED(which), void *data)
> >  	handle_krb5_upcall(clp);
> >  }
> >  
> > +static int
> > +scan_active_thread_list(void)
> > +{
> > +	struct upcall_thread_info *info;
> > +	struct timespec now;
> > +	unsigned int sleeptime;
> > +	bool sleeptime_set = false;
> > +	int err;
> > +	void *tret, *saveprev;
> > +
> > +	sleeptime = upcall_timeout;
> > +	pthread_mutex_lock(&active_thread_list_lock);
> > +	clock_gettime(CLOCK_MONOTONIC, &now);
> > +	TAILQ_FOREACH(info, &active_thread_list, list) {
> > +		err = pthread_tryjoin_np(info->tid, &tret);
> > +		switch (err) {
> > +		case 0:
> > +			if (tret == PTHREAD_CANCELED)
> > +				printerr(3, "watchdog: thread id 0x%lx cancelled successfully\n",
> > +						info->tid);
> > +			saveprev = info->list.tqe_prev;
> > +			TAILQ_REMOVE(&active_thread_list, info, list);
> > +			free(info);
> > +			info = saveprev;
> > +			break;
> > +		case EBUSY:
> > +			if (now.tv_sec >= info->timeout.tv_sec) {
> > +				if (cancel_timed_out_upcalls && !info->cancelled) {
> > +					printerr(0, "watchdog: thread id 0x%lx timed out\n",
> > +							info->tid);
> > +					pthread_cancel(info->tid);
> > +					info->cancelled = true;
> > +					do_error_downcall(info->fd, info->uid, -ETIMEDOUT);
> > +				} else {
> > +					printerr(0, "watchdog: thread id 0x%lx running for %ld seconds\n",
> > +							info->tid,
> > +							now.tv_sec - info->timeout.tv_sec + upcall_timeout);
> If people are going to used the -C flag they are saying they want
> to ignore hung threads so I'm thinking with printerr(0) we would
> be filling up their logs about messages they don't care about.
> So I'm thinking we should change this to a printerr(1) 

Note that message could pop multiple times per thread even without the
-C flag because cancellation isn't immediate (a thread needs to hit a
cancellation point, which it won't actually do that until it comes back
from wherever it's hanging).  My thinking was leaving it with
printerr(0) would make it blatantly obvious when something was wrong and
needed to be investigated.  I have no issue with changing it to
printerr(1) though. 

Alternatively we could add another flag to struct upcall_thread_info to
ensure that message only gets logged once per thread.

> 
> > +				}
> > +			} else if (!sleeptime_set) {
> > +				sleeptime = info->timeout.tv_sec - now.tv_sec;
> > +				sleeptime_set = true;
> > +			}
> > +			break;
> > +		default:
> > +			printerr(0, "watchdog: attempt to join thread id 0x%lx returned %d (%s)!\n",
> > +					info->tid, err, strerror(err));
> > +			break;
> > +		}
> > +	}
> > +	pthread_mutex_unlock(&active_thread_list_lock);
> > +
> > +	return sleeptime;
> > +}
> > +
> > +static void *
> > +watchdog_thread_fn(void *UNUSED(arg))
> > +{
> > +	unsigned int sleeptime;
> > +
> > +	for (;;) {
> > +		sleeptime = scan_active_thread_list();
> > +		printerr(4, "watchdog: sleeping %u secs\n", sleeptime);
> > +		sleep(sleeptime);
> > +	}
> > +	return (void *)0;
> > +}
> > +
> > +static int
> > +start_watchdog_thread(void)
> > +{
> > +	pthread_attr_t attr;
> > +	pthread_t th;
> > +	int ret;
> > +
> > +	ret = pthread_attr_init(&attr);
> > +	if (ret != 0) {
> > +		printerr(0, "ERROR: failed to init pthread attr: ret %d: %s\n",
> > +			 ret, strerror(errno));
> > +		return ret;
> > +	}
> > +	ret = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
> > +	if (ret != 0) {
> > +		printerr(0, "ERROR: failed to create pthread attr: ret %d: %s\n",
> > +			 ret, strerror(errno));
> > +		return ret;
> > +	}
> > +	ret = pthread_create(&th, &attr, watchdog_thread_fn, NULL);
> > +	if (ret != 0) {
> > +		printerr(0, "ERROR: pthread_create failed: ret %d: %s\n",
> > +			 ret, strerror(errno));
> > +	}
> > +	return ret;
> > +}
> > +
> >  static struct clnt_info *
> >  gssd_get_clnt(struct topdir *tdi, const char *name)
> >  {
> > @@ -825,7 +925,7 @@ sig_die(int signal)
> >  static void
> >  usage(char *progname)
> >  {
> > -	fprintf(stderr, "usage: %s [-f] [-l] [-M] [-n] [-v] [-r] [-p pipefsdir] [-k keytab] [-d ccachedir] [-t timeout] [-R preferred realm] [-D] [-H]\n",
> > +	fprintf(stderr, "usage: %s [-f] [-l] [-M] [-n] [-v] [-r] [-p pipefsdir] [-k keytab] [-d ccachedir] [-t timeout] [-R preferred realm] [-D] [-H] [-U upcall timeout] [-C]\n",
> >  		progname);
> >  	exit(1);
> >  }
> > @@ -846,6 +946,9 @@ read_gss_conf(void)
> >  #endif
> >  	context_timeout = conf_get_num("gssd", "context-timeout", context_timeout);
> >  	rpc_timeout = conf_get_num("gssd", "rpc-timeout", rpc_timeout);
> > +	upcall_timeout = conf_get_num("gssd", "upcall-timeout", upcall_timeout);
> > +	cancel_timed_out_upcalls = conf_get_bool("gssd", "cancel-timed-out-upcalls",
> > +						cancel_timed_out_upcalls);
> >  	s = conf_get_str("gssd", "pipefs-directory");
> >  	if (!s)
> >  		s = conf_get_str("general", "pipefs-directory");
> > @@ -887,7 +990,7 @@ main(int argc, char *argv[])
> >  	verbosity = conf_get_num("gssd", "verbosity", verbosity);
> >  	rpc_verbosity = conf_get_num("gssd", "rpc-verbosity", rpc_verbosity);
> >  
> > -	while ((opt = getopt(argc, argv, "HDfvrlmnMp:k:d:t:T:R:")) != -1) {
> > +	while ((opt = getopt(argc, argv, "HDfvrlmnMp:k:d:t:T:R:U:C")) != -1) {
> >  		switch (opt) {
> >  			case 'f':
> >  				fg = 1;
> > @@ -938,6 +1041,11 @@ main(int argc, char *argv[])
> >  			case 'H':
> >  				set_home = false;
> >  				break;
> > +			case 'U':
> > +				upcall_timeout = atoi(optarg);
> > +				break;
> > +			case 'C':
> > +				cancel_timed_out_upcalls = false;
> >  			default:
> >  				usage(argv[0]);
> >  				break;
> > @@ -1010,6 +1118,11 @@ main(int argc, char *argv[])
> >  	else
> >  		progname = argv[0];
> >  
> > +	if (upcall_timeout > MAX_UPCALL_TIMEOUT)
> > +		upcall_timeout = MAX_UPCALL_TIMEOUT;
> > +	else if (upcall_timeout < MIN_UPCALL_TIMEOUT)
> > +		upcall_timeout = MIN_UPCALL_TIMEOUT;
> > +
> >  	initerr(progname, verbosity, fg);
> >  #ifdef HAVE_LIBTIRPC_SET_DEBUG
> >  	/*
> > @@ -1068,6 +1181,14 @@ main(int argc, char *argv[])
> >  	}
> >  	event_add(inotify_ev, NULL);
> >  
> > +	TAILQ_INIT(&active_thread_list);
> > +
> > +	rc = start_watchdog_thread();
> > +	if (rc != 0) {
> > +		printerr(0, "ERROR: failed to start watchdog thread: %d\n", rc);
> > +		exit(EXIT_FAILURE);
> > +	}
> > +
> >  	TAILQ_INIT(&topdir_list);
> >  	gssd_scan();
> >  	daemon_ready();
> > diff --git a/utils/gssd/gssd.h b/utils/gssd/gssd.h
> > index 6d53647e..ad0d1d93 100644
> > --- a/utils/gssd/gssd.h
> > +++ b/utils/gssd/gssd.h
> > @@ -50,6 +50,11 @@
> >  #define GSSD_DEFAULT_KEYTAB_FILE		"/etc/krb5.keytab"
> >  #define GSSD_SERVICE_NAME			"nfs"
> >  #define RPC_CHAN_BUF_SIZE			32768
> > +
> I think we should add a "/* seconds */" 
> so you don't have dig in the code 
> to see what interval is 
> > +#define MIN_UPCALL_TIMEOUT			5
> > +#define DEF_UPCALL_TIMEOUT			30
> > +#define MAX_UPCALL_TIMEOUT			600
> > +
> >  /*
> >   * The gss mechanisms that we can handle
> >   */
> > @@ -91,10 +96,20 @@ struct clnt_upcall_info {
> >  	char			*service;
> >  };
> >  
> > +struct upcall_thread_info {
> > +	TAILQ_ENTRY(upcall_thread_info) list;
> > +	pthread_t		tid;
> > +	struct timespec		timeout;
> > +	uid_t			uid;
> > +	int			fd;
> > +	bool			cancelled;
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
> > index 9ae6def9..20fea729 100644
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
> > +seconds will be cancelled and an error of -ETIMEDOUT will be reported
> > +to the kernel.  The default
> > +.I timeout
> > +is 30 seconds.  The minimum is 5 seconds.  The maximum is 600 seconds.
> > +.TP
> > +.B -C
> > +Instead of cancelling upcall threads that have timed out, cause an error
> > +message to be logged to the syslog (no error will be reported to the kernel).
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
> > +.B false
> > +is equivalent to providing the
> > +.B -C
> > +flag.
> > +.TP
> >  .B set-home
> >  Setting to
> >  .B false
> > diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
> > index ba508b30..ac7b1d1c 100644
> > --- a/utils/gssd/gssd_proc.c
> > +++ b/utils/gssd/gssd_proc.c
> > @@ -81,11 +81,23 @@
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
> > +struct cleanup_args  {
> > +	OM_uint32 	*min_stat;
> > +	gss_buffer_t	acceptor;
> > +	gss_buffer_t	token;
> > +	struct authgss_private_data *pd;
> > +	AUTH		**auth;
> > +	CLIENT		**rpc_clnt;
> > +};
> > +
> >  /*
> >   * Parse the supported encryption type information
> >   */
> > @@ -184,7 +196,7 @@ out_err:
> >  	return;
> >  }
> >  
> > -static int
> > +int
> >  do_error_downcall(int k5_fd, uid_t uid, int err)
> >  {
> >  	char	buf[1024];
> > @@ -607,14 +619,37 @@ out:
> >  	return auth;
> >  }
> >  
> > +static void
> > +cleanup_handler(void *arg)
> > +{
> > +	struct cleanup_args *args = (struct cleanup_args *)arg;
> > +
> > +	gss_release_buffer(args->min_stat, args->acceptor);
> > +	if (args->token->value)
> > +		free(args->token->value);
> > +#ifdef HAVE_AUTHGSS_FREE_PRIVATE_DATA
> > +	if (args->pd->pd_ctx_hndl.length != 0 || args->pd->pd_ctx != 0)
> > +		authgss_free_private_data(args->pd);
> > +#endif
> > +	if (*args->auth)
> > +		AUTH_DESTROY(*args->auth);
> > +	if (*args->rpc_clnt)
> > +		clnt_destroy(*args->rpc_clnt);
> > +}
> > +
> >  /*
> >   * this code uses the userland rpcsec gss library to create a krb5
> >   * context on behalf of the kernel
> >   */
> >  static void
> > -process_krb5_upcall(struct clnt_info *clp, uid_t uid, int fd, char *srchost,
> > -		    char *tgtname, char *service)
> > +process_krb5_upcall(struct clnt_upcall_info *info)
> >  {
> > +	struct clnt_info	*clp = info->clp;
> > +	uid_t			uid = info->uid;
> > +	int			fd = info->fd;
> > +	char			*srchost = info->srchost;
> > +	char			*tgtname = info->target;
> > +	char			*service = info->service;
> >  	CLIENT			*rpc_clnt = NULL;
> >  	AUTH			*auth = NULL;
> >  	struct authgss_private_data pd;
> > @@ -624,11 +659,13 @@ process_krb5_upcall(struct clnt_info *clp, uid_t uid, int fd, char *srchost,
> >  	gss_name_t		gacceptor = GSS_C_NO_NAME;
> >  	gss_OID			mech;
> >  	gss_buffer_desc		acceptor  = {0};
> > +	struct cleanup_args cleanup_args = {&min_stat, &acceptor, &token, &pd, &auth, &rpc_clnt};
> >  
> >  	token.length = 0;
> >  	token.value = NULL;
> >  	memset(&pd, 0, sizeof(struct authgss_private_data));
> >  
> > +	pthread_cleanup_push(cleanup_handler, &cleanup_args);
> >  	/*
> >  	 * If "service" is specified, then the kernel is indicating that
> >  	 * we must use machine credentials for this request.  (Regardless
> > @@ -650,6 +687,7 @@ process_krb5_upcall(struct clnt_info *clp, uid_t uid, int fd, char *srchost,
> >  	 * used for this case is not important.
> >  	 *
> >  	 */
> > +	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
> >  	if (uid != 0 || (uid == 0 && root_uses_machine_creds == 0 &&
> >  				service == NULL)) {
> >  
> > @@ -670,15 +708,21 @@ process_krb5_upcall(struct clnt_info *clp, uid_t uid, int fd, char *srchost,
> >  			goto out_return_error;
> >  		}
> >  	}
> > +	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
> > +	pthread_testcancel();
> >  
> > +	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
> >  	if (!authgss_get_private_data(auth, &pd)) {
> >  		printerr(1, "WARNING: Failed to obtain authentication "
> >  			    "data for user with uid %d for server %s\n",
> >  			 uid, clp->servername);
> >  		goto out_return_error;
> >  	}
> > +	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
> > +	pthread_testcancel();
> >  
> >  	/* Grab the context lifetime and acceptor name out of the ctx. */
> > +	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
> >  	maj_stat = gss_inquire_context(&min_stat, pd.pd_ctx, NULL, &gacceptor,
> >  				       &lifetime_rec, &mech, NULL, NULL, NULL);
> >  
> > @@ -690,37 +734,35 @@ process_krb5_upcall(struct clnt_info *clp, uid_t uid, int fd, char *srchost,
> >  		get_hostbased_client_buffer(gacceptor, mech, &acceptor);
> >  		gss_release_name(&min_stat, &gacceptor);
> >  	}
> > +	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
> > +	pthread_testcancel();
> >  
> >  	/*
> >  	 * The serialization can mean turning pd.pd_ctx into a lucid context. If
> >  	 * that happens then the pd.pd_ctx will be unusable, so we must never
> >  	 * try to use it after this point.
> >  	 */
> > +	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
> >  	if (serialize_context_for_kernel(&pd.pd_ctx, &token, &krb5oid, NULL)) {
> >  		printerr(1, "WARNING: Failed to serialize krb5 context for "
> >  			    "user with uid %d for server %s\n",
> >  			 uid, clp->servername);
> >  		goto out_return_error;
> >  	}
> > +	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
> > +	pthread_testcancel();
> >  
> >  	do_downcall(fd, uid, &pd, &token, lifetime_rec, &acceptor);
> >  
> >  out:
> > -	gss_release_buffer(&min_stat, &acceptor);
> > -	if (token.value)
> > -		free(token.value);
> > -#ifdef HAVE_AUTHGSS_FREE_PRIVATE_DATA
> > -	if (pd.pd_ctx_hndl.length != 0 || pd.pd_ctx != 0)
> > -		authgss_free_private_data(&pd);
> > -#endif
> > -	if (auth)
> > -		AUTH_DESTROY(auth);
> > -	if (rpc_clnt)
> > -		clnt_destroy(rpc_clnt);
> > +	pthread_cleanup_pop(1);
> >  
> >  	return;
> >  
> >  out_return_error:
> > +	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
> > +	pthread_testcancel();
> > +
> >  	do_error_downcall(fd, uid, downcall_err);
> >  	goto out;
> >  }
> > @@ -786,38 +828,71 @@ void free_upcall_info(struct clnt_upcall_info *info)
> >  }
> >  
> >  static void
> > -gssd_work_thread_fn(struct clnt_upcall_info *info)
> > +cleanup_clnt_upcall_info(void *arg)
> >  {
> > -	process_krb5_upcall(info->clp, info->uid, info->fd, info->srchost, info->target, info->service);
> > +	struct clnt_upcall_info *info = (struct clnt_upcall_info *)arg;
> > +
> >  	free_upcall_info(info);
> >  }
> >  
> > +static void
> > +gssd_work_thread_fn(struct clnt_upcall_info *info)
> > +{
> > +	pthread_cleanup_push(cleanup_clnt_upcall_info, info);
> > +	process_krb5_upcall(info);
> > +	pthread_cleanup_pop(1);
> > +}
> > +
> > +static struct upcall_thread_info *
> > +alloc_upcall_thread_info(void)
> > +{
> > +	struct upcall_thread_info *info;
> > +
> > +	info = malloc(sizeof(struct upcall_thread_info));
> > +	if (info == NULL)
> > +		return NULL;
> > +	memset(info, 0, sizeof(*info));
> > +	return info;
> > +}
> > +
> >  static int
> > -start_upcall_thread(void (*func)(struct clnt_upcall_info *), void *info)
> > +start_upcall_thread(void (*func)(struct clnt_upcall_info *), struct clnt_upcall_info *info)
> >  {
> >  	pthread_attr_t attr;
> >  	pthread_t th;
> > +	struct upcall_thread_info *tinfo;
> >  	int ret;
> >  
> > +	tinfo = alloc_upcall_thread_info();
> > +	if (!tinfo)
> > +		return -ENOMEM;
> > +	tinfo->fd = info->fd;
> > +	tinfo->uid = info->uid;
> > +	tinfo->cancelled = false;
> > +
> >  	ret = pthread_attr_init(&attr);
> >  	if (ret != 0) {
> >  		printerr(0, "ERROR: failed to init pthread attr: ret %d: %s\n",
> >  			 ret, strerror(errno));
> > -		return ret;
> > -	}
> > -	ret = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
> > -	if (ret != 0) {
> > -		printerr(0, "ERROR: failed to create pthread attr: ret %d: "
> > -			 "%s\n", ret, strerror(errno));
> > +		free(tinfo);
> >  		return ret;
> >  	}
> >  
> >  	ret = pthread_create(&th, &attr, (void *)func, (void *)info);
> > -	if (ret != 0)
> > +	if (ret != 0) {
> >  		printerr(0, "ERROR: pthread_create failed: ret %d: %s\n",
> >  			 ret, strerror(errno));
> > -	else
> > -		printerr(0, "created thread id 0x%lx\n", th);
> > +		free(tinfo);
> > +		return ret;
> > +	}
> > +	printerr(1, "created thread id 0x%lx\n", th);
> This will be removed... 
> > +	tinfo->tid = th;
> > +	pthread_mutex_lock(&active_thread_list_lock);
> > +	clock_gettime(CLOCK_MONOTONIC, &tinfo->timeout);
> > +	tinfo->timeout.tv_sec += upcall_timeout;
> > +	TAILQ_INSERT_TAIL(&active_thread_list, tinfo, list);
> > +	pthread_mutex_unlock(&active_thread_list_lock);
> > +
> >  	return ret;
> >  }
> >  
> > 
> 
> Overall I think the code is very well written with
> one exception... The lack of comments. I think it
> would be very useful to let the reader know what
> you are doing and why.... But by no means is 
> that a show stopper. Nice work!

I can go back and add some comments.

-Scott
> 
> I'm still doing more testing and nothing 
> is breaking... So it is looking pretty good!
> 
> steved.
> 

