Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B723338DC68
	for <lists+linux-nfs@lfdr.de>; Sun, 23 May 2021 20:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhEWS2x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 May 2021 14:28:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59013 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231829AbhEWS2x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 May 2021 14:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621794446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/TMokTRYdrIiwAh6Qc6o71xaE1jHlMIFOkO+/hJrdx4=;
        b=Kz8S3AJM4HZAhQE4K8GcK9miTkvhj6G74sH7f2r/37eg/kjESIt7ZSOT6HeSC0QPrxBJ6g
        1DAfNusN48vpxS2jpNjtC6XwhLlIXo18nTkcGf2ymjd0LtQNbSRtn0OHH4wGmp5/CmElrE
        ciOd1pq32kfudEp6DY5WmA2rO2Pb6fY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-ymeF_c1cPlei3YkMnTf4Mg-1; Sun, 23 May 2021 14:27:22 -0400
X-MC-Unique: ymeF_c1cPlei3YkMnTf4Mg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D1318015C6;
        Sun, 23 May 2021 18:27:21 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-73.phx2.redhat.com [10.3.112.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69B975D9F0;
        Sun, 23 May 2021 18:27:20 +0000 (UTC)
Subject: Re: [PATCH nfs-utils 1/2] Remove 'force' arg from cache_flush()
To:     NeilBrown <neilb@suse.de>
Cc:     Petr Vorel <pvorel@suse.cz>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>
References: <20210422191803.31511-1-pvorel@suse.cz>
 <20210422202334.GB25415@fieldses.org> <YILQip3nAxhpXP9+@pevik>
 <162035212343.24322.12361160756597283121@noble.neil.brown.name>
 <162122673178.19062.96081788305923933@noble.neil.brown.name>
 <289c5819-917a-39a7-9aa4-2a27ae7248c0@RedHat.com>
 <162156113063.19062.9406037279407040033@noble.neil.brown.name>
 <162156122215.19062.11710239266795260824@noble.neil.brown.name>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <9a370e4b-6cdc-66a4-6a08-715fc4e4983a@RedHat.com>
Date:   Sun, 23 May 2021 14:30:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <162156122215.19062.11710239266795260824@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/20/21 9:40 PM, NeilBrown wrote:
> 
> Since v4.17 the timestamp written to 'flush' is ignored,
> so there isn't much point choosing too precisely.
> 
> For kernels since v4.3-rc3-13-g778620364ef5 it is safe
> to write 1 second beyond the current time.
> 
> For earlier kernels, nothing is really safe (even the current
> behaviour), but writing one second beyond the current time isn't too bad
> in the unlikely case the people use a new nfs-utils on a 5 year old
> kernel.
> 
> This remove a dependency for libnfs.a on 'etab' being declare,
> so svcgssd no longer needs to declare it.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
Committed... (tag: nfs-utils-2-5-4-rc4)

steved.
> ---
>  support/export/auth.c     |  2 +-
>  support/include/nfslib.h  |  2 +-
>  support/nfs/cacheio.c     | 17 ++++++++---------
>  utils/exportfs/exportfs.c |  4 ++--
>  utils/gssd/svcgssd.c      |  1 -
>  5 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/support/export/auth.c b/support/export/auth.c
> index cea376300d01..17bdfc83748e 100644
> --- a/support/export/auth.c
> +++ b/support/export/auth.c
> @@ -80,7 +80,7 @@ check_useipaddr(void)
>  		use_ipaddr = 0;
>  
>  	if (use_ipaddr != old_use_ipaddr)
> -		cache_flush(1);
> +		cache_flush();
>  }
>  
>  unsigned int
> diff --git a/support/include/nfslib.h b/support/include/nfslib.h
> index 84d8270b330f..58eeb3382fcc 100644
> --- a/support/include/nfslib.h
> +++ b/support/include/nfslib.h
> @@ -132,7 +132,7 @@ int			wildmat(char *text, char *pattern);
>  
>  int qword_get(char **bpp, char *dest, int bufsize);
>  int qword_get_int(char **bpp, int *anint);
> -void cache_flush(int force);
> +void cache_flush(void);
>  void qword_add(char **bpp, int *lp, char *str);
>  void qword_addhex(char **bpp, int *lp, char *buf, int blen);
>  void qword_addint(char **bpp, int *lp, int n);
> diff --git a/support/nfs/cacheio.c b/support/nfs/cacheio.c
> index 70ead94d64f0..73f4be4af9f9 100644
> --- a/support/nfs/cacheio.c
> +++ b/support/nfs/cacheio.c
> @@ -32,8 +32,6 @@
>  #include <time.h>
>  #include <errno.h>
>  
> -extern struct state_paths etab;
> -
>  void qword_add(char **bpp, int *lp, char *str)
>  {
>  	char *bp = *bpp;
> @@ -213,7 +211,7 @@ int qword_get_uint(char **bpp, unsigned int *anint)
>   */
>  
>  void
> -cache_flush(int force)
> +cache_flush(void)
>  {
>  	struct stat stb;
>  	int c;
> @@ -234,12 +232,13 @@ cache_flush(int force)
>  		NULL
>  	};
>  	now = time(0);
> -	if (force ||
> -	    stat(etab.statefn, &stb) != 0 ||
> -	    stb.st_mtime > now)
> -		stb.st_mtime = time(0);
> -	
> -	sprintf(stime, "%" PRId64 "\n", (int64_t)stb.st_mtime);
> +
> +	/* Since v4.16-rc2-3-g3b68e6ee3cbd the timestamp written is ignored.
> +	 * It is safest always to flush caches if there is any doubt.
> +	 * For earlier kernels, writing the next second from now is
> +	 * the best we can do.
> +	 */
> +	sprintf(stime, "%" PRId64 "\n", (int64_t)now+1);
>  	for (c=0; cachelist[c]; c++) {
>  		int fd;
>  		sprintf(path, "/proc/net/rpc/%s/flush", cachelist[c]);
> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> index bc76aaaf8714..d586296796a9 100644
> --- a/utils/exportfs/exportfs.c
> +++ b/utils/exportfs/exportfs.c
> @@ -188,7 +188,7 @@ main(int argc, char **argv)
>  
>  	if (optind == argc && ! f_all) {
>  		if (force_flush) {
> -			cache_flush(1);
> +			cache_flush();
>  			free_state_path_names(&etab);
>  			return 0;
>  		} else {
> @@ -235,7 +235,7 @@ main(int argc, char **argv)
>  				unexportfs(argv[i], f_verbose);
>  	}
>  	xtab_export_write();
> -	cache_flush(force_flush);
> +	cache_flush();
>  	free_state_path_names(&etab);
>  	export_freeall();
>  
> diff --git a/utils/gssd/svcgssd.c b/utils/gssd/svcgssd.c
> index 3ab2100b66bb..881207b3e8a2 100644
> --- a/utils/gssd/svcgssd.c
> +++ b/utils/gssd/svcgssd.c
> @@ -67,7 +67,6 @@
>  #include "misc.h"
>  #include "svcgssd_krb5.h"
>  
> -struct state_paths etab; /* from cacheio.c */
>  static bool signal_received = false;
>  static struct event_base *evbase = NULL;
>  static int nullrpc_fd = -1;
> 

