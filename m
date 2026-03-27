Return-Path: <linux-nfs+bounces-20479-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFTfLo7ixmlDPwUAu9opvQ
	(envelope-from <linux-nfs+bounces-20479-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 21:03:26 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2142634A922
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 21:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 184FD300A744
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 20:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9384D37AA64;
	Fri, 27 Mar 2026 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc2e4OB4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39B232B9A9
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774641734; cv=none; b=gYRmokOrwfrLmuTqWKtbJ9YKsH/D+X3GmqD16SBAowmvtfWDk1IrCoAoZhA19G5wBif0XiESedZ38yGbJqaPneFcIIPd10Nl9GT5jjdCmBVxCmm85v67K5Koy4xgFFtfFDPAZDWMN2UGpzscyMI3pmgi/8fsO/7hMeJrKhv7KKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774641734; c=relaxed/simple;
	bh=MmHqXQgafrwty5MEdkYqLKA9RUkTqWlMKETh27Godi0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsNkKxiW8FXbBakPeWqryLwSwn+M4k9YFXJjmrNsJedlh0DWPpaTihMv9K9yNcuws1s1bd6w+gaLP/a334VIvuMLXa8SR5yFVGZemnMvBmwkp6DIbBmr3y9+YHVejV0+fiYwqIJU0/8KVKHDoQbOsWUxe44YCviCFYiXUTkAgz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nc2e4OB4; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d55b97f358so1499804a34.3
        for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 13:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774641732; x=1775246532; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BwBskcTjpBCYRdyy28qWv+JNUe66FQYS4ZDx9iWeIMw=;
        b=nc2e4OB4yfmMGx6c677+Ich2qMhY6QAts5QG0+ZrpH2kwAc2mhdt0gan0MTaqUPF9F
         EZt7N923Fd5aJFIOhCLzufyAdEe8DOXMtusNiMj3LsEQBW0Yu0S7G1574Toens1uSmdG
         yDyyKgjY3u3lPPc6nJOxGJhne4xoiq2YqGIAALyV4y0EPr7ZBNyl9CG5GVaXpOxZo9Kv
         NdVgCXB2a5u1nuYafVVc0PHWTfzxOI27xYakaG1o/EHh8G3Q503hV5Db6NCKzlYfvyrl
         EHvbW0ihdCZv+b/I1H18h9LKfaSwCpP5jdyJb8VPav9wAnRLxSFY3Ht9ogOy2PNoZUHC
         4Odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774641732; x=1775246532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwBskcTjpBCYRdyy28qWv+JNUe66FQYS4ZDx9iWeIMw=;
        b=bgxZifxVYVSLd3pzvLjkvTwnGNvLNFhi/6vsAnYrCTHM2P3TDPHyuWXcYoh6pJq0DI
         hSbuDDKoGqAkFOjjEAcwhyaPSczkT0Byhdn55SmC11H3qQni3OAhnzYVYXuMMomhNySC
         /3cb/hNvJxHGvU7F3E5MZ2R+Vj7qJM6XBgnv/cHo8ophZ48Cz8BetkRq/CzRvq/VrRpf
         WzOwIB7bRkwPLvJhWW9yWXBUsRV8Ctveq/Z4SvgXk3HFNjUz/ZO7UBmNe9p+TSgzc21c
         ews4FaU5qxvdXxIgqRmajziZYmFYefBHr20xffk8m024CzPnJt7BZh1+rZBRkB9IJYEX
         t3Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVMhbgmwinXv5oJYGU6ckHm1lWUKCxKWx0TLJyctpiQz+1y6f8Leo4LmLDMgo2TZfwwarpmk8XgWvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxVhYqwn6gdoujzWYp1dHQ+aYybr/BAbGPeL7X4YR4CaNDjAg8
	QBS1wwW9nNudGD89Sjf62PMtm5L1n3//1p8JlQMnUHyvBzHePJCi46ZF
X-Gm-Gg: ATEYQzyoEemZdNNJexaZyaO8K/A2RK70tLOokwjak9jPO3bCPGTTxzVw7a5pRfKsQOY
	HJrDp1uvYHt0nHZ/ovcDL+sg8YxsrD27KUGNNO1n7YXBANBReCCeGWW1tGmmYkBHu7iu0Gstcqb
	3+R+lY8ojwk0yi6p1OphbPxMcn79Ys+AKKJDAWPIv+1VErX1axj0zRhGQNhvg7kCOqgA/xDZnIY
	fpwQbuKP79lwsqsvZOx3pi+lwvcm+uQ/gUtz+IldrtfeVD+P8kNHpB/J5G3OPHeU1Yd0XKxzPew
	AZKF2+3MYCRrzav2lkYf8peMhCoghuEofYZzCT5D96Y0OYqhZ+sMCSEwrFHLPnGA5KxmoaoIYYd
	6bRqflUDkg8ODSNNJjEN9jtH9POkoDA+Ic10ViaJWv0+Mq60euDKbdqQIvDlgBP506BL002f9Qt
	aPKU0vfmOJYHxJaHOEMjtQMIJBiXQYDGnQax/zuYYeK18e5wGNUMQ8Gu4WezNRNw6Jhzp52T8=
X-Received: by 2002:a05:6870:2e8d:b0:3ec:4a8d:420b with SMTP id 586e51a60fabf-41cec37f76amr2013119fac.42.1774641731560;
        Fri, 27 Mar 2026 13:02:11 -0700 (PDT)
Received: from localhost (c-174-160-87-152.hsd1.ca.comcast.net. [174.160.87.152])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d0496591csm197102fac.8.2026.03.27.13.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:02:11 -0700 (PDT)
From: Thomas Haynes <loghyr@gmail.com>
X-Google-Original-From: Thomas Haynes <loghy@gmail.com>
Date: Fri, 27 Mar 2026 13:02:09 -0700
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Thomas Haynes <loghyr@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nfs: update inode ctime after removexattr
 operation
Message-ID: <acbfV0C-fAy4nZ-i@mana>
References: <20260324-nfs-7-1-v2-0-d110da3c0036@kernel.org>
 <20260324-nfs-7-1-v2-2-d110da3c0036@kernel.org>
 <CAN-5tyFpsuE9+5ZvAASwvTYKtcN5jNpAxi8ejde90e-vpUzFKg@mail.gmail.com>
 <284ca17e74af8c4f5942b2952f2bf75490dd17c0.camel@kernel.org>
 <CAN-5tyFsEUcSUycb4JjxH5v754SefwOH=zt24KtxEC_Ow4OjMw@mail.gmail.com>
 <80b423c66dba84b46be1084307d2c66b935065bc.camel@kernel.org>
 <acbJsryTMYCMlE_o@mana>
 <CAN-5tyFQrt7WyW4=qLodKS2-eckAetKjs15A6U1OOdGPSL58XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN-5tyFQrt7WyW4=qLodKS2-eckAetKjs15A6U1OOdGPSL58XQ@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20479-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,umich.edu:email]
X-Rspamd-Queue-Id: 2142634A922
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 03:36:12PM -0800, Olga Kornievskaia wrote:
> On Fri, Mar 27, 2026 at 2:22 PM Thomas Haynes <loghyr@gmail.com> wrote:
> >
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
> 
> What happens when the client holding the attribute delegation (it's
> the authority) is doing the query? Is it the server's responsibility
> to query the client before replying.

The Hammerspace server on a getattr checks to see if there is
a delegated stateid (and whether it is the client making the request
or not). If it is and the GETATTR asks for FATTR4_SIZE, FATTR4_TIME_MODIFY,
or FATTR4_TIME_METADATA, then it will send a CB_GETATTR before
responding to the client.

While it does not do so, if the client sent in a SETATTR in the
same compound we could short circuit that. Think a sort of WCC.

> Example, client sends a CLONE
> operation which has a GETATTR attached. (1) is the server supposed to
> issue a CB_GETATTR before replying to the compound? (2) is the client
> not supposed to send any GETATTRs while holding an attribute
> delegation? CLONE is a modifying operation but client hasn't done any
> actual modifications to the opened file so a CB_GETATTR would return
> that file hasn't been modified. Is the server then not going to
> express that the file has indeed been modified when replying to
> GETATTR?

The server could argue that the client wants to know what it thinks.
But that isn't the argeement. The server has to query those values
before sending them on.

> 
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
> > Thanks,
> > Tom
> >
> >
> > >
> > >
> > >
> > > > > It's certainly possible that the REMOVEXATTR is the only change that
> > > > > occurred. With what I'm proposing, we don't even need to do a SETATTR
> > > > > at all if nothing else changed. With your version, you would.
> > > > >
> > > > > > >
> > > > > > > Fixes: 3e1f02123fba ("NFSv4.2: add client side XDR handling for extended attributes")
> > > > > > > Reported-by: Olga Kornievskaia <aglo@umich.edu>
> > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > ---
> > > > > > >  fs/nfs/nfs42proc.c      | 18 ++++++++++++++++--
> > > > > > >  fs/nfs/nfs42xdr.c       | 10 ++++++++--
> > > > > > >  include/linux/nfs_xdr.h |  3 +++
> > > > > > >  3 files changed, 27 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > > > > > index 7b3ca68fb4bb3bee293f8621e5ed5fa596f5da3f..7e5c1172fc11c9d5a55b3621977ac83bb98f7c20 100644
> > > > > > > --- a/fs/nfs/nfs42proc.c
> > > > > > > +++ b/fs/nfs/nfs42proc.c
> > > > > > > @@ -1372,11 +1372,15 @@ int nfs42_proc_clone(struct file *src_f, struct file *dst_f,
> > > > > > >  static int _nfs42_proc_removexattr(struct inode *inode, const char *name)
> > > > > > >  {
> > > > > > >         struct nfs_server *server = NFS_SERVER(inode);
> > > > > > > +       __u32 bitmask[NFS_BITMASK_SZ];
> > > > > > >         struct nfs42_removexattrargs args = {
> > > > > > >                 .fh = NFS_FH(inode),
> > > > > > > +               .bitmask = bitmask,
> > > > > > >                 .xattr_name = name,
> > > > > > >         };
> > > > > > > -       struct nfs42_removexattrres res;
> > > > > > > +       struct nfs42_removexattrres res = {
> > > > > > > +               .server = server,
> > > > > > > +       };
> > > > > > >         struct rpc_message msg = {
> > > > > > >                 .rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_REMOVEXATTR],
> > > > > > >                 .rpc_argp = &args,
> > > > > > > @@ -1385,12 +1389,22 @@ static int _nfs42_proc_removexattr(struct inode *inode, const char *name)
> > > > > > >         int ret;
> > > > > > >         unsigned long timestamp = jiffies;
> > > > > > >
> > > > > > > +       res.fattr = nfs_alloc_fattr();
> > > > > > > +       if (!res.fattr)
> > > > > > > +               return -ENOMEM;
> > > > > > > +
> > > > > > > +       nfs4_bitmask_set(bitmask, server->cache_consistency_bitmask,
> > > > > > > +                        inode, NFS_INO_INVALID_CHANGE);
> > > > > > > +
> > > > > > >         ret = nfs4_call_sync(server->client, server, &msg, &args.seq_args,
> > > > > > >             &res.seq_res, 1);
> > > > > > >         trace_nfs4_removexattr(inode, name, ret);
> > > > > > > -       if (!ret)
> > > > > > > +       if (!ret) {
> > > > > > >                 nfs4_update_changeattr(inode, &res.cinfo, timestamp, 0);
> > > > > > > +               ret = nfs_post_op_update_inode(inode, res.fattr);
> > > > > > > +       }
> > > > > > >
> > > > > > > +       kfree(res.fattr);
> > > > > > >         return ret;
> > > > > > >  }
> > > > > > >
> > > > > > > diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> > > > > > > index 5c7452ce6e8ac94bd24bc3a33d4479d458a29907..ec105c62f721cfe01bfc60f5981396958084d627 100644
> > > > > > > --- a/fs/nfs/nfs42xdr.c
> > > > > > > +++ b/fs/nfs/nfs42xdr.c
> > > > > > > @@ -263,11 +263,13 @@
> > > > > > >  #define NFS4_enc_removexattr_sz                (compound_encode_hdr_maxsz + \
> > > > > > >                                          encode_sequence_maxsz + \
> > > > > > >                                          encode_putfh_maxsz + \
> > > > > > > -                                        encode_removexattr_maxsz)
> > > > > > > +                                        encode_removexattr_maxsz + \
> > > > > > > +                                        encode_getattr_maxsz)
> > > > > > >  #define NFS4_dec_removexattr_sz                (compound_decode_hdr_maxsz + \
> > > > > > >                                          decode_sequence_maxsz + \
> > > > > > >                                          decode_putfh_maxsz + \
> > > > > > > -                                        decode_removexattr_maxsz)
> > > > > > > +                                        decode_removexattr_maxsz + \
> > > > > > > +                                        decode_getattr_maxsz)
> > > > > > >
> > > > > > >  /*
> > > > > > >   * These values specify the maximum amount of data that is not
> > > > > > > @@ -869,6 +871,7 @@ static void nfs4_xdr_enc_removexattr(struct rpc_rqst *req,
> > > > > > >         encode_sequence(xdr, &args->seq_args, &hdr);
> > > > > > >         encode_putfh(xdr, args->fh, &hdr);
> > > > > > >         encode_removexattr(xdr, args->xattr_name, &hdr);
> > > > > > > +       encode_getfattr(xdr, args->bitmask, &hdr);
> > > > > > >         encode_nops(&hdr);
> > > > > > >  }
> > > > > > >
> > > > > > > @@ -1818,6 +1821,9 @@ static int nfs4_xdr_dec_removexattr(struct rpc_rqst *req,
> > > > > > >                 goto out;
> > > > > > >
> > > > > > >         status = decode_removexattr(xdr, &res->cinfo);
> > > > > > > +       if (status)
> > > > > > > +               goto out;
> > > > > > > +       status = decode_getfattr(xdr, res->fattr, res->server);
> > > > > > >  out:
> > > > > > >         return status;
> > > > > > >  }
> > > > > > > diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> > > > > > > index ff1f12aa73d27b6fd874baf7019dd03195fc36e5..fcbd21b5685f46136a210c8e11c20a54d6ed9dad 100644
> > > > > > > --- a/include/linux/nfs_xdr.h
> > > > > > > +++ b/include/linux/nfs_xdr.h
> > > > > > > @@ -1611,12 +1611,15 @@ struct nfs42_listxattrsres {
> > > > > > >  struct nfs42_removexattrargs {
> > > > > > >         struct nfs4_sequence_args       seq_args;
> > > > > > >         struct nfs_fh                   *fh;
> > > > > > > +       const u32                       *bitmask;
> > > > > > >         const char                      *xattr_name;
> > > > > > >  };
> > > > > > >
> > > > > > >  struct nfs42_removexattrres {
> > > > > > >         struct nfs4_sequence_res        seq_res;
> > > > > > >         struct nfs4_change_info         cinfo;
> > > > > > > +       struct nfs_fattr                *fattr;
> > > > > > > +       const struct nfs_server         *server;
> > > > > > >  };
> > > > > > >
> > > > > > >  #endif /* CONFIG_NFS_V4_2 */
> > > > > > >
> > > > > > > --
> > > > > > > 2.53.0
> > > > > > >
> > > > >
> > > > > --
> > > > > Jeff Layton <jlayton@kernel.org>
> > >
> > > --
> > > Jeff Layton <jlayton@kernel.org>
> >

