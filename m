Return-Path: <linux-nfs+bounces-21370-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOaNCfmd92nmjgIAu9opvQ
	(envelope-from <linux-nfs+bounces-21370-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 03 May 2026 21:11:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC074B712E
	for <lists+linux-nfs@lfdr.de>; Sun, 03 May 2026 21:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51D9B30078F4
	for <lists+linux-nfs@lfdr.de>; Sun,  3 May 2026 19:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6E437700A;
	Sun,  3 May 2026 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5EGOeUn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA5337649B
	for <linux-nfs@vger.kernel.org>; Sun,  3 May 2026 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777835509; cv=none; b=AEt680IP+e0nvBQpylHPG5lUUEss3hw1zumFQK5bVx+UiG+g1M8kgkZ6wQoh+YMz/symlq+ge4TMRqkHzI1qrAUQIGx7QRz/K+SDNa4bLuLOcjEnuQ31XVAjUvNalDU/f/HePgDpeaIo5g4HSoap4yNaBy/yfNL/t1NCsR7XPWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777835509; c=relaxed/simple;
	bh=vs3Yq6iRW4JVla6OLUlMHL5ekqG8d1hXCaEjlX8gGt4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KNF7kq5yI/LZHF1lRft8rZFgq9WdkBZBapSfOT1/oZ4q9Z4KSF3EVQRG/WQUjwRX9A9C+voP/+CPy1l4Qx50pOjAYS9Ly+/P69aON+gFz+8R8RDXcM7uUG1FVM+s0MVQ/ZQ3wvtxKEYfiXABACL1b5AGEtvBe6bqkJJm4It7jH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5EGOeUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D108C2BCB9;
	Sun,  3 May 2026 19:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777835508;
	bh=vs3Yq6iRW4JVla6OLUlMHL5ekqG8d1hXCaEjlX8gGt4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=B5EGOeUnulhM6BYJleKP3PSqd+bon++o++G7J4aVhccc+u63nW4eQ8agJSfxylEBN
	 vwGQXb/NPcvMdkZKZJ/TR0WzsJV3FJSYrbJY1wrGJu4ptyQNiT1oF3dHZYymfl/0fG
	 ibLUz+eArFOfHky27FaocRZzGsRkLj/SFsf+v6ZAIZbpjncEfRyuuOnjflEHXcXDF8
	 9xZFeCJm0NMyH+3hLlcXTYlznLv9EJmw09+Y03a1ykb+a4zfzCRZD7A0dWu8J5Tl4T
	 7vnhNOVf1cW2sz1ythlswdhZ0Vtv3r2aoT+OXS9WvIOIKWEE+AwLqbkuIRWkmD0EQJ
	 1rRU3v9Uvg/zw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8DCB2F40084;
	Sun,  3 May 2026 15:11:47 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sun, 03 May 2026 15:11:47 -0400
X-ME-Sender: <xms:8533aTibQ7Uj6oI5CsbPN-TWgyLGLWgemBittnjAA05WeEKlv_dtUg>
    <xme:8533aa06bG4nPBXfP6jjw1H2CsqgY6DqAUFvjZvLaNuC6wLyRVqqHOCL8ETYMzhU6
    7uS9Dt1GwNPeFOVfZyElWbbUw-jcbIebOgwKSudftQ3-kNfA8r7xAc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelieejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epgffhgeeutdeiieevuefgvedtjeefudekvefggefguefgtefgledtteeuleelleetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprhgtphhtthhopehkvghrnhgvlhdqth
    hlshdqhhgrnhgushhhrghkvgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthho
    pegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehsmhgrhi
    hhvgifsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8533aSs02W3pdes0-ce0aDb6EhFQ9NwiQg3zVCN8x6KQVTUb0ke3-w>
    <xmx:8533aQYy-k8GXYSEoFxcNq28C1_Ox-NeafFvMltDBfr1nn4aKeaD2w>
    <xmx:8533aZX4OX5bPiaGiU-YQVMwpI9UlvW9tYFw-j7WlHAlIax_LAOHkQ>
    <xmx:8533adT20Soxl9rVFKO2ubZaKsHp-kuwWeIK7L_HIgXHuAKzTKhVVQ>
    <xmx:8533afPqW4tOXbDpBrwZgShY5_Z2H_bitakpWWUIgQ0MMD_I1DZPV6XX>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6AE54780070; Sun,  3 May 2026 15:11:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ak5ktnwSWV1c
Date: Sun, 03 May 2026 21:11:27 +0200
From: "Chuck Lever" <cel@kernel.org>
To: "Sagi Grimberg" <sagi@grimberg.me>, "Scott Mayhew" <smayhew@redhat.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 kernel-tls-handshake@lists.linux.dev
Message-Id: <98a865cb-94e3-4f57-8b9e-0634c43098b9@app.fastmail.com>
In-Reply-To: <e55cd958-6d86-4c6b-abc6-5be83fc53b0b@grimberg.me>
References: <fd4aaf4e-b1b7-4ca2-bc93-955c31fab317@grimberg.me>
 <92a53963-1e4b-42eb-af81-6be9f63f9e43@app.fastmail.com>
 <afUKzeUYPhb97DX4@aion>
 <7c6516be-adb9-4d0d-ba7c-fa107fd4a865@app.fastmail.com>
 <e55cd958-6d86-4c6b-abc6-5be83fc53b0b@grimberg.me>
Subject: Re: Breakage in ktls-utils with nfs keyring?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4DC074B712E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21370-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]



On Sun, May 3, 2026, at 9:48 AM, Sagi Grimberg wrote:
> On 02/05/2026 6:08, Chuck Lever wrote:
>>
>> On Fri, May 1, 2026, at 4:19 PM, Scott Mayhew wrote:
>>> On Thu, 30 Apr 2026, Chuck Lever wrote:
>>>
>>>> Cc'ing the ktls-utils development list.
>>>>
>>>> On Thu, Apr 30, 2026, at 9:32 AM, Sagi Grimberg wrote:
>>>>> Hey Chuck,
>>>>>
>>>>> Upstream ktls-utils fails passing client certificate and private k=
ey
>>>>> using the .nfs keyring.
>>>>> Bisecting leads commit facd084e43fc ("tlshd: Client-side dual
>>>>> certificate support").
>>>>>
>>>>> I manually apply this (probably wrong) change and keyring works:
>>>>> --
>>>>> diff --git a/src/tlshd/client.c b/src/tlshd/client.c
>>>>> index 2664ffb..a946797 100644
>>>>> --- a/src/tlshd/client.c
>>>>> +++ b/src/tlshd/client.c
>>>>> @@ -327,7 +327,7 @@ tlshd_x509_retrieve_key_cb(gnutls_session_t se=
ssion,
>>>>>   =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>>>>>   =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tlshd_lo=
g_debug("%s: Selecting x509.certificate from
>>>>> conf file", __func__);
>>>>>   =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *pcert_l=
ength =3D tlshd_certs_len;
>>>>> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*pcert =3D=
 tlshd_certs + tlshd_pq_certs_len;
>>>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*pcert =3D=
 tlshd_certs;
>>>>>   =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *privkey=
 =3D tlshd_privkey;
>>>>>   =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>>>   =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>>>>> --
>>>>>
>>>>> But, I have a feeling its not the correct change...
>>>>
>>>> Scott, can you triage this?
>>> So when I added the dual certificate support, I didn't touch any of =
the
>>> keyring code.  Frankly, I'm not entirely sure what is the right way =
to
>>> set it up and the docs are pretty much nonexistent.  As far as I can
>>> tell:
>>>
>>> - you need to load nfs.ko first so that the .nfs keyring gets created
>>>    via nfs_init_keyring()
>>> - you need to restart tlshd so that it links the .nfs keyring into i=
ts
>>>    session keyring (I tried loading nfs.ko at boot via modules-load.=
d,
>>>    but tlshd still reported an error saying it couldn't find the .nfs
>>>    keyring)
>>> - you need to convert the cert and key to DER format
>>> - you need to add the cert and key to the .nfs keyring, e.g.
>>>
>>>    keyctl padd user "nfs_cert" %:.nfs < smayhew-rawhide.crt.der
>>>    keyctl padd user "nfs_key" %:.nfs < smayhew-rawhide.key.der
>>>
>>> - then you mount w/ '-o xprtsec=3Dmtls,cert_serial=3D...,privkey_ser=
ial=3D...'
>>>
>>> Is that somewhat accurate?
>
> It is.
>
>>>    Is there a better way to do it?
>
> Have a script/automation SW.

Our intention is to have mount.nfs pick up some of this work.

We need a solution that can pick up a different certificate for each
network namespace, for instance. And we want to enable certificate
storage in the system's TPM someday.

And this needs to be made reliable relative to module load order.


>>>   It seems
>>> like a lot more work than just using the config file.
>
> Well in some cases, storing credentials on a persistent file is not a=20
> viable option.
> For nvme there is a userspace utility that helps with this to some ext=
ent.

This is because handling an NVMe PSK in the keyring is a first-class,
supported mechanism. Handling the x.509 certificate this way hasn't
really been thought through.

>> It is more work because keyring support for the NFS consumers is still
>> aspirational/experimental.
>
> Can you elaborate? I think people expect to be able to pass certs/keys=
 to
> tlshd the .nfs keyring. Also I expected it to work (as it used to).

The "cert_serial" and "privkey_serial" mount options are not documented
at all in nfs(5). They are intended to be a way for the mount.nfs command
to pass key serial numbers to the kernel NFS client, not as an
administrative interface. Because, yuck.

This doesn't mean we don't want to support using a keyring for x.509
certificates on NFS mounts. It means the capability isn't finished yet.


>> I've pushed your patch to a "fixes" branch for folks to try out. I'm =
not
>> sure yet whether we want a 1.4.1 release with this fix, since keyring
>> support for NFS is "not finished".
>
> I understand that there are features that are not supported via the
> keyring interface. But I think that users expect things that used to w=
ork to
> continue working. My personal opinion is that releasing this fix is=20
> appropriate
> given that this is a regression.

You are the first user I know of for this capability.

Yes, technically it's a regression, but it's not really a feature that
is supposed to be ready for users at this stage.

You are also building tlshd from scratch rather than using a distro-
packaged version of it. That's rare enough, but it also means you can
apply the patch that fixes the issue and build it yourself.

I'm open to considering a dot-release, but you haven't convinced me yet.


> Is keyring support for NFS marked as "experimental" or "not finished"=20
> anywhere?

Where would we add such a marking? nfs(5) doesn't document either of
those mount options.

Patches and architecture are welcome. As I said, we want this to work
eventually.


--=20
Chuck Lever

