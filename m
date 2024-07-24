Return-Path: <linux-nfs+bounces-5030-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F1C93B04F
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 13:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71F01C2117E
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 11:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6190B156F30;
	Wed, 24 Jul 2024 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHDHelTx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1634915689A
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721820412; cv=none; b=T8f7165VgqyZ3tOH64k1P8U8DClJi1cO97iKZZnMrQNI4YoOIDPcgz7RsaaDFMRVl9rq2O+llOArQQF/1vtxmw7spuqRJ/QLJcrbvR+ozWTEaQUamdmP5c5CtNfkFLMa9XIaefvBVMPJCrccFRELJICUScB0efmQvytiijyI3Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721820412; c=relaxed/simple;
	bh=IGeQhr18CB487p09WOzQ28jrpxxt4Pe/w5MgNaqByGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pFdizcrm6PJGxovHn8SPMh2Z9iswZDP+eRbgiAtjhllsezhRwx3M/xabmfudH/Bl8Q2A4a36+eYrkpZ5szi8qwUXbkO42rhkVaMfvKAoEZYDyQYoRSftVgXHE/UyegQFGUYc2MdbjvsLZUmCRU6OuuIoLfbav8RdI5pDw9S9l1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MHDHelTx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721820409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHL1y20+LMUJgE+Tk1FHL2Fer0A8K3eiU6L4brLtyuw=;
	b=MHDHelTxYQa52/cijjOJbdOsXl4FFZiAmM+rNe7i6ynjG3xuEJRkxPMV4esYyuyEUuaBhv
	OHN74yAlNSOIGGlvWbMkZ3Ue8wUuv01KcDke3NY6WeLJGLi7h7Czsg14h8YGbmhZF2zC+z
	ikVJOvcNtrZWAWhP0fHL0CIZZZ31QTY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-sXK0SzweOC2JIx4EI6KBIA-1; Wed, 24 Jul 2024 07:26:47 -0400
X-MC-Unique: sXK0SzweOC2JIx4EI6KBIA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-447e66bbc62so3538741cf.2
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 04:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721820406; x=1722425206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHL1y20+LMUJgE+Tk1FHL2Fer0A8K3eiU6L4brLtyuw=;
        b=AFR5M70PQK+pHSfD2f132gpExMesS2hxZC/vzE8dZyfiQmtKUBuN3aNtIZUIoKT4o9
         X1X+PJKPdHKrtjT119hd1NIMPe1pzEh6p8BFbcruJ9K0fEH2XlrNJ7d690WoV9M9VOpH
         wVyaPP0o+DF+lOQPxAge4mzjNXCJPwSBvDmw4BpvogafJu8xeg1Ztq9h/VfKImtnryeK
         hEK5zEK0B7K8MCjE3yJqyLQX8AECzlSRbgKg/JFO3EXZywx3QYl/45JSssleYOULI+89
         3BuDdWDFFUkRbfH1/gwVg+J38Iwr02fqm10Z6edZk5pbBXBlekzTrFonQtuHHyV9MVYP
         qJ3w==
X-Forwarded-Encrypted: i=1; AJvYcCVM26MrNL3PGU2PtV/d2inFw5T6uXKG2Y6zlT55RlYUNDe+3CIeOU9CbIMCpAWDcQ4hXprwzJH71WcN57T7jNqbs3nkyJoQK46k
X-Gm-Message-State: AOJu0YxvslVwRrROOAp5djJeDiMy0DeQdpxtEmOE/8ct/Ryg67uztrtQ
	8n08EDY/8sdRrsuxStMDOd+uCpaDrvjNHf2i4S37EKRyY5z3dzhRObLRQjqUvTn+UA2aNiLLh9U
	M/ZMI2+GZ0vACrtT9+o2/fcleB63UVV9kmY9IBwkK1G8QeMVH096LYQgSTWl1TaLZrw==
X-Received: by 2002:a05:6214:2d44:b0:6b5:ddf3:c142 with SMTP id 6a1803df08f44-6b94f01406dmr93287446d6.5.1721820405849;
        Wed, 24 Jul 2024 04:26:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+ejZ+n9YjXifZsrffxgzpHJnJuiasBDWpaiQLoz4b8B9v65SIYCtREl5rLk6pS8xxsOSvfw==
X-Received: by 2002:a05:6214:2d44:b0:6b5:ddf3:c142 with SMTP id 6a1803df08f44-6b94f01406dmr93287336d6.5.1721820405399;
        Wed, 24 Jul 2024 04:26:45 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.163.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b96af3211csm37031126d6.100.2024.07.24.04.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 04:26:44 -0700 (PDT)
Message-ID: <93f4b015-90e1-46d1-bea5-64c2f8818179@redhat.com>
Date: Wed, 24 Jul 2024 07:26:43 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: systemd/nfs-server.service: Is `ExecStopPost=/usr/sbin/exportfs
 -au` necessary?
To: Paul Menzel <pmenzel@molgen.mpg.de>, linux-nfs@vger.kernel.org
Cc: it+linux-nfs@molgen.mpg.de
References: <92cfc598-d81c-4c2f-b8c6-3d2ab589fe18@molgen.mpg.de>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <92cfc598-d81c-4c2f-b8c6-3d2ab589fe18@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/22/24 9:18 AM, Paul Menzel wrote:
> Dear NFS folks,
> 
> 
> Since the beginning in 2014 with commit 929aaa7eeab1 (Added 
> systemd/nfs-server.service) the systemd service unit 
> `systemd/nfs-server.service` has
> 
>      Description=NFS server and services
>      […]
>      [Service]
>      Type=oneshot
>      RemainAfterExit=yes
>      ExecStartPre=-/usr/sbin/exportfs -r
>      ExecStart=/usr/sbin/rpc.nfsd
>      ExecStop=/usr/sbin/rpc.nfsd 0
>      ExecStopPost=/usr/sbin/exportfs -au
>      ExecStopPost=/usr/sbin/exportfs -f
> 
> and this is still present today as of commit b76dbaa48f7c (exports(5): 
> update and correct information about subdirectory exports) [1].
> 
> Is flushing out the kernel’s export table with `exportfs -au` really 
> necessary when stopping the NFS server?
What problem does it cause to clean things up
when the server is shutdown?

steved.
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: 
> https://git.linux-nfs.org/?p=steved/nfs-utils.git;a=blob;f=systemd/nfs-server.service;h=ac17d5286d3bf93d693fea5554eb439425f6857c;hb=b76dbaa48f7c239accb0c2d1e1d51ddd73f4d6be
> 


