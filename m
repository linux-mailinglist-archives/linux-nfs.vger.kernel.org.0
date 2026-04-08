Return-Path: <linux-nfs+bounces-20740-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALLiBvxb1mmNEggAu9opvQ
	(envelope-from <linux-nfs+bounces-20740-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 15:45:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B08093BD237
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 15:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A18730285D8
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 13:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2B43D16EC;
	Wed,  8 Apr 2026 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2/KRW6DL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EXLGe7QT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2/KRW6DL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EXLGe7QT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0250E3ACEF3
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775655916; cv=none; b=lR3zfFdheXwL96xIysNADVYGjejavbaC0JH25JKzUehm3siBhTQS/hDR588QfLuSecjnj+s2U/gNzHA24AOEc2Qc/0QZFMM+nfgI1QHPhV9+D84QSMDRkKbN90UqJcwYCAPCNFRou4Ikcy4dwykg2x8QUm9FBdXVXcHfoe9imXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775655916; c=relaxed/simple;
	bh=96pqWyn6sg9V9CtrdwIXS4q1G7kDDB0OegRtHC3KUGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0j9NuCMtL1qyq/dKhlrVnW7Jh5uuw0OtEpd6Cbvq9OaLVSEBEzIXtzTSQQyDHIJhQ4gEPKkTVmML046bsGsjFM8w7f8tbYndqvvoqkyEpvs2jzNVTDfkeMlUAVRjzM+MlU1Mu1m5bHiOJz6z1I+/HfEO1lr561iK/qAgcEn3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2/KRW6DL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EXLGe7QT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2/KRW6DL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EXLGe7QT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 556344E9ED;
	Wed,  8 Apr 2026 13:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775655912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/zQBRHkcZTGdmtgmvOuDF2/eOE0Fsx6ewiC4Or4NOYk=;
	b=2/KRW6DLy38ko0+FKOgsrCg79uq/lN6y7ccGVBZ1S50/vsiStlcgoF7TM7CWN6K7NnFLcq
	LtwNzgdPktx22ylYwoCdejd3ggHrZF+Pzb5ALuyUhCMhHShA8Le0fhniOsf+ZIIaOaD7CM
	d4oKhxQ/Z5Ki5bnLq/jVV0eyiY9nhvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775655912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/zQBRHkcZTGdmtgmvOuDF2/eOE0Fsx6ewiC4Or4NOYk=;
	b=EXLGe7QTULOkdrTE+oBvw2r0u+WLTQnh+BXVz5AMbm40b7twK1HqsLJh+DNXHbD3MOi++f
	VNFM3Yhn5SpTs/CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775655912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/zQBRHkcZTGdmtgmvOuDF2/eOE0Fsx6ewiC4Or4NOYk=;
	b=2/KRW6DLy38ko0+FKOgsrCg79uq/lN6y7ccGVBZ1S50/vsiStlcgoF7TM7CWN6K7NnFLcq
	LtwNzgdPktx22ylYwoCdejd3ggHrZF+Pzb5ALuyUhCMhHShA8Le0fhniOsf+ZIIaOaD7CM
	d4oKhxQ/Z5Ki5bnLq/jVV0eyiY9nhvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775655912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/zQBRHkcZTGdmtgmvOuDF2/eOE0Fsx6ewiC4Or4NOYk=;
	b=EXLGe7QTULOkdrTE+oBvw2r0u+WLTQnh+BXVz5AMbm40b7twK1HqsLJh+DNXHbD3MOi++f
	VNFM3Yhn5SpTs/CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 490CA4A0B3;
	Wed,  8 Apr 2026 13:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vDnPEehb1mn/NQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Apr 2026 13:45:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E399CA0A7E; Wed,  8 Apr 2026 15:45:07 +0200 (CEST)
Date: Wed, 8 Apr 2026 15:45:07 +0200
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
Subject: Re: [PATCH 01/24] filelock: add support for ignoring deleg breaks
 for dir change events
Message-ID: <snnggefctfffpb3rsyhjdwmxozqdklqmweiojmxy7owettksgz@6vud2iacgeqc>
References: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
 <20260407-dir-deleg-v1-1-aaf68c478abd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-dir-deleg-v1-1-aaf68c478abd@kernel.org>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spam-Flag: NO
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
	TAGGED_FROM(0.00)[bounces-20740-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B08093BD237
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue 07-04-26 09:21:14, Jeff Layton wrote:
> If a NFS client requests a directory delegation with a notification
> bitmask covering directory change events, the server shouldn't recall
> the delegation. Instead the client will be notified of the change after
> the fact.
> 
> Add support for ignoring lease breaks on directory changes. Add a new
> flags parameter to try_break_deleg() and teach __break_lease how to
> ignore certain types of delegation break events.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -222,6 +225,10 @@ struct file_lease *locks_alloc_lease(void);
>  #define LEASE_BREAK_LAYOUT		BIT(2)	// break layouts only
>  #define LEASE_BREAK_NONBLOCK		BIT(3)	// non-blocking break
>  #define LEASE_BREAK_OPEN_RDONLY		BIT(4)	// readonly open event
> +#define LEASE_BREAK_DIR_CREATE		BIT(6)  // dir deleg create event
> +#define LEASE_BREAK_DIR_DELETE		BIT(7)  // dir deleg delete event
> +#define LEASE_BREAK_DIR_RENAME		BIT(8)  // dir deleg rename event

Just curious why you've left out bit 5 here... :)

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

