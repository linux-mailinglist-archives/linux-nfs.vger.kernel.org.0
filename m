Return-Path: <linux-nfs+bounces-20936-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ9UJkAe4mlX1wAAu9opvQ
	(envelope-from <linux-nfs+bounces-20936-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 13:49:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4116841AEE8
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 13:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D5F0300E146
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 11:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF645359A91;
	Fri, 17 Apr 2026 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n31qkFQN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eID7hiG5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n31qkFQN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eID7hiG5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A6137104D
	for <linux-nfs@vger.kernel.org>; Fri, 17 Apr 2026 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776426553; cv=none; b=g0G3whwFBj4VGzdjIcx8yl+kO7+L0yRb/knKiNne+XiYSE72X1Giqgu2d6Ior8VwE7NLLswTjHWwYcjYxwIkFRrm+Mwk1SGnBk1CLVtrOtKPMuEXY+E0f5/kMlrdQFrqoBKXoKVg7AlO5jsqk+KUkquaAJomWZj5GsfYfHcIyjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776426553; c=relaxed/simple;
	bh=2x6+8s34PRmlb2i1C2cRqcX+jSonW6TTU5dV5+6DUGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGYnPuHpuLeFLDuP7dUm+4v8jHOdViC6AwJzywmCI0w9YUO7PUXqVvMV8q8keAh0O1iaZhir9j9SUgtMNr5aF6ZY6kDVHMgHoW0daPGml9sqsxJvtNOw+aSf3BDo6sAx7UEZcMB5l94PJ472XTn0qxS+J2d+UiFevPyC/RODr2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n31qkFQN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eID7hiG5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n31qkFQN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eID7hiG5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46C286A9B1;
	Fri, 17 Apr 2026 11:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776426550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZV4dgGno8T+BMRZOHPUxoxlD1b4AiTZswKVYJ9iPYc=;
	b=n31qkFQNRlYZbASOMDRZF5zJ7mQdileibiPoRD1I8D5OWgUY0IVttv9KhxmQHI6RQPpD6N
	f9F2PhxqgPFuQr0tFnlzQyR2p73rBVJ6s3Rf2fP+DJFdZH+DBqWtdVAMyxR+xBX++En12l
	wHLfqXeZzuDVQ/+PkukkaOXVxG//81Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776426550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZV4dgGno8T+BMRZOHPUxoxlD1b4AiTZswKVYJ9iPYc=;
	b=eID7hiG5ktoaVW8toHbXDb4ESA/AOLc28mgeLds/UVyAGueWFmUexKVDviF7/S6wKmJDM8
	6eLjOqQznYqX/0BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776426550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZV4dgGno8T+BMRZOHPUxoxlD1b4AiTZswKVYJ9iPYc=;
	b=n31qkFQNRlYZbASOMDRZF5zJ7mQdileibiPoRD1I8D5OWgUY0IVttv9KhxmQHI6RQPpD6N
	f9F2PhxqgPFuQr0tFnlzQyR2p73rBVJ6s3Rf2fP+DJFdZH+DBqWtdVAMyxR+xBX++En12l
	wHLfqXeZzuDVQ/+PkukkaOXVxG//81Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776426550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZV4dgGno8T+BMRZOHPUxoxlD1b4AiTZswKVYJ9iPYc=;
	b=eID7hiG5ktoaVW8toHbXDb4ESA/AOLc28mgeLds/UVyAGueWFmUexKVDviF7/S6wKmJDM8
	6eLjOqQznYqX/0BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27725593AE;
	Fri, 17 Apr 2026 11:49:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id teyWCTYe4mnZBwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 17 Apr 2026 11:49:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D3DBBA0B77; Fri, 17 Apr 2026 13:49:09 +0200 (CEST)
Date: Fri, 17 Apr 2026 13:49:09 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Calum Mackay <calum.mackay@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 05/28] fsnotify: new tracepoint in fsnotify()
Message-ID: <64g3qra4l7o2xm37yo3fwenbob3gdyzxdptzeabzuceegkaips@lj7ulfaltfkl>
References: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
 <20260416-dir-deleg-v2-5-851426a550f6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416-dir-deleg-v2-5-851426a550f6@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20936-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4116841AEE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu 16-04-26 10:35:06, Jeff Layton wrote:
> Add a tracepoint so we can see exactly how this is being called.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/fsnotify.c            |  5 ++++
>  include/trace/events/fsnotify.h | 51 +++++++++++++++++++++++++++++++++++++++++
>  include/trace/misc/fsnotify.h   | 35 ++++++++++++++++++++++++++++
>  3 files changed, 91 insertions(+)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 9995de1710e5..5448738635f6 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -14,6 +14,9 @@
>  #include <linux/fsnotify_backend.h>
>  #include "fsnotify.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/fsnotify.h>
> +
>  /*
>   * Clear all of the marks on an inode when it is being evicted from core
>   */
> @@ -504,6 +507,8 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>  	int ret = 0;
>  	__u32 test_mask, marks_mask = 0;
>  
> +	trace_fsnotify(mask, data, data_type, dir, file_name, inode, cookie);
> +
>  	if (path)
>  		mnt = real_mount(path->mnt);
>  
> diff --git a/include/trace/events/fsnotify.h b/include/trace/events/fsnotify.h
> new file mode 100644
> index 000000000000..341bbd57a39b
> --- /dev/null
> +++ b/include/trace/events/fsnotify.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM fsnotify
> +
> +#if !defined(_TRACE_FSNOTIFY_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_FSNOTIFY_H
> +
> +#include <linux/tracepoint.h>
> +
> +#include <trace/misc/fsnotify.h>
> +
> +TRACE_EVENT(fsnotify,
> +	TP_PROTO(__u32 mask, const void *data, int data_type,
> +		 struct inode *dir, const struct qstr *file_name,
> +		 struct inode *inode, u32 cookie),
> +
> +	TP_ARGS(mask, data, data_type, dir, file_name, inode, cookie),
> +
> +	TP_STRUCT__entry(
> +		__field(__u32, mask)
> +		__field(unsigned long, dir_ino)
> +		__field(unsigned long, ino)
> +		__field(dev_t, s_dev)
> +		__field(int, data_type)
> +		__field(u32, cookie)
> +		__string(file_name, file_name ? (const char *)file_name->name : "")
> +	),
> +
> +	TP_fast_assign(
> +		__entry->mask = mask;
> +		__entry->dir_ino = dir ? dir->i_ino : 0;
> +		__entry->ino = inode ? inode->i_ino : 0;
> +		__entry->s_dev = dir ? dir->i_sb->s_dev :
> +				 inode ? inode->i_sb->s_dev : 0;
> +		__entry->data_type = data_type;
> +		__entry->cookie = cookie;
> +		__assign_str(file_name);
> +	),
> +
> +	TP_printk("dev=%d:%d dir=%lu ino=%lu data_type=%d cookie=0x%x mask=0x%x %s name=%s",
> +		  MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
> +		  __entry->dir_ino, __entry->ino,
> +		  __entry->data_type, __entry->cookie,
> +		  __entry->mask, show_fsnotify_mask(__entry->mask),
> +		  __get_str(file_name))
> +);
> +
> +#endif /* _TRACE_FSNOTIFY_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/include/trace/misc/fsnotify.h b/include/trace/misc/fsnotify.h
> new file mode 100644
> index 000000000000..a201e1bd6d8c
> --- /dev/null
> +++ b/include/trace/misc/fsnotify.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Display helpers for fsnotify events
> + */
> +
> +#include <linux/fsnotify_backend.h>
> +
> +#define show_fsnotify_mask(mask) \
> +	__print_flags(mask, "|", \
> +		{ FS_ACCESS,		"ACCESS" }, \
> +		{ FS_MODIFY,		"MODIFY" }, \
> +		{ FS_ATTRIB,		"ATTRIB" }, \
> +		{ FS_CLOSE_WRITE,	"CLOSE_WRITE" }, \
> +		{ FS_CLOSE_NOWRITE,	"CLOSE_NOWRITE" }, \
> +		{ FS_OPEN,		"OPEN" }, \
> +		{ FS_MOVED_FROM,	"MOVED_FROM" }, \
> +		{ FS_MOVED_TO,		"MOVED_TO" }, \
> +		{ FS_CREATE,		"CREATE" }, \
> +		{ FS_DELETE,		"DELETE" }, \
> +		{ FS_DELETE_SELF,	"DELETE_SELF" }, \
> +		{ FS_MOVE_SELF,		"MOVE_SELF" }, \
> +		{ FS_OPEN_EXEC,		"OPEN_EXEC" }, \
> +		{ FS_UNMOUNT,		"UNMOUNT" }, \
> +		{ FS_Q_OVERFLOW,	"Q_OVERFLOW" }, \
> +		{ FS_ERROR,		"ERROR" }, \
> +		{ FS_OPEN_PERM,		"OPEN_PERM" }, \
> +		{ FS_ACCESS_PERM,	"ACCESS_PERM" }, \
> +		{ FS_OPEN_EXEC_PERM,	"OPEN_EXEC_PERM" }, \
> +		{ FS_PRE_ACCESS,	"PRE_ACCESS" }, \
> +		{ FS_MNT_ATTACH,	"MNT_ATTACH" }, \
> +		{ FS_MNT_DETACH,	"MNT_DETACH" }, \
> +		{ FS_EVENT_ON_CHILD,	"EVENT_ON_CHILD" }, \
> +		{ FS_RENAME,		"RENAME" }, \
> +		{ FS_DN_MULTISHOT,	"DN_MULTISHOT" }, \
> +		{ FS_ISDIR,		"ISDIR" })
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

