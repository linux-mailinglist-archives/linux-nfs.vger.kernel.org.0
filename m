Return-Path: <linux-nfs+bounces-20474-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPE6E/3Kxmn5OgUAu9opvQ
	(envelope-from <linux-nfs+bounces-20474-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 19:22:53 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A60348F94
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 19:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0307302AD23
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 18:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C560401A3A;
	Fri, 27 Mar 2026 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiedcPOe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A37402450
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774635769; cv=none; b=l6lSm/UoFA3jMb2TF+1g+gf37jNONY64t3SnrZdSPJVVyXgMtdhG0Ee5v0tFr2p5DtKMbrDMVaIxMPVMgssP9zZh9LHCc0YQrFzlZ476vczvNMvoOmkqMRggoK+yOKeLPmKYmfCbWHAstPVozBby2ixyVcgv9wX3Zqpum8ldDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774635769; c=relaxed/simple;
	bh=Ce+JeBdKPngkz03e9C0BLp1VEvPo2cdoJJHu0LbAVaY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQo4zfuBd2d49U9hliizoCr/11opo2Wkeisj4VSlsJMFAJ42qo81b1nM4lo3uvfmPj9PqIjMMMl7FXBdyhKbLtkn9glVYEyLshr/3l3jssYydfOgqWtohb4hfLi32WOQAhAGRuqH+bpNas/5BuKTs6cwhvKNmivnXQDmWSx9hgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiedcPOe; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-408778a8ec4so1496295fac.0
        for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774635764; x=1775240564; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T7n7hKZ8FOeCaaapHn5s1aqBX5jq6R1SR85ZlaoOO7A=;
        b=aiedcPOe2YF4iGhN1HF0Itb1a4cmgma4ge/1M6gKa9mlxRrhG3IxrsUnbxXd3mdBc5
         WY5rSOFuaMwyuo1GlbXCmZTXTVSn/Q/faRIP8k1/R1BaTKUG/l5DkHi+4PrzJDIcUlb9
         GKjHpQtjuO9bdvVl2jSNED6yMwviBX1nXgYkevlhyD8tr8JfmYuMcWnwWtbw5CXiXSjj
         9dpTW7S2kZoYUP8ltCBsqEu9ln6mDm76xLQuxyGERq2oPV+IvmB8nQBEPg7CLnUqYjrY
         IksorMUoJqK8biQvA6a4UIITNzSVhGjmNgiF5tG5CjirX8VUAZyweFQsVNhTyW4CZi8C
         Femw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774635764; x=1775240564;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7n7hKZ8FOeCaaapHn5s1aqBX5jq6R1SR85ZlaoOO7A=;
        b=pnISFwvwy4c/3TE3As5oKUvNJ3b8+moKGKBIsV9upt/y5+GG3/i5LcXmBRjJCA3Ufp
         PxRtbYIso5KnHRmUTs1jduKX771aOQ7RGZBve1lY1ap64hc3PLZvouKvwXKM95Q+fLma
         R62Zor5HGjsTuZb4okg+T4gd966dNmrz6zvTd4eltxMax7v4Jp6o/aJ73Urvn51dmUa/
         rhM34TfXRNlrgZ5vZ99YgKwG64ksivtZRCQDgD7KkCR9ZX4ibvowYj978MY2tSytv6V7
         be4i7kp/pvmETcBgQ3xjL6PkiDGoSjjjGPQGAB1tAvyZuEvQkccteDw/4tgJO4yOvnXu
         YYww==
X-Forwarded-Encrypted: i=1; AJvYcCVCVTx7kD8AhPojge1MamNI7T28FsAwYB72PofDSBTZOGgAZHibH8mNopHXrh4Xwm7X3qR5ad92igw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB82aIspmesYZTKII3xIH3uW1/pHL955irOjhRTOHT8YLmIb8I
	fuO6rDT/jfosOU6nQpqB4U6y+F8BWmnR+UNI3xJqwVTQKG7DKMGLBbXb6UGnamwx
X-Gm-Gg: ATEYQzwX2o1NPA2ivjmrjthQUm5XEnPI6s6zkUDW1Mi0UD9GUkbIxJTte8Ls3/jLBDt
	QA+IClTZu1hGdpMhH2q4XMfc8bXYK3AojByxtqRqqNUE6QrjXPEvhHx0U/1LID20I2x4f9VaLAV
	che6Tp9gujsEOs6vRm+RWDaakFGXzPATLcnLxImWiJZ2vjg4KD+b9Y3LsE2Mo/EBAnNTmShbyrR
	G0L1mlDzG1tPsAOznC2eLhkMJCtRaDUQqIkNq/DTWMnwBimuSnE3vV4bHWeleiXtMUq4A33f/hh
	kOOZl6bHGb4DKhYP8Yh8d/IrGx0jbX3YfZeFKEfTqLaFN6FlLyN4W/xzTCFdyvVfVk8BUCf4A/4
	8yQWMDYe4EcW4EKrwrvSlQGvcgNv91IPmybNfyunr/iIPHEeycUQkvIdOVFvIx/aq6R0lnLbdS4
	DBdnc5P+yzj3eLok/dji90ImX/7PhPblmEijJ64IBtQJb+UIpb01zL27moPDaO7FmZ8pEevkp2r
	iHcgW/VKw==
X-Received: by 2002:a05:6870:b620:b0:40e:e0b2:e375 with SMTP id 586e51a60fabf-41cec2ca743mr1462914fac.31.1774635764042;
        Fri, 27 Mar 2026 11:22:44 -0700 (PDT)
Received: from localhost (c-174-160-87-152.hsd1.ca.comcast.net. [174.160.87.152])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d049523a6sm50122fac.6.2026.03.27.11.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 11:22:42 -0700 (PDT)
From: Thomas Haynes <loghyr@gmail.com>
X-Google-Original-From: Thomas Haynes <loghy@gmail.com>
Date: Fri, 27 Mar 2026 11:22:39 -0700
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <aglo@umich.edu>, Thomas Haynes <loghyr@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nfs: update inode ctime after removexattr
 operation
Message-ID: <acbJsryTMYCMlE_o@mana>
References: <20260324-nfs-7-1-v2-0-d110da3c0036@kernel.org>
 <20260324-nfs-7-1-v2-2-d110da3c0036@kernel.org>
 <CAN-5tyFpsuE9+5ZvAASwvTYKtcN5jNpAxi8ejde90e-vpUzFKg@mail.gmail.com>
 <284ca17e74af8c4f5942b2952f2bf75490dd17c0.camel@kernel.org>
 <CAN-5tyFsEUcSUycb4JjxH5v754SefwOH=zt24KtxEC_Ow4OjMw@mail.gmail.com>
 <80b423c66dba84b46be1084307d2c66b935065bc.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80b423c66dba84b46be1084307d2c66b935065bc.camel@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[umich.edu,gmail.com,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20474-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,umich.edu:email]
X-Rspamd-Queue-Id: 86A60348F94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 12:59:54PM -0800, Jeff Layton wrote:
> On Fri, 2026-03-27 at 12:20 -0400, Olga Kornievskaia wrote:
> > On Fri, Mar 27, 2026 at 11:50 AM Jeff Layton <jlayton@kernel.org> wrote:
> > > 
> > > On Fri, 2026-03-27 at 11:11 -0400, Olga Kornievskaia wrote:
> > > > On Tue, Mar 24, 2026 at 1:32 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > > > 
> > > > > xfstest generic/728 fails with delegated timestamps. The client does a
> > > > > removexattr and then a stat to test the ctime, which doesn't change. The
> > > > > stat() doesn't trigger a GETATTR because of the delegated timestamps, so
> > > > > it relies on the cached ctime, which is wrong.
> > > > > 
> > > > > The setxattr compound has a trailing GETATTR, which ensures that its
> > > > > ctime gets updated. Follow the same strategy with removexattr.
> > > > 
> > > > This approach relies on the fact that the server the serves delegated
> > > > attributes would update change_attr on operations which might now
> > > > necessarily happen (ie, linux server does not update change_attribute
> > > > on writes or clone). I propose an alternative fix for the failing
> > > > generic/728.
> > > > 
> > > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > > index 7b3ca68fb4bb..ede1835a45b3 100644
> > > > --- a/fs/nfs/nfs42proc.c
> > > > +++ b/fs/nfs/nfs42proc.c
> > > > @@ -1389,7 +1389,13 @@ static int _nfs42_proc_removexattr(struct inode
> > > > *inode, const char *name)
> > > >             &res.seq_res, 1);
> > > >         trace_nfs4_removexattr(inode, name, ret);
> > > >         if (!ret)
> > > > -               nfs4_update_changeattr(inode, &res.cinfo, timestamp, 0);
> > > > +               if (nfs_have_delegated_attributes(inode)) {
> > > > +                       nfs_update_delegated_mtime(inode);
> > > > +                       spin_lock(&inode->i_lock);
> > > > +                       nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
> > > > +                       spin_unlock(&inode->i_lock);
> > > > +               } else
> > > > +                       nfs4_update_changeattr(inode, &res.cinfo, timestamp, 0);
> > > > 
> > > >         return ret;
> > > >  }
> > > > 
> > > 
> > > What's the advantage of doing it this way?
> > > 
> > > You just sent a REMOVEXATTR operation to the server that will change
> > > the mtime there. The server has the most up-to-date version of the
> > > mtime and ctime at that point.
> > 
> > In presence of delegated attributes, Is the server required to update
> > its mtime/ctime on an operation? As I mentioned, the linux server does
> > not update its ctime/mtime for WRITE, CLONE, COPY.
> > 
> > Is possible that
> > some implementations might be different and also do not update the
> > ctime/mtime on REMOVEXATTR?
> > 
> > Therefore I was suggesting that the patch
> > relies on the fact that it would receive an updated value. Of course
> > perhaps all implementations are done the same as the linux server and
> > my point is moot. I didn't see anything in the spec that clarifies
> > what the server supposed to do (and client rely on).
> > 
> 
> (cc'ing Tom)
> 
> That is a very good point.
> 
> My interpretation was that delegated timestamps generally covered
> writes, but SETATTR style operations that do anything beyond only
> changing the mtime can't be cached.
> 
> We probably need some delstid spec clarification: for what operations
> is the server required to disable timestamp updates when a write
> delegation is outstanding?
> 
> In the case of nfsd, we disable timestamp updates for WRITE/COPY/CLONE
> but not SETATTR/SETXATTR/REMOVEXATTR.
> 
> How does the Hammerspace anvil behave? Does it disable c/mtime updates
> for writes when there is an outstanding timestamp delegation like we're
> doing in nfsd? If so, does it do the same for
> SETATTR/SETXATTR/REMOVEXATTR operations as well?

Jeff,

I think the right way to look at this is closer to how size is
handled under delegation in RFC8881, rather than as a per-op rule.

In our implementation, because we are acting as an MDS and data I/O
goes to DSes, we already treat size as effectively delegated when
a write layout is outstanding. The MDS does not maintain authoritative
size locally in that case. We may refresh size/timestamps internally
(e.g., on GETATTR by querying DSes), but we don’t treat that as
overriding the delegated authority.

For timestamps, our behavior is effectively the same model. When
the client holds the relevant delegation, the server does not
consider itself authoritative for ctime/mtime. If current values
are needed, we can obtain them from the client (e.g., via CB_GETATTR),
and the client must present the delegation stateid to demonstrate
that authority. So the authority follows the delegation, not the
specific operation.

That said, I don’t think we’ve fully resolved the semantics for all
metadata-style ops either. WRITE and SETATTR are clear in our model,
but for things like CLONE/COPY/SETXATTR/REMOVEXATTR, we’ve likely
been relying on assumptions rather than a fully consistent rule.
I.e., CLONE and COPY we just pass through to the DS and we don't
implement SETXATTR/REMOVEXATTR.

So the spec question, as I see it, is not whether REMOVEXATTR (or
any particular op) should update ctime/mtime, but whether delegated
timestamps are meant to follow the same attribute-authority model
as delegated size in RFC8881. If so, then we expect that the server
should query the client via CB_GETATTR to return updated ctime/mtime
after such operations while the delegation is outstanding.

Thanks,
Tom


> 
> 
> 
> > > It's certainly possible that the REMOVEXATTR is the only change that
> > > occurred. With what I'm proposing, we don't even need to do a SETATTR
> > > at all if nothing else changed. With your version, you would.
> > > 
> > > > > 
> > > > > Fixes: 3e1f02123fba ("NFSv4.2: add client side XDR handling for extended attributes")
> > > > > Reported-by: Olga Kornievskaia <aglo@umich.edu>
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > >  fs/nfs/nfs42proc.c      | 18 ++++++++++++++++--
> > > > >  fs/nfs/nfs42xdr.c       | 10 ++++++++--
> > > > >  include/linux/nfs_xdr.h |  3 +++
> > > > >  3 files changed, 27 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > > > index 7b3ca68fb4bb3bee293f8621e5ed5fa596f5da3f..7e5c1172fc11c9d5a55b3621977ac83bb98f7c20 100644
> > > > > --- a/fs/nfs/nfs42proc.c
> > > > > +++ b/fs/nfs/nfs42proc.c
> > > > > @@ -1372,11 +1372,15 @@ int nfs42_proc_clone(struct file *src_f, struct file *dst_f,
> > > > >  static int _nfs42_proc_removexattr(struct inode *inode, const char *name)
> > > > >  {
> > > > >         struct nfs_server *server = NFS_SERVER(inode);
> > > > > +       __u32 bitmask[NFS_BITMASK_SZ];
> > > > >         struct nfs42_removexattrargs args = {
> > > > >                 .fh = NFS_FH(inode),
> > > > > +               .bitmask = bitmask,
> > > > >                 .xattr_name = name,
> > > > >         };
> > > > > -       struct nfs42_removexattrres res;
> > > > > +       struct nfs42_removexattrres res = {
> > > > > +               .server = server,
> > > > > +       };
> > > > >         struct rpc_message msg = {
> > > > >                 .rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_REMOVEXATTR],
> > > > >                 .rpc_argp = &args,
> > > > > @@ -1385,12 +1389,22 @@ static int _nfs42_proc_removexattr(struct inode *inode, const char *name)
> > > > >         int ret;
> > > > >         unsigned long timestamp = jiffies;
> > > > > 
> > > > > +       res.fattr = nfs_alloc_fattr();
> > > > > +       if (!res.fattr)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       nfs4_bitmask_set(bitmask, server->cache_consistency_bitmask,
> > > > > +                        inode, NFS_INO_INVALID_CHANGE);
> > > > > +
> > > > >         ret = nfs4_call_sync(server->client, server, &msg, &args.seq_args,
> > > > >             &res.seq_res, 1);
> > > > >         trace_nfs4_removexattr(inode, name, ret);
> > > > > -       if (!ret)
> > > > > +       if (!ret) {
> > > > >                 nfs4_update_changeattr(inode, &res.cinfo, timestamp, 0);
> > > > > +               ret = nfs_post_op_update_inode(inode, res.fattr);
> > > > > +       }
> > > > > 
> > > > > +       kfree(res.fattr);
> > > > >         return ret;
> > > > >  }
> > > > > 
> > > > > diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> > > > > index 5c7452ce6e8ac94bd24bc3a33d4479d458a29907..ec105c62f721cfe01bfc60f5981396958084d627 100644
> > > > > --- a/fs/nfs/nfs42xdr.c
> > > > > +++ b/fs/nfs/nfs42xdr.c
> > > > > @@ -263,11 +263,13 @@
> > > > >  #define NFS4_enc_removexattr_sz                (compound_encode_hdr_maxsz + \
> > > > >                                          encode_sequence_maxsz + \
> > > > >                                          encode_putfh_maxsz + \
> > > > > -                                        encode_removexattr_maxsz)
> > > > > +                                        encode_removexattr_maxsz + \
> > > > > +                                        encode_getattr_maxsz)
> > > > >  #define NFS4_dec_removexattr_sz                (compound_decode_hdr_maxsz + \
> > > > >                                          decode_sequence_maxsz + \
> > > > >                                          decode_putfh_maxsz + \
> > > > > -                                        decode_removexattr_maxsz)
> > > > > +                                        decode_removexattr_maxsz + \
> > > > > +                                        decode_getattr_maxsz)
> > > > > 
> > > > >  /*
> > > > >   * These values specify the maximum amount of data that is not
> > > > > @@ -869,6 +871,7 @@ static void nfs4_xdr_enc_removexattr(struct rpc_rqst *req,
> > > > >         encode_sequence(xdr, &args->seq_args, &hdr);
> > > > >         encode_putfh(xdr, args->fh, &hdr);
> > > > >         encode_removexattr(xdr, args->xattr_name, &hdr);
> > > > > +       encode_getfattr(xdr, args->bitmask, &hdr);
> > > > >         encode_nops(&hdr);
> > > > >  }
> > > > > 
> > > > > @@ -1818,6 +1821,9 @@ static int nfs4_xdr_dec_removexattr(struct rpc_rqst *req,
> > > > >                 goto out;
> > > > > 
> > > > >         status = decode_removexattr(xdr, &res->cinfo);
> > > > > +       if (status)
> > > > > +               goto out;
> > > > > +       status = decode_getfattr(xdr, res->fattr, res->server);
> > > > >  out:
> > > > >         return status;
> > > > >  }
> > > > > diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> > > > > index ff1f12aa73d27b6fd874baf7019dd03195fc36e5..fcbd21b5685f46136a210c8e11c20a54d6ed9dad 100644
> > > > > --- a/include/linux/nfs_xdr.h
> > > > > +++ b/include/linux/nfs_xdr.h
> > > > > @@ -1611,12 +1611,15 @@ struct nfs42_listxattrsres {
> > > > >  struct nfs42_removexattrargs {
> > > > >         struct nfs4_sequence_args       seq_args;
> > > > >         struct nfs_fh                   *fh;
> > > > > +       const u32                       *bitmask;
> > > > >         const char                      *xattr_name;
> > > > >  };
> > > > > 
> > > > >  struct nfs42_removexattrres {
> > > > >         struct nfs4_sequence_res        seq_res;
> > > > >         struct nfs4_change_info         cinfo;
> > > > > +       struct nfs_fattr                *fattr;
> > > > > +       const struct nfs_server         *server;
> > > > >  };
> > > > > 
> > > > >  #endif /* CONFIG_NFS_V4_2 */
> > > > > 
> > > > > --
> > > > > 2.53.0
> > > > > 
> > > 
> > > --
> > > Jeff Layton <jlayton@kernel.org>
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

