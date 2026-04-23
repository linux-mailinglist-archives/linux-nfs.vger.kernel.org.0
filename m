Return-Path: <linux-nfs+bounces-21018-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGTBN4936WkBagIAu9opvQ
	(envelope-from <linux-nfs+bounces-21018-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 03:36:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C7B44C215
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 03:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8BE530067AF
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E353A4F27;
	Thu, 23 Apr 2026 01:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLB/V9Vx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA4E1D9A54;
	Thu, 23 Apr 2026 01:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776908170; cv=none; b=kH8qpT1Q7Gkv75g+oQFDnEoFUyJBjjEblGmmg1qPMgEzQtOXf2DLyxpKN6Oq5uiNCRtYsqwyYIinOO+v7qvnbcixJs0bKvumnDuGFHCSVtVcbkp1DxmYAoMP2bjZatVCmZ/soFXZrHy4ivqgRt8f2SVZJBn6f33D/onva9+IIdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776908170; c=relaxed/simple;
	bh=fisfLRUPF2gQeK8/tjab1CMLN7z38y0h7QBe3fR1FGk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IslLa3IA2x4kekBBeAd5TWe1lf8V6phrT3vdCfJ64ocvRO+/H1xgyBNtU+RUMDJFln7KHrdZ4lJAKrEFMbZix6S+ItmCOpKQ5pf79oAdR5is9ruKtLSPjovRFj/QigbPJQAdmC9w2XdYup7wENRZgXJUJyfNfPVwxvSZekpF2DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLB/V9Vx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0EEC2BCB4;
	Thu, 23 Apr 2026 01:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776908170;
	bh=fisfLRUPF2gQeK8/tjab1CMLN7z38y0h7QBe3fR1FGk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=uLB/V9Vxth7g4vShFYvcL/mCTim0wfkAAkzRXOhJ3wDvANYCoRIde/8hvh+dG2QJF
	 /jGC5YH+IR1TrhTJMzoW/ahCEIQqaIvTvOPOVyLT70ckze0ciCzKkRw9Ey6At5urbo
	 OAy3FEXO7SjoCK+NI2hD22Uy6THb29cgHttSndmUTWS8jiMA17j06gmzCo/Nl+ikAq
	 5rmJQKSDoXL0ZQ2hE/NnPbmXVr13Fg0WP7qJx/b11Odz6Jt4+TmF0qBMY7YVJk9X+w
	 gqJHVlktyUP9gP84U0fdhV8hz9D1VlQczWS/xG/9G35iAySWuSucdKbee96dDB+uzs
	 /XI/Yu8+CoQTw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5F59AF4006A;
	Wed, 22 Apr 2026 21:36:08 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 22 Apr 2026 21:36:08 -0400
X-ME-Sender: <xms:iHfpaeo4VthmNtZ5zqVLjiXC2cn8tWHGEMdzLK0PkfHerQzKuwGL8w>
    <xme:iHfpaXdLH9MSdgJtkPwHUqYJVv1n_uNz8FaJj5-5PuPzSv6NNKdKbBoPzaTwYk9Lb
    c1xxpWMr8HwIBjxxcs-GZB4qopZ4Kv9XLZdh_pdji3Ur2a-_bOMJJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiheekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epgffhgeeutdeiieevuefgvedtjeefudekvefggefguefgtefgledtteeuleelleetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeeffedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepshgvnhhoiihhrghtshhkhiestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtoh
    eprgguihhlghgvrhdrkhgvrhhnvghlseguihhlghgvrhdrtggrpdhrtghpthhtohepshhl
    rghvrgesughusggvhihkohdrtghomhdprhgtphhtthhopehrohhnnhhivghsrghhlhgsvg
    hrghesghhmrghilhdrtghomhdprhgtphhtthhopehsmhhfrhgvnhgthhesghhmrghilhdr
    tghomhdprhgtphhtthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsg
    hrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvmheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptghhrghosehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iHfpaR735JLTmlXf6PZaw09JvM2INK1_wFF6Sofysyc5cHAzrptIUA>
    <xmx:iHfpaR3Ct_L9JXA3_3D08tOGJwAeJitT7nP5_Yj2u3ZipmZ8_WhTyA>
    <xmx:iHfpacp_YaFAr7nSWwX0ZxI4Obx-0-j3X9gZ32hL5RJuIURnLf2EVg>
    <xmx:iHfpaXVoO2mIU-wKylIYQImIQNtl2kj4f7yCmO3vyFuPWUpTFhRI7w>
    <xmx:iHfpaRcA71LEAscdJdF6cGc-t3Q_4jPF-jb1PwNWd4SjcOeP35Uy-bpw>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2894B780070; Wed, 22 Apr 2026 21:36:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Apr 2026 21:35:47 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Steve French" <smfrench@gmail.com>
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
 senozhatsky@chromium.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <c41111fd-2473-4fdd-8e1e-285b9e24e631@app.fastmail.com>
In-Reply-To: 
 <CAH2r5muvUVY8FD6ZM+ARecM8evjejB15n0Ea9Z=GGn=i5aKFNA@mail.gmail.com>
References: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
 <20260422-case-sensitivity-v9-10-be023cc070e2@oracle.com>
 <CAH2r5muvUVY8FD6ZM+ARecM8evjejB15n0Ea9Z=GGn=i5aKFNA@mail.gmail.com>
Subject: Re: [PATCH v9 10/17] cifs: Implement fileattr_get for case sensitivity
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21018-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,app.fastmail.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 79C7B44C215
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, Apr 22, 2026, at 8:59 PM, Steve French wrote:
> Acked-by: Steve French <stfrench@microsoft.com>
>
> Do you know which xfstests this would enable?  IIRC a few of them
> depend on the fs supporting fileattr_get

Thanks for the Ack.

I checked the current xfstests tree and couldn=E2=80=99t find a test tha=
t flips
from notrun to run on cifs just from adding ->fileattr_get. generic/556
is the existing case-folding test, but _has_casefold_kernel_support in
common/casefold hard-codes ext4/f2fs/tmpfs. Enabling it on cifs would
need a new mechanism in common/casefold plus a mount-option-driven
variant (the cifs reporting keys off nocase, not a per-inode flag), so
that's a separate piece of work.

The practical effect on the existing suite is that fsstress's getattr_f
now returns success instead of ENOTTY on cifs, which quiets some noise
but doesn't gate any test. To actually exercise the new FS_XFLAG_CASEFOLD
reporting I think a new test (or a generalization of generic/556) would
have to be written.


--=20
Chuck Lever

