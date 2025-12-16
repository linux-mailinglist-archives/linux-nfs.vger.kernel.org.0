Return-Path: <linux-nfs+bounces-17114-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BB1CC1A71
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Dec 2025 09:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 245943020811
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Dec 2025 08:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A3F1400C;
	Tue, 16 Dec 2025 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPNFWjdn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/ay7yfa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29B372627
	for <linux-nfs@vger.kernel.org>; Tue, 16 Dec 2025 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765875056; cv=none; b=FSQdNiMfDJEDSdUCw8ipjC5vBjVpNa+CDCNuNdkeMhrK8pPidNBvektyKTHkAxsJ2mBmOzfOaYu5ioP4cphL6S1qX2mOdJsES4XlAJFn67qKNkDPgjxSLrESdOxOSB4fz/aIomq/qsMHYEtZa1NSynKH2dVgOLwC5C6iyJEgCUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765875056; c=relaxed/simple;
	bh=kZcad+aLeY5hHd5gW8UnVBU2UJS26yYwTOfXYFemjK8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jBNoYjuPW1AcX87WaXjy7BaQh3AAd/q1CxaKZXxEzAh7L9FPHPrYtreIbLIKL3PaJQKMIfLasa422nNNPouRfeeow6ISVdiyIZUfmmunp3neEZtD9Pwj7+4n7Fou/XFD7puBBuiPv0wHQclN0fU9UJg4SDnltHIZwRJsN6lyPPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPNFWjdn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/ay7yfa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765875053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E3IXRuLWyQC4T59q4jPouySi7bisIo5z00s20K17Lxo=;
	b=ZPNFWjdnq9cgqVur+ElEg2Nfy/j9oxow6vro+BgiQnjyuMySCPAx89g1PnbAH64zLnLhsg
	5wi+gcpjd3E2AD95xznOd5Z737j1f2M1HGJ2f2+c3e4o55zYoUplNP4JyYFQ10VphupGYw
	qbp6+W8hAzPxib48P+mz2TEkh//YxKk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-TLJ2tuIZPpedTrvVTTIqGA-1; Tue, 16 Dec 2025 03:50:52 -0500
X-MC-Unique: TLJ2tuIZPpedTrvVTTIqGA-1
X-Mimecast-MFC-AGG-ID: TLJ2tuIZPpedTrvVTTIqGA_1765875051
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42fb1c2c403so3443101f8f.3
        for <linux-nfs@vger.kernel.org>; Tue, 16 Dec 2025 00:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765875050; x=1766479850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E3IXRuLWyQC4T59q4jPouySi7bisIo5z00s20K17Lxo=;
        b=B/ay7yfaJUxDprhyNhgGlJkkIk0lf7prO49iuNbHDidbw8VN5NIJJBugDKdEk2H684
         OgTajJyQkPai88OVl5Ei/LmRetBEWB4nrIt7mRdEJcHCCqR8v+buwQfzs9e6Gdzfg5qR
         RzJeRPdrm3/1y5DNx5mw4GGA5d5LrPdxByge2Tf3doddUIqnAfamHoeP0aN4MpM1chem
         jnShAInAOZkfVLG4o05WocfQSh6E3BCTnnjiMOoQvfOA4c7E5eN5MTAAVLaqKbFaTchR
         E9XHo7lFbKez2gM8sxErDRs0z83eLmHv6zfhLnG7OrAKXsgsC4zURnSkl5aF9kuGGE2Z
         n8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765875050; x=1766479850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3IXRuLWyQC4T59q4jPouySi7bisIo5z00s20K17Lxo=;
        b=uDCzKFVqhyrLMbY8be6d7bgI6f1ua4op42Ld6/m6Sa6EQkhIlK0H/oMARXg9cNxP6z
         tO7uw9ulAvLfxS0430S2vVYo859FeUiDsmw8rCXrrHYrBPJehFz8eN3f69X549OwgBVW
         W1mo2AoMpOd4ntDwM7NbTtWOUgE2OVmefaKrw6AUIWccvk9nc87VUuz0o3tGUf+TEMsY
         P8kcquavDqGuSZONyyDMvGWZTn16BCF6iYRgORzhAKOykL6cQ4m0jP8Wv9/KquYT2dm4
         GMQt6GsJaIOH2n1KSmh/w7zR2VmHBAXRK/VUOkN1DSMPpAO3DDkVSjf3xZ0e+yNqP1HL
         Y0pA==
X-Gm-Message-State: AOJu0YzqxpaIeoyiqQ6yuf8CE3lN1YyuW5oIG02stXVezlLsFlClAMJz
	fJaMCPoCT0vxfMqf8r9g1+3RMZMJl7Kb1kelf3/8PHsPVRwkGzU2s0Zk5eAxew1MQlDwrfBaisH
	nUwyStnUd7gwSw3pwOV/m+WEmKOt3IcAxxJ/xcqVaLyfzdX6EY4Dv+W/VZ9aH6/+rFF9PZVMw4P
	H3XgJ3q90f7rPOn6FwJ0bfy54BROUxPITJchchIIZlqfJRPsoH3w==
X-Gm-Gg: AY/fxX7W3wmCskdSfGaIfjWzpv9w8Zi76fY7tktyK0e3tuRT2ecIsHrrKQPkDk3j9en
	pbx947cZpjqzSq87qfZ2x/zXvhbayj5qwDnUOhfhR3pdc9J3XDPzso5DBM1TedQcVMkubjiQRXh
	eTXkMJ8QrLthSn9MZlW7Z4zcImsbR6IAJcN2Bsn6EV6EVhijiGwvUZvsg5JI/RBjyisA==
X-Received: by 2002:a05:6000:310e:b0:430:fcda:4529 with SMTP id ffacd0b85a97d-430fcda47a1mr6994915f8f.61.1765875050656;
        Tue, 16 Dec 2025 00:50:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8132JgjO9U9yKi2cDb4jPFP2P0N1djaPlC8N+FCVMiLR6qQpQjrmjUx0MuoJRF25IBbq9q0Mjo2uQA7yzaK8=
X-Received: by 2002:a05:6000:310e:b0:430:fcda:4529 with SMTP id
 ffacd0b85a97d-430fcda47a1mr6994895f8f.61.1765875050268; Tue, 16 Dec 2025
 00:50:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Suhas Athani <sathani@redhat.com>
Date: Tue, 16 Dec 2025 14:20:37 +0530
X-Gm-Features: AQt7F2qeF0ZezUH4nqUIoOzf8rNX2CVhkoi5Hvoq7efpx1MD1FRHg_7TxXNrtBo
Message-ID: <CAHZzugbT9vuoAaR7L7jDoPsLUtrrS3J052i-M=bL9O5nq4auqA@mail.gmail.com>
Subject: [pynfs] Proposal to fix CB_GETATTR handling in DELEG24 / DELEG25 (_testCbGetattr)
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Cc: Frank Filz <ffilz@redhat.com>, Rajesh Prasad <raprasad@redhat.com>, ffilzlnx@mindspring.com, 
	calum.mackay@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am working on NFSv4 delegation testing using pynfs and recently
encountered a failure in the delegation test cases DELEG24 and
DELEG25, both of which rely on the helper _testCbGetattr() in
st_delegation.py.

After analysis, the failure appears to be caused by two issues in the
test logic rather than a server-side protocol violation. I would like
to propose small changes to the test and get feedback from the
community before proceeding further.

1. Incorrect bit test for OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS

In _testCbGetattr(), the test checks whether the server supports
delegated timestamps using:

if caps[FATTR4_OPEN_ARGUMENTS].oa_share_access_want &
        OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS:

However, oa_share_access_want is defined as a bitmap, and
OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS represents a bit number,
not a mask.

The correct test should be:

if caps[FATTR4_OPEN_ARGUMENTS].oa_share_access_want &
        (1 << OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS):

Without this shift, the test may incorrectly assume support for
delegated timestamps, resulting in mismatched OPEN arguments and
incorrect expectations in the CB_GETATTR response.

2. Handling of NFS4ERR_DELAY after CB_GETATTR

In DELEG24 / DELEG25, the test currently accepts NFS4ERR_DELAY as a
valid status for the client=E2=80=99s GETATTR:

check(res, [NFS4_OK, NFS4ERR_DELAY])

However, immediately after this, the test unconditionally accesses:

attrs2 =3D res.resarray[-1].obj_attributes

When the server returns NFS4ERR_DELAY, the compound reply does not
contain a valid GETATTR result, which leads to an exception in the
test harness.

From the server side, returning NFS4ERR_DELAY is legal and expected
behavior while:

- a write delegation is held

- CB_GETATTR has been issued

- delegation-related state is still being resolved

This behavior is commonly observed in asynchronous server implementations.

To make the test robust and protocol-correct, I replaced the
single-shot GETATTR handling with a simple retry loop:

- If the GETATTR returns NFS4ERR_DELAY, sleep briefly and retry

- Continue until the server returns NFS4_OK

- Only then validate obj_attributes

This matches the intended NFS4ERR_DELAY and reflects how a real NFSv4
client is expected to behave.

I would appreciate feedback from the community on whether these
changes are acceptable, or if there is a preferred alternative
approach.

Thanks for your time and guidance.


Regards,
Suhas Athani
NFS-Ganesha Team


