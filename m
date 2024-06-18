Return-Path: <linux-nfs+bounces-3994-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528EC90D9AE
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 18:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7C4281893
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 16:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB6B78C92;
	Tue, 18 Jun 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="FRDaWmCy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6627C6C0
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729021; cv=none; b=e9uzwzkqhvlIsniMVLK0z8wkbZbX+v+LLCGOLcjwYX3G03i4GjOxcUfW5rGw7b2eDY6sNEIWrSzTJ8xmx12ud6HfMe9CJGcMSvnxc3KGdBhbqKQQZ/u00f+FAfLZ8wnKGxKk/kEMFxipZ8kI2cqLzWlUSDRcjrEsKQj7rwNtH2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729021; c=relaxed/simple;
	bh=tQw0Rm5KswBDsBzuV0ZBj7AkBXLooZJuRsBikkkq0Qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Smdk0S/7jEuisqrLeaeiOYeP8TCnIW10vT/970xFk+xFXYe85yN+uz1U3Y0SlLtF3pDP5JkjN81UC7Btg0VbeJIKLweat3ebM6WhuFtOma6hEaMWDORbMUC+nCpadGT4C10WdfEBOE7T1VzcJ+R20J9ntJy2B2BW7KkAFUg790M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=FRDaWmCy; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ec3432633dso1282581fa.3
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 09:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1718729018; x=1719333818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xu4K/aBzAbyPDBaTdvV9pXck0w3TE5CPNzXYfBKoi8M=;
        b=FRDaWmCyNtj4r/Sqr4Isc8IbNxM+7EvpRjcj6DyNEWpqtWuwrKl+rFHNCuylYLyCng
         2hCKiYQGQ5TgYce7dlRuh3mGumM5mQp+mnAWMnZi7fc8DzgasAm/NIE6Bkd6Qjvw+buc
         hBJz3pCJ+KhwJwG0PLXjONLEL0klBA/u8BBhSBez3xJf+8FltsAdDYyc95g5RKw/dPWg
         BpLNYt6vTc9vGm3lNgLH50/BHvLtj+621ObSSvv14UsRnCSUucuWnOzPRz10+NkmpqAz
         LyfbOlEDJCGW20P9XbS/9IK7CBexHDQt98DBxjYVhrn7GZ/ZRJFx42d0IdKXOgnkFceZ
         Mmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718729018; x=1719333818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xu4K/aBzAbyPDBaTdvV9pXck0w3TE5CPNzXYfBKoi8M=;
        b=p5HHr/KI8GZporsaPjdBcCLxwZvtzicx+hNeoQYOJs0RDGQaY1Nam/ix9b6WqRQE/G
         izH0SHZyEw1kNWallKYqL8wQvbMnz5wKBgnjqxqcfnqrb4MVmSe/0gNH4KVLh7h0Fe2y
         iEr7zJFRY6uwAzhD1wMC1628OFgVxbvQKvZMzKlTfA//cUHcCejJ3f9iKgLIlHOGmFuQ
         5nxQ1MLG6AqY7SqmpJ8vFZurSXqOkn0kcjPaQHzDGv/QYoKIAhTS7pSvPu0Y++6f7FoZ
         bU4JpNVeIadADbgqbbU1ITBX5Yww28TLUVbjrbi9vD26nMMQxcuvURYhrBwM1HxyRQWt
         RVag==
X-Gm-Message-State: AOJu0YwZwZLTZU79ylxKRj8nUhtMInLTDaNbVZCW1DL3qelrQyPmP7wJ
	O3zSSXlGZW1e1qmeImkrau0nfpjw6v1H2ELyrszXgZf17PoAzWo6wgxFk6QwSNvRTjucLaDO88A
	Z9Zu583spO3io0qrjZ/tGe8kC5KY=
X-Google-Smtp-Source: AGHT+IGTwDJCvhad0f6BFd4w7w2lA5PsxKnNLxbuLptqKwOdM9jHRWT/6RCTpzKgBnyWnhp2DOMs0nDf1UnMyrddSO0=
X-Received: by 2002:a2e:9c99:0:b0:2ec:143e:2893 with SMTP id
 38308e7fff4ca-2ec3ce941e1mr1942681fa.2.1718729017674; Tue, 18 Jun 2024
 09:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAiJnjrKr65w-DttnyOc+srDweZnpb_LfXMvCCyP64KrzNO2oQ@mail.gmail.com>
In-Reply-To: <CAAiJnjrKr65w-DttnyOc+srDweZnpb_LfXMvCCyP64KrzNO2oQ@mail.gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 18 Jun 2024 12:43:25 -0400
Message-ID: <CAN-5tyF3YHWJPdnqOs6_KhBQOU+QTvWj4YK1gGY6rO4rSHtV0Q@mail.gmail.com>
Subject: Re: NFS 4.2 multipath
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 6:56=E2=80=AFAM Anton Gavriliuk <antosha20xx@gmail.=
com> wrote:
>
> Hi I have a NFS 4.2 server with 6x100 Gb/s ports.
>
> The NFS server connected via two switches to the ESXi host,  3 NFS
> server ports per switch.
>
> Three VMs running with Oracle Linux 8.10 (kernel 4.18.0-553)
>
> On the VMs I mounted NFS share 6 times with 6 different ip addresses
>
> mount -o nconnect=3D16,max_connect=3D6,trunkdiscovery
> 10.44.41.90:/exports/lv_prd6 /deep-storage2
> mount -o nconnect=3D16,max_connect=3D6,trunkdiscovery
> 10.44.41.91:/exports/lv_prd6 /deep-storage2
> mount -o nconnect=3D16,max_connect=3D6,trunkdiscovery
> 10.44.41.92:/exports/lv_prd6 /deep-storage2
> mount -o nconnect=3D16,max_connect=3D6,trunkdiscovery
> 10.44.41.93:/exports/lv_prd6 /deep-storage2
> mount -o nconnect=3D16,max_connect=3D6,trunkdiscovery
> 10.44.41.94:/exports/lv_prd6 /deep-storage2
> mount -o nconnect=3D16,max_connect=3D6,trunkdiscovery
> 10.44.41.95:/exports/lv_prd6 /deep-storage2
>
> During test I/O workload (8 fio jobs with different files per VM),
> looking at two switches I see that single port shows much higher
> bandwidth -
>
> 2 250 000 TX packets per second
>
> and rest of the traffic spreads across all other 5 ports evenly -
>
> 900 000 TX packets per second
>
> Please help determine why traffic doesn't spread evenly across all 6
> ports, more like 5+1 ?
>
> Seems like nconnect=3D16 works only for the 1st of 6 ip addresses.

Nconnect only applies to the 1st (main) connection. In your example
there should be 16 connections established to 10.44.41.90 and then 5
other trunked connections are going to be added to the group of the 16
nconnect connections.  RPCs are going to be round robined over the
16+5 connections. 10.44.41.90 would see more traffic then the rest of
IPs because it has more connections.

