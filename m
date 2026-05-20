Return-Path: <linux-nfs+bounces-21733-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMgBBVDIDWr93AUAu9opvQ
	(envelope-from <linux-nfs+bounces-21733-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 16:42:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8C558FDCC
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 16:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D762F30673A6
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 14:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4877C3EC2CE;
	Wed, 20 May 2026 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gc8IQnkI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F240A3E9F9E;
	Wed, 20 May 2026 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287980; cv=none; b=fz8MywjZQQLgYfSlErKuvW3n3tQWbhAWJHZ7KNOF6cMoPgeuvrBJdb6822eaRD7em+Z2M0yHkCgWafYhXvo0FFjtD/V2QDp2HWuJU1wn/Vv2XYXwoSF1T0kQc4AGMEnEz/1MhgCH3MbiHt3pLM21lnehfL6G9PMC/xC442iKCyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287980; c=relaxed/simple;
	bh=wJ+5+3TKbLajCUI+TUOXrFo15fu3lCiVEg9BDCTRpwk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CSpvpfWRZwB1V4A9p9SUFTcD1kyN7JVCj+zJAAxgM9jPJ33cExAD79dLD91BWoy/nViZbDu3b5bF4NP7pDoBXiZKpQ0u80/e/G12+42GAdBaZQ08eqyfvxB4nFQMDOgeVIU1Te6TlW82sy3bjS2DcHTTa12xDPQDQbJ1cmyX9As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gc8IQnkI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD8E1F00893;
	Wed, 20 May 2026 14:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779287978;
	bh=TXjZnzwaYeGtjoLVSOSADuZFQffREJdAvzXtNbRNtCU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Gc8IQnkIS0QsfNN8I9QQV4668E6Yrcn7A5c0Ze7xv7pWSKCNJ7O/IIrQCyv8mKTXs
	 7cL78768ubta20tn5iF0dBEGOM/97c62B1P+mvx12S6hk3jqITMPgZ7YwlXneCzEag
	 joE6MRB/8l9oesaj8O510flNfc+v7DLefHxbXeAiAkC6rR2guegYNTTT0fuUGBGVmY
	 8QOV2CDWMmHYzbHUUs1TGraZEPoIjFtW17+md10KdsWnxy0XVCbMQafVPQ8dcJDhTh
	 1zq/XkwpPOGAZB1evIjhyZcLmDqiY3/3RKIy6Bjr/eoQYn4JuqwP0bDX+NyC369/jU
	 /Z2II/rVHDkJA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2B1DBF40073;
	Wed, 20 May 2026 10:39:37 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 20 May 2026 10:39:37 -0400
X-ME-Sender: <xms:qccNakvcQXgZIcvMtKY7LNrR6_H9xD4YEmkakspRNQYlkVuzv5oKOw>
    <xme:qccNasQBqVoKWRbR9fA_LUWqNI3XdP5nIVgjYbGTPr8Lb5F14ETHZCT5ze-98Vk4E
    vAyEWB9DCk9pd2guEjOMDSBh42Us4w30zs2fFon0fbFWqMhcA2e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeegkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
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
X-ME-Proxy: <xmx:qccNallEHzPaD0ty8qD3Fpe5euKj7nYbRGpbvvks6WvsmcFayjWKhw>
    <xmx:qccNanJYLZ_Wpp4l8AtXdwRbGPZjKgUeTJ0JS2th62x1FS8WHuiBog>
    <xmx:qccNahqKadoieDjV1hC8AMi0a6AxsKrt9rvdoN8H2LvhFFJwnwXZhA>
    <xmx:qccNai7K9wsk-JNFffu3VlpYtN6KGHY29e_BoHVRjVI9DCsKS1R5eQ>
    <xmx:qccNaqb-7jwLcmPxlYPRZx4BqVON_3fE1Nwmo4g6A10z63svVDwqz--L>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F0751780075; Wed, 20 May 2026 10:39:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AuvJ25pICu_N
Date: Wed, 20 May 2026 10:39:16 -0400
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
Message-Id: <04302551-3628-4036-9a3f-596cb782f5b7@app.fastmail.com>
In-Reply-To: <dc69224d-9926-4414-8c6e-4c15ae98705b@sirena.org.uk>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
 <20260507-case-sensitivity-v14-3-e62cc8200435@oracle.com>
 <dc69224d-9926-4414-8c6e-4c15ae98705b@sirena.org.uk>
Subject: Re: [PATCH v14 03/15] fat: Implement fileattr_get for case sensitivity
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-21733-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oracle.com:email];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: DE8C558FDCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Wed, May 20, 2026, at 10:31 AM, Mark Brown wrote:
> On Thu, May 07, 2026 at 04:52:56AM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> 
>> Report FAT's case sensitivity behavior via the FS_XFLAG_CASEFOLD
>> and FS_XFLAG_CASENONPRESERVING flags. FAT filesystems are
>> case-insensitive by default.
>> 
>> MSDOS supports a 'nocase' mount option that enables case-sensitive
>> behavior; check this option when reporting case sensitivity.
>> 
>> VFAT long filename entries preserve case; without VFAT, only
>> uppercased 8.3 short names are stored. MSDOS with 'nocase' also
>> preserves case since the name-formatting code skips upcasing when
>> 'nocase' is set. Check both options when reporting case preservation.
>
> I'm seeing a regression in -next with the LTP statx04 test which bisects
> to this commit:
>
> tst_tmpdir.c:316: TINFO: Using /tmp/LTP_sta8hUyB4 as tmpdir (tmpfs 
> filesystem)
> tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
> tst_test.c:2047: TINFO: LTP version: 20260130
> tst_test.c:2050: TINFO: Tested kernel: 7.1.0-rc4-next-20260520 #1 SMP 
> PREEMPT @1779279361 aarch64
>
> ...
>
> tst_test.c:1985: TINFO: === Testing on vfat ===
> tst_test.c:1290: TINFO: Formatting /dev/loop0 with vfat opts='' extra 
> opts=''
> tst_test.c:1302: TINFO: Mounting /dev/loop0 to 
> /tmp/LTP_sta8hUyB4/mntpoint fstyp=vfat flags=0
> statx04.c:121: TFAIL: STATX_ATTR_COMPRESSED not supported
> statx04.c:121: TFAIL: STATX_ATTR_APPEND not supported
> statx04.c:121: TFAIL: STATX_ATTR_IMMUTABLE not supported
> statx04.c:121: TFAIL: STATX_ATTR_NODUMP not supported

At first blush, that does not seem like a plausible bisect
result. This commit shouldn't affect the behavior of tmpfs
in any way.


-- 
Chuck Lever

