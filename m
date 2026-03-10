Return-Path: <linux-nfs+bounces-19905-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG4kLOYAsGm0eQIAu9opvQ
	(envelope-from <linux-nfs+bounces-19905-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 12:30:46 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5620824AE02
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 12:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90C7E32645AD
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 11:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9156C3876DE;
	Tue, 10 Mar 2026 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkOoejQb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689413876B0;
	Tue, 10 Mar 2026 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141858; cv=none; b=VeTUd4UCVxmrskyMzm87HzIkcQDWfwEELIyEPvzvjZ1z/CToxLjseW9v+5dVrxC0FspmgHKpOYBnGHonHhNYInGF6TpRY3/09ZBDNDsEQ+UforgiDsXIBUu7r+p5CxXdnNwcjB9NiEZ0c6dOD6zKDewFZT5C95Rk+QSbiaE9NP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141858; c=relaxed/simple;
	bh=xT53Ttf/NyogikS/gfdkFymB7LtDXRO0Yz6j+bwKsPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aX1r5lG+WDjqGkk0Fwqqs1hScgJi2aitgJJMRJiBwd2iN1Yn+leS1n+Ocle9dUuoq/aZRRv8QyaTfSaIqHHb0GsFiE2JNGWQHzztFTZdLlqS7cLwTQq3n+LEpqNaqTZtmSs2KQ3Ebcwg2PJ00Bj8qnW5qMgigTuTWtOeqo/7388=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkOoejQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8497BC19423;
	Tue, 10 Mar 2026 11:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141858;
	bh=xT53Ttf/NyogikS/gfdkFymB7LtDXRO0Yz6j+bwKsPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JkOoejQbIY5sFLhLxCkOVN4kxiKJQN7lTCbiqMhI2bPYZCWqCDH0QcPHkf9E94N1P
	 jGKWxOZDnrBvfZwk3KlNfSPE8lrfyGUmy/E8KZRXnZ3WA2W+jaNVCXVB0fdXzl2Epk
	 xdyGfd3tLRQx0V4K/FAplurzOKD4T7ZCDXJbb1/yW+bnAtN/DEPHfz+j7RrHKIT4et
	 mst/xUtfedv4qkVcmjou7az+d7Do3wm3dxVhtCDP9L1/BM2ZP0qghkq/jyHg4SSkSp
	 MiB5UsygHd+YPYVvodLr6rfXKh/5Fgbcu9NvSb0LZNXu/UpDt3L4jAOcvxUwz9rzo4
	 xluXx/3QcCvGA==
Date: Tue, 10 Mar 2026 12:24:05 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Jeff Layton <jlayton@kernel.org>, 
	Dorjoy Chowdhury <dorjoychy111@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, 
	smfrench@gmail.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, trondmy@kernel.org, 
	anna@kernel.org, sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, shuah@kernel.org, 
	miklos@szeredi.hu, hansg@kernel.org
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
Message-ID: <20260310-ausdehnen-wahrnehmen-f9d9c6224799@brauner>
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com>
 <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
 <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
 <CALCETrVt7o+7JCMfTX3Vu9PANJJgR8hB5Z2THcXzam61kG9Gig@mail.gmail.com>
 <20260309-umsturz-herfallen-067eb2df7ec2@brauner>
 <CALCETrWjb+V-zrMT412MtmgDCx9y8simJBQ7+45C9MtdiSMnuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrWjb+V-zrMT412MtmgDCx9y8simJBQ7+45C9MtdiSMnuw@mail.gmail.com>
X-Rspamd-Queue-Id: 5620824AE02
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19905-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,oracle.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 09:50:18AM -0700, Andy Lutomirski wrote:
> On Mon, Mar 9, 2026 at 1:58 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Sun, Mar 08, 2026 at 10:10:05AM -0700, Andy Lutomirski wrote:
> > > On Sun, Mar 8, 2026 at 4:40 AM Jeff Layton <jlayton@kernel.org> wrote:
> > > >
> > > > On Sat, 2026-03-07 at 10:56 -0800, Andy Lutomirski wrote:
> > > > > On Sat, Mar 7, 2026 at 6:09 AM Dorjoy Chowdhury <dorjoychy111@gmail.com> wrote:
> > > > > >
> > > > > > This flag indicates the path should be opened if it's a regular file.
> > > > > > This is useful to write secure programs that want to avoid being
> > > > > > tricked into opening device nodes with special semantics while thinking
> > > > > > they operate on regular files. This is a requested feature from the
> > > > > > uapi-group[1].
> > > > > >
> > > > >
> > > > > I think this needs a lot more clarification as to what "regular"
> > > > > means.  If it's literally
> > > > >
> > > > > > A corresponding error code EFTYPE has been introduced. For example, if
> > > > > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > > > > > param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> > > > > > like FreeBSD, macOS.
> > > > >
> > > > > I think this needs more clarification as to what "regular" means,
> > > > > since S_IFREG may not be sufficient.  The UAPI group page says:
> > > > >
> > > > > Use-Case: this would be very useful to write secure programs that want
> > > > > to avoid being tricked into opening device nodes with special
> > > > > semantics while thinking they operate on regular files. This is
> > > > > particularly relevant as many device nodes (or even FIFOs) come with
> > > > > blocking I/O (or even blocking open()!) by default, which is not
> > > > > expected from regular files backed by “fast” disk I/O. Consider
> > > > > implementation of a naive web browser which is pointed to
> > > > > file://dev/zero, not expecting an endless amount of data to read.
> > > > >
> > > > > What about procfs?  What about sysfs?  What about /proc/self/fd/17
> > > > > where that fd is a memfd?  What about files backed by non-"fast" disk
> > > > > I/O like something on a flaky USB stick or a network mount or FUSE?
> > > > >
> > > > > Are we concerned about blocking open?  (open blocks as a matter of
> > > > > course.)  Are we concerned about open having strange side effects?
> > > > > Are we concerned about write having strange side effects?  Are we
> > > > > concerned about cases where opening the file as root results in
> > > > > elevated privilege beyond merely gaining the ability to write to that
> > > > > specific path on an ordinary filesystem?
> >
> > I think this is opening up a barrage of question that I'm not sure are
> > all that useful. The ability to only open regular file isn't intended to
> > defend against hung FUSE or NFS servers or other random Linux
> > special-sauce murder-suicide file descriptor traps. For a lot of those
> > we have O_PATH which can easily function with the new extension. A lot
> > of the other special-sauce files (most anonymous inode fds) cannot even
> > be reopened via e.g., /proc.
> 
> On the flip side, /proc itself can certainly be opened.  Should
> O_REGULAR be able to open the more magical /proc and /sys files?  Are
> there any that are problematic?

If procfs job isn't to provide problematic files to userspace I'm not
sure what it is. Joking aside, I think in general you are of course
right that procfs is full of files that under a very strict
interpretation of "regular file" should absolutely not count as a
regular file. sysfs probably as well and let's ignore debugfs and
tracefs and all the other magic filesystems or files.

In general, Linux has been so loosey-goosey with "regular file" for such
a long-time that making OPENAT2_REGULAR come up with some strict
definition of "this is a regular file - no really, pinky-promise a
regular one" - is just doomed to fail.

The other problem is that we cannot reasonably determine what odd file
the user really wanted to defend against opening with OPENAT2_REGULAR.
A caller may really want to open /proc/kmsg and just be sure that
someone didn't overmount it with a fifo (systemd does that in containers
iirc).

My personal "hot take" is that adding an api built around a regular file
with immediate irreversible side-effects for the caller on VFS
syscall-based open [1] is a bug. Such broken semantics is what ioctl()s
are for.

[1]: I mean specifically open(), openat2() etc. I'm excluding all
     dedicated APIs that return file descriptors that cannot be reopened
     via regular lookup.

From my pov, what would help is if one had a flexible way to scope opens
on e.g., filesystem. But imo, that is not policy the kernel can
reasonably express at the syscall api layer - it would look fugly as
hell and how many other knobs would we have to add to satisfy all needs.
I think that is best left to an lsm hooking into security_file_open()
which can maintain a map of files and filesystems to allow or deny - a
bpf lsm can do this quite nicely.

