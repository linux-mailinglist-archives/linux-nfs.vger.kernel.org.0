Return-Path: <linux-nfs+bounces-21199-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM9wF1yF72klCAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21199-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 17:48:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D40D347583F
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 17:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1251030C5293
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4CA3E3152;
	Mon, 27 Apr 2026 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Aysv71Jg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ByfH34ew";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Aysv71Jg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ByfH34ew"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5657B3E314B
	for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303858; cv=none; b=LthoBaYZmsGtp8wNoyLUaCZGObmUginhpgAOPabpuLYuY7DcPuUREACUCc9aFeDD6VTFNUKs8HsdWTx/kDcEd1d8X3ReQN1vSfUZZQJ5tHDJ180nALCtySvpOLTvqkCOu4SwuI82OiAuae5PkHE+6bAHNkxeMKOW7Tyw+XtY0Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303858; c=relaxed/simple;
	bh=A8d/wC+e7YNTnjy9OqxjJ672fXbuhxFSU8FpXpeA/Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtQpJFo/MCsjGyve1xbVxo1BPu7zvR5LVCXVQib1i1p37zYFNqbRT5V2fQEhddHYoCdC77itzRuMMyawIazdcPip6aNvVeYhGXZVtgitRM86UDTb6wtBAGs8dX5AxgAp7ZC4W4ZzR3qzvbexk7/qhI2ejBYoIGLTgUFhew1h/vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Aysv71Jg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ByfH34ew; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Aysv71Jg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ByfH34ew; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 83C405BD28;
	Mon, 27 Apr 2026 15:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777303854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S5TTh67heGQlOR0MPWIUkAW95GyTnx+icWBSCmm/7n0=;
	b=Aysv71JgNdkUTLe/R48X+824uBNRHn71litaKG+1w3A/La231hoXUGBWz2y9yzsnn597mv
	3P03spY5S3DdVhHCq0qYKHFvVuwZg6pQhYxrLTt86tLSZR6efrU+hSdh7QqDVh0gGeiw4f
	hGZLTaIznZNVQWN0qZZWDoyKNyoU2/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777303854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S5TTh67heGQlOR0MPWIUkAW95GyTnx+icWBSCmm/7n0=;
	b=ByfH34ewyF0hmVnffEbScDGb1ZxCDfRi+yKco+Xw6OzguYlECQXkamlnVtnXzZCBify66N
	bmYnyjqNmoSD5TBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Aysv71Jg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ByfH34ew
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777303854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S5TTh67heGQlOR0MPWIUkAW95GyTnx+icWBSCmm/7n0=;
	b=Aysv71JgNdkUTLe/R48X+824uBNRHn71litaKG+1w3A/La231hoXUGBWz2y9yzsnn597mv
	3P03spY5S3DdVhHCq0qYKHFvVuwZg6pQhYxrLTt86tLSZR6efrU+hSdh7QqDVh0gGeiw4f
	hGZLTaIznZNVQWN0qZZWDoyKNyoU2/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777303854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S5TTh67heGQlOR0MPWIUkAW95GyTnx+icWBSCmm/7n0=;
	b=ByfH34ewyF0hmVnffEbScDGb1ZxCDfRi+yKco+Xw6OzguYlECQXkamlnVtnXzZCBify66N
	bmYnyjqNmoSD5TBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 772B4593B0;
	Mon, 27 Apr 2026 15:30:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id po8VHS6B72npVQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 27 Apr 2026 15:30:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 37EB1A0B3C; Mon, 27 Apr 2026 17:30:54 +0200 (CEST)
Date: Mon, 27 Apr 2026 17:30:54 +0200
From: Jan Kara <jack@suse.cz>
To: Chuck Lever <cel@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	almaz.alexandrovich@paragon-software.com, Viacheslav Dubeyko <slava@dubeyko.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, frank.li@vivo.com, Theodore Tso <tytso@mit.edu>, 
	adilger.kernel@dilger.ca, Carlos Maiolino <cem@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Roland Mainz <roland.mainz@nrubsig.org>, 
	Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH v11 00/15] Exposing case folding behavior
Message-ID: <jq4wmu34kstqgvjspfalgedpsv3xciwkc5uaj7ewdc73a3yt6f@ddoia6tddojv>
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
 <yc7ygk6w6zvf46arzzvmxnuoqjrni2dtlhmywaivzmvfxnilf3@xv7tthtrowns>
 <af3f7518-7501-4c25-9bbc-a8fc8cdb4e29@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af3f7518-7501-4c25-9bbc-a8fc8cdb4e29@app.fastmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: D40D347583F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21199-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,zeniv.linux.org.uk,kernel.org,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On Mon 27-04-26 09:30:28, Chuck Lever wrote:
> 
> On Mon, Apr 27, 2026, at 6:55 AM, Jan Kara wrote:
> > On Fri 24-04-26 21:53:02, Chuck Lever wrote:
> >> Changes since v10:
> >> - cifs: Source case-handling flags from the server's cached
> >>   FS_ATTRIBUTE_INFORMATION reply instead of the nocase mount
> >>   option, with a nocase fallback when the reply is absent
> >> - Address findings from sashiko(gemini-3) and gpt-5.5:
> >>   - nfs: Skip pathconf case bits on NFSv4 (set via FATTR4_CASE_*
> >>     instead)
> >>   - xfs: Hide FS_CASEFOLD_FL from the legacy flags view so
> >>     chattr round-trips do not hit the setflags whitelist
> >>   - ext4, f2fs: Drop redundant fileattr_get patches; the
> >>     FS_CASEFOLD_FL translation in fileattr_fill_flags() already
> >>     reports FS_XFLAG_CASEFOLD for casefolded directories
> >
> > Err, how is this supposed to work? I wasn't able to find any code
> > transforming S_CASEFOLDED inode flag into FS_CASEFOLD_FL on fileattr_get
> > path. Sure, fileattr_fill_flags() takes care of setting FS_XFLAG_CASEFOLD
> > once FS_CASEFOLD_FL is set. What am I missing?
> 
> Agreed, that is a little surprising.
> 
> The path does not go through S_CASEFOLD.  Both filesystems
> report FS_CASEFOLD_FL straight from their on-disk flag word.
> 
> For ext4, EXT4_CASEFOLD_FL is 0x40000000, the same bit value
> as FS_CASEFOLD_FL, and it is included in EXT4_FL_USER_VISIBLE.
> ext4_iget() loads it into ei->i_flags directly from
> raw_inode->i_flags (fs/ext4/inode.c:5358). ext4_fileattr_get()
> then masks with EXT4_FL_USER_VISIBLE and hands the result to
> fileattr_fill_flags(), which translates FS_CASEFOLD_FL into
> FS_XFLAG_CASEFOLD on the way out.

Oh, right. I've missed how EXT4_CASEFOLD_FL propagates into FS_CASEFOLD_FL.
Thanks for clearing that out.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

