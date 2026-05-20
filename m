Return-Path: <linux-nfs+bounces-21741-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ9FIc/4DWqq5AUAu9opvQ
	(envelope-from <linux-nfs+bounces-21741-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 20:09:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D139595693
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 20:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6506E3229AD2
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 17:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA603B0AD6;
	Wed, 20 May 2026 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H94sNRNE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564862628D;
	Wed, 20 May 2026 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298229; cv=none; b=JKceByRAs8oHcLCfRAqefQizQFooaLwrH0Ds13KWsbXWLTtOk7/Crwgexj7ZVr7ZS3+rw42k4WsE6DoF3p3kXDKuRRhXNZLCrjsJ+llnA1vV5A5hmPeqRVVqyTAiyMcHJ6c/CL7evxnyY2bTKJaEa/eclXmg7Pxh/aFAzlQGK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298229; c=relaxed/simple;
	bh=mCIcBkL05sOWje+R2Q/7F5pBBRDFsBUbOc6ODx3yPT0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NAwkwK7GyXTwFB3umtJJxKDTKUC6NiDMic6Z9Rutwou8svozsmF5hTKd/a28g547bilGOv73RPo+U66n4yo3wVCPZl609u7o+2gvVi4UwgwBG/zrsp16YoQYPUlWdOMJ3BveNBVGxZ6FnaDLA0UmFDRzdgkE5lO6iSBhY/fQ4Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H94sNRNE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433621F00898;
	Wed, 20 May 2026 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779298228;
	bh=hp/LsSdQ0ID+IBacKCrtn1LiJIpuZ/a/08Y8EBXFu0E=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=H94sNRNEqRKSUACk8LYK84RxEbL6+b/Vw+285XGry0XSmBqa5aB3J5f6LSMMrm+IP
	 58PpB/I1hKpUJgIbjr9vv7xJKdQD6SfZ+05NrAWeoxrrpiru/cRXtAkDA+Asivbbrt
	 CJiUjbLwYn0xpzQHMPAQRBk9Cq4jrZymBPkcNm2gAxFE6PY/6uiD+mYwVOLlnwSHgy
	 LuPTMQPxf3gp4RhFtO1OdVDrEqQPyP642G9u3yLXTxC1Fx7F4nF6XXYB1fdQDI/R0c
	 o70WFXZyDIrzI2cy6AhKtUujqzkLD3wVVcSnEyqvm6g+YsNP6gLyxWUc+UUiYdF9tJ
	 q2oR3Fhk9+bMA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6B958F40075;
	Wed, 20 May 2026 13:30:26 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 20 May 2026 13:30:26 -0400
X-ME-Sender: <xms:su8NavFR3K0V9EcvFJfXc3Wsci7E6tZzPh7akBvB6u99zTx8rze7Gw>
    <xme:su8NanI9KFxJAd23rFo4BZcQSSRqZ4IOxvvOi8Hq6e2addjaUtdGgzeW0Snx6bfFV
    F6HZJz8k0LU_FpzJrJko6dN1pLJljMzh_b5Ll8sc0YwUhoSP8OzpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehvdefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:su8Nas-hLOkDseW56q88vVoEsCdEJofZpbwE6rWAXeInKKpHr_MW5Q>
    <xmx:su8NarAnnqHmefxc4iTmrF4_T-hy_-xQ19oXQWlTGvvmgtwo5lPF1Q>
    <xmx:su8NaoB7yw-Fw6OLeA4_bYVbPfkMLH9YKuPnbxL7dMEJvDRxnu_9gg>
    <xmx:su8Napw2lcPRdf9cLIVzimsPOiNvDq1t578i-dfKLown4ig7XNkDfw>
    <xmx:su8Nanz9yDOkUucI8YkgQgyBNftzdGRtrCi-D4JRFcnETfqVOinIWWHT>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 39DFF780076; Wed, 20 May 2026 13:30:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AuvJ25pICu_N
Date: Wed, 20 May 2026 13:30:06 -0400
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
Message-Id: <d2425b45-a37a-4cc9-8984-bed55ee54a32@app.fastmail.com>
In-Reply-To: <cdeaab82-06bf-47c1-8f6c-4e40dbec2344@sirena.org.uk>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
 <20260507-case-sensitivity-v14-3-e62cc8200435@oracle.com>
 <dc69224d-9926-4414-8c6e-4c15ae98705b@sirena.org.uk>
 <04302551-3628-4036-9a3f-596cb782f5b7@app.fastmail.com>
 <a366645c-364d-4588-8a15-4cd446f64366@sirena.org.uk>
 <8b750b3f-4d73-41f3-84fb-6e387fd24168@app.fastmail.com>
 <3a347b64-f91b-450f-b27d-26ea6810b960@sirena.org.uk>
 <858d7233-1d9c-48f4-aa4f-c5a9f6e1f5dc@app.fastmail.com>
 <cdeaab82-06bf-47c1-8f6c-4e40dbec2344@sirena.org.uk>
Subject: Re: [PATCH v14 03/15] fat: Implement fileattr_get for case sensitivity
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-21741-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: 8D139595693
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, May 20, 2026, at 1:11 PM, Mark Brown wrote:
> On Wed, May 20, 2026 at 12:58:22PM -0400, Chuck Lever wrote:
>> The first option is the narrowest kernel-side change, and
>> matches what other minimal-fileattr filesystems do.
>
> That sounds like a good idea regardless of what we do with the test?

Yes, I have no objection to this approach, but it would be great to
hear from the vfat maintainers/contributors on this one before I
dig in.


-- 
Chuck Lever

