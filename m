Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E20611E843
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 17:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfLMQ0c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Dec 2019 11:26:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55540 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbfLMQ0b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Dec 2019 11:26:31 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDGOboR070657;
        Fri, 13 Dec 2019 16:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=XjbF7xHIvruJBOPHoIq2nTZJeplqSyrocKoLdHyZnLY=;
 b=k5kum/0EkmY47MVEWp3F1a+MckehgkX6saziOKoRgQ903q4CmdIR9RQ5OG/AzWgaRWt2
 N2w2LMDvzuPQ4msPSUPGWLffNTeT9WSMnv0b/8QU0OPOM/c1lI5b8MowCmbl/aBMjH9R
 jZG8bjaIrlSsbDQc8YVtSQh0ZYp34Yw9JLgUOS7EbCiOqDlwDXJoRS7vO5FjsSRt/wSy
 7EuA/Mkbhl2eOCv0E7ccUIfuY9CTCwjAfej5eakPuarVtbbQtWgLYa3gpIntgnJYrztj
 6DJ4G9D5uhbkcCSWZpEOc3aAQeqVQaWnRejds7Fi8AHrknv0Yt0x5CwNbNJz8VIVMNqL wA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wr4qs1y7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 16:26:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDGOLK2186537;
        Fri, 13 Dec 2019 16:26:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2wvdwpbsu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 16:26:22 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBDGQFK7001320;
        Fri, 13 Dec 2019 16:26:15 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 08:26:15 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 10/12] nfsd: use boottime for lease expiry alculation
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20191213141046.1770441-11-arnd@arndb.de>
Date:   Fri, 13 Dec 2019 11:26:13 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CBC9899C-12BE-466E-8809-EA928AAE1F11@oracle.com>
References: <20191213141046.1770441-1-arnd@arndb.de>
 <20191213141046.1770441-11-arnd@arndb.de>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130134
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Arnd-

> On Dec 13, 2019, at 9:10 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>=20
> A couple of time_t variables are only used to track the state of the
> lease time and its expiration. The code correctly uses the =
'time_after()'
> macro to make this work on 32-bit architectures even beyond year 2038,
> but the get_seconds() function and the time_t type itself are =
deprecated
> as they behave inconsistently between 32-bit and 64-bit architectures
> and often lead to code that is not y2038 safe.
>=20
> As a minor issue, using get_seconds() leads to problems with =
concurrent
> settimeofday() or clock_settime() calls, in the worst case timeout =
never
> triggering after the time has been set backwards.
>=20
> Change nfsd to use time64_t and ktime_get_boottime_seconds() here. =
This
> is clearly excessive, as boottime by itself means we never go beyond =
32
> bits, but it does mean we handle this correctly and consistently =
without
> having to worry about corner cases and should be no more expensive =
than
> the previous implementation on 64-bit architectures.
>=20
> The max_cb_time() function gets changed in order to avoid an expensive
> 64-bit division operation, but as the lease time is at most one hour,
> there is no change in behavior.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> fs/nfsd/netns.h        |  4 ++--
> fs/nfsd/nfs4callback.c |  7 ++++++-
> fs/nfsd/nfs4state.c    | 41 +++++++++++++++++++----------------------
> fs/nfsd/nfsctl.c       |  6 +++---
> fs/nfsd/state.h        |  8 ++++----
> 5 files changed, 34 insertions(+), 32 deletions(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 29bbe28eda53..2baf32311e00 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -92,8 +92,8 @@ struct nfsd_net {
> 	bool in_grace;
> 	const struct nfsd4_client_tracking_ops *client_tracking_ops;
>=20
> -	time_t nfsd4_lease;
> -	time_t nfsd4_grace;
> +	time64_t nfsd4_lease;
> +	time64_t nfsd4_grace;
> 	bool somebody_reclaimed;
>=20
> 	bool track_reclaim_completes;
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 24534db87e86..508d7c6c00b5 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -823,7 +823,12 @@ static const struct rpc_program cb_program =3D {
> static int max_cb_time(struct net *net)
> {
> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> -	return max(nn->nfsd4_lease/10, (time_t)1) * HZ;
> +
> +	/* nfsd4_lease is set to at most one hour */
> +	if (WARN_ON_ONCE(nn->nfsd4_lease > 3600))
> +		return 360 * HZ;

Why is the WARN_ON_ONCE added here? Is it really necessary?

(Otherwise these all LGTM).


> +
> +	return max(((u32)nn->nfsd4_lease)/10, 1u) * HZ;
> }
>=20
> static struct workqueue_struct *callback_wq;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 9a063c4b4460..6afdef63f6d7 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -170,7 +170,7 @@ renew_client_locked(struct nfs4_client *clp)
> 			clp->cl_clientid.cl_boot,
> 			clp->cl_clientid.cl_id);
> 	list_move_tail(&clp->cl_lru, &nn->client_lru);
> -	clp->cl_time =3D get_seconds();
> +	clp->cl_time =3D ktime_get_boottime_seconds();
> }
>=20
> static void put_client_renew_locked(struct nfs4_client *clp)
> @@ -2612,7 +2612,7 @@ static struct nfs4_client *create_client(struct =
xdr_netobj name,
> 	gen_clid(clp, nn);
> 	kref_init(&clp->cl_nfsdfs.cl_ref);
> 	nfsd4_init_cb(&clp->cl_cb_null, clp, NULL, =
NFSPROC4_CLNT_CB_NULL);
> -	clp->cl_time =3D get_seconds();
> +	clp->cl_time =3D ktime_get_boottime_seconds();
> 	clear_bit(0, &clp->cl_cb_slot_busy);
> 	copy_verf(clp, verf);
> 	memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
> @@ -4282,7 +4282,7 @@ move_to_close_lru(struct nfs4_ol_stateid *s, =
struct net *net)
> 	last =3D oo->oo_last_closed_stid;
> 	oo->oo_last_closed_stid =3D s;
> 	list_move_tail(&oo->oo_close_lru, &nn->close_lru);
> -	oo->oo_time =3D get_seconds();
> +	oo->oo_time =3D ktime_get_boottime_seconds();
> 	spin_unlock(&nn->client_lock);
> 	if (last)
> 		nfs4_put_stid(&last->st_stid);
> @@ -4377,7 +4377,7 @@ static void nfsd4_cb_recall_prepare(struct =
nfsd4_callback *cb)
> 	 */
> 	spin_lock(&state_lock);
> 	if (dp->dl_time =3D=3D 0) {
> -		dp->dl_time =3D get_seconds();
> +		dp->dl_time =3D ktime_get_boottime_seconds();
> 		list_add_tail(&dp->dl_recall_lru, &nn->del_recall_lru);
> 	}
> 	spin_unlock(&state_lock);
> @@ -5183,9 +5183,8 @@ nfsd4_end_grace(struct nfsd_net *nn)
>  */
> static bool clients_still_reclaiming(struct nfsd_net *nn)
> {
> -	unsigned long now =3D (unsigned long) ktime_get_real_seconds();
> -	unsigned long double_grace_period_end =3D (unsigned =
long)nn->boot_time +
> -					   2 * (unsigned =
long)nn->nfsd4_lease;
> +	time64_t double_grace_period_end =3D nn->boot_time +
> +					   2 * nn->nfsd4_lease;
>=20
> 	if (nn->track_reclaim_completes &&
> 			atomic_read(&nn->nr_reclaim_complete) =3D=3D
> @@ -5198,12 +5197,12 @@ static bool clients_still_reclaiming(struct =
nfsd_net *nn)
> 	 * If we've given them *two* lease times to reclaim, and they're
> 	 * still not done, give up:
> 	 */
> -	if (time_after(now, double_grace_period_end))
> +	if (ktime_get_boottime_seconds() > double_grace_period_end)
> 		return false;
> 	return true;
> }
>=20
> -static time_t
> +static time64_t
> nfs4_laundromat(struct nfsd_net *nn)
> {
> 	struct nfs4_client *clp;
> @@ -5212,8 +5211,8 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	struct nfs4_ol_stateid *stp;
> 	struct nfsd4_blocked_lock *nbl;
> 	struct list_head *pos, *next, reaplist;
> -	time_t cutoff =3D get_seconds() - nn->nfsd4_lease;
> -	time_t t, new_timeo =3D nn->nfsd4_lease;
> +	time64_t cutoff =3D ktime_get_boottime_seconds() - =
nn->nfsd4_lease;
> +	time64_t t, new_timeo =3D nn->nfsd4_lease;
>=20
> 	dprintk("NFSD: laundromat service - starting\n");
>=20
> @@ -5227,7 +5226,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	spin_lock(&nn->client_lock);
> 	list_for_each_safe(pos, next, &nn->client_lru) {
> 		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> -		if (time_after((unsigned long)clp->cl_time, (unsigned =
long)cutoff)) {
> +		if (clp->cl_time > cutoff) {
> 			t =3D clp->cl_time - cutoff;
> 			new_timeo =3D min(new_timeo, t);
> 			break;
> @@ -5250,7 +5249,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	spin_lock(&state_lock);
> 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
> 		dp =3D list_entry (pos, struct nfs4_delegation, =
dl_recall_lru);
> -		if (time_after((unsigned long)dp->dl_time, (unsigned =
long)cutoff)) {
> +		if (dp->dl_time > cutoff) {
> 			t =3D dp->dl_time - cutoff;
> 			new_timeo =3D min(new_timeo, t);
> 			break;
> @@ -5270,8 +5269,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	while (!list_empty(&nn->close_lru)) {
> 		oo =3D list_first_entry(&nn->close_lru, struct =
nfs4_openowner,
> 					oo_close_lru);
> -		if (time_after((unsigned long)oo->oo_time,
> -			       (unsigned long)cutoff)) {
> +		if (oo->oo_time > cutoff) {
> 			t =3D oo->oo_time - cutoff;
> 			new_timeo =3D min(new_timeo, t);
> 			break;
> @@ -5301,8 +5299,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	while (!list_empty(&nn->blocked_locks_lru)) {
> 		nbl =3D list_first_entry(&nn->blocked_locks_lru,
> 					struct nfsd4_blocked_lock, =
nbl_lru);
> -		if (time_after((unsigned long)nbl->nbl_time,
> -			       (unsigned long)cutoff)) {
> +		if (nbl->nbl_time > cutoff) {
> 			t =3D nbl->nbl_time - cutoff;
> 			new_timeo =3D min(new_timeo, t);
> 			break;
> @@ -5319,7 +5316,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> 		free_blocked_lock(nbl);
> 	}
> out:
> -	new_timeo =3D max_t(time_t, new_timeo, =
NFSD_LAUNDROMAT_MINTIMEOUT);
> +	new_timeo =3D max_t(time64_t, new_timeo, =
NFSD_LAUNDROMAT_MINTIMEOUT);
> 	return new_timeo;
> }
>=20
> @@ -5329,13 +5326,13 @@ static void laundromat_main(struct work_struct =
*);
> static void
> laundromat_main(struct work_struct *laundry)
> {
> -	time_t t;
> +	time64_t t;
> 	struct delayed_work *dwork =3D to_delayed_work(laundry);
> 	struct nfsd_net *nn =3D container_of(dwork, struct nfsd_net,
> 					   laundromat_work);
>=20
> 	t =3D nfs4_laundromat(nn);
> -	dprintk("NFSD: laundromat_main - sleeping for %ld seconds\n", =
t);
> +	dprintk("NFSD: laundromat_main - sleeping for %lld seconds\n", =
t);
> 	queue_delayed_work(laundry_wq, &nn->laundromat_work, t*HZ);
> }
>=20
> @@ -6549,7 +6546,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
> 	}
>=20
> 	if (fl_flags & FL_SLEEP) {
> -		nbl->nbl_time =3D get_seconds();
> +		nbl->nbl_time =3D ktime_get_boottime_seconds();
> 		spin_lock(&nn->blocked_locks_lock);
> 		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
> 		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
> @@ -7709,7 +7706,7 @@ nfs4_state_start_net(struct net *net)
> 	nfsd4_client_tracking_init(net);
> 	if (nn->track_reclaim_completes && nn->reclaim_str_hashtbl_size =
=3D=3D 0)
> 		goto skip_grace;
> -	printk(KERN_INFO "NFSD: starting %ld-second grace period (net =
%x)\n",
> +	printk(KERN_INFO "NFSD: starting %lld-second grace period (net =
%x)\n",
> 	       nn->nfsd4_grace, net->ns.inum);
> 	queue_delayed_work(laundry_wq, &nn->laundromat_work, =
nn->nfsd4_grace * HZ);
> 	return 0;
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 11b42c523f04..aace740d5a92 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -956,7 +956,7 @@ static ssize_t write_maxconn(struct file *file, =
char *buf, size_t size)
>=20
> #ifdef CONFIG_NFSD_V4
> static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t =
size,
> -				  time_t *time, struct nfsd_net *nn)
> +				  time64_t *time, struct nfsd_net *nn)
> {
> 	char *mesg =3D buf;
> 	int rv, i;
> @@ -984,11 +984,11 @@ static ssize_t __nfsd4_write_time(struct file =
*file, char *buf, size_t size,
> 		*time =3D i;
> 	}
>=20
> -	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%ld\n", *time);
> +	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%lld\n", =
*time);
> }
>=20
> static ssize_t nfsd4_write_time(struct file *file, char *buf, size_t =
size,
> -				time_t *time, struct nfsd_net *nn)
> +				time64_t *time, struct nfsd_net *nn)
> {
> 	ssize_t rv;
>=20
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 03fc7b4380f9..e426b22b5028 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -132,7 +132,7 @@ struct nfs4_delegation {
> 	struct list_head	dl_recall_lru;  /* delegation recalled =
*/
> 	struct nfs4_clnt_odstate *dl_clnt_odstate;
> 	u32			dl_type;
> -	time_t			dl_time;
> +	time64_t		dl_time;
> /* For recall: */
> 	int			dl_retries;
> 	struct nfsd4_callback	dl_recall;
> @@ -310,7 +310,7 @@ struct nfs4_client {
> #endif
> 	struct xdr_netobj	cl_name; 	/* id generated by =
client */
> 	nfs4_verifier		cl_verifier; 	/* generated by client =
*/
> -	time_t                  cl_time;        /* time of last lease =
renewal */
> +	time64_t		cl_time;	/* time of last lease =
renewal */
> 	struct sockaddr_storage	cl_addr; 	/* client ipaddress */
> 	bool			cl_mach_cred;	/* SP4_MACH_CRED in =
force */
> 	struct svc_cred		cl_cred; 	/* setclientid principal =
*/
> @@ -449,7 +449,7 @@ struct nfs4_openowner {
> 	 */
> 	struct list_head	oo_close_lru;
> 	struct nfs4_ol_stateid *oo_last_closed_stid;
> -	time_t			oo_time; /* time of placement on =
so_close_lru */
> +	time64_t		oo_time; /* time of placement on =
so_close_lru */
> #define NFS4_OO_CONFIRMED   1
> 	unsigned char		oo_flags;
> };
> @@ -606,7 +606,7 @@ static inline bool =
nfsd4_stateid_generation_after(stateid_t *a, stateid_t *b)
> struct nfsd4_blocked_lock {
> 	struct list_head	nbl_list;
> 	struct list_head	nbl_lru;
> -	time_t			nbl_time;
> +	time64_t		nbl_time;
> 	struct file_lock	nbl_lock;
> 	struct knfsd_fh		nbl_fh;
> 	struct nfsd4_callback	nbl_cb;
> --=20
> 2.20.0
>=20

--
Chuck Lever



