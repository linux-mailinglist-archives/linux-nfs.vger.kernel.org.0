Return-Path: <linux-nfs+bounces-18411-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPIuOVfqc2lXzgAAu9opvQ
	(envelope-from <linux-nfs+bounces-18411-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 22:38:31 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6043C7AF30
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 22:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 387883011040
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 21:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6C32F690F;
	Fri, 23 Jan 2026 21:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKrLZgNb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6482F0C6A
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769204307; cv=none; b=Fd5lSQlsFz6fRVY4qlHBgDGMxjRcxXkqyzj8PUSQTmSIAqWpoHGnedC2wNirddlBD4KYZaLlbWrR4Rdza7brIsNGD5j+qij/4nSgGGBnUqgyr/h6U+oCg10P8cj0GceiArXbhfWwvzPeiEL0NOLTxb6L691Q5dMXuryLXvkcQQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769204307; c=relaxed/simple;
	bh=w8gPre6MwfCwqGMCAJY7XTgHmq6unCKOVtKOkoVpHLE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bdIXOUK4Zucnvfd1RRzem4F5NrLtuk6u69T+WRhP2hlncR6pAf/LAFW39jv7XPXQ7lhO7DjwZWtIfz/FvbKlRJGTCACcz/7TnlyFARH2x/k2fvN8vrd7AYcyuHlYBsd034pg12eODhWbVRIeyOzIinRD9SpxU0K9967OldvKu+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKrLZgNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414BFC4CEF1;
	Fri, 23 Jan 2026 21:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769204307;
	bh=w8gPre6MwfCwqGMCAJY7XTgHmq6unCKOVtKOkoVpHLE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=cKrLZgNb/PPvTluPzsaafBZ+Mjhfef5Ru04b1zwe+GHUV2CYBVYtQLdByvSxPfcMY
	 mc3LB5WXK1QLCNJgqHbztWuIM9HmwOX7qpgTIvfcqr8AOVm/r2wNuNl7WwQ2yKr3g0
	 eny1s4aHgKOQxqZ7d0zGJzgbYl3Hx42IwsaPuIHgDRLXfCd9CqBPSG6/V3O4B3lBs+
	 3Irdp0Eux9yCckNweuk0oAs1OvmkLdGGn0sot6PIcvXwKKlEpIzL96ISwC+Y8RN7SW
	 4ruI/4PSXLqEXQAHHGn2Dw8+L/riDOkIQTvrYKCUJeGz13ZTJVoYK23LRB9AE3CZ30
	 vmOWexTnqd98A==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 437D2F4006A;
	Fri, 23 Jan 2026 16:38:26 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 23 Jan 2026 16:38:26 -0500
X-ME-Sender: <xms:UupzaWD_lj_Ct9k2LSC039beNg4lode5NjkKL62Et-732LdRC37gOA>
    <xme:UupzabXPyUSqMZUc-o3CRs_Fpw-WmK0euSZ01Aw2vKFrr_ZeFWTlmQEGer1GOsLQP
    8rVJyRBvj4kUOSLPmys36QU8IsTxhbwjzRPn7nm15Igp6cXYbQpYzc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduhedtudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsggtohguughinhhgsehhrghmmhgvrhhsphgrtggvrdgtohhmpdhrtghpthhtoh
    epjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgv
    vhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtohepnhgvihhlsgesohifnhhmrghilhdrnhgvthdprhgtphht
    thhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhesth
    grlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:UupzaYXPITR74gtEK5Hv-JYy1OQOxnWCuEVrtLokVaL6_2Oc18yPZA>
    <xmx:UupzaWn3W6wNvSU83ArBbkU0Z00nkfSBBspjO9uUiU82jNGh5bUlMA>
    <xmx:UupzaTA8e059q_XHtWz3qZ883KVNaBDItklQlZyAjERZJiHa7BGZyA>
    <xmx:UupzaVi-gx_l2JW8Xg2aWxpqJmz8lyfjImV-bjRClqiLXEMzkGAcug>
    <xmx:UupzaQxs_hP2NuLizBeECoWaotdbbJY1HDIzrOv-zG27ac9NEdbTckLA>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 24B09780075; Fri, 23 Jan 2026 16:38:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Akq3so5pvRuw
Date: Fri, 23 Jan 2026 16:37:35 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neilb@ownmail.net>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>,
 "Benjamin Coddington" <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <8131fa88-2f62-4724-97d1-25615b2de7d3@app.fastmail.com>
In-Reply-To: <5c7126f0ace2874ceb2af74726962875e647256d.camel@kernel.org>
References: <20260123185259.1215767-1-cel@kernel.org>
 <20260123185259.1215767-6-cel@kernel.org>
 <53120eface645028e6a33cfb3cbf1a66ccbe2ca6.camel@kernel.org>
 <8f13122c-66eb-4c54-a767-c152cc3db04d@kernel.org>
 <5c7126f0ace2874ceb2af74726962875e647256d.camel@kernel.org>
Subject: Re: [PATCH v2 05/42] NFS: Use nlmclnt_rpc_clnt() helper to retrieve nlm_host's
 rpc_clnt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-18411-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com,hammerspace.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6043C7AF30
X-Rspamd-Action: no action



On Fri, Jan 23, 2026, at 4:30 PM, Jeff Layton wrote:
> On Fri, 2026-01-23 at 15:44 -0500, Chuck Lever wrote:
>> On 1/23/26 3:23 PM, Jeff Layton wrote:
>> > On Fri, 2026-01-23 at 13:52 -0500, Chuck Lever wrote:
>> > > From: Chuck Lever <chuck.lever@oracle.com>
>> > > 
>> > > The external API definitions for lockd reside in linux/lockd/bind.h.
>> > > Because "struct nlm_host" is an internal lockd structure, bind.h
>> > > does not include a definition of it. Dereferencing that structure
>> > > outside of lockd violates the layering boundary between NFS and
>> > > lockd.
>> > > 
>> > > The proper approach is to use the nlmclnt_rpc_clnt() helper function
>> > > already provided in lockd/bind.h, which retrieves the NLM host's
>> > > struct rpc_clnt without exposing internal lockd structures. This
>> > > maintains clean separation between the NFS client and lockd
>> > > internals.
>> > > 
>> > > Note that the nlm_host's h_rpcclnt field can be NULL during
>> > > initialization (host.c:141) or after cleanup (host.c:629). Add a
>> > > NULL check before calling shutdown_client() to prevent a potential
>> > > NULL pointer dereference in the sysfs shutdown path.
>> > > 
>> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> > > ---
>> > >  fs/nfs/sysfs.c | 10 +++++++---
>> > >  1 file changed, 7 insertions(+), 3 deletions(-)
>> > > 
>> > > diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
>> > > index ea6e6168092b..186b29de0129 100644
>> > > --- a/fs/nfs/sysfs.c
>> > > +++ b/fs/nfs/sysfs.c
>> > > @@ -12,7 +12,7 @@
>> > >  #include <linux/string.h>
>> > >  #include <linux/nfs_fs.h>
>> > >  #include <linux/rcupdate.h>
>> > > -#include <linux/lockd/lockd.h>
>> > > +#include <linux/lockd/bind.h>
>> > >  
>> > >  #include "internal.h"
>> > >  #include "nfs4_fs.h"
>> > > @@ -284,8 +284,12 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
>> > >  	if (!IS_ERR(server->client_acl))
>> > >  		shutdown_client(server->client_acl);
>> > >  
>> > > -	if (server->nlm_host)
>> > > -		shutdown_client(server->nlm_host->h_rpcclnt);
>> > > +	if (server->nlm_host) {
>> > > +		struct rpc_clnt *nlm_clnt = nlmclnt_rpc_clnt(server->nlm_host);
>> > > +
>> > > +		if (nlm_clnt)
>> > > +			shutdown_client(nlm_clnt);
>> > 
>> > I don't see any locking here. Soon after this thing goes NULL, the
>> > nlm_clnt can be freed. ISTM that this ought to take a reference to
>> > nlm_clnt and put it afterward.
>> 
>> So there is no locking here before the patch is applied. The patch does
>> not change that. Do you mean that the patch should add the additional
>> reference count bump (and document that fix in the commit message) ?
>> 
>> Mason's prompts did not call this out, so I assumed there wasn't an
>> obvious UAF possible in this path.
>> 
>
> (Adding Ben since he wrote this originally...)
>
> Sorry, I didn't make it clear. This is (possibly) an existing bug and
> not something that is changed by your patches.
>
> If that value can go NULL and be freed (and it looks like it can in
> nlm_shutdown_hosts_net()) then I think that could race with someone
> writing to the "shutdown" file. OTOH, maybe that can't happen because
> the sysfs file gets removed before lockd_down() runs? I'm not sure.
>
> The safest thing might be to take and hold the (global) nlm_host_mutex
> around the NLM parts of shutdown_store(). Maybe we could add a helper
> to the nlm public interface that does that so we don't need to expose
> that mutex outside of NLM?

I asked Claude specifically to look for races, and he agrees there
is a pre-existing synchronization issue in here. Certainly could
be addressed via a pre-requisite patch to 05/42.


-- 
Chuck Lever

