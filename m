Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663E93A32AB
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 20:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFJSFR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 14:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230305AbhFJSFR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 14:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623348200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RxcYUDuALKqolB2HkXuRRkYybvqaib82HQ8VmPusdjE=;
        b=EF+ZxjAfWXVTljXtS11zhpIv/9m2Uo+tZmmdGxXPDUgHdAESpzw4uFlBMb7oIakhy+Kr1X
        PDXZNt5pmq8k7kdVtLJ0Iu6mw0i/KpH76h9Hqeo0TDHtSrha5C3EOXSZLMhltCUmZW6+eW
        uRj7U4igNcR4PDphkMvIfOdtHh7PCqM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-VA2C3fnNOJuUo0RZpsnOsA-1; Thu, 10 Jun 2021 14:03:19 -0400
X-MC-Unique: VA2C3fnNOJuUo0RZpsnOsA-1
Received: by mail-qv1-f69.google.com with SMTP id n3-20020a0cee630000b029020e62abfcbdso16941569qvs.16
        for <linux-nfs@vger.kernel.org>; Thu, 10 Jun 2021 11:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RxcYUDuALKqolB2HkXuRRkYybvqaib82HQ8VmPusdjE=;
        b=ipGTNXtKAbHE+niyYy9oLhOWrWWcBNF083kV92vi/Lt8xZjTkVNmvNWXDTDnajKaEJ
         CbKKiyMuvV7cp/LOVf9TsvDIisRZEfNaryM8bmfHIputvgXTnv8TQf6hMOGo/ZCC7TSl
         IO/3SP7buTiXOsQLsFGH/jEOZ72kOW1ml1BSL7fhlXL+Plw+KEp54TfUvPHSq4HMv3d3
         YGjKQtSp4JJdNBEtr/st+LhMcBVkYf48yCsCpR75myDAKHNlipHleClhavzetnIiirBz
         XMhZNNaP5Q+mjhnm9b4oq4vl6T463Yz/zMdxnFpN8V3lbJWMalTIDX3gTTvh/gvukcHe
         BBOQ==
X-Gm-Message-State: AOAM5310oAhZBdQaSeDkq76PggT4pSrHzIKIiMuz/s1lbPw0WWfx/TwK
        FFYGleCZMMJr0hN5iJrTFGV8JSkIY6eFe8KJUO+QVhNTO27GFf3e/AXgZZ+n7O0jwF5LZvJ/pfA
        Z04JCKerzRfgdeoQ43Bk9IbOPdaxVM1Vdr8AMD8TotI4nmczUD8EkTK5xxWDXhZiPLKEqmA==
X-Received: by 2002:a0c:eec2:: with SMTP id h2mr857544qvs.22.1623348198626;
        Thu, 10 Jun 2021 11:03:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOk+xblQWMMdiXanQJW1rGEjNbxor/MAZ+rF01AxZ+2avkQtAzxVz3xxYbQfvX5/cQ9qgIZg==
X-Received: by 2002:a0c:eec2:: with SMTP id h2mr857507qvs.22.1623348198419;
        Thu, 10 Jun 2021 11:03:18 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([71.161.93.112])
        by smtp.gmail.com with ESMTPSA id t139sm2698302qka.85.2021.06.10.11.03.17
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 11:03:18 -0700 (PDT)
Subject: Re: [PATCH] gssd: Cleaned up debug messages
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210610150825.396565-1-steved@redhat.com>
Message-ID: <627209c3-21dd-312e-c2dc-cc810108f7d1@redhat.com>
Date:   Thu, 10 Jun 2021 14:06:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210610150825.396565-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/10/21 11:08 AM, Steve Dickson wrote:
> Added tids to a number of statements
> Broke the lifetime_rec secs into a readable format
> Printed tids out correctly
> Trim down the output of both '-v' and '-vv'
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed (tag: nfs-utils-2-5-4-rc7)

steved.
> ---
>   utils/gssd/err_util.c  | 14 ++++++++++++++
>   utils/gssd/err_util.h  |  1 +
>   utils/gssd/gssd.c      | 12 ++++++------
>   utils/gssd/gssd_proc.c | 34 ++++++++++++++++++++++------------
>   utils/gssd/krb5_util.c | 29 +++++++++++++++++------------
>   5 files changed, 60 insertions(+), 30 deletions(-)
> 
> diff --git a/utils/gssd/err_util.c b/utils/gssd/err_util.c
> index 2b1132ac..27abd236 100644
> --- a/utils/gssd/err_util.c
> +++ b/utils/gssd/err_util.c
> @@ -70,3 +70,17 @@ int get_verbosity(void)
>   {
>   	return verbosity;
>   }
> +
> +char *
> +sec2time(int value)
> +{
> +    static char buf[BUFSIZ];
> +    int hr, min, sec;
> +
> +    hr = (value / 3600);
> +    min = (value  - (3600*hr))/60;
> +    sec = (value  - (3600*hr) - (min*60));
> +    sprintf(buf, "%dh:%dm:%ds", hr, min, sec);
> +    return(buf);
> +}
> +
> diff --git a/utils/gssd/err_util.h b/utils/gssd/err_util.h
> index c4df32da..6fa9d3d7 100644
> --- a/utils/gssd/err_util.h
> +++ b/utils/gssd/err_util.h
> @@ -34,5 +34,6 @@
>   void initerr(char *progname, int verbosity, int fg);
>   void printerr(int priority, char *format, ...);
>   int get_verbosity(void);
> +char * sec2time(int);
>   
>   #endif /* _ERR_UTIL_H_ */
> diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
> index 4ca637f4..4113cbab 100644
> --- a/utils/gssd/gssd.c
> +++ b/utils/gssd/gssd.c
> @@ -396,7 +396,7 @@ gssd_free_client(struct clnt_info *clp)
>   	if (refcnt > 0)
>   		return;
>   
> -	printerr(3, "freeing client %s\n", clp->relpath);
> +	printerr(4, "freeing client %s\n", clp->relpath);
>   
>   	if (clp->krb5_fd >= 0)
>   		close(clp->krb5_fd);
> @@ -417,7 +417,7 @@ gssd_free_client(struct clnt_info *clp)
>   static void
>   gssd_destroy_client(struct clnt_info *clp)
>   {
> -	printerr(3, "destroying client %s\n", clp->relpath);
> +	printerr(4, "destroying client %s\n", clp->relpath);
>   
>   	if (clp->krb5_ev) {
>   		event_del(clp->krb5_ev);
> @@ -494,7 +494,7 @@ scan_active_thread_list(void)
>   			 * upcall_thread_info from the list and free it.
>   			 */
>   			if (tret == PTHREAD_CANCELED)
> -				printerr(3, "watchdog: thread id 0x%lx cancelled successfully\n",
> +				printerr(2, "watchdog: thread id 0x%lx cancelled successfully\n",
>   						info->tid);
>   			saveprev = info->list.tqe_prev;
>   			TAILQ_REMOVE(&active_thread_list, info, list);
> @@ -598,7 +598,7 @@ gssd_get_clnt(struct topdir *tdi, const char *name)
>   		if (!strcmp(clp->name, name))
>   			return clp;
>   
> -	printerr(3, "creating client %s/%s\n", tdi->name, name);
> +	printerr(4, "creating client %s/%s\n", tdi->name, name);
>   
>   	clp = calloc(1, sizeof(struct clnt_info));
>   	if (!clp) {
> @@ -639,7 +639,7 @@ gssd_scan_clnt(struct clnt_info *clp)
>   {
>   	int clntfd;
>   
> -	printerr(3, "scanning client %s\n", clp->relpath);
> +	printerr(4, "scanning client %s\n", clp->relpath);
>   
>   	clntfd = openat(pipefs_fd, clp->relpath, O_RDONLY);
>   	if (clntfd < 0) {
> @@ -798,7 +798,7 @@ gssd_scan(void)
>   {
>   	struct dirent *d;
>   
> -	printerr(3, "doing a full rescan\n");
> +	printerr(4, "doing a full rescan\n");
>   	rewinddir(pipefs_dir);
>   
>   	while ((d = readdir(pipefs_dir))) {
> diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
> index e849d104..ae568f15 100644
> --- a/utils/gssd/gssd_proc.c
> +++ b/utils/gssd/gssd_proc.c
> @@ -166,8 +166,9 @@ do_downcall(int k5_fd, uid_t uid, struct authgss_private_data *pd,
>   	unsigned int buf_size = 0;
>   	pthread_t tid = pthread_self();
>   
> -	printerr(2, "do_downcall(0x%x): lifetime_rec=%u acceptor=%.*s\n",
> -		tid, lifetime_rec, acceptor->length, acceptor->value);
> +	if (get_verbosity() > 1)
> +		printerr(2, "do_downcall(0x%lx): lifetime_rec=%s acceptor=%.*s\n",
> +			tid, sec2time(lifetime_rec), acceptor->length, acceptor->value);
>   	buf_size = sizeof(uid) + sizeof(timeout) + sizeof(pd->pd_seq_win) +
>   		sizeof(pd->pd_ctx_hndl.length) + pd->pd_ctx_hndl.length +
>   		sizeof(context_token->length) + context_token->length +
> @@ -193,7 +194,7 @@ do_downcall(int k5_fd, uid_t uid, struct authgss_private_data *pd,
>   	return;
>   out_err:
>   	free(buf);
> -	printerr(1, "do_downcall(0x%x): Failed to write downcall!\n", tid);
> +	printerr(1, "do_downcall(0x%lx): Failed to write downcall!\n", tid);
>   	return;
>   }
>   
> @@ -204,8 +205,9 @@ do_error_downcall(int k5_fd, uid_t uid, int err)
>   	char	*p = buf, *end = buf + 1024;
>   	unsigned int timeout = 0;
>   	int	zero = 0;
> +	pthread_t tid = pthread_self();
>   
> -	printerr(2, "doing error downcall\n");
> +	printerr(2, "do_error_downcall(0x%lx): uid %d err %d\n", tid, uid, err);
>   
>   	if (WRITE_BYTES(&p, end, uid)) goto out_err;
>   	if (WRITE_BYTES(&p, end, timeout)) goto out_err;
> @@ -328,6 +330,7 @@ create_auth_rpc_client(struct clnt_info *clp,
>   	struct timeval	timeout;
>   	struct sockaddr		*addr = (struct sockaddr *) &clp->addr;
>   	socklen_t		salen;
> +	pthread_t tid = pthread_self();
>   
>   	sec.qop = GSS_C_QOP_DEFAULT;
>   	sec.svc = RPCSEC_GSS_SVC_NONE;
> @@ -361,8 +364,8 @@ create_auth_rpc_client(struct clnt_info *clp,
>   
>   	/* create an rpc connection to the nfs server */
>   
> -	printerr(2, "creating %s client for server %s\n", clp->protocol,
> -			clp->servername);
> +	printerr(3, "create_auth_rpc_client(0x%lx): creating %s client for server %s\n",
> +		tid, clp->protocol, clp->servername);
>   
>   	protocol = IPPROTO_TCP;
>   	if ((strcmp(clp->protocol, "udp")) == 0)
> @@ -405,7 +408,8 @@ create_auth_rpc_client(struct clnt_info *clp,
>   	if (!tgtname)
>   		tgtname = clp->servicename;
>   
> -	printerr(2, "creating context with server %s\n", tgtname);
> +	printerr(3, "create_auth_rpc_client(0x%lx): creating context with server %s\n",
> +		tid, tgtname);
>   	auth = authgss_create_default(rpc_clnt, tgtname, &sec);
>   	if (!auth) {
>   		/* Our caller should print appropriate message */
> @@ -511,9 +515,10 @@ krb5_not_machine_creds(struct clnt_info *clp, uid_t uid, char *tgtname,
>   	gss_cred_id_t	gss_cred;
>   	char		**dname;
>   	int		err, resp = -1;
> +	pthread_t tid = pthread_self();
>   
> -	printerr(2, "krb5_not_machine_creds: uid %d tgtname %s\n",
> -		uid, tgtname);
> +	printerr(2, "krb5_not_machine_creds(0x%lx): uid %d tgtname %s\n",
> +		tid, uid, tgtname);
>   
>   	*chg_err = change_identity(uid);
>   	if (*chg_err) {
> @@ -559,9 +564,10 @@ krb5_use_machine_creds(struct clnt_info *clp, uid_t uid,
>   	char	**ccname;
>   	int	nocache = 0;
>   	int	success = 0;
> +	pthread_t tid = pthread_self();
>   
> -	printerr(2, "krb5_use_machine_creds: uid %d tgtname %s\n",
> -		uid, tgtname);
> +	printerr(2, "krb5_use_machine_creds(0x%lx): uid %d tgtname %s\n",
> +		tid, uid, tgtname);
>   
>   	do {
>   		gssd_refresh_krb5_machine_credential(clp->servername,
> @@ -878,6 +884,7 @@ start_upcall_thread(void (*func)(struct clnt_upcall_info *), struct clnt_upcall_
>   	pthread_t th;
>   	struct upcall_thread_info *tinfo;
>   	int ret;
> +	pthread_t tid = pthread_self();
>   
>   	tinfo = alloc_upcall_thread_info();
>   	if (!tinfo)
> @@ -900,6 +907,9 @@ start_upcall_thread(void (*func)(struct clnt_upcall_info *), struct clnt_upcall_
>   		free(tinfo);
>   		return ret;
>   	}
> +	printerr(2, "start_upcall_thread(0x%lx): created thread id 0x%lx\n",
> +		tid, th);
> +
>   	tinfo->tid = th;
>   	pthread_mutex_lock(&active_thread_list_lock);
>   	clock_gettime(CLOCK_MONOTONIC, &tinfo->timeout);
> @@ -962,7 +972,7 @@ handle_gssd_upcall(struct clnt_info *clp)
>   	}
>   	lbuf[lbuflen-1] = 0;
>   
> -	printerr(2, "\n%s(0x%x): '%s' (%s)\n", __func__, tid,
> +	printerr(2, "\n%s(0x%lx): '%s' (%s)\n", __func__, tid,
>   		 lbuf, clp->relpath);
>   
>   	for (p = strtok(lbuf, " "); p; p = strtok(NULL, " ")) {
> diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
> index 51e0c6a2..c5f1152e 100644
> --- a/utils/gssd/krb5_util.c
> +++ b/utils/gssd/krb5_util.c
> @@ -409,6 +409,7 @@ gssd_get_single_krb5_cred(krb5_context context,
>   	char *pname = NULL;
>   	char *k5err = NULL;
>   	int nocache = 0;
> +	pthread_t tid = pthread_self();
>   
>   	memset(&my_creds, 0, sizeof(my_creds));
>   
> @@ -421,8 +422,8 @@ gssd_get_single_krb5_cred(krb5_context context,
>   	now += 300;
>   	pthread_mutex_lock(&ple_lock);
>   	if (ple->ccname && ple->endtime > now && !nocache) {
> -		printerr(3, "INFO: Credentials in CC '%s' are good until %d\n",
> -			 ple->ccname, ple->endtime);
> +		printerr(3, "%s(0x%lx): Credentials in CC '%s' are good until %s",
> +			 __func__, tid, ple->ccname, ctime((time_t *)&ple->endtime));
>   		code = 0;
>   		pthread_mutex_unlock(&ple_lock);
>   		goto out;
> @@ -522,7 +523,8 @@ gssd_get_single_krb5_cred(krb5_context context,
>   	}
>   
>   	code = 0;
> -	printerr(2, "%s: principal '%s' ccache:'%s'\n", __func__, pname, cc_name);
> +	printerr(2, "%s(0x%lx): principal '%s' ccache:'%s'\n",
> +		__func__, tid, pname, cc_name);
>     out:
>   #ifdef HAVE_KRB5_GET_INIT_CREDS_OPT_SET_ADDRESSLESS
>   	if (init_opts)
> @@ -651,6 +653,7 @@ get_full_hostname(const char *inhost, char *outhost, int outhostlen)
>   	struct addrinfo hints;
>   	int retval;
>   	char *c;
> +	pthread_t tid = pthread_self();
>   
>   	memset(&hints, 0, sizeof(hints));
>   	hints.ai_socktype = SOCK_STREAM;
> @@ -660,8 +663,8 @@ get_full_hostname(const char *inhost, char *outhost, int outhostlen)
>   	/* Get full target hostname */
>   	retval = getaddrinfo(inhost, NULL, &hints, &addrs);
>   	if (retval) {
> -		printerr(1, "%s while getting full hostname for '%s'\n",
> -			 gai_strerror(retval), inhost);
> +		printerr(1, "%s(0x%lx): getaddrinfo(%s) failed: %s\n",
> +			 __func__, tid, inhost, gai_strerror(retval));
>   		goto out;
>   	}
>   	strncpy(outhost, addrs->ai_canonname, outhostlen);
> @@ -669,7 +672,10 @@ get_full_hostname(const char *inhost, char *outhost, int outhostlen)
>   	for (c = outhost; *c != '\0'; c++)
>   	    *c = tolower(*c);
>   
> -	printerr(3, "Full hostname for '%s' is '%s'\n", inhost, outhost);
> +	if (get_verbosity() && strcmp(inhost, outhost))
> +		printerr(1, "%s(0x%0lx): inhost '%s' different than outhost'%s'\n",
> +			inhost, outhost);
> +
>   	retval = 0;
>   out:
>   	return retval;
> @@ -856,6 +862,7 @@ find_keytab_entry(krb5_context context, krb5_keytab kt,
>   	krb5_principal princ;
>   	const char *notsetstr = "not set";
>   	char *adhostoverride = NULL;
> +	pthread_t tid = pthread_self();
>   
>   
>   	/* Get full target hostname */
> @@ -1010,7 +1017,7 @@ find_keytab_entry(krb5_context context, krb5_keytab kt,
>   					tried_upper = 1;
>   				}
>   			} else {
> -				printerr(2, "Success getting keytab entry for '%s'\n",spn);
> +				printerr(2, "find_keytab_entry(0x%lx): Success getting keytab entry for '%s'\n",tid, spn);
>   				retval = 0;
>   				goto out;
>   			}
> @@ -1151,9 +1158,6 @@ gssd_refresh_krb5_machine_credential_internal(char *hostname,
>   	char *k5err = NULL;
>   	const char *svcnames[] = { "$", "root", "nfs", "host", NULL };
>   
> -	printerr(2, "%s: hostname=%s ple=%p service=%s srchost=%s\n",
> -		__func__, hostname, ple, service, srchost);
> -
>   	/*
>   	 * If a specific service name was specified, use it.
>   	 * Otherwise, use the default list.
> @@ -1162,9 +1166,10 @@ gssd_refresh_krb5_machine_credential_internal(char *hostname,
>   		svcnames[0] = service;
>   		svcnames[1] = NULL;
>   	}
> -	if (hostname == NULL && ple == NULL)
> +	if (hostname == NULL && ple == NULL) {
> +		printerr(0, "ERROR: %s: Invalid args\n", __func__);
>   		return EINVAL;
> -
> +	}
>   	code = krb5_init_context(&context);
>   	if (code) {
>   		k5err = gssd_k5_err_msg(NULL, code);
> 

