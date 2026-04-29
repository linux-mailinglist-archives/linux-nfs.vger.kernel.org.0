Return-Path: <linux-nfs+bounces-21265-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GHnE8pw8WlugwEAu9opvQ
	(envelope-from <linux-nfs+bounces-21265-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 04:45:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AF148E67F
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 04:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 185843029A61
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 02:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A2B3009F6;
	Wed, 29 Apr 2026 02:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="p7nwm/KU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rFQ3e9nP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903F3155C82;
	Wed, 29 Apr 2026 02:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777430710; cv=none; b=taO+amnCM8nrVLB95P0EvZQK2H/6qRLJ7siLSufm6Uw8L7/kySuO6dTXhrW2ryOB86LXfSbTsgwerlGkHzy1RPbXwSi/kC46PkY4t+acQAf0BYbmOor7lZ9Hlwl88BDoX5DY6WhhJ+2nniDfCR6JGUtJy0wvXCEl7sqQ8/2M0j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777430710; c=relaxed/simple;
	bh=3d3Yo2f3R2b21NrQLFyvL05Vr223aLnO/9/cEzxxYzM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Q0n9kDwgjgjclpXKIkxNDxh+kbK5O8BR70jsu3cLpd96cQFTnYWQj/e7Tm5CrdzLjTmm3r1vlzubF1706Zcu7zfag9ogmhOlnhyafa3BvDl9bS4WI4LIQULoo2wIf6LBBCLaktQpJ5i1y46dx6375BxmDbU723i3OyiHfWgP5qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=p7nwm/KU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rFQ3e9nP; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D87F11D0024D;
	Tue, 28 Apr 2026 22:45:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 28 Apr 2026 22:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1777430706; x=1777517106; bh=IgNWooArhzvjLyvBO/WwleTTd7lAHOuXMbe
	7gFvne3Q=; b=p7nwm/KU0LfVv93I78CJN6KUYaqq/jUdOANaYc3NtyrBvQWqRdL
	y6VYFhpA0gezPhHKRmL+HgrJn7GrJArqpJ2mn9XCuQjzEuZ01i9ED8RKwR7PiB4V
	oYrHCEr5SuYO0DBM0W8kbJYXCPM5dKQlpgqyV0Qxh4zWqTRKXcGgIf2hFOV7AFIj
	WmYWE83H5O8DwjlBNHvTWJbl+l9KN6QWeIOkRxBhjNNIPW/1poEmAI/TpRumPW0s
	Xi0QUayhtuEf7MFNtnmmEBVt6CIxggKBcT3uiWzyBZ+S/nASWMm/EBaccknBfICx
	T871QYJMJqCg+HAZq8sv+9ADQ8fRZ07AvmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777430706; x=
	1777517106; bh=IgNWooArhzvjLyvBO/WwleTTd7lAHOuXMbe7gFvne3Q=; b=r
	FQ3e9nP0I6fHqh5HWTn5X3bhFV1Z8lBPMPTftkWxm3jEMAvH8mpLwjgCUqybTer3
	ve6fNDF0rGZ8utGKR8/uY5tBmkn/HHEt2EpsNmT1ik0SAKbJS5ZmR+59pjw4hLHv
	DPX9Y+IJQY9UiJnH+Lk3nJVfTNLL9wFoiMlFFlu7GWsrnU5h+FhORFRnygo8ePgF
	bT/SWXt+qDe4W4tKoiPjo1iIUAPzkpU/T6PLM4NzTyWcGR+rC1xdhjtdxNbTWCu3
	QWu3ht4qTY1Ea4XIXkLm9OEAePTG/mfpTL7cOSmbkimFBoAzgXPKy8G8qnmubWq6
	HiGZFO7OVqV1uP37Wdw2g==
X-ME-Sender: <xms:sXDxadHzIfU3N7aa2S37MxWbYeeIClOxzILrQ1T6r-eTdf3p8nqSvQ>
    <xme:sXDxaepfsJBkM3aAX8hR-d02doK8r8aXCaxnNJVnvjG6iUMASG6pzGFtur22FNK9Y
    NbCu32T4bSdsVEV8F164EYgLSJpE2Z10W1-NDM3g852LQGbeA>
X-ME-Received: <xmr:sXDxaQy18iJRtg2ZCzSJlMLJEFvjuX0gqV1zzFE2yHBMTEA-hcS1AaHDqZfCwd2-dFkyK7QOk1JwgF22KSCnNdaaSbX7DAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekfedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthejredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duteefhfduveehvdefueefvdffkeevkefgtdefgffgkeehjeeghfetiefhgffgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtg
    hksehsuhhsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:sXDxaQOdVIhmLRs9nKbtliIgoyum2MAwu7TGRoZoW1_f1x217GAKzA>
    <xmx:sXDxaYcovSwn_b6cOlIAA2zTO4r3eLnRtZXnnQ4dCAcieKyMInhn5Q>
    <xmx:sXDxaU5kDZDoUC4jcSvRpgQG794X2aQweZrTzt7bJFotWPlP41S3hg>
    <xmx:sXDxaQJ8eYYD5jEvGCFesGeDFHryJSTKsLCVuPU0Xp2naqHhP6lxhQ>
    <xmx:snDxaR0O5E74WchCjezMFGP3PmZsNz4y0jXWiXTUK7sHnlIimznPiorp>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Apr 2026 22:45:00 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Jeff Layton" <jlayton@kernel.org>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Miklos Szeredi" <miklos@szeredi.hu>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jeremy Kerr" <jk@ozlabs.org>,
 "Ard Biesheuvel" <ardb@kernel.org>, linux-efi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3 03/19] VFS: allow d_alloc_name() to be used with ->d_hash
In-reply-to: <20260428021056.GT3518998@ZenIV>
References: <20260427040517.828226-1-neilb@ownmail.net>
  <20260427040517.828226-4-neilb@ownmail.net>
  <20260428021056.GT3518998@ZenIV>
Date: Wed, 29 Apr 2026 12:44:57 +1000
Message-id: <177743069784.1474915.857167561824713821@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: E8AF148E67F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21265-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,suse.cz,szeredi.hu,gmail.com,ozlabs.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCPT_COUNT_TWELVE(0.00)[16];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,noble.neil.brown.name:mid,ownmail.net:dkim,brown.name:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, 28 Apr 2026, Al Viro wrote:
> On Mon, Apr 27, 2026 at 02:01:21PM +1000, NeilBrown wrote:
> 
> > +/**
> > + * d_alloc_name: allocate a dentry for use in a dcache-based filesystem.
> > + * @parent: dentry of the parent for the dentry
> > + * @name: name of the dentry
> > + *
> > + * d_alloc_name() allocates a dentry without any protection against
> > + * races.  It should only be used in directories that do not support
> > + * create/rename/link inode operations and so is particularly suited for
> 
> Contemplate
> 
> const struct inode_operations efivarfs_dir_inode_operations = {
>         .lookup = simple_lookup,
> 	.unlink = efivarfs_unlink,
> 	.create = efivarfs_create,
> };
> 
> in fs/efivarfs/inode.c, please.
> 
> The only reason efivarfs is still playing with d_alloc() rather than
> using simple_start_creating()/simple_done_creating() (and believe me,
> I had been very tempted to kill that weirdness) is that exclusion in
> there is deeply weird.
> 
> It *has* ->create() (and ->unlink(), while we are at it).  Both are
> using efivar_lock().  And efivarfs_create_dentry() is called by
> their iterator callbacks - called under efivar_lock().  So we can't
> use anything like the regular exclusion in that case or we would
> deadlock... or, at least, scare the living hell out of lockdep.
> 
> In reality there is an exclusion of very irregular sort - and it's
> not entirely correct, at that.  It's based upon the fs freeze levels,
> of all things - calls of ->create() and ->unlink() can't overlap with
> calls of ->unfreeze_fs(), which is where that shite comes from after
> the filesystem had been mounted.
> 
> Only it's not quite enough - O_RDONLY open() can bloody well race with
> ->unfreeze_fs() and pick dentry before we hit
>         inode_lock(inode);
> 	inode->i_private = entry;
> 	i_size_write(inode, size + sizeof(__u32)); /* attributes + data */
> 	inode_unlock(inode);
> in efivarfs_create_dentry(), oopsing on
> static int efivarfs_file_open(struct inode *inode, struct file *file)
> {
>         struct efivar_entry *entry = inode->i_private;
>  
>         file->private_data = entry;
>  
>         inode_lock(inode);
>         entry->open_count++;
> this.

I don't see the problem.

An O_RDONLY open will either find something in the dcache which will be
fully initialised, or it will hit simple_lookup() which will make the
dentry negative, and the open will fail.

If the lookup races with efivarfs_check_missing() calling
efivarfs_create_dentry() then you could end up with two dentries in the
dcache with the same name.  One from open/simple_lookup/d_add which is
negative and one from efivarfs_create_dentry/d_alloc/d_make_persistent
which is fully initialised (d_make_persistent() isn't called until after
->i_private is initialised).
The former will be negative and later in the hash chain.
The latter will be positive and earlier in the hash chain.
The former will soon disappear because of DCACHE_DONTCACHE.
The latter will be found by subsequent lookups.
This might be a bit unorthodox, but is not problematic.

> 
> When the only reason for your extension is something that flat-out violates
> the conditions of use you are putting into comment in the same commit...

Yes, that condition is a little too simplistic.

 * d_alloc_name() allocates a dentry without any protection against
 * races.  It should only be used in directories that use simple_lookup
 * and when create/rename/link inode operations cannot be called, either
 * because they don't exist or because some locking prevents it.
 * d_alloc_name() is particularly suited for use with
 * simple_dir_inode_operations but can also be used freely in
 * fill_super/get_tree context and with some care when the filesystem
 * is frozen.
 *
 * The result of d_alloc_name() is typically passed to d_make_persistent().


> 
> That crap needs to be straightened out, but I would rather not mix that
> into your series.
> 

I can drop this change for now.  I only wanted it so that I could remove
the EXPORT of d_alloc() but I am comfortable delaying that.

Thanks,
NeilBrown

