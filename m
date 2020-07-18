Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB00E224CBA
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jul 2020 17:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGRPzD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Jul 2020 11:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgGRPzC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Jul 2020 11:55:02 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CA8C0619D2
        for <linux-nfs@vger.kernel.org>; Sat, 18 Jul 2020 08:55:02 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id ABA1A6193; Sat, 18 Jul 2020 11:55:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org ABA1A6193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1595087701;
        bh=3bSX3vn3S13LjtLNsUZONdchjIfYTNblRp5W7zzgYAM=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=hcFQI4dq2LzXXI1yQNS9DPdd/kuvQo3mn8HURoyIFogNimQVMHlATYHHF7J1jtNWb
         nPPFU6Gi8VekY3/tvKwiT1VqNI+xeV/rXVrofJDj7Buj3v1SzHqSoVCVSSnTpbO/Jp
         bvlCMAMfuApf+V06+VYrcShcqBqVRXg0i9KIhUoA=
Date:   Sat, 18 Jul 2020 11:55:01 -0400
To:     Doug Nazar <nazard@nazar.ca>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 11/11] svcgssd: Wait for nullrpc channel if not available
Message-ID: <20200718155501.GB27817@fieldses.org>
References: <20200718092421.31691-1-nazard@nazar.ca>
 <20200718092421.31691-12-nazard@nazar.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718092421.31691-12-nazard@nazar.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Jul 18, 2020 at 05:24:21AM -0400, Doug Nazar wrote:
> Signed-off-by: Doug Nazar <nazard@nazar.ca>

So, is there a race here that could result in a hang, and has anyone
seen it in practice?

Just curious.  Thanks for doing this.--b.

> ---
>  utils/gssd/svcgssd.c | 99 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 80 insertions(+), 19 deletions(-)
> 
> diff --git a/utils/gssd/svcgssd.c b/utils/gssd/svcgssd.c
> index 3155a2f9..3ab2100b 100644
> --- a/utils/gssd/svcgssd.c
> +++ b/utils/gssd/svcgssd.c
> @@ -67,9 +67,14 @@
>  #include "misc.h"
>  #include "svcgssd_krb5.h"
>  
> -struct state_paths etab;
> +struct state_paths etab; /* from cacheio.c */
>  static bool signal_received = false;
>  static struct event_base *evbase = NULL;
> +static int nullrpc_fd = -1;
> +static struct event *nullrpc_event = NULL;
> +static struct event *wait_event = NULL;
> +
> +#define NULLRPC_FILE "/proc/net/rpc/auth.rpcsec.init/channel"
>  
>  static void
>  sig_die(int signal)
> @@ -118,6 +123,66 @@ svcgssd_nullrpc_cb(int fd, short UNUSED(which), void *UNUSED(data))
>  	handle_nullreq(lbuf);
>  }
>  
> +static void
> +svcgssd_nullrpc_close(void)
> +{
> +	if (nullrpc_event) {
> +		printerr(2, "closing nullrpc channel %s\n", NULLRPC_FILE);
> +		event_free(nullrpc_event);
> +		nullrpc_event = NULL;
> +	}
> +	if (nullrpc_fd != -1) {
> +		close(nullrpc_fd);
> +		nullrpc_fd = -1;
> +	}
> +}
> +
> +static void
> +svcgssd_nullrpc_open(void)
> +{
> +	nullrpc_fd = open(NULLRPC_FILE, O_RDWR);
> +	if (nullrpc_fd < 0) {
> +		printerr(0, "failed to open %s: %s\n",
> +			 NULLRPC_FILE, strerror(errno));
> +		return;
> +	}
> +	nullrpc_event = event_new(evbase, nullrpc_fd, EV_READ | EV_PERSIST,
> +				  svcgssd_nullrpc_cb, NULL);
> +	if (!nullrpc_event) {
> +		printerr(0, "failed to create event for %s: %s\n",
> +			 NULLRPC_FILE, strerror(errno));
> +		close(nullrpc_fd);
> +		nullrpc_fd = -1;
> +		return;
> +	}
> +	event_add(nullrpc_event, NULL);
> +	printerr(2, "opened nullrpc channel %s\n", NULLRPC_FILE);
> +}
> +
> +static void
> +svcgssd_wait_cb(int UNUSED(fd), short UNUSED(which), void *UNUSED(data))
> +{
> +	static int times = 0;
> +	int rc;
> +
> +	rc = access(NULLRPC_FILE, R_OK | W_OK);
> +	if (rc != 0) {
> +		struct timeval t = {times < 10 ? 1 : 10, 0};
> +		times++;
> +		if (times % 30 == 0)
> +			printerr(2, "still waiting for nullrpc channel: %s\n",
> +				NULLRPC_FILE);
> +		evtimer_add(wait_event, &t);
> +		return;
> +	}
> +
> +	svcgssd_nullrpc_open();
> +	event_free(wait_event);
> +	wait_event = NULL;
> +}
> +
> +
> +
>  int
>  main(int argc, char *argv[])
>  {
> @@ -132,8 +197,6 @@ main(int argc, char *argv[])
>  	char *principal = NULL;
>  	char *s;
>  	int rc;
> -	int nullrpc_fd = -1;
> -	struct event *nullrpc_event = NULL;
>  
>  	conf_init_file(NFS_CONFFILE);
>  
> @@ -250,22 +313,19 @@ main(int argc, char *argv[])
>  		}
>  	}
>  
> -#define NULLRPC_FILE "/proc/net/rpc/auth.rpcsec.init/channel"
> -
> -	nullrpc_fd = open(NULLRPC_FILE, O_RDWR);
> -	if (nullrpc_fd < 0) {
> -		printerr(0, "failed to open %s: %s\n",
> -			 NULLRPC_FILE, strerror(errno));
> -		exit(1);
> -	}
> -	nullrpc_event = event_new(evbase, nullrpc_fd, EV_READ | EV_PERSIST,
> -				  svcgssd_nullrpc_cb, NULL);
> +	svcgssd_nullrpc_open();
>  	if (!nullrpc_event) {
> -		printerr(0, "failed to create event for %s: %s\n",
> -			 NULLRPC_FILE, strerror(errno));
> -		exit(1);
> +		struct timeval t = {1, 0};
> +
> +		printerr(2, "waiting for nullrpc channel to appear\n");
> +		wait_event = evtimer_new(evbase, svcgssd_wait_cb, NULL);
> +		if (!wait_event) {
> +			printerr(0, "ERROR: failed to create wait event: %s\n",
> +				 strerror(errno));
> +			exit(EXIT_FAILURE);
> +		}
> +		evtimer_add(wait_event, &t);
>  	}
> -	event_add(nullrpc_event, NULL);
>  
>  	daemon_ready();
>  
> @@ -275,8 +335,9 @@ main(int argc, char *argv[])
>  	if (rc < 0)
>  		printerr(0, "event_base_dispatch() returned %i!\n", rc);
>  
> -	event_free(nullrpc_event);
> -	close(nullrpc_fd);
> +	svcgssd_nullrpc_close();
> +	if (wait_event)
> +		event_free(wait_event);
>  
>  	event_base_free(evbase);
>  
> -- 
> 2.26.2
