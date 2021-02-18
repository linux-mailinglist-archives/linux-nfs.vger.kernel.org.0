Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FF631EF1E
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Feb 2021 20:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhBRTAm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Feb 2021 14:00:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234906AbhBRR6Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Feb 2021 12:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613671008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bRx/Q3QG2sOCHa5ufjDWidZYmQgMzEKTWuCSpPFUFA8=;
        b=bDekC9V2rPM3S3lUa5EOVkOjmGO1v/QrIffeC0PaJGJrGDbN2Ezgtq5f2H6r5BzsQmNRo+
        a8PUKF5rIppfKtxXXv50OdWdaPI0YVKkEexE6YXG+YMWsMsoPo6E5wHW80PaztY7sYn7Xo
        h6gPZK5H/QwXwWQuDWoOqXN5Wb73uhE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-rFO6k0GkPPWnxqnz3rUmIw-1; Thu, 18 Feb 2021 12:56:46 -0500
X-MC-Unique: rFO6k0GkPPWnxqnz3rUmIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 070C1801978
        for <linux-nfs@vger.kernel.org>; Thu, 18 Feb 2021 17:56:45 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-108.phx2.redhat.com [10.3.112.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B33F019C47
        for <linux-nfs@vger.kernel.org>; Thu, 18 Feb 2021 17:56:44 +0000 (UTC)
Subject: Re: [PATCH 1/1] nfs-utiles: rename xlog_from_conffile() to
 xlog_set_debug()
From:   Steve Dickson <SteveD@RedHat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210217201836.95788-1-steved@redhat.com>
Message-ID: <dc24d931-3eb3-2911-2f7a-8d2ae7229ad6@RedHat.com>
Date:   Thu, 18 Feb 2021 12:58:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210217201836.95788-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/17/21 3:18 PM, Steve Dickson wrote:
> Standardized how config setting are set as
> well as the rename
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... 

steved.
> ---
>  support/include/xlog.h          |  2 +-
>  support/nfs/xlog.c              |  2 +-
>  utils/exportfs/exportfs.c       | 12 +++++++++---
>  utils/mountd/mountd.c           |  9 +++------
>  utils/nfsd/nfsd.c               | 11 +++++++++--
>  utils/nfsdcltrack/nfsdcltrack.c | 20 ++++++++++++--------
>  utils/statd/sm-notify.c         |  7 ++++---
>  utils/statd/statd.c             |  8 ++++----
>  8 files changed, 43 insertions(+), 28 deletions(-)
> 
> diff --git a/support/include/xlog.h b/support/include/xlog.h
> index 32ff5a1..69cdf61 100644
> --- a/support/include/xlog.h
> +++ b/support/include/xlog.h
> @@ -51,7 +51,7 @@ void			xlog_stderr(int on);
>  void			xlog_syslog(int on);
>  void			xlog_config(int fac, int on);
>  void			xlog_sconfig(char *, int on);
> -void			xlog_from_conffile(char *);
> +void			xlog_set_debug(char *);
>  int			xlog_enabled(int fac);
>  void			xlog(int fac, const char *fmt, ...) XLOG_FORMAT((printf, 2, 3));
>  void			xlog_warn(const char *fmt, ...) XLOG_FORMAT((printf, 1, 2));
> diff --git a/support/nfs/xlog.c b/support/nfs/xlog.c
> index 86acd6a..e5861b9 100644
> --- a/support/nfs/xlog.c
> +++ b/support/nfs/xlog.c
> @@ -129,7 +129,7 @@ xlog_sconfig(char *kind, int on)
>  }
>  
>  void
> -xlog_from_conffile(char *service)
> +xlog_set_debug(char *service)
>  {
>  	struct conf_list *kinds;
>  	struct conf_list_node *n;
> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> index 9fcae0b..f8b446a 100644
> --- a/utils/exportfs/exportfs.c
> +++ b/utils/exportfs/exportfs.c
> @@ -91,7 +91,12 @@ release_lockfile()
>  		_lockfd = -1;
>  	}
>  }
> -
> +inline static void 
> +read_exportfs_conf(void)
> +{
> +	conf_init_file(NFS_CONFFILE);
> +	xlog_set_debug("exportfs");
> +}
>  int
>  main(int argc, char **argv)
>  {
> @@ -116,8 +121,9 @@ main(int argc, char **argv)
>  	xlog_stderr(1);
>  	xlog_syslog(0);
>  
> -	conf_init_file(NFS_CONFFILE);
> -	xlog_from_conffile("exportfs");
> +	/* Read in config setting */
> +	read_exportfs_conf();
> +
>  	nfsd_path_init();
>  
>  	/* NOTE: following uses "mountd" section of nfs.conf !!!! */
> diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
> index a480265..612063b 100644
> --- a/utils/mountd/mountd.c
> +++ b/utils/mountd/mountd.c
> @@ -666,13 +666,13 @@ int	port = 0;
>  int	descriptors = 0;
>  
>  inline static void 
> -read_mount_conf(char **argv)
> +read_mountd_conf(char **argv)
>  {
>  	char	*s;
>  
>  	conf_init_file(NFS_CONFFILE);
>  
> -	xlog_from_conffile("mountd");
> +	xlog_set_debug("mountd");
>  	manage_gids = conf_get_bool("mountd", "manage-gids", manage_gids);
>  	descriptors = conf_get_num("mountd", "descriptors", descriptors);
>  	port = conf_get_num("mountd", "port", port);
> @@ -684,9 +684,6 @@ read_mount_conf(char **argv)
>  	if (s && !state_setup_basedir(argv[0], s))
>  		exit(1);
>  
> -	if ((s = conf_get_str("mountd", "debug")) != NULL)
> -		xlog_sconfig(s, 1);
> -
>  	/* NOTE: following uses "nfsd" section of nfs.conf !!!! */
>  	if (conf_get_bool("nfsd", "udp", NFSCTL_UDPISSET(_rpcprotobits)))
>  		NFSCTL_UDPSET(_rpcprotobits);
> @@ -726,7 +723,7 @@ main(int argc, char **argv)
>  	xlog_open(progname);
>  
>  	/* Read in config setting */
> -	read_mount_conf(argv);
> +	read_mountd_conf(argv);
>  
>  	/* Parse the command line options and arguments. */
>  	opterr = 0;
> diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
> index c9f0385..b074171 100644
> --- a/utils/nfsd/nfsd.c
> +++ b/utils/nfsd/nfsd.c
> @@ -56,6 +56,13 @@ static struct option longopts[] =
>  	{ NULL, 0, 0, 0 }
>  };
>  
> +inline static void 
> +read_nfsd_conf(void)
> +{
> +	conf_init_file(NFS_CONFFILE); 
> +	xlog_set_debug("nfsd");
> +}
> +
>  int
>  main(int argc, char **argv)
>  {
> @@ -81,8 +88,8 @@ main(int argc, char **argv)
>  	xlog_syslog(0);
>  	xlog_stderr(1);
>  
> -	conf_init_file(NFS_CONFFILE); 
> -	xlog_from_conffile("nfsd");
> +	/* Read in config setting */
> +	read_nfsd_conf();
>  
>  	nfssvc_get_minormask(&minormask);
>  
> diff --git a/utils/nfsdcltrack/nfsdcltrack.c b/utils/nfsdcltrack/nfsdcltrack.c
> index b45a904..ee85167 100644
> --- a/utils/nfsdcltrack/nfsdcltrack.c
> +++ b/utils/nfsdcltrack/nfsdcltrack.c
> @@ -549,7 +549,17 @@ find_cmd(char *cmdname)
>  			__func__, cmdname);
>  	return NULL;
>  }
> +inline static void 
> +read_nfsdcltrack_conf(void)
> +{
> +	char *val;
>  
> +	conf_init_file(NFS_CONFFILE); 
> +	xlog_set_debug("nfsdcltrack");
> +	val = conf_get_str("nfsdcltrack", "storagedir");
> +	if (val)
> +		storagedir = val;
> +}
>  int
>  main(int argc, char **argv)
>  {
> @@ -564,14 +574,8 @@ main(int argc, char **argv)
>  	xlog_syslog(1);
>  	xlog_stderr(0);
>  
> -	conf_init_file(NFS_CONFFILE); 
> -	xlog_from_conffile("nfsdcltrack");
> -	val = conf_get_str("nfsdcltrack", "storagedir");
> -	if (val)
> -		storagedir = val;
> -	rc = conf_get_num("nfsdcltrack", "debug", 0);
> -	if (rc > 0)
> -		xlog_config(D_ALL, 1);
> +	/* Read in config setting */
> +	read_nfsdcltrack_conf();
>  
>  	/* process command-line options */
>  	while ((arg = getopt_long(argc, argv, "hdfs:", longopts,
> diff --git a/utils/statd/sm-notify.c b/utils/statd/sm-notify.c
> index 739731f..606b912 100644
> --- a/utils/statd/sm-notify.c
> +++ b/utils/statd/sm-notify.c
> @@ -482,12 +482,12 @@ nsm_lift_grace_period(void)
>  	return;
>  }
>  inline static void 
> -read_nfsconf(char **argv)
> +read_smnotify_conf(char **argv)
>  {
>  	char *s;
>  
>  	conf_init_file(NFS_CONFFILE);
> -	xlog_from_conffile("sm-notify");
> +	xlog_set_debug("sm-notify");
>  	opt_max_retry = conf_get_num("sm-notify", "retry-time", opt_max_retry / 60) * 60;
>  	opt_srcport = conf_get_str("sm-notify", "outgoing-port");
>  	opt_srcaddr = conf_get_str("sm-notify", "outgoing-addr");
> @@ -512,7 +512,8 @@ main(int argc, char **argv)
>  	else
>  		progname = argv[0];
>  
> -	read_nfsconf(argv);
> +	/* Read in config setting */
> +	read_smnotify_conf(argv);
>  
>  	while ((c = getopt(argc, argv, "dm:np:v:P:f")) != -1) {
>  		switch (c) {
> diff --git a/utils/statd/statd.c b/utils/statd/statd.c
> index e4a1df4..32169d4 100644
> --- a/utils/statd/statd.c
> +++ b/utils/statd/statd.c
> @@ -243,12 +243,12 @@ int port = 0, out_port = 0;
>  int nlm_udp = 0, nlm_tcp = 0;
>  
>  inline static void 
> -read_nfsconf(char **argv)
> +read_statd_conf(char **argv)
>  {
>  	char *s;
>  
>  	conf_init_file(NFS_CONFFILE);
> -	xlog_from_conffile("statd");
> +	xlog_set_debug("statd");
>  
>  	out_port = conf_get_num("statd", "outgoing-port", out_port);
>  	port = conf_get_num("statd", "port", port);
> @@ -306,8 +306,8 @@ int main (int argc, char **argv)
>  	/* Set hostname */
>  	MY_NAME = NULL;
>  
> -	/* Read nfs.conf */
> -	read_nfsconf(argv);
> +	/* Read in config setting */
> +	read_statd_conf(argv);
>  
>  	/* Process command line switches */
>  	while ((arg = getopt_long(argc, argv, "h?vVFNH:dn:p:o:P:LT:U:", longopts, NULL)) != EOF) {
> 

