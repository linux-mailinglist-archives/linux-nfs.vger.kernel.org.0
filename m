Return-Path: <linux-nfs+bounces-21170-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKj8N/dA72lP/QAAu9opvQ
	(envelope-from <linux-nfs+bounces-21170-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 12:56:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CD44715A8
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 12:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC3D93030E83
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 10:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623233B6344;
	Mon, 27 Apr 2026 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mL3ngl1c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ILylDamP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mL3ngl1c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ILylDamP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979CB3B4E9C
	for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287359; cv=none; b=I9r2L/cNB7sIxk/hTpQKtosMscbLppSJcvPDh7VxaV7C0tkCsmFI/FIqJOC159T0JXDg+Eu95RRXjKg0iervBTvpInQpXxwaRNWdyLfMxrMht5C1aIjiDrH9jYAW/h5FnRJ/x03vb5YaQnkY7NpRauXPM09A42G04tWtuk7bKRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287359; c=relaxed/simple;
	bh=3sJXeUMO9jisAeihFbO9SPq83sRF/8ovxEJvWG5d2p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkJ+GGjjI8tPJqLXfH3hF07SK13tiZaX6yIkPvaPyQzE+uHinb4AXqGhfgl/ZXXFv9dK8VQC4yXstMqlaw6Wcpdfn0uL3bekVv85GHkdtnJhYE9GxPKGfnkyGOgTL3uC75MmBY2X1WAmyhx0d/u0yyNzvFsbsb38oACAqKvE3Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mL3ngl1c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ILylDamP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mL3ngl1c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ILylDamP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DB1DF6A90C;
	Mon, 27 Apr 2026 10:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777287355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7v7Dqr0yFbYHWxuadHzDP6hn5aEfxXOyhRHqVAyeSDA=;
	b=mL3ngl1cqaRUt8Fn5dYnLoFF2Acv+D9WQtqParWsKqzU/P5IXj0SXcU98WOltiA1mn4zVm
	BOKmz6VoxTsS6U2V1Z8vMrEHG8P9XabHEblzsATlsxjFsMFI251OYIDwEOn0XYFbgu1xzD
	uX3AFNBs03zK1OvzoLoIcxzuG1vWQuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777287355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7v7Dqr0yFbYHWxuadHzDP6hn5aEfxXOyhRHqVAyeSDA=;
	b=ILylDamPZoKLtgaAkFGi18Zgg+LC8tTd9UFmlIrhO7AJ1n2wvk+mr09kzXnhdJRJ2siVKG
	yLiBMSGqbMZCTwBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mL3ngl1c;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ILylDamP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777287355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7v7Dqr0yFbYHWxuadHzDP6hn5aEfxXOyhRHqVAyeSDA=;
	b=mL3ngl1cqaRUt8Fn5dYnLoFF2Acv+D9WQtqParWsKqzU/P5IXj0SXcU98WOltiA1mn4zVm
	BOKmz6VoxTsS6U2V1Z8vMrEHG8P9XabHEblzsATlsxjFsMFI251OYIDwEOn0XYFbgu1xzD
	uX3AFNBs03zK1OvzoLoIcxzuG1vWQuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777287355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7v7Dqr0yFbYHWxuadHzDP6hn5aEfxXOyhRHqVAyeSDA=;
	b=ILylDamPZoKLtgaAkFGi18Zgg+LC8tTd9UFmlIrhO7AJ1n2wvk+mr09kzXnhdJRJ2siVKG
	yLiBMSGqbMZCTwBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CACD3593B0;
	Mon, 27 Apr 2026 10:55:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0DN3MbtA72lvOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 27 Apr 2026 10:55:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8ABE3A0AFF; Mon, 27 Apr 2026 12:55:55 +0200 (CEST)
Date: Mon, 27 Apr 2026 12:55:55 +0200
From: Jan Kara <jack@suse.cz>
To: Chuck Lever <cel@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	sj1557.seo@samsung.com, yuezhang.mo@sony.com, almaz.alexandrovich@paragon-software.com, 
	slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, trondmy@kernel.org, anna@kernel.org, 
	jaegeuk@kernel.org, chao@kernel.org, hansg@kernel.org, senozhatsky@chromium.org, 
	Chuck Lever <chuck.lever@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Roland Mainz <roland.mainz@nrubsig.org>, Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH v11 00/15] Exposing case folding behavior
Message-ID: <yc7ygk6w6zvf46arzzvmxnuoqjrni2dtlhmywaivzmvfxnilf3@xv7tthtrowns>
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 82CD44715A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21170-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On Fri 24-04-26 21:53:02, Chuck Lever wrote:
> Changes since v10:
> - cifs: Source case-handling flags from the server's cached
>   FS_ATTRIBUTE_INFORMATION reply instead of the nocase mount
>   option, with a nocase fallback when the reply is absent
> - Address findings from sashiko(gemini-3) and gpt-5.5:
>   - nfs: Skip pathconf case bits on NFSv4 (set via FATTR4_CASE_*
>     instead)
>   - xfs: Hide FS_CASEFOLD_FL from the legacy flags view so
>     chattr round-trips do not hit the setflags whitelist
>   - ext4, f2fs: Drop redundant fileattr_get patches; the
>     FS_CASEFOLD_FL translation in fileattr_fill_flags() already
>     reports FS_XFLAG_CASEFOLD for casefolded directories

Err, how is this supposed to work? I wasn't able to find any code
transforming S_CASEFOLDED inode flag into FS_CASEFOLD_FL on fileattr_get
path. Sure, fileattr_fill_flags() takes care of setting FS_XFLAG_CASEFOLD
once FS_CASEFOLD_FL is set. What am I missing?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

