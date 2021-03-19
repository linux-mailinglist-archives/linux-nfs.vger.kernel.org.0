Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C31341F2B
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Mar 2021 15:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhCSOPi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Mar 2021 10:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhCSOPJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Mar 2021 10:15:09 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D857DC06174A
        for <linux-nfs@vger.kernel.org>; Fri, 19 Mar 2021 07:15:08 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1B634248F; Fri, 19 Mar 2021 10:15:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1B634248F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1616163308;
        bh=a3lpCNdq9cMpXyY+xhKxULXjIFopgnxPwVoWFCV9mSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kSiBIJhhG70lqhSgyKUrh4BpSEFucibnbgK6DNgE48bAaXzSU+EnJv8qT5RnsYmhi
         W9YFtdDjnlUlwvrb9G1/uBW0obHv/oItmDbUsDOJLmEpp/QDHVA18p5q7aanAtCdz+
         P/OTtrbFG5CnACZS0OXYnFPU1EH+Xh6QcMoyCvh8=
Date:   Fri, 19 Mar 2021 10:15:08 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] mountd/exportd: only log confirmed clients, and poll for
 updates
Message-ID: <20210319141508.GB31533@fieldses.org>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
 <874khui7hr.fsf@notabene.neil.brown.name>
 <20210302032733.GC16303@fieldses.org>
 <87y2ejerwn.fsf@notabene.neil.brown.name>
 <87v99neruh.fsf@notabene.neil.brown.name>
 <87sg4rerta.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sg4rerta.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Mar 19, 2021 at 02:38:25PM +1100, NeilBrown wrote:
> 
> It is possible (and common with the Linux NFS client) for the nfs server
> to receive multiple SET_CLIENT_ID or EXCHANGE_ID requests when starting
> a connection.  This results in some clients appearing in
>  /proc/fs/nfsd/clients
> which never get confirmed.  mountd currently logs these, but they aren't
> really helpful.
> 
> If the kernel supports the reporting of the confirmation status of
> clients, we can suppress the message until a client is confirmed.
> 
> With this patch we:
>  - record if the client is confirmed, assuming it is if the status is
>     not reported
>  - don't log unconfirmed clients
>  - check all unconfirmed clients each time any event is processed,
>  - if there are unconfirmed clients, we request a wakeup after a
>    exponentially decreasing time, and check again

increasing not decreasing, I think.

Is there any better way to let userland know when the contents of a
virtual file have changed?

Looks at inofity man page....  There's an "IN_MODIFY" event.  I think we
could add an fsnotify_inode(inode, FS_MODIFY); at the end of
move_to_confirmed().  (I'm not sure what's the best way to get the inode
of the info file there.)

Would that help?

--b.

> This requires updating the two event loops to allow a timeout to be
> specified.
> 
> When there is no other activity, but there are unconfirmed clients,
> timeout for repeat checks are after 1, 2, 4 ... 512 seconds.
> If any wait is interrupted, the next wait time is still chosen, so we
> might advance quickly through the list.  But if there is lots of
> activity, we don't really need the timeout.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  support/export/cache.c     |  7 ++-
>  support/export/export.h    |  2 +-
>  support/export/v4clients.c | 92 ++++++++++++++++++++++++++++++--------
>  utils/mountd/svc_run.c     |  7 ++-
>  4 files changed, 85 insertions(+), 23 deletions(-)
> 
> diff --git a/support/export/cache.c b/support/export/cache.c
> index 3e4f53c0a32e..687b3aef27a1 100644
> --- a/support/export/cache.c
> +++ b/support/export/cache.c
> @@ -1524,6 +1524,7 @@ void cache_process_loop(void)
>  {
>  	fd_set	readfds;
>  	int	selret;
> +	struct timeval tv = { 60*60, 0 };
>  
>  	FD_ZERO(&readfds);
>  
> @@ -1533,8 +1534,10 @@ void cache_process_loop(void)
>  		v4clients_set_fds(&readfds);
>  
>  		selret = select(FD_SETSIZE, &readfds,
> -				(void *) 0, (void *) 0, (struct timeval *) 0);
> +				(void *) 0, (void *) 0, &tv);
>  
> +		tv.tv_sec = 60*60;
> +		tv.tv_usec = 0;
>  
>  		switch (selret) {
>  		case -1:
> @@ -1546,7 +1549,7 @@ void cache_process_loop(void)
>  
>  		default:
>  			cache_process_req(&readfds);
> -			v4clients_process(&readfds);
> +			v4clients_process(&readfds, &tv);
>  		}
>  	}
>  }
> diff --git a/support/export/export.h b/support/export/export.h
> index 8d5a0d3004ef..71d3ed39bd28 100644
> --- a/support/export/export.h
> +++ b/support/export/export.h
> @@ -24,7 +24,7 @@ void		cache_process_loop(void);
>  
>  void		v4clients_init(void);
>  void		v4clients_set_fds(fd_set *fdset);
> -int		v4clients_process(fd_set *fdset);
> +int		v4clients_process(fd_set *fdset, struct timeval *tv);
>  
>  struct nfs_fh_len *
>  		cache_get_filehandle(nfs_export *exp, int len, char *p);
> diff --git a/support/export/v4clients.c b/support/export/v4clients.c
> index 056ddc9b065d..04cec3136876 100644
> --- a/support/export/v4clients.c
> +++ b/support/export/v4clients.c
> @@ -48,12 +48,15 @@ void v4clients_set_fds(fd_set *fdset)
>  }
>  
>  static void *tree_root;
> +static int have_unconfirmed;
> +static time_t unconfirmed_wait = 1;
>  
>  struct ent {
>  	unsigned long num;
>  	char *clientid;
>  	char *addr;
>  	int vers;
> +	int unconfirmed;
>  };
>  
>  static int ent_cmp(const void *av, const void *bv)
> @@ -89,15 +92,13 @@ static char *dup_line(char *line)
>  	return ret;
>  }
>  
> -static void add_id(int id)
> +static void read_info(struct ent *key)
>  {
>  	char buf[2048];
> -	struct ent **ent;
> -	struct ent *key;
>  	char *path;
>  	FILE *f;
>  
> -	if (asprintf(&path, "/proc/fs/nfsd/clients/%d/info", id) < 0)
> +	if (asprintf(&path, "/proc/fs/nfsd/clients/%lu/info", key->num) < 0)
>  		return;
>  
>  	f = fopen(path, "r");
> @@ -105,32 +106,56 @@ static void add_id(int id)
>  		free(path);
>  		return;
>  	}
> -	key = calloc(1, sizeof(*key));
> -	if (!key) {
> -		fclose(f);
> -		free(path);
> -		return;
> -	}
> -	key->num = id;
>  	while (fgets(buf, sizeof(buf), f)) {
> -		if (strncmp(buf, "clientid: ", 10) == 0)
> +		if (strncmp(buf, "clientid: ", 10) == 0) {
> +			free(key->clientid);
>  			key->clientid = dup_line(buf+10);
> -		if (strncmp(buf, "address: ", 9) == 0)
> +		}
> +		if (strncmp(buf, "address: ", 9) == 0) {
> +			free(key->addr);
>  			key->addr = dup_line(buf+9);
> +		}
>  		if (strncmp(buf, "minor version: ", 15) == 0)
>  			key->vers = atoi(buf+15);
> +		if (strncmp(buf, "status: ", 8) == 0 &&
> +		    strstr(buf, " unconfirmed") != NULL) {
> +			key->unconfirmed = 1;
> +			have_unconfirmed = 1;
> +		}
> +		if (strncmp(buf, "status: ", 8) == 0 &&
> +		    strstr(buf, " confirmed") != NULL)
> +			key->unconfirmed = 0;
>  	}
>  	fclose(f);
>  	free(path);
>  
> -	xlog(L_NOTICE, "v4.%d client attached: %s from %s",
> -	     key->vers, key->clientid, key->addr);
> +	if (!key->unconfirmed)
> +		xlog(L_NOTICE, "v4.%d client attached: %s from %s",
> +		     key->vers, key->clientid ?: "-none-",
> +		     key->addr ?: "-none-");
> +}
> +
> +static void add_id(int id)
> +{
> +	struct ent **ent;
> +	struct ent *key;
> +
> +	key = calloc(1, sizeof(*key));
> +	if (!key) {
> +		return;
> +	}
> +	key->num = id;
>  
>  	ent = tsearch(key, &tree_root, ent_cmp);
>  
>  	if (!ent || *ent != key)
>  		/* Already existed, or insertion failed */
>  		free_ent(key);
> +	else {
> +		read_info(key);
> +		if (key->unconfirmed)
> +			unconfirmed_wait = 1;
> +	}
>  }
>  
>  static void del_id(int id)
> @@ -143,18 +168,43 @@ static void del_id(int id)
>  		return;
>  	ent = *e;
>  	tdelete(ent, &tree_root, ent_cmp);
> -	xlog(L_NOTICE, "v4.%d client detached: %s from %s",
> -	     ent->vers, ent->clientid, ent->addr);
> +	if (!ent->unconfirmed)
> +		xlog(L_NOTICE, "v4.%d client detached: %s from %s",
> +		     ent->vers, ent->clientid, ent->addr);
>  	free_ent(ent);
>  }
>  
> -int v4clients_process(fd_set *fdset)
> +static void check_one(const void *ventp, VISIT which, int depth)
> +{
> +	struct ent * const *ep = ventp;
> +	struct ent *ent;
> +
> +	if (depth >= 0 && /* Silence "unused paramter" warning */
> +	    which != preorder && which != leaf)
> +		return;
> +
> +	ent = *ep;
> +	if (ent->unconfirmed)
> +		read_info(ent);
> +}
> +
> +static void check_unconfirmed(void)
> +{
> +	if (!have_unconfirmed)
> +		return;
> +	have_unconfirmed = 0;
> +	twalk(tree_root, check_one);
> +}
> +
> +int v4clients_process(fd_set *fdset, struct timeval *tv)
>  {
>  	char buf[4096] __attribute__((aligned(__alignof__(struct inotify_event))));
>  	const struct inotify_event *ev;
>  	ssize_t len;
>  	char *ptr;
>  
> +	check_unconfirmed();
> +
>  	if (clients_fd < 0 ||
>  	    !FD_ISSET(clients_fd, fdset))
>  		return 0;
> @@ -174,6 +224,12 @@ int v4clients_process(fd_set *fdset)
>  				del_id(id);
>  		}
>  	}
> +	if (have_unconfirmed && tv->tv_sec > unconfirmed_wait) {
> +		tv->tv_sec = unconfirmed_wait;
> +		tv->tv_usec = 0;
> +		if (unconfirmed_wait < 300)
> +			unconfirmed_wait <<= 1;
> +	}
>  	return 1;
>  }
>  
> diff --git a/utils/mountd/svc_run.c b/utils/mountd/svc_run.c
> index 167b9757bde2..042bed8957b9 100644
> --- a/utils/mountd/svc_run.c
> +++ b/utils/mountd/svc_run.c
> @@ -95,6 +95,7 @@ my_svc_run(void)
>  {
>  	fd_set	readfds;
>  	int	selret;
> +	struct timeval tv = { 60*60, 0 };
>  
>  	for (;;) {
>  
> @@ -103,8 +104,10 @@ my_svc_run(void)
>  		v4clients_set_fds(&readfds);
>  
>  		selret = select(FD_SETSIZE, &readfds,
> -				(void *) 0, (void *) 0, (struct timeval *) 0);
> +				(void *) 0, (void *) 0, &tv);
>  
> +		tv.tv_sec = 60*60;
> +		tv.tv_usec = 0;
>  
>  		switch (selret) {
>  		case -1:
> @@ -116,7 +119,7 @@ my_svc_run(void)
>  
>  		default:
>  			selret -= cache_process_req(&readfds);
> -			selret -= v4clients_process(&readfds);
> +			selret -= v4clients_process(&readfds, &tv);
>  			if (selret)
>  				svc_getreqset(&readfds);
>  		}
> -- 
> 2.30.1
> 


