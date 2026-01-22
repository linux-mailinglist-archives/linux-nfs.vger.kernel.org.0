Return-Path: <linux-nfs+bounces-18285-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKzmBxEQcmksawAAu9opvQ
	(envelope-from <linux-nfs+bounces-18285-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 12:54:57 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C75486642F
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 12:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6EDBD6AC549
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 11:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2453D350A16;
	Thu, 22 Jan 2026 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/vxHXQo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaIxM2z8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF41232ABC2
	for <linux-nfs@vger.kernel.org>; Thu, 22 Jan 2026 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082013; cv=pass; b=U+jeWlbqjtoJqTbGXbYGN6g4+dTLLnETZZrKbXkFqgJn4nNZuMAfbBvDtKpOmwrziNHh6tMcTJ2W3gxh1BeCokEr2U9nYKsMfs6NGt7MjU2MnpZnx7yFbF7kUFjngea7x2U2Ai/cXSaLtARsI/w/cdkJMTAbaYlonx+xIrZGN5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082013; c=relaxed/simple;
	bh=7nh+IiJKNSXBc5R5+FYF95YeudgFAHMqQvCHy/wJqyM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DlEGBDjTBQiXQ62I+1CPLNIAyvSS08PRSUFdjfQ28s7CH8SqRoPT6O0kJJq863hEfmhuUVHRbx0sK3kyvhFWSnelhvIj7TSw61hXNAtgbTXuOu8TB35oqlQ3iM+U4Wvk0RKP4H3h1FOPsP/MnmcsuUFgGBIDc7NZYAsVMLun/JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P/vxHXQo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaIxM2z8; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769082008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=7MwNfME23czUiYvxkWZ1isZajN24xKcF+NCI+R9gLiE=;
	b=P/vxHXQoGyIht4aqI3j2zAka1bAcrzY3SP4mQz391d1WOTzoXtL4NhWE21Zc1tt2wpHjx0
	sL7oqj+rQHLDEu/MD1L7YHTqCEZYWGLrEacNDiit1jcCA5n/Tz4WfLfJK4ypxGaEvnpbmO
	sLzowt6R5kDecU4IHh6IOk5TMS3nKIk=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-nxHChWgtNVW1dhZSwuqkww-1; Thu, 22 Jan 2026 06:40:06 -0500
X-MC-Unique: nxHChWgtNVW1dhZSwuqkww-1
X-Mimecast-MFC-AGG-ID: nxHChWgtNVW1dhZSwuqkww_1769082006
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5f5337e9fc9so652323137.2
        for <linux-nfs@vger.kernel.org>; Thu, 22 Jan 2026 03:40:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769082006; cv=none;
        d=google.com; s=arc-20240605;
        b=LTcyQt75y7Qo0TJC3AGmbDqY1oCDUh9UoOjgvLLZIpEvOeppvMSEQeYsN/g7McQpWk
         Vtjlc6rL//CmLbxyqZl2AOYOcq2iFlfBBHsMHPWp4rrw7XtEudfsPkfWVpf0nqoIYZt6
         SUD/F64UMwlzoWNK5vpIkqv5hiwWSQaOZGALIuemwPuDyuRwGGcW/qXMtrqmE8YUgrG7
         /tMeutvMosdaDwjYPUbMh1p4uDTzUwomoDb6ly0ZVbEJBOOCrehgtq+QpVsrczinlnBV
         o4uBm5Zot6zfS0vzqn+hJbvRFXC8E8Ysety8jwb5oh/YHTaeEUxGrd4Z4nMzbnUc0E1F
         qoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=7MwNfME23czUiYvxkWZ1isZajN24xKcF+NCI+R9gLiE=;
        fh=E/FXhmUauEGefm5R+oU9bYmTxswclnb8UjR8wmV9z8I=;
        b=lTe8G4TugI7CoGlZgG6ti3Z4De5JUSxvpicUL48WEXOfLAY11yn8yNAxr2Gvn55QHI
         jnGEaxQPSDqjo/8GSBAk3aX1yfRBIFRCmtwMTT73p/QkyL+owTekn6m2Nv6+xGif7Pxd
         ryaL1lcjCUwAq7SINEGTSxg9fDXo5dv6IZ3MLFEkMEqESL8+JuDYIa6u5QGY6hq5C/RL
         qeyw/OIQghqHhksm/b10PDOUomVeBggOUB87bXwqtn7HQRcmxWtv0rjFjL+Tkzo5W5YK
         +xYO+Fg7pd4dL2z9mhmlN9vr2a69Mc+mX2GniJJ44lKMgmqOK8OVWE0PnMqtqwO9O6l+
         0mPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769082006; x=1769686806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7MwNfME23czUiYvxkWZ1isZajN24xKcF+NCI+R9gLiE=;
        b=FaIxM2z82dajGLsVGFw6NRFVkOelZt1nv8yRO9BM2iEMEeQkvfA3R3/00YXMSDvf5o
         LMnSgcuOd5DOCfQ7dLly+DE0Pf75ggSkx2nTfOpKxH8i9/ptKBOlgRRFXmA8AL4Yv3W6
         XQ/sgsKAHnIHa0vte5xwmhlJNtiaW5rTQfBRxcMqsKEgbEbZ70imDIIJpXbIU9lvaY51
         NzYLjtF4WHqMItl6ctqAL0FJt8fCSWhC4w22cZI9//U+vRAXlUV/cJQvHRfy8KZ22wLd
         O6bciD03jjGF2SymlwT+yBOLcWbo1YxhyCJo+YbqFndQ/xNs95/AbAMZFE3xqP/JI7xw
         jHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769082006; x=1769686806;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MwNfME23czUiYvxkWZ1isZajN24xKcF+NCI+R9gLiE=;
        b=hOX5VUcruKto8LG5YQLPen5lgkESGx1kL5P4OP/tPB7ftqCJVaKF/O4T6xJtpF8Pt4
         8rWxWJUsnZ0bA+Mw7R+KmGWLpU+u90K9QwToXixpf7xvfSI0QnoJ/1fQzGqZLxHKeq8F
         gObt2f6dq5jt10wVHEkbtSmxO1BCKCoH1T+69piQZjtyaeZgMSYBhJzOMffJ5ngjfm0B
         NvG0yTYlK23QaaubzyZ+whJBiKzERRveeiZUkZnYzQgNpWcwPEczIcdFxUnIbInZxSFZ
         9+xag5nXusZ43Gfs3Wnc/Eu1OUv4bEDtHlthreT5L95ko3ocSIgRP5s6kjlJ1rHakYkh
         KZKg==
X-Gm-Message-State: AOJu0Yw9M+zGazu/y/SEsMjAuGS2zkNv0ABOltYI09MWXvwsVVsSvcen
	kkCo8SMXK4JKSxiz+OHP7AJFJgmSZi2/ksA7MrXfDUqLYlyhBBBSVmKm9lLZa5mZFL9W+357ouP
	I/cVEsEedeYuIMrXUSZ8FrgGtCjhYiXU/rAmmtqr8dqMTgkVTg0rSMLuAUsIWHQwsYV/yNuaLwE
	26gHU+IlkbSm0Y7XHZQEes2Ab8h18w9JhKuf2Q
X-Gm-Gg: AZuq6aIp8U4n9YJ+j64aFkp2DthJANC3l/butxDDfQacrQoykUojoFvZ3c1F6EOkL4Z
	0Z6uoKkwD5cWp8xiGmuwq7VaTFIayVEtbBCwn3qtxrRtSFReoqEfv/ZQVCr7DbxfUR/5XEK6Ahj
	oCqme6yDbE4/SkEpCj2SeH6nPmTtt2HAvhXrpr/V0vv776+azo04uDGmGkoj8Se19p
X-Received: by 2002:a05:6102:cc6:b0:5db:20ea:2329 with SMTP id ada2fe7eead31-5f1a55a32demr6162673137.35.1769082005875;
        Thu, 22 Jan 2026 03:40:05 -0800 (PST)
X-Received: by 2002:a05:6102:cc6:b0:5db:20ea:2329 with SMTP id
 ada2fe7eead31-5f1a55a32demr6162668137.35.1769082005477; Thu, 22 Jan 2026
 03:40:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Animesh Javali <ajavali@redhat.com>
Date: Thu, 22 Jan 2026 17:09:54 +0530
X-Gm-Features: AZwV_QgqQKItXHlsXCpfXjOp5z1iqAb015HOzt1YR0NOVmCnMCFvLMMMfIJXb-Q
Message-ID: <CAHPU9Sizox_r6-jSa8ik90f4q6itBo-3M3TopdGVmFymKJPUaA@mail.gmail.com>
Subject: Allow NAMETOOLONG along with REQ_TOO_BIG in SEQ6
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008410770648f88033"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	HAS_ATTACHMENT(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18285-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ajavali@redhat.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C75486642F
X-Rspamd-Action: no action

--0000000000008410770648f88033
Content-Type: multipart/alternative; boundary="0000000000008410750648f88031"

--0000000000008410750648f88031
Content-Type: text/plain; charset="UTF-8"

Hi Calum,

Attaching the patch for the fix and the adjusted FIXME comment.

Description:
Ganesha returns NFS4ERR_NAMETOOLONG when a single
pathname component exceeds MAXNAMLEN.
RFC 5661 allows name-length validation to occur
before request-size checks, so this behavior is
RFC-compliant.

Updated the SEQ6 test to accept both
NFS4ERR_REQ_TOO_BIG and NFS4ERR_NAMETOOLONG as valid responses.


Best wishes
Animesh

--0000000000008410750648f88031
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Calum,</div><div><br></div><div>Attaching the patc=
h for the fix and the adjusted FIXME comment.</div><div><br></div><div>Desc=
ription:</div><div>Ganesha returns NFS4ERR_NAMETOOLONG when a single<br>pat=
hname component exceeds MAXNAMLEN.<br>RFC 5661 allows name-length validatio=
n to occur<br>before request-size checks, so this behavior is<br>RFC-compli=
ant.<br><br>Updated the SEQ6 test to accept both<br>NFS4ERR_REQ_TOO_BIG and=
 NFS4ERR_NAMETOOLONG as valid responses.<br><br></div><div><br></div><div>B=
est wishes</div><div>Animesh</div></div>

--0000000000008410750648f88031--
--0000000000008410770648f88033
Content-Type: application/octet-stream; 
	name="0001-Allow-NAMETOOLONG-along-with-REQ_TOO_BIG-in-SEQ6.patch"
Content-Disposition: attachment; 
	filename="0001-Allow-NAMETOOLONG-along-with-REQ_TOO_BIG-in-SEQ6.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mkpdpz8k0>
X-Attachment-Id: f_mkpdpz8k0

RnJvbSBkYjEwOTY4MDgyYmFhZDg2ZjBjYzA0ZGI5NWRjMDY0Yjk2ZWNkOTExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmltZXNoIEphdmFsaSA8QW5pbWVzaC5KYXZhbGlAaWJtLmNv
bT4KRGF0ZTogV2VkLCAyMSBKYW4gMjAyNiAwMzowMDozMyAtMDUwMApTdWJqZWN0OiBbUEFUQ0hd
IEFsbG93IE5BTUVUT09MT05HIGFsb25nIHdpdGggUkVRX1RPT19CSUcgaW4gU0VRNgoKR2FuZXNo
YSByZXR1cm5zIE5GUzRFUlJfTkFNRVRPT0xPTkcgd2hlbiBhIHNpbmdsZQpwYXRobmFtZSBjb21w
b25lbnQgZXhjZWVkcyBNQVhOQU1MRU4uClJGQyA1NjYxIGFsbG93cyBuYW1lLWxlbmd0aCB2YWxp
ZGF0aW9uIHRvIG9jY3VyCmJlZm9yZSByZXF1ZXN0LXNpemUgY2hlY2tzLCBzbyB0aGlzIGJlaGF2
aW9yIGlzClJGQy1jb21wbGlhbnQuCgpVcGRhdGUgdGhlIFNFUTYgdGVzdCB0byBhY2NlcHQgYm90
aApORlM0RVJSX1JFUV9UT09fQklHIGFuZCBORlM0RVJSX05BTUVUT09MT05HCmFzIHZhbGlkIHJl
c3BvbnNlcy4KClNpZ25lZC1vZmYtYnk6IEFuaW1lc2ggSmF2YWxpIDxBbmltZXNoLkphdmFsaUBp
Ym0uY29tPgotLS0KIG5mczQuMS9zZXJ2ZXI0MXRlc3RzL3N0X3NlcXVlbmNlLnB5IHwgNCArKy0t
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL25mczQuMS9zZXJ2ZXI0MXRlc3RzL3N0X3NlcXVlbmNlLnB5IGIvbmZzNC4xL3NlcnZl
cjQxdGVzdHMvc3Rfc2VxdWVuY2UucHkKaW5kZXggOWJlMTA5Ni4uNmMzMDZiMSAxMDA2NDQKLS0t
IGEvbmZzNC4xL3NlcnZlcjQxdGVzdHMvc3Rfc2VxdWVuY2UucHkKKysrIGIvbmZzNC4xL3NlcnZl
cjQxdGVzdHMvc3Rfc2VxdWVuY2UucHkKQEAgLTY4LDggKzY4LDggQEAgZGVmIHRlc3RSZXF1ZXN0
VG9vQmlnKHQsIGVudik6CiAgICAgc2VzczEgPSBjMS5jcmVhdGVfc2Vzc2lvbihmb3JlX2F0dHJz
ID0gYXR0cnMpCiAgICAgIyBTZW5kIGEgbG9va3VwIHJlcXVlc3Qgd2l0aCBhIHZlcnkgbG9uZyBm
aWxlbmFtZQogICAgIHJlcyA9IHNlc3MxLmNvbXBvdW5kKFtvcC5wdXRyb290ZmgoKSwgb3AubG9v
a3VwKGIiMTIzNDUiKjEwMCldKQotICAgICMgRklYTUUgLSBOQU1FX1RPT19CSUcgaXMgdmFsaWQs
IGRvbid0IHdhbnQgaXQgdG8gYmUKLSAgICBjaGVjayhyZXMsIE5GUzRFUlJfUkVRX1RPT19CSUcp
CisgICAgIyBBY2NlcHQgYm90aCBSRVFfVE9PX0JJRyBhbmQgTkFNRVRPT0xPTkcgZXJyb3JzCisg
ICAgY2hlY2socmVzLCAoTkZTNEVSUl9SRVFfVE9PX0JJRywgTkZTNEVSUl9OQU1FVE9PTE9ORykp
CiAKIGRlZiB0ZXN0VG9vTWFueU9wcyh0LCBlbnYpOgogICAgICIiIlNlbmQgYSByZXF1ZXN0IHdp
dGggbW9yZSBvcHMgdGhhbiB0aGUgc2Vzc2lvbiBjYW4gaGFuZGxlCi0tIAoyLjQ3LjMKCg==
--0000000000008410770648f88033--


