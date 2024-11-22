Return-Path: <linux-nfs+bounces-8197-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AA39D6048
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Nov 2024 15:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45322282809
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Nov 2024 14:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B63524B0;
	Fri, 22 Nov 2024 14:29:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9D2171D2;
	Fri, 22 Nov 2024 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732285761; cv=none; b=Z5FqWT5UIhs+Of6eJP/BeNhD2ASdr+K1jLzQsjnJBLt63ORib4pk1cPoZKt2yDUa2MdrQWQixfeTj+gfUA/1E8l8n+QN2LpjDYo5uN4aU6X9WTOfM4+acHQoKJcD88ZdiTgk9y5343y7wpI4TvsXdz8qg/hiTWffH0TBuDI2skY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732285761; c=relaxed/simple;
	bh=ALWtShgKlACg5peP3rjy/sBRWgmDv3+Kp9cFCaaIV7A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A8Sao7HV8FO6tx3E/Jj90QK1ncuM2lrzDUTi9MyEgUMshwJg35fWspWqftm3CKYAqMad76Cgn5CRuwonVVUwdwX7Wm9rhUUY/oSxl3o3ua4WF0XQ2v9UMfN81fs+i7ysA5EJi5qKcQTrxwgG+2l83gTeLRMZoQcCmw7i0jdo94c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21288d3b387so16865515ad.1;
        Fri, 22 Nov 2024 06:29:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732285759; x=1732890559;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ALWtShgKlACg5peP3rjy/sBRWgmDv3+Kp9cFCaaIV7A=;
        b=mYO7Z73LoI/pyxzUv9UUK75M8s3m+SMwknJnp+bcC3+CCyWXish9CjakRwgrYBXI94
         1E2k9L/9BRm5Lga2eVI8t8SHITRCAG7yRjiAVz9665vWRqGYDLaIHcuq0kgNf5yT91f5
         vMopwnBwRyglFP96EKVHs8zkTbG58ZEGQY4jbasuf0rfp5V4QYJwlulQla3EDWvIPYH/
         47W3aYg0OnAdqhWedctRc8Bl2bgozgpmTg5ubyqhM+R2UH1EUBQpHoo0o6gM9sLeSoYm
         2dhkmsjUqeZQpt2xOY6L1hd/hrubvA5ATu6xWGXkYCsNJz7KtAzEMEoPt16z2YFD/fAF
         aKeg==
X-Forwarded-Encrypted: i=1; AJvYcCVVn9qztWX3E59Eq5UJEnayqjYX2/gxzu3hUanLCbKHHx9VgWXnVXBWJjC+4QRkvE4w9veafcA168rWJd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZK+TxsbBSs6x+YGUk1rNLbngwkcNKtC520nALlIb4gEhttC1h
	ALgkTDIBAOm9UyE6nq96q4Ocr8UubJipJdTPtx7ayqfN0i8vBSPRO3lb
X-Gm-Gg: ASbGncvTvOZ7mDkqD61QVrNbps09ZRM7koxzg+nF0lwQY7nN498eggWluVSJlNFhqzs
	L05AnFgDZojA6+2ZiOP3jabqMPWlsdRFIFydjnh6OSxbxp/S+L2/RWq0JrxbAWdeIvNTCOjHubM
	ANstnV5oG8cTJBF+PvBTdGNIECJ1lWgyw0Npa0nUVE89FESAsqW3BGGyyqCjPFGeTzRUa7dFcUM
	sjiduXBFjAYtENaPIzUB21bLh2IYc+remYBAZyU94OlAbJ/v+dGJKiXVGybQgM5+jcjT07P6W34
	fSpbY0thtcH0xGqqLKfIN79Soh7JqWvVjHzEEgiHOCc=
X-Google-Smtp-Source: AGHT+IHel6+PKEihHvZyFEe4e3RNy6kPKRotK4Z9syzvfzmS32VcpNb0Rz9EH0NPaRwp67vJtT6eOg==
X-Received: by 2002:a17:902:d4cb:b0:212:996:3536 with SMTP id d9443c01a7336-2129f5c3cf0mr42291255ad.10.1732285758986;
        Fri, 22 Nov 2024 06:29:18 -0800 (PST)
Received: from leira.trondhjem.org (104-63-89-173.lightspeed.livnmi.sbcglobal.net. [104.63.89.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc207bbsm16542835ad.228.2024.11.22.06.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 06:29:18 -0800 (PST)
Message-ID: <d7b2d246dfffb921f7d2c1e59fc0e6d847fcaf2f.camel@kernel.org>
Subject: Re: [PATCH v3 0/2] two fixes for pNFS SCSI device handling
From: Trond Myklebust <trondmy@kernel.org>
To: Benjamin Coddington <bcodding@redhat.com>, Anna Schumaker
 <anna@kernel.org>,  Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph
 Hellwig	 <hch@lst.de>
Date: Fri, 22 Nov 2024 09:29:15 -0500
In-Reply-To: <cover.1732279560.git.bcodding@redhat.com>
References: <cover.1732279560.git.bcodding@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-22 at 07:47 -0500, Benjamin Coddington wrote:
> A bit late for v6.13 perhaps, but here are two fresh corrections for
> pNFS
> SCSI device handling, and some comments as requested by Christoph.
>=20
> On v2: add full commit subject in 1/2, change the caller in 2/2.
> On v3: add r-b for Chuck, tweak comments in 2/2.
>=20
> Benjamin Coddington (2):
> =C2=A0 nfs/blocklayout: Don't attempt unregister for invalid block device
> =C2=A0 nfs/blocklayout: Limit repeat device registration on failure
>=20
> =C2=A0fs/nfs/blocklayout/blocklayout.c | 15 ++++++++++++++-
> =C2=A0fs/nfs/blocklayout/dev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 6 ++----
> =C2=A02 files changed, 16 insertions(+), 5 deletions(-)
>=20
>=20
> base-commit: adc218676eef25575469234709c2d87185ca223a

Please make those patches be incremental against what is already in
linux-next.
--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com



