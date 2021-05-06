Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BE137594A
	for <lists+linux-nfs@lfdr.de>; Thu,  6 May 2021 19:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbhEFR3u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 May 2021 13:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236209AbhEFR3u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 May 2021 13:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620322131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HPlsTvSFEt7sjnJ9ReP2hm7rF4Y16Z46RgQO9KxcCTI=;
        b=dkm77Jvugr5jo38HlGYh1aeZ24j+yidCCs6aRobVus35/0d86oQrr0cEcOnh/UWoe5sOUU
        bdHsEzhqjF/VLMdNj2a/5C7pMZxZJVo5UOwtjjPYGAS/FBPRkV+SjNLyr/613rmZ/E3c6d
        POikfCiirJOel0JCgAJekSeJBKshIPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-r8tMOQq7NimBenSxRP29rw-1; Thu, 06 May 2021 13:28:49 -0400
X-MC-Unique: r8tMOQq7NimBenSxRP29rw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45B9E801817;
        Thu,  6 May 2021 17:28:48 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-61.phx2.redhat.com [10.3.112.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1AAE5D9CA;
        Thu,  6 May 2021 17:28:47 +0000 (UTC)
Subject: Re: [PATCH nfs-utils] Replace all /var/run with /run
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs@vger.kernel.org
References: <162008982689.6582.6678647463188747222@noble.neil.brown.name>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <3ca0a1c5-0812-ce62-84de-2534ad84305a@RedHat.com>
Date:   Thu, 6 May 2021 13:31:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <162008982689.6582.6678647463188747222@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/3/21 8:57 PM, NeilBrown wrote:
> FHS 3.0 deprecated /var/run in favour of /run.
> FHS 3.0 was released over 5 years ago.
> I think it is time for nfs-utils to catch up.
> Note that some places, particularly systemd unit files, already use just
> "/run".
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
Committed (tag: nfs-utils-2-5-4-rc3)

steved.
> ---
>  support/nfs/getport.c            |  2 +-
>  tests/test-lib.sh                |  2 +-
>  utils/blkmapd/device-discovery.c |  2 +-
>  utils/statd/sm-notify.c          |  4 ++--
>  utils/statd/start-statd          | 10 +++++-----
>  utils/statd/statd.c              |  2 +-
>  utils/statd/statd.man            |  2 +-
>  7 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/support/nfs/getport.c b/support/nfs/getport.c
> index e458d8fe95f8..813f7bf9e3ff 100644
> --- a/support/nfs/getport.c
> +++ b/support/nfs/getport.c
> @@ -904,7 +904,7 @@ int nfs_getport_ping(struct sockaddr *sap, const socklen_t salen,
>   * listen on AF_LOCAL.
>   *
>   * If that doesn't work (for example, if portmapper is running, or rpcbind
> - * isn't listening on /var/run/rpcbind.sock), send a query via UDP to localhost
> + * isn't listening on /run/rpcbind.sock), send a query via UDP to localhost
>   * (UDP doesn't leave a socket in TIME_WAIT, and the timeout is a relatively
>   * short 3 seconds).
>   */
> diff --git a/tests/test-lib.sh b/tests/test-lib.sh
> index 57af37b11126..e47ad13539ac 100644
> --- a/tests/test-lib.sh
> +++ b/tests/test-lib.sh
> @@ -56,5 +56,5 @@ start_statd() {
>  
>  # shut down statd
>  kill_statd() {
> -	kill `cat /var/run/rpc.statd.pid`
> +	kill `cat /run/rpc.statd.pid`
>  }
> diff --git a/utils/blkmapd/device-discovery.c b/utils/blkmapd/device-discovery.c
> index f5f9b10b95f2..77ebe73670fa 100644
> --- a/utils/blkmapd/device-discovery.c
> +++ b/utils/blkmapd/device-discovery.c
> @@ -64,7 +64,7 @@
>  #define EVENT_BUFSIZE (1024 * EVENT_SIZE)
>  
>  #define RPCPIPE_DIR	"/var/lib/nfs/rpc_pipefs"
> -#define PID_FILE	"/var/run/blkmapd.pid"
> +#define PID_FILE	"/run/blkmapd.pid"
>  
>  #define CONF_SAVE(w, f) do {			\
>  	char *p = f;				\
> diff --git a/utils/statd/sm-notify.c b/utils/statd/sm-notify.c
> index 606b912d3629..ed82b8f2533d 100644
> --- a/utils/statd/sm-notify.c
> +++ b/utils/statd/sm-notify.c
> @@ -901,7 +901,7 @@ find_host(uint32_t xid)
>  }
>  
>  /*
> - * Record pid in /var/run/sm-notify.pid
> + * Record pid in /run/sm-notify.pid
>   * This file should remain until a reboot, even if the
>   * program exits.
>   * If file already exists, fail.
> @@ -913,7 +913,7 @@ static int record_pid(void)
>  	int fd;
>  
>  	(void)snprintf(pid, sizeof(pid), "%d\n", (int)getpid());
> -	fd = open("/var/run/sm-notify.pid", O_CREAT|O_EXCL|O_WRONLY, 0600);
> +	fd = open("/run/sm-notify.pid", O_CREAT|O_EXCL|O_WRONLY, 0600);
>  	if (fd < 0)
>  		return 0;
>  
> diff --git a/utils/statd/start-statd b/utils/statd/start-statd
> index 54ced822016a..2baf73c385cf 100755
> --- a/utils/statd/start-statd
> +++ b/utils/statd/start-statd
> @@ -1,18 +1,18 @@
>  #!/bin/sh
>  # nfsmount calls this script when mounting a filesystem with locking
>  # enabled, but when statd does not seem to be running (based on
> -# /var/run/rpc.statd.pid).
> +# /run/rpc.statd.pid).
>  # It should run statd with whatever flags are apropriate for this
>  # site.
>  PATH="/sbin:/usr/sbin:/bin:/usr/bin"
>  
>  # Use flock to serialize the running of this script
> -exec 9> /var/run/rpc.statd.lock
> +exec 9> /run/rpc.statd.lock
>  flock -e 9
>  
> -if [ -s /var/run/rpc.statd.pid ] &&
> -       [ 1`cat /var/run/rpc.statd.pid` -gt 1 ] &&
> -       kill -0 `cat /var/run/rpc.statd.pid` > /dev/null 2>&1
> +if [ -s /run/rpc.statd.pid ] &&
> +       [ 1`cat /run/rpc.statd.pid` -gt 1 ] &&
> +       kill -0 `cat /run/rpc.statd.pid` > /dev/null 2>&1
>  then
>      # statd already running - must have been slow to respond.
>      exit 0
> diff --git a/utils/statd/statd.c b/utils/statd/statd.c
> index 32169d47c66d..a469a67a91df 100644
> --- a/utils/statd/statd.c
> +++ b/utils/statd/statd.c
> @@ -161,7 +161,7 @@ usage(void)
>  	fprintf(stderr,"      -H                   Specify a high-availability callout program.\n");
>  }
>  
> -static const char *pidfile = "/var/run/rpc.statd.pid";
> +static const char *pidfile = "/run/rpc.statd.pid";
>  
>  int pidfd = -1;
>  static void create_pidfile(void)
> diff --git a/utils/statd/statd.man b/utils/statd/statd.man
> index ecd3e889e831..7441ffde2687 100644
> --- a/utils/statd/statd.man
> +++ b/utils/statd/statd.man
> @@ -440,7 +440,7 @@ directory containing notify list
>  .I /var/lib/nfs/state
>  NSM state number for this host
>  .TP 2.5i
> -.I /var/run/run.statd.pid
> +.I /run/run.statd.pid
>  pid file
>  .TP 2.5i
>  .I /etc/netconfig
> 

