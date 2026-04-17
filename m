Return-Path: <linux-nfs+bounces-20937-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNIIBHog4mlX1wAAu9opvQ
	(envelope-from <linux-nfs+bounces-20937-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 13:58:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C2441AFFD
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 13:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1361B303638E
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 11:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4171396560;
	Fri, 17 Apr 2026 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JrY43o6X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m+x+5RrY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JVLsXN0E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IiAHLP/q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E65344030
	for <linux-nfs@vger.kernel.org>; Fri, 17 Apr 2026 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776427022; cv=none; b=EA9fhDzzMnjVaH9+1YahJY57Der8b3iI8+OgnRBrVbSpIA94YIm20iJtEcbBgUYaxhx8Bh4Sh7CMubO3gmfr/2BG2/BT28giMyrIPheAnC86anbF3zQqhhdJHmbB9HUo4ukAWaEs7DzTB45W2MSxnuNvLw1VdYLGiBbIU23l6cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776427022; c=relaxed/simple;
	bh=/9hByDEs1tZsUl/bDPSgLnO/m2DCUNXsUDzm566x2cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyS2uXfmwA8NuCUNVwFJsj46NnbMMlAI/jqUMBTrgfKfJ6qLNGJNQzP6emcA10UYnVqA4sjDsXdGnDKC5kZs7sN9EPZEhMDsxm8j0J8EHOFIUe+iVK/NaAtnVD2MJO3/tehLs9tDacccp9lUcK3WCnYjV3kFS2kTAl1FTSQcRM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JrY43o6X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m+x+5RrY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JVLsXN0E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IiAHLP/q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5BC286A9B2;
	Fri, 17 Apr 2026 11:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776427018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GGB/8ndmkq0nQUxUya+Cz2jubXI4ei3cKlGky0eSZKE=;
	b=JrY43o6Xe1ofNqWi4bvLBzThTEXmBrvj5V3MwYPNpvICe4DNVCt2qnUtLTs/4tzIjwuXmj
	GDlfU4KhmPh1x7kKYpJRd7Ai/Cej3v/cL4CjD/TXZu5JgJbaFVj8ZKbkZ/EE5sEUTepDX+
	vOVJEBV5zF7L+5RBJ1csivlWzDmrQMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776427018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GGB/8ndmkq0nQUxUya+Cz2jubXI4ei3cKlGky0eSZKE=;
	b=m+x+5RrYcxeAH96bGN38/97b28DjQa4nIelb+rRiMRrHNy5Vxy7nPaMggllU050bL9+hdg
	Dr/O37z373X7/2AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JVLsXN0E;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="IiAHLP/q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776427014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GGB/8ndmkq0nQUxUya+Cz2jubXI4ei3cKlGky0eSZKE=;
	b=JVLsXN0EPcZio2K42RMPet6VIJxxtGhRo3aUATTs3cOHrhVjKPwIyI5b+ua13mb0DGmtYq
	5qy/LIF5vL4/lr4crEuy8E3tsx91iOLRpSbyFahjV2HR/596HVKHg01MO9M/bUcFZJlt+W
	QgBJcRH6ntnpQSmu2UxOLGjERmW+bkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776427014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GGB/8ndmkq0nQUxUya+Cz2jubXI4ei3cKlGky0eSZKE=;
	b=IiAHLP/qnnnxEzLkM4lqfzwmD9R4dBhIgE50hF/3FUm1y/Q+l/xrvk4BHxmZNbhjxOR4Gr
	wumBQErEmRI4CYDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41B8F593AE;
	Fri, 17 Apr 2026 11:56:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6qsJEAYg4mmFDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 17 Apr 2026 11:56:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B8434A0B77; Fri, 17 Apr 2026 13:56:45 +0200 (CEST)
Date: Fri, 17 Apr 2026 13:56:45 +0200
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
Subject: Re: [PATCH v2 07/28] fsnotify: add FSNOTIFY_EVENT_RENAME data type
Message-ID: <njcjrskw4lfsjn7pjfan4xyqmk37jzlc5amgc7snbhpsrbsdnq@mawp7fdkczrk>
References: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
 <20260416-dir-deleg-v2-7-851426a550f6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416-dir-deleg-v2-7-851426a550f6@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20937-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 66C2441AFFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu 16-04-26 10:35:08, Jeff Layton wrote:
> Add a new fsnotify_rename_data struct and FSNOTIFY_EVENT_RENAME data
> type that carries both the moved dentry and the inode that was
> overwritten by the rename (if any).
> 
> Update fsnotify_data_inode(), fsnotify_data_dentry(), and
> fsnotify_data_sb() to handle the new type, and add a new
> fsnotify_data_rename_target() helper for extracting the overwritten
> target inode.
> 
> Update fsnotify_move() to use the new data type for FS_RENAME and
> FS_MOVED_TO events, passing the overwritten target inode through the
> event data. FS_MOVED_FROM is unchanged since the source directory
> doesn't need overwrite information.
> 
> This is done so that fsnotify consumers like nfsd can atomically
> observe the overwritten file when a rename replaces an existing entry,
> without needing a separate FS_DELETE event.
> 
> Assisted-by: Claude (Anthropic Claude Code)
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fsnotify.h         |  8 ++++++--
>  include/linux/fsnotify_backend.h | 20 ++++++++++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 079c18bcdbde..bda798bc67bc 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -257,6 +257,10 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
>  	__u32 new_dir_mask = FS_MOVED_TO;
>  	__u32 rename_mask = FS_RENAME;
>  	const struct qstr *new_name = &moved->d_name;
> +	struct fsnotify_rename_data rd = {
> +		.moved = moved,
> +		.target = target,
> +	};
>  
>  	if (isdir) {
>  		old_dir_mask |= FS_ISDIR;
> @@ -265,12 +269,12 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
>  	}
>  
>  	/* Event with information about both old and new parent+name */
> -	fsnotify_name(rename_mask, moved, FSNOTIFY_EVENT_DENTRY,
> +	fsnotify_name(rename_mask, &rd, FSNOTIFY_EVENT_RENAME,
>  		      old_dir, old_name, 0);
>  
>  	fsnotify_name(old_dir_mask, source, FSNOTIFY_EVENT_INODE,
>  		      old_dir, old_name, fs_cookie);
> -	fsnotify_name(new_dir_mask, source, FSNOTIFY_EVENT_INODE,
> +	fsnotify_name(new_dir_mask, &rd, FSNOTIFY_EVENT_RENAME,
>  		      new_dir, new_name, fs_cookie);
>  
>  	if (target)
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 66e185bd1b1b..f8c8fb7f34ae 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -311,6 +311,7 @@ enum fsnotify_data_type {
>  	FSNOTIFY_EVENT_DENTRY,
>  	FSNOTIFY_EVENT_MNT,
>  	FSNOTIFY_EVENT_ERROR,
> +	FSNOTIFY_EVENT_RENAME,
>  };
>  
>  struct fs_error_report {
> @@ -335,6 +336,11 @@ struct fsnotify_mnt {
>  	u64 mnt_id;
>  };
>  
> +struct fsnotify_rename_data {
> +	struct dentry *moved;	/* the dentry that was renamed */
> +	struct inode *target;	/* inode overwritten by rename, or NULL */
> +};
> +
>  static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
>  {
>  	switch (data_type) {
> @@ -348,6 +354,8 @@ static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
>  		return d_inode(file_range_path(data)->dentry);
>  	case FSNOTIFY_EVENT_ERROR:
>  		return ((struct fs_error_report *)data)->inode;
> +	case FSNOTIFY_EVENT_RENAME:
> +		return d_inode(((const struct fsnotify_rename_data *)data)->moved);
>  	default:
>  		return NULL;
>  	}
> @@ -363,6 +371,8 @@ static inline struct dentry *fsnotify_data_dentry(const void *data, int data_typ
>  		return ((const struct path *)data)->dentry;
>  	case FSNOTIFY_EVENT_FILE_RANGE:
>  		return file_range_path(data)->dentry;
> +	case FSNOTIFY_EVENT_RENAME:
> +		return ((struct fsnotify_rename_data *)data)->moved;
>  	default:
>  		return NULL;
>  	}
> @@ -395,6 +405,8 @@ static inline struct super_block *fsnotify_data_sb(const void *data,
>  		return file_range_path(data)->dentry->d_sb;
>  	case FSNOTIFY_EVENT_ERROR:
>  		return ((struct fs_error_report *) data)->sb;
> +	case FSNOTIFY_EVENT_RENAME:
> +		return ((const struct fsnotify_rename_data *)data)->moved->d_sb;
>  	default:
>  		return NULL;
>  	}
> @@ -430,6 +442,14 @@ static inline struct fs_error_report *fsnotify_data_error_report(
>  	}
>  }
>  
> +static inline struct inode *fsnotify_data_rename_target(const void *data,
> +							int data_type)
> +{
> +	if (data_type == FSNOTIFY_EVENT_RENAME)
> +		return ((const struct fsnotify_rename_data *)data)->target;
> +	return NULL;
> +}
> +
>  static inline const struct file_range *fsnotify_data_file_range(
>  							const void *data,
>  							int data_type)
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

