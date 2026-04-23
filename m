Return-Path: <linux-nfs+bounces-21054-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLO9Fltb6mnXyQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21054-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 19:48:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CD5455BCB
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 19:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93A8430552A7
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 17:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FF035A3BF;
	Thu, 23 Apr 2026 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="F7keYk36"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF503033DF;
	Thu, 23 Apr 2026 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966204; cv=none; b=Hk/ZDMDuck4rLZ8EyDvWsNSKfDGcoKacG+crEpwIrkC9L1JURBaSVwL2E4HIBysKiQRjUWJU8AVUi9bz8AXUfCH7EKS+5UKp55DHunbg3zqNg8fgcgrWzZQt4OE+AOfvmwO8tZ5XWW4HK2mTsDbP8tUTyWPwcxOdRYLHR11iwv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966204; c=relaxed/simple;
	bh=vkq7YgCeDD1Bfr9M3vrmSOO1AM3+7u/K8BLnBhaW26s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ag9H+bq1dHdyVjeKpzI3JBXSo1ObfWm0HM58OMUbUfp30GYImZtwoRYLI6a2TWy9v3CnsjxSev+d6wd/cCEltPxjCUx8IJGLkqlDdR6aiU1zArqI528sJfdiTKfMB0AGmyLRKSkLXYqCDPgkCZ6+gwR9CHXGuZlwqH7NiTsL2j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=F7keYk36; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:To:Date:Message-ID:CC;
	bh=vkq7YgCeDD1Bfr9M3vrmSOO1AM3+7u/K8BLnBhaW26s=; b=F7keYk369OjmEaXd1AxVnHYYbJ
	cKUd5WB5yhCfsznQ8+W8MWmysFXK2/CECapJZLy4duVOShmjLl6OCzfP0GQGsxe413GUnwh7KcUNr
	HrwrAtb4ibDFmLaRyFtrlbdXa2+TNjXDBMYSfdkFo8SdEAnIZ1ZK4pdhdVKPbuOAhgZCWlFN333sU
	ukBqOjHcn11a72EEsAH2Qr8eNUWihhFN9QwRU6YtZzXGeDYF3rlrSHrBdUXkLQZipPqwN4ZRPOkeG
	taYuqdcAbhBjKW6CqatBIfuHKtD4ZSl7u0nIw3Fz2/xRqJsf1Ldr3Ld8WPjHK1hRGg6taM2QJdqP6
	sAMxlONoDOHTL+Uq07Ye94F2bitaPalqz1P9jgJc+gzvb2nagcUO7qOAO7AvVp+jvjZ+tyLn/5dVy
	RUKrVb2oON+dNRcbfe5OmnZuwi8EpzjUg2UBo7zIx1YVzU5gY1amlrPp1bu5BkLk4XCLEuoTjdGFz
	5tlERVmRq0rt/D/QtN4IIEzA;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wFy53-00000003cgH-44oa;
	Thu, 23 Apr 2026 17:43:14 +0000
Message-ID: <438478a7-c965-4a2a-9c4a-84b5f77d6dbe@samba.org>
Date: Thu, 23 Apr 2026 19:43:13 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "Intent" of VFS lookups
To: Shyam Prasad N <nspmangalore@gmail.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 CIFS <linux-cifs@vger.kernel.org>, linux-nfs@vger.kernel.org
References: <CANT5p=oV8kcE6hXPoUVQAYGaiz+2OERoSRLAS6X+q9KJ_8w8YQ@mail.gmail.com>
From: Ralph Boehme <slow@samba.org>
Content-Language: en-US, de-DE
Autocrypt: addr=slow@samba.org; keydata=
 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
 rb9LanmjmJltdkLDwbd58Q==
In-Reply-To: <CANT5p=oV8kcE6hXPoUVQAYGaiz+2OERoSRLAS6X+q9KJ_8w8YQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------diU7aiJiSXkEUIabePlVv9Sy"
X-Spamd-Result: default: False [-3.16 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21054-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slow@samba.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[samba.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:dkim,samba.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6CD5455BCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------diU7aiJiSXkEUIabePlVv9Sy
Content-Type: multipart/mixed; boundary="------------CF5AvGltTlGTEaELMcV6HInJ";
 protected-headers="v1"
From: Ralph Boehme <slow@samba.org>
To: Shyam Prasad N <nspmangalore@gmail.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 CIFS <linux-cifs@vger.kernel.org>, linux-nfs@vger.kernel.org
Message-ID: <438478a7-c965-4a2a-9c4a-84b5f77d6dbe@samba.org>
Subject: Re: "Intent" of VFS lookups
References: <CANT5p=oV8kcE6hXPoUVQAYGaiz+2OERoSRLAS6X+q9KJ_8w8YQ@mail.gmail.com>
In-Reply-To: <CANT5p=oV8kcE6hXPoUVQAYGaiz+2OERoSRLAS6X+q9KJ_8w8YQ@mail.gmail.com>

--------------CF5AvGltTlGTEaELMcV6HInJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNC8yMy8yNiA3OjAxIFBNLCBTaHlhbSBQcmFzYWQgTiB3cm90ZToNCj4gV2FudGVkIHRv
IHVuZGVyc3RhbmQgaWYgdGhpcyBpcyBhIHByb2JsZW0gZm9yIG90aGVyIGZpbGVzeXN0ZW1z
IG9yIGlmDQo+IGl0IGlzIHNwZWNpZmljIHRvIFNNQiBwcm90b2NvbD8NCj4gU01CMisgcHJv
dG9jb2wgbWFuZGF0ZSB0aGF0IG9wZW4gY2FsbCBzcGVjaWZpZXMgaWYgdGhlIGZpbGUgYmVp
bmcNCj4gb3BlbmVkIGlzIGEgZGlyZWN0b3J5IG9yIG5vdCAocmVndWxhciBmaWxlKS4NCnN1
cmU/IEZyb20gbWVtb3J5ICh0aG91Z2ggdGhlIGxvZ2ljIGhhcyBhbHdheXMga2luZCBvZiBl
c2NhcGVkIG1lKSBpZiANCnlvdSBuZWl0aGVyIHNwZWNpZnkgRklMRV9ESVJFQ1RPUllfRklM
RSBub3IgRklMRV9OT05fRElSRUNUT1JZX0ZJTEUgdGhlIA0Kc2VydmVyIGlzIHN1cHBvc2Vk
IHRvIG9wZW4gdGhlIG9iamVjdCByZWdhcmRsZXNzIG9mIHRoZSB0eXBlLg0K

--------------CF5AvGltTlGTEaELMcV6HInJ--

--------------diU7aiJiSXkEUIabePlVv9Sy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE+uLGCIokJSBRxVnkqh6bcSY5nkYFAmnqWjEFAwAAAAAACgkQqh6bcSY5nkbV
3w//SJ3gtpbUX8Xn3DvIzvWF3DrIIe4Wvk6EDP8NMB9EvVgoAlaZXqtnaJkGS5Uohw+gTHcaae8R
mgiHTh549i6B9hDxRvnCtzV7l4jN5jFHesN/+g9HzCU/mM7VZfZxPyRf832SGUAJa6iQBfzImk38
OX4TngF3ekzeRshVwj24GWydnkz1DM4moRUBHxJwSBQ5zMFVTZHfWT3u1p2JrDI/MaVmZLlYmxjX
Vh07X/KxiuVtws0o0nYtSj/cTtdz/2Sep+BbyPcsDPniFh+76bvjNq6Q2vdtQmJSvMBobzRQ/gj0
Am1Dc6FKTSc98bVKuIE3f4VNxCLesM7Dro7lrJvWS6Bw2ZesOdLpTPy6eeIGeADIPOi/IpOSIHTG
TLDZTMH6z2K+kb6vST31kGBodQ4vOzUDLhI7XAEaMUT9oSyPnYDiDhZtGr3LJ6uU+9urzICW6Osr
p6FqbG2OpDk5a06EZfcQZzqkF4vfdPElFblnHPyigx/pb+BDqWmPEYGBAqJDPE1c5TEgc7CzwWL4
m5F9o2w92OJHyf/7Kmu2QyB+qaDow56dLpAVKozWEjcqa/u45Z+QL+PwvU6iMKuPMB5jYvHSNSfV
/0eU7u3BjuI4hndfm23s8LovCY4iF12STw1R5ad8lSHA4VkP0PBnUhgAx/RJgO9PHKkmVjdca6Sc
bjA=
=BsdN
-----END PGP SIGNATURE-----

--------------diU7aiJiSXkEUIabePlVv9Sy--

