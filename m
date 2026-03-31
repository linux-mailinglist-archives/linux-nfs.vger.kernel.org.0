Return-Path: <linux-nfs+bounces-20557-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDKUCPsXzGkeOQYAu9opvQ
	(envelope-from <linux-nfs+bounces-20557-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 20:52:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3313703B0
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 20:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 997CE3011776
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 18:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84203A16A3;
	Tue, 31 Mar 2026 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8EgUTjk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D716738F94A
	for <linux-nfs@vger.kernel.org>; Tue, 31 Mar 2026 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983057; cv=none; b=ZxiSDFg+652PZtaqWjwRpidzu1smdi2VQm5Jp/iFw2nudPoXUVri9P+OeWjjdOlWs4iXmqQscw2HObSTYTTl+benFHk3+vt6M3N0mDIPDuqrjITLTaNhec2zWHAkMvRHedN8QURVjRun3O4PHDnxIW4oExnLspYOQib4llfo5h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983057; c=relaxed/simple;
	bh=RYiujHcew1ybNo36Sv3nw5I2zBhocvyipc0akOPYlPQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmPsZ+0WD2MVQ+l8nco9Kvu+PZkwWc7Byf+Btp0NaR6aWciVjbOjjPgnpAxXHb+dKj6So0Za7wiAH+YpAQTTOEx6qXaSqmqdqenKrT5NSvzTz+7IuX47LMKTjxrcQtSLUg/RQ/2ENc9gOyZyOIuisuykILe/F8hMCRvJmGFe7sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8EgUTjk; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40438e0cba6so3781499fac.1
        for <linux-nfs@vger.kernel.org>; Tue, 31 Mar 2026 11:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774983055; x=1775587855; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eSJ/eXWnNsWthjGxIEF6lraolPhD6WEFsSMcFh50u08=;
        b=m8EgUTjkrZ6OsvJbNUuvBkNU4X7pYV+a+f9XvNPTW5nIhHH/aWz9LDyZYXTxLxjQIE
         rr5IC1ESeMMKy2tktrBbyRSBG1gs8a2C2OSaP0RWPknBW+aJgAXFOae/c7Byvq+ImdkR
         nsrAbel4dba9vJBtrvUudXhjc4990sO4bzXlqTTuxHJtsGnqyn2iJyjooMsFlteXCbto
         IIC6NLTCLRENtz9yiArXQ2dH6LJcTYGh/oLJ7W5t2L9VQWwzC1sp+XvtquxOcO3EgTkP
         Eg0qloEr46ta0Nzrk8yJfV5Z09yLhIfNjkBDcWdaFmiIMppPjiFq/xBK8Grakj2NIN6s
         xPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774983055; x=1775587855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSJ/eXWnNsWthjGxIEF6lraolPhD6WEFsSMcFh50u08=;
        b=qu8Hk2m1sgo+TzAQgmG9psKTglYz3zd+4W7Sag5+2efVhVzozALWW8OMlNgKrJPmuq
         njBAA7SqnaoKWp3QDKAZzF9yqvUnWV1GA3ybtf6StgU2dhLSwzLEtSEPjr8RGiYpQfat
         5Ff01xDFOY4wbfjE310yQasMd+sx/FhpIY9nhywBnjWd5mcn777RjTBy2Gpbm+RxgFd0
         Hff/XKJt9UT4osJEfov7KUXyBvjgGF5PWRS8x8XuGdwSC3nwka+1b800QnomdSPdRMLQ
         Gj0exmnVbfddH/akrKZCu3rup28zN1JV8+4QpgYlFwETuHYaOUQsUk9ScNO4i4AuOeT/
         IEvA==
X-Forwarded-Encrypted: i=1; AJvYcCU/0Y0/SX/aBgaqDSg11Grqz/woX7yw7VsXRbB8UILOx6sFL0edoJ868ubgwXT4GTTiEE7pJpPocus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxdylqo+k+TK5HfD347ZvYHAtNgzpl0FgkD0WtuaF8qZezkAXl
	Avf+tabitw2dZ8vnD/9l2MIjqh97jURzuCjPXfeQaZsrH4e9Z8f5jbv2
X-Gm-Gg: ATEYQzwDrS/L4qhkhsCTa7HgNlroxNidgQwiGt+BimVx5l0qIC5o5/mfRHc7UxKcr4f
	17DFH1F0VMYMyKMT9XvpUKfD8IgFY+/egY7t/DF5M8/+KTo7VDxRclP6uMN7QQHt/lvLJczmG80
	4SdHhmsGOaYZfYffQp2zxsjG1TQta+bHWzcOgxb/cnqClUVyhg2yJz3JWGF8rhPxyy/cG5I0NSy
	SWFot/X+xWrc68ggjCDup/erCyZRIVz8o+dgtpkSNaf1XiRW2MtsaTyFEAiR3ZnzbGYJHidFO3c
	2vzs5mYk2p2cqvyG0R60RU93Hbo/h++ONLmwVtaKEh+/rqjH9bcR1ThwCw+y/ZwrrXpNiwrHl0I
	OCI2HkmJNpd45o09EW8k3UL4jBwvRF1GSVC9lcqSUq5eiOZ0Y1eWPZjuWhJ+yfNA4pCXTLTWrwM
	udQI3TenTmochrlj6BlogUO1Zt4yTVphBp5Q6rfeuo6A==
X-Received: by 2002:a05:6820:4dcb:b0:67e:41c9:110e with SMTP id 006d021491bc7-67fabd02280mr228904eaf.54.1774983054565;
        Tue, 31 Mar 2026 11:50:54 -0700 (PDT)
Received: from localhost ([12.117.181.174])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e231ace13sm7404299eaf.9.2026.03.31.11.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 11:50:54 -0700 (PDT)
From: Thomas Haynes <loghyr@gmail.com>
X-Google-Original-From: Thomas Haynes <loghy@gmail.com>
Date: Tue, 31 Mar 2026 11:50:53 -0700
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Thomas Haynes <loghyr@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nfs: update inode ctime after removexattr
 operation
Message-ID: <acwWuf5VMKHOfSUU@mana>
References: <20260324-nfs-7-1-v2-0-d110da3c0036@kernel.org>
 <20260324-nfs-7-1-v2-2-d110da3c0036@kernel.org>
 <CAN-5tyFpsuE9+5ZvAASwvTYKtcN5jNpAxi8ejde90e-vpUzFKg@mail.gmail.com>
 <284ca17e74af8c4f5942b2952f2bf75490dd17c0.camel@kernel.org>
 <CAN-5tyFsEUcSUycb4JjxH5v754SefwOH=zt24KtxEC_Ow4OjMw@mail.gmail.com>
 <80b423c66dba84b46be1084307d2c66b935065bc.camel@kernel.org>
 <acbJsryTMYCMlE_o@mana>
 <CAN-5tyFQrt7WyW4=qLodKS2-eckAetKjs15A6U1OOdGPSL58XQ@mail.gmail.com>
 <acbfV0C-fAy4nZ-i@mana>
 <CAN-5tyGd1ZtL-sKvT251=BZa-38nOAEYbiZq5Bk+XN_ETX0PWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN-5tyGd1ZtL-sKvT251=BZa-38nOAEYbiZq5Bk+XN_ETX0PWA@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20557-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[umich.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C3313703B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 02:17:54PM -0800, Olga Kornievskaia wrote:
> On Fri, Mar 27, 2026 at 4:02 PM Thomas Haynes <loghyr@gmail.com> wrote:
> >
> > On Fri, Mar 27, 2026 at 03:36:12PM -0800, Olga Kornievskaia wrote:
> > > On Fri, Mar 27, 2026 at 2:22 PM Thomas Haynes <loghyr@gmail.com> wrote:
> > > >
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
> > >
> > > What happens when the client holding the attribute delegation (it's
> > > the authority) is doing the query? Is it the server's responsibility
> > > to query the client before replying.
> >
> > The Hammerspace server on a getattr checks to see if there is
> > a delegated stateid (and whether it is the client making the request
> > or not). If it is and the GETATTR asks for FATTR4_SIZE, FATTR4_TIME_MODIFY,
> > or FATTR4_TIME_METADATA, then it will send a CB_GETATTR before
> > responding to the client.
> 
> So... while I might not be running the latest Hammerspace bits and
> something has changed but I do not see Hammerspace server sending a
> CB_GETATTR when the "client is making a getattr request with a
> delegated stateid".

Or the process is broken on the server side.


> Example is the CLONE operation with an accompanied
> GETATTR. The server in this case updates the change attribute and
> mtime and returns different from what the client had previously in the
> OPEN back to the client (this is what the test expect but I think
> that's contradictory to what is said above). (To contrast nfsd server
> does not update the change attribute or mtime and returns the same
> value and thus making xfstest fail). So if the spec mandates that
> before answering the GETATTR a CB_GETATTR needs to be sent then
> neither of the server (Hammerspace nor linux) do that. But then again
> I'm not sure the client is not at fault for sending a GETATTR in the
> CLONE compound in the first place. For instance client does not have a
> GETATTR in the COPY compound (and then fails to pass xfstest that
> checks for modifies ctime/mtime). But the solution isn't clear to is
> it like Jeff's REMOVEXATTR approach to add the GETATTR to the COPY
> compound but that then should trigger a CB_GETATTR back to the client.
> Again probably none of the servers do that...
> 
> Another point I would like to raise is: doesn't it seem
> counter-intuitive to be in a situation where we have a
> delegation-holding client sending a GETATTR and then a server needing
> to do a CB_GETTATTR to the said client to fulfill the request.
> Delegations were supposed to reduce traffic and now we are introducing
> additional traffic instead. I guess I'm arguing that the client is
> broken to ever query for change_attr, mtime if it's holding the
> delegation. Yet the linux client (I could be wrong here) is written
> such that change_attr or mtime has to always come from the server. Say
> the application did a write() followed by a stat(). Client can't
> satisfy stat() without reaching out to the server. Yet the server is
> not the authority and before it can generate the reply for
> change_attr, mtime, it needs to callback to the client (CB_GETATTR).
> It seems it would have been better to never get a delegated attribute
> delegation in the first place?

Or the client needs to change its behaviour in this scenario? Why ask
as question to a source which is not the authority?

Or, I agree with your analysis...

> 
> > While it does not do so, if the client sent in a SETATTR in the
> > same compound we could short circuit that. Think a sort of WCC.
> >
> > > Example, client sends a CLONE
> > > operation which has a GETATTR attached. (1) is the server supposed to
> > > issue a CB_GETATTR before replying to the compound? (2) is the client
> > > not supposed to send any GETATTRs while holding an attribute
> > > delegation? CLONE is a modifying operation but client hasn't done any
> > > actual modifications to the opened file so a CB_GETATTR would return
> > > that file hasn't been modified. Is the server then not going to
> > > express that the file has indeed been modified when replying to
> > > GETATTR?
> >
> > The server could argue that the client wants to know what it thinks.
> > But that isn't the argeement. The server has to query those values
> > before sending them on.
> >
> > >
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
> > > > Thanks,
> > > > Tom
> > > >
> > > >
> > > > >
> > > > >
> > > > >
> > > > > > > It's certainly possible that the REMOVEXATTR is the only change that
> > > > > > > occurred. With what I'm proposing, we don't even need to do a SETATTR
> > > > > > > at all if nothing else changed. With your version, you would.
> > > > > > >
> > > > > > > > >
> > > > > > > > > Fixes: 3e1f02123fba ("NFSv4.2: add client side XDR handling for extended attributes")
> > > > > > > > > Reported-by: Olga Kornievskaia <aglo@umich.edu>
> > > > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > > ---
> > > > > > > > >  fs/nfs/nfs42proc.c      | 18 ++++++++++++++++--
> > > > > > > > >  fs/nfs/nfs42xdr.c       | 10 ++++++++--
> > > > > > > > >  include/linux/nfs_xdr.h |  3 +++
> > > > > > > > >  3 files changed, 27 insertions(+), 4 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > > > > > > > index 7b3ca68fb4bb3bee293f8621e5ed5fa596f5da3f..7e5c1172fc11c9d5a55b3621977ac83bb98f7c20 100644
> > > > > > > > > --- a/fs/nfs/nfs42proc.c
> > > > > > > > > +++ b/fs/nfs/nfs42proc.c
> > > > > > > > > @@ -1372,11 +1372,15 @@ int nfs42_proc_clone(struct file *src_f, struct file *dst_f,
> > > > > > > > >  static int _nfs42_proc_removexattr(struct inode *inode, const char *name)
> > > > > > > > >  {
> > > > > > > > >         struct nfs_server *server = NFS_SERVER(inode);
> > > > > > > > > +       __u32 bitmask[NFS_BITMASK_SZ];
> > > > > > > > >         struct nfs42_removexattrargs args = {
> > > > > > > > >                 .fh = NFS_FH(inode),
> > > > > > > > > +               .bitmask = bitmask,
> > > > > > > > >                 .xattr_name = name,
> > > > > > > > >         };
> > > > > > > > > -       struct nfs42_removexattrres res;
> > > > > > > > > +       struct nfs42_removexattrres res = {
> > > > > > > > > +               .server = server,
> > > > > > > > > +       };
> > > > > > > > >         struct rpc_message msg = {
> > > > > > > > >                 .rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_REMOVEXATTR],
> > > > > > > > >                 .rpc_argp = &args,
> > > > > > > > > @@ -1385,12 +1389,22 @@ static int _nfs42_proc_removexattr(struct inode *inode, const char *name)
> > > > > > > > >         int ret;
> > > > > > > > >         unsigned long timestamp = jiffies;
> > > > > > > > >
> > > > > > > > > +       res.fattr = nfs_alloc_fattr();
> > > > > > > > > +       if (!res.fattr)
> > > > > > > > > +               return -ENOMEM;
> > > > > > > > > +
> > > > > > > > > +       nfs4_bitmask_set(bitmask, server->cache_consistency_bitmask,
> > > > > > > > > +                        inode, NFS_INO_INVALID_CHANGE);
> > > > > > > > > +
> > > > > > > > >         ret = nfs4_call_sync(server->client, server, &msg, &args.seq_args,
> > > > > > > > >             &res.seq_res, 1);
> > > > > > > > >         trace_nfs4_removexattr(inode, name, ret);
> > > > > > > > > -       if (!ret)
> > > > > > > > > +       if (!ret) {
> > > > > > > > >                 nfs4_update_changeattr(inode, &res.cinfo, timestamp, 0);
> > > > > > > > > +               ret = nfs_post_op_update_inode(inode, res.fattr);
> > > > > > > > > +       }
> > > > > > > > >
> > > > > > > > > +       kfree(res.fattr);
> > > > > > > > >         return ret;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> > > > > > > > > index 5c7452ce6e8ac94bd24bc3a33d4479d458a29907..ec105c62f721cfe01bfc60f5981396958084d627 100644
> > > > > > > > > --- a/fs/nfs/nfs42xdr.c
> > > > > > > > > +++ b/fs/nfs/nfs42xdr.c
> > > > > > > > > @@ -263,11 +263,13 @@
> > > > > > > > >  #define NFS4_enc_removexattr_sz                (compound_encode_hdr_maxsz + \
> > > > > > > > >                                          encode_sequence_maxsz + \
> > > > > > > > >                                          encode_putfh_maxsz + \
> > > > > > > > > -                                        encode_removexattr_maxsz)
> > > > > > > > > +                                        encode_removexattr_maxsz + \
> > > > > > > > > +                                        encode_getattr_maxsz)
> > > > > > > > >  #define NFS4_dec_removexattr_sz                (compound_decode_hdr_maxsz + \
> > > > > > > > >                                          decode_sequence_maxsz + \
> > > > > > > > >                                          decode_putfh_maxsz + \
> > > > > > > > > -                                        decode_removexattr_maxsz)
> > > > > > > > > +                                        decode_removexattr_maxsz + \
> > > > > > > > > +                                        decode_getattr_maxsz)
> > > > > > > > >
> > > > > > > > >  /*
> > > > > > > > >   * These values specify the maximum amount of data that is not
> > > > > > > > > @@ -869,6 +871,7 @@ static void nfs4_xdr_enc_removexattr(struct rpc_rqst *req,
> > > > > > > > >         encode_sequence(xdr, &args->seq_args, &hdr);
> > > > > > > > >         encode_putfh(xdr, args->fh, &hdr);
> > > > > > > > >         encode_removexattr(xdr, args->xattr_name, &hdr);
> > > > > > > > > +       encode_getfattr(xdr, args->bitmask, &hdr);
> > > > > > > > >         encode_nops(&hdr);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > @@ -1818,6 +1821,9 @@ static int nfs4_xdr_dec_removexattr(struct rpc_rqst *req,
> > > > > > > > >                 goto out;
> > > > > > > > >
> > > > > > > > >         status = decode_removexattr(xdr, &res->cinfo);
> > > > > > > > > +       if (status)
> > > > > > > > > +               goto out;
> > > > > > > > > +       status = decode_getfattr(xdr, res->fattr, res->server);
> > > > > > > > >  out:
> > > > > > > > >         return status;
> > > > > > > > >  }
> > > > > > > > > diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> > > > > > > > > index ff1f12aa73d27b6fd874baf7019dd03195fc36e5..fcbd21b5685f46136a210c8e11c20a54d6ed9dad 100644
> > > > > > > > > --- a/include/linux/nfs_xdr.h
> > > > > > > > > +++ b/include/linux/nfs_xdr.h
> > > > > > > > > @@ -1611,12 +1611,15 @@ struct nfs42_listxattrsres {
> > > > > > > > >  struct nfs42_removexattrargs {
> > > > > > > > >         struct nfs4_sequence_args       seq_args;
> > > > > > > > >         struct nfs_fh                   *fh;
> > > > > > > > > +       const u32                       *bitmask;
> > > > > > > > >         const char                      *xattr_name;
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > >  struct nfs42_removexattrres {
> > > > > > > > >         struct nfs4_sequence_res        seq_res;
> > > > > > > > >         struct nfs4_change_info         cinfo;
> > > > > > > > > +       struct nfs_fattr                *fattr;
> > > > > > > > > +       const struct nfs_server         *server;
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > >  #endif /* CONFIG_NFS_V4_2 */
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > 2.53.0
> > > > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Jeff Layton <jlayton@kernel.org>
> > > > >
> > > > > --
> > > > > Jeff Layton <jlayton@kernel.org>
> > > >

