Return-Path: <linux-nfs+bounces-18696-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKoaFfkog2kxigMAu9opvQ
	(envelope-from <linux-nfs+bounces-18696-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 12:09:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CD9E4EC7
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 12:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A64E300EFBA
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 11:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A1B3E8C78;
	Wed,  4 Feb 2026 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="FcFFvJj1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9C63E8C5D
	for <linux-nfs@vger.kernel.org>; Wed,  4 Feb 2026 11:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203358; cv=pass; b=B9Uk2W5gFgrOPZcCL1zZlsF/4JsX5rkH0v2wtT1Xo+CzfUcvXroHgrD1A25FIm/cmK7n32RXgxAFFfBRBQiFAXRxgxUON/X4cFve3XwBZVz1XRJn9SVrANM62KmQKEWe3ekYz7io6OcaXzEedUDpCgxsRDf+RGqZhlgqbd5S81s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203358; c=relaxed/simple;
	bh=h7WyMZU3aPYHDv5fuo7ziDUM7+U5/kHIvqg5dPvwavc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lOjAhozXqEX9585EG5BlsRowt3EhWEs3pl2k0UuZ+nH6QkJBzVb19eyqcgXOPXQvJjGmaMLOt+MQSqrzzpVmS7JsyoZnpvlT3QqJK0eFrKcB0gsIixAqD93mUUob9qHPGDYnYkczOm4d7KdaX2Q3lsTbFuYmZVacfGbwsnnsOns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=FcFFvJj1; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6580dbdb41eso9997073a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 04 Feb 2026 03:09:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770203356; cv=none;
        d=google.com; s=arc-20240605;
        b=FNhMmpA4tjp/wN925B31V8gU+Re/rJ5xsdm3aYEteDoEf3ilQ5fW/gTdOqN78DUaJQ
         HKR0LaU8Bd6CK03uEKfnY18wXsunpMV9ASM0GgtQ0l2HqRfy4gRX7CfGJ7Mp22RSIuZU
         V8CWU32ItAx+OaL5TfWJOy//HLSJuCWWxXvDww2oPHYiiTMuBzP8Jpkc2tLcR7X2XF5W
         WYV6yzqLqa62ckcueGWo1qLIhBDSPVYQ0/jPUWNvLafwvpjP+211t65OESAzHWi6ATAt
         iOVJttAtQkcpjBgQp9UuHEGWaIrt7KdYGWJjcuMWTOdc5MeN+vi7caUkSZvlTnLDV9Y1
         QE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=tgaecH22Ny2L+M9qTaZn/lOjZd8pKk0qHrFwroy3y8k=;
        fh=Mys3y4MwsHRytUQMpdfGBn3oGRYLcLloxNwkFYMYMmg=;
        b=knzEC2BdDoR7ye/etrp2An97Ac8xZwuTaUUcAZG2ugXdau5cnU0JbXZjdQ5EHB8SLb
         /e3u/48qTo8tSsbUpSzYFwJdGuxYvPx1JnJJ4hV8KTZ1DvyCr2wbVGB3kygTsUla0U3T
         sfsAD9xiucofA6P1hKQtHXCWW4kyP09yyUHWxc34ZLi/UOYFsluOnRb8LWl9NU3PAnwx
         ZeXy8Mdm05+fRsYmlhbh7aL3Z79lPcS+W5SLVXMXZxchwtrAOFFVW5COGlAugxJrngR7
         4CKjQHow2wysFzFVfuV7o70NYPgOJ6id3z2Xwiqv6uzprtwZ9T/K4H+1G9Q5DVymTw4S
         IKmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1770203356; x=1770808156; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tgaecH22Ny2L+M9qTaZn/lOjZd8pKk0qHrFwroy3y8k=;
        b=FcFFvJj1tKZerkEeLr3rFCNS5cmzDZKyi90dl/1cPSRekaKDTK/ei8bzHFWBCOb9Nz
         rwR4xKGPBSupb1gxB64vcvbxjuQQF0I1u9Nzp5wxbIExzMefOb15ro5Qa2fAg84xCF+R
         k3X8/7DeqG6Ela/A7UUvOCVylBuD4SfZldvitB6hVC6WVNL9xo4KKqiJcKn/cGlKd2BG
         WR5WkMq6dR82mX1mEqjMuzWGsBJO4LyPHfbRUANYmAC2zfa7m0ap9p28CkcIydwKqLDn
         6tcWJYnJ15bHKqR8uf/lmxzwph4H4r7sJ5Ys/fzub2kN2fIGpN95UUKH/Xj25ap9O2qp
         BvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203356; x=1770808156;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tgaecH22Ny2L+M9qTaZn/lOjZd8pKk0qHrFwroy3y8k=;
        b=nasOjC5KBjz571Ms7O8i+WbSr16VWhzfrSxYvDV2brRPfas+gRJhGyr0qbAtnH2Oh2
         VVqqTnWL5i4idrg+cE5uQ7BLGp/mH3HIqNus0z84eAJ//oO6ftOsOfQqiUpXHiIRBg1T
         sKd2DjyubZMF39ESylmQuovi65bSMcmJXS5VCOxM3qqWB3FxUFCtv7yeHmpCPG/RaUer
         IkH6jHnWtzLM0m2r/+hlliZDZTE2dyVNFJXyo5jMWN8UJJB9tzJzR4vwNMLjpFXr+VRQ
         xf62aU3ist4nHcW0wGUZ6Ne/StgyzcgWRhF/l3qysnBE6wCydBCSokA/SGujyvlDCN3k
         7XSQ==
X-Gm-Message-State: AOJu0Ywm7IYOyFTSKb2WQbTwEhGfwLLLrtmpcPMp+NCYQCLIO6Ow9zrO
	7Em5wrRKtkDQuYvzTUMdlNLr59ZOPuggHt9HMmqm7416miO9SNgp+ZKbbgZPr5xegMiQvb1MmkY
	Ungog2deai3a4xPGvH+jasTHBMeplJ3tfc3klEa2xl0pqt03MMXu7UXE=
X-Gm-Gg: AZuq6aLtTwwcbz9bJgqmHU0/wOheQ4Wo6NYEIGd1WZcb5pYUEfctbvQKgg1ANOU9/mp
	j/RAk0gfj+0VOIxDE/TWxVlAj0U23afCM5FZJXfmC9H4w/iTh/eejMt9aWymbC5op6BGeIgeONp
	cikhEqrkVJVxR/uBoEhDWglWlMmNBEHQR5bgUxkAqjsFle39inXlB8rADB90Z+HDwv0/UtO+7F4
	/qCNnNNGaa4mbfqlBnWwYefOU1agHUqkzeM4PcQ6JXKrq4NOrLSaBZeaTgOIC1Sh3V9BqY=
X-Received: by 2002:a05:6402:210a:b0:649:d81b:7b7e with SMTP id
 4fb4d7f45d1cf-65949ab43dcmr1879529a12.8.1770203355842; Wed, 04 Feb 2026
 03:09:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Stoler <michael.stoler@vastdata.com>
Date: Wed, 4 Feb 2026 13:09:04 +0200
X-Gm-Features: AZwV_Qjr70u1dFFtIcT1McxVsruW3jbQdu967FatnK1TRXacBdLVPxJ1hu5bP8I
Message-ID: <CAGztG2DRZrEVcMnNjDPwKft8c+2M3CSsZ1ZVzXyqn0x17Nnsbg@mail.gmail.com>
Subject: Unnecessary page cache invalidation
To: linux-nfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000034dc8e0649fd9643"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[vastdata.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[vastdata.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18696-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ATTACHMENT(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[vastdata.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.stoler@vastdata.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9CD9E4EC7
X-Rspamd-Action: no action

--00000000000034dc8e0649fd9643
Content-Type: multipart/alternative; boundary="00000000000034dc8d0649fd9641"

--00000000000034dc8d0649fd9641
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

    I=E2=80=99m seeing a performance issue with an NFS driver based on Linu=
x 6.6.
When untar extracts an archive, it sets file attributes and timestamps
after each file is created. As a result, the inodes of these files are
marked as OOO (out-of-order write), which causes valid page cache to be
dropped on subsequent opens.

    This flase OOO tagging occurs during the nfs_setattr() inode method.
The reason is that inode attributes are updated twice: first in the
protocol-version-specific
method nfs*_proc_setattr(), and then again in nfs_setattr() itself via
nfs_refresh_inode(), even though the inode state has already been updated
by nfs_update_inode() in protocol-version-specific method. As a result,
nfs_refresh_inode() falsely detects the second attempt to apply the same
file attributes as an out-of-order operation and marks the inode with an
OOO range.

    The proposed patch resolves this issue by eliminating the second inode
attribute update in nfs_refresh_inode() when the inode has already been
updated.


Regards,

    Michael Stoler

--00000000000034dc8d0649fd9641
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">





<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-size-adjust:n=
one;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;line=
-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1"=
 style=3D"font-variant-ligatures:no-common-ligatures">=C2=A0 =C2=A0 I=E2=80=
=99m seeing a performance issue with an NFS driver based on Linux 6.6. When=
 untar extracts an archive, it sets file attributes and timestamps after ea=
ch file is created. As a result, the inodes of these files are marked as OO=
O (out-of-order write), which causes valid page cache to be dropped on subs=
equent opens.</span></p><p class=3D"gmail-p1" style=3D"margin:0px;font-vari=
ant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:n=
ormal;font-size-adjust:none;font-kerning:auto;font-feature-settings:normal;=
font-stretch:normal;line-height:normal;font-family:Menlo;color:rgb(0,0,0)">=
<span class=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligature=
s">=C2=A0 =C2=A0 This flase OOO tagging occurs during the nfs_setattr() ino=
de method. The reason is that inode attributes are updated twice: first in =
the </span><span class=3D"gmail-s2" style=3D"font-variant-ligatures:no-comm=
on-ligatures;background-color:rgb(224,228,9)">protocol</span><span class=3D=
"gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures">-version-sp=
ecific method nfs*_proc_setattr(), and then again in nfs_setattr() itself v=
ia nfs_refresh_inode(), even though the inode state has already been update=
d by nfs_update_inode() in </span><span class=3D"gmail-s2" style=3D"font-va=
riant-ligatures:no-common-ligatures;background-color:rgb(224,228,9)">protoc=
ol</span><span class=3D"gmail-s1" style=3D"font-variant-ligatures:no-common=
-ligatures">-version-specific method. As a result, nfs_refresh_inode() fals=
ely detects the second attempt to apply the same file attributes as an out-=
of-order operation and marks the inode with an OOO range.</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-size-adjust:n=
one;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;line=
-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1"=
 style=3D"font-variant-ligatures:no-common-ligatures">=C2=A0 =C2=A0 The pro=
posed patch resolves this issue by eliminating the second inode attribute u=
pdate in nfs_refresh_inode() when the inode has already been updated.</span=
></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;=
font-variant-east-asian:normal;font-variant-alternates:normal;font-size-adj=
ust:none;font-kerning:auto;font-feature-settings:normal;font-stretch:normal=
;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmai=
l-s1" style=3D"font-variant-ligatures:no-common-ligatures"><br></span></p><=
p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:n=
ormal;font-variant-alternates:normal;font-size-adjust:none;font-kerning:aut=
o;font-feature-settings:normal;font-stretch:normal;line-height:normal;font-=
family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-com=
mon-ligatures">Regards,</span></p><p class=3D"gmail-p1" style=3D"margin:0px=
;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-al=
ternates:normal;font-size-adjust:none;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;line-height:normal;font-family:Menlo;color:rg=
b(0,0,0)"><span class=3D"gmail-s1" style=3D"font-variant-ligatures:no-commo=
n-ligatures"></span></p><p style=3D"margin:0px;font-variant-numeric:normal;=
font-variant-east-asian:normal;font-variant-alternates:normal;font-size-adj=
ust:none;font-kerning:auto;font-feature-settings:normal;font-stretch:normal=
;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font=
-variant-ligatures:no-common-ligatures">=C2=A0 =C2=A0 Michael Stoler</span>=
</p><p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-as=
ian:normal;font-variant-alternates:normal;font-size-adjust:none;font-kernin=
g:auto;font-feature-settings:normal;font-stretch:normal;line-height:normal;=
font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:n=
o-common-ligatures"><br></span></p></div>

--00000000000034dc8d0649fd9641--
--00000000000034dc8e0649fd9643
Content-Type: application/octet-stream; name="nfs-463.patch"
Content-Disposition: attachment; filename="nfs-463.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ml7xcvzu0>
X-Attachment-Id: f_ml7xcvzu0

Y29tbWl0IGY2YTU3MWEzYTkzMWRiYWNkZmEyNDc0MGI2ZDBkZDlkNjBlZTVkMTMKQXV0aG9yOiBN
aWNoYWVsIFN0b2xlciA8bWljaGFlbC5zdG9sZXJAdmFzdGRhdGEuY29tPgpEYXRlOiAgIFRodSBK
YW4gMSAxMDozNjo0NiAyMDI2ICswMDAwCgogICAgbmZzOiBhdm9pZCB0cmlnZ2VyaW5nIG91dC1v
Zi1vcmRlciB3cml0ZSBoYW5kbGluZyBpbiBuZnNfc2V0YXR0cigpCiAgICAKICAgIFRoZSBjdXJy
ZW50IE5GUyBpbXBsZW1lbnRhdGlvbiBhdHRlbXB0cyB0byB1cGRhdGUgaW5vZGUgcHJvcGVydGll
cyB0d2ljZSB3aGVuCiAgICBuZnNfc2V0YXR0cigpIGlzIGNhbGxlZCBmb3IgYW4gTkZTIGlub2Rl
LiBGaXJzdCwgaW5vZGUgcHJvcGVydGllcyBhcmUKICAgIHVuY29uZGl0aW9uYWxseSB1cGRhdGVk
IGJ5IG5mc191cGRhdGVfaW5vZGUoKSBkdXJpbmcgdGhlIGludm9jYXRpb24gb2YgdGhlIE5GUwog
ICAgcHJvdG9jb2zigJN2ZXJzaW9u4oCTc3BlY2lmaWMgbWV0aG9kIG5mcypfcHJvY19zZXRhdHRy
KCksIHdoaWNoIGludGVybmFsbHkgY2FsbHMKICAgIG5mc19zZXRhdHRyX3VwZGF0ZV9pbm9kZSgp
LgogICAgCiAgICBUaGUgc2Vjb25kIGF0dGVtcHQgb2NjdXJzIGF0IHRoZSBlbmQgb2YgbmZzX3Nl
dGF0dHIoKSwgd2hlbiBuZnNfcmVmcmVzaF9pbm9kZSgpCiAgICBpcyBpbnZva2VkLiBUaGlzIGNh
bGwgY29uZGl0aW9uYWxseSB0cmlnZ2VycyBuZnNfdXBkYXRlX2lub2RlKCkgYWZ0ZXIgY2hlY2tp
bmcKICAgIHRoZSB1cGRhdGUgb3JkZXJpbmcuIEhvd2V2ZXIsIHNpbmNlIHRoZSBpbm9kZSBwcm9w
ZXJ0aWVzIGhhdmUgYWxyZWFkeSBiZWVuCiAgICB1cGRhdGVkIGR1cmluZyB0aGUgZmlyc3QgYXR0
ZW1wdCwgdGhpcyBzZWNvbmQgdXBkYXRlIHNlcnZlcyBvbmx5IHRvIGNoZWNrIHRoZQogICAgZXJy
b3Igc3RhdGUoLUVTVEFMRSkuCiAgICAKICAgIFRoaXMgYXBwcm9hY2ggd2FzIGFkZXF1YXRlIHVu
dGlsIHRoZSBpbnRyb2R1Y3Rpb24gb2Yg4oCcTkZTdjM6IGhhbmRsZSBvdXQtb2Ytb3JkZXIKICAg
IHdyaXRlIHJlcGxpZXPigJ0gKHVwc3RyZWFtIGNvbW1pdCAzZGI2M2RhYWJlMjEwKS4gVGhlIGxh
dHRlciBjb2xsZWN0cyBvdXQtb2Ytb3JkZXIKICAgIGRhdGEgaW4gbmZzX3JlZnJlc2hfaW5vZGUo
KSBpbnZvY2F0aW9uIC4gQXMgYSByZXN1bHQsIG5mc19zZXRhdHRyKCkgbWF5CiAgICBpbmFkdmVy
dGVudGx5IHN3aWNoIG9uIHRoZSBvdXQtb2Ytb3JkZXIgc3RhdGUgaW4gbmZzX3JlZnJlc2hfaW5v
ZGUoKSBpbnZvY2F0aW9uLAogICAgd2hpY2ggdHJpZ2dlcnMgYW4gaW5vZGUncyBwYWdlLWNhY2hl
IGludmFsaWRhdGlvbiBhbmQgc3Vic2VxdWVudGx5IGRlZ3JhZGVzIHJlYWQKICAgIHBlcmZvcm1h
bmNlLgogICAgCiAgICBUaGlzIHBhdGNoIHNpbXBsaWZpZXMgaW5vZGUgYXR0cmlidXRlIHVwZGF0
ZXMgaW4gbmZzX3NldGF0dHIoKSBieSBtZXJnaW5nIHRoZQogICAgdHdvIHByZXZpb3VzbHkgZGVz
Y3JpYmVkIHN0YWdlcyBpbnRvIGEgc2luZ2xlIGNhbGwgdG8gbmZzX3NldGF0dHJfdXBkYXRlX2lu
b2RlKCkuCiAgICBUaGlzIGVsaW1pbmF0ZXMgaW5jb3JyZWN0IG91dC1vZi1vcmRlciBkZXRlY3Rp
b24gYW5kIHRoZSByZXN1bHRpbmcgcmVhZAogICAgcGVyZm9ybWFuY2UgZGVncmFkYXRpb24uCiAg
ICAKZGlmZiAtLWdpdCBhL2ZzL25mcy9pbm9kZS5jIGIvZnMvbmZzL2lub2RlLmMKaW5kZXggNzZj
YzBlZjU5Li5iMjY2YThkNzMgMTAwNjQ0Ci0tLSBhL2ZzL25mcy9pbm9kZS5jCisrKyBiL2ZzL25m
cy9pbm9kZS5jCkBAIC04NDgsOCArODQ4LDYgQEAgbmZzX3NldGF0dHIoQ09NUEFUX1NUUlVDVF9N
TlRfSURNQVAgKmlkbWFwLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnksCiAJfQogCiAJZXJyb3IgPSBO
RlNfUFJPVE8oaW5vZGUpLT5zZXRhdHRyKGRlbnRyeSwgZmF0dHIsIGF0dHIpOwotCWlmIChlcnJv
ciA9PSAwKQotCQllcnJvciA9IG5mc19yZWZyZXNoX2lub2RlKGlub2RlLCBmYXR0cik7CiAJbmZz
X2ZyZWVfZmF0dHIoZmF0dHIpOwogb3V0OgogCXRyYWNlX25mc19zZXRhdHRyX2V4aXQoaW5vZGUs
IGVycm9yKTsKQEAgLTkwMSw5ICs4OTksMTEgQEAgb3V0OgogICogTm90ZTogd2UgZG8gdGhpcyBp
biB0aGUgKnByb2MuYyBpbiBvcmRlciB0byBlbnN1cmUgdGhhdAogICogICAgICAgaXQgd29ya3Mg
Zm9yIHRoaW5ncyBsaWtlIGV4Y2x1c2l2ZSBjcmVhdGVzIHRvby4KICAqLwotdm9pZCBuZnNfc2V0
YXR0cl91cGRhdGVfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGlhdHRyICphdHRy
LAoraW50IG5mc19zZXRhdHRyX3VwZGF0ZV9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1
Y3QgaWF0dHIgKmF0dHIsCiAJCXN0cnVjdCBuZnNfZmF0dHIgKmZhdHRyKQogeworCWludCByZXQg
PSAwOworCiAJLyogQmFycmllcjogYnVtcCB0aGUgYXR0cmlidXRlIGdlbmVyYXRpb24gY291bnQu
ICovCiAJbmZzX2ZhdHRyX3NldF9iYXJyaWVyKGZhdHRyKTsKIApAQCAtOTczLDggKzk3MywxMCBA
QCB2b2lkIG5mc19zZXRhdHRyX3VwZGF0ZV9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1
Y3QgaWF0dHIgKmF0dHIsCiAJCQkJCXwgTkZTX0lOT19JTlZBTElEX0NUSU1FKTsKIAl9CiAJaWYg
KGZhdHRyLT52YWxpZCkKLQkJbmZzX3VwZGF0ZV9pbm9kZShpbm9kZSwgZmF0dHIpOworCQlyZXQg
PSBuZnNfdXBkYXRlX2lub2RlKGlub2RlLCBmYXR0cik7CiAJc3Bpbl91bmxvY2soJmlub2RlLT5p
X2xvY2spOworCisJcmV0dXJuIHJldDsKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKG5mc19zZXRhdHRy
X3VwZGF0ZV9pbm9kZSk7CiAKZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnMzcHJvYy5jIGIvZnMvbmZz
L25mczNwcm9jLmMKaW5kZXggMjlhMDA0OTc1Li4xZWJjMTFjMjAgMTAwNjQ0Ci0tLSBhL2ZzL25m
cy9uZnMzcHJvYy5jCisrKyBiL2ZzL25mcy9uZnMzcHJvYy5jCkBAIC0xNTMsNyArMTUzLDcgQEAg
bmZzM19wcm9jX3NldGF0dHIoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBzdHJ1Y3QgbmZzX2ZhdHRy
ICpmYXR0ciwKIAlzdGF0dXMgPSBuZnMzX3JwY19jYWxsX3N5bmNfbXVsdGlwYXRoKE5GU19DTElF
TlQoaW5vZGUpLCAmbXNnLCAwLAogCQkJCQkgICAgICBORlNfRkhfSEFTSF9JTk9ERShpbm9kZSks
IHt9KTsKIAlpZiAoc3RhdHVzID09IDApIHsKLQkJbmZzX3NldGF0dHJfdXBkYXRlX2lub2RlKGlu
b2RlLCBzYXR0ciwgZmF0dHIpOworCQlzdGF0dXMgPSBuZnNfc2V0YXR0cl91cGRhdGVfaW5vZGUo
aW5vZGUsIHNhdHRyLCBmYXR0cik7CiAJCWlmIChORlNfSShpbm9kZSktPmNhY2hlX3ZhbGlkaXR5
ICYgTkZTX0lOT19JTlZBTElEX0FDTCkKIAkJCW5mc196YXBfYWNsX2NhY2hlKGlub2RlKTsKIAl9
CmRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNHByb2MuYyBiL2ZzL25mcy9uZnM0cHJvYy5jCmluZGV4
IDUzN2UyZWJiNi4uN2NmZTU2OTQ1IDEwMDY0NAotLS0gYS9mcy9uZnMvbmZzNHByb2MuYworKysg
Yi9mcy9uZnMvbmZzNHByb2MuYwpAQCAtNDU2Niw3ICs0NTY2LDcgQEAgbmZzNF9wcm9jX3NldGF0
dHIoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBzdHJ1Y3QgbmZzX2ZhdHRyICpmYXR0ciwKIAogCXN0
YXR1cyA9IG5mczRfZG9fc2V0YXR0cihpbm9kZSwgY3JlZCwgZmF0dHIsIHNhdHRyLCBjdHgsIE5V
TEwpOwogCWlmIChzdGF0dXMgPT0gMCkgewotCQluZnNfc2V0YXR0cl91cGRhdGVfaW5vZGUoaW5v
ZGUsIHNhdHRyLCBmYXR0cik7CisJCXN0YXR1cyA9IG5mc19zZXRhdHRyX3VwZGF0ZV9pbm9kZShp
bm9kZSwgc2F0dHIsIGZhdHRyKTsKIAkJbmZzX3NldHNlY3VyaXR5KGlub2RlLCBmYXR0cik7CiAJ
fQogCXJldHVybiBzdGF0dXM7CmRpZmYgLS1naXQgYS9mcy9uZnMvcHJvYy5jIGIvZnMvbmZzL3By
b2MuYwppbmRleCA5NmUxOTgyYzEuLmRlODRhMTdlMSAxMDA2NDQKLS0tIGEvZnMvbmZzL3Byb2Mu
YworKysgYi9mcy9uZnMvcHJvYy5jCkBAIC0xNDcsNyArMTQ3LDcgQEAgbmZzX3Byb2Nfc2V0YXR0
cihzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIHN0cnVjdCBuZnNfZmF0dHIgKmZhdHRyLAogCW5mc19m
YXR0cl9pbml0KGZhdHRyKTsKIAlzdGF0dXMgPSBycGNfY2FsbF9zeW5jKE5GU19DTElFTlQoaW5v
ZGUpLCAmbXNnLCAwLCB7fSk7CiAJaWYgKHN0YXR1cyA9PSAwKQotCQluZnNfc2V0YXR0cl91cGRh
dGVfaW5vZGUoaW5vZGUsIHNhdHRyLCBmYXR0cik7CisJCXN0YXR1cyA9IG5mc19zZXRhdHRyX3Vw
ZGF0ZV9pbm9kZShpbm9kZSwgc2F0dHIsIGZhdHRyKTsKIAlkcHJpbnRrKCJORlMgcmVwbHkgc2V0
YXR0cjogJWRcbiIsIHN0YXR1cyk7CiAJcmV0dXJuIHN0YXR1czsKIH0KZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvbmZzX2ZzLmggYi9pbmNsdWRlL2xpbnV4L25mc19mcy5oCmluZGV4IDNhN2Yy
YjI1Zi4uNGI0NDdkOWI5IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L25mc19mcy5oCisrKyBi
L2luY2x1ZGUvbGludXgvbmZzX2ZzLmgKQEAgLTQ1Myw3ICs0NTMsNyBAQCBleHRlcm4gYm9vbCBu
ZnNfbWFwcGluZ19uZWVkX3JldmFsaWRhdGVfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSk7CiBl
eHRlcm4gaW50IG5mc19yZXZhbGlkYXRlX21hcHBpbmcoc3RydWN0IGlub2RlICppbm9kZSwgc3Ry
dWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcpOwogZXh0ZXJuIGludCBuZnNfcmV2YWxpZGF0ZV9t
YXBwaW5nX3JjdShzdHJ1Y3QgaW5vZGUgKmlub2RlKTsKIGV4dGVybiBpbnQgbmZzX3NldGF0dHIo
c3RydWN0IG1udF9pZG1hcCAqLCBzdHJ1Y3QgZGVudHJ5ICosIHN0cnVjdCBpYXR0ciAqKTsKLWV4
dGVybiB2b2lkIG5mc19zZXRhdHRyX3VwZGF0ZV9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBz
dHJ1Y3QgaWF0dHIgKmF0dHIsIHN0cnVjdCBuZnNfZmF0dHIgKik7CitleHRlcm4gaW50IG5mc19z
ZXRhdHRyX3VwZGF0ZV9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgaWF0dHIgKmF0
dHIsIHN0cnVjdCBuZnNfZmF0dHIgKik7CiBleHRlcm4gdm9pZCBuZnNfc2V0c2VjdXJpdHkoc3Ry
dWN0IGlub2RlICppbm9kZSwgc3RydWN0IG5mc19mYXR0ciAqZmF0dHIpOwogZXh0ZXJuIHN0cnVj
dCBuZnNfb3Blbl9jb250ZXh0ICpnZXRfbmZzX29wZW5fY29udGV4dChzdHJ1Y3QgbmZzX29wZW5f
Y29udGV4dCAqY3R4KTsKIGV4dGVybiB2b2lkIHB1dF9uZnNfb3Blbl9jb250ZXh0KHN0cnVjdCBu
ZnNfb3Blbl9jb250ZXh0ICpjdHgpOwo=
--00000000000034dc8e0649fd9643--

