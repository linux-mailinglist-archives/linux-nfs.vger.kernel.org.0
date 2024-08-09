Return-Path: <linux-nfs+bounces-5272-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4668B94D0D1
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Aug 2024 15:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7933A1C21DEA
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Aug 2024 13:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40755193086;
	Fri,  9 Aug 2024 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czJ4ZoJJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB103174EE4
	for <linux-nfs@vger.kernel.org>; Fri,  9 Aug 2024 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723208811; cv=none; b=Xg6LYUia9QBWCz6Yj4En+Uas19septtkUQ370FoUj81npAxWGp72wfuF9mYrREGgvv8Db5yg3/U6+KJz1SkYvvwxH5y2YVkT39FoYRkPqr8b7JdzZTc2DNz9o/oJA7rRYuW1cDeTjWq70TCVh8PASpUWD/eivDxrOFHwNq5kXho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723208811; c=relaxed/simple;
	bh=woYsOJlaYEVCblkUAOqjsoWV/utfoIefgYmJW6W1iC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CaTiIb5EWDTliyAekYdVjHKRCj/NQ15d4tz2Ia9DlopS4Z9kMcEkm8qA6gZbJB65hcmFhaHJMUev0O3sePj/2ylQQaFekBqLW2dUl84kMQek9LXsOOOpAdflU/kcIcyF23xCnT55g2hvE8umDK85XOOdek6ie/Fo/Qt66Jowe+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czJ4ZoJJ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44fe58fcf2bso12344881cf.2
        for <linux-nfs@vger.kernel.org>; Fri, 09 Aug 2024 06:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723208808; x=1723813608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybKhhOCXki4gIQYz6P2VEuGRkAWVjvvl23ppAU/MiS4=;
        b=czJ4ZoJJxoTTWIji/EUVdZMR01Bk1nBFJTvYWe/sfkYIcf8+hFFOi8Rmk4KHvWIxzg
         svK9Dz5bpGPV4gAcX0wu32aQAG7R9v8f+uSq5DLKtTZb9nL5fdEBvFJyJSn/ZYUOK0eA
         U3Hi0cPoJdxp60W8OjE8R8L4MqMdaYcLNFa9OWuhAlsf/v/ZQtQTS6BMt3luxR+Ci58Y
         ac9eMruHLq5o45MgZQzjA2tpsxoIan1QknWSuGna+74GiYDSO6IORSbOKe6PaEEMN4XD
         7Cikpi+cJ6sFjYZ0HKPVsNzphEeWOwrACyIZMl8YqQkrbxGG9PuqXbzlte2LNkHsuweX
         28Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723208808; x=1723813608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybKhhOCXki4gIQYz6P2VEuGRkAWVjvvl23ppAU/MiS4=;
        b=sbyNFCf3TEgqg3zhZM/Ry882XU+TFSbVvDXSJwjRu8u5yyqVjFOxl0q+6qdT5czYmF
         O2sw1iB/8Cut4p3/H9BmOJ77S72eFE5+tdaej0zbmD9AbeyVqPzebIP9iIjPDq+PRKKt
         Qk1fOsEsF2u2nkThs6FcYgXnklg24ToNKdazV/3v2YOKytS6Vy/D34oioMuLBFWBZ8vP
         ZsSggOKDRd+K/cSRa79EXdJXLOE3zdSRibHYSdtzFkfRVHm3mPrl9WogAoH3ZD/lknSl
         qmukgaj7KTQRXFcDFtmJEvTutG/cUjfkgy1RnmXEfIFLszPd4+R9+0fHNtgxq33pz9s4
         7mLg==
X-Forwarded-Encrypted: i=1; AJvYcCU0bj3HBzokljQJ5iuWQAcNUDWqvxCrHAMiPFWGfMGJUPuEJPjVPzCWggq8TkcRrLuiqtgOz3jsXQkvrLuiLEae/ZbNgjf+O0Uw
X-Gm-Message-State: AOJu0Ywy2fXXdpRNzSmbiS9EzU32TRmAu9jy9qNBxIWJNL4f8swRKJlW
	fIKe+Z1xHiJwTpboQC0SnUNdEhGHvBtq1u1CmhPInGxcsLmXlAEE5sqTuFdcEIL8OnpUgB6/fTo
	Spb73DJomuBYie7ltE8cjbjxm8Mo=
X-Google-Smtp-Source: AGHT+IG6k1ynC4nDff5LiWdd5cfZXz5i5rs5wLhqZlZOXafiuW5UuwoBoDVlpJh58Q+ZEKciMvf0PQWkoYTQyiD1oBI=
X-Received: by 2002:a05:622a:1b10:b0:444:f860:3b4b with SMTP id
 d75a77b69052e-4531257caf9mr13471371cf.14.1723208808438; Fri, 09 Aug 2024
 06:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c4f1d8bf-745b-4a98-9d38-2da4c355d691@gmail.com>
 <66be75a6-2d3f-4f5b-96da-327556170c4a@gmail.com> <e39131ce-1816-49e1-8319-820472892a38@gmail.com>
 <CAN-5tyEx=j2OiRZVd+18x-2Y36SGGsJxAVApudT+mWjiNGDyxA@mail.gmail.com>
In-Reply-To: <CAN-5tyEx=j2OiRZVd+18x-2Y36SGGsJxAVApudT+mWjiNGDyxA@mail.gmail.com>
From: Anna Schumaker <schumaker.anna@gmail.com>
Date: Fri, 9 Aug 2024 09:06:32 -0400
Message-ID: <CAFX2Jf=k0SC4iFzj+24HbR-4MPkk0bkGCvnnOiv0OYgqO4QOBw@mail.gmail.com>
Subject: Re: NFS client to pNFS DS
To: Olga Kornievskaia <aglo@umich.edu>
Cc: marc eshel <eshel.marc@gmail.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Trond Myklebust <trondmy@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 6:07=E2=80=AFPM Olga Kornievskaia <aglo@umich.edu> w=
rote:
>
> On Mon, Aug 5, 2024 at 5:51=E2=80=AFPM marc eshel <eshel.marc@gmail.com> =
wrote:
> >
> > Hi Trond,
> >
> > Will the Linux NFS client try to us krb5i regardless of the MDS
> > configuration?
> >
> > Is there any option to avoid it?
>
> I was under the impression the linux client has no way of choosing a
> different auth_gss security flavor for the DS than the MDS. Meaning

That's a good point, I completely missed that this is specifically for the =
DS.

> that if mount command has say sec=3Dkrb5i then both MDS and DS
> connections have to do krb5i and if say the DS isn't configured for
> Kerberos, then IO would fallback to MDS. I no longer have a pnfs

That's what I would expect, too.

> server to verify whether or not what I say is true but that is what my
> memory tells me is the case.
>
>
> >
> > Thanks, Marc.
> >
> > ul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node
> > stripe count  1
> > Jul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node
> > ds_num 1
> > Jul 30 11:10:58 svl-marcrh-node-1 kernel: RPC:       Couldn't create
> > auth handle (flavor 390004)
> >
> >
>

