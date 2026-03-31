Return-Path: <linux-nfs+bounces-20575-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLHGGUxIzGmmSAYAu9opvQ
	(envelope-from <linux-nfs+bounces-20575-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 00:18:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C132A3725B1
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 00:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA81F30315F0
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 22:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112CA45BD5F;
	Tue, 31 Mar 2026 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y51MMX82"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDBC43CECA
	for <linux-nfs@vger.kernel.org>; Tue, 31 Mar 2026 22:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774995392; cv=none; b=Sy9nuL8MhfU7/Z79fVgh0Y05gwsQqG8fDeIXacsiJtmulIwPoXDzX7X9Tk0PXnQefHLnIbOQ6B6XVh0Z8n5P+LLKC+SfzhvPf2+kgEzaB3yYW0wpYbRbKyw8+VELfZXqtJGqe0J+sCsOxhmzdkzzjps+ugaa3ZkRSJh2ldoV+I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774995392; c=relaxed/simple;
	bh=cea1+TCCNb5SH82ew0kDq0UxHB9U6cN12pLdZBuraV0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/GfAhi1qpgT3ECgB/m0IDXbkOknm0K3ZhY4lYHtDbkF+UwDDUeUzaOPyWONebfzM+QjWp49QIIf5Q2PGAJbFWZ0IW8m5ypKB1GOfpwDj3iWNVxGmgHXnI0r6N7SQsPhc/TiBYGjvLyAE1a8xzb9aW8WKnAWQwBu5C5u3H8zBAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y51MMX82; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d86eb7c854so3310467a34.3
        for <linux-nfs@vger.kernel.org>; Tue, 31 Mar 2026 15:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774995389; x=1775600189; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F7DUVhhz3wpKEW/XuFl08bRr8Fi4ShMP8tD1A31Pw3g=;
        b=Y51MMX82MBAn16T4oU9nafbTHrluiAfk+ktpVJzXNlTfqfQLnmx4Pa3p2KvmjUS6St
         FJVqSQM5fURXIcn+J93ro+f9+exmkUrzRsA3yOOzMsMr1gC1ITkX4KZJ3T9EWwOxI6pi
         K5hwvBnOLmfr9RHfx0EDKZIXdiX2WINMJrVhFpIkm1JvggsvhSbXgkb5/+Iuslas8a5X
         sKvTwOZiVjDKc3QJvkYCznH/g335yvHENkX1kVCLWwg58WPHR9HRU2BYMvwLo2m1/ru2
         wXDNiR8qCIotO43f6qY+2+Knr8BDkWXfaJxdde8hMzCV/or3hgeVx7VLEa4ikYuDsBBp
         yzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774995389; x=1775600189;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7DUVhhz3wpKEW/XuFl08bRr8Fi4ShMP8tD1A31Pw3g=;
        b=N3gmqzhxuX4YAg9gFv2g6S4GhJ74x6UcvTOL2ZI6Ab6q1ZS14IDwV/Os0/dxwcDLvq
         fB8kSHME5uyrPRbx+HpqU8yYA1jDwGCx+z0w3YCkLPa6oD1wBjlQYA52+wrBK+Sx7cKz
         IMs5eEMH31sqbp1zSm4ZNBo88pT9zXA5VHSbFewtLg9S+8u3nPFR7JMD+lIvczRi/7PM
         HMy/i7nQYIg+32JhBsbNgg1MLsiaOZZ9rLQCJvdyvSI9C9mROb0eCWJNwAmTgv/sF0Gm
         rey1Cu2BuJy+XFxJYlThHeJtztWZ9Bgj+NvT0Bc7WH2XoRG5mM3lZd0XyjQgkSiqfgAI
         5Vng==
X-Forwarded-Encrypted: i=1; AJvYcCUL4lm2fsvNHBviadI9iaTphkBTyddh+pGBoRtwq1beGzbVdf5uCH4+hQE4LNDch2l3T1PEoIMQb/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9R3Kxz0uQy2ZZO0aHamQ+A4B3srJb0/9SRP8QxjqJAZ9mkH+3
	V5o/D+kK6WII+sQbONfROfFLDiAhwRWsrQy9q7fdaoYWrO0ipMRXAXEz
X-Gm-Gg: ATEYQzyFyM1x9Q8q8Qk/fTwBPugEmaAVHl5nGvkFg3wr8SVGKWVRxWMaBBVPUcGvLU/
	nJwO23BRbcBUp0Jbta0YIMr2Zs/fBVZ+uPzS+hpA4QKzoBS0qT+Wgt8f9z24l0a1NX3VLdBWxk5
	wTahQ+0ZRAj9ytwsgcx22YLIL/eImQPoy57PBRY46QiepkVdzySJkuq3geshW+RkcR0KnwPeU/D
	v4cEeUAY2ATnSK4TTxx62D+86LELPHUo9Ab42Et83HsIK5KybbopJgGmXH+e1T3h6cRbz2YRxQk
	uT/Jcmdp5RenC4aZuTV1so91wY5JUVS84ivKa6xx+yECQ1fpzQT9mvQjJ59ydDyFw2YG3nnTzeg
	wugPJig8SSUGCuA/PZTSGjYWlKsL4BAf1kdRP1WCw1musL9uv37ShNpMs9Hh5LjsDvd5sUoMs3D
	8SEwrl5nGZIM9w09TObQIcfM67NbCZ4xE=
X-Received: by 2002:a05:6820:198a:b0:679:97ac:2cc3 with SMTP id 006d021491bc7-67fabc2480fmr582296eaf.22.1774995388952;
        Tue, 31 Mar 2026 15:16:28 -0700 (PDT)
Received: from localhost ([12.117.181.174])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e231cb2e2sm7368644eaf.12.2026.03.31.15.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 15:16:28 -0700 (PDT)
From: Thomas Haynes <loghyr@gmail.com>
X-Google-Original-From: Thomas Haynes <loghy@gmail.com>
Date: Tue, 31 Mar 2026 15:16:25 -0700
To: Jeff Layton <jlayton@kernel.org>
Cc: Thomas Haynes <loghyr@gmail.com>, Olga Kornievskaia <aglo@umich.edu>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nfs: update inode ctime after removexattr
 operation
Message-ID: <acxGNz07W03ijzM2@mana>
References: <20260324-nfs-7-1-v2-0-d110da3c0036@kernel.org>
 <20260324-nfs-7-1-v2-2-d110da3c0036@kernel.org>
 <CAN-5tyFpsuE9+5ZvAASwvTYKtcN5jNpAxi8ejde90e-vpUzFKg@mail.gmail.com>
 <284ca17e74af8c4f5942b2952f2bf75490dd17c0.camel@kernel.org>
 <CAN-5tyFsEUcSUycb4JjxH5v754SefwOH=zt24KtxEC_Ow4OjMw@mail.gmail.com>
 <80b423c66dba84b46be1084307d2c66b935065bc.camel@kernel.org>
 <acbJsryTMYCMlE_o@mana>
 <13f1fd90b75c73e8d5220dadb6eb9d9473bc96e8.camel@kernel.org>
 <acwVE5ZoPPLFQCLT@mana>
 <a23b715677db8553061da684fc047185e328121b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a23b715677db8553061da684fc047185e328121b.camel@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,umich.edu,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20575-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loghyr@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C132A3725B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 05:19:33PM -0800, Jeff Layton wrote:
> On Tue, 2026-03-31 at 11:47 -0700, Thomas Haynes wrote:
> > On Tue, Mar 31, 2026 at 07:42:56AM -0800, Jeff Layton wrote:
> > > On Fri, 2026-03-27 at 11:22 -0700, Thomas Haynes wrote:
> > > > On Fri, Mar 27, 2026 at 12:59:54PM -0800, Jeff Layton wrote:
> > > > > On Fri, 2026-03-27 at 12:20 -0400, Olga Kornievskaia wrote:
> > > > > > On Fri, Mar 27, 2026 at 11:50 AM Jeff Layton <jlayton@kernel.org> wrote:
> > > > > > > 
> > > > > > > On Fri, 2026-03-27 at 11:11 -0400, Olga Kornievskaia wrote:
> > > > > > > > On Tue, Mar 24, 2026 at 1:32 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > > > > > > > 
> > > > > > > > > xfstest generic/728 fails with delegated timestamps. The client does a
> > > > > > > > > removexattr and then a stat to test the ctime, which doesn't change. The
> > > > > > > > > stat() doesn't trigger a GETATTR because of the delegated timestamps, so
> > > > > > > > > it relies on the cached ctime, which is wrong.
> > > > > > > > > 
> > > > > > > > > The setxattr compound has a trailing GETATTR, which ensures that its
> > > > > > > > > ctime gets updated. Follow the same strategy with removexattr.
> > > > > > > > 
> > > > > > > > This approach relies on the fact that the server the serves delegated
> > > > > > > > attributes would update change_attr on operations which might now
> > > > > > > > necessarily happen (ie, linux server does not update change_attribute
> > > > > > > > on writes or clone). I propose an alternative fix for the failing
> > > > > > > > generic/728.
> > > > > > > > 
> > > > > > > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > > > > > > index 7b3ca68fb4bb..ede1835a45b3 100644
> > > > > > > > --- a/fs/nfs/nfs42proc.c
> > > > > > > > +++ b/fs/nfs/nfs42proc.c
> > > > > > > > @@ -1389,7 +1389,13 @@ static int _nfs42_proc_removexattr(struct inode
> > > > > > > > *inode, const char *name)
> > > > > > > >             &res.seq_res, 1);
> > > > > > > >         trace_nfs4_removexattr(inode, name, ret);
> > > > > > > >         if (!ret)
> > > > > > > > -               nfs4_update_changeattr(inode, &res.cinfo, timestamp, 0);
> > > > > > > > +               if (nfs_have_delegated_attributes(inode)) {
> > > > > > > > +                       nfs_update_delegated_mtime(inode);
> > > > > > > > +                       spin_lock(&inode->i_lock);
> > > > > > > > +                       nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
> > > > > > > > +                       spin_unlock(&inode->i_lock);
> > > > > > > > +               } else
> > > > > > > > +                       nfs4_update_changeattr(inode, &res.cinfo, timestamp, 0);
> > > > > > > > 
> > > > > > > >         return ret;
> > > > > > > >  }
> > > > > > > > 
> > > > > > > 
> > > > > > > What's the advantage of doing it this way?
> > > > > > > 
> > > > > > > You just sent a REMOVEXATTR operation to the server that will change
> > > > > > > the mtime there. The server has the most up-to-date version of the
> > > > > > > mtime and ctime at that point.
> > > > > > 
> > > > > > In presence of delegated attributes, Is the server required to update
> > > > > > its mtime/ctime on an operation? As I mentioned, the linux server does
> > > > > > not update its ctime/mtime for WRITE, CLONE, COPY.
> > > > > > 
> > > > > > Is possible that
> > > > > > some implementations might be different and also do not update the
> > > > > > ctime/mtime on REMOVEXATTR?
> > > > > > 
> > > > > > Therefore I was suggesting that the patch
> > > > > > relies on the fact that it would receive an updated value. Of course
> > > > > > perhaps all implementations are done the same as the linux server and
> > > > > > my point is moot. I didn't see anything in the spec that clarifies
> > > > > > what the server supposed to do (and client rely on).
> > > > > > 
> > > > > 
> > > > > (cc'ing Tom)
> > > > > 
> > > > > That is a very good point.
> > > > > 
> > > > > My interpretation was that delegated timestamps generally covered
> > > > > writes, but SETATTR style operations that do anything beyond only
> > > > > changing the mtime can't be cached.
> > > > > 
> > > > > We probably need some delstid spec clarification: for what operations
> > > > > is the server required to disable timestamp updates when a write
> > > > > delegation is outstanding?
> > > > > 
> > > > > In the case of nfsd, we disable timestamp updates for WRITE/COPY/CLONE
> > > > > but not SETATTR/SETXATTR/REMOVEXATTR.
> > > > > 
> > > > > How does the Hammerspace anvil behave? Does it disable c/mtime updates
> > > > > for writes when there is an outstanding timestamp delegation like we're
> > > > > doing in nfsd? If so, does it do the same for
> > > > > SETATTR/SETXATTR/REMOVEXATTR operations as well?
> > > > 
> > > > Jeff,
> > > > 
> > > > I think the right way to look at this is closer to how size is
> > > > handled under delegation in RFC8881, rather than as a per-op rule.
> > > > 
> > > > In our implementation, because we are acting as an MDS and data I/O
> > > > goes to DSes, we already treat size as effectively delegated when
> > > > a write layout is outstanding. The MDS does not maintain authoritative
> > > > size locally in that case. We may refresh size/timestamps internally
> > > > (e.g., on GETATTR by querying DSes), but we don’t treat that as
> > > > overriding the delegated authority.
> > > > 
> > > > For timestamps, our behavior is effectively the same model. When
> > > > the client holds the relevant delegation, the server does not
> > > > consider itself authoritative for ctime/mtime. If current values
> > > > are needed, we can obtain them from the client (e.g., via CB_GETATTR),
> > > > and the client must present the delegation stateid to demonstrate
> > > > that authority. So the authority follows the delegation, not the
> > > > specific operation.
> > > > 
> > > > That said, I don’t think we’ve fully resolved the semantics for all
> > > > metadata-style ops either. WRITE and SETATTR are clear in our model,
> > > > but for things like CLONE/COPY/SETXATTR/REMOVEXATTR, we’ve likely
> > > > been relying on assumptions rather than a fully consistent rule.
> > > > I.e., CLONE and COPY we just pass through to the DS and we don't
> > > > implement SETXATTR/REMOVEXATTR.
> > > > 
> > > > So the spec question, as I see it, is not whether REMOVEXATTR (or
> > > > any particular op) should update ctime/mtime, but whether delegated
> > > > timestamps are meant to follow the same attribute-authority model
> > > > as delegated size in RFC8881. If so, then we expect that the server
> > > > should query the client via CB_GETATTR to return updated ctime/mtime
> > > > after such operations while the delegation is outstanding.
> > > > 
> > > 
> > > The dilemma we have is: because we _do_ allow local processes to stat()
> > > files that have an outstanding write delegation, we can never allow the
> > > ctime in particular to roll backward (modulo clock jumps).
> > 
> > I agree we do not want visible ctime rollback, but I do not see how
> > that can be guaranteed from delegated timestamps alone when the
> > authoritative timestamp may be generated on a different node with
> > a different clock and the object may change during the CB_GETATTR
> > window. That seems to require either monotonic clamping of exposed
> > ctime, or treating change_attr rather than ctime as the real
> > serialization signal.
> > 
> > > 
> > > If we're dealing with changes that have been cached in the client and
> > > are being lazily flushed out, then we can't update the timestamp when
> > > that operation occurs. The time of the RPC to flush the changes will
> > > almost certainly be later than the cached timestamps on the client that
> > > will eventually be set, so when the client comes back we'd end up
> > > violating the rollback rule.
> > > 
> > > Our only option is to freeze timestamp updates on anything that might
> > > represent such an operation. So far, we only do that on WRITE and COPY
> > > operations -- in general, operations that require an open file, since
> > > FMODE_NOCMTIME is attached to the file.
> > > 
> > > Some SETATTRs that only update the mtime and atime can be cached on the
> > > client by virtue of the fact that it's authoritative for timestamps.
> > > There are some exceptions though:
> > > 
> > > - atime-only updates can't be cached since the ctime won't change with
> > > a timestamp update if the mtime didn't change
> > > 
> > > - if you set the mtime to a time that is later than the time you got
> > > the delegation from the server, but earlier than the current time, you
> > > can't cache that. The ctime would be later than the mtime in that case,
> > > and we don't have a mechanism to handle that in a delegated timestamp
> > > SETATTR.
> > > 
> > > I don't see how you could reasonably buffer a SETXATTR or REMOVEXATTR
> > > operation to be sent later. These need to be done synchronously since
> > > they could always fail for some reason and we don't have a mechanism at
> > > the syscall layer to handle a deferred error. They also only update the
> > > ctime and not the mtime, and we have no mechanism to do that with
> > > delegated timestamps.
> > > 
> > > Based on that, I think the client and server both need to ignore the
> > > timestamp delegation on a SETXATTR or REMOVEXATTR. The server should
> > > update the ctime and the client needs to send a trailing GETATTR on the
> > > REMOVEXATTR compound in order to get it and the change attr.
> > 
> > One concern I have with a per-op formulation is extensibility. If
> > delegated timestamp behavior is defined by enumerating specific
> > operations, then every new operation added to the protocol creates
> > a fresh ambiguity until the spec is updated again. It seems better
> > to define the behavior in terms of operation properties - e.g., whether
> > the operation is synchronously visible, can be deferred/cached at
> > the client, and whether it affects only ctime versus mtime/atime -
> > so future operations can be classified without reopening the base
> > rule.
> > 
> > I.e., I can't tell if you want me to update the spec with
> > guidance per-op or you are just documenting what you did.
> > 
> > 
> 
> I think we probably need some guidance in the spec, and I think that
> guidance comes down to: operations that don't have a way to report a
> delayed error condition can't be buffered on the client and must
> continue to be done synchronously even if a delegation is held.
> 
> By way of example: if I do a write() on the client I can buffer that
> because userland can eventually do an fsync() to see if it succeeded.
> This is not true for syscalls like setxattr() or removexattr(), or most
> syscalls that result in a SETATTR operation (chmod(), chown(), etc).
> 
> They must be done synchronously because:
> 
> 1/ there's no way to update only the ctime in a delegated timestamp
> update
> 
> ...and...
> 
> 2/ these syscalls can fail, so we can't return from them until we know
> the outcome.
> 
> How best to phrase this guidance, I'm not sure...
> -- 
> Jeff Layton <jlayton@kernel.org>

One concern I have with the "ops that can report delayed error"
formulation is that, in practice, any NFSv4 operation may encounter
a temporary condition and return NFS4ERR_DELAY at execution time.
Even a simple operation like GETFH may need to allocate reply
resources and fail transiently. As such, the ability to convey delay
is not a distinguishing property of a particular operation.

I think the relevant distinction is instead whether the client may
complete the syscall locally and defer authoritative execution
and/or result until a later point without violating its semantics.
Some operations fit that model, but others do not.

Even WRITE is not inherently in the "may be deferred" category;
that depends on the data path. For example, in a pNFS configuration
where WRITE is routed synchronously to an MDS, completion semantics
differ from a buffered writeback model. This suggests that the
classification should not be tied to specific opcodes, but to the
completion semantics of the operation in the context in which it
is executed.

Given that, it may be more useful for the spec to describe delegated
timestamp behavior in terms of these semantics:

   o Operations for which the client may lawfully acknowledge
   completion before authoritative server execution has completed
   may use delegated timestamp authority, subject to the constraints
   of that deferred-completion model.

   o Operations that require authoritative execution status before
   completion of the user-visible request must be executed synchronously
   and must not rely on deferred timestamp resolution.

This avoids per-op enumeration and allows future operations to be
classified based on their semantics rather than requiring explicit
specification updates.
---
Tom Haynes <loghyr@gmail.com>

