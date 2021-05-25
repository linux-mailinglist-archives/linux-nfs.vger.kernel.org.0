Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4ADD390AF1
	for <lists+linux-nfs@lfdr.de>; Tue, 25 May 2021 22:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhEYVAS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 May 2021 17:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbhEYVAS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 May 2021 17:00:18 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03984C061574
        for <linux-nfs@vger.kernel.org>; Tue, 25 May 2021 13:58:47 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id EA1886851; Tue, 25 May 2021 16:58:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org EA1886851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1621976325;
        bh=MiJl6qZD3NtAnrAn17UrmtlClz5d7dAYh/kY9Ifi1As=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=luBb1phnpRjxwKBnOsxPkH1AWV+udq+EYwT0rfbF1oEpD5AZ0aY8cOUWRB2JgPdhs
         p2eiFHg1rhzNaNt+UVTAEWzcvbhSk59LKl1KIz2GvS25wLCO4lvdryGgAGBFT5Hv9z
         V0xjUO1nH6eomkBXQsZys7JkBXggyOXWnWzuD6Yw=
Date:   Tue, 25 May 2021 16:58:45 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nfsd4: Expose the callback address and state of
 each NFS4 client
Message-ID: <20210525205845.GB4162@fieldses.org>
References: <1621283385-24390-1-git-send-email-dwysocha@redhat.com>
 <1621283385-24390-2-git-send-email-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621283385-24390-2-git-send-email-dwysocha@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When I run trace-cmd report I get output like:

  [nfsd:nfsd_cb_state] function cb_state2str not defined
  [nfsd:nfsd_cb_shutdown] function cb_state2str not defined
  [nfsd:nfsd_cb_probe] function cb_state2str not defined
  [nfsd:nfsd_cb_lost] function cb_state2str not defined

I don't know how this is supposed to work.  Is it OK for tracepoint definitions
to reference kernel functions if they're defined in the right way somehow?  If
not, I don't know what the solution would be for sharing this--define a macro
that expands to the array literal and use that in both places?  Or maybe just
live with the the redundancy.

--b.

On Mon, May 17, 2021 at 04:29:45PM -0400, Dave Wysochanski wrote:
> In addition to the client's address, display the callback channel
> state and address in the 'info' file.  Define and use a common
> function for this information that can be used by both callback
> trace events and the NFS4 client 'info' file.
> 
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> ---
>  fs/nfsd/nfs4state.c |  2 ++
>  fs/nfsd/trace.c     | 15 +++++++++++++++
>  fs/nfsd/trace.h     |  9 ++-------
>  3 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b2573d3ecd3c..f3b8221bb543 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2385,6 +2385,8 @@ static int client_info_show(struct seq_file *m, void *v)
>  		seq_printf(m, "\nImplementation time: [%lld, %ld]\n",
>  			clp->cl_nii_time.tv_sec, clp->cl_nii_time.tv_nsec);
>  	}
> +	seq_printf(m, "callback state: %s\n", cb_state2str(clp->cl_cb_state));
> +	seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
>  	drop_client(clp);
>  
>  	return 0;
> diff --git a/fs/nfsd/trace.c b/fs/nfsd/trace.c
> index f008b95ceec2..6291b5d10824 100644
> --- a/fs/nfsd/trace.c
> +++ b/fs/nfsd/trace.c
> @@ -2,3 +2,18 @@
>  
>  #define CREATE_TRACE_POINTS
>  #include "trace.h"
> +
> +const char *cb_state2str(const int state)
> +{
> +	switch (state) {
> +	case NFSD4_CB_UP:
> +		return "UP";
> +	case NFSD4_CB_UNKNOWN:
> +		return "UNKNOWN";
> +	case NFSD4_CB_DOWN:
> +		return "DOWN";
> +	case NFSD4_CB_FAULT:
> +		return "FAULT";
> +	}
> +	return "UNDEFINED";
> +}
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 10cc3aaf1089..8908d48b2aa6 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -876,12 +876,7 @@
>  	TP_printk("client %08x:%08x", __entry->cl_boot, __entry->cl_id)
>  )
>  
> -#define show_cb_state(val)						\
> -	__print_symbolic(val,						\
> -		{ NFSD4_CB_UP,		"UP" },				\
> -		{ NFSD4_CB_UNKNOWN,	"UNKNOWN" },			\
> -		{ NFSD4_CB_DOWN,	"DOWN" },			\
> -		{ NFSD4_CB_FAULT,	"FAULT"})
> +const char *cb_state2str(const int state);
>  
>  DECLARE_EVENT_CLASS(nfsd_cb_class,
>  	TP_PROTO(const struct nfs4_client *clp),
> @@ -901,7 +896,7 @@
>  	),
>  	TP_printk("addr=%pISpc client %08x:%08x state=%s",
>  		__entry->addr, __entry->cl_boot, __entry->cl_id,
> -		show_cb_state(__entry->state))
> +		cb_state2str(__entry->state))
>  );
>  
>  #define DEFINE_NFSD_CB_EVENT(name)			\
> -- 
> 1.8.3.1
