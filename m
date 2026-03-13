Return-Path: <linux-nfs+bounces-20119-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEjEJwRYs2kRVQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20119-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:19:16 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B6E27B884
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 987F8302ECAE
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 00:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4CB257827;
	Fri, 13 Mar 2026 00:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="gHD+X8LZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cCdkekOP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93875191;
	Fri, 13 Mar 2026 00:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773361147; cv=none; b=AzsiR7Wkyaex8qDknmU3dNmJejChFfrbPhR6bCWiBjY15UsdYm+59Z7MjRQnPo3Gmr6QJ9taLhsy6EMxgFyjiPLTbV6P3hXHiI1Mcjkn+n0bteYwhp88GwYcTrqX/gekV18KdkkSdgt4V7Ajte0qo9TDRjYWHq6AXRIvkhbDySQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773361147; c=relaxed/simple;
	bh=KDownSrJa5S3EqGFi/GZy1HPESB/36MNwmQwJTfITNs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=LXOJLgK2hIr46xWJEMJLAapItWGFd9kRKjO7S676rr7rLFynCxJ/vH0dpCvvesB225rs0KpTLnpk9mYOF9W6VOpKm55aMhHnntub3ECUO5VI7LJgZa2DnrbbxU8QCoorKuq7bKGidQWKeKlvwXz26Eyfb+Sp0Ou48pfmce6YWQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=gHD+X8LZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cCdkekOP; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 8CEA61301B20;
	Thu, 12 Mar 2026 20:19:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 20:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1773361144; x=1773368344; bh=mVG8eebTQIYrNSCfz5AoYNPWvAP9zOmA/oS
	XBEUNMDg=; b=gHD+X8LZJV5BmcTxyVzSi4eOH+f9NWdLk6voSZ3Dk2TmtFtrTPT
	n0z2oXB44COIaMxym9EotuPwl3zhBchA17LQD1aiXLP0HZVx+1sB2rDvs+59CClN
	HQKjtkq+MLlefiP50e3G0ZUzDRVImhJt8LXC5Gk+3LL4kz0dWCTiZEgkORI83H3g
	IYzMIhIFS+pW8u+iq3O1fDK+eB6xv0w3oEKr75CQKG3ENMDVGe/ATK98/l7Dvx/P
	8BZhP/BMTsa8A8nINOCn4yT0evPyJ+NeT9UVxbDjMi1RnmCTf2Vmbpsgbeb+2prd
	AnO6/VSTlvk8uuzd90K874TkKVJWxfC+iOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773361144; x=
	1773368344; bh=mVG8eebTQIYrNSCfz5AoYNPWvAP9zOmA/oSXBEUNMDg=; b=c
	CdkekOPdZGeTHq9Q9fn6kwRHxICBqhAbEe7Mbn8RL0/ghUTZud8i2luiteEmp2Ir
	nIdMJTy2arC7PIdd3QUxuvFoTPxCOMLV9z6Gm7Dry2+55WAsz8/lpUpp6KLCvOb5
	vppTuCMIOaaruvILxo7wGqRgbVRfmvszAtPJWbhzUWIoBUdJz8+7BU3zgxJSlbc3
	fpGHsm7gMQ5BqZ2Qbs1zxa7FgNneoKrfT70cZbcDqlzmSr5Rt1Zdfq8ZqH/0hCpG
	u4ztiIjqn7BZ94m/pkzsJPqZlNum+Fn4NWKv3hqcNWG2BtBRflNBWi/TcF8QJ+Eo
	3H4DqYmdO0Ph/KIpM2FGA==
X-ME-Sender: <xms:9lezaf2biEH_YUoVtaJ788TBctRMYMGJjfZ2DGR5uanh1iY0Bnn1tg>
    <xme:9lezaRxzKm32RjDuV_b2LpuNVPPb6Y2SpMCDjskankSuVyTtPWjSsFcMWwjNHIFU7
    GLRMDp98i1zC2yMmBsdKulbM_AH2YMuIt5X8wc4fPQA-OpC2Q>
X-ME-Received: <xmr:9lezaa84oPqo9JeTHF-KiyHUZaJt4h0JSykKqUiirLVobFQ0qtPIFeYYpGFOGnN83U9sO87B36Hyg9vaeC9k5oIsMjNlS0OCsh5IMJauHcVf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epffevjeeljeehueejgeehleelueevudehjeekgeevueffteevhfefvedtueeugfejnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhm
    rghilhdrnhgvthdpnhgspghrtghpthhtohephedupdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthht
    oheplhhinhhugidqgihfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqthhrrggtvgdqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9lezaSQ88me8CYxNCjygrSQBmtG4cdv1lL3aUTLRRuM52pJKUU1ccw>
    <xmx:9lezaXkQlDHP4UxMpnGEVP1brRONq1oRM3xyFBblzX9245pjYr4Vpw>
    <xmx:9lezaSZBls0VHhctSLEpvUTcq6jJd_Fbrs8I5U1SyxvxEE-JGS1Fuw>
    <xmx:9lezaak5kvHNn-TYlzGIxM5qxPwoE_QzIk7oFu49dZPa1Fp3mUUnVA>
    <xmx:-FezaRCDWnLXkmnc85hbOjTGKD_omhp2YPsIbC_7rVSfPvFCo06RTGxC>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:18:49 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Carlos Maiolino" <cem@kernel.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Jan Harkes" <jaharkes@cs.cmu.edu>, "Hugh Dickins" <hughd@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>,
 "Steve French" <sfrench@samba.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Sungjong Seo" <sj1557.seo@samsung.com>,
 "Yuezhang Mo" <yuezhang.mo@sony.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Breno Leitao" <leitao@debian.org>, "Theodore Ts'o" <tytso@mit.edu>,
 "Andreas Dilger" <adilger.kernel@dilger.ca>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Ilya Dryomov" <idryomov@gmail.com>,
 "Alex Markuze" <amarkuze@redhat.com>,
 "Viacheslav Dubeyko" <slava@dubeyko.com>,
 "Tyler Hicks" <code@tyhicks.com>,
 "Andreas Gruenbacher" <agruenba@redhat.com>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Jeremy Kerr" <jk@ozlabs.org>, "Ard Biesheuvel" <ardb@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 coda@cs.cmu.edu, linux-mm@kvack.org, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
 gfs2@lists.linux.dev, linux-um@lists.infradead.org,
 linux-efi@vger.kernel.org
Subject: Re: [PATCH RFC 00/53] lift lookup out of exclive lock for dir ops
In-reply-to: <20260312193847.28c32a2c@gandalf.local.home>
References: <20260312214330.3885211-1-neilb@ownmail.net>,
 <20260312193847.28c32a2c@gandalf.local.home>
Date: Fri, 13 Mar 2026 11:18:47 +1100
Message-id: <177336112755.5556.2850267364383380917@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20119-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,cs.cmu.edu,google.com,linux.alibaba.com,redhat.com,auristor.com,samba.org,samsung.com,sony.com,debian.org,mit.edu,dilger.ca,dubeyko.com,tyhicks.com,nod.at,cambridgegreys.com,sipsolutions.net,ozlabs.org,vger.kernel.org,kvack.org,lists.infradead.org,lists.linux.dev];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_GT_50(0.00)[51];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,noble.neil.brown.name:mid,ownmail.net:dkim,ownmail.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,brown.name:replyto]
X-Rspamd-Queue-Id: 88B6E27B884
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026, Steven Rostedt wrote:
> On Fri, 13 Mar 2026 08:11:47 +1100
> NeilBrown <neilb@ownmail.net> wrote:
>=20
> > *[PATCH 26/53] smb/client: don't unhashed and rehash to prevent new
> > *[PATCH 27/53] smb/client: use d_splice_alias() in atomic_open
> >  [PATCH 28/53] smb/client: Use d_alloc_noblock() in
> > *[PATCH 29/53] exfat: simplify exfat_lookup()
> > *[PATCH 30/53] configfs: remove d_add() calls before
> >  [PATCH 31/53] configfs: stop using d_add().
> > *[PATCH 32/53] ext4: move dcache modifying code out of __ext4_link()
> > *[PATCH 33/53] ext4: use on-stack dentries in
>=20
> >  [PATCH 34/53] tracefs: stop using d_add().
>=20
> Hmm, another reason I hate being Cc'd on every patch of a patch bomb where
> I only need to look at one (and maybe the first) patch.

I could try to refine my tooling, but you can't please all the people
all the time...  I wonder how many people would be bothered if only the
cover-letter was sent to everyone, and the patches only went to lkml -
to be fetched from lore if not subscribed.

You would probably need to look at 02/53

https://github.com/neilbrown/linux/commit/aebdc6545eb18e5b6a7d41320f30d752996=
b3c6c

to have the context to understand 34/53

>=20
> For some reason, I'm missing several patches, and this is one of them :-p

They don't seem to have made it to lore.kernel.org either.  Maybe I'm
being rate-limited somewhere.

https://github.com/neilbrown/linux/commit/77074c04a94176d6b2b2caf44dd84f0788a=
420c4

Thanks,
NeilBrown

>=20
> -- Steve
>=20
>=20
> >  [PATCH 35/53] cephfs: stop using d_add().
> > *[PATCH 36/53] cephfs: remove d_alloc from CEPH_MDS_OP_LOOKUPNAME
> >  [PATCH 37/53] cephfs: Use d_alloc_noblock() in
> >  [PATCH 38/53] cephfs: Don't d_drop() before d_splice_alias()
> >  [PATCH 39/53] ecryptfs: stop using d_add().
> >  [PATCH 40/53] gfs2: stop using d_add().
>=20


