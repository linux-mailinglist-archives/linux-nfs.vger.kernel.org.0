Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8B722B547
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jul 2020 19:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbgGWR42 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jul 2020 13:56:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46862 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726666AbgGWR42 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Jul 2020 13:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595526986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/G7rA30jxcX1p03blDBADoYnBUXIB4uwwvQtFEBJSFQ=;
        b=H2qmK95RP54pybqljbiukmVxR3iVhHLtuVjZBnIlc6W0GsFOjstfBNZvrOTp5t4QZpbWRh
        cEoJPWlmai8aqIvHu331ohaUVeeG8+01h4e8dt6GRzH1KFdgJARk+1aqOFohgBs5eWJoGm
        6qOafsSLx5JpTj1PytN5RlktKdkoo6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-Nky9eAndOnegXcUFt8wfUg-1; Thu, 23 Jul 2020 13:56:24 -0400
X-MC-Unique: Nky9eAndOnegXcUFt8wfUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37C7F91277;
        Thu, 23 Jul 2020 17:56:23 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-147.phx2.redhat.com [10.3.113.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35A2B7849A;
        Thu, 23 Jul 2020 17:56:21 +0000 (UTC)
Subject: Re: [PATCH 2/4] idmapd: Add graceful exit and resource cleanup
To:     Doug Nazar <nazard@nazar.ca>, linux-nfs@vger.kernel.org
References: <20200722055354.28132-1-nazard@nazar.ca>
 <20200722055354.28132-3-nazard@nazar.ca>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <c136e451-f10a-c3a2-7f50-12735463275f@RedHat.com>
Date:   Thu, 23 Jul 2020 13:56:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200722055354.28132-3-nazard@nazar.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 7/22/20 1:53 AM, Doug Nazar wrote:
> Signed-off-by: Doug Nazar <nazard@nazar.ca>
> ---
>  utils/idmapd/idmapd.c | 75 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 65 insertions(+), 10 deletions(-)
> 
> diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
> index 491ef54c..dae5e567 100644
> --- a/utils/idmapd/idmapd.c
> +++ b/utils/idmapd/idmapd.c
> @@ -155,6 +155,7 @@ static void idtonameres(struct idmap_msg *);
>  static void nametoidres(struct idmap_msg *);
>  
>  static int nfsdopen(void);
> +static void nfsdclose(void);
>  static int nfsdopenone(struct idmap_client *);
>  static void nfsdreopen_one(struct idmap_client *);
>  static void nfsdreopen(void);
> @@ -167,6 +168,20 @@ static char *nobodyuser, *nobodygroup;
>  static uid_t nobodyuid;
>  static gid_t nobodygid;
>  static struct event_base *evbase = NULL;
> +static bool signal_received = false;
> +
> +static void
> +sig_die(int signal)
> +{
> +	if (signal_received) {
> +		xlog_warn("forced exiting on signal %d\n", signal);
> +		exit(0);
> +	}
> +
> +	signal_received = true;
> +	xlog_warn("exiting on signal %d\n", signal);
> +	event_base_loopexit(evbase, NULL);
> +}
>  
>  static int
>  flush_nfsd_cache(char *path, time_t now)
> @@ -210,14 +225,15 @@ main(int argc, char **argv)
>  {
>  	int wd = -1, opt, fg = 0, nfsdret = -1;
>  	struct idmap_clientq icq;
> -	struct event *rootdirev, *clntdirev, *svrdirev, *inotifyev;
> -	struct event *initialize;
> +	struct event *rootdirev = NULL, *clntdirev = NULL,
> +		     *svrdirev = NULL, *inotifyev = NULL;
> +	struct event *initialize = NULL;
>  	struct passwd *pw;
>  	struct group *gr;
>  	struct stat sb;
>  	char *xpipefsdir = NULL;
>  	int serverstart = 1, clientstart = 1;
> -	int inotify_fd;
> +	int inotify_fd = -1;
>  	int ret;
>  	char *progname;
>  	char *conf_path = NULL;
> @@ -290,6 +306,9 @@ main(int argc, char **argv)
>  			serverstart = 0;
>  	}
>  
> +	/* Not needed anymore */
> +	conf_cleanup();
> +
I'm a bit confused by this comment... If it is not needed why as the call added?

steved.
>  	while ((opt = getopt(argc, argv, GETOPTSTR)) != -1)
>  		switch (opt) {
>  		case 'v':
> @@ -398,6 +417,9 @@ main(int argc, char **argv)
>  
>  		TAILQ_INIT(&icq);
>  
> +		signal(SIGINT, sig_die);
> +		signal(SIGTERM, sig_die);
> +
>  		/* These events are persistent */
>  		rootdirev = evsignal_new(evbase, SIGUSR1, dirscancb, &icq);
>  		if (rootdirev == NULL)
> @@ -435,7 +457,25 @@ main(int argc, char **argv)
>  	if (event_base_dispatch(evbase) < 0)
>  		xlog_err("main: event_dispatch returns errno %d (%s)",
>  			    errno, strerror(errno));
> -	/* NOTREACHED */
> +
> +	nfs4_term_name_mapping();
> +	nfsdclose();
> +
> +	if (inotifyev)
> +		event_free(inotifyev);
> +	if (inotify_fd != -1)
> +		close(inotify_fd);
> +
> +	if (initialize)
> +		event_free(initialize);
> +	if (rootdirev)
> +		event_free(rootdirev);
> +	if (clntdirev)
> +		event_free(clntdirev);
> +	if (svrdirev)
> +		event_free(svrdirev);
> +	event_base_free(evbase);
> +
>  	return 1;
>  }
>  
> @@ -760,6 +800,19 @@ out:
>  	event_add(ic->ic_event, NULL);
>  }
>  
> +static void
> +nfsdclose_one(struct idmap_client *ic)
> +{
> +	if (ic->ic_event) {
> +		event_free(ic->ic_event);
> +		ic->ic_event = NULL;
> +	}
> +	if (ic->ic_fd != -1) {
> +		close(ic->ic_fd);
> +		ic->ic_fd = -1;
> +	}
> +}
> +
>  static void
>  nfsdreopen_one(struct idmap_client *ic)
>  {
> @@ -769,12 +822,7 @@ nfsdreopen_one(struct idmap_client *ic)
>  		xlog_warn("ReOpening %s", ic->ic_path);
>  
>  	if ((fd = open(ic->ic_path, O_RDWR, 0)) != -1) {
> -		if (ic->ic_event && event_initialized(ic->ic_event)) {
> -			event_del(ic->ic_event);
> -			event_free(ic->ic_event);
> -		}
> -		if (ic->ic_fd != -1)
> -			close(ic->ic_fd);
> +		nfsdclose_one(ic);
>  
>  		ic->ic_fd = fd;
>  		ic->ic_event = event_new(evbase, ic->ic_fd, EV_READ, nfsdcb, ic);
> @@ -807,6 +855,13 @@ nfsdopen(void)
>  		    nfsdopenone(&nfsd_ic[IC_IDNAME]) == 0) ? 0 : -1);
>  }
>  
> +static void
> +nfsdclose(void)
> +{
> +	nfsdclose_one(&nfsd_ic[IC_NAMEID]);
> +	nfsdclose_one(&nfsd_ic[IC_IDNAME]);
> +}
> +
>  static int
>  nfsdopenone(struct idmap_client *ic)
>  {
> 

