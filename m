Return-Path: <linux-nfs+bounces-21693-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5JAtOdfWC2qhPAUAu9opvQ
	(envelope-from <linux-nfs+bounces-21693-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 05:19:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20749576C88
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 05:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F27F3014376
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 03:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FE12877E8;
	Tue, 19 May 2026 03:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="kwdU0qq3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O7NM0QHT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB1F223DFB;
	Tue, 19 May 2026 03:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779160787; cv=none; b=leFh7MwrdDBt6IsaT3PW85MtEMfmv7jJPLB+wCGOvAzMIx4HVnqWGbl5EHqeK+QzS+cpz6bSaLzDSx+UTkDpBZ2gV4eMbzUrjoe3O2Cjj8ZjJRm4KuLg9tpoO9R5r4zpWYHDK2QVekxGMqRa/5oj39r5KNrAY3rkZ0D2y4J5wtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779160787; c=relaxed/simple;
	bh=KBn7PosK3uRD/1vuWm+YCbMzlGZ3pP0omt8Cx3r05kE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=qh3kbIP4h8cTQAJvssDTVb79ZVq+MwPjuBkt6fOXsj6nPn4roMoHgxYEZPlgryWEB6Z589K/yJuoJnFsidF7XdRTndDlWEqhljQku8Ab5rfjkophwlaFt3UXi/FbpZdoHkY1WJc/kXjrTg/oa/vYgT7lvocDxC8mDkBL2mW0z0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=kwdU0qq3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O7NM0QHT; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 81B381D00104;
	Mon, 18 May 2026 23:19:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 18 May 2026 23:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1779160784; x=1779247184; bh=v4ZFc8FwJLJO4YU+gW5JvtMEa1pwI0kSyYh
	/+5NSWKk=; b=kwdU0qq3E8dV6CneWz89Gmx9JSGImOVcb8sCRk+2ms4oRVUyEEq
	IXYL2Yogr53GG2AhbUmojmbUuKRQG9Rpdv1pIGlwS9YO+x9s1Rfb3AdWpj/Av9mz
	TV82rqIVobwIQMDZ+N0RMG8DlNxEacAtHs3lkVCXQy85cB6vd21Yist3ve3WFsiv
	Y5lSE/tX5S7X0DVnX1YRq5TAl9Ob8cbJwKuV0Vs4qYeVxyJ/73U2RrE+3UkL9NDc
	rmPZeyjcA0uyQBtdq00cA9/x6F8JurdTlmCrfmnVnkECAl/uT9+nDemAYZ4kUo8S
	xvWit/ZizcNCmaN/RBoZgkJ0rYanXUThVuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779160784; x=
	1779247184; bh=v4ZFc8FwJLJO4YU+gW5JvtMEa1pwI0kSyYh/+5NSWKk=; b=O
	7NM0QHT96XCroNpmqsoghAGZLM9k3YWnuCaxY4vE0h8TYi5OUL01XqKcJnCsjWdG
	uzIKW0WMefE4UUiSksgKaYhk/0EQiN/9J0ALn/VXir1WgCMvikiEMNDGsiSn8p5U
	Q1j2niMQk9xmCQNmEQdG0ZqL3Wvk6RwV+apm7nGPp+MToSskvEy+IqeYA88gYXkh
	yKdjzLTKk/53CkTbOsj4SmlDEqfO3uYXJG004/ZFIuV7M+DTgmDTPdmxuRwDNJS/
	oSxSYuCESa4VUTH86355sme2mbmIdHId040jbBjC5TJ6HK/B5EIGFx/vjjqpCRzP
	K4pQcpgYFNQfSDG1VbsXg==
X-ME-Sender: <xms:0NYLarEQTLoyvHnpPeQZi0uzyt1__utB7nLd6AR8Gg0wdf5E_0Z7mw>
    <xme:0NYLagGlWHML9IHakZhbcAGYFBTFqbG8ptwSwAFAYq9Pl81uS5YNs82-L4pqcdREb
    C5VVZIvQtjBWUfhLs2iFKa8VdmlWgefvZ_4HP8qA9O45rq0wA>
X-ME-Received: <xmr:0NYLagOjSiY1stydYpv9vgX7VUoMghFaK3Wo6T9Z8tYy_JjOOyL2ILrFTBivuBIIWX6e089NNy3YadYEaZU8vY7d7I49KlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epgeehfeevheehteetudehjeduiefhueehieevvdejkeeufeevkeelieffffduhfevnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    hnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhs
    uggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtoh
    hnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0NYLanGbkUfd6v8qseZesU9nKhzm8sJ6qHIkTmzogjWIGib_aevrTg>
    <xmx:0NYLavO-pQIQF0lXQc2A3KQ6cP4LfgMRzC5P7E4sQp65gJxMwURGNw>
    <xmx:0NYLag9gUy9Fv5Lo2FEhuy-FbLJq2c1dxeIiZrwDZ4_VwJk1alN3bw>
    <xmx:0NYLajRuiwzMhkFzsh4XxTV6bL3jUWw7xzjKNQW21xGFrgeKc7nwMg>
    <xmx:0NYLanUJBZzd7eWCfo7VXWJ9mhOTehXdDDEyrJPMfFVFUAzevj059PjJ>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 23:19:42 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: try_break_deleg() and atomic_open()
In-reply-to: <a278be1fa50f3c52af869233ce34d3139c33b653.camel@kernel.org>
References: <177853810078.2788210.11836979435758859096@noble.neil.brown.name>
  <72c8e1e9c9212aeb8a0cb9f5321dd576685a4f7e.camel@kernel.org>
  <177855793113.2788210.10945921479429705266@noble.neil.brown.name>
  <a278be1fa50f3c52af869233ce34d3139c33b653.camel@kernel.org>
Date: Tue, 19 May 2026 13:19:38 +1000
Message-id: <177916077874.3947082.12776465344029937479@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21693-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,noble.neil.brown.name:mid]
X-Rspamd-Queue-Id: 20749576C88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 12 May 2026, Jeff Layton wrote:
> On Tue, 2026-05-12 at 13:52 +1000, NeilBrown wrote:
> > On Tue, 12 May 2026, Jeff Layton wrote:
> > > On Tue, 2026-05-12 at 08:21 +1000, NeilBrown wrote:
> > > > Hi Jeff,
> > > >  quick question (I hope).
> > > > Should atomic_open() call try_break_deleg() on the directory
> > > > when a create is pending?
> > > > 
> > > > This seems a bit iffy because the VFS doesn't necessarily know if a
> > > > create will happen before it calls ->atomic_open, so it cannot know
> > > > if it needs to break the deleg or not.
> > > 
> > > Agreed, so I'm thinking no to doing that in generic code.
> > > 
> > > > So maybe the individual ->atomic_open functions should do it?
> > > > 
> > > 
> > > I think that's probably what has to happen:
> > > 
> > > atomic_open() is there to handle the non-trivial open cases (mostly
> > > network and clustered filesystems). Those, in general, also require
> > > non-trivial delegation/lease handling. I think we sort of need to leave
> > > it to the underlying fs in those cases since the kernel doesn't have
> > > enough info to do it.
> > 
> > I had a look and could only find gfs2/nolocks and NFSv4 as filesystems
> > which support leases on directories and use ->atomic_open.
> > 
> 
> Maybe also smb/client? Ceph also supports clustered leases, but the
> kernel client never got support for it.

Yes, those both *could* possible support directory leases, but neither
actually do at present.

>  
> > I wonder if gfs2/nolocks should not advertise ->atomic_open.  The
> > implication of nolocks is (I assume) that there is only the one active
> > client, and in that case no special handling is needed for exclusive
> > create.
> > 
> 
> Yeah, I don't see the point of GFS2's ->atomic_open in the case of a
> single-client filesystem.
> 
> > NFSv4 uses delegations to provide leases.  So the ->atomic_open
> > handler does have work to do to cancel any lease while keeping the
> > delegation.
> > We would need to either allow ->atomic_open to return the deleg_inode
> > somehow, or have ->atomic_open drop the parent lock so that it can
> > safely wait.
> > 
> > Or we could just ignore the issue until I manage to land my changed to
> > push locking down into the filesystem, and then locking/waiting becomes
> > much easier.
> > 
> 
> To make sure I understand the scenario: the NFS client has a directory
> delegation on the parent directory and an application has taken out a
> lease on that directory. We now want to issue an open(..., O_CREAT) on
> a file in that directory for which we don't yet have a dentry?

Yes, that is the scenario when ->atomic_open will be called and could
created a file without first breaking the lease that some application
holds on the directory.

> 
> FWIW, the current NFSv4 client code won't hand out leases on a
> directory, as struct nfs_dir_operations doesn't set the ->setlease
> operation, so this situation shouldn't arise. Ditto for CIFS.

Oh.... I had thought that I saw that it did.  Clearly I was wrong.
So at present the only filesystem which supports directory leases and
->atomic_open is gfs2 when "nolocks" is active and we both agree that is
an odd configuration.  But it likely doesn't work as expected and maybe
we should discuss fixing it with the gfs2 devs.

> 
> But, let's pretend that it's possible: Ideally we'd just leave it up to
> the server to recall the deleg if a create happens, but most servers
> won't revoke the deleg of the client making the change. So I think if
> we ever did want to support this, then the NFSv4 client would need to
> revoke the (local application's) lease on its own.

Yes.  One approach is to decide that ->atomic_open needs to handle any
lease breaking that might be needed.  In that case we should document
this requirement for atomic_open.

The other approach is to have the VFS proactively break the lease if a
create is expected.

> 
> > 
> > > 
> > > > I'm looking at dentry_create() which calls atomic_open() is quite a
> > > > different way to how lookup_open() calls it.  I'd like to change
> > > > nfsd4 so it calls something a lot more like lookup_open() and in
> > > > looking at what I would need to change, delegated_inode stood out.
> > > > 
> > > 
> > > Understood. I wish that were a bit less klunky, but I don't see a great
> > > way to make it so.
> > 
> > We could check for a lease and if one is present then do the lookup
> > separately from ->atomic_open.  If that finds a match then no create is
> > needed.  If it doesn't then there is justification to break the lease
> > before calling ->atomic_open.
> > 
> > This means that when there is a lease on an NFS directory, other apps
> > have to do a LOOKUP for uncached names before sending a creating OPEN.
> > Maybe that is an acceptable cost.
> > 
> > Should an O_CREAT open *always* break a directory lease, even if the
> > name happens to exist?
> > I note that man/man2const/F_GETLEASE.2const in man-pages.git doesn't
> > mention directories.
> > 
> 
> There is a coming update to the manpage, but it may not have trickled
> out to the distros yet. My thinking at this point is that this would
> have to be handled inside of the NFS (or CIFS) client.

Where can I see the manpage update?  It isn't in
   https://git.kernel.org/pub/scm/docs/man-pages/man-pages/

> 
> Now though I'm wondering if the NFSv4 client-side lease implementation
> is actually broken:
> 
> Suppose an application takes out a read lease on a fd1 for a file and
> then another application on the same client opens fd2 on the file for
> write. I don't think a lease break will happen today since the activity
> comes from the same client.
> 
> OTOH, maybe it does work since the v4 client does set a local lease on
> the file? I think we'll need to test this to see how that works.

I think the local lease handling is enough to break the lease.
As long as the NFS client only gives out leases when it holds a
delegation, and break them when it loses the delegation (and this is
what the code appears to do) then it should all work properly.  Testing
wouldn't hurt of course.

So the short answer to my original question is that something should
break leases when ->atomic_create is called, but it doesn't actually
matter for any filesystem at present so we can delay having a firm
opinion until someone wants to implement directory leases combined with
atomic_open.

Thanks,
NeilBrown


> -- 
> Jeff Layton <jlayton@kernel.org>
> 


