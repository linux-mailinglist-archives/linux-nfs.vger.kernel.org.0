Return-Path: <linux-nfs+bounces-20114-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NfmAthAs2l6TgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20114-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:40:24 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1237E27B011
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52B5D303ABF2
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113EF374162;
	Thu, 12 Mar 2026 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Zg58F/SG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WrAckuAK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14B42F3C26;
	Thu, 12 Mar 2026 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773355183; cv=none; b=Jsf6svfHDdJQCtPMcuvFMDnQK7Atc+ps9KbUHQhc4oz/u14rUehc+gfqAP0AlI4fp6dnv8txZz1E4g6Zk7oGT9rtwl3yqd65IiOShAsdztVYNN35su8e8aayYNs9giPVZrOx3jQ4Gjw2PGIS1NGL2g3oPyas6Yr9HTKER9sNQB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773355183; c=relaxed/simple;
	bh=TrSIwL97TYjCsfniuvWwlpXozZqpTBen/RyGtj6qNGI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=pIwJkM0RK7I3NYVKoktQTVswiFXha12F9D4O8ck2t5w6Soen5Cuh+1FQoi7m9SDYgXwAva9Rfq+OvuuGEiYubDvWc2AernEHMzI+vz+v4LuLuCJHQyD+q6215p+WuMSJq8kUuwly9sJjVmtPW9gtv6puw3gv12RPNQARCReNio4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Zg58F/SG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WrAckuAK; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C439B7A00DC;
	Thu, 12 Mar 2026 18:39:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 18:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1773355181; x=1773441581; bh=I2HYPiTpoKa15Sjzz4VE4VCGc6yGT1w0F7V
	AuMJaieQ=; b=Zg58F/SG4cEEkupxG9ZGyGrZZbAXgqmbaA/FjbjaRm5BhwJL85u
	Gp9jMT6nHQwB3M5xkk4EP5nS9qzA9EQN8bTk4x0PcS+9X99Unl9P+or1e5Lp2hNh
	J7VHJTzMxpF7WnMR2EwCVd7s6+aGiOg78a3K1gCK1Y/TD/474wdhvHXQsEWAuo69
	/UJK8/Z6Dn9mfd9+1f0HBFIYqBO9FMN6g9rh8rnQDlyGy1Ca3NPxcNQM4wmamptO
	BVnIGN+tyZASYfPQosBD3rshfntDx/ULxpg4Ds6nm/+PnKSruQAPvlakDGF2Ahpk
	Dhtb5eZvnBxxFpu3VejgyWkcgefV88C4pEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773355181; x=
	1773441581; bh=I2HYPiTpoKa15Sjzz4VE4VCGc6yGT1w0F7VAuMJaieQ=; b=W
	rAckuAK8770Z3UhHmRJ9ux+tYQYJDzUHQO9TWTsjPaZXoDDMLvvd1gfmQa3zCMYs
	1BW43YLoSIovg8t8kM97n1CUL5wMV5jkaFXK34n+iamzwp3ArxcyPHKcG6Qzc/C6
	L927NDNdo4IbLmqaCIZbM48aZSmkjX723r+dSMJfZ70LTcAO+LuoyLBu0WuzQP6o
	XXSozHrEiieVK/TOpKXJ51pqKHaIi4AyHmG5w3qJaFMg7fhaHW8ae2cA5CgVDMTC
	WIK63EK/PtVzqV3suqo0cbHNVoGUI/8R34j/+cBSB+nnZuOpRDROvKeE5cudE0SS
	l+DUAMWicGxQ+UDf7uAmQ==
X-ME-Sender: <xms:rUCzaQMwoNOGmCKTpbSVurvmnFjeisK77hCcNEyN1xzQC3sLuUXKdw>
    <xme:rUCzaS8h08PRiVcfYWFHYKN8lweBxloY-PAAGDLiiw60-BvM42zwhNgj3NacmohIX
    qWMjOi1q9eBr6v96rnnOWsbDk2GjbjWsoCdsUYlzCjT3VW92g>
X-ME-Received: <xmr:rUCzaZerzOxDZLRGwnd_WGpV-Q7qF7xZ__waUuHucpIidlVBChPwLCRhvFjKncoI_EN4PCTm2jyU7LuFOepgtu2jjiIDbKqnzzgvoTM0Cujz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeektddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhjrdhirg
    hmrdhtjhesphhrohhtohhnrdhmvgdprhgtphhtthhopegthhhutghkrdhlvghvvghrseho
    rhgrtghlvgdrtghomhdprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlvggvmhhhuh
    hishdrihhnfhhopdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepudduvdekkeeiudessghughhsrdguvggsihgrnhdrohhrgh
X-ME-Proxy: <xmx:rUCzaZyZNgnYCGd9HOH9RwusgXbqIUsM676iFwMWqLPy6M6FM4HYmA>
    <xmx:rUCzaWJkL2UG5EKfDNWRtLEZjpgN2uG2V04i5uBb7qCu0cTyev4qog>
    <xmx:rUCzaTF_Qj3vNs54_A8djcEaMYYu6KnynkpX8mHNuKlwrU-ykFoTTw>
    <xmx:rUCzaa9dQhRis9D_w9bsB4mq-xKNY3Kt5RrYn5xXvd0likLyuBZeXw>
    <xmx:rUCzaW2_W14jtmfrliFgW71omBzy-KpH9C_omS_yT-CSSqC-IQiqweJq>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 18:39:38 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Thorsten Leemhuis" <regressions@leemhuis.info>,
 "Tj" <tj.iam.tj@proton.me>, 1128861@bugs.debian.org,
 linux-nfs@vger.kernel.org, "Olga Kornievskaia" <okorniev@redhat.com>,
 stable@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: Regression: Missing check in nfsd_permission() causes -ENOLCK No
 locks available
In-reply-to: <5a302dcfcb54a87366dd6a9bc5ec27df179f7f58.camel@kernel.org>
References: <c0f15088-3fc0-487a-9f24-cf89c158420d@proton.me>,
 <418f30b5-06ae-471f-bf5f-f14f3f75deff@leemhuis.info>,
 <5a302dcfcb54a87366dd6a9bc5ec27df179f7f58.camel@kernel.org>
Date: Fri, 13 Mar 2026 09:39:36 +1100
Message-id: <177335517622.5556.4792770517095870331@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20114-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,brown.name:replyto,noble.neil.brown.name:mid,ownmail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 1237E27B011
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026, Jeff Layton wrote:
> On Fri, 2026-02-27 at 10:54 +0100, Thorsten Leemhuis wrote:
> > > This was discovered on the Debian openQA infrastructure server when=20
> > > upgrading kernel from v6.12.48 to later v6.12.y where worker hosts (wit=
h=20
> > > any earlier or later kernel version) pass NFSv3 mounted ISO images to=20
> > > qemu-system-x86_64 and it reports:
> > >=20
> > > !!! : qemu-system-x86_64: -device=20
> > > scsi-cd,id=3Dcd0-device,drive=3Dcd0-overlay0,serial=3Dcd0: Failed to ge=
t=20
> > > "consistent read" lock: No locks available
> > > QEMU: Is another process using the image=20
> > > [/var/lib/openqa/pool/2/20260223-1-debian-testing-amd64-netinst.iso]?
> > >=20
>=20
> I have to wonder if this is a QEMU bug too:
>=20
> Why is it opening a file read-only and then taking out an exclusive
> lock on it? What's the point of denying access to other readers?

It turns out that I mis-diagnosed the problem.  i.e. I guess wrong as to
what weird thing qemu is doing.

qemu isn't using flock().  It is using fcntl() locking but at this point
isn't trying to GET a lock, it is testing if a lock already exists.
i.e. F_GETLK or F_OFD_GETLK.

F_GETLK doesn't require WRITE access, even when getting an exclusive
lock.
But NFSD does :-)

So maybe this is the fix that we want.

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 255a847ca0b6..67234686ef8c 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -632,7 +632,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *=
file,
 		goto out;
 	}
=20
-	mode =3D lock_to_openmode(&lock->fl);
+	mode =3D O_RDONLY;
 	locks_init_lock(&conflock->fl);
 	/* vfs_test_lock only uses start, end, and owner, but tests flc_file */
 	conflock->fl.c.flc_file =3D lock->fl.c.flc_file;



????
NeilBrown

