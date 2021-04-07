Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF1E35742E
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Apr 2021 20:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbhDGSYh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Apr 2021 14:24:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231526AbhDGSYg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Apr 2021 14:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617819866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+WmlxQnn+nYRptl/LYF2MiDUBM8CJtHVJiBMqt2gUSE=;
        b=OH0uvwZNufXKrg6UN2SYf60h4WOqCP1Y2CIDzVQW5jaM9isgBkHd9RWiPMPjTrNblRUOly
        s3CQodGVzgnVnIRNZvUhzRwlSudsXwQvbfWciE+87wPbcosbcq7TK8Pqm1j3a8lE677lVL
        GPu9aa0GysPr9RTbZOPHB2ZQgAH3ZNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-CJRbeeiUPEaOm21ums__pw-1; Wed, 07 Apr 2021 14:24:24 -0400
X-MC-Unique: CJRbeeiUPEaOm21ums__pw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD24AA40C6;
        Wed,  7 Apr 2021 18:24:23 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-148.phx2.redhat.com [10.3.112.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A4E419D7D;
        Wed,  7 Apr 2021 18:24:22 +0000 (UTC)
Subject: Re: [PATCH v2] mountd/exportd: only log confirmed clients, and poll
 for updates
To:     NeilBrown <neilb@suse.de>, "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
 <874khui7hr.fsf@notabene.neil.brown.name>
 <20210302032733.GC16303@fieldses.org>
 <87y2ejerwn.fsf@notabene.neil.brown.name>
 <87v99neruh.fsf@notabene.neil.brown.name>
 <87sg4rerta.fsf@notabene.neil.brown.name>
 <87eegaepk4.fsf@notabene.neil.brown.name>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <14712e4a-3888-407f-b53b-3c2c53990ca0@RedHat.com>
Date:   Wed, 7 Apr 2021 14:26:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87eegaepk4.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/19/21 6:39 PM, NeilBrown wrote:
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
>  - request MODIFY notification from unconfirmed clients.
>  - recheck an info file when it is modified.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
Sorry it took so long... PTO got in the way!

Committed... (tag: nfs-utils-2-5-4-rc2)

steved.
> ---
>  support/export/v4clients.c | 86 +++++++++++++++++++++++++++++---------
>  1 file changed, 67 insertions(+), 19 deletions(-)
> 
> diff --git a/support/export/v4clients.c b/support/export/v4clients.c
> index 056ddc9b065d..f2c9bb482ba7 100644
> --- a/support/export/v4clients.c
> +++ b/support/export/v4clients.c
> @@ -48,12 +48,15 @@ void v4clients_set_fds(fd_set *fdset)
>  }
>  
>  static void *tree_root;
> +static int have_unconfirmed;
>  
>  struct ent {
>  	unsigned long num;
>  	char *clientid;
>  	char *addr;
>  	int vers;
> +	int unconfirmed;
> +	int wid;
>  };
>  
>  static int ent_cmp(const void *av, const void *bv)
> @@ -89,15 +92,14 @@ static char *dup_line(char *line)
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
> +	int was_unconfirmed = key->unconfirmed;
>  	FILE *f;
>  
> -	if (asprintf(&path, "/proc/fs/nfsd/clients/%d/info", id) < 0)
> +	if (asprintf(&path, "/proc/fs/nfsd/clients/%lu/info", key->num) < 0)
>  		return;
>  
>  	f = fopen(path, "r");
> @@ -105,35 +107,64 @@ static void add_id(int id)
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
> +	if (key->wid < 0)
> +		key->wid = inotify_add_watch(clients_fd, path, IN_MODIFY);
> +
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
> +	if (was_unconfirmed && !key->unconfirmed)
> +		xlog(L_NOTICE, "v4.%d client attached: %s from %s",
> +		     key->vers, key->clientid ?: "-none-",
> +		     key->addr ?: "-none-");
> +	if (!key->unconfirmed && ent->wid >= 0) {
> +		inotify_rm_watch(clients_fd, ent->wid);
> +		ent->wid = -1;
> +	}
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
> +	key->wid = -1;
>  
>  	ent = tsearch(key, &tree_root, ent_cmp);
>  
>  	if (!ent || *ent != key)
>  		/* Already existed, or insertion failed */
>  		free_ent(key);
> +	else
> +		read_info(key);
>  }
>  
> -static void del_id(int id)
> +static void del_id(unsigned long id)
>  {
>  	struct ent key = {.num = id};
>  	struct ent **e, *ent;
> @@ -143,11 +174,27 @@ static void del_id(int id)
>  		return;
>  	ent = *e;
>  	tdelete(ent, &tree_root, ent_cmp);
> -	xlog(L_NOTICE, "v4.%d client detached: %s from %s",
> -	     ent->vers, ent->clientid, ent->addr);
> +	if (!ent->unconfirmed)
> +		xlog(L_NOTICE, "v4.%d client detached: %s from %s",
> +		     ent->vers, ent->clientid, ent->addr);
> +	if (ent->wid >= 0)
> +		inotify_rm_watch(clients_fd, ent->wid);
>  	free_ent(ent);
>  }
>  
> +static void check_id(unsigned long id)
> +{
> +	struct ent key = {.num = id};
> +	struct ent **e, *ent;
> +
> +	e = tfind(&key, &tree_root, ent_cmp);
> +	if (!e || !*e)
> +		return;
> +	ent = *e;
> +	if (ent->unconfirmed)
> +		read_info(ent);
> +}
> +
>  int v4clients_process(fd_set *fdset)
>  {
>  	char buf[4096] __attribute__((aligned(__alignof__(struct inotify_event))));
> @@ -172,8 +219,9 @@ int v4clients_process(fd_set *fdset)
>  				add_id(id);
>  			if (ev->mask & IN_DELETE)
>  				del_id(id);
> +			if (ev->mask & IN_MODIFY)
> +				check_id(id);
>  		}
>  	}
>  	return 1;
>  }
> -
> 

