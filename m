Return-Path: <linux-nfs+bounces-20373-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDaCFKDmw2lvugQAu9opvQ
	(envelope-from <linux-nfs+bounces-20373-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 14:44:00 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5DE326061
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 14:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D021C31308A8
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 13:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293C826A0A7;
	Wed, 25 Mar 2026 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ufpw2dmd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F1C1E7660
	for <linux-nfs@vger.kernel.org>; Wed, 25 Mar 2026 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774445310; cv=none; b=nQ2hZwpgEK+tryn1vHsD5p+dgAsQMZBcpATb40WcB+0KEpGzA3RmCs6vEbw5v1xmjDh0xxvk7hswG8qotGuj3Dy6OZU3Pum2r4OdjtzL2tnuD95Rv3bBi/cX4O07lrV+IdlnorSAjdezuxH92/k87kK1ZuzX4HAjJON0Ff99+5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774445310; c=relaxed/simple;
	bh=VrtayuYLKmIwdMELbRfNa0BOEz+16aqgLPxRX1NOKPE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=S2AemWMv6lP7dhP7466Z4ufr2jI5UOFYZsusIGUZb+fWicVQ1Hc09fZ1PzOFRpXUA5/Y/LM4qpDzCiSUfHg0Ffa9ClJNZhGi3JpUconH5gDNUtD8HfjLZmbac4mydlmf60b95Lp80yReZ04rAIW6lSPbP1TXM9D1yRLU/y9bKnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ufpw2dmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FF7C4AF0B;
	Wed, 25 Mar 2026 13:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774445309;
	bh=VrtayuYLKmIwdMELbRfNa0BOEz+16aqgLPxRX1NOKPE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Ufpw2dmd6/oA4c0ZAHC6bxe982nbyCkMRRmaYIDHiYe3iM/dbxnTP+6cYA3/IlQjC
	 KF6VRYAq4jSZvVgPPuKK1jXNLPWkZSRIyRnWxAeOLn7nxSkpKTvfShyCqJlkwe+A44
	 fnxV8sh8/LeW38RSE1q1ccPSMwbvMS0IaNm8EK3nwqqrjMj/uGEs4KP+SKtyrnYw0M
	 Lqyo3KPyxaEzqJ6o4lQySiQ9PPQsxAaE7HWV8oVh+H9ZiR+2u8I1N2aRQkUsRmDSka
	 8n6WHFfXyEp809GMPV99+pndJgphFxD0hT/uJ+YM4qHGdQ+mXLewhHNrZuaCqXyJet
	 23PRSY16BkIDg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 68894F40070;
	Wed, 25 Mar 2026 09:28:28 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 25 Mar 2026 09:28:28 -0400
X-ME-Sender: <xms:_OLDaTfz9u7X5WeE3H20BwZG7x7IHAd7iaAPGplrwnk9JBi8ENJiMg>
    <xme:_OLDaUDM62EKkYFlY0EAbXYExRpTDZii8UWo0Ub8s4xTeU0AJILNrCTJ2wGzaWAro
    0KPjBqUxXG0vPKhHJlSTvk6m216UpMlvrQBX4gTpCjwxOvh49QiGKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeejhfdutdetfeetvdevfeevtdelueelffdtleefledtteefteefgffhieefgeelieen
    ucffohhmrghinhepuggvsghirghnrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    peekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvghilhessghrohifnhdrnh
    grmhgvpdhrtghpthhtohepudduvdekkeeiudessghughhsrdguvggsihgrnhdrohhrghdp
    rhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrvg
    hgrhgvshhsihhonhhssehlvggvmhhhuhhishdrihhnfhhopdhrtghpthhtohepthhjrdhi
    rghmrdhtjhesphhrohhtohhnrdhmvgdprhgtphhtthhopehokhhorhhnihgvvhesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_OLDaQPHFcNP3khHfVWOshjoG-BFipJK1sc8KuhI1UX2ICVSOd-2ew>
    <xmx:_OLDaZhOiuS-qOdUZWJcoUOnKINMRrv_UJuwaa6bdCnqNfnW35qldQ>
    <xmx:_OLDaa7bvVz9YDK5eWMCUlSbLcH_xVXrKbbmzeZgKmoy5FfTT4ms7w>
    <xmx:_OLDaY2SKYbNqFIPJL9SPxHHiHJ-ntLnE0awvimUNwhy8zA6mpUg3Q>
    <xmx:_OLDadtD2lol2ZirswO9WjVuddTli5K98xdCbs98nMv79lzUVtwRMG_N>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3C3FF780076; Wed, 25 Mar 2026 09:28:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_jyC0Lb0WUR
Date: Wed, 25 Mar 2026 09:28:08 -0400
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Thorsten Leemhuis" <regressions@leemhuis.info>, 1128861@bugs.debian.org,
 Tj <tj.iam.tj@proton.me>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, stable@vger.kernel.org
Message-Id: <a6e6a731-2885-4510-87dd-45e6a8f4fbd7@app.fastmail.com>
In-Reply-To: <177442248735.2237155.773724155681455344@noble.neil.brown.name>
References: <c0f15088-3fc0-487a-9f24-cf89c158420d@proton.me>
 <177266540127.7472.3460090956713656639@noble.neil.brown.name>
 <6ba41798-9c69-44f5-9a4e-09336c75a4b9@leemhuis.info>
 <cf78feb7ffaee6ed478afb734d2ede149597de86.camel@kernel.org>
 <177434721528.7102.13514118512738778346@noble.neil.brown.name>
 <d4773958-5ae5-42d4-b785-6598b5c9b27a@app.fastmail.com>
 <177442248735.2237155.773724155681455344@noble.neil.brown.name>
Subject: Re: [PATCH] lockd: fix TEST handling when not all permissions are available.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20373-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,brown.name:email,proton.me:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0D5DE326061
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Wed, Mar 25, 2026, at 3:08 AM, NeilBrown wrote:
> On Wed, 25 Mar 2026, Chuck Lever wrote:
>> 
>> On Tue, Mar 24, 2026, at 6:13 AM, NeilBrown wrote:
>> > From: NeilBrown <neil@brown.name>
>> >
>> > The F_GETLK fcntl can work with either read access or write access or
>> > both.  It can query F_RDLCK and F_WRLCK locks in either case.
>> >
>> > However lockd currently treats F_GETLK similar to F_SETLK in that read
>> > access is required to query an F_RDLCK lock and write access is required
>> > to query a F_WRLCK lock.
>> >
>> > This is wrong and can cause problem - e.g.  when qemu accesses a
>> > read-only (e.g. iso) filesystem image over NFS (though why it queries
>> > if it can get a write lock - I don't know.  But it does, and this works
>> > with local filesystems).
>> >
>> > So we need TEST requests to be handled differently.  To do this:
>> >
>> > - change nlm_do_fopen() to accept O_RDWR as a mode and in that case
>> >   succeed if either a O_RDONLY or O_WRONLY file can be opened.
>> > - change nlm_lookup_file() to accept a mode argument from caller,
>> >   instead of deducing base on lock time, and pass that on to nlm_do_fopen()
>> > - change nlm4svc_retrieve_args() and nlmsvc_retrieve_args() to detect
>> >   TEST requests and pass O_RDWR as a mode to nlm_lookup_file, passing
>> >   the same mode as before for other requests.  Also set
>> >    lock->fl.c.flc_file to whichever file is available for TEST requests.
>> > - change nlmsvc_testlock() to also not calculate the mode, but to use
>> >   whenever was stored in lock->fl.c.flc_file.
>> >
>> > Reported-by: Tj <tj.iam.tj@proton.me>
>> > Link:  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1128861
>> > Fixes: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
>> > Signed-off-by: NeilBrown <neil@brown.name>
>> 
>> Hi Neil, which kernels should this fix apply to?
>> 
>
> v6.13 and later. So linux-6.18.y and linux-6.19.y

Assuming that includes upstream, I recommend that I take this
into nfsd-testing / nfsd-next and let nature, ah, er, stable
automation, take it's course.


> The Fixes: tag is actually wrong.  This bug has been present forever.
> However a different bug that 
>   Commit: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
> fixed was hiding the bug.
>
> So it should probably be marked
>   Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
> with an explanation.

IIUC, we want Fixes: to point to the commit that introduced
the issue (Fixes: since forever) and then use a "# v6.13+"
comment on the Cc: stable to control how far back to backport
it.

Commit message could mention that 4cc9b9f2bf4d uncovered the
issue.

-- 
Chuck Lever

