Return-Path: <linux-nfs+bounces-21175-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ87LMhl72kIBAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21175-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:34:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA844737EB
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2AF83087D02
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 13:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D10D3CB2F0;
	Mon, 27 Apr 2026 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bJ9xnzF7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ep8BtrKE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bJ9xnzF7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ep8BtrKE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803D625782A
	for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296615; cv=none; b=KAoW2LjA7xmpPgcWXjEfP8DI6JWwcU9SI77fRPlEH8e2PhFEsT/62Q1XuiRfLxfcuvUviDlaF5b+9j8Ub0ihH2nKpQVJgsA/mtsGqbiQv+YyHHdtTTwzBCGvLo4/d8+TLQhaHqnsHQEV9aJSY3Tf1McSO0+QSRO1r9+ZhwWBEJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296615; c=relaxed/simple;
	bh=QTkhm7BQUqulEPhN8RoVyJshMSLIopwnBFEPuRLWIFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueDsmfuQ8Snf6Dcp5Gyf3a7cwo+4/0g3qRvEx10Gza6Ky9QtQY72JmETt5IoiropdKfFgokaDscLFtvsdZ+UAlNlEqwFXNMCea5SR4+7nRX8mauas3FpqUtB7L6PYLDoif8f9q5muRuAYG2x74ma4IsNarAuAQHRfTkVYM56s90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bJ9xnzF7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ep8BtrKE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bJ9xnzF7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ep8BtrKE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BEFDB5BCD4;
	Mon, 27 Apr 2026 13:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777296611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ywgzgcft+C+lUn4KhFHszkfD7fjPVqcPL/BmeMIkrC4=;
	b=bJ9xnzF7xFxi6EJ0ITevdtIXeNBmmMmr3PezUqGew7pkrtcg93SGCxFES36b9gWD+oNRcW
	BWLMQySbIWGkNDz8vqtjgM3m/gaaRPjwmjsx4BgkJfjBdOE5JyBeb9aQmQYl+mIjSR8GRI
	4qBPQavM+yjDmyktcL8JNDZOhWh06Ws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777296611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ywgzgcft+C+lUn4KhFHszkfD7fjPVqcPL/BmeMIkrC4=;
	b=ep8BtrKEMutZlURd5W8fPA3/5kuf8iMOihx2Ckvd0Wbuo1uAF9/Uc3lcMZO6v9FAiOT/8c
	6DWuEKuDWRIn0hDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bJ9xnzF7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ep8BtrKE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777296611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ywgzgcft+C+lUn4KhFHszkfD7fjPVqcPL/BmeMIkrC4=;
	b=bJ9xnzF7xFxi6EJ0ITevdtIXeNBmmMmr3PezUqGew7pkrtcg93SGCxFES36b9gWD+oNRcW
	BWLMQySbIWGkNDz8vqtjgM3m/gaaRPjwmjsx4BgkJfjBdOE5JyBeb9aQmQYl+mIjSR8GRI
	4qBPQavM+yjDmyktcL8JNDZOhWh06Ws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777296611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ywgzgcft+C+lUn4KhFHszkfD7fjPVqcPL/BmeMIkrC4=;
	b=ep8BtrKEMutZlURd5W8fPA3/5kuf8iMOihx2Ckvd0Wbuo1uAF9/Uc3lcMZO6v9FAiOT/8c
	6DWuEKuDWRIn0hDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B247A593B0;
	Mon, 27 Apr 2026 13:30:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y5eAK+Nk72nAWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 27 Apr 2026 13:30:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7582DA0B3C; Mon, 27 Apr 2026 15:30:11 +0200 (CEST)
Date: Mon, 27 Apr 2026 15:30:11 +0200
From: Jan Kara <jack@suse.cz>
To: Lionel Cons <lionelcons1972@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Chuck Lever <cel@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	sj1557.seo@samsung.com, yuezhang.mo@sony.com, almaz.alexandrovich@paragon-software.com, 
	slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, trondmy@kernel.org, anna@kernel.org, 
	jaegeuk@kernel.org, chao@kernel.org, hansg@kernel.org, senozhatsky@chromium.org, 
	Chuck Lever <chuck.lever@oracle.com>, Roland Mainz <roland.mainz@nrubsig.org>
Subject: Re: [PATCH v11 12/15] isofs: Implement fileattr_get for case
 sensitivity
Message-ID: <lxbpvsj3b6jvl2tmcxgto4aqsi6necmmha3ldby3k4bnmyxltm@mii3s6vjmanq>
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
 <20260424-case-sensitivity-v11-12-de5619beddaf@oracle.com>
 <isfgwmd5hxjfn7dj7p54yzlhumx2hrkt3zw7fscs2ywm57g3hu@co27drpx24lq>
 <CAPJSo4WmRu_64TxBsaimWOqz3VAU0TZ1H-_hw36HSqzQULm39w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPJSo4WmRu_64TxBsaimWOqz3VAU0TZ1H-_hw36HSqzQULm39w@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 5CA844737EB
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
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[archive.org:url,nrubsig.org:email,suse.cz:dkim,suse.cz:email,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-21175-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[35];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,zeniv.linux.org.uk,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On Mon 27-04-26 14:02:00, Lionel Cons wrote:
> On Mon, 27 Apr 2026 at 12:47, Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 24-04-26 21:53:14, Chuck Lever wrote:
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > >
> > > Upper layers such as NFSD need a way to query whether a
> > > filesystem handles filenames in a case-sensitive manner so
> > > they can provide correct semantics to remote clients. Without
> > > this information, NFS exports of ISO 9660 filesystems cannot
> > > advertise their filename case behavior.
> > >
> > > Implement isofs_fileattr_get() to report ISO 9660 case handling
> > > behavior via the FS_XFLAG_CASEFOLD flag. The 'check=r' (relaxed)
> > > mount option enables case-insensitive lookups, and this setting
> > > determines the value reported. By default, Joliet extensions
> > > operate in relaxed mode while plain ISO 9660 uses strict
> > > (case-sensitive) mode. All ISO 9660 variants are case-preserving,
> > > meaning filenames are stored exactly as they appear on the disc.
> > >
> > > Case handling is a superblock-wide property, so the callback
> > > must report the same value for every inode type. Regular files
> > > previously had no inode_operations; introduce
> > > isofs_file_inode_operations to carry the callback. Symlinks
> > > previously shared page_symlink_inode_operations; introduce
> > > isofs_symlink_inode_operations, which wires page_get_link
> > > alongside the callback, so that fileattr queries on a symlink
> > > reach the isofs implementation instead of returning
> > > -ENOIOCTLCMD. The flag is set in both fa->fsx_xflags and
> > > fa->flags so FS_IOC_FSGETXATTR and FS_IOC_GETFLAGS agree.
> > >
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >
> > ...
> >
> > > @@ -281,6 +293,18 @@ const struct file_operations isofs_dir_operations =
> > >  const struct inode_operations isofs_dir_inode_operations =
> > >  {
> > >       .lookup = isofs_lookup,
> > > +     .fileattr_get = isofs_fileattr_get,
> > > +};
> > > +
> > > +const struct inode_operations isofs_file_inode_operations =
> > > +{
> > > +     .fileattr_get = isofs_fileattr_get,
> > > +};
> > > +
> > > +const struct inode_operations isofs_symlink_inode_operations =
> > > +{
> > > +     .get_link = page_get_link,
> > > +     .fileattr_get = isofs_fileattr_get,
> > >  };
> >
> > Hum, I thought casefolding is a directory attribute. At least I don't see
> > a big point in reporting it for regular files or symlinks (and then why not
> > report it for device nodes or named pipes?). So why did you decide for this
> > change?
> 
> Where do you see this being a per-directory attribute in
> https://web.archive.org/web/20170404043745/http://www.ymi.com/ymi/sites/default/files/pdf/Rockridge.pdf

I wasn't refering to Rockridge standard but rather to the general way how
VFS tracks (and reports) casefolding.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

