Return-Path: <linux-nfs+bounces-22542-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fCjwGtCGLWrDhAQAu9opvQ
	(envelope-from <linux-nfs+bounces-22542-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jun 2026 18:35:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C664F67F13B
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jun 2026 18:35:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IxnOPIWc;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22542-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22542-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBF203012335
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jun 2026 16:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12772E229F;
	Sat, 13 Jun 2026 16:35:24 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BCD75801
	for <linux-nfs@vger.kernel.org>; Sat, 13 Jun 2026 16:35:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781368524; cv=none; b=DiWCfBW6jXuxklIcFQaV6TcRE+ahizagVBjsQTCssWQgjoXUA4+TV//1y3ZTGQb9BPSrCzBpGGBzezJY5YeExox+o6Onu1Et1kTqQLQE5vxgTLHd074rw4XwsPX167gHg3RwyNQrYcwsOBE2CyuFcP0C6P9J4MSXciSIG71mAPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781368524; c=relaxed/simple;
	bh=oiCYkPaDKuuWKc7O3Fn+W1rJzjdXENV7kU1GIpv99+s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hp8VRc+4zlEtWfPeqsFo31/u4vdbzdFBynqkZ3/a4AVlSV/9kEbZqmHt+ncUry2ldQ6+7Fueozqj9pUrk7NPfqszsPUy8JPN9KovlEmO5Gyy9uAvFQDqpNuXdpKhJFicgt+oI4AVGS57c1xb85KhhITBk4N70OmV7F/VO6Ijzh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxnOPIWc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE791F000E9;
	Sat, 13 Jun 2026 16:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781368523;
	bh=Ry6eBTJa7gjRRJATQXuVhd2DBIsefrI3nqy2BcPDmMA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=IxnOPIWcaes05ybCNnvnJrpjpjRmO3DF0EQ0oN00P0eOpPzRRpOlm1r0vobQrly5y
	 hNSx0cYB+o4yAm9T7Copz43djUB/8TKVrlDZKQA4ysTWuNZ6BHUJElUCHejPigPrj6
	 hg4qxKTIhL5jiunPlQxXQNnaINDec6Ma4VLjSU8OPveE+2mp0p2Phiw2P8xrL+3ezW
	 TRHwr1EUm6GT1bZAqEL1cGo3LNdwwW9+3WJDxNTweQUxr/12yH44Uksnzdc3lfbDeE
	 egU/pLB4x+7oZwxVfgemkuGg1WPdanDiAv9eQcVTJOzEA3n/Gm7NHfEo08FUfurCX0
	 O8LAEek0gCb5A==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id F0799F4007C;
	Sat, 13 Jun 2026 12:35:21 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 13 Jun 2026 12:35:21 -0400
X-ME-Sender: <xms:yYYtavd1yU9M2S0SeS7X9b-NamZHH4u0YJnGqekaBwy6bOa1j07Dqg>
    <xme:yYYtagD4BcZjfApDNzTpuzFavMMPiNg7tGSzNX8H7S00q0S82yXd3vOXH2O9D_XB5
    lQhB6ZZRuCzoQpwA1bdsw9a53F_pPtW4pnFkc5Y12FcHP65dDjkO1U>
X-ME-Proxy-Cause: dmFkZTF9/5POrL4Yn9xb62dthH2UK4ktwmyd372xNwYSVkiZxXzQbe4iL7HM/s2WO1dQC2
    AWynM4iAUpIHd0UbCqMryvUmJOA9aLkvYt/eV5YVBoDVJOL2mavXZ5DOWCvgPXlJLGSviu
    yjco+9W2Y6+Nqe0Vk1V/2l5/trIU4F+6OVwqlcfwUF6OoGYk9J0cANpUhQjR1LsSQiP2ml
    BFbvDx7B86GvsBDfYYCN7s4vqM4IOilq74rIB61OlMXtCluRx5Q5yl/d0mEOlO4AXoBzBf
    gLMuvXKfjb6GBb89YZ47GNp1tLT6S2kVJ9xu+MyP34qNLqzAoR9zRFHTc2LnalEChW7ceY
    EpUOQuoL8Xp3zmFnd4MOXAYonAz8xmFqHmGrGbsYm3cMrvIzW/oArQ1wviywJFkQWD1YRV
    +NhfHBnVQKscpnjJRdTEJV7LMEm+z+mCT8wu8fPQSp+yZ3n25Qvo+ZNaFYk/LFwGofijLS
    V9j6T4PxNUHo8quK594ITPqHhHjjZ6zdOhoktHAzW3EkXZs/IJ2sUN7n8xt2xTfJoBoZsi
    Q6ai9IE1WNQvcTG6pJnE1sw7r3rfQ7XaTv1p9zcr/XWg0e81VN9/g7AoUuYk92xIgBmHNF
    E+JG6Dg5eLO4xjUoALGgcTqPb7kGilg5jwpAnrGanPa3Lhy9qUyLzf3r9reA
X-ME-Proxy: <xmx:yYYtaiDYiumCQzzqieH-n4J-6UUHipJ0Dm4xjUL_1dj6H6tzqVicow>
    <xmx:yYYtauDva7HHSrMQtSkccaJryXLkknkzHt3jZsd7PSiVFVlfuazdtA>
    <xmx:yYYtalofDhzSjH9I5fNxnb8y3wdF70lRHJPQ79oregm4zl2vJZLFrA>
    <xmx:yYYtagmPIplW2kY9ORWprNufrXwMGDmlXH_Ajk47TrBoklSIA0blbg>
    <xmx:yYYtatxEvkCkshFrJ3Zbll3HAUn9BFs0aMX6QDMOAjeYuvu06v9-NeDx>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CE35D780070; Sat, 13 Jun 2026 12:35:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AX6p6lkWayPV
Date: Sat, 13 Jun 2026 12:35:00 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Nikol Kuklev" <nikolk202@gmail.com>
Cc: security@kernel.org, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Message-Id: <58af210b-63c7-41b0-b339-21d13af9394a@app.fastmail.com>
In-Reply-To: 
 <CAM4XWykjHb5HHNSbBzSphEWTRSbtARjnC363Hk8D8x3kmU6t_w@mail.gmail.com>
References: 
 <CAM4XWym=NREGQ67b-ypADfJwemnF61dNyHp2LVMpkxphE_+dvQ@mail.gmail.com>
 <9b3bf3c9-c2c7-4db1-b722-d440ffd8d9a1@app.fastmail.com>
 <CAM4XWykjHb5HHNSbBzSphEWTRSbtARjnC363Hk8D8x3kmU6t_w@mail.gmail.com>
Subject: Re: [SECURITY] nfsd: fix null dereference in nfsd4_setattr for deleg timestamp
 attrs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nikolk202@gmail.com,m:security@kernel.org,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,app.fastmail.com:mid];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22542-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C664F67F13B



On Sat, Jun 13, 2026, at 4:24 AM, Nikol Kuklev wrote:
> When a SETATTR request includes FATTR4_WORD2_TIME_DELEG_ACCESS or
> FATTR4_WORD2_TIME_DELEG_MODIFY in the attribute bitmap, nfsd4_setattr()
> sets deleg_attrs=3Dtrue and calls nfs4_preprocess_stateid_op() to vali=
date
> the stateid.
>
> If the client supplies the NFSv4 "one stateid" (all-0xFF bytes),
> check_special_stateids() returns nfs_ok without populating the output
> nfs4_stid pointer, because the special-stateid path in
> nfs4_preprocess_stateid_op() jumps to done: with s=3D=3DNULL, and the
> "if (s)" block that would set *cstid is skipped. The local variable `s=
t`
> remains NULL.
>
> Back in nfsd4_setattr(), the if (deleg_attrs) block then unconditional=
ly
> dereferences st->sc_type (at offset 4 from NULL), causing a kernel oop=
s.
>
> This is remotely triggerable by any NFSv4 client: send COMPOUND [PUTRO=
OTFH,
> SETATTR(ONE_STATEID, {bmval2=3DFATTR4_WORD2_TIME_DELEG_ACCESS, ...})].
> No authentication, delegation, or prior state is required.
>
> Fix by adding a NULL check before the dereference. A special stateid is
> not a delegation stateid, so the existing nfserr_bad_stateid return va=
lue
> is already correct; we only need to guard the pointer dereference itse=
lf.
>
> Fixes: 7e13f4f8d27dc02fb88666f603c53ca749d56f92 ("nfsd: handle delegat=
ed
> timestamps in SETATTR")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Nikol Kuklev <nikolk202@gmail.com>
> ---
>  fs/nfsd/nfs4proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> v1 -> v2: Resend as inline patch per maintainer request; no code chang=
es.
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1251,7 +1251,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct
> nfsd4_compound_state *cstate,
>   if (deleg_attrs) {
>   status =3D nfserr_bad_stateid;
> - if (st->sc_type & SC_TYPE_DELEG) {
> + if (st && (st->sc_type & SC_TYPE_DELEG)) {
>   struct nfs4_delegation *dp =3D delegstateid(st);
>
>   /* Only for *_ATTRS_DELEG flavors */
> --=20
> 2.39.0

This appears to be your very first submission to the Linux kernel.
I don't see your email in the commit history nor does a lore
search find it. So I'm going to provide some friendly feedback.

The above snippet still does not apply.

In particular, note the whitespace damage in the diff body --
all the tabs are gone.

Please carefully review the below documents explaining how to
prepare your patches and configure your email client to submit
contributions to the Linux kernel:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/email-clients.rst

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst

Maintainers are few and contributions are many. We rely on
scripts and automation to make the individual chores easy and
not overwhelming. When you submit a patch that does not follow
the guidelines above, we have to take time to massage your
submission. For many maintainers, that means they won't bother
to apply it at all, even if your patch is valid.

Since this is your first submission and it is only a one-line
change, I hand-rolled it and applied it to the nfsd-testing
branch.

Next time, please carefully observe our posting guidelines so
this process goes smoothly for you and for us.


>> Thank you for the bug report. Unfortunately the attachment does
>> not apply using "git apply". Please resend the patch inline. See:
>>
>> Documentation/process/email-clients.rst =E2=80=94 "Email clients info=
 for Linux."
>>
>> Lines 21-26 state: patches are submitted via email "preferably as inl=
ine
>> text in the body of the email." Attachments are "generally frowned up=
on
>> because it makes quoting portions of the patch more difficult in the =
patch
>> review process," and where accepted must use content-type text/plain.
>>
>> This doc then covers per-client configuration (Mutt, Alpine, Claws,
>> Evolution, Kmail, Thunderbird, etc.) to send patches inline without
>> mangling whitespace.
>>
>> Related companion docs:
>>   - Documentation/process/submitting-patches.rst =E2=80=94 overall pa=
tch
>> submission guidance
>>   - Documentation/process/applying-patches.rst =E2=80=94 the receivin=
g end


--=20
Chuck Lever

