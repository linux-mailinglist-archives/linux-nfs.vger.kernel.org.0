Return-Path: <linux-nfs+bounces-20747-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDr+G1Be1mmNEggAu9opvQ
	(envelope-from <linux-nfs+bounces-20747-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 15:55:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4613BD3DF
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 15:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33AAB3019D77
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 13:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D443C3CFF71;
	Wed,  8 Apr 2026 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jFmCEKN6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iQcGEGzV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jFmCEKN6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iQcGEGzV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADE32F39B4
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775656525; cv=none; b=DRlW1aAPd6geIyKGzl7UU7v+vxkHx7J7R2rNURrqY57++mg7045gp2ABCRCE/2U81TzylU5kQ2E6JMKvH/cwzjYbpkLLxtz5oHjELfwNc7pdnwp7hvO9IFVaWcvcRAMIzTYHPp/Og1OFfLydP4WCZAa/xo2Osy4AvsxP7/lxDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775656525; c=relaxed/simple;
	bh=7AQQn9FBOnHh/h22ouj+OJcI6gBdsnXRDykbLd5UAaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnZjC5u+PHgbzoXh8vymybri2CWakf5+7ulN3St6delrgQVFJpblkihETCfkUTzTTkAyXegAap1IfLaVhGhpUXjReSqBUC8B7DadHZ370HOCgONL6HmMIWddQZqNP8J47YxMsIzDTr5siHvaRmA9UA9H/jZFbU/3tMtrWdq61Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jFmCEKN6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iQcGEGzV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jFmCEKN6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iQcGEGzV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ABF8D5BCD7;
	Wed,  8 Apr 2026 13:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775656522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx4ZIvi8G+HrNa2mMQOovPJxPFEEZfX+EX33BeJKF+I=;
	b=jFmCEKN6kBlQKbqUcn/9U981uGLCtjxdYgi9Fjj/br/HSy6c8wivFcjGSMy0SM1ND4ct/H
	PwgU3CV4aRUTLkqoFlesjbrTGmMqlUi7Ka8ieqfYfCWNE/eSE0FAZ7y6czZBoaSk21MAGC
	Uenqg0CdCkdVyQgSs7d5sVcQyHFgQjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775656522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx4ZIvi8G+HrNa2mMQOovPJxPFEEZfX+EX33BeJKF+I=;
	b=iQcGEGzV83/8zGbA3mgpFnISkHUq969DK6gv0Knji2BcKY4i5jWuXmMwH3LQ1a6+4m2rYw
	ChJ8VmlT+rPK41AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775656522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx4ZIvi8G+HrNa2mMQOovPJxPFEEZfX+EX33BeJKF+I=;
	b=jFmCEKN6kBlQKbqUcn/9U981uGLCtjxdYgi9Fjj/br/HSy6c8wivFcjGSMy0SM1ND4ct/H
	PwgU3CV4aRUTLkqoFlesjbrTGmMqlUi7Ka8ieqfYfCWNE/eSE0FAZ7y6czZBoaSk21MAGC
	Uenqg0CdCkdVyQgSs7d5sVcQyHFgQjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775656522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx4ZIvi8G+HrNa2mMQOovPJxPFEEZfX+EX33BeJKF+I=;
	b=iQcGEGzV83/8zGbA3mgpFnISkHUq969DK6gv0Knji2BcKY4i5jWuXmMwH3LQ1a6+4m2rYw
	ChJ8VmlT+rPK41AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 943DE4A0B3;
	Wed,  8 Apr 2026 13:55:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vuonJEpe1mmqQAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Apr 2026 13:55:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 607CFA0A7E; Wed,  8 Apr 2026 15:55:22 +0200 (CEST)
Date: Wed, 8 Apr 2026 15:55:22 +0200
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
Subject: Re: [PATCH 00/24] vfs/nfsd: add support for CB_NOTIFY callbacks in
 directory delegations
Message-ID: <psab2fhw3fappbbfqudg75jvogu2nnvki46b73rqag2wz5b5y5@t3ijifuzdl72>
References: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20747-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0B4613BD3DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue 07-04-26 09:21:13, Jeff Layton wrote:
> This patchset builds on the directory delegation work we did a few
> months ago, to add support for CB_NOTIFY callbacks for some events. In
> particular, creates, unlinks and renames. The server also sends updated
> directory attributes in the notifications. With this support, the client
> can register interest in a directory and get notifications about changes
> within it without losing its lease.
> 
> The series starts with patches to allow the vfs to ignore certain types
> of events on directories. nfsd can then request these sorts of
> delegations on directories, and then set up inotify watches on the
> directory to trigger sending CB_NOTIFY events.
> 
> This has mainly been tested with pynfs, with some new testcases that
> I'll be posting soon. They seem to work fine with those tests, but I
> don't think we'll want to merge these until we have a complete
> client-side implementation to test against.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

The fsnotify changes and generic file locking changes look OK to me. I
don't feel confident enough with NFSD stuff to really review that :)

								Honza

> ---
> Jeff Layton (24):
>       filelock: add support for ignoring deleg breaks for dir change events
>       filelock: add a tracepoint to start of break_lease()
>       filelock: add an inode_lease_ignore_mask helper
>       nfsd: add protocol support for CB_NOTIFY
>       nfs_common: add new NOTIFY4_* flags proposed in RFC8881bis
>       nfsd: allow nfsd to get a dir lease with an ignore mask
>       vfs: add fsnotify_modify_mark_mask()
>       nfsd: update the fsnotify mark when setting or removing a dir delegation
>       nfsd: make nfsd4_callback_ops->prepare operation bool return
>       nfsd: add callback encoding and decoding linkages for CB_NOTIFY
>       nfsd: use RCU to protect fi_deleg_file
>       nfsd: add data structures for handling CB_NOTIFY
>       nfsd: add notification handlers for dir events
>       nfsd: add tracepoint to dir_event handler
>       nfsd: apply the notify mask to the delegation when requested
>       nfsd: add helper to marshal a fattr4 from completed args
>       nfsd: allow nfsd4_encode_fattr4_change() to work with no export
>       nfsd: send basic file attributes in CB_NOTIFY
>       nfsd: allow encoding a filehandle into fattr4 without a svc_fh
>       nfsd: add a fi_connectable flag to struct nfs4_file
>       nfsd: add the filehandle to returned attributes in CB_NOTIFY
>       nfsd: properly track requested child attributes
>       nfsd: track requested dir attributes
>       nfsd: add support to CB_NOTIFY for dir attribute changes
> 
>  Documentation/sunrpc/xdr/nfs4_1.x    | 264 ++++++++++++++-
>  fs/attr.c                            |   2 +-
>  fs/locks.c                           |  89 +++++-
>  fs/namei.c                           |  31 +-
>  fs/nfsd/filecache.c                  |  57 +++-
>  fs/nfsd/nfs4callback.c               |  60 +++-
>  fs/nfsd/nfs4layouts.c                |   5 +-
>  fs/nfsd/nfs4proc.c                   |  15 +
>  fs/nfsd/nfs4state.c                  | 524 ++++++++++++++++++++++++++----
>  fs/nfsd/nfs4xdr.c                    | 300 ++++++++++++++---
>  fs/nfsd/nfs4xdr_gen.c                | 601 ++++++++++++++++++++++++++++++++++-
>  fs/nfsd/nfs4xdr_gen.h                |  20 +-
>  fs/nfsd/state.h                      |  70 +++-
>  fs/nfsd/trace.h                      |  21 ++
>  fs/nfsd/xdr4.h                       |   5 +
>  fs/nfsd/xdr4cb.h                     |  12 +
>  fs/notify/mark.c                     |  29 ++
>  fs/posix_acl.c                       |   4 +-
>  fs/xattr.c                           |   4 +-
>  include/linux/filelock.h             |  54 +++-
>  include/linux/fsnotify_backend.h     |   1 +
>  include/linux/nfs4.h                 | 127 --------
>  include/linux/sunrpc/xdrgen/nfs4_1.h | 291 ++++++++++++++++-
>  include/trace/events/filelock.h      |  38 ++-
>  include/uapi/linux/nfs4.h            |   2 -
>  25 files changed, 2321 insertions(+), 305 deletions(-)
> ---
> base-commit: bd5b9fd5e3d55bc412cec4bebe5a11da2151de4a
> change-id: 20260325-dir-deleg-339066dd1017
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

