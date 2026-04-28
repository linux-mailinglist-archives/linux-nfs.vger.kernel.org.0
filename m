Return-Path: <linux-nfs+bounces-21206-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDKTK1cO8GnTNgEAu9opvQ
	(envelope-from <linux-nfs+bounces-21206-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 03:33:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C92147C691
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 03:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7237530459F1
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 01:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28C62D5C8E;
	Tue, 28 Apr 2026 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOhfDvzD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCC62C0261;
	Tue, 28 Apr 2026 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777339946; cv=none; b=mXbaMEbJSXUOyX3ZIl0igT5+DXrIZ2/War7ajcoT6KzgBUY4GhpWzBkdwt692lOll1emEFzrE/mL9/0k3DgGTJXGKG9Eh2BDDwkspSX/lKIE5N64GX4miirElAWzTFAUB6ItC6HBovsdRhkgpughLCMwGYiu4TMhYqPYMcXjhT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777339946; c=relaxed/simple;
	bh=wHz+5U7YZ1YUh8S3O/ePJZetSOyRqZDheoo8PdaQubw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=N2jpiuN9jPABaedwxyU7PmstflMduKRDTmshwNjcUJ2ZPyjg5EPE2bz1k5nDcnlc3plx33Iymgo2Ly3/qibxjcknLJ52QVAzBtZlqTkk5XO7qClWlFl9VxHVHkPbk37mp9BgrQvv6qpZYYEhAD7gp125gSwqd/pxmhY+8RThD6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOhfDvzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F80C2BCB8;
	Tue, 28 Apr 2026 01:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777339946;
	bh=wHz+5U7YZ1YUh8S3O/ePJZetSOyRqZDheoo8PdaQubw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=TOhfDvzDaluU/j7Kds/kem7583xdqoHSELQ2x559IB9y0NQQNXIyzGBe6Fqbj/oYL
	 HDM4jXg3bM9cjeEpaA6UdmNgruCW0rC5TyBRUOno+ir17RijO8NOgZqdoGNXn7XgIT
	 EdF6NZGZUZgLwy74Fuq0NNuvvlu+7UwuiRf7BFCJxWEqwH0d15FUxo9qcUscCUFGNc
	 BxRVwKIgWZ0PBiiG0NR9CjyM58Mb8CgM5Pj5NpqM0ptb7OY+g2TosBdIJpj7xTYFjv
	 57pFveojlFHAesXaWck2CXVYspyIEIQiLPiM41p2XnkyOFZoB0mLHGNy9v7h0INder
	 MX09Rw2Na6AMQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0EEA6F4006D;
	Mon, 27 Apr 2026 21:32:24 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 27 Apr 2026 21:32:24 -0400
X-ME-Sender: <xms:Jw7waTdxAlNGjpqkcmYs-AuhVm8o6a2ys9cH7oPKakERIjM35CzggQ>
    <xme:Jw7waUByBHZtpz_cO4UMWr0VoT7wNaP3SOQWx1_VsC9VZI3f0qKIOJlPWIqNFK_qx
    eTGs3Us4qmDCHQRAYK3eICv5OzGaEwL7XdPlGXhSJQN84a8D--lFa4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdektddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    eptdduhfeuteeileehtdegledvhfdvieefveelleeludelfeetvdfhteetjeetffdvnecu
    ffhomhgrihhnpehsrghshhhikhhordguvghvnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    peefgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgvnhhoiihhrghtshhkhi
    estghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtoheprgguihhlghgvrhdrkhgvrhhnvghl
    seguihhlghgvrhdrtggrpdhrtghpthhtohepshhlrghvrgesughusggvhihkohdrtghomh
    dprhgtphhtthhopehrohhnnhhivghsrghhlhgsvghrghesghhmrghilhdrtghomhdprhgt
    phhtthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvmheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptghhrghosehkvghrnhgvlhdrohhrghdprhgtphhtthhopegujhifohhngh
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Jw7waQ4Xow-t11J593OXzv-Gwl0Byd6MFv6z4UpYTD9UNKvdBWnqag>
    <xmx:KA7waYbam4XDlg9sbJKf1HWcmAANgKgDVgaJ3EUUVdDrsHM_F7ioEA>
    <xmx:KA7waSoQNfBCkKag9VRPAnKAGom1WVXc4rDrBOYssIOmltGlTsaAYg>
    <xmx:KA7wafIyNoQwaeh8KjYI0_7YlZVPbx8Hm9QpSej1pjj1LmcPjLYiZA>
    <xmx:KA7wadZV4ms4hY1uafi9BlfHPsflm006PYfpHyB8gesdt20AVsIDU3u9>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D0C61780075; Mon, 27 Apr 2026 21:32:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 27 Apr 2026 21:32:03 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
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
Message-Id: <3fd6dcbf-ece6-459e-b114-1d8b95035acf@app.fastmail.com>
In-Reply-To: <20260427155636.GC7751@frogsfrogsfrogs>
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
 <20260424-case-sensitivity-v11-8-de5619beddaf@oracle.com>
 <20260427155636.GC7751@frogsfrogsfrogs>
Subject: Re: [PATCH v11 08/15] xfs: Report case sensitivity in fileattr_get
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5C92147C691
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-21206-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nrubsig.org:email,app.fastmail.com:mid,sashiko.dev:url];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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



On Mon, Apr 27, 2026, at 11:56 AM, Darrick J. Wong wrote:
> On Fri, Apr 24, 2026 at 09:53:10PM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> Upper layers such as NFSD need to query whether a filesystem
>> is case-sensitive. Add FS_XFLAG_CASEFOLD to xfs_ip2xflags()
>> when the filesystem is formatted with the ASCIICI feature
>> flag. This serves both FS_IOC_FSGETXATTR (via xfs_fill_fsxattr() in
>> xfs_fileattr_get()) and XFS_IOC_BULKSTAT (which populates bs_xflags
>> directly from xfs_ip2xflags()), so bulkstat consumers and per-inode
>> queries see a consistent view of the filesystem's case-folding
>> behavior.
>>=20
>> XFS always preserves case. XFS is case-sensitive by default, but
>> supports ASCII case-insensitive lookups when formatted with the
>> ASCIICI feature flag.
>>=20
>> Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---

> I don't understand this at all.  Yes, FS_XFLAG_CASEFOLD is readonly,
> but how does clearing FS_CASEFOLD_FL from the fileattr_get output
> (without clearing XFLAG_CASEFOLD!) solve anything?  This makes the
> reported output inconsistent between fsgetxattr and getflags -- one
> reports case folding, the other reports no casefolding.

The masking is a misplaced reaction to a sashiko review on the
v9 predecessor of this patch [1], which pointed out that v9 set
FS_XFLAG_CASEFOLD in fa->fsx_xflags after xfs_fill_fsxattr() had
already synced fa->flags, leaving the two views inconsistent in
the other direction, and that bulkstat would miss the flag for
the same reason. Moving the injection into xfs_ip2xflags() fixed
both gaps -- but it also surfaced FS_CASEFOLD_FL on the legacy
view, so chattr's RMW through FS_IOC_SETFLAGS hits the EOPNOTSUPP
gate at the top of xfs_fileattr_set(). Hiding it from getflags
was the wrong place to address that.

> If you want to avoid fileattr_set returning EINVAL when setting
> attributes due to the casefold flag, then don't you want to check
> the flag state vs. xfs_has_asciici() in the *fileattr_set* path?

Yep. For v12 I=E2=80=99ll drop the fa->flags mask and add FS_CASEFOLD_FL
to the allowlist in xfs_fileattr_set(), gated on xfs_has_asciici(mp).
xfs_flags2diflags() already has no clause for CASEFOLD, so the
FSSETXATTR path silently no-ops it the same way it does for
FS_XFLAG_HASATTR, and FS_XFLAG_CASEFOLD is in FS_XFLAG_RDONLY_MASK
so FSSETXATTR strips it centrally. Both views then agree, and a
chattr round-trip is accepted as a no-op.

The hfsplus patch in this series carries the same pattern --
FS_XFLAG_CASEFOLD is set after fileattr_fill_flags() so that
FS_CASEFOLD_FL stays out of fa->flags and dodges the EOPNOTSUPP
gate in hfsplus_fileattr_set(). I will fix it the same way.

Thanks for the catch!

[1] https://sashiko.dev/#/patchset/20260422-case-sensitivity-v9-0-be023c=
c070e2@oracle.com?part=3D9


--=20
Chuck Lever

