Return-Path: <linux-nfs+bounces-4504-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE7691EBA2
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 01:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2DD1F220D0
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 23:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B013238DD9;
	Mon,  1 Jul 2024 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ppSS6kz9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TB0EXfXi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iPLK27nv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MttSFQp8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D957C173328
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719878164; cv=none; b=q6Ce5pZ6vdHq4c8INMt8BfA4CQYZr9kcxaCwaicP1Yxd+bDaUgt+y2dXyrv6pbzkSuLg+oUnqQqVC+TB2WTUAFBdhG+EovJiiOp5iBoBchDEoV/gLtDEXUSpafqVawMKjCfw2FcB8gMuac5fman1Yqf9OHEGsMbEv8P31a1e18I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719878164; c=relaxed/simple;
	bh=Nu+UwWnHOIWI3RjfCrvVyLfHusqZwDOMlVzHMdyoykc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=GBgBmAxdD6KmKKkJ6wUKpiGm6rn6fGA4lUM4H/fMAOGA2V3Yhr8utqjncUwTth8Ug7yl11gMRjJPviMhZ/8Yx8tiiCaPL72RTTshE47x7wEnS/IQdiGL/QtRWPDBIEbUsqcidRjselEWUKKQ6iPV+Lg/qFr3MtJJdzTfLIW3nfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ppSS6kz9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TB0EXfXi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iPLK27nv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MttSFQp8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC08E21ACC;
	Mon,  1 Jul 2024 23:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719878160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWHuxoj7syp9MENwFE9JMVmZa1JMUQ/KSdRXNbmR/uM=;
	b=ppSS6kz9qiwwQfRDqbZzRxLvPMHKb8DpKjkwxGs0K4FPeIYhpOLW05gXOSw2b8aG7u6XoC
	GF1+BAN22X8RCplilZefPs1BSywcbXP1nSHH0xraaXvc4V+TgWIEI1RSTCv9rRSRdo9bYC
	qMbL7LjRs9WtHjZn2CpbVCY7yEjDFZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719878160;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWHuxoj7syp9MENwFE9JMVmZa1JMUQ/KSdRXNbmR/uM=;
	b=TB0EXfXiW5bFWyYqYD9N/7FHocl8q+t5FlnbVIhUAqiJvwhcywgL+4zsZGwjTHTZ2bNi2i
	1VXvdl5L5RlvWXBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iPLK27nv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MttSFQp8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719878159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWHuxoj7syp9MENwFE9JMVmZa1JMUQ/KSdRXNbmR/uM=;
	b=iPLK27nv2GNJZSlIAvO+hbpELWkBjVmvcsDBrtJxYDxCpTkLscv8XflI5J3f0Gjq9/atMK
	9LuLG+Howup2eTCqKFKKaQX2QUn5T6Nun1KZlZqcxkB7Ea3GYDMV8EVCNQkgfJrN1rP1Oe
	EA6Q0niGyvwKothgvFV4kSbY8HiuzXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719878159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWHuxoj7syp9MENwFE9JMVmZa1JMUQ/KSdRXNbmR/uM=;
	b=MttSFQp8+dmgozqGqLboqTLjZniEWTEaM8m3ujwYA/vVhIrGX1Jl+4XRGH2YtnhEtqP5QW
	1qQuXXtAmJ81zfDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDA0A13668;
	Mon,  1 Jul 2024 23:55:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3CFsIAxCg2a7DAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 01 Jul 2024 23:55:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Mike Snitzer" <snitzer@kernel.org>
Subject: Re: [PATCH 6/6] nfsd: add nfsd_file_acquire_local().
In-reply-to: <a97c04d1166243f758ad5e3f2cc267aa9360b3f8.camel@kernel.org>
References: <>, <a97c04d1166243f758ad5e3f2cc267aa9360b3f8.camel@kernel.org>
Date: Tue, 02 Jul 2024 09:55:52 +1000
Message-id: <171987815216.16071.11700950008759904924@noble.neil.brown.name>
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CC08E21ACC
X-Spam-Flag: NO
X-Spam-Score: -5.51
X-Spam-Level: 

On Mon, 01 Jul 2024, Jeff Layton wrote:
> 
> Neil, in an earlier email you mentioned that the client could hold onto
> the nfsd_file reference over several operations and then put it. That
> would be fine too, but I'm unclear on how the client will manage this.
> Does the client have a way to keep track of the nfsd_file over several
> operations to the same inode?

Looking at 
   [PATCH v10 13/19] nfs: add "localio" support

you can see that 
   struct file *local_filp;
is added to "struct nfs_open_context".  An nfs_open_context is stored
in file->private_data and is attached to the inode via nfsi->open_files.
It holds the nfs state for any file open on the NFS filesystem..

->local_filp is set the first time nfs_local_file_open_cache() is called
and remains set until the final __put_nfs_open_context() call destroys
the context.  So it lasts as long as the NFS file is open.  Note that
only one successful ->nfsd_open_local_fh() call is made for each opened
NFS file.  All IO then uses the "struct file*" with no further reference
to nfsd.

If we stored an nfsd_file in the nfs_open_context, either as well as
the 'struct file*' or instead of, then we could call nfsd_file_put()
when the nfs file is closed.  That seems to be the correct lifetime and
matches (almost) exactly what happens with NFSv4 where OPEN and CLOSE
are send over the wire.

> 
> Even then, I still think we're probably better off just garbage
> collecting thse, since it seems likely that they will end up being
> reused in many cases.

Why does this logic apply to localio, but not to normal NFSv4 access?

NeilBrown


