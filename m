Return-Path: <linux-nfs+bounces-17822-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F8DD1B5CB
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 22:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62AEC305D904
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 21:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C64731ED81;
	Tue, 13 Jan 2026 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbdSrqF/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5E22EDD45
	for <linux-nfs@vger.kernel.org>; Tue, 13 Jan 2026 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768338633; cv=none; b=SGMMWUREejU9TYxH//3lj/WZ+fo0CjY1Xz0r7GE8IMqyIGeZ9QSgoHHT6zH7EpxAkxeSbCiAK/s4WaoPnugYsHQYS6LDkgsNa94fZh2nmie+vhi+TLKMiIzLhTiAiPbflCn3HKCjV2uPKUcT6rG00f+7QkiNoJRnBV1WepGp7KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768338633; c=relaxed/simple;
	bh=C0JtDQru3iDjaKkLKtm4a92sKewn2QGr0JB4TPxCqZw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YfVfG3/wbr478X2GqwdI3Ezqi7VIyo1IrhKnKtaqMLEI/mXTGlw+ms8Q2+v+twCMs0HXxTLuIzDzyxv/RhsvZAE9X6FnrcdWRAwiatLzcbotwBvHnBbGUA+IZvzEJqp5dKOMfbE2tyC/NPKCtmwxa99ftCuOyy1ZyNm0EfgbEXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbdSrqF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4943EC19424;
	Tue, 13 Jan 2026 21:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768338633;
	bh=C0JtDQru3iDjaKkLKtm4a92sKewn2QGr0JB4TPxCqZw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=XbdSrqF/eKQDGbVSOSqSy+Lw/b4COS+SIHFK6PbhMOVdNbGSbmFSbZdFPD4CqZ9T8
	 o129o4osaS2NfaWqqEhxtv9kc8WrqrEdi5DXzoLh/CwRqlXdJ21UkD0LYQe/24keCM
	 eue78aJ1KRoDaQsCG1xACxxuTZtBna1Jdi4PU2ibh7Dn9n2Ks4zNd58k5a0uwKWdT4
	 64f+Mc6bxpfrBYXLFaQX1ePQEGPQIBYucHVpCy9ZVdvqUYjCsly6GNCpUn5JnHft+K
	 LQaVKcq+rdUAMrbjLmI92Z1+PDJOG8OXPOS3mY5DbFSwAppHBWNIXVwrdjXQWWY4om
	 p4fOVHFuiJzSA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 56C6DF4006D;
	Tue, 13 Jan 2026 16:10:32 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 13 Jan 2026 16:10:32 -0500
X-ME-Sender: <xms:yLRmaSMbeSGXY0tUgj6GrJJdu6I_ZWx2dhmsJxjCjgGzQo9B847biQ>
    <xme:yLRmabzTxEhKh9uYZejnPXmn_C5NBK6YM7g4U_PdngTb_AJJCuMr3Ywv15huE_RO6
    EfT06AdYCZLzCMu5i58IpiPKfKJjwixcnUbcNRpBZVkU1OXLBcS-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtohepsggtohguughinh
    hgsehhrghmmhgvrhhsphgrtggvrdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghirdhn
    ghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorh
    grtghlvgdrtghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhm
X-ME-Proxy: <xmx:yLRmaVy05-mw4UJQGNnOvUipwB-xx8v5_hb6PY_PrjPzwy_Zo0aFNw>
    <xmx:yLRmaRJGZ8dJIesVtCPbHAszuGkqLPvzrvNiNOqZdq_qgUkCDJCtXg>
    <xmx:yLRmacUcULTz1Co5VT0Y7kXhm2eWA7px62R0UGI50Nd47PuVqvWM_Q>
    <xmx:yLRmacaowtgYmOdSaaB6x0fjKQffO1Ahc89ViOywzd8lfcgVQJVK-A>
    <xmx:yLRmabz5XEGmiXXG7iP9o90vGSfXW-YyRlipYWLFjXNjcMRwNil--1H2>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 38FB5780070; Tue, 13 Jan 2026 16:10:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIvM9mKjbfBc
Date: Tue, 13 Jan 2026 16:09:56 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>
Cc: "Benjamin Coddington" <bcodding@hammerspace.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <d9060e6f-f1d5-4322-80fa-3794770c0153@app.fastmail.com>
In-Reply-To: <3b5faf0e9bb08c779854e3aaa8b30fb12e86b25e.camel@kernel.org>
References: <20260113-rq_private-v1-0-88ed308364e6@kernel.org>
 <20260113-rq_private-v1-1-88ed308364e6@kernel.org>
 <5806015a-ad18-4bc9-a320-2fdab4d86969@app.fastmail.com>
 <71ddafd443a0e13f79cea09ba2b3ac4f106163ce.camel@kernel.org>
 <6f112559-43e0-41ad-864c-03b1841920d2@app.fastmail.com>
 <3b5faf0e9bb08c779854e3aaa8b30fb12e86b25e.camel@kernel.org>
Subject: Re: [PATCH 1/2] nfsd/sunrpc: add svc_rqst->rq_private pointer and remove
 rq_lease_breaker
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Jan 13, 2026, at 3:12 PM, Jeff Layton wrote:
> On Tue, 2026-01-13 at 14:41 -0500, Chuck Lever wrote:
>> 
>> On Tue, Jan 13, 2026, at 2:31 PM, Jeff Layton wrote:
>> > On Tue, 2026-01-13 at 14:21 -0500, Chuck Lever wrote:
>> > > 
>> > > On Tue, Jan 13, 2026, at 1:37 PM, Jeff Layton wrote:
>> > > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
>> > > > index eee8c3f4a251a3fae6e41679de0ec34c76caf198..8ce366c9e49220e8baf475c2e5f3424fedc1cec1 100644
>> > > > --- a/fs/nfsd/nfssvc.c
>> > > > +++ b/fs/nfsd/nfssvc.c
>> > > > @@ -900,6 +900,7 @@ nfsd(void *vrqstp)
>> > > > struct svc_xprt *perm_sock = list_entry(rqstp->rq_server->sv_permsocks.next, typeof(struct svc_xprt), xpt_list);
>> > > > struct net *net = perm_sock->xpt_net;
>> > > > struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>> > > > + struct nfsd_thread_local_info ntli = { };
>> > > > bool have_mutex = false;
>> > > >  
>> > > > /* At this point, the thread shares current->fs
>> > > > @@ -914,6 +915,8 @@ nfsd(void *vrqstp)
>> > > >  
>> > > > set_freezable();
>> > > >  
>> > > > + rqstp->rq_private = &ntli;
>> > > > +
>> > > > /*
>> > > > * The main request loop
>> > > > */
>> > > 
>> > > Thanks for tackling this one. Nits below...
>> > > 
>> > > This assumes sizeof(structure nfsd_thread_local_info) will always
>> > > be small enough that it is reasonable to keep on the stack. I
>> > > can't say that would be a good bet in the long run.
>> > > 
>> > > And we don't need the perfect reliability of not doing a dynamic
>> > > allocation here. If kmalloc(sizeof(struct nfsd_thread_local_info))
>> > > fails, the thread exits immediately, no harm.
>> > > 
>> > 
>> > Not sure how much space Ben will need (if any).
>> > 
>> > We certainly could have nfsd allocate this separately. I didn't see the
>> > point for something that is only a few bytes though.
>> 
>> If we are designing for today, another approach would be to set up
>> a BUILD_WARN_ON or other type of static build failure if this
>> structure grows larger than, say 256 bytes -- then add dynamic
>> allocation at that point.
>> 
>
> I don't see us growing this to huge proportions. I think that's the
> sort of thing we just have to watch out for as maintainers.
>
> If you really insist on a BUILD_WARN_ON tripwire, I'll add one, but it
> seems like overkill to me.

I think a tripwire documents the assumption made here in a single
line... no different than a lockdep_assert.

More critically, though, maintainers tend to have a very short memory.
Not a trustworthy lot, really.

static_assert(sizeof(struct nfsd_thread_local_info) < 256);


-- 
Chuck Lever

