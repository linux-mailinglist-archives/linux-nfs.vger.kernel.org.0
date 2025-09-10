Return-Path: <linux-nfs+bounces-14164-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9E1B50A9C
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 04:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D041C4E0367
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 02:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7193A70830;
	Wed, 10 Sep 2025 02:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="jcoxyOo4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FtFI4SlE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB48B14F9FB
	for <linux-nfs@vger.kernel.org>; Wed, 10 Sep 2025 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469645; cv=none; b=MSUgphSBvyCgxH/Bu8dqHDVK1PyLcUpW+oczGYjdNxbjQu7rc4mNll3SWyVSLWAPZldKT/z9EfbcJNqc1akbtM7BosSC7yshvQ+kLJbLqfN/oTtmnR692LUQUIZCvzjhKuSHgs0EJj3kFBAqKF49mwm9WEgLW9Pi3GW0APReFqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469645; c=relaxed/simple;
	bh=8xxHkYN/dziXjIjjPBClQDk73osTxEV1tFmSZHgzWkE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=OkrZwUfOei/mueT5O8u2aVjnYqM+cxin0YN/0eDGMmhEksaewCDZ8CSYrrs/+vaAGl7PpZB8+NWiyLTENyZ8HRASWgy8TAtl6lcoKe46GWo47cWcjGjfK9wsGhXMz5MvHmov8DtFw3fScSZ4WGammfZS8QpI30WA2wLxL8QFPcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=jcoxyOo4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FtFI4SlE; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E4D957A01DB;
	Tue,  9 Sep 2025 22:00:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 09 Sep 2025 22:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1757469639; x=1757556039; bh=56dSISCKSSDuPn+mztuSqYnvr0ab5u9ojLE
	XEuYZKVw=; b=jcoxyOo4ys87fcqmN/9T4TPhnhJ6VL1LJBx2hPDVEEP8M/ZZ1wp
	vwDDNmlUqOJo4hjVxlh/EUtq+Uy5/ALL6pprjDgrCWeJlk3NDjSOYr7fAzEiZWvT
	tcPGKSXXSobMhlRNXkarvlNaS7PaRGvKmMgYKVN5PBJc4ufm0mdjutFUzlOthdpg
	NY454Ao7m3pu3U36ZV1mUHlFPPJgwlvl75M/Ih6aA/tZg+dDngPFHvLWNUEZkyYZ
	9TDWhiZ2N1zQ0dHLXjMqWELxbDFw28EIFv2LEYJ3wZppZXBcJQkZgmJFH+Ux9Tb3
	IATb5pKEs5MMfCkmfYg7lIqsKZNTrOiEfmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757469639; x=
	1757556039; bh=56dSISCKSSDuPn+mztuSqYnvr0ab5u9ojLEXEuYZKVw=; b=F
	tFI4SlEhJgp0tuxmlNprynPSmqsAczEWDY1p7ZUVlRmdeo19eFX1doFdI5Ns+Lg6
	bQZ+rinYk40FpDrrHepFtCFVl3YuQwj0kNYs7fd4eeB3RkxnR/bkUVCOsW1G1STH
	sIJMg5U1DvIGh9AxwrM+56jChNHkJg3vN6jlmFWl8yjdn6blQdYUF5Cs5jIzytwn
	V6xL/gHFcxpLeFV3GVXQtBNu3oYdiCs3SIAOkXU66gWkf0so5QK579NaZbRUQJkm
	uQUva8ex+ZVy2S5jaOkFOL3Ug8G2XzVzyp6rxEIhvm7M0COUh2mtenjaQBALzr5T
	eD+9+Fo+8L4gR7z3IEQUA==
X-ME-Sender: <xms:x9vAaAX6htTBwVv9E35UIzw5JbQVRq_AX00M74ux0D7elGmaC_StUg>
    <xme:x9vAaAGFxzc3PHkdNR3IdF57RU_JhEq5kkjqQdyL-iC8fPPOaJftagU9z53KUNt5q
    Z6CI_-Mz7MlRQ>
X-ME-Received: <xmr:x9vAaK2x_wFFtPu5i8O8lSuZwEhxMh4tK-hXxxNwTQnaIwTBAnWTcroXxFSoMBoUfSl5V364zGKqdIZYR50zv2EORS_nbdjmp8tYj0EVO07O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvehrufgjfhffkfesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgvedvjeehhefhfeegkefhveekieehkeeviedvueevleejfeekjeeuhffhffevjeenucff
    ohhmrghinheprhgvughhrghtrdgtohhmpdhsohgtkhgvthdrrghsnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghi
    lhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peihohihrghnghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshhtvghvvggusehrvg
    guhhgrthdrtghomhdprhgtphhtthhopehsmhgrhihhvgifsehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopegstghougguihhnghesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:x9vAaKPREZpcCU7JBF3r59P1XSsM6ju5ejqnlyIhE0qOHn-8gncZ-A>
    <xmx:x9vAaB4OLzwMS1RVtOQZj4e4ljaBUYYiS0XTJkFRdNEcnyKrla8kXg>
    <xmx:x9vAaM0-mUTBF245S5wIQNLIBp6cMKjujK_ezjcQ4eP0c0rw8-6euA>
    <xmx:x9vAaKwsGYYsUbu3hD9Y6pfK0BPoeHw68mjHlPXRIsuq4Eqb2879SA>
    <xmx:x9vAaGkI6m47DIcGoQgLiSrUXtBSIN3WwJxzD3Uu6PXHzknGKFRsGmAU>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 22:00:37 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Scott Mayhew" <smayhew@redhat.com>
Cc: steved@redhat.com, bcodding@redhat.com, yoyang@redhat.com,
 linux-nfs@vger.kernel.org
Reply-to: neil@brown.name
Subject: Re: [nfs-utils PATCH v2] rpc-statd.service: define dependency on both
 rpcbind.service and rpcbind.socket
In-reply-to: <20250909131752.1310595-1-smayhew@redhat.com>
References: <20250909131752.1310595-1-smayhew@redhat.com>
Date: Wed, 10 Sep 2025 12:00:29 +1000
Message-id: <175746962966.2850467.1938500503007460477@noble.neil.brown.name>

On Tue, 09 Sep 2025, Scott Mayhew wrote:
> In 91da135f ("systemd unit files: fix up dependencies on rpcbind"),
> Neil laid out the rationale for how the nfs services should define their
> dependencies on rpcbind.  In a nutshell:
>=20
> 1. Dependencies should only be defined using rpcbind.socket
> 2. Ordering for dependencies should only be defined usint "After=3D"
> 3. nfs-server.service should use "Wants=3Drpcbind.socket", to allow
>    rpcbind.socket to be masked in NFSv4-only setups.
> 4. rpc-statd.service should use "Requires=3Drpcbind.socket", as rpc.statd
>    is useless if it can't register with rpcbind.
>=20
> Then in https://bugzilla.redhat.com/show_bug.cgi?id=3D2100395, Ben noted
> that due to the way the dependencies are ordered, when 'systemctl stop
> rpcbind.socket' is run, systemd first sends SIGTERM to rpcbind, then
> SIGTERM to rpc.statd.  On SIGTERM, rpcbind tears down /var/run/rpcbind.sock.
> However, rpc-statd on SIGTERM attempts to unregister from rpcbind.  This
> results in a long delay:
>=20
> [root@rawhide ~]# time systemctl restart rpcbind.socket
>=20
> real	1m0.147s
> user	0m0.004s
> sys	0m0.003s
>=20
> 8a835ceb ("rpc-statd.service: Stop rpcbind and rpc.stat in an exit race")
> fixed this by changing the dependency in rpc-statd.service to use
> "After=3Drpcbind.service", bending rule #1 from above.
>=20
> Yongcheng recently noted that when runnnig the following test:
>=20
> [root@rawhide ~]# for i in `seq 10`; do systemctl reset-failed; \
> 	systemctl stop rpcbind rpcbind.socket ; systemctl restart nfs-server ; \
> 	systemctl status rpc-statd; done
>=20
> rpc-statd.service would often fail to start:
>=20
> =C3=97 rpc-statd.service - NFS status monitor for NFSv2/3 locking.
>      Loaded: loaded (/usr/lib/systemd/system/rpc-statd.service; enabled-run=
time; preset: disabled)
>     Drop-In: /usr/lib/systemd/system/service.d
>              =E2=94=94=E2=94=8010-timeout-abort.conf
>      Active: failed (Result: exit-code) since Fri 2025-09-05 18:01:15 EDT; =
229ms ago
>    Duration: 228ms
>  Invocation: bafb2bb00761439ebc348000704e8fbb
>        Docs: man:rpc.statd(8)
>     Process: 29937 ExecStart=3D/usr/sbin/rpc.statd (code=3Dexited, status=
=3D1/FAILURE)
>    Mem peak: 1.5M
>         CPU: 7ms
>=20
> Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Version 2.8.2 starti=
ng
> Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Flags: TI-RPC
> Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to register (=
statd, 1, udp): svc_reg() err: RPC: Remote system error - Connection refused
> Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to register (=
statd, 1, tcp): svc_reg() err: RPC: Success
> Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to register (=
statd, 1, udp6): svc_reg() err: RPC: Success
> Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to register (=
statd, 1, tcp6): svc_reg() err: RPC: Success
> Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: failed to create RPC=
 listeners, exiting
> Sep 05 18:01:15 rawhide.smayhew.test systemd[1]: rpc-statd.service: Control=
 process exited, code=3Dexited, status=3D1/FAILURE
> Sep 05 18:01:15 rawhide.smayhew.test systemd[1]: rpc-statd.service: Failed =
with result 'exit-code'.
> Sep 05 18:01:15 rawhide.smayhew.test systemd[1]: Failed to start rpc-statd.=
service - NFS status monitor for NFSv2/3 locking..
>=20
> Define the dependency on both rpcbind.service and rpcbind.socket.  As
> Neil explains:
>=20
> "After" declarations only have effect if the units are in the same
> transaction.  If the Unit is not being started or stopped, the After
> declaration has no effect.
>=20
> So on startup, this will ensure rpcbind.socket is started before
> rpc-statd.service.  On shutdown in a transaction that stops both
> rpc-statd.service and rpcbind.service, rpcbind.service won't be
> stopped until after rpc-statd.service is stopped.
>=20
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown


> ---
>  systemd/rpc-statd.service | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/systemd/rpc-statd.service b/systemd/rpc-statd.service
> index 660ed861..96fd500d 100644
> --- a/systemd/rpc-statd.service
> +++ b/systemd/rpc-statd.service
> @@ -6,7 +6,7 @@ Conflicts=3Dumount.target
>  Requires=3Dnss-lookup.target rpcbind.socket
>  Wants=3Dnetwork-online.target
>  Wants=3Drpc-statd-notify.service
> -After=3Dnetwork-online.target nss-lookup.target rpcbind.service
> +After=3Dnetwork-online.target nss-lookup.target rpcbind.service rpcbind.so=
cket
> =20
>  PartOf=3Dnfs-utils.service
>  IgnoreOnIsolate=3Dyes
> --=20
> 2.50.1
>=20
>=20


