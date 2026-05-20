Return-Path: <linux-nfs+bounces-21736-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLVpNDvbDWrE4AUAu9opvQ
	(envelope-from <linux-nfs+bounces-21736-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 18:03:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D45D5591663
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 18:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79429322401D
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 15:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E222D3F1AD5;
	Wed, 20 May 2026 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDcrDxgL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A515E3F1AB0
	for <linux-nfs@vger.kernel.org>; Wed, 20 May 2026 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289994; cv=none; b=OjmbEoayyf2MN/uBdryxTLjynk8fb/temhYIs8R/iZ+SpdZcvHRZ+af3T+bbmG0MHMmKD3fzSaKR1AdQY204ENBtVRde7uWBCVKpODeL8o6emakwc9TLUWwpvP4eg5KsRr0xrVFYjFLCcJ/K2sfLRvbRN/mhyrLe+EHmXDAIrSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289994; c=relaxed/simple;
	bh=3I5bJDpziI90OiiRYA9ZyJO0ozA3nkV+qtWlUumpJz0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bkjPgzGWNwGPJJv59vVF6LsMtRViG3m5uz1O8gxxV2+yhfElJWWFIwcW88LuDpl61k2CK0n/vlULByzPy4S06nRATUSNgYzsFg4OVlk7sSvP6ruF6iZLJIAjTebQO0IqEYMDOdeptGzBCKO9Pk4Axxivw8DME2LS3KTU2xHf7pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDcrDxgL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867931F000E9;
	Wed, 20 May 2026 15:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779289993;
	bh=8dqhKrp9QxPmbHdOhtinaRS5mItxrPIhA1DLRkJPMuw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=bDcrDxgLBXqFd7oQ0wZU622SnF/gVCHQtBI0GrLMzkntsFVzv52Agrt4HYg93JO7A
	 ZRtgunV6IZDaK3zNaRtWQAfTHpld/8PkX2dKFnPtNP0fto38nrZzC3OBRp2yoyX4lt
	 pdxubsyu3DFOIEl6f6uUAYV+5pMxBJXxw1b9PCHnBREQtbZQjDysNanhWnNIT3v0W6
	 LBY0asiOPMnAaC3I5Bm5u2q7q1ZaBbA3QHBUiQGm47FzbfQrzdd8khWWPigXOoPxdW
	 kwNjXUqUVfGG+L0Wz+G9dz3/LSru4bFBxQBQjPEEdB4cTbPpoo5ZkXNPDVQAn3YdSH
	 LDkDpyrlXc0jQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B4FCDF4007F;
	Wed, 20 May 2026 11:13:11 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 20 May 2026 11:13:11 -0400
X-ME-Sender: <xms:h88NanPZoAh6fJjERdRUPNJd7ginhDUpVvORLEtlIC_A8ozAhyCpFQ>
    <xme:h88Nasy7bDtAU5vDFUlrjierZTX9I8ObWJN3rLJrTM7gqlgzW5xwL2g0JP9qabEKX
    t7dDK5dS8m65gV5RY5e9uQhs3cCsXLyvhlu7YbrM_qObXjl8lEY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeegleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepfeegpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehsvghnohiihhgrthhskhihsegthhhrohhmihhumhdrohhrghdprhgtphhtth
    hopegrughilhhgvghrrdhkvghrnhgvlhesughilhhgvghrrdgtrgdprhgtphhtthhopehs
    lhgrvhgrseguuhgsvgihkhhordgtohhmpdhrtghpthhtoheprhhonhhnihgvshgrhhhlsg
    gvrhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvghmsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegthhgroheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:h88NakEks2rfD9OalS8ngqxS5q8fCYyxdhjAoTCi9Vc61b5QWwMZQA>
    <xmx:h88NajoeLr4Pi6ussVLVJN2t71CEoSYKC8sec503wHX9CcpLAx8DVQ>
    <xmx:h88NakJwz4NpVTdqRErBae-kslldix6kZFVhiV6VR5i8YzddCZZ-cA>
    <xmx:h88Naja5ApYgknkBh5zV-M4CtPMIi2SvPkUorF9SPDyxLjrWu5ne_A>
    <xmx:h88Nag71tyG97Kc5muYomSB72JP-pdJnkr01SeEceG5QQqDJlzWdPW56>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 83D25780070; Wed, 20 May 2026 11:13:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AuvJ25pICu_N
Date: Wed, 20 May 2026 11:12:51 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Mark Brown" <broonie@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Sungjong Seo" <sj1557.seo@samsung.com>,
 "Yuezhang Mo" <yuezhang.mo@sony.com>,
 almaz.alexandrovich@paragon-software.com,
 "Viacheslav Dubeyko" <slava@dubeyko.com>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 frank.li@vivo.com, "Theodore Tso" <tytso@mit.edu>,
 adilger.kernel@dilger.ca, "Carlos Maiolino" <cem@kernel.org>,
 "Steve French" <sfrench@samba.org>, "Paulo Alcantara" <pc@manguebit.org>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Jaegeuk Kim" <jaegeuk@kernel.org>,
 "Chao Yu" <chao@kernel.org>, "Hans de Goede" <hansg@kernel.org>,
 senozhatsky@chromium.org, "Chuck Lever" <chuck.lever@oracle.com>,
 "Roland Mainz" <roland.mainz@nrubsig.org>
Message-Id: <8b750b3f-4d73-41f3-84fb-6e387fd24168@app.fastmail.com>
In-Reply-To: <a366645c-364d-4588-8a15-4cd446f64366@sirena.org.uk>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
 <20260507-case-sensitivity-v14-3-e62cc8200435@oracle.com>
 <dc69224d-9926-4414-8c6e-4c15ae98705b@sirena.org.uk>
 <04302551-3628-4036-9a3f-596cb782f5b7@app.fastmail.com>
 <a366645c-364d-4588-8a15-4cd446f64366@sirena.org.uk>
Subject: Re: [PATCH v14 03/15] fat: Implement fileattr_get for case sensitivity
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-21736-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D45D5591663
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Wed, May 20, 2026, at 10:54 AM, Mark Brown wrote:
> On Wed, May 20, 2026 at 10:39:16AM -0400, Chuck Lever wrote:
>> On Wed, May 20, 2026, at 10:31 AM, Mark Brown wrote:
>> > On Thu, May 07, 2026 at 04:52:56AM -0400, Chuck Lever wrote:
>
>> > I'm seeing a regression in -next with the LTP statx04 test which bisects
>> > to this commit:
>
>> > tst_tmpdir.c:316: TINFO: Using /tmp/LTP_sta8hUyB4 as tmpdir (tmpfs 
>> > filesystem)
>> > tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
>> > tst_test.c:2047: TINFO: LTP version: 20260130
>> > tst_test.c:2050: TINFO: Tested kernel: 7.1.0-rc4-next-20260520 #1 SMP 
>> > PREEMPT @1779279361 aarch64
>
>> > ...
>
>> > tst_test.c:1985: TINFO: === Testing on vfat ===
>> > tst_test.c:1290: TINFO: Formatting /dev/loop0 with vfat opts='' extra 
>> > opts=''
>> > tst_test.c:1302: TINFO: Mounting /dev/loop0 to 
>> > /tmp/LTP_sta8hUyB4/mntpoint fstyp=vfat flags=0
>> > statx04.c:121: TFAIL: STATX_ATTR_COMPRESSED not supported
>> > statx04.c:121: TFAIL: STATX_ATTR_APPEND not supported
>> > statx04.c:121: TFAIL: STATX_ATTR_IMMUTABLE not supported
>> > statx04.c:121: TFAIL: STATX_ATTR_NODUMP not supported
>
>> At first blush, that does not seem like a plausible bisect
>> result. This commit shouldn't affect the behavior of tmpfs
>> in any way.
>
> It's not testing tmpfs (well, it does but that passed), as the log above
> shows it is making a vfat filesystem on a loop device backed by a file
> that happens to be in a tmpfs and then testing that.  There's a bunch of
> filesystems covered in this manner:
>
> tst_test.c:1985: TINFO: === Testing on ext2 ===
> tst_test.c:1985: TINFO: === Testing on ext3 ===
> tst_test.c:1985: TINFO: === Testing on ext4 ===
> tst_test.c:1985: TINFO: === Testing on btrfs ===
> tst_test.c:1985: TINFO: === Testing on vfat ===
> tst_test.c:1985: TINFO: === Testing on tmpfs ===

OK. Is vfat the only failure in LTP statx04 ?

-- 
Chuck Lever

