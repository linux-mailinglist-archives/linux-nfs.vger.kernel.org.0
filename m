Return-Path: <linux-nfs+bounces-20556-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wD8cEboWzGkeOQYAu9opvQ
	(envelope-from <linux-nfs+bounces-20556-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 20:47:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1613702D2
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 20:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E85A30058CD
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 18:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C060338B13E;
	Tue, 31 Mar 2026 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAh4gGvr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E0536F430
	for <linux-nfs@vger.kernel.org>; Tue, 31 Mar 2026 18:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774982838; cv=none; b=W+70W3I/ITUZpVfL2QCPO07J+x3wmbdXPM8CjaEf4AHAAO5CVwSN0PlaRV31VD3f6ToQ0QGf+3fBIuXhq/zbSollfgyeOvokQFgplYX9LCPBKgLlhpTaL3LQaCuWOhYP8C5ekEMqo4dqC6HS0VGFbh1Gq8rKiuEOdoD3Q1FUZ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774982838; c=relaxed/simple;
	bh=klca8zZnNvUVLhlOO2LRAQgkuJB8sDzaNxfUFUDM+aY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9oc4rOAtPKEGJf7Vj4rl4RK6y/E+3tsSsJJKenG8xrHDewoKSnkcjB1XpkC57Wzo8hG/IdyyvBszUtXeUGPz95JIja8nm6Q01Q8cPatl1OLRHmTzRxG0BXa26M6hcngZMHHHnANpsyOzCGNVap9y6QyPk9kihxmxk1h2BkUcaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAh4gGvr; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d8b2703f37so5571600a34.1
        for <linux-nfs@vger.kernel.org>; Tue, 31 Mar 2026 11:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774982836; x=1775587636; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bV9BROuCXz7vmDIjNMuDEUixDsIrGdMikx5FHekafU0=;
        b=YAh4gGvrqWdqXOBCPmSS/99BQIp2XBmuRSwP2ER1MtXFrDrnlA5f2HX5BAmfHrhtAv
         1Fy8LY/2nfwyYlRPuyd/Pa+Q6Z1i/HRs1XJgJB+/x1RLow4MAkPTgsxIW0rAPANMuFE4
         W1YgipGF0wkxtHpiG8cLHM80BySoBw/faRpylzjq0r69z9bQIhblavxtdxDsEntyF3bx
         9FrzOEF5kb2sxhDMbqT0I3YHEyhA8ZEHjgMkHiHlMtyYlRZSmkLNB9iXVbRhZI6P1bTQ
         VFdLcr7JRpYwrFQAhp87zYemzN36YhgGfl4fRpcZYV9h8jV/cylnxdiWFPEQ/UBO4Auh
         6c0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774982836; x=1775587636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bV9BROuCXz7vmDIjNMuDEUixDsIrGdMikx5FHekafU0=;
        b=joFbP5DlImI45Zo44OUnfpuRN6r4x+s7SndGMi6ZEgWCohlxXrWTZ44AauE9VBpaGK
         vrr9KgmcPQEE3YTmjAWGx8MkgCeJfTqjx+I7q58uSQ0a1zJR7JmTggx7HbNuHyrN3YGx
         bFVRHPAcRwXp14qIuyjP68Cqu2SdjuekpLnbPKjxUvOPMgpfRyQTMbxPOrYMIoZCih5B
         oF8CLv0OyiuhEoALVg/u8qEQjkkDkkF3BDbS+GgUrHbloyZG/n68HbEwPfPMDQJJDbgM
         oVRTtkmZcWB4dfIzYVb13iyY9AF7rxC5ngqE0OyogEIh1M1TqY84W9KMmUY+HDeLMUfi
         wXJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp/3G2cItsWVHTpB6LML2WbcxwMVOPOQSNV8F/lBpJX1yjyXuVIdkZi9xRbTAilD/qXzmvdMtmTgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeAk2ECvpfPrctUCRrxNvV1hbWD4hXbzQnD7R8GJzybUkvtOsX
	DZpk357DYxbCmkShBNmkaPIWsRmPSSljBCHhLsfC7uhJd6hPeh/93/ws
X-Gm-Gg: ATEYQzxgtDt2aIRZnd9dmKCQkfOCdiHLzcyjgbsV5CXcsfRQbUzBvuB3JHKNeoZOEJ8
	b/NmRB6wW9aJGVEBCkNuZ9+l7prf9QDI/vWF8k3sje4iWj1N0AbqeZVhxLIfTy+MrVfifg8fvCa
	ybEBLhr51UJk751OwRoI3mcvzOHcJTFJmNdXGM1Bqox05LSUm6teiuwWmK3O/SKzvb/uVFeVkVN
	phocjpfpte1JEm9yECFCMzn0QIJEfdde17bxL0o2H0yGEdzg5J//OyHQdQYkxMrHCF3UiWtIJjv
	01XIhPak/4QwMwm6AtPyu+w9JB++x2haYn/JF8RISBN3AsEmgwXN2U3/OsjGDh2mlKYW1bLHGPV
	R5piieFwpvJ/quFJh6Xnll3W5nZOz9IYmVNvH9DvfslYNK9S8Sfl21drVzsFVgHccPPQh9zrDOD
	qt60ZauSKdGApeeTH2yigweINR9xQRGaI=
X-Received: by 2002:a05:6830:82b8:b0:7d7:d1e1:6987 with SMTP id 46e09a7af769-7db993469admr484012a34.21.1774982835911;
        Tue, 31 Mar 2026 11:47:15 -0700 (PDT)
Received: from localhost ([12.117.181.174])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a335421sm8591876a34.3.2026.03.31.11.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 11:47:15 -0700 (PDT)
From: Thomas Haynes <loghyr@gmail.com>
X-Google-Original-From: Thomas Haynes <loghy@gmail.com>
Date: Tue, 31 Mar 2026 11:47:14 -0700
To: Jeff Layton <jlayton@kernel.org>
Cc: Thomas Haynes <loghyr@gmail.com>, Olga Kornievskaia <aglo@umich.edu>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nfs: update inode ctime after removexattr
 operation
Message-ID: <acwVE5ZoPPLFQCLT@mana>
References: <20260324-nfs-7-1-v2-0-d110da3c0036@kernel.org>
 <20260324-nfs-7-1-v2-2-d110da3c0036@kernel.org>
 <CAN-5tyFpsuE9+5ZvAASwvTYKtcN5jNpAxi8ejde90e-vpUzFKg@mail.gmail.com>
 <284ca17e74af8c4f5942b2952f2bf75490dd17c0.camel@kernel.org>
 <CAN-5tyFsEUcSUycb4JjxH5v754SefwOH=zt24KtxEC_Ow4OjMw@mail.gmail.com>
 <80b423c66dba84b46be1084307d2c66b935065bc.camel@kernel.org>
 <acbJsryTMYCMlE_o@mana>
 <13f1fd90b75c73e8d5220dadb6eb9d9473bc96e8.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13f1fd90b75c73e8d5220dadb6eb9d9473bc96e8.camel@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,umich.edu,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20556-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC1613702D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 07:42:56AM -0800, Jeff Layton wrote:
> On Fri, 2026-03-27 at 11:22 -0700, Thomas Haynes wrote:
> > On Fri, Mar 27, 2026 at 12:59:54PM -0800, Jeff Layton wrote:
> > > On Fri, 2026-03-27 at 12:20 -0400, Olga Kornievskaia wrote:
> > > > On Fri, Mar 27, 2026 at 11:50 AM Jeff Layton <jlayton@kernel.org> wrote:
> > > > > 
> > > > > On Fri, 2026-03-27 at 11:11 -0400, Olga Kornievskaia wrote:
> > > > > > On Tue, Mar 24, 2026 at 1:32 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > > > > > 
> > > > > > > xfstest generic/728 fails with delegated timestamps. The client does a
> > > > > > > removexattr and then a stat to test the ctime, which doesn't change. The
> > > > > > > stat() doesn't trigger a GETATTR because of the delegated timestamps, so
> > > > > > > it relies on the cached ctime, which is wrong.
> > > > > > > 
> > > > > > > The setxattr compound has a trailing GETATTR, which ensures that its
> > > > > > > ctime gets updated. Follow the same strategy with removexattr.
> > > > > > 
> > > > > > This approach relies on the fact that the server the serves delegated
> > > > > > attributes would update change_attr on operations which might now
> > > > > > necessarily happen (ie, linux server does not update change_attribute
> > > > > > on writes or clone). I propose an alternative fix for the failing
> > > > > > generic/728.
> > > > > > 
> > > > > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > > > > index 7b3ca68fb4bb..ede1835a45b3 100644
> > > > > > --- a/fs/nfs/nfs42proc.c
> > > > > > +++ b/fs/nfs/nfs42proc.c
> > > > > > @@ -1389,7 +1389,13 @@ static int _nfs42_proc_removexattr(struct inode
> > > > > > *inode, const char *name)
> > > > > >             &res.seq_res, 1);
> > > > > >         trace_nfs4_removexattr(inode, name, ret);
> > > > > >         if (!ret)
> > > > > > -               nfs4_update_changeattr(inode, &res.cinfo, timestamp, 0);
> > > > > > +               if (nfs_have_delegated_attributes(inode)) {
> > > > > > +                       nfs_update_delegated_mtime(inode);
> > > > > > +                       spin_lock(&inode->i_lock);
> > > > > > +                       nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
> > > > > > +                       spin_unlock(&inode->i_lock);
> > > > > > +               } else
> > > > > > +                       nfs4_update_changeattr(inode, &res.cinfo, timestamp, 0);
> > > > > > 
> > > > > >         return ret;
> > > > > >  }
> > > > > > 
> > > > > 
> > > > > What's the advantage of doing it this way?
> > > > > 
> > > > > You just sent a REMOVEXATTR operation to the server that will change
> > > > > the mtime there. The server has the most up-to-date version of the
> > > > > mtime and ctime at that point.
> > > > 
> > > > In presence of delegated attributes, Is the server required to update
> > > > its mtime/ctime on an operation? As I mentioned, the linux server does
> > > > not update its ctime/mtime for WRITE, CLONE, COPY.
> > > > 
> > > > Is possible that
> > > > some implementations might be different and also do not update the
> > > > ctime/mtime on REMOVEXATTR?
> > > > 
> > > > Therefore I was suggesting that the patch
> > > > relies on the fact that it would receive an updated value. Of course
> > > > perhaps all implementations are done the same as the linux server and
> > > > my point is moot. I didn't see anything in the spec that clarifies
> > > > what the server supposed to do (and client rely on).
> > > > 
> > > 
> > > (cc'ing Tom)
> > > 
> > > That is a very good point.
> > > 
> > > My interpretation was that delegated timestamps generally covered
> > > writes, but SETATTR style operations that do anything beyond only
> > > changing the mtime can't be cached.
> > > 
> > > We probably need some delstid spec clarification: for what operations
> > > is the server required to disable timestamp updates when a write
> > > delegation is outstanding?
> > > 
> > > In the case of nfsd, we disable timestamp updates for WRITE/COPY/CLONE
> > > but not SETATTR/SETXATTR/REMOVEXATTR.
> > > 
> > > How does the Hammerspace anvil behave? Does it disable c/mtime updates
> > > for writes when there is an outstanding timestamp delegation like we're
> > > doing in nfsd? If so, does it do the same for
> > > SETATTR/SETXATTR/REMOVEXATTR operations as well?
> > 
> > Jeff,
> > 
> > I think the right way to look at this is closer to how size is
> > handled under delegation in RFC8881, rather than as a per-op rule.
> > 
> > In our implementation, because we are acting as an MDS and data I/O
> > goes to DSes, we already treat size as effectively delegated when
> > a write layout is outstanding. The MDS does not maintain authoritative
> > size locally in that case. We may refresh size/timestamps internally
> > (e.g., on GETATTR by querying DSes), but we don’t treat that as
> > overriding the delegated authority.
> > 
> > For timestamps, our behavior is effectively the same model. When
> > the client holds the relevant delegation, the server does not
> > consider itself authoritative for ctime/mtime. If current values
> > are needed, we can obtain them from the client (e.g., via CB_GETATTR),
> > and the client must present the delegation stateid to demonstrate
> > that authority. So the authority follows the delegation, not the
> > specific operation.
> > 
> > That said, I don’t think we’ve fully resolved the semantics for all
> > metadata-style ops either. WRITE and SETATTR are clear in our model,
> > but for things like CLONE/COPY/SETXATTR/REMOVEXATTR, we’ve likely
> > been relying on assumptions rather than a fully consistent rule.
> > I.e., CLONE and COPY we just pass through to the DS and we don't
> > implement SETXATTR/REMOVEXATTR.
> > 
> > So the spec question, as I see it, is not whether REMOVEXATTR (or
> > any particular op) should update ctime/mtime, but whether delegated
> > timestamps are meant to follow the same attribute-authority model
> > as delegated size in RFC8881. If so, then we expect that the server
> > should query the client via CB_GETATTR to return updated ctime/mtime
> > after such operations while the delegation is outstanding.
> > 
> 
> The dilemma we have is: because we _do_ allow local processes to stat()
> files that have an outstanding write delegation, we can never allow the
> ctime in particular to roll backward (modulo clock jumps).

I agree we do not want visible ctime rollback, but I do not see how
that can be guaranteed from delegated timestamps alone when the
authoritative timestamp may be generated on a different node with
a different clock and the object may change during the CB_GETATTR
window. That seems to require either monotonic clamping of exposed
ctime, or treating change_attr rather than ctime as the real
serialization signal.

> 
> If we're dealing with changes that have been cached in the client and
> are being lazily flushed out, then we can't update the timestamp when
> that operation occurs. The time of the RPC to flush the changes will
> almost certainly be later than the cached timestamps on the client that
> will eventually be set, so when the client comes back we'd end up
> violating the rollback rule.
> 
> Our only option is to freeze timestamp updates on anything that might
> represent such an operation. So far, we only do that on WRITE and COPY
> operations -- in general, operations that require an open file, since
> FMODE_NOCMTIME is attached to the file.
> 
> Some SETATTRs that only update the mtime and atime can be cached on the
> client by virtue of the fact that it's authoritative for timestamps.
> There are some exceptions though:
> 
> - atime-only updates can't be cached since the ctime won't change with
> a timestamp update if the mtime didn't change
> 
> - if you set the mtime to a time that is later than the time you got
> the delegation from the server, but earlier than the current time, you
> can't cache that. The ctime would be later than the mtime in that case,
> and we don't have a mechanism to handle that in a delegated timestamp
> SETATTR.
> 
> I don't see how you could reasonably buffer a SETXATTR or REMOVEXATTR
> operation to be sent later. These need to be done synchronously since
> they could always fail for some reason and we don't have a mechanism at
> the syscall layer to handle a deferred error. They also only update the
> ctime and not the mtime, and we have no mechanism to do that with
> delegated timestamps.
> 
> Based on that, I think the client and server both need to ignore the
> timestamp delegation on a SETXATTR or REMOVEXATTR. The server should
> update the ctime and the client needs to send a trailing GETATTR on the
> REMOVEXATTR compound in order to get it and the change attr.

One concern I have with a per-op formulation is extensibility. If
delegated timestamp behavior is defined by enumerating specific
operations, then every new operation added to the protocol creates
a fresh ambiguity until the spec is updated again. It seems better
to define the behavior in terms of operation properties - e.g., whether
the operation is synchronously visible, can be deferred/cached at
the client, and whether it affects only ctime versus mtime/atime -
so future operations can be classified without reopening the base
rule.

I.e., I can't tell if you want me to update the spec with
guidance per-op or you are just documenting what you did.

> 
> Exactly what this patch does, fwiw...
> -- 
> Jeff Layton <jlayton@kernel.org>

