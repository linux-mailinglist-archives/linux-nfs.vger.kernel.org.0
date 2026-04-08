Return-Path: <linux-nfs+bounces-20742-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHfALNFd1mmNEggAu9opvQ
	(envelope-from <linux-nfs+bounces-20742-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 15:53:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F913BD36E
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 15:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 745F13021E49
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 13:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C212D3ACA64;
	Wed,  8 Apr 2026 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RfdJr19v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q2FxjAx2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R1mMO9ol";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vSOxa7sB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69443370D6B
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775656273; cv=none; b=POVXtgRmyBgYae0EDAVOaAj1Y3F6s59lmT56X8MY5RFxPtASR2KSU4rxiNgbfOto0JNOsGEh7zEA1omwjwa7IUll/1w+V7plqERTr6MAC1pdrMuN4jdonLL/0ncjwjdsu++QN/aXhZkkoARWW4Ondj+DwQ4KxvOnHwwUjb5NfIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775656273; c=relaxed/simple;
	bh=qP/5Jy0821X7NiLfTMYW9q5+T5u7GzsrTdIVEAPSyaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Po1fMoV0jhqHKRTJhjTJVevOBwPJ0/uu4uM6GLIRL387H4QzrlxY4CD5vLlnU0zEBkYXZxdHh8xa1LEHkDeFKXHx0cjN5qoUomXQ+wFXLgjt0g0xs1k4koLwYg/hLFQ21R4W30KwDAVBz8Y1q164JNHnN654wUEV01YBlyB5A68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RfdJr19v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q2FxjAx2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R1mMO9ol; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vSOxa7sB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AE31B4E9F3;
	Wed,  8 Apr 2026 13:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775656270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OJjUy2mQzfWSECJnXOQK+j29FfzvSNAP9nh+eOIWE80=;
	b=RfdJr19vxqGAu7/hsy8A5W2Brvb7WMM4iy/3EPzP1PPz9SOV44z1lhj9YLc0G7Ca8RvBI3
	8Ugq95DclEwNdr89Go0Aofbu9Zj5Hg+AQ+Bd3NJgAxDVnTcpPi5AOh68YjKxj7hskIQe2s
	LDoa73AOSOGGushzw+UpukjWbhJJow8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775656270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OJjUy2mQzfWSECJnXOQK+j29FfzvSNAP9nh+eOIWE80=;
	b=Q2FxjAx26yvUEMgzP5iJJCn3r1jAHyuNdkR96RyaoyDi85kflBkDdOZZRxVkwtwai6/7kU
	nFqjTZ9As/FKuoAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775656269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OJjUy2mQzfWSECJnXOQK+j29FfzvSNAP9nh+eOIWE80=;
	b=R1mMO9olSZpD1CG6ojN2VLVCLSw/XJyrfWJYm0r5A/iHxdU/P8OcRlErix8t9uj79GYpqa
	CS/wzwjaeyT+8f0ZLJuKHNZip1hqecDo2Fv3oS8QjOK0FK3/qnsHPkfavJiFCN3MTm1LrO
	aNro2nNkzSjfhnaPxzO55j3Tjh/hw6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775656269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OJjUy2mQzfWSECJnXOQK+j29FfzvSNAP9nh+eOIWE80=;
	b=vSOxa7sB7YO/+mD+v9SaNe3tKowuRPNXaa6N0a+lC7W/w5Y4LNidnFi6rOSKHQIIPcsPWF
	pZiePj/vIV786TCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A47794A0B3;
	Wed,  8 Apr 2026 13:51:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NkwlKE1d1mkzPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Apr 2026 13:51:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 67E59A0A7E; Wed,  8 Apr 2026 15:51:05 +0200 (CEST)
Date: Wed, 8 Apr 2026 15:51:05 +0200
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
Subject: Re: [PATCH 07/24] vfs: add fsnotify_modify_mark_mask()
Message-ID: <vds657qjz3ohsaj5dpaphix234d6z5unjo2m7euxrfaws4ibxh@bkaqqdjyuiwa>
References: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
 <20260407-dir-deleg-v1-7-aaf68c478abd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-dir-deleg-v1-7-aaf68c478abd@kernel.org>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spam-Flag: NO
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
	TAGGED_FROM(0.00)[bounces-20742-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 15F913BD36E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue 07-04-26 09:21:20, Jeff Layton wrote:
> nfsd needs to be able to modify the mask on an existing mark when new
> directory delegations are set or unset. Add an exported function that
> allows the caller to set and clear bits in the mark->mask, and does
> the recalculation if something changed.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/notify/mark.c                 | 29 +++++++++++++++++++++++++++++
>  include/linux/fsnotify_backend.h |  1 +
>  2 files changed, 30 insertions(+)
> 
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index c2ed5b11b0fe..b1e73c6fd382 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -310,6 +310,35 @@ void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>  		fsnotify_conn_set_children_dentry_flags(conn);
>  }
>  
> +/**
> + * fsnotify_modify_mark_mask - set and/or clear flags in a mark's mask
> + * @mark: mark to be modified
> + * @set: bits to be set in mask
> + * @clear: bits to be cleared in mask
> + *
> + * Modify a fsnotify_mark mask as directed, and update its associated conn.
> + * The caller is expected to hold a reference to the mark.
> + */
> +void fsnotify_modify_mark_mask(struct fsnotify_mark *mark, u32 set, u32 clear)
> +{
> +	bool recalc = false;
> +	u32 mask;
> +
> +	WARN_ON_ONCE(clear & set);
> +
> +	spin_lock(&mark->lock);
> +	mask = mark->mask;
> +	mark->mask |= set;
> +	mark->mask &= ~clear;
> +	if (mark->mask != mask)
> +		recalc = true;
> +	spin_unlock(&mark->lock);
> +
> +	if (recalc)
> +		fsnotify_recalc_mask(mark->connector);
> +}
> +EXPORT_SYMBOL_GPL(fsnotify_modify_mark_mask);
> +
>  /* Free all connectors queued for freeing once SRCU period ends */
>  static void fsnotify_connector_destroy_workfn(struct work_struct *work)
>  {
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 95985400d3d8..66e185bd1b1b 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -917,6 +917,7 @@ extern void fsnotify_get_mark(struct fsnotify_mark *mark);
>  extern void fsnotify_put_mark(struct fsnotify_mark *mark);
>  extern void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info);
>  extern bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info);
> +extern void fsnotify_modify_mark_mask(struct fsnotify_mark *mark, u32 set, u32 clear);
>  
>  static inline void fsnotify_init_event(struct fsnotify_event *event)
>  {
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

