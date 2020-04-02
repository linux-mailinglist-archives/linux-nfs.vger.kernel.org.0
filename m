Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B09119BAA3
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Apr 2020 05:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbgDBDXo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Apr 2020 23:23:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44477 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732664AbgDBDXo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Apr 2020 23:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585797823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K7PlE1BOvd4yWyewYc0QHOLEgPNNxiICYcnTl2gESck=;
        b=LbAT2ec43CejEK+JxDWM+B7uaFWgKfoInKeFOTqpA9hwYY8ArKT7kKaB2pn42+TvgEwxOp
        JatQ67EzLXRpjJZsKs7yfxMzf3m/mzv2Oa0M3/e/7TGQzfO+4rCTanAZlnRZqNdDrLyb3z
        4ReH5cCFZJ+uuOHX2ELIvRp21zQw6rc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-0cNM-cReMNm_NkUsjhAWog-1; Wed, 01 Apr 2020 23:23:41 -0400
X-MC-Unique: 0cNM-cReMNm_NkUsjhAWog-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 858F7107ACC9;
        Thu,  2 Apr 2020 03:23:40 +0000 (UTC)
Received: from yoyang-pc.usersys.redhat.com (dhcp-12-152.nay.redhat.com [10.66.12.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5740496F83;
        Thu,  2 Apr 2020 03:23:38 +0000 (UTC)
Date:   Thu, 2 Apr 2020 11:23:35 +0800
From:   Yongcheng Yang <yoyang@redhat.com>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     steved@redhat.com, bfields@fieldses.org, jlayton@kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH RFC v3 6/8] nfsdcld: add /etc/nfs.conf support
Message-ID: <20200402032335.GA7811@yoyang-pc.usersys.redhat.com>
References: <20190326220730.3763-1-smayhew@redhat.com>
 <20190326220730.3763-7-smayhew@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326220730.3763-7-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Scott,

Sorry for jumping back into this thread after one year.

Maybe one another man page nfs.conf(5) (i.e. systemd/nfs.conf.man)
also needs an update (just as nfsdcltrack does).

Thanks,
Yongcheng

On Tue, Mar 26, 2019 at 06:07:28PM -0400, Scott Mayhew wrote:
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  nfs.conf                  |  4 ++++
>  utils/nfsdcld/nfsdcld.c   | 13 +++++++++++++
>  utils/nfsdcld/nfsdcld.man | 15 +++++++++++++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/nfs.conf b/nfs.conf
> index 796bee4..aabf300 100644
> --- a/nfs.conf
> +++ b/nfs.conf
> @@ -34,6 +34,10 @@
>  # state-directory-path=/var/lib/nfs
>  # ha-callout=
>  #
> +[nfsdcld]
> +# debug=0
> +# storagedir=/var/lib/nfs/nfsdcld
> +#
>  [nfsdcltrack]
>  # debug=0
>  # storagedir=/var/lib/nfs/nfsdcltrack
> diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
> index 272c7c5..313c68f 100644
> --- a/utils/nfsdcld/nfsdcld.c
> +++ b/utils/nfsdcld/nfsdcld.c
> @@ -45,6 +45,7 @@
>  #include "cld-internal.h"
>  #include "sqlite.h"
>  #include "../mount/version.h"
> +#include "conffile.h"
>  
>  #ifndef DEFAULT_PIPEFS_DIR
>  #define DEFAULT_PIPEFS_DIR NFS_STATEDIR "/rpc_pipefs"
> @@ -640,6 +641,7 @@ main(int argc, char **argv)
>  	char *progname;
>  	char *storagedir = CLD_DEFAULT_STORAGEDIR;
>  	struct cld_client clnt;
> +	char *s;
>  
>  	memset(&clnt, 0, sizeof(clnt));
>  
> @@ -653,6 +655,17 @@ main(int argc, char **argv)
>  	xlog_syslog(0);
>  	xlog_stderr(1);
>  
> +	conf_init_file(NFS_CONFFILE);
> +	s = conf_get_str("general", "pipefs-directory");
> +	if (s)
> +		strlcpy(pipefs_dir, s, sizeof(pipefs_dir));
> +	s = conf_get_str("nfsdcld", "storagedir");
> +	if (s)
> +		storagedir = s;
> +	rc = conf_get_num("nfsdcld", "debug", 0);
> +	if (rc > 0)
> +		xlog_config(D_ALL, 1);
> +
>  	/* process command-line options */
>  	while ((arg = getopt_long(argc, argv, "hdFp:s:", longopts,
>  				  NULL)) != EOF) {
> diff --git a/utils/nfsdcld/nfsdcld.man b/utils/nfsdcld/nfsdcld.man
> index b607ba6..c271d14 100644
> --- a/utils/nfsdcld/nfsdcld.man
> +++ b/utils/nfsdcld/nfsdcld.man
> @@ -163,6 +163,21 @@ Location of the rpc_pipefs filesystem. The default value is
>  .IX Item "-s storagedir, --storagedir=storage_dir"
>  Directory where stable storage information should be kept. The default
>  value is \fI/var/lib/nfs/nfsdcld\fR.
> +.SH "CONFIGURATION FILE"
> +.IX Header "CONFIGURATION FILE"
> +The following values are recognized in the \fB[nfsdcld]\fR section
> +of the \fI/etc/nfs.conf\fR configuration file:
> +.IP "\fBstoragedir\fR" 4
> +.IX Item "storagedir"
> +Equivalent to \fB\-s\fR/\fB\-\-storagedir\fR.
> +.IP "\fBdebug\fR" 4
> +.IX Item "debug"
> +Setting "debug = 1" is equivalent to \fB\-d\fR/\fB\-\-debug\fR.
> +.LP
> +In addition, the following value is recognized from the \fB[general]\fR section:
> +.IP "\fBpipefs\-directory\fR" 4
> +.IX Item "pipefs-directory"
> +Equivalent to \fB\-p\fR/\fB\-\-pipefsdir\fR.
>  .SH "NOTES"
>  .IX Header "NOTES"
>  The Linux kernel NFSv4 server has historically tracked this information
> -- 
> 2.17.2
> 

