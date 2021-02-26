Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D44326474
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Feb 2021 16:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhBZPCI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Feb 2021 10:02:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55460 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229535AbhBZPCH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Feb 2021 10:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614351641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DCvRIc6aFyDWWBSHSRb4uuO8gchdZno7LFN7Leg6qNQ=;
        b=Hv78KcfoBgClGINgzOxYutr123AeP0O/f+T+s0kpcBdUYi06uz5saz+pQuF1YbGhpRbX4D
        pLuNsOljOmueGdjLoQPxJdEwxG5vwZkO92KDsVN7G94SnGgCXGaK6+UkhSAeVRbRRkg5um
        NH4eOyY6QtwOC0ppC5yVr7iTw5TXh9U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-pJ3hftgcMNej6d5E3QjHUA-1; Fri, 26 Feb 2021 10:00:39 -0500
X-MC-Unique: pJ3hftgcMNej6d5E3QjHUA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0DFC801975;
        Fri, 26 Feb 2021 15:00:37 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-114-99.rdu2.redhat.com [10.10.114.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2817A1001E73;
        Fri, 26 Feb 2021 15:00:37 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 34808120400; Fri, 26 Feb 2021 10:00:36 -0500 (EST)
Date:   Fri, 26 Feb 2021 10:00:36 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] Repair misuse of sv_lock in 5.10.16-rt30.
Message-ID: <YDkNFKmzb7rbumYf@pick.fieldses.org>
References: <20210226143820.GA49043@zipoli.concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226143820.GA49043@zipoli.concurrent-rt.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Adding Chuck, linux-nfs.

Makes sense to me.--b.

On Fri, Feb 26, 2021 at 09:38:20AM -0500, Joe Korty wrote:
> Repair misuse of sv_lock in 5.10.16-rt30.
> 
> [ This problem is in mainline, but only rt has the chops to be
> able to detect it. ]
> 
> Lockdep reports a circular lock dependency between serv->sv_lock and
> softirq_ctl.lock on system shutdown, when using a kernel built with
> CONFIG_PREEMPT_RT=y, and a nfs mount exists.
> 
> This is due to the definition of spin_lock_bh on rt:
> 
> 	local_bh_disable();
> 	rt_spin_lock(lock);
> 
> which forces a softirq_ctl.lock -> serv->sv_lock dependency.  This is
> not a problem as long as _every_ lock of serv->sv_lock is a:
> 
> 	spin_lock_bh(&serv->sv_lock);
> 
> but there is one of the form:
> 
> 	spin_lock(&serv->sv_lock);
> 
> This is what is causing the circular dependency splat.  The spin_lock()
> grabs the lock without first grabbing softirq_ctl.lock via local_bh_disable.
> If later on in the critical region,  someone does a local_bh_disable, we
> get a serv->sv_lock -> softirq_ctrl.lock dependency established.  Deadlock.
> 
> Fix is to make serv->sv_lock be locked with spin_lock_bh everywhere, no
> exceptions.
> 
> Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com>
> 
> 
> 
> 
> [  OK  ] Stopped target NFS client services.
>          Stopping Logout off all iSCSI sessions on shutdown...
>          Stopping NFS server and services...
> [  109.442380] 
> [  109.442385] ======================================================
> [  109.442386] WARNING: possible circular locking dependency detected
> [  109.442387] 5.10.16-rt30 #1 Not tainted
> [  109.442389] ------------------------------------------------------
> [  109.442390] nfsd/1032 is trying to acquire lock:
> [  109.442392] ffff994237617f60 ((softirq_ctrl.lock).lock){+.+.}-{2:2}, at: __local_bh_disable_ip+0xd9/0x270
> [  109.442405] 
> [  109.442405] but task is already holding lock:
> [  109.442406] ffff994245cb00b0 (&serv->sv_lock){+.+.}-{0:0}, at: svc_close_list+0x1f/0x90
> [  109.442415] 
> [  109.442415] which lock already depends on the new lock.
> [  109.442415] 
> [  109.442416] 
> [  109.442416] the existing dependency chain (in reverse order) is:
> [  109.442417] 
> [  109.442417] -> #1 (&serv->sv_lock){+.+.}-{0:0}:
> [  109.442421]        rt_spin_lock+0x2b/0xc0
> [  109.442428]        svc_add_new_perm_xprt+0x42/0xa0
> [  109.442430]        svc_addsock+0x135/0x220
> [  109.442434]        write_ports+0x4b3/0x620
> [  109.442438]        nfsctl_transaction_write+0x45/0x80
> [  109.442440]        vfs_write+0xff/0x420
> [  109.442444]        ksys_write+0x4f/0xc0
> [  109.442446]        do_syscall_64+0x33/0x40
> [  109.442450]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  109.442454] 
> [  109.442454] -> #0 ((softirq_ctrl.lock).lock){+.+.}-{2:2}:
> [  109.442457]        __lock_acquire+0x1264/0x20b0
> [  109.442463]        lock_acquire+0xc2/0x400
> [  109.442466]        rt_spin_lock+0x2b/0xc0
> [  109.442469]        __local_bh_disable_ip+0xd9/0x270
> [  109.442471]        svc_xprt_do_enqueue+0xc0/0x4d0
> [  109.442474]        svc_close_list+0x60/0x90
> [  109.442476]        svc_close_net+0x49/0x1a0
> [  109.442478]        svc_shutdown_net+0x12/0x40
> [  109.442480]        nfsd_destroy+0xc5/0x180
> [  109.442482]        nfsd+0x1bc/0x270
> [  109.442483]        kthread+0x194/0x1b0
> [  109.442487]        ret_from_fork+0x22/0x30
> [  109.442492] 
> [  109.442492] other info that might help us debug this:
> [  109.442492] 
> [  109.442493]  Possible unsafe locking scenario:
> [  109.442493] 
> [  109.442493]        CPU0                    CPU1
> [  109.442494]        ----                    ----
> [  109.442495]   lock(&serv->sv_lock);
> [  109.442496]                                lock((softirq_ctrl.lock).lock);
> [  109.442498]                                lock(&serv->sv_lock);
> [  109.442499]   lock((softirq_ctrl.lock).lock);
> [  109.442501] 
> [  109.442501]  *** DEADLOCK ***
> [  109.442501] 
> [  109.442501] 3 locks held by nfsd/1032:
> [  109.442503]  #0: ffffffff93b49258 (nfsd_mutex){+.+.}-{3:3}, at: nfsd+0x19a/0x270
> [  109.442508]  #1: ffff994245cb00b0 (&serv->sv_lock){+.+.}-{0:0}, at: svc_close_list+0x1f/0x90
> [  109.442512]  #2: ffffffff93a81b20 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock+0x5/0xc0
> [  109.442518] 
> [  109.442518] stack backtrace:
> [  109.442519] CPU: 0 PID: 1032 Comm: nfsd Not tainted 5.10.16-rt30 #1
> [  109.442522] Hardware name: Supermicro X9DRL-3F/iF/X9DRL-3F/iF, BIOS 3.2 09/22/2015
> [  109.442524] Call Trace:
> [  109.442527]  dump_stack+0x77/0x97
> [  109.442533]  check_noncircular+0xdc/0xf0
> [  109.442546]  __lock_acquire+0x1264/0x20b0
> [  109.442553]  lock_acquire+0xc2/0x400
> [  109.442564]  rt_spin_lock+0x2b/0xc0
> [  109.442570]  __local_bh_disable_ip+0xd9/0x270
> [  109.442573]  svc_xprt_do_enqueue+0xc0/0x4d0
> [  109.442577]  svc_close_list+0x60/0x90
> [  109.442581]  svc_close_net+0x49/0x1a0
> [  109.442585]  svc_shutdown_net+0x12/0x40
> [  109.442588]  nfsd_destroy+0xc5/0x180
> [  109.442590]  nfsd+0x1bc/0x270
> [  109.442595]  kthread+0x194/0x1b0
> [  109.442600]  ret_from_fork+0x22/0x30
> [  109.518225] nfsd: last server has exited, flushing export cache
> [  OK  ] Stopped NFSv4 ID-name mapping service.
> [  OK  ] Stopped GSSAPI Proxy Daemon.
> [  OK  ] Stopped NFS Mount Daemon.
> [  OK  ] Stopped NFS status monitor for NFSv2/3 locking..
> Index: b/net/sunrpc/svc_xprt.c
> ===================================================================
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -1062,7 +1062,7 @@ static int svc_close_list(struct svc_ser
>  	struct svc_xprt *xprt;
>  	int ret = 0;
>  
> -	spin_lock(&serv->sv_lock);
> +	spin_lock_bh(&serv->sv_lock);
>  	list_for_each_entry(xprt, xprt_list, xpt_list) {
>  		if (xprt->xpt_net != net)
>  			continue;
> @@ -1070,7 +1070,7 @@ static int svc_close_list(struct svc_ser
>  		set_bit(XPT_CLOSE, &xprt->xpt_flags);
>  		svc_xprt_enqueue(xprt);
>  	}
> -	spin_unlock(&serv->sv_lock);
> +	spin_unlock_bh(&serv->sv_lock);
>  	return ret;
>  }
>  
> 

