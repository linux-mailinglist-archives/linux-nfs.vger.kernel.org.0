Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB8CDB113
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 17:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438683AbfJQP03 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Oct 2019 11:26:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438633AbfJQP03 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 17 Oct 2019 11:26:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC28810DCCA3
        for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2019 15:26:28 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-120-158.rdu2.redhat.com [10.10.120.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C81835C1D6;
        Thu, 17 Oct 2019 15:26:28 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 6F19720836; Thu, 17 Oct 2019 11:26:28 -0400 (EDT)
Date:   Thu, 17 Oct 2019 11:26:28 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH v3] gssd: daemonize earlier
Message-ID: <20191017152628.GA5017@coeurl.usersys.redhat.com.nfsv4bat.org>
References: <20191017150844.21045-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017150844.21045-1-smayhew@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Thu, 17 Oct 2019 15:26:28 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Note this is v1 patch.  I forgot to check my git config before creating
the patch :)

-Scott

On Thu, 17 Oct 2019, Scott Mayhew wrote:

> daemon_init() calls closeall() which closes all fd's >= 4.  This causes
> rpc.gssd to fail when it's configured to use the gssproxy interposer
> plugin (via "use-gss-proxy=1" in nfs.conf or GSS_USE_PROXY="yes" in the
> environment) *and* libtirpc debugging is enabled (i.e. at least one
> "-r" on the command line):
> 
> 1. During startup if rpc debugging is enabled then libtirpc_set_debug()
>    is called, which calls openlog() which consumes fd 3.
> 2. If the gssproxy interposer plugin is enabled then when
>    gssd_check_mechs() is called, a socket is created (fd 4) and
>    connected to /var/lib/gssproxy/default.sock.  The fd is stored
>    internally in a struct gpm_ctx.
> 3. daemon_init() runs and closes all fd's >= 4.
> 4. event_init() runs which calls epoll_create() which returns an epoll
>    fd of 4.
> 5. Later when handling an upcall, gssd calls gssd_acquire_krb5_cred()
>    which winds up closing the gpm_ctx->fd which was 4.
> 6. event_dispatch() calls epoll_wait() with epfd=4, and -EBADF is
>    returned.  gssd logs the message ""ERROR: event_dispatch() returned!"
>    and exits.
> 
> The solution is to call daemon_init() earlier.
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  utils/gssd/gssd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
> index 19ad4da..c38dedb 100644
> --- a/utils/gssd/gssd.c
> +++ b/utils/gssd/gssd.c
> @@ -1020,11 +1020,11 @@ main(int argc, char *argv[])
>  			    "support setting debug levels\n");
>  #endif
>  
> +	daemon_init(fg);
> +
>  	if (gssd_check_mechs() != 0)
>  		errx(1, "Problem with gssapi library");
>  
> -	daemon_init(fg);
> -
>  	event_init();
>  
>  	pipefs_dir = opendir(pipefs_path);
> -- 
> 2.17.2
> 
