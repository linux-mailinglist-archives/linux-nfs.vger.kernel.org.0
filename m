Return-Path: <linux-nfs+bounces-13305-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FA6B1607F
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jul 2025 14:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F640565382
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jul 2025 12:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCCC4C62;
	Wed, 30 Jul 2025 12:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpFwxaml"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0797528031D
	for <linux-nfs@vger.kernel.org>; Wed, 30 Jul 2025 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753879395; cv=none; b=HJeHbo7LZWLKWOt89iDsyDWkq2XM0tmMPpeAoXJiYDri4AKyEfk/ZvpcQMA0sB4x4qW37/Ft/Ql4NcOOPTwKZcOF2OLLJY/xeieEjk1PteFSaSn4/1MHI8mgCEIRLwGJ8KlOJgSB1uHS7ZhZXWTu+Ecey3pK57EDiEyc+ceUjZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753879395; c=relaxed/simple;
	bh=SOQIVdFcw17Yv5cH49hVgdPTKb2ZhTTfb4lW2S1VFeY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=n/s4sJvp9VvJ/WbBpUb2vAv0y+lt29E8XoG89iJnW2K0U6oepYppexYEEXjpVdhZXvriWqeave5x92JVGOCRgOu8qbDSQkUlueusQdDODYzMS1ax5cKGCsyxFiWp57iCuX6/aVoXhERdXD2di42D8XISoAwnt/IRE3jnNDMW7Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpFwxaml; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e8e11af0f54so2583666276.2
        for <linux-nfs@vger.kernel.org>; Wed, 30 Jul 2025 05:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753879392; x=1754484192; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5twsxx5xusgE5pCOMFbrbjEdyfFumI7wpKLfnEFEnHw=;
        b=hpFwxamlRTDWIJM9VLLeOxlfVWkwvGbsikX/0ZOqsvugUHjUn+ufIN2SvWd1ndtLTg
         APsVmdkkdz/nHbisRQYlUsB8ZAlnQ5UgSoBOvrrW86fIAOJU0XIjmw0+H/cH3OMykjqg
         2cf9REps+mF6GQM2MhOM9gXZgbN5wNLeUaqS5whIP6p36lnH8L/kOoqPO041E1BfgtSm
         DH+ZdXATxwxpZ0iYk/j93UfF2Fy5WwmMcJagRYJa1sEFWxgaDEgFzrUa2i1Q5zsT0Laq
         FuOry4DUfS2t5XrkioZ6pypMsuNglzrL+G62dNUB4calikMUUXdxHZ4AG7NAaq6lJ0WK
         Lzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753879392; x=1754484192;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5twsxx5xusgE5pCOMFbrbjEdyfFumI7wpKLfnEFEnHw=;
        b=kfMwdcTWw90VqSxoUfO/9ccP0cBty/QG0EkxnNxKPPpNRKzEcLE02lYjuLNf4/SPCJ
         C9LpmuGyxgnsmPdS8Pn7YbizbQCRu3PWcggZTTg9FhXH01Ml37PkULHzkdx3epBfH5IA
         MDlq/fieQvw+ujzKC89Mg0QhC6aPytYMFV9E1Iil8iv5NmvFJIOyH7FidpG9uqTo6HGq
         0poHJUkUl0Ij6ha7f/q+atJQZYCcj+1+3iuLlZzDBWYovNAEXHQKoUR02EVnCl0Nyai+
         Wl7mva8rmufuEUy7ZmRaogfGi5oB6FlqwC+bp7MAXm8ocUC5eDXDP///BXHRCbsd4i0y
         BuyQ==
X-Gm-Message-State: AOJu0YzsmApUyleAb5sJgIaW9g0v3sW/UGuc4tapLJ8JnKpFVjgBNhY0
	Dh3QfHm+LV+Uyd9oHwO3OqxTfz3YxaTbE1KC0vR+kMs4PtmbqUdK2IXCO5QbWUvzSTLL/giyXZv
	DmXHjNMD71m9dr518QGMG/TaOzYTBESVvGBWf
X-Gm-Gg: ASbGncv/QU1wdgO6hReMXu5cbfgicqraNl4O7lTd9cI1C5+gNC/TEkH10ZNlA3ii/rs
	CwJX5EtVTXAhjvTq1gJtmmZ5WkzjeKfY/mZ36cKxGP8np8XTBXDXaL2N4DSGN7/RZ63v1EpQYRi
	37RTA4ETXE9iz5FX0lKAYr0lssC1G717ET3hSlCTM+5h1Ar5Sr1bqJH76gMSewlW4MDqe+ir6k7
	WDg78W4
X-Google-Smtp-Source: AGHT+IGqA93UfoM9ktl4AQ3QvAfjjtk2C6gnGV/DcqwYRG3T2kSKmozcpt8/zpNxgeudH+C4BBXO4MZabEIRrN1s22U=
X-Received: by 2002:a05:6902:1615:b0:e8d:cf0d:2d36 with SMTP id
 3f1490d57ef6-e8e3147a9b7mr3637862276.3.1753879392657; Wed, 30 Jul 2025
 05:43:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Wed, 30 Jul 2025 15:43:00 +0300
X-Gm-Features: Ac12FXwoPYtK5in4sptjC5nv6bljq_WoEFibfT1-TPeb9JnLpSMzTcRgZQ3Rkr0
Message-ID: <CAAiJnjoNd37p6kqSZSOPzYup_fWaHZgJv3gEpfThpxn--MqpqA@mail.gmail.com>
Subject: mount NFS with localio
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

How to mount NFS with localio on Fedora Server 42 (6.15.8 kernel) ?

Localio enabled in kernel

[root@23-127-77-5 ~]# cat /boot/config-6.15.8-200.fc42.x86_64 | grep -i localio
CONFIG_NFS_COMMON_LOCALIO_SUPPORT=m
CONFIG_NFS_LOCALIO=y

[root@23-127-77-5 ~]# lsmod | grep -i localio
nfs_localio            36864  2 nfsd,nfs
sunrpc                925696  30
nfs_localio,nfsd,rpcrdma,nfsv4,auth_rpcgss,lockd,rpcsec_gss_krb5,nfs_acl,nfs

[root@23-127-77-5 ~]# mount -t nfs 127.0.0.1:/mnt /mnt1
[root@23-127-77-5 ~]#
[root@23-127-77-5 ~]# mount | grep -i mnt1
127.0.0.1:/mnt on /mnt1 type nfs4
(rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=127.0.0.1,local_lock=none,addr=127.0.0.1)

So /mnt1 is mounted with localio ?

Anton

