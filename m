Return-Path: <linux-nfs+bounces-20117-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O9sH8VVs2nyVAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20117-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:09:41 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F11527B6B7
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 01:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FB6330FCF5F
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 00:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DBE2B9BA;
	Fri, 13 Mar 2026 00:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="nmFe2jtL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G5Cai4kt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5962AD10;
	Fri, 13 Mar 2026 00:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360571; cv=none; b=I1DFiZ/OLj0KL9rLbsLgoJFkHMp/9lBHdDNOJBIrDYoiQhqD6/9L9b8pPjQkz171Gqgr1Qe+A3nGI5ND0VwSK/9EcdsHn3pytXPEj1+C11OfOmDu86LSGTDDWS68oxzaG2vPWsOai1QLJJ7zyfjpCv4na3rTzr9r15WrxCnu4a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360571; c=relaxed/simple;
	bh=5WyyyzalVTsOFqKBoq2Ui24NLNW5bx4BjtZMs2Kh5tw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=dujyKcht/XrBAUYE9c9wFBCNQFpvY078J69alGAOV1wKYHx7FQ4F5bISt4nOaIF5V6UYz2EP0r7s0CGNcULsZZgS9pf0mrLKzMM6UMm2p4D1Gmayt3GdJyPsfrab58sJ47/DVA2O9ssBidZlLsri0YGYFelrKyB6wqp1wrc1OLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=nmFe2jtL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G5Cai4kt; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 453521300F4D;
	Thu, 12 Mar 2026 20:09:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 12 Mar 2026 20:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1773360565; x=1773367765; bh=KgAiLbof0iO8cGF8i0bS3fRoWLrp1RkGsUr
	3z87f+QY=; b=nmFe2jtLyLr+7u8+TDKRncwnQQgfmtMxU9rW2fcZXcAX5N/O+oK
	mkTcvLt2tGqnfh0yQZ9VxfeJXHOmQK3xmRCh0WkZO8z+9EbGkHt1EK+1v9oEDQFk
	yjK2H4B7GbHLcXZXF6XJNsP5Q5oExxA0/3HptDHC4Yo7bGMxV66pr3UW7B9oRSB4
	vuiTbATRXYBbLXhvd6Op9YEKWgq8ir7OPi6JV+oRhKZvn8t8u83ENmYYrl/BoZV0
	FrCRFffyXHlTGaGOZ5VUzpnpHtLR7Cp1SV1LfUlzqP/nSXhBI3LJq0G6aafkvcXQ
	H921q+OqQ7yY81EaudsM9yPaG6U2Be50mTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773360565; x=
	1773367765; bh=KgAiLbof0iO8cGF8i0bS3fRoWLrp1RkGsUr3z87f+QY=; b=G
	5Cai4ktm8ZYp5XyzSdEJarMpSfeXDzWAL8MTxUvYBQ2hpUgY3TIWYBA9NiTzGeNa
	5E83ul9G/GPuOexqHFwoNmE5Bf87gj016HXSgb9HA2ajcfY5cLlR/6Scnq1+bMSy
	L/Puu8DC52gTGANh4qz45QluS+yFcFx8cBkqURrLJFH5bOAyWf/oR6Uo1r93DRwO
	ChU+IBist6Pp1G8vs9yINCx1pw7Dl8SVJBTw/u/RobXjWABJlCOcI6SzK3FmMqVv
	JWB6ykQWBhykIIJXXf4XNnPkhW+lXc0X5IwRHItIgUJymc4RMF52UynxsiryvgQn
	Ohgl8jSg52zXQ1Ht0jvEQ==
X-ME-Sender: <xms:slWzaeXV7qa1u6neLd6Q1-cVt0VMASr8cnqysAFQocSTAtEfKc0JvQ>
    <xme:slWzaeSKlwNXuQd-ytFXXY0mVc_-Zjwa4_mmoEgCEIxrE6aOdvb3p8liU_ELdbDzk
    UaaJ6Rv9sIirpntfCZ3ed2iOF6DIF4YVBR0WyA36tWvjzE7914>
X-ME-Received: <xmr:slWzadcI0WZE_K5ZNf3p0KQMTKhUmZqGQsTQWME1TwSj7PSSkE9RCFBWyBYhQ55dSIow75rJ91K6-dY7EINULxs6lGnfRrWsj3AxXRa0e5UN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epgfeikeetueehudeigfefkeekleegheehueeifffhieefvdegueetgfekuddukeevnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeehuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhose
    iivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehlihhnuhigqdigfhhs
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidquhhnihhonh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhtrhgr
    tggvqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdgvgihtgeesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdgvfhhisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:slWzaSzNnugwYNYtiVWYHc4qaDBmXyQ51PSSBJ1uiNVJapnS6gluPA>
    <xmx:slWzaeEAu6gvMjez-LKBYzOhXf5W2TUuXYdFq9RYM3BZ9DviPSnwQA>
    <xmx:slWzaW4NCFWB-i4WBv0KYxfPr8CoLpfQ8pVU8lId_PRL8FTgtUuCaQ>
    <xmx:slWzaVHk7pykGSmnnTVs6z84wbljsuc816F1d1tD0LoUWms4qvgBoQ>
    <xmx:tVWzaRho-xmNtiFafDRGXsj1bH7ybmYtyFLigxgHrazcCccpxnyLB6O->
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:09:09 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
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
 "Steven Rostedt" <rostedt@goodmis.org>,
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
In-reply-to:
 <CAHk-=wh92deXvH5iXCo9mThXCBYt-jRcVu=z4kiH-f3+wZQOHA@mail.gmail.com>
References: <20260312214330.3885211-1-neilb@ownmail.net>,
 <CAHk-=wh92deXvH5iXCo9mThXCBYt-jRcVu=z4kiH-f3+wZQOHA@mail.gmail.com>
Date: Fri, 13 Mar 2026 11:09:04 +1100
Message-id: <177336054496.5556.4842794610845842132@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20117-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,cs.cmu.edu,google.com,linux.alibaba.com,redhat.com,auristor.com,samba.org,samsung.com,sony.com,debian.org,mit.edu,dilger.ca,goodmis.org,dubeyko.com,tyhicks.com,nod.at,cambridgegreys.com,sipsolutions.net,ozlabs.org,vger.kernel.org,kvack.org,lists.infradead.org,lists.linux.dev];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brown.name:replyto,ownmail.net:dkim,ownmail.net:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 1F11527B6B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026, Linus Torvalds wrote:
> On Thu, 12 Mar 2026 at 14:44, NeilBrown <neilb@ownmail.net> wrote:
> >
> > This patch set progresses my effort to improve concurrency of
> > directory operations and specifically to allow concurrent updates
> > in a given directory.
> 
> I only got about half the patches, but the ones I did get didn't raise
> my hackles.
> 
> HOWEVER.
> 
> This is very much a "absolutely requires ACKs from Al" series. Al?

Yes, I'm looking forward to Al's thoughts

> 
> Also, because I only got about half the patches, and there's 53 of
> them total, I'd really like to see a git branch for something like
> this. It makes it easier to review for me, and I suspect it makes it
> easier for some of the test robots too.

github.com/neilbrown/linux.git branch pdirops

But if you have only time for one patch, 52/53 is the one to look at.

Thanks,
NeilBrown

> 
> But again - this needs Al to look at it. Iirc he had some fundamental
> concern with the last version - hopefully now fixed, but ...
> 
>                  Linus
> 
> 


