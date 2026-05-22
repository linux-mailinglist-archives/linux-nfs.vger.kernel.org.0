Return-Path: <linux-nfs+bounces-21807-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCPgJK11EGoZXgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21807-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 17:26:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6725B6DCB
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 17:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 299BC3071B63
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C369D43CECD;
	Fri, 22 May 2026 14:31:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9679C4218A5;
	Fri, 22 May 2026 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779460288; cv=none; b=ERXvPSw0IA02/FEPDtyfqBrW91qLPoWcmz6jR8deruajexlLm59rOCvpOSFiGDQIlmMITkEBYljm9DR6c9SUqAQEuFEZu3OVG7A9cwsJavOn4z8WBIsJfiY08S5JmxfGL8cHLcCmBydFIElLldsWdMo3j29lnqwOUcPFj6L8Tmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779460288; c=relaxed/simple;
	bh=HuCwUi/7uO46kT1qwJq0hEJtdMEHa0AgvWi1UReZ1Po=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVOFJSvr3SmvIcyvAAqM0hTMBxB6aueAXByzokM6HO5Ud1W/vNSNMqgPXB04B7pyu8Ea8vmjaOrHQMUBnUUE66tW4p9Uz4LaKDtWxVur/fyoY4uewLL6f8Wh6u/Oepx0NC44MlkRY2mfMJCsAGuKOrpbbcJkIE3E1KJFn/e3SJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 0AB021407E6;
	Fri, 22 May 2026 14:31:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 65B5220027;
	Fri, 22 May 2026 14:31:08 +0000 (UTC)
Date: Fri, 22 May 2026 10:31:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>, Alexander Aring <alex.aring@gmail.com>, Amir
 Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Calum
 Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 11/21] nfsd: add tracepoint to dir_event handler
Message-ID: <20260522103131.080908fc@gandalf.local.home>
In-Reply-To: <20260522-dir-deleg-v4-11-2acb883ac6bc@kernel.org>
References: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
	<20260522-dir-deleg-v4-11-2acb883ac6bc@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: oc4per67rmyow4fptwqcwqmbnptpbm8x
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/j7aqctpg9NW2tR4A8PFF+/r4vzAO23pU=
X-HE-Tag: 1779460268-493531
X-HE-Meta: U2FsdGVkX1980suR8vYXPXd8kAHBWSTcK55rwb76Mgvgewo0jZMr8NP2QwbyW/W9cHeMv1c3bAMVgZH9FNJFf1qT7n/hNIM0Fsx/AgtJeiyk3wsXkwfKuyuf2+SArmvHmoIrTL+K9anGCXeKfvDPUr+iJyfnUtthWNttkPoVg2OHRGD2qp58vPH0KRBb51QuL6zxibUvVybbnzOurXe82g1UySpoiEKbh5KTNeQ9K0A4qE4JDrKLIbl72oigNfZoCQv32gOafSfy9CPAM8jZb2ZCbPxUPsn0w4mFK4cj0PT+cov1eIiEwhUGG6OES/HX+6UxuZGT5Kz0C9WrJvM01Z+A9SonK8xdytCljhRP+bRFsbJYMLmwdnyv9MbY1j5iXjynnBQpnCzZrzzgTJimTw==
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21807-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,brown.name,redhat.com,talpey.com,kernel.org,gmail.com,suse.cz,zeniv.linux.org.uk,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.971];
	TAGGED_RCPT(0.00)[linux-nfs];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,gandalf.local.home:mid]
X-Rspamd-Queue-Id: 9D6725B6DCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 08:29:00 -0400
Jeff Layton <jlayton@kernel.org> wrote:

> Add some extra visibility around the fsnotify handlers.
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4state.c |  2 ++
>  fs/nfsd/trace.h     | 22 ++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 3afde2e91efe..8d73203297e5 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -10032,6 +10032,8 @@ nfsd_handle_dir_event(u32 mask, const struct inode *dir, const void *data,
>  	struct file_lock_core *flc;
>  	struct nfsd_notify_event *evt;
>  
> +	trace_nfsd_handle_dir_event(mask, dir, name);
> +
>  	/* Normalize cross-dir rename events to create/delete */
>  	if (mask & FS_MOVED_FROM) {
>  		mask &= ~FS_MOVED_FROM;
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index ebf5677c4e73..e8e121a52e82 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -12,6 +12,7 @@
>  #include <linux/sunrpc/clnt.h>
>  #include <linux/sunrpc/xprt.h>
>  #include <trace/misc/fs.h>
> +#include <trace/misc/fsnotify.h>
>  #include <trace/misc/nfs.h>
>  #include <trace/misc/sunrpc.h>
>  
> @@ -1377,6 +1378,27 @@ TRACE_EVENT(nfsd_file_fsnotify_handle_event,
>  			__entry->nlink, __entry->mode, __entry->mask)
>  );
>  
> +TRACE_EVENT(nfsd_handle_dir_event,
> +	TP_PROTO(u32 mask, const struct inode *dir, const struct qstr *name),
> +	TP_ARGS(mask, dir, name),
> +	TP_STRUCT__entry(
> +		__field(u32, mask)
> +		__field(dev_t, s_dev)
> +		__field(ino_t, i_ino)
> +		__string_len(name, name->name, name->len)
> +	),
> +	TP_fast_assign(
> +		__entry->mask = mask;
> +		__entry->s_dev = dir->i_sb->s_dev;
> +		__entry->i_ino = dir->i_ino;
> +		__assign_str(name);
> +	),
> +	TP_printk("inode=0x%x:0x%x:0x%lx mask=%s name=%s",
> +			MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
> +			__entry->i_ino, show_fsnotify_mask(__entry->mask),

Hmm, I don't have the show_fsnotify_mask() function in my repos and don't
see it defined in the patch series (I scanned lore).

Have a link to the patch or repo that creates it?

-- Steve


> +			__get_str(name))
> +);
> +
>  DECLARE_EVENT_CLASS(nfsd_file_gc_class,
>  	TP_PROTO(
>  		const struct nfsd_file *nf
> 


