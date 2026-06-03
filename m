Return-Path: <linux-nfs+bounces-22251-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id liRTG1N5IGoV4AAAu9opvQ
	(envelope-from <linux-nfs+bounces-22251-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 20:58:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D0E63AB2C
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 20:58:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.org.uk header.s=zeniv-20220401 header.b=lGDtasK6;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22251-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22251-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=zeniv.linux.org.uk;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87DE9307281F
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 18:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD94B47CC7A;
	Wed,  3 Jun 2026 18:53:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DAF477E53;
	Wed,  3 Jun 2026 18:53:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512808; cv=none; b=Dat67gsoXsXL3GXMd8JkpR63Kj977I58K7AoJD4YygMIUQFsr1oOBoRURXRsa5hFlvkwxeQU9y/k48vKi5+/L5SI2bhXkLGLpsDhO36fSlzhIEQSi9KIldkdqrBG69vZyeW1YR28igE2Y5ytzc+5i4iXSLfFs26Ph0krDiDrSCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512808; c=relaxed/simple;
	bh=K2DEgpRpwOJi+UD5qGXHaG4TcMBVOTr+6U/sjZHEEkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aY8DHTmwPYdoLksUvO2RmY0wtgucjRNZpkuC1lO+wdhncXtCdF9WdIbTDY34apM/Q8nc2dB/92HqIEE0COXt7EAHHEwnq0op0p6RH6DusqwdW6y/2vD1Uojm+aRMd0hElXl0xAZQ1rh+9OANKxZprZx9bcfRTFGxP/orj4yS5+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lGDtasK6; arc=none smtp.client-ip=62.89.141.173
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=BnV94cT53Rbz4Slhp0utYBCUS9p15JXjHvFb5MlM7Qs=; b=lGDtasK6I0razSv00WGBuIB2SX
	n3RjjNTXMsJ2apU8LPUu5e9RvPFj31fnfwECExgqEDRNjadGf/nGk6XbcJiATqLmqSOlpMXUC+SUE
	e8jw9cvmO0JLqBgTmxITScCg3mPFDjgFQ7eFafkq/zuVMr01KEI0shvSJvU1YKiYgFHqOssJgDiiD
	LlXma5ZzF+Yg6hfjOteeiGj39Cvipzz1d/XDfIgEv9gAFl5GqtPZkXbRJgLgDfAxLsfU8opPk0y61
	zgt9eVyQbHP4TKM18uVW3VXRZYdzkMUoXfRUlD/v8Qlk0XW0LpdtZYtuc8sOUncwd6rYaQ1ad8Iwx
	iLXLAoaw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUqiS-0000000FCms-1mmu;
	Wed, 03 Jun 2026 18:53:24 +0000
Date: Wed, 3 Jun 2026 19:53:24 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] fhandle: fix UAF due to unlocked ->mnt_ns read in
 may_decode_fh()
Message-ID: <20260603185324.GA2636677@ZenIV>
References: <20260603-vfs-fhandle-uaf-fix-v1-1-ff64ee367e4d@google.com>
 <20260603181523.GW2636677@ZenIV>
 <20260603182454.GX2636677@ZenIV>
 <CAG48ez0Jte3UE8wn9Ljs3o2uVDFB24Zbp9zBdaj+D5c4R0+TSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0Jte3UE8wn9Ljs3o2uVDFB24Zbp9zBdaj+D5c4R0+TSQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22251-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,oracle.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jannh@google.com,m:brauner@kernel.org,m:jack@suse.cz,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[viro@zeniv.linux.org.uk,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.org.uk:email,linux.org.uk:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2D0E63AB2C

On Wed, Jun 03, 2026 at 08:46:07PM +0200, Jann Horn wrote:
> On Wed, Jun 3, 2026 at 8:24 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Wed, Jun 03, 2026 at 07:15:23PM +0100, Al Viro wrote:
> > > On Wed, Jun 03, 2026 at 07:38:06PM +0200, Jann Horn wrote:
> > >
> > > > Fix it by taking rcu_read_lock() around the mount::mnt_ns access, like
> > > > in __prepend_path().
> > >
> > > > +   /*
> > > > +    * Containing namespace.
> > > > +    * Normally protected by namespace_sem, but there are also lockless
> > > > +    * readers (which must use RCU to guard against the namespace being
> > > > +    * freed).
> > > > +    */
> > > > +   struct mnt_namespace *mnt_ns;
> > >
> > > Umm...  It's somewhat subtle - at the very least you need to explain why
> > > there will be an RCU delay between umount_tree() clearing that and
> > > having the sucker freed.
> >
> > Something along the lines of "removals from namespace are serialized on
> > namespace_sem and guaranteed to happen no later than the active
> > refcount on namespace reaches zero; freeing of namespace happens only
> > after the passive refcount hitting zero and there's an RCU delay between
> > dropping the last active ref and dropping the passive one that had been
> > implicitly held by the fact of having actives", perhaps?  Only in
> > more readable form than that, please...
> 
> Hm, like this?
> 
> Containing namespace (active).

Umm...  That's actually "active or has _just_ dropped the last active
reference and didn't get around to scheduling decrement of passive refcount
yet", unfortunately.

Hell knows - "active or deactivating", perhaps?

