Return-Path: <linux-nfs+bounces-16531-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BA5C6E177
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 11:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9243E34B554
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 10:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DB030F7F7;
	Wed, 19 Nov 2025 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="fhNDsY6a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FC732ABF6
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763549590; cv=none; b=XCFBUpDCinOBVnn3XkyBc+iG161Av8MiH44d9puZwQY5I9i8SWNq8etC/JdAzDtCATXLmb2HoCPSejbo3LgQ9El6M+LOOe4VLD++thNBsW9inv6I9SzbTuQfcV4/NFNiQgYoz7x7sI1cAAgVRw+xnr9iAa5lpsnDl9wWiWaemb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763549590; c=relaxed/simple;
	bh=dmqDtDbjwWcizySRYTOoIpczHEluH8L5o1yE9pUuX5E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=llVIiX1zK0JbMjhtTIRPZS0MjBJCq82zsosOheVaBN+lCrkslyu7R+9GNBRmrOyQJ6Lrn/skqkYRLkRfbAwZKPZj1zCgLHZasnlTEimkToDocy3fu3/oS6XlpLTRDpzxNGba8BjheaUTMG1Z6oxkafp59LwgRCuUky4qHU9yD48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=fail smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=fhNDsY6a; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vastdata.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so10536684a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 02:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1763549586; x=1764154386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tilJZkgbMkkhNf41s546i1YzW5rXA89mky+noauG8bw=;
        b=fhNDsY6aWOYU0kUL4n6kWmCgYagB/kr6DnHS1YpU8A5PDJMySrP5aSiXrM1Vg+xtEb
         88VyMfDvcP3vo62zYClp+ZfJdgM0FNvoZNNwUuTc9Us+i0HohW2i+le57q5qYEvYVqxI
         kAoYeaNVe1qyJjPL1GTInm5dCgcrg+zLYGuvOpwadX7A6tn177DbtTopdIS+T3h4KQWM
         9pBfwy9ggYH2c/So+zH5EHYY2PAEls0Z8fTQuWu9vTWFWahFNckslsFArnIBKShqVvsa
         hzujbt6p65dYslP/rVPF3ulWRbN1MsCT97qibl+OVNiKiNiA0CYgdZWCstA3ZLwE6Jxm
         fV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763549586; x=1764154386;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tilJZkgbMkkhNf41s546i1YzW5rXA89mky+noauG8bw=;
        b=GPjXDFuE2w/0EjxXauNwePZWeLshH81hi+fHvldjZukPn5njCWKopHrJLL39eL8JrM
         OJLRY1xuBDbl5cHDK/h3Th1tXEWGQKJ2mQAeeomceRlBDZAnrnjCjCzSRSmlu31zbAdM
         ZGCTU/2JLVxM0A+tJoxji5sDaHyaxYxm73uVNItIbIBeYKysr/sJWRr61MjE3jdbP0NH
         SwKREym5QvONtaVgJB3tJJo9b9OPlkd1PPgcXfgaXgxRXxOcqy+CdEN79XZp0lFpynsy
         oKimc4ik88UKdPAD0tZepnVToLcHPkfIrsneYi/cmTqfYlAka1VPzapNB5n73KRraqvr
         H8xg==
X-Gm-Message-State: AOJu0YxHSt13REtJ4zw3ato6QWjgW/NV9aYORJ0gqDnIN90nacBUa3C0
	LPl5XLuwAYsfLa7ltR500hM7RmKODvlBhFwGWJJhdbc/7mZFka+WybYgV+9pqcKCfDyDQ7NGUIZ
	8pKPpa9sbfeFbmmWdNt3gFTQlzm9xAP6RNnsEqRPSihZxOSftTlcou8U=
X-Gm-Gg: ASbGncvd6O8j74Sg6FkdKBF2A8NNrhLYBKjqObaVurLVGKqRKAxc1qfOp+sQN6JYQe/
	9Mb+o8VBDjJ4N0DgRYLh+EG1GuctycZmUx5/Hk2upfsuCbPKLedNMInQQACUPZOfdV9P5yvYigv
	4aQYNPXrxi4pykcpGLHIHHRhRVpWEKoKj1rVsWRISb5ldKAMcDvYsK9cmnWdgEFdD6bPS0iGk+/
	H/CdNQi2luhoXwkw679MY18UFIPPzlAY4QgmxAZG+JBXv4NoqtBIsC1hy8UhAb6DK0fMvdqd6Iw
	+Q8j2ZLXXyPnni16
X-Google-Smtp-Source: AGHT+IHZCDKqpUv3Ro6ya996eePV8Zr0MUW38bK8nXvCstBpfdB/6KNK+kTpVFk3jhZPYGo9TO/qBWbRuF57aALLu8w=
X-Received: by 2002:a05:6402:218e:10b0:641:72a8:c91b with SMTP id
 4fb4d7f45d1cf-64350ebe3afmr14763055a12.34.1763549586224; Wed, 19 Nov 2025
 02:53:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Stoler <michael.stoler@vastdata.com>
Date: Wed, 19 Nov 2025 12:52:54 +0200
X-Gm-Features: AWmQ_bmkMjdYgMfzfUn0BXGcPLrMYekRKHUQKH1z595RSI3GZ82CaDSKen-w-js
Message-ID: <CAGztG2BdRW8fy9iF5u0iJmMoXrc2G0NQTt8jwk12Q=Q+e0FaLQ@mail.gmail.com>
Subject: Spurious -EEXIST from NFSv3
To: linux-nfs@vger.kernel.org
Cc: Dan Aloni <dan.aloni@vastdata.com>
Content-Type: multipart/mixed; boundary="000000000000a1be240643f062d8"

--000000000000a1be240643f062d8
Content-Type: multipart/alternative; boundary="000000000000a1be230643f062d6"

--000000000000a1be230643f062d6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

    I=E2=80=99m having an issue with an NFS driver based on Linux 5.15.147.=
 The
function nfs_verifier_is_delegated() spuriously returns true for NFSv3 file
inside nfs_do_lookup_revalidate(). This causes the d_revalidate method to
return true for a removed file, which in turn leads to an -EEXIST error
during exclusive creation of a non-existent file.

    It appears that the root cause is an initialization races or an
uninitialized d_time value. The attached patch resolves the issue, but is
there a more graceful or proper solution?


    Regards,

Michael Stoler

--000000000000a1be230643f062d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">





<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-size-adjust:n=
one;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;line=
-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1"=
 style=3D"font-variant-ligatures:no-common-ligatures">=C2=A0 =C2=A0 I=E2=80=
=99m having an issue with an NFS driver based on Linux 5.15.147. The functi=
on nfs_verifier_is_delegated() spuriously returns true for NFSv3 file insid=
e nfs_do_lookup_revalidate(). This causes the d_revalidate method to return=
 true for a removed file, which in turn leads to an -EEXIST error during ex=
clusive creation of a non-existent file.</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-size-adjust:n=
one;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;line=
-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1"=
 style=3D"font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-=
Apple-converted-space" style=3D"">=C2=A0 =C2=A0 </span>It appears that the =
root cause is an initialization races or an uninitialized d_time value. The=
 attached patch resolves the issue, but is there a more graceful or proper =
solution?</span></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-=
numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norma=
l;font-size-adjust:none;font-kerning:auto;font-feature-settings:normal;font=
-stretch:normal;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><spa=
n class=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures"><=
br></span></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeri=
c:normal;font-variant-east-asian:normal;font-variant-alternates:normal;font=
-size-adjust:none;font-kerning:auto;font-feature-settings:normal;font-stret=
ch:normal;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span clas=
s=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures">=C2=A0 =
=C2=A0 Regards,</span></p><p class=3D"gmail-p1" style=3D"margin:0px;font-va=
riant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates=
:normal;font-size-adjust:none;font-kerning:auto;font-feature-settings:norma=
l;font-stretch:normal;line-height:normal;font-family:Menlo;color:rgb(0,0,0)=
"><span class=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligatu=
res">Michael Stoler</span></p></div>

--000000000000a1be230643f062d6--
--000000000000a1be240643f062d8
Content-Type: application/octet-stream; name="revalidate.patch"
Content-Disposition: attachment; filename="revalidate.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mi5vticw0>
X-Attachment-Id: f_mi5vticw0

ZGlmZiAtLWdpdCBhL2ZzL25mcy9kaXIuYyBiL2ZzL25mcy9kaXIuYwotLS0gYS9mcy9uZnMvZGly
LmMKKysrIGIvZnMvbmZzL2Rpci5jCkBAIC0xNjAyLDcgKzE2MDIsNyBAQCBuZnNfZG9fbG9va3Vw
X3JldmFsaWRhdGUoc3RydWN0IGlub2RlICpkaXIsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSwKIAkJ
Z290byBvdXRfYmFkOwogCX0KIAotCWlmIChuZnNfdmVyaWZpZXJfaXNfZGVsZWdhdGVkKGRlbnRy
eSkpCisJaWYgKG5mc192ZXJpZmllcl9pc19kZWxlZ2F0ZWQoZGVudHJ5KSAmJiBORlNfUFJPVE8o
aW5vZGUpLT52ZXJzaW9uID4gMykKIAkJcmV0dXJuIG5mc19sb29rdXBfcmV2YWxpZGF0ZV9kZWxl
Z2F0ZWQoZGlyLCBkZW50cnksIGlub2RlKTsKIAogCS8qIEZvcmNlIGEgZnVsbCBsb29rIHVwIGlm
ZiB0aGUgcGFyZW50IGRpcmVjdG9yeSBoYXMgY2hhbmdlZCAqLwo=
--000000000000a1be240643f062d8--

