Return-Path: <linux-nfs+bounces-22437-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ljU0Fi92KWrKXAMAu9opvQ
	(envelope-from <linux-nfs+bounces-22437-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 16:35:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CECE66A435
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 16:35:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cBahSpXs;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22437-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22437-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA2FB32F8A1A
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 14:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AEF3BB122;
	Wed, 10 Jun 2026 14:28:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCB633D4F8;
	Wed, 10 Jun 2026 14:28:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101715; cv=none; b=XHsTJ0XJk62m+B++fzV7sQMoua/n0NSw6+iY2QbrcfbN+b9LBkHnIgzcvCiBWInDQhFo/mhmpaTTX9f40waBK/T9kIQjjlo8GcfTa/4LRcZMJWXPXRKclbRYDrNzMOmkNd6qGoDF2RHEXJdXnOkLf1ZKhP/CixfZ7jwQNqBQdyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101715; c=relaxed/simple;
	bh=+bmwZAtHHEshgOQRjN5qxE4tw/GFszAT5/dc2pPV7X4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BW1ajHpeEI61t7AUCi6q2znLCIMF6KiMA4Z4tfSd3G+QjZV8vnNPgxIo8XdusA0q9wBv48y9wgsiD4KW0UGsr/8Ipx2+AMM1XnCJJBJhNArvn8+QuYAV2QKy6huVvj5BVY7TPBxI/1ulaPGNnWCIGtqoqgQrnkUeMT09L57+oFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBahSpXs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6111F00898;
	Wed, 10 Jun 2026 14:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781101713;
	bh=usz09gXUhRAO92R6pHZAh8vlZ5c7zZWYbZMrAGM/zYA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=cBahSpXs+rj+EGmSTxpFTUCH8GDXFZCSj4IZSZ/gCSFI73GFQ7SGh9/+6WRIbFUZs
	 6BE9hAU4zELw1P7OGX5s3lDw0HmUFnKgiIJCEPdVaBlwG+Go8cC9svNjeuDSMAQ2Lp
	 MADs5BUjctJCHIDvyjjhPIXHHXPk8RKiKAMicLUStNmnz5Eoq9l7QbWeKmPEprS3jc
	 4pCD9Q2sYeD6Cw1eq9h4pDldHsbcsm/rfX2QaM3CBmiegeqJZZARz9DvKR1uUdV2/E
	 1NsOY3NUgCr96zj/8L9WqnHX4L4B+Eq41X0jpRqO9L0cVH8MF+ddeLe5GdXFVPXhD4
	 xAsPG9TzeKNCg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 68381F40097;
	Wed, 10 Jun 2026 10:28:32 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 10:28:32 -0400
X-ME-Sender: <xms:kHQpaoAXPlsGYf7BA0x6NXH9wFMjKkfePfpWauGCNT7b4pUsG_GXeg>
    <xme:kHQpalXVGyjIKAjCueY5GEOkMeoPfCBok9DEQqIRmSY0rE4VekZJJS9M9J_6iuVeh
    Zx5Mnswt7Ei7sBZ8TvWxW2ypO5i9P-1lbG-fsWgJE5vsNStTogsbJ1H>
X-ME-Proxy-Cause: dmFkZTFug49oVC+lYOXXANZTytnInRE9GA76nwoLHANdW1h4FSdQOMVIi2Dymb/z1aE5No
    xZKQIbjnzTYfq7ejRHdCJF1jIUuB9IlOof13D10/4NF0R9QciAC0asuUdWaJjK131BpGn3
    i5hm55tRIiyCZrr8R0ZeikhrVD5KwusATQgwuOPAUwtxiPtDZmvcVKm1rDgwYn76oZhUNh
    qg5JwsFejSx41++L/9ehtHuJQD2uA3Cm/XhJ8XBAPpagAgytpUMmGr6r/48tyXkq+A3PCA
    MNCvHFNMTbbP6GqTQFQSQTQkK4sh7+SGWp9bV7ca0yDDaYrZ/8Uvj45ugsCoX1v1IaEpVU
    SobUmEuTZj0qtx6DleyDOjNnsXea8OlWtt7cCva6LacDDgbBA//YiZq3mXW2y6mR0j8mvI
    hlX8iV3D4Yayabg1tLXhwRuvANRpsqJf0U1CR2/5n3s8xVK+spzL9uP8k49GATLCSnv9Ow
    yLLVPoWhdHBCEsruCPk/TfNeGAL7dswDyWd4jXg7ErIN27+1OP9tf3vIJ6N6Cg94SbRx4Z
    yRuJEIl4GGJDqSeEPpIotC3NdWRTTv42HNQvHbJvMH6K+ji8wAE5hI8BngVNOb+Mo6H2jI
    SmQQLSOKxKwfhLAxKQPML3JvCs4kzJZCSbVc7/bq3V+6MPTEi1knp7C1eQOA
X-ME-Proxy: <xmx:kHQpaji7R4ldspZ8pkiH02PWa6TN_cdMXuNnA2ZPuZHmTlcRU38D6g>
    <xmx:kHQpajEI1D2_AWeSTHKDwLqrr2M4G3zNNeqYu2NL7l-Zzae5_y5rpA>
    <xmx:kHQpatta7Tntfodk21szWht8uHbz1Y6aTE7cM2Jx0fMwqQ6IjkI91w>
    <xmx:kHQpasfolm4qs7Jppr9FP7Qcyp6F3lDd8w-mpr-5G5WaBmQr4azAhg>
    <xmx:kHQparlPmGjgobJpBteMuKD6iXYolGxTa3kn5NiNGnIkEFNYxYyyavmq>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 408D4B60070; Wed, 10 Jun 2026 10:28:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7DWBoyFEMmk
Date: Wed, 10 Jun 2026 10:28:10 -0400
From: "Anna Schumaker" <anna@kernel.org>
To: "Thorsten Leemhuis" <regressions@leemhuis.info>,
 "Trond Myklebust" <trondmy@kernel.org>, NeilBrown <neil@brown.name>,
 "Igor Raits" <igor.raits@gmail.com>
Cc: =?UTF-8?Q?Jan_=C4=8C=C3=ADpa?= <jan.cipa@gooddata.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 "Linux kernel regressions list" <regressions@lists.linux.dev>
Message-Id: <fa68fbe1-466e-4fa3-8245-8eb61243b409@app.fastmail.com>
In-Reply-To: <5cbf8431-e3c4-41d9-afcd-fb121dc12395@leemhuis.info>
References: <177745671692.1474915.5018486129724109553@noble.neil.brown.name>
 <20260429104938.1776671-1-igor.raits@gmail.com>
 <971ecb6c-2687-429f-af86-fc980c2d04f9@leemhuis.info>
 <5cbf8431-e3c4-41d9-afcd-fb121dc12395@leemhuis.info>
Subject: Re: [PATCH] NFSv4: clear exception state on successful mkdir retry
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.65 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22437-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[leemhuis.info,kernel.org,brown.name,gmail.com];
	FORGED_SENDER(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:regressions@leemhuis.info,m:trondmy@kernel.org,m:neil@brown.name,m:igor.raits@gmail.com,m:jan.cipa@gooddata.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:regressions@lists.linux.dev,m:igorraits@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,linux-nfs.org:url,gooddata.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CECE66A435

Hi Thorsten,

On Tue, Jun 9, 2026, at 6:05 AM, Thorsten Leemhuis wrote:
> On 5/13/26 09:18, Thorsten Leemhuis wrote:
>> [top-posting to facilitate processing]
>>=20
>> @NFSv4 maintainers, just wondering, did this patch maybe fall through
>> the cracks? It fixes a regression, that's why it's on my radar. Or was
>> there some progress and I missed it?

The patch is in my linux-next branch here: https://git.linux-nfs.org/?p=3D=
anna/linux-nfs.git;a=3Dcommit;h=3D238e9b51aa29f48b6243212a3b75c8e48d6b96=
fd

It'll be included when the merge window opens this weekend.

Anna

>
> Still no progress afaics. Feels like I'm missing something obvious or
> like I'm totally of track.
>
> Igor, Neil, is that the case? Or are you also waiting for the fix to
> make progress?
>
> Ciao, Thorsten
>
>> On 4/29/26 12:49, Igor Raits wrote:
>>> After a server returns NFS4ERR_DELAY for an NFSv4 CREATE issued by
>>> mkdir(2), the client correctly waits and retries.  When the retry
>>> succeeds, however, mkdir(2) can still surface -EEXIST to userspace
>>> even though the directory was just created on the server.
>>>
>>> Reproducer (random 16-hex names so collisions are not the cause)
>>> against an in-kernel Linux nfsd; reproduces under both NFSv4.0 and
>>> NFSv4.2:
>>>
>>>   N=3D2000000; base=3D/var/gdc/export
>>>   for ((i=3D1; i<=3DN; i++)); do
>>>       d=3D$base/$(openssl rand -hex 8)
>>>       mkdir "$d" 2>/dev/null || echo "$(date +%T) failed loop=3D$i $=
d"
>>>       rmdir "$d" 2>/dev/null
>>>   done
>>>
>>> Failures cluster at the cadence at which the server-side auth/export
>>> cache refresh path causes nfsd to return NFS4ERR_DELAY for CREATE.
>>>
>>> A wire trace of one failure (the three CREATE RPCs all come from a
>>> single mkdir(2), generated by the do-while in nfs4_proc_mkdir()):
>>>
>>>   client -> server  CREATE name=3D...  -> NFS4ERR_DELAY
>>>   ~100 ms later
>>>   client -> server  CREATE name=3D...  -> NFS4_OK         (dir creat=
ed)
>>>   ~80 us later
>>>   client -> server  CREATE name=3D...  -> NFS4ERR_EXIST   (correct)
>>>
>>> Since commit dd862da61e91 ("nfs: fix incorrect handling of large-num=
ber
>>> NFS errors in nfs4_do_mkdir()"), nfs4_handle_exception() is called o=
nly
>>> when _nfs4_proc_mkdir() returned an error.  That gate breaks retry-s=
tate
>>> hygiene: nfs4_do_handle_exception() resets exception.{delay,recoveri=
ng,
>>> retry} to 0 on entry, so calling it on success is what previously
>>> cleared the retry flag set by the preceding NFS4ERR_DELAY iteration.
>>> With the gate in place, exception.retry stays at 1 after the success=
ful
>>> retry, the loop runs once more, and the resulting CREATE for an
>>> already-created name yields NFS4ERR_EXIST -> -EEXIST to userspace.
>>>
>>> Drop the conditional and call nfs4_handle_exception() unconditionall=
y,
>>> matching every other do-while in fs/nfs/nfs4proc.c (nfs4_proc_symlin=
k(),
>>> nfs4_proc_link(), etc.).  The dentry/status separation introduced by
>>> that commit is preserved.
>>>
>>> Fixes: dd862da61e91 ("nfs: fix incorrect handling of large-number NF=
S errors in nfs4_do_mkdir()")
>>> Reported-and-tested-by: Jan =C4=8C=C3=ADpa <jan.cipa@gooddata.com>
>>> Closes: https://lore.kernel.org/linux-nfs/CA+9S74hSp_tJu2Ffe2BPNC2T2=
5gfkhgjjDkdgSsF5c2rnJq_wA@mail.gmail.com/
>>> Reviewed-by: NeilBrown <neil@brown.name>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Igor Raits <igor.raits@gmail.com>
>>> ---
>>>  fs/nfs/nfs4proc.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>> index a0885ae55abc..ffd14141ea1d 100644
>>> --- a/fs/nfs/nfs4proc.c
>>> +++ b/fs/nfs/nfs4proc.c
>>> @@ -5393,10 +5393,9 @@ static struct dentry *nfs4_proc_mkdir(struct =
inode *dir, struct dentry *dentry,
>>>  	do {
>>>  		alias =3D _nfs4_proc_mkdir(dir, dentry, sattr, label, &err);
>>>  		trace_nfs4_mkdir(dir, &dentry->d_name, err);
>>> +		err =3D nfs4_handle_exception(NFS_SERVER(dir), err, &exception);
>>>  		if (err)
>>> -			alias =3D ERR_PTR(nfs4_handle_exception(NFS_SERVER(dir),
>>> -							      err,
>>> -							      &exception));
>>> +			alias =3D ERR_PTR(err);
>>>  	} while (exception.retry);
>>>  	nfs4_label_release_security(label);
>>> =20
>>

