Return-Path: <linux-nfs+bounces-15543-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 460D0BFE56C
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 23:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F29F74F183B
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 21:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9164F2FF173;
	Wed, 22 Oct 2025 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="SkalMdX5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J+qmplzV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BC2301486
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761169491; cv=none; b=ie3F+1jhAYhmk2wpAaJBOtc8uDRM3JKfip7TIxiCJTx9F9Vy/UWTsJr4h5teXuHbRgUJnEgRJuPu17minHdFXQjHzJRNWbOb8PkR6d+vvtIiQGz+sODa+kN32+CRy3WgxViN1by+vW6VdXZiBj+elThggMpeHtFumKtGJtK4Pro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761169491; c=relaxed/simple;
	bh=/pX3m77Zv7Bxc8xWPo8NoG8i9zRtloBDOaHQqPvDNu8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=VJAqpcJP8OofhNBbyydxhlx2Rfo4fn9982tsNhoy9aRifaSdm5ih+EVb+Tlm3ZWQkhNBxEpMtlFViiHlsBXGYpHicRtWesSpi5Z8tYamOWq4zeRrftSHRfajWbSA9dAC9mhZdY3zM7rUWgFPP2rD2DZbn1ZTqiWydKutaG8KpfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=SkalMdX5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J+qmplzV; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 494D214000C9;
	Wed, 22 Oct 2025 17:44:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 22 Oct 2025 17:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1761169486; x=1761255886; bh=P4yolquHEH7zXJH7n7MIcdEz/1FV7fv0lnf
	DT23e1RM=; b=SkalMdX583CAxvbT9gFFcz3gTdjPseRGKR0aXcQSaej6V8w74ge
	9kChHfksUrx9iJz7tE3QKGm/PRQp0Y5Y/c0chr4a9d1c/04pt+0kND5Lvkl1FypJ
	XI4jUahgkJOU6II+06e4M0Ydkh82hflYYmBlW5U8az/QnlDfYinge4Q69lPNlFBr
	zzG4TDWgprqMTRg3H8R096bkN0GoMVrap0/IX+5OjTJPR/8LAvCPQMkVvPFGbsQr
	Rx0bkfMD9n65K2ftsj/njoB4fn/gGd3p/s8y4K0nd1KnTSBXHdrwH2l0BImerm3y
	aTnRMm/xXYcXLksK4srnBk2jdhuuYakpxzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761169486; x=
	1761255886; bh=P4yolquHEH7zXJH7n7MIcdEz/1FV7fv0lnfDT23e1RM=; b=J
	+qmplzVW18BWuZnvhfN7A4JEwDo+iyDwDymtvgHmto8g63So+PVD/sMlgT4eeoG+
	tVxZL6Xu12GKfVt3PvPFHbR2areoygovAc5RcaDM1AZVsdfcqgwiFloiwQQVssEi
	XIU467CF356I0gnDyDDx1iOk5O89oFdB3oMDVAcjrum+7em5p44fPiBKVful3L82
	i6RVy72wzPhcp1WDZEKqcAM7mjh6Thvvxx9AGp9m5LCZcMQWw6CL5an7m5QxXkDy
	uV1NlZSoRKnQXTuQB41a8YfS9Wxb1AV+pZvrgyz4ExQyFhsQQ/Ad0RaeRMCuTYNe
	eJriTzMA/VCWBz5J5ibjQ==
X-ME-Sender: <xms:TVD5aP0TWHsAAuPnjkvIB6QAawy-h5owQyoqp6s7F4Ktvj7aTn9x4g>
    <xme:TVD5aNLLGgiCm5kcVCw0fx8CYOSv6A8mHws8FAsjg12hJDzi_ZFb9eyfJKGl0iG6q
    UwRuhcC7ergmnLsUphNfbKBNrCLNKCeL6bPvyvlXiFi6CKYUA>
X-ME-Received: <xmr:TVD5aGEyrBus8hDwqbwhgrdEblHBIo3l6-hcxZhuB0KMc6Qk_7A5tEee9fHBx-Irtej5wagHpF5HjGgUbMvrUXV84fgRu4BCcMb5hLd2s9Uf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegrghhlohesuhhmihgthhdrvgguuhdprhgtphhtthhopehtohhmseht
    rghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghp
    thhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhhlrgihth
    honheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvihhlsgessghrohifnhdrnhgr
    mhgv
X-ME-Proxy: <xmx:TVD5aBW36YGccuYfvPwjxUoYxHG9M31Vq-PTmB4Keqa5bPoQKFjkTg>
    <xmx:TVD5aGxgmnCZlaqgCQrI9MBEG1w0dPilsCRez-ZddJ4FsBJVUxYZ-w>
    <xmx:TVD5aOQTpBDjXR1e8eVxkf0OIEbA9kqJ83jCLNc1iVEBnPL3eV1MxQ>
    <xmx:TVD5aKigrhAiRxQbajp7Y4dOYTeqIjKE3q0g8PTPlzzgOO8Y-9dd6g>
    <xmx:TlD5aMHizTtlzWf5s8K0NqoogPh9WUDEx7TeF6t9NzgZY6vHm5TXd3yz>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 17:44:43 -0400 (EDT)
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
Cc: "Olga Kornievskaia" <aglo@umich.edu>,
 "Olga Kornievskaia" <okorniev@redhat.com>, chuck.lever@oracle.com,
 linux-nfs@vger.kernel.org, neilb@brown.name, Dai.Ngo@oracle.com,
 tom@talpey.com
Subject:
 Re: [RFC PATCH 1/1] lockd: prevent UAF in nlm4svc_proc_test in reexport NLM
In-reply-to: <f5073caf3e3db05702ed196042053fc864645750.camel@kernel.org>
References: <20251021130506.45065-1-okorniev@redhat.com>,
 <33ba39d2ff01eb0e52c80aa7015d27e34dde7fd2.camel@kernel.org>,
 <CAN-5tyEuV2UO17w97b8weJUQR7hgqX=jz-kvGR9Sr_m3NZp8ww@mail.gmail.com>,
 <d0a1a1ccec73ee56e614b91c4a75941f557398b8.camel@kernel.org>,
 <CAN-5tyGK4MHgYaN1SqpygtvWM8BFrapT-rXY_y9msVfnRjN1Jw@mail.gmail.com>,
 <ff353db93ca47b8fae530695ea44c0a34cd40af8.camel@kernel.org>,
 <fe1489b3c55bdb32cd7ad460a2403bc23abdde81.camel@kernel.org>,
 <f61025a96df19c64ba372cdcab8b12f3fa2fff9e.camel@kernel.org>,
 <CAN-5tyFWvP2ZTeYFN6ybGoxvsAw=TKFJAo0dVLU_=s_5t=LCGg@mail.gmail.com>,
 <f5073caf3e3db05702ed196042053fc864645750.camel@kernel.org>
Date: Thu, 23 Oct 2025 08:44:38 +1100
Message-id: <176116947850.1793333.1787478761707441526@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 23 Oct 2025, Jeff Layton wrote:
>=20
> Longer term, I think Neil is right and we probably need to fix
> vfs_test_lock and the lock inode_operation to take a separate conflock
> for testlock purposes. That's a bigger change though (particularly the
> ->lock operations).

Thanks.  But in the shorter term I'd like to suggest this.
I haven't tested, but I think it should fix the lockd issue and make the
code cleaner too.
Sorry - I haven't written a commit description yet :-(
As nlmsvc_testlock() is being passed a conflock, use that directly to
hold the found lock, and initialise it from 'lock' before, rather than
copying results the from lock after.

NeilBrown

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 109e5caae8c7..4b6f18d97734 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -97,7 +97,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res =
*resp)
 	struct nlm_args *argp =3D rqstp->rq_argp;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
-	struct nlm_lockowner *test_owner;
 	__be32 rc =3D rpc_success;
=20
 	dprintk("lockd: TEST4        called\n");
@@ -107,7 +106,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_re=
s *resp)
 	if ((resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
 		return resp->status =3D=3D nlm_drop_reply ? rpc_drop_reply :rpc_success;
=20
-	test_owner =3D argp->lock.fl.c.flc_owner;
 	/* Now check for conflicting locks */
 	resp->status =3D nlmsvc_testlock(rqstp, file, host, &argp->lock,
 				       &resp->lock);
@@ -116,7 +114,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_re=
s *resp)
 	else
 		dprintk("lockd: TEST4        status %d\n", ntohl(resp->status));
=20
-	nlmsvc_put_lockowner(test_owner);
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rc;
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index a31dc9588eb8..381b837a8c18 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -627,7 +627,13 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file =
*file,
 	}
=20
 	mode =3D lock_to_openmode(&lock->fl);
-	error =3D vfs_test_lock(file->f_file[mode], &lock->fl);
+	locks_init_lock(&conflock->fl);
+	/* vfs_test_lock only uses start, end, and owner, but tests flc_file */
+	conflock->fl.c.flc_file =3D lock->fl.c.flc_file;
+	conflock->fl.fl_start =3D lock->fl.fl_start;
+	conflock->fl.fl_end =3D lock->fl.fl_end;
+	conflock->fl.c.flc_owner =3D lock->fl.c.flc_owner;
+	error =3D vfs_test_lock(file->f_file[mode], &conflock->fl);
 	if (error) {
 		/* We can't currently deal with deferred test requests */
 		if (error =3D=3D FILE_LOCK_DEFERRED)
@@ -648,11 +654,8 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file =
*file,
 	conflock->caller =3D "somehost";	/* FIXME */
 	conflock->len =3D strlen(conflock->caller);
 	conflock->oh.len =3D 0;		/* don't return OH info */
-	conflock->svid =3D lock->fl.c.flc_pid;
-	conflock->fl.c.flc_type =3D lock->fl.c.flc_type;
-	conflock->fl.fl_start =3D lock->fl.fl_start;
-	conflock->fl.fl_end =3D lock->fl.fl_end;
-	locks_release_private(&lock->fl);
+	conflock->svid =3D conflock->fl.c.flc_pid;
+	locks_release_private(&conflock->fl);
=20
 	ret =3D nlm_lck_denied;
 out:
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index f53d5177f267..5817ef272332 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -117,7 +117,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res=
 *resp)
 	struct nlm_args *argp =3D rqstp->rq_argp;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
-	struct nlm_lockowner *test_owner;
 	__be32 rc =3D rpc_success;
=20
 	dprintk("lockd: TEST          called\n");
@@ -127,8 +126,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res=
 *resp)
 	if ((resp->status =3D nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
 		return resp->status =3D=3D nlm_drop_reply ? rpc_drop_reply :rpc_success;
=20
-	test_owner =3D argp->lock.fl.c.flc_owner;
-
 	/* Now check for conflicting locks */
 	resp->status =3D cast_status(nlmsvc_testlock(rqstp, file, host,
 						   &argp->lock, &resp->lock));
@@ -138,7 +135,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res=
 *resp)
 		dprintk("lockd: TEST          status %d vers %d\n",
 			ntohl(resp->status), rqstp->rq_vers);
=20
-	nlmsvc_put_lockowner(test_owner);
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rc;


