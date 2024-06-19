Return-Path: <linux-nfs+bounces-4047-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10B590E2B2
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 07:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E4A1C21EE4
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 05:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285112139C9;
	Wed, 19 Jun 2024 05:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H+YhpJAl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T3vOPhOU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AdgHilUz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BY/r1UF5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85664208B0
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 05:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718775070; cv=none; b=V6OsKIFZICH9O8l7OI8JAFQrJz3sOQfZDXfOAQWv0FbX05JjNzF77vlUSNlqwdMiGCJH1KCDd5aGNk1ssqG3LnlLlbi8zFgLtHj61r81y0AmxFIOToID9dl/xOKL3TBt9q09RLf3FkGq6ehc341rlQaToZo2SZ1k/oMND5AQbrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718775070; c=relaxed/simple;
	bh=o3mvzbUqgCYKftbnHvgUfRPsGsoMPzf6FzQ8zayUMAU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=gMEHsNH0sRXxh0I4IHGcyOfALURktAHuIh/V/oDkCFoz4L/yNNIcKXYDyQGIBCe6gB3fERJYLJOtUDp5cPEDiEar1gM9SSZa/Z5uyb/IwNAvDHehIugkEsTFTFEdlof3BLX5FCOYQ1liZyj6A5ZEY2K9+xjMzcMhScKTQh5k5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H+YhpJAl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T3vOPhOU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AdgHilUz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BY/r1UF5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7DA6921A29;
	Wed, 19 Jun 2024 05:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718775066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/HvfPEuyvM7zwJfpjX82H+YXe3ooeP11XBd5xdhjbbA=;
	b=H+YhpJAlgzuQo0JFtmNblN6DK3ymh0sZAX43ezi6BHFleIJMvamWj+AixznhtQbc2l6+4w
	5sIdS+zsrbEezweq0TJOFHhk3OE/3P5Lg/QrkThe61B+TyM9E+Q8CPZsJQN4eqFUGIac+x
	V2V79P/INFfb5HZ8dmEmp80O6xqiBuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718775066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/HvfPEuyvM7zwJfpjX82H+YXe3ooeP11XBd5xdhjbbA=;
	b=T3vOPhOUbiXkZNiJrnlB+ybKzzJ0wasHLEGbU4gYQv2t2XpZnpofJ42RJ23J9k+FSLki/j
	vrViDXiWqvBCiOBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AdgHilUz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="BY/r1UF5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718775065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/HvfPEuyvM7zwJfpjX82H+YXe3ooeP11XBd5xdhjbbA=;
	b=AdgHilUz2JW6DbGqJ8X6shJ41d2JLE1kDRjYdGj+k5tKqNpXaXUZx2KYhn9uqoq0+KJPqx
	6dhk1QNMZRmHpAPRt8jhYw2ae7f1O7Q9u3AUit+/XxKDktHuBxCEUII/P+eGniQCAVajxs
	FP58ZW+WFMxGCYzsQlLhMZUZcqVyzFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718775065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/HvfPEuyvM7zwJfpjX82H+YXe3ooeP11XBd5xdhjbbA=;
	b=BY/r1UF5HdS0WMBbOGdp8R1A3tKJPYCJOtufB7SUziWUJXsluRg2gZE+fFv0B/Wv6QbQ8H
	lP2vmYmLRSy/tDBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E175513AAF;
	Wed, 19 Jun 2024 05:31:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7kRFIRZtcmZJaAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 19 Jun 2024 05:31:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v5 09/19] nfs: implement v3 and v4 client support for
 NFS_LOCALIO_PROGRAM
In-reply-to: <20240618201949.81977-10-snitzer@kernel.org>
References: <20240618201949.81977-1-snitzer@kernel.org>,
 <20240618201949.81977-10-snitzer@kernel.org>
Date: Wed, 19 Jun 2024 15:30:59 +1000
Message-id: <171877505925.14261.8038886761089867261@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,iana.org:url,lanana.org:url]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7DA6921A29
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On Wed, 19 Jun 2024, Mike Snitzer wrote:
> LOCALIOPROC_GETUUID allows client to discover server's uuid.
> 
> nfs_local_probe() will retrieve server's uuid via LOCALIO protocol and
> verify the server with that uuid it is known to be local. This ensures
> client and server 1: support localio 2: are local to each other.
> 
> While doing so, factor out nfs_init_localioclient() so it is used by
> both nfs3client.c and nfs4client.c
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
..
>  
> +#define NFS_LOCALIO_PROGRAM	100229

According to RFC5531, this number is reserved for "metad".
It might be best not to use it.

That RFC says that assigning numbers isn't a job for IETF standard-track
and handed the job over to IANA.

IANA...
https://www.iana.org/assignments/sun-rpc-numbers/sun-rpc-numbers.xhtml
thinks SUN rpc numbers are obsolete.

So maybe nobody cares.

I would feel most comfortable allocating a number from the range:

             0x20000000 - 0x3fffffff   Defined by local administrator
                                       (some blocks assigned here)

and maybe make it configurable by a module parameter just to be on the
safe side (overkill??)

We could try registering with lanana.org (The Linux Assigned Names And
Numbers Authority) but I wouldn't be surprised if that went nowhere.

While this might not matter in practice, I think we should appear to be
doing the right thing.

NeilBrown


> +#define LOCALIOPROC_NULL	0
> +#define LOCALIOPROC_GETUUID	1
> +
>  #define NFS_PIPE_DIRNAME "nfs"
>  
>  /*
> -- 
> 2.44.0
> 
> 


