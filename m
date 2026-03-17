Return-Path: <linux-nfs+bounces-20232-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EixNTEnuWm1sQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20232-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 11:04:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAE12A7752
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 11:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 270CE306DA7D
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 10:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C874D3A4F5A;
	Tue, 17 Mar 2026 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oZJ3/cY6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z8+9L0n+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CX35RV4c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t/jEKk2C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A909C3A4F37
	for <linux-nfs@vger.kernel.org>; Tue, 17 Mar 2026 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741654; cv=none; b=o3EmcF7GduaJ82pueIRGrkB6aRgh8iuElc9epWBOxA0BMDGUKOAe1jgeRGtAopMUuWMGBPnnMgLkicxcTwxiLejR08eIuGu2qqQvq3pz68ZqNbM4Vhci9uy4QTpcS601qGf6Ri+wKYT/0AmyASiGjxDTOXmltJ7MrQf7JVp79nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741654; c=relaxed/simple;
	bh=xQClvtHmcR6w8TrLUiGiLIoF7WZTm3EhitOCJri8BXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8cGIGiYsdRS/JFLR4Q0Qp/rnlsfpW8TKZ6DFKKD//wez1tmryJP+cdKUn+0rergmjdv4rJ4DuD7s/dJeRlqXSkcvm5qiQ72bjQOFotSDYAvZFQvg0gIY0GRFIiTe/gzlSNPfDzV7w/vsLkhKD5xXLpUrgZSZQ+cON5TstVPYlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oZJ3/cY6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z8+9L0n+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CX35RV4c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t/jEKk2C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9C3725BDB1;
	Tue, 17 Mar 2026 10:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773741643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3NxxYZ0Z73C+D6nMp9RM66Emm5gr807GrvA6Zh/dc0A=;
	b=oZJ3/cY6ydGUBsEkcn4dEP5dVa8+6N5TCpbl/uoiRyk4zmmW7J9KBCWw5LYg5qJ9sSUBYN
	kDXicji+Mmuu83eTS1GuU5bfaeUnybdFqqkL+Jwnv/gBugxmNyvsnLCjytkBMSabdBzeo2
	pLuxV3JV9Bq7GlVOwyPPk0QMnb/TzHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773741643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3NxxYZ0Z73C+D6nMp9RM66Emm5gr807GrvA6Zh/dc0A=;
	b=z8+9L0n+2BvyNILizCEGBPcuF7FXAXX68hzMw03OLmlBtux01ucO78gQQUP6lspoRnVAHU
	fjJTL+Fs+WzbkkBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CX35RV4c;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="t/jEKk2C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773741638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3NxxYZ0Z73C+D6nMp9RM66Emm5gr807GrvA6Zh/dc0A=;
	b=CX35RV4cPd92rVX9pIFlpypFdx5RdDbqy0m6JgL3N9BAb1bDqCFP/C0Zs6abuDaJbL268b
	RKMPUfa+HwHLtaL4MRvpjsvnT/cJx39tZuQLpkJt2PNatB2G8g6k6iWLCggoPL5w+fPupt
	OQrs5XNahoIFDxhNI9Hmnmsh9lYPs30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773741638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3NxxYZ0Z73C+D6nMp9RM66Emm5gr807GrvA6Zh/dc0A=;
	b=t/jEKk2CCIPbv8gHZqK1jU4ncUvF5g0vCKqzpoNhRGjc3w+LQQ99i+VJ4D9TTFrf362JNo
	vbna+wrOzVfO1uAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 833EB4273C;
	Tue, 17 Mar 2026 10:00:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZhkGIEYmuWn0SwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Mar 2026 10:00:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 40DE4A0AB1; Tue, 17 Mar 2026 11:00:34 +0100 (CET)
Date: Tue, 17 Mar 2026 11:00:34 +0100
From: Jan Kara <jack@suse.cz>
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Jan Harkes <jaharkes@cs.cmu.edu>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Steve French <sfrench@samba.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Tyler Hicks <code@tyhicks.com>, Andreas Gruenbacher <agruenba@redhat.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, coda@cs.cmu.edu, linux-mm@kvack.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	ecryptfs@vger.kernel.org, gfs2@lists.linux.dev, linux-um@lists.infradead.org, 
	linux-efi@vger.kernel.org
Subject: Re: [PATCH 32/53] ext4: move dcache modifying code out of
 __ext4_link()
Message-ID: <imo3cvhqtvginngr2ofsotmrsxixutn2jagbkj6322cfgxm3lj@wosdq3xvlym5>
References: <20260312214330.3885211-1-neilb@ownmail.net>
 <20260312214330.3885211-33-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312214330.3885211-33-neilb@ownmail.net>
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
	TAGGED_FROM(0.00)[bounces-20232-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_CC(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,cs.cmu.edu,google.com,linux.alibaba.com,redhat.com,auristor.com,samba.org,samsung.com,sony.com,debian.org,mit.edu,dilger.ca,goodmis.org,dubeyko.com,tyhicks.com,nod.at,cambridgegreys.com,sipsolutions.net,ozlabs.org,vger.kernel.org,kvack.org,lists.infradead.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4BAE12A7752
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri 13-03-26 08:12:19, NeilBrown wrote:
...
> diff --git a/fs/dcache.c b/fs/dcache.c
> index a1219b446b74..c48337d95f9a 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -358,7 +358,7 @@ static inline int dname_external(const struct dentry *dentry)
>  	return dentry->d_name.name != dentry->d_shortname.string;
>  }
>  
> -void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry)
> +void take_dentry_name_snapshot(struct name_snapshot *name, const struct dentry *dentry)
>  {
>  	unsigned seq;
>  	const unsigned char *s;

The constification of take_dentry_name_snapshot() should probably be a
separate patch? Also I'd note that this constification (and the
constification of __ext4_fc_track_link()) isn't really needed here because
ext4_fc_track_link() will immediately bail through ext4_fc_disabled() when
fast commit replay is happening so __ext4_fc_track_link() never gets called
in that case - more about that below.

> @@ -1471,7 +1471,15 @@ static int ext4_fc_replay_link_internal(struct super_block *sb,
>  		goto out;
>  	}
>  
> +	ihold(inode);
> +	inc_nlink(inode);
>  	ret = __ext4_link(dir, inode, dentry_inode);
> +	if (ret) {
> +		drop_nlink(inode);
> +		iput(inode);
> +	} else {
> +		d_instantiate(dentry_inode, inode);
> +	}
>  	/*
>  	 * It's possible that link already existed since data blocks
>  	 * for the dir in question got persisted before we crashed OR
...
> @@ -3460,8 +3460,6 @@ int __ext4_link(struct inode *dir, struct inode *inode, struct dentry *dentry)
>  		ext4_handle_sync(handle);
>  
>  	inode_set_ctime_current(inode);
> -	ext4_inc_count(inode);
> -	ihold(inode);
>  
>  	err = ext4_add_entry(handle, dentry, inode);
>  	if (!err) {
> @@ -3471,11 +3469,7 @@ int __ext4_link(struct inode *dir, struct inode *inode, struct dentry *dentry)
>  		 */
>  		if (inode->i_nlink == 1)
>  			ext4_orphan_del(handle, inode);
> -		d_instantiate(dentry, inode);
> -		ext4_fc_track_link(handle, dentry);
> -	} else {
> -		drop_nlink(inode);
> -		iput(inode);
> +		__ext4_fc_track_link(handle, inode, dentry);

This looks wrong. If fastcommit replay is running, we must skip calling
__ext4_fc_track_link(). Similarly if the filesystem is currently
inelligible for fastcommit (due to some complex unsupported operations
running in parallel). Why did you change ext4_fc_track_link() to
__ext4_fc_track_link()?

> @@ -3504,7 +3498,16 @@ static int ext4_link(struct dentry *old_dentry,
>  	err = dquot_initialize(dir);
>  	if (err)
>  		return err;
> -	return __ext4_link(dir, inode, dentry);
> +	ihold(inode);
> +	ext4_inc_count(inode);

I'd put inc_nlink() here instead. We are guaranteed to have a regular file
anyway and it matches what we do in ext4_fc_replay_link_internal().
Alternatively we could consistently use ext4_inc_count() &
ext4_dec_count() in these functions.

> +	err = __ext4_link(dir, inode, dentry);
> +	if (err) {
> +		drop_nlink(inode);
> +		iput(inode);
> +	} else {
> +		d_instantiate(dentry, inode);
> +	}
> +	return err;
>  }

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

