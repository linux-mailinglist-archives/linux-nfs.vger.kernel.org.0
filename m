Return-Path: <linux-nfs+bounces-21438-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Hh5GBu8/GnSTAAAu9opvQ
	(envelope-from <linux-nfs+bounces-21438-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 18:21:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D62B84EC1EC
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 18:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1A0930799DD
	for <lists+linux-nfs@lfdr.de>; Thu,  7 May 2026 16:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ABB3F7A98;
	Thu,  7 May 2026 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrvD8sfY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13612DA775
	for <linux-nfs@vger.kernel.org>; Thu,  7 May 2026 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170397; cv=none; b=lFO9BBraLIc+NtBeZWh5wLZArq2ZcZWcFT4/0Uut4LYQwb9BUV9PhKUSvLVUUwNm4yX1Ify7cE1owflrNMAQZ/6bxD/sIj9bVNw9B9Kz9E2r57VwnK+P8tMBr18vS4MmYBnlmqEAXzuxfS8p3IauPtrNhpU3pvGjYGOaavI9CzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170397; c=relaxed/simple;
	bh=PuLUE747uu/IIcMnfH62AU0ZjTeTwo+w0XIMvnAzyr0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MvSTs4kj0tV8PrMT6x40fwZ4PLqG55QNaink2gQ0vBxbTPee3V5QNhHSoosU3DMy96Z6pJzzJM3RlDreNnfq9eeASMnymlpE7VM23G3aYAlj4BOL6WMyC3teGb2WwstKmQyD3dBWBBkmiF4FIthGtZ4RoSuNbox4Uv0+vvZgifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrvD8sfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B6FC2BCB8;
	Thu,  7 May 2026 16:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778170397;
	bh=PuLUE747uu/IIcMnfH62AU0ZjTeTwo+w0XIMvnAzyr0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=HrvD8sfYP7OKKqnHpvmPeXcr9VILL7X0KLlgehFsP+2TWbbPtSnsZQM+hgpk+HdJF
	 YWWnkuwyDU4gyXz25f2vYxnSBm4nzZzhcc2mX5nZftTEUv39Mc/wyrTewj72u2Qw8b
	 VNYWjXI0BnnkhJY2qWqyfrQ59kStKIe/p4RCRNIupNENIKphpNBC4T9wC8/cPRh94y
	 eP07uAyHKQy+ABLMiBIMB6mH0XVosD5MqdoqEX7yKAUQoHQs7HKtuEdTbO+8b6vAfT
	 8CCNCUQAJoKgdhnEPOiQhyG9bpeWtyIUroOAscDgjl7jFvx9EeTAqihDORoC0sTtxb
	 fJk7DeK/Qp0Mw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 22899F40069;
	Thu,  7 May 2026 12:13:16 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 07 May 2026 12:13:16 -0400
X-ME-Sender: <xms:HLr8af2HgcoJybgixy7KUCibXZBGGe94hczhsC9Dvpmb8exrmphPkw>
    <xme:HLr8aY4IHzjFXjyOGkeSw4v0Iw0TL8WWyEBO4mARujtRXK_RPBwhK9RbZSC5XXCVK
    B5vJBHRhJVN1eKQQ8FciiXgC84Ks08xGOkV62NwAARzTOmIixLRpe4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdejledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtohepuggrvhgvmhesug
    grvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohephigrnhhgvghrkhhunheshhhurgifvghirdgtohhmpdhrtg
    hpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhohhrmhhssehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhrohhn
    ughmhieskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HLr8acBrK6cE-0sLPicXq_fVwksxmklZc1MFmqcHOdulsC-xnaR6DQ>
    <xmx:HLr8aScgAqHzMz9UyH0ymGa1-DxWLQhqpfUQrG5vF6e9sHOJCX5_ng>
    <xmx:HLr8aUJxtfCvQVB-zcURkslwXDzLf5uBWtldayW2x2cnXaz9ovllnQ>
    <xmx:HLr8aauOgDt8tfUOikE-3mlyORDN45j0Im2IDhBTacoUHRMZjpR0xA>
    <xmx:HLr8aWa-cborerkNJfEEOl_uXwSj6HcOzA8HD6C_id_0ohxPr8jVOLmG>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E524C780077; Thu,  7 May 2026 12:13:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AxcNF55tVgJk
Date: Thu, 07 May 2026 18:12:55 +0200
From: "Chuck Lever" <cel@kernel.org>
To: yangerkun <yangerkun@huawei.com>,
 "Misbah Anjum N" <misanjum@linux.ibm.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <76a10e49-54a6-4813-8b58-b7cd0820fdc6@app.fastmail.com>
In-Reply-To: <c45779f6-fe6c-4037-bb1c-01cfbbaa8aac@huawei.com>
References: <20260501-cache-uaf-fix-v1-0-a49928bf4817@oracle.com>
 <c45779f6-fe6c-4037-bb1c-01cfbbaa8aac@huawei.com>
Subject: Re: [PATCH 0/6] SUNRPC: Address remaining cache_check_rcu() UAF in cache
 content files
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D62B84EC1EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21438-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Hello Erkun -

On Thu, May 7, 2026, at 11:09 AM, yangerkun wrote:
> Hi,
>
> =E5=9C=A8 2026/5/1 22:51, Chuck Lever =E5=86=99=E9=81=93:
>> Misbah Anjum reported a use-after-free in cache_check_rcu()
>> reached through e_show() while sosreport was reading
>> /proc/fs/nfsd/exports on ppc64le.  Two fixes for that report
>> landed in v7.0:
>>=20
>>    48db892356d6 ("NFSD: Defer sub-object cleanup in export put callba=
cks")
>>    e7fcf179b82d ("NFSD: Hold net reference for the lifetime of /proc/=
fs/nfs/exports fd")
>
> Back to the problem fixed by this patches, I'm a little confused why
> this UAF can be trigged.
>
> Before this patches, svc_export_put show as follow:
>
>   368 static void svc_export_put(struct kref *ref)
>   369 {
>   370         struct svc_export *exp =3D container_of(ref, struct=20
> svc_export, h.ref);
>   371
>   372         path_put(&exp->ex_path);
>   373         auth_domain_put(exp->ex_client);
>   374         call_rcu(&exp->ex_rcu, svc_export_release);
>   375 }
>
> The auth_domain_put function releases ->name using call_rcu, and
> path_put may release the dentry also via call_rcu. All of this seems to
> prevent e_show from causing a UAF. Could you point out which line in
> d_path triggers the issue?

The dentry, the mount, and the auth_domain ->name buffer all
end up RCU-freed (dentry_free() and delayed_free_vfsmnt in
fs/, svcauth_unix_domain_release_rcu() in svcauth_unix.c).
The eventual kfree isn't the problem.

The problem is the synchronous teardown inside path_put(),
which runs before svc_export_put() ever reaches its own
call_rcu():

  path_put(&exp->ex_path)
    -> dput(dentry)
       -> __dentry_kill()              [if last ref]
          -> __d_drop()                /* unhashes */
          -> dentry_unlink_inode()     /* d_inode =3D NULL */
          -> d_op->d_release() if set
          -> drops parent d_lockref    /* may cascade up */
          -> dentry_free()             /* call_rcu deferred */
    -> mntput(mnt)                     /* deferred via task_work */

The dentry pointer itself is RCU-safe, so prepend_path()'s walk
of d_parent and d_name doesn't read freed memory.  But by the
time the reader gets there, __d_clear_type_and_inode() has
already stored NULL into d_inode, __d_drop() has broken the
hash linkage, and the parent's d_lockref has been decremented
-- which can in turn fire __dentry_kill() on the parent, and
on up the tree.  An e_show() that's still inside its cache RCU
read section walks into that half-dismantled state through
seq_path(), and that's the NULL deref Misbah reported.

The earlier fix (2530766492ec, "nfsd: fix UAF when access
ex_uuid or ex_stats") moved the kfree of ex_uuid and ex_stats
into svc_export_release() so those are RCU-safe now.
path_put() and auth_domain_put() couldn't go in there because
both may sleep, and call_rcu callbacks run in softirq context.
This series uses queue_rcu_work() instead: it defers past the
grace period AND runs the callback in process context, so the
sleeping puts move into the deferred path and the window
closes.


--=20
Chuck Lever

