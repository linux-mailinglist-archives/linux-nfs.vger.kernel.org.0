Return-Path: <linux-nfs+bounces-9077-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC237A08651
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 05:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA073A969F
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 04:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AA93FBB3;
	Fri, 10 Jan 2025 04:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b="AkFB6pcG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B966479D0
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 04:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.179.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736484857; cv=none; b=XxyNhShhTeABke2RYMSqxfERw4/SZugrvOU3bf31LiHZeGRkC2OudEexYaqJSIzfskl1TbkqpoiUF19CnQpvGkX3nZ1wbtWMucVRBY2Pe+8NxJQk74zXfMYBh3bhY7X7tle+vuvn9wuBuy+Fq2SUbbRDa6lZXBZHJhx8Ef3UP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736484857; c=relaxed/simple;
	bh=wanZ8I0kzlXnoqfrYx5sW+6XIimnzK8Nb8//LiLttrM=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=L+4kXSiI/btQMsl06lLuVr7ALtp0gmM9+vl65IPuDAipr1bmbPgKMQjxPANJcP7lYUwNRzWkIYOaHCvCmdHnWxFax9jTPjD2hScnG1LxA2vgRutOq3qTQPjickyH6EF84p8175Mjzys2ajZVxZLCkzm9Xie1DS3WsupaEq3eGJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu; spf=pass smtp.mailfrom=cs.ucla.edu; dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b=AkFB6pcG; arc=none smtp.client-ip=131.179.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 94BE53C12385F;
	Thu,  9 Jan 2025 20:46:23 -0800 (PST)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id kzxDfKc70ZnS; Thu,  9 Jan 2025 20:46:23 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 191C43C123868;
	Thu,  9 Jan 2025 20:46:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 191C43C123868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1736484383;
	bh=wanZ8I0kzlXnoqfrYx5sW+6XIimnzK8Nb8//LiLttrM=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=AkFB6pcG+edcwXWltMDDHg/fstwagNhhpi62a0Pqhu059Xtrttv2zKwNqPYXpvLFo
	 o43PYRbqYPojv3suw3I2qbOmE2M/rWVd9GxP6rT96GEfTy81Ef1QNGyPXGdM5gyWQk
	 ZcCDLUcccRAFxiyOKfR6uDYeUZtdAI1MbC8iZW9EITIBXeFMLAmA9CSRa3LiIi5PxE
	 GeNEZxg3d8g9NJYaC+kyguceXZ9ptqgJYg1kuBejCAkL/ba85adnmg8yYd7XuHCksa
	 WhU6TXqSZecWLgeElcdn1rvLO9aMmbKTIJo+56LWkd1nBUfxMLr8yTPpw3NGJvyw9H
	 ucNyaXGPPszTg==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id 8QhAjIIo-JAp; Thu,  9 Jan 2025 20:46:22 -0800 (PST)
Received: from [192.168.254.12] (unknown [47.154.28.214])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id E43853C12385F;
	Thu,  9 Jan 2025 20:46:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------FmtyXVEjiYK4Ph8yAIhOedVG"
Message-ID: <96b0b8f3-4b41-4fce-ad28-c6590d0e557e@cs.ucla.edu>
Date: Thu, 9 Jan 2025 20:46:22 -0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bug#74692: ls -la unexpected output on NFS shares, possibly due
 to listxattr in gnulib
To: =?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigBrady.com>
Cc: 74692@debbugs.gnu.org,
 Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>,
 linux-nfs@vger.kernel.org, Gnulib bugs <bug-gnulib@gnu.org>
References: <CAOLeGd3ubjfb8vKWez0zYuGMGhcET_vsns2HfoKoFK-rStc4SQ@mail.gmail.com>
 <0296d983-8fa3-4ea4-9d77-44c18f91dbe0@cs.ucla.edu>
 <2faafa4a-0eda-4430-a852-a4f7879c23d7@draigBrady.com>
 <081f4f6c-827b-4e45-97d6-87b197460900@cs.ucla.edu>
 <70757094-d4ff-4414-aa8b-557e0227d70b@draigBrady.com>
 <0a479f97-9bf2-4c31-8f73-8692fcabfb49@cs.ucla.edu>
 <301468bd-7b9f-48c5-8670-48379b437931@draigBrady.com>
Content-Language: en-US
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <301468bd-7b9f-48c5-8670-48379b437931@draigBrady.com>

This is a multi-part message in MIME format.
--------------FmtyXVEjiYK4Ph8yAIhOedVG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2025-01-09 05:29, P=C3=A1draig Brady wrote:

> over NFS with unreadable files
> you can GET the security.selinux xattr, but you can't LIST any xattrs:

Ouch again....


> Also there was a change since coreutils v9.5 where we don't call the GE=
T,

Yes, that is for efficiency in the common case where the file has no=20
attributes. In that case, ls (via file_has_aclinfo) needs only one=20
llistxattr call and can skip the other syscalls.


> So perhaps we should also always call lgetxattr("security.selinux"),
> or at least fall back to that upon EACCES from listxattr() ?

The latter sounds better, given the efficiency concerns. Also, come to=20
think of it, E2BIG is in the same category as EACCES.

I installed the attached into Gnulib and propagated it into coreutils;=20
please give it a try.
--------------FmtyXVEjiYK4Ph8yAIhOedVG
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-file-has-acl-port-to-Linux-6.12-NFS-listxattr.patch"
Content-Disposition: attachment;
 filename="0001-file-has-acl-port-to-Linux-6.12-NFS-listxattr.patch"
Content-Transfer-Encoding: base64

RnJvbSA2NGNlMDQ2YzA0NjU2M2JjZTUxZTlhNWVkNGNmMjQyMmVlMzc2YzhiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXVsIEVnZ2VydCA8ZWdnZXJ0QGNzLnVjbGEuZWR1
PgpEYXRlOiBUaHUsIDkgSmFuIDIwMjUgMjA6Mzc6MTMgLTA4MDAKU3ViamVjdDogW1BBVENI
XSBmaWxlLWhhcy1hY2w6IHBvcnQgdG8gTGludXggNi4xMiArIE5GUyBsaXN0eGF0dHIKTUlN
RS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04
CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKCiogbGliL2ZpbGUtaGFzLWFjbC5j
IChnZXRfYWNsaW5mbyk6IFRyeSB0aGUgZ2V0eGF0dHItcmVsYXRlZCBjYWxscwpldmVuIGlm
IFtsXWxpc3R4YXR0ciBmYWlscyB3aXRoIEVBQ0NFUy4gIFByb2JsZW0gcmVwb3J0ZWQgYnkK
UMOhZHJhaWcgQnJhZHkgPGh0dHBzOi8vYnVncy5nbnUub3JnLzc0NjkyIzI1Pi4gIEFsc28s
IHRyZWF0IEUyQklHCmxpa2UgRUFDQ0VTLgotLS0KIENoYW5nZUxvZyAgICAgICAgICB8ICA4
ICsrKysrKysrCiBsaWIvZmlsZS1oYXMtYWNsLmMgfCAxMiArKysrKysrKystLS0KIDIgZmls
ZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9DaGFuZ2VMb2cgYi9DaGFuZ2VMb2cKaW5kZXggYjk2ODFhNzFmMS4uNGNiYmU1MmU4
ZCAxMDA2NDQKLS0tIGEvQ2hhbmdlTG9nCisrKyBiL0NoYW5nZUxvZwpAQCAtMSwzICsxLDEx
IEBACisyMDI1LTAxLTA5ICBQYXVsIEVnZ2VydCAgPGVnZ2VydEBjcy51Y2xhLmVkdT4KKwor
CWZpbGUtaGFzLWFjbDogcG9ydCB0byBMaW51eCA2LjEyICsgTkZTIGxpc3R4YXR0cgorCSog
bGliL2ZpbGUtaGFzLWFjbC5jIChnZXRfYWNsaW5mbyk6IFRyeSB0aGUgZ2V0eGF0dHItcmVs
YXRlZCBjYWxscworCWV2ZW4gaWYgW2xdbGlzdHhhdHRyIGZhaWxzIHdpdGggRUFDQ0VTLiAg
UHJvYmxlbSByZXBvcnRlZCBieQorCVDDoWRyYWlnIEJyYWR5IDxodHRwczovL2J1Z3MuZ251
Lm9yZy83NDY5MiMyNT4uICBBbHNvLCB0cmVhdCBFMkJJRworCWxpa2UgRUFDQ0VTLgorCiAy
MDI1LTAxLTA5ICBCcnVubyBIYWlibGUgIDxicnVub0BjbGlzcC5vcmc+CiAKIAlzeXNfc29j
a2V0LWg6IFVwZGF0ZSBmb3IgUE9TSVg6MjAyNC4KZGlmZiAtLWdpdCBhL2xpYi9maWxlLWhh
cy1hY2wuYyBiL2xpYi9maWxlLWhhcy1hY2wuYwppbmRleCAzNWRjYzE5ZjE2Li41ZWM2YjI1
NmVmIDEwMDY0NAotLS0gYS9saWIvZmlsZS1oYXMtYWNsLmMKKysrIGIvbGliL2ZpbGUtaGFz
LWFjbC5jCkBAIC0xNzYsMTEgKzE3NiwxNyBAQCBnZXRfYWNsaW5mbyAoY2hhciBjb25zdCAq
bmFtZSwgc3RydWN0IGFjbGluZm8gKmFpLCBpbnQgZmxhZ3MpCiAgICAgICAgIH0KICAgICB9
CiAKLSAgaWYgKDAgPCBhaS0+c2l6ZSAmJiBmbGFncyAmIEFDTF9HRVRfU0NPTlRFWFQpCisg
IC8qIEEgc2VjdXJpdHkgY29udGV4dCBjYW4gZXhpc3Qgb25seSBpZiBleHRlbmRlZCBhdHRy
aWJ1dGVzIGRvOiBpLmUuLAorICAgICBbbF1saXN0eGF0dHIgZWl0aGVyIHJldHVybmVkIGEg
cG9zaXRpdmUgbnVtYmVyLCBvciBmYWlsZWQgd2l0aCBFMkJJRywKKyAgICAgb3IgZmFpbGVk
IHdpdGggRUFDQ0VTIHdoaWNoIGluIExpbnV4IGtlcm5lbCA2LjEyIE5GUyBjYW4gbWVhbiBt
ZXJlbHkKKyAgICAgdGhhdCB3ZSBsYWNrIHJlYWQgYWNjZXNzLiAgKi8KKyAgaWYgKGZsYWdz
ICYgQUNMX0dFVF9TQ09OVEVYVAorICAgICAgJiYgKDAgPCBhaS0+c2l6ZQorICAgICAgICAg
IHx8IChhaS0+c2l6ZSA8IDAgJiYgKGFpLT51LmVyciA9PSBFMkJJRyB8fCBhaS0+dS5lcnIg
PT0gRUFDQ0VTKSkpKQogICAgIHsKICAgICAgIGlmIChpc19zbWFja19lbmFibGVkICgpKQog
ICAgICAgICB7Ci0gICAgICAgICAgaWYgKGFjbGluZm9faGFzX3hhdHRyIChhaSwgWEFUVFJf
TkFNRV9TTUFDSykpCisgICAgICAgICAgaWYgKGFpLT5zaXplIDwgMCB8fCBhY2xpbmZvX2hh
c194YXR0ciAoYWksIFhBVFRSX05BTUVfU01BQ0spKQogICAgICAgICAgICAgewogICAgICAg
ICAgICAgICBzc2l6ZV90IHIgPSBzbWFja19uZXdfbGFiZWxfZnJvbV9wYXRoIChuYW1lLCAi
c2VjdXJpdHkuU01BQ0s2NCIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGZsYWdzICYgQUNMX1NZTUxJTktfRk9MTE9XLApAQCAtMTkx
LDcgKzE5Nyw3IEBAIGdldF9hY2xpbmZvIChjaGFyIGNvbnN0ICpuYW1lLCBzdHJ1Y3QgYWNs
aW5mbyAqYWksIGludCBmbGFncykKICAgICAgIGVsc2UKICAgICAgICAgewogIyBpZiBVU0Vf
U0VMSU5VWF9TRUxJTlVYX0gKLSAgICAgICAgICBpZiAoYWNsaW5mb19oYXNfeGF0dHIgKGFp
LCBYQVRUUl9OQU1FX1NFTElOVVgpKQorICAgICAgICAgIGlmIChhaS0+c2l6ZSA8IDAgfHwg
YWNsaW5mb19oYXNfeGF0dHIgKGFpLCBYQVRUUl9OQU1FX1NFTElOVVgpKQogICAgICAgICAg
ICAgewogICAgICAgICAgICAgICBzc2l6ZV90IHIgPQogICAgICAgICAgICAgICAgICgoZmxh
Z3MgJiBBQ0xfU1lNTElOS19GT0xMT1cgPyBnZXRmaWxlY29uIDogbGdldGZpbGVjb24pCi0t
IAoyLjQ1LjIKCg==

--------------FmtyXVEjiYK4Ph8yAIhOedVG--

