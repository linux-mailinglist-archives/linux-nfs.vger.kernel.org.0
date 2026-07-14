Return-Path: <linux-nfs+bounces-23314-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z3M+Ki1VVmo23gAAu9opvQ
	(envelope-from <linux-nfs+bounces-23314-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2026 17:26:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAFE756694
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2026 17:26:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Vz7Icj9E;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23314-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23314-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A3113074F51
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2026 15:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB84495527;
	Tue, 14 Jul 2026 15:16:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB1148C40F
	for <linux-nfs@vger.kernel.org>; Tue, 14 Jul 2026 15:16:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042207; cv=none; b=m/st09KnZHtBTE1FA/KF+mzEyOt/hTmuL4iTrek5ASSIMgRiop3BwtbybN2srO8tAFOGQohTQM9+zPBof6HojQf5kqe7Vw1P3uTn/pjl2Nh0mpgOU/aPs5uETr/WDpsUDOQd5KzBOXjMiftoBTnTVeFiYM+8OOl02dZ8uXWKDPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042207; c=relaxed/simple;
	bh=XWuH/bkFbRh2NtqZ1UTv/UzmhCRUo5Ubxoqv1ODWHAc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YxSr58CSKubwaDwmlUlnuIORSIL3qrOWfYKVWle0Rp6YZ+H9k3EtZJ3ErzRbTaNbQIUY+fnGFPyWr3XlfS7IugDOS+iTOk37Xvz8r333iDAOF4Xi6fo4RRE8U3LxjUZ89g+LKZtSSns2LmR7wtft4Ofl608IwIEAZLVTfh4KXWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vz7Icj9E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10911F00A3A
	for <linux-nfs@vger.kernel.org>; Tue, 14 Jul 2026 15:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784042205;
	bh=2SVBonFlIunKYkpmJ+iRuwiOlU5TLF7PSRzcSCCMyEk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Vz7Icj9EsDFSDS/C5Lf76wgcp9wob2V8N3oAayBP4oxV3Q/8giY13J9SsmpP5rG75
	 qSlzLBWh0dVNn1+syVDEIhi9dPCIHYl+KlyEEq2cHWZWuV3y7KPe4e47LJeGgSBNw6
	 4nroIShNM5W7uTHZSX5O7OBOkJvgDp3RK6+ijuiECbJ+JDdO6Ls9fg0ns0zSrkCDox
	 SjI+Ib7wdRH4yyQJ8CnUS3RH+Nn1m9R51Y53IioGidojqeZ5D8yMUUc5c1euD7IOSB
	 8SUeb1piV1X6ayAoR8O326Ef47v0fPOigZczNO549Y4Cq62DrbKm3athz853P0ehLN
	 VcX/jDmdzbhow==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B1117F40066;
	Tue, 14 Jul 2026 11:16:44 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 14 Jul 2026 11:16:44 -0400
X-ME-Sender: <xms:3FJWaoOondBTVzaU90JzN4qvFJDGro3j1fL4ph2VqgJ9-AOW9KQOVw>
    <xme:3FJWapxF2UYfByR4izjMk5LIHdQbIovzQ4AdHZWzhoyKqfXFLCnS0IgHwZSLRno3O
    atKjmv6qSjcXFDuYB-8Cnldj-q5ku8xkWyB-5Yxc3qYZggO_EBaS65o>
X-ME-Proxy-Cause: dmFkZTEDNHpeYniHqLf/4+To/x8XgZOiIz9BNQlYiYRE285vZRmRmOkkyxJQmU9yKpvzyz
    MpaTlKBuZqGD7NT4SFoI50MOOkuWBBNF2rvTWeRGBnFbDdyx2Nybmsx/pTM2189oWLKQXG
    9ZRNj5CyGH7HmqUJHimhn8T1PjCvLJRNgnLXCYQrdaezmZ9oYOa0WSS8dot90iSt+eOAOw
    rHTL+oDzeEPSnoAi17oI75T9Jf92vHpo/TByemczkefJj0g0gDuYFYiRFv7qG7mtqv57nz
    dEZesM9pOktzvroqsfqYSnrkiuZ9dPjDA+nqymk5gy4cc+Ej6EDFV6TeV6EESvv1p6XXs2
    GJOVvCnojFq+6aPw4rJED1lxk26uSDk8sac+pewQANBjr4FfJF1rJfQkMD2fRbSUhhhAQ7
    6H45MI2hhm8RAQlIGvqauqq0SPrB9RXved/jobKA8ZPj8hE1MuoqOfQJaGoSFLBgNhpgGZ
    jcAVQD9PptzM6JhLfJ9dKLaCIuqncmzdL462xggEbIR0VRO5V0QONEK++w/USK+faFSCAG
    C2EjPO0Lug6PETLh98DjeZdLOPYXc+0eOc1YFSg3mx7swCIHEWnEQc3oJn1HKvLpbJF3h9
    il/mB7pNep2dj99Mx0KHfv4spdJ64dw+vZvC5uw0NLZIfQkrrlV0/UhvvTMA
X-ME-Proxy: <xmx:3FJWan3xrUwUEDo2pGbO0EYPTBYRZYX8vTgIWMRveoFky3I-kcIv0w>
    <xmx:3FJWaj4uYsvmg4vcamMbJhkxqNqEbJmcfmvtUHNOIC199HYn6v5V1A>
    <xmx:3FJWaiWawuAwOSGlv2DW9BFpn-SqM7P06dd-mX1SqIuGV6BOJ1gOfw>
    <xmx:3FJWaqAtCwjaVMA1h27Vf_mkka942BYLhRKbYzoA9USgQDh-CtYJCA>
    <xmx:3FJWap5AK89cWBpaJR9RZEFJ5636lgMevsb9y5bI9-My8JPHzwjsgKh->
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8D8217811B3; Tue, 14 Jul 2026 11:16:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AiMPoQqzriiR
Date: Tue, 14 Jul 2026 11:16:24 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "zhangjian (CG)" <zhangjian496@huawei.com>,
 "Steve Dickson" <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <dfd0efac-0d06-47f5-a9bd-04b26f4061af@app.fastmail.com>
In-Reply-To: <356736aa-25d8-4b79-a50f-33b4e7035856@huawei.com>
References: <356736aa-25d8-4b79-a50f-33b4e7035856@huawei.com>
Subject: Re: nfsd: fix memory overflow for haddr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-23314-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhangjian496@huawei.com,m:steved@redhat.com,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,app.fastmail.com:mid];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EAFE756694

Hi -


On Tue, Jul 14, 2026, at 4:43 AM, zhangjian (CG) wrote:
> when hcounter is not 0, haddr memory is not enough.
> asan report heap-buffer-overflow error in following scene:
> CFLAGS=3D"-fsanitize=3Daddress -g" ./configure && make
> ./utils/nfsd/nfsd -H 192.168.1.1 -H 192.168.1.2
>
> Signed-off-by: zhangjian <zhangjian496@huawei.com>
> ---
>  utils/nfsd/nfsd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
> index c95d32f4..e3fcdde4 100644
> --- a/utils/nfsd/nfsd.c
> +++ b/utils/nfsd/nfsd.c
> @@ -185,7 +185,7 @@ main(int argc, char **argv)
>  				hcounter =3D 0;
>  			}
>  			if (hcounter) {
> -				haddr =3D realloc(haddr, sizeof(char*) * hcounter+1);
> +				haddr =3D realloc(haddr, sizeof(char*) * (hcounter+1));
>  				if(!haddr) {
>  					fprintf(stderr, "%s: unable to allocate "
>  							"memory.\n", progname);
> --=20
> 2.33.0

A couple of notes regarding patch submission process:

You sent this To: chuck.lever and prefixed the Subject with
"nfsd:" so I assumed it was for the Linux in-kernel NFS
server. In fact, it's for nfs-utils. Steve might not
recognize that he is responsible for this patch. I suggest
using "nfs-utils:" instead for such patches (including the
preceding patch labeled "gssd:").

Second, your email transfer agent's DKIM is misconfigured.
This security feature is tested by our patch intake tooling
as a way to spot bogus submitters. b4 reported this when I
imported your patch:

  =E2=9C=97 [PATCH] nfsd: fix memory overflow for haddr
    + Link: https://patch.msgid.link/356736aa-25d8-4b79-a50f-33b4e703585=
6@huawei.com
  ---
  =E2=9C=97 BADSIG: DKIM/h-partners.com

This might become a blocking gate for future submissions, so
you should speak with your email administrator to get this
corrected.


--=20
Chuck Lever

