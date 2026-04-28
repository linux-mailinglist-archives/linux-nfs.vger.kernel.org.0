Return-Path: <linux-nfs+bounces-21207-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN/OEDQX8GmNOQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21207-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 04:11:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AF447CA01
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 04:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0863330090A3
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 02:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB61B37267C;
	Tue, 28 Apr 2026 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pGsbQzS6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3EE2D5C8E;
	Tue, 28 Apr 2026 02:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777342257; cv=none; b=RUUkE5e1m0IDdh33dKb9+p1KLoRGgaW792lzp71e5aePIOBX/MgNQlcxTEx+pHiZGYDVNfNtKs++CJvdQnCiIoK6sE9SzEzlJ3y52F5AhZtDx19WBh2VNXJ3pa49kl2o0/qWosm0Knk/YKKNTY6upqbFKJDKIIcptmM62HHyQZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777342257; c=relaxed/simple;
	bh=ThxQYffEsRw+hGegjQyGnF06h6xZBuscCbqSAiDK2rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jt8O+UwdTo6lfAj2RtLmvjv8x8JHrckJFaJ0SrqpgBGktEvN4XkN6tjp6bW/psSltENzD7K6TrZRhCa2ikIsivb31QfT8KHBfmeUVl5P7gQ9jMJw1lcUCVEtlHeBNTbJQCCK9FSukawNcwIHrr0gfMy+a6vKyHTCBodBGqPagUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pGsbQzS6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S4TOlL9++e935CjmgoPHAxujN5GoF6v0bdjqBB6QqqQ=; b=pGsbQzS6eIBhlvewctZHFTAjSL
	3h5wc+zgnouaigl/hb5gW6h4BDzirg6IMBYbJrzdUnsG9C0zMRa5FRMfIzWj7qK2hWAJWgvhFatO5
	YeH7+7bt+uT0rp6fLmLjdHRgJqiG/ui19W6pyrHPPEZbo2j1JXURZ+s/ATKWeGO3z01E+9v6WQfPh
	Y0qSDQeo1lBJqEScObk+rKuesykCFozEDRL/Ca2HwA7uZuzNhpjU1GXtuIIhIHkqCmL4dgP79UBvX
	XvpegdMSC9Nf8Ws/oJEUgmys0vFy0EDiY+qOKMy6Bw9MrVb/EUYiYUZyDHON89kYY5DTvnkUyewkn
	19pbmNIw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wHXua-0000000FvBE-2ykq;
	Tue, 28 Apr 2026 02:10:56 +0000
Date: Tue, 28 Apr 2026 03:10:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/19] VFS: allow d_alloc_name() to be used with
 ->d_hash
Message-ID: <20260428021056.GT3518998@ZenIV>
References: <20260427040517.828226-1-neilb@ownmail.net>
 <20260427040517.828226-4-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427040517.828226-4-neilb@ownmail.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Queue-Id: C3AF447CA01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21207-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,suse.cz,szeredi.hu,gmail.com,ozlabs.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.org.uk:dkim]

On Mon, Apr 27, 2026 at 02:01:21PM +1000, NeilBrown wrote:

> +/**
> + * d_alloc_name: allocate a dentry for use in a dcache-based filesystem.
> + * @parent: dentry of the parent for the dentry
> + * @name: name of the dentry
> + *
> + * d_alloc_name() allocates a dentry without any protection against
> + * races.  It should only be used in directories that do not support
> + * create/rename/link inode operations and so is particularly suited for

Contemplate

const struct inode_operations efivarfs_dir_inode_operations = {
        .lookup = simple_lookup,
	.unlink = efivarfs_unlink,
	.create = efivarfs_create,
};

in fs/efivarfs/inode.c, please.

The only reason efivarfs is still playing with d_alloc() rather than
using simple_start_creating()/simple_done_creating() (and believe me,
I had been very tempted to kill that weirdness) is that exclusion in
there is deeply weird.

It *has* ->create() (and ->unlink(), while we are at it).  Both are
using efivar_lock().  And efivarfs_create_dentry() is called by
their iterator callbacks - called under efivar_lock().  So we can't
use anything like the regular exclusion in that case or we would
deadlock... or, at least, scare the living hell out of lockdep.

In reality there is an exclusion of very irregular sort - and it's
not entirely correct, at that.  It's based upon the fs freeze levels,
of all things - calls of ->create() and ->unlink() can't overlap with
calls of ->unfreeze_fs(), which is where that shite comes from after
the filesystem had been mounted.

Only it's not quite enough - O_RDONLY open() can bloody well race with
->unfreeze_fs() and pick dentry before we hit
        inode_lock(inode);
	inode->i_private = entry;
	i_size_write(inode, size + sizeof(__u32)); /* attributes + data */
	inode_unlock(inode);
in efivarfs_create_dentry(), oopsing on
static int efivarfs_file_open(struct inode *inode, struct file *file)
{
        struct efivar_entry *entry = inode->i_private;
 
        file->private_data = entry;
 
        inode_lock(inode);
        entry->open_count++;
this.

When the only reason for your extension is something that flat-out violates
the conditions of use you are putting into comment in the same commit...

That crap needs to be straightened out, but I would rather not mix that
into your series.

