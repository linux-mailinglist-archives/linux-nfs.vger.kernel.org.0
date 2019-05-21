Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E11F254AB
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2019 17:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfEUP6W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 May 2019 11:58:22 -0400
Received: from fieldses.org ([173.255.197.46]:57922 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbfEUP6W (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 21 May 2019 11:58:22 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id B4F011CEE; Tue, 21 May 2019 11:58:21 -0400 (EDT)
Date:   Tue, 21 May 2019 11:58:21 -0400
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Xuewei Zhang <xueweiz@google.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] Revert "lockd: Show pid of lockd for remote locks"
Message-ID: <20190521155821.GD9499@fieldses.org>
References: <952928a350da64fd8de3e1a79deb8cc23552972f.1558362681.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <952928a350da64fd8de3e1a79deb8cc23552972f.1558362681.git.bcodding@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 20, 2019 at 10:33:07AM -0400, Benjamin Coddington wrote:
> This reverts most of commit b8eee0e90f97 ("lockd: Show pid of lockd for
> remote locks"), which caused remote locks to not be differentiated between
> remote processes for NLM.

To make sure I understand: I assume a client resolves conflicts among
its own processes before involving the server, so the server only needs
to resolve conflicts among nlm_hosts.  Is that right?  So the only
practical affect is the missing grant callbacks that Xuewei noticed?

Or is my assumption not true in general?  Or is it true only for some
client implementations?

--b.

> 
> We retain the fixup for setting the client's fl_pid to a negative value.
> 
> Fixes: b8eee0e90f97 ("lockd: Show pid of lockd for remote locks")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/lockd/xdr.c  | 4 ++--
>  fs/lockd/xdr4.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
> index 9846f7e95282..7147e4aebecc 100644
> --- a/fs/lockd/xdr.c
> +++ b/fs/lockd/xdr.c
> @@ -127,7 +127,7 @@ nlm_decode_lock(__be32 *p, struct nlm_lock *lock)
>  
>  	locks_init_lock(fl);
>  	fl->fl_owner = current->files;
> -	fl->fl_pid   = current->tgid;
> +	fl->fl_pid   = (pid_t)lock->svid;
>  	fl->fl_flags = FL_POSIX;
>  	fl->fl_type  = F_RDLCK;		/* as good as anything else */
>  	start = ntohl(*p++);
> @@ -269,7 +269,7 @@ nlmsvc_decode_shareargs(struct svc_rqst *rqstp, __be32 *p)
>  	memset(lock, 0, sizeof(*lock));
>  	locks_init_lock(&lock->fl);
>  	lock->svid = ~(u32) 0;
> -	lock->fl.fl_pid = current->tgid;
> +	lock->fl.fl_pid = (pid_t)lock->svid;
>  
>  	if (!(p = nlm_decode_cookie(p, &argp->cookie))
>  	 || !(p = xdr_decode_string_inplace(p, &lock->caller,
> diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
> index 70154f376695..7ed9edf9aed4 100644
> --- a/fs/lockd/xdr4.c
> +++ b/fs/lockd/xdr4.c
> @@ -119,7 +119,7 @@ nlm4_decode_lock(__be32 *p, struct nlm_lock *lock)
>  
>  	locks_init_lock(fl);
>  	fl->fl_owner = current->files;
> -	fl->fl_pid   = current->tgid;
> +	fl->fl_pid   = (pid_t)lock->svid;
>  	fl->fl_flags = FL_POSIX;
>  	fl->fl_type  = F_RDLCK;		/* as good as anything else */
>  	p = xdr_decode_hyper(p, &start);
> @@ -266,7 +266,7 @@ nlm4svc_decode_shareargs(struct svc_rqst *rqstp, __be32 *p)
>  	memset(lock, 0, sizeof(*lock));
>  	locks_init_lock(&lock->fl);
>  	lock->svid = ~(u32) 0;
> -	lock->fl.fl_pid = current->tgid;
> +	lock->fl.fl_pid = (pid_t)lock->svid;
>  
>  	if (!(p = nlm4_decode_cookie(p, &argp->cookie))
>  	 || !(p = xdr_decode_string_inplace(p, &lock->caller,
> -- 
> 2.20.1
