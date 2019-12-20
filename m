Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 034661273A6
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2019 03:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfLTC5I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Dec 2019 21:57:08 -0500
Received: from fieldses.org ([173.255.197.46]:38956 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfLTC5I (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Dec 2019 21:57:08 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id BCC801BE3; Thu, 19 Dec 2019 21:57:07 -0500 (EST)
Date:   Thu, 19 Dec 2019 21:57:07 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org
Subject: Re: [PATCH v2 10/12] nfsd: use boottime for lease expiry alculation
Message-ID: <20191220025707.GH12026@fieldses.org>
References: <20191213141046.1770441-1-arnd@arndb.de>
 <20191213141046.1770441-11-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213141046.1770441-11-arnd@arndb.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 13, 2019 at 03:10:44PM +0100, Arnd Bergmann wrote:
> @@ -5212,8 +5211,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>  	struct nfs4_ol_stateid *stp;
>  	struct nfsd4_blocked_lock *nbl;
>  	struct list_head *pos, *next, reaplist;
> -	time_t cutoff = get_seconds() - nn->nfsd4_lease;
> -	time_t t, new_timeo = nn->nfsd4_lease;
> +	time64_t cutoff = ktime_get_boottime_seconds() - nn->nfsd4_lease;

For some reason the version I was testing still had this as
get_seconds(), which was what was causing test failures.  I'm not quite
sure what happened--I may have just typo'd something while fixing up a
conflict.

--b.

> +	time64_t t, new_timeo = nn->nfsd4_lease;
>  
>  	dprintk("NFSD: laundromat service - starting\n");
>  
> @@ -5227,7 +5226,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>  	spin_lock(&nn->client_lock);
>  	list_for_each_safe(pos, next, &nn->client_lru) {
>  		clp = list_entry(pos, struct nfs4_client, cl_lru);
> -		if (time_after((unsigned long)clp->cl_time, (unsigned long)cutoff)) {
> +		if (clp->cl_time > cutoff) {
>  			t = clp->cl_time - cutoff;
>  			new_timeo = min(new_timeo, t);
>  			break;
> @@ -5250,7 +5249,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>  	spin_lock(&state_lock);
>  	list_for_each_safe(pos, next, &nn->del_recall_lru) {
>  		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> -		if (time_after((unsigned long)dp->dl_time, (unsigned long)cutoff)) {
> +		if (dp->dl_time > cutoff) {
>  			t = dp->dl_time - cutoff;
>  			new_timeo = min(new_timeo, t);
>  			break;
> @@ -5270,8 +5269,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>  	while (!list_empty(&nn->close_lru)) {
>  		oo = list_first_entry(&nn->close_lru, struct nfs4_openowner,
>  					oo_close_lru);
> -		if (time_after((unsigned long)oo->oo_time,
> -			       (unsigned long)cutoff)) {
> +		if (oo->oo_time > cutoff) {
>  			t = oo->oo_time - cutoff;
>  			new_timeo = min(new_timeo, t);
>  			break;
> @@ -5301,8 +5299,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>  	while (!list_empty(&nn->blocked_locks_lru)) {
>  		nbl = list_first_entry(&nn->blocked_locks_lru,
>  					struct nfsd4_blocked_lock, nbl_lru);
> -		if (time_after((unsigned long)nbl->nbl_time,
> -			       (unsigned long)cutoff)) {
> +		if (nbl->nbl_time > cutoff) {
>  			t = nbl->nbl_time - cutoff;
>  			new_timeo = min(new_timeo, t);
>  			break;
> @@ -5319,7 +5316,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>  		free_blocked_lock(nbl);
>  	}
>  out:
> -	new_timeo = max_t(time_t, new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
> +	new_timeo = max_t(time64_t, new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
>  	return new_timeo;
>  }
>  
> @@ -5329,13 +5326,13 @@ static void laundromat_main(struct work_struct *);
>  static void
>  laundromat_main(struct work_struct *laundry)
>  {
> -	time_t t;
> +	time64_t t;
>  	struct delayed_work *dwork = to_delayed_work(laundry);
>  	struct nfsd_net *nn = container_of(dwork, struct nfsd_net,
>  					   laundromat_work);
>  
>  	t = nfs4_laundromat(nn);
> -	dprintk("NFSD: laundromat_main - sleeping for %ld seconds\n", t);
> +	dprintk("NFSD: laundromat_main - sleeping for %lld seconds\n", t);
>  	queue_delayed_work(laundry_wq, &nn->laundromat_work, t*HZ);
>  }
>  
> @@ -6549,7 +6546,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	}
>  
>  	if (fl_flags & FL_SLEEP) {
> -		nbl->nbl_time = get_seconds();
> +		nbl->nbl_time = ktime_get_boottime_seconds();
>  		spin_lock(&nn->blocked_locks_lock);
>  		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
>  		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
> @@ -7709,7 +7706,7 @@ nfs4_state_start_net(struct net *net)
>  	nfsd4_client_tracking_init(net);
>  	if (nn->track_reclaim_completes && nn->reclaim_str_hashtbl_size == 0)
>  		goto skip_grace;
> -	printk(KERN_INFO "NFSD: starting %ld-second grace period (net %x)\n",
> +	printk(KERN_INFO "NFSD: starting %lld-second grace period (net %x)\n",
>  	       nn->nfsd4_grace, net->ns.inum);
>  	queue_delayed_work(laundry_wq, &nn->laundromat_work, nn->nfsd4_grace * HZ);
>  	return 0;
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 11b42c523f04..aace740d5a92 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -956,7 +956,7 @@ static ssize_t write_maxconn(struct file *file, char *buf, size_t size)
>  
>  #ifdef CONFIG_NFSD_V4
>  static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t size,
> -				  time_t *time, struct nfsd_net *nn)
> +				  time64_t *time, struct nfsd_net *nn)
>  {
>  	char *mesg = buf;
>  	int rv, i;
> @@ -984,11 +984,11 @@ static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t size,
>  		*time = i;
>  	}
>  
> -	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%ld\n", *time);
> +	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%lld\n", *time);
>  }
>  
>  static ssize_t nfsd4_write_time(struct file *file, char *buf, size_t size,
> -				time_t *time, struct nfsd_net *nn)
> +				time64_t *time, struct nfsd_net *nn)
>  {
>  	ssize_t rv;
>  
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 03fc7b4380f9..e426b22b5028 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -132,7 +132,7 @@ struct nfs4_delegation {
>  	struct list_head	dl_recall_lru;  /* delegation recalled */
>  	struct nfs4_clnt_odstate *dl_clnt_odstate;
>  	u32			dl_type;
> -	time_t			dl_time;
> +	time64_t		dl_time;
>  /* For recall: */
>  	int			dl_retries;
>  	struct nfsd4_callback	dl_recall;
> @@ -310,7 +310,7 @@ struct nfs4_client {
>  #endif
>  	struct xdr_netobj	cl_name; 	/* id generated by client */
>  	nfs4_verifier		cl_verifier; 	/* generated by client */
> -	time_t                  cl_time;        /* time of last lease renewal */
> +	time64_t		cl_time;	/* time of last lease renewal */
>  	struct sockaddr_storage	cl_addr; 	/* client ipaddress */
>  	bool			cl_mach_cred;	/* SP4_MACH_CRED in force */
>  	struct svc_cred		cl_cred; 	/* setclientid principal */
> @@ -449,7 +449,7 @@ struct nfs4_openowner {
>  	 */
>  	struct list_head	oo_close_lru;
>  	struct nfs4_ol_stateid *oo_last_closed_stid;
> -	time_t			oo_time; /* time of placement on so_close_lru */
> +	time64_t		oo_time; /* time of placement on so_close_lru */
>  #define NFS4_OO_CONFIRMED   1
>  	unsigned char		oo_flags;
>  };
> @@ -606,7 +606,7 @@ static inline bool nfsd4_stateid_generation_after(stateid_t *a, stateid_t *b)
>  struct nfsd4_blocked_lock {
>  	struct list_head	nbl_list;
>  	struct list_head	nbl_lru;
> -	time_t			nbl_time;
> +	time64_t		nbl_time;
>  	struct file_lock	nbl_lock;
>  	struct knfsd_fh		nbl_fh;
>  	struct nfsd4_callback	nbl_cb;
> -- 
> 2.20.0
