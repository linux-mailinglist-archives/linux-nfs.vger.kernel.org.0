Return-Path: <linux-nfs+bounces-10906-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2106EA7183B
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 15:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A4718844B8
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 14:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D995125DF;
	Wed, 26 Mar 2025 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/koKZv5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C472454652
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998607; cv=none; b=hPGJsJsXnjuks4GQO1y9lnChHdsnKAQnELi/gb3Fc6Eyf0Y/U8vMkI9QtjT1XixVsmg9waFTwq4/odY9UhA0wiJUVxMUOqKRwDU0GTy/wdI1PGKK3oCk6tKo+B4Hkp/t9A5WRyT8lZOt5/YBpyNXNV7EYDzwc7pIRvRl1LbCcp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998607; c=relaxed/simple;
	bh=JBd1SNYeNfRxgueHq6qjQACHPh6zlxPV86THvWZYnVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nu+8PleXFvIAJbxzXkraAVd9B+twbRIx3fexzM3yOZcQ4peXdF+mJpGGR4LoHC636SxvGWmynlmB4DGC/fBJbitdh4fNIBcLyTxYNasyQ9S+nlb1g81+QC55RiFR8T6kH+8w6BzvyzXYZTVSgMovzmCsDv0HbEf41qps523F9BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/koKZv5; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2aeada833so189222966b.0
        for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 07:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742998601; x=1743603401; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kfuZU+4ZaV7rwjRbT3bE3/wVa1VsdJhqmYSIPmVLcQ=;
        b=T/koKZv5Ax4N7I6LKLnrdKQXpMY6xq+8yD/ECyS34nyvnQKToc//SQjsk0hES9jzR9
         /o/yeeLsO8VT2KUZBzzP7TUSPADHIjVnY0N6gut8EZqAfSG5FVY2cEhWsw96gywm9U02
         fVK1oIuG6dVUVn81+8Ten5lbVybxkmS23fRrxD5c6DuGLzlfhvpFi6+RFleXj29LxgjM
         02xZ3hPOMrbSnQ4YwPBqWfnHt6ZuOn2kElI9pMOV9L5jD9foxKVe1GcLObw2YJXpPYVZ
         UbbResZIq1OW9e/DNuMxOPo0l2T2Lhx9xqnYr8KeOtm08avctfHsGtlGn7DeSZ5LIIjQ
         I1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742998601; x=1743603401;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kfuZU+4ZaV7rwjRbT3bE3/wVa1VsdJhqmYSIPmVLcQ=;
        b=Ck4PiBOIEKj3Lsl7ZdRwjgenEDG0v8NoYTx6EAOUD0A4e9oO9cCLg9v1FIeINKriyU
         ldFIHcgaQ+CdlC/O+xeQ9AN4OKDIuXuAcNpspp32wGUCjgw/6xYn3Kas98mb+xI1yysV
         5Qwcv9htp23autNWpNtdFZg2hfO1AytI8uS3nh82MAfJSxzCJT7i02QPyjv4kmeN8uhQ
         rkck8ssQZ3ZFRlX1bf9JlQjgnoz3HrMx3B+7I3JOP+MWgHRQDkCbrAhGgF8vRmsKQJU6
         vYCYOuQdJp6nWSPftyq1sORZP1VKxoO2jr1L1fLeTdaD3gJwgHf2Y40vKzIh5FrpdJv5
         jc7Q==
X-Gm-Message-State: AOJu0YwPrpCic7CvM1CaNvGpmwNK/M2fK8Q0pwBX7w09XTs1ZH6H/+lZ
	M6D30WbpUO0QG7F+joux3jxAGcj4c/qnvYMUuF7HEmVOoX5iN1rlH02YbggJcXqUeMlDjD59TPc
	Uo72kcUhixQ7slXj2qmf81g8SBJlfD2W04+0=
X-Gm-Gg: ASbGncsC906pRqTxB5MTjch9+ivbBJceUOgbctEekm32MOCF0e0gKd5HvIN5IVEirKa
	0LO3zu/JpGX7X3EefMsD2KZqICibFOx9kF4nenIrE6hG8z/ChYIkb2Mi3XaLSVxDkI+1L0nR3GK
	rbKkLDhctfTDJqwuzIFotia9jV/Q==
X-Google-Smtp-Source: AGHT+IG5u9YPEbsY6ENcpHlUCIxkZpKDN8SyRXRHYisGz1I2EmsDGwVsrfh+aw15dbGQ7UCA2Qy9SM/aq5ZCRbmIPrg=
X-Received: by 2002:a17:907:961f:b0:abf:6e87:5148 with SMTP id
 a640c23a62f3a-ac6e0d9f82dmr426007466b.23.1742998600714; Wed, 26 Mar 2025
 07:16:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6NoWzPikoEtbVN1esw9d5KDgfOfds1iLfpUNeFcXzaA2w@mail.gmail.com>
 <9324cfc2-4a74-4577-bcfd-704ffd25240d@oracle.com>
In-Reply-To: <9324cfc2-4a74-4577-bcfd-704ffd25240d@oracle.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Wed, 26 Mar 2025 15:16:03 +0100
X-Gm-Features: AQ5f1JrNZOP2FL3zu8ewLE2V79x6wJwnZ8_DtVHNwrcqdDS14TqzSHr3_LpYKCM
Message-ID: <CANH4o6Pq1Snhyk9sFeG5sdZ1LKekpSOrLb0Hc-sb-5wSDPDA4w@mail.gmail.com>
Subject: Re: pynfs tests for NFSv4.1 OPENATTR / O_XATTR?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 9:03=E2=80=AFPM Calum Mackay <calum.mackay@oracle.c=
om> wrote:
>
> hi Martin,
>
> On 24/03/2025 2:29 pm, Martin Wege wrote:
> > Hello!
> >
> > Does pynfs have tests for NFSv4.1 OPENATTR / O_XATTR?
>
> Yes, have a look at the "xattr" flag, the XATT1=E2=80=93XATT12 tests, and=
:
>
>         https://git.linux-nfs.org/?p=3Dcdmackay/pynfs.git;a=3Dblob;f=3Dnf=
s4.1/server41tests/st_xattr.py

No, these are https://datatracker.ietf.org/doc/rfc8276/ FATTR4_XATTR_*.

We need tests for NFSv4.x OPENATTR, the alternate data stream support.

Thanks,
Martin

