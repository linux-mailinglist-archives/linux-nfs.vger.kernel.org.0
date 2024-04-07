Return-Path: <linux-nfs+bounces-2700-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A2C89B28F
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Apr 2024 16:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CFB281FA7
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Apr 2024 14:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8612428377;
	Sun,  7 Apr 2024 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6DDPpMH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754F8241E7
	for <linux-nfs@vger.kernel.org>; Sun,  7 Apr 2024 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712501144; cv=none; b=aDIWs+qCjQpqLxaMeZmT5fDuLv3ci+iWIgNbVl/vaCHIgiPdMl4BpwHKbqANn+3TqbhKXOGCqpSSsvGby6UTQJ2G4BUc2kX6G9xCG246IcOBLwi/clhoYlcFLIzFJZra4VjGDIVRcl8ovlBSMBQuYM4XKb5RcSbRA1khfnB8A4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712501144; c=relaxed/simple;
	bh=6Fsr/5417AAMj9ngeiSZnpiyEw2iuG+5u/aSlTygRnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjXrewPTpo3Ghk1Aw+PrTbr6UWcTHrc2YqQBjemF+kdnMx0TOHIygnjEVY48vk/Xx741+SOmqRpFhbjQvNyVcBZcH87HMa/5GueiNV+AordKFz9/7eRPUMQwj9oKswIT1g4kW33Obc4DFOsObclWiINXOw5ZkbJNMi6uXkx2Xlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c6DDPpMH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712501140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9iQy2cEfM4bfTgM810kU3gtpYpYGnS80hJ02ta1UI5M=;
	b=c6DDPpMHM6sq4/fzke2BXM3gLQt1N1okQVgRdS+sVNuBHL5tkPLElRdlDlpQVLo2ljn2AB
	V0k44uiPDBFv7T0S009zmm9WTUbRiUXBWRWh7w/NMG2d8RwKNMGx/N5D03M8exyrWL8sP/
	V1XuOIxupbPHaXQuh/mGy6CPfBCu5Jk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-aLakB_XiO-e-TXgQnk70yw-1; Sun, 07 Apr 2024 10:45:37 -0400
X-MC-Unique: aLakB_XiO-e-TXgQnk70yw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-432c8284601so11857531cf.1
        for <linux-nfs@vger.kernel.org>; Sun, 07 Apr 2024 07:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712501136; x=1713105936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9iQy2cEfM4bfTgM810kU3gtpYpYGnS80hJ02ta1UI5M=;
        b=a7yk4cDA8/NPFMW1HYsihYdZn4Ns67AlAaNARIn2iLV1yV1amGR8iQ1EaMdKwn4u+l
         RfDPS017aZ7kwxMK8KBmMmzwLZgXFyo5ICCGUkVCx7fC/u6EsvKxa6i7QxGzlhBPGYKv
         2DKlqFlShQXHqDGZa2QTJDDy+lrTc9phYjeatfUwHKzEWiwRj/RpY3ZIVciYp+UG+sP2
         4R05thkkMIqgdcNhYGhASZ3VeSV7IZBWph16Z2mmhwHpRAQOLHkx4lr5xJbdlxhyDt6x
         A1eXchyJ1Ewqi5CX9pH2YUwf1j2ylI6KixKa4Aq7qT5nYr/fO9GjYskDYuSTuo1dzvEu
         1isA==
X-Gm-Message-State: AOJu0YxvnwaOOKjCDYVxxpWhODMCmq79r2EJNiyUSwvGcVp1m57ZY1mz
	CJBGNGPxjZTZYit6jscr++12DWyh2Ft6MmbH4jEvzDcOrJZsiDD2wPIRlhyYRyn8JRDiRrNhEKA
	onIvNPv/RXqp9ykphBfLObHx3WQXNc0MW1HqhaHNWlhD1sk5vMJFcJ11TCfx5nHeifQ==
X-Received: by 2002:a05:620a:4093:b0:78d:641d:3db2 with SMTP id f19-20020a05620a409300b0078d641d3db2mr1285945qko.2.1712501135749;
        Sun, 07 Apr 2024 07:45:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF26AHP7wJKBgTDOQu4JCPcyeFTza4Gco9wzSTOJJbE0Q5usTb5szVt+6oTIwx4KX8uflar7g==
X-Received: by 2002:a05:620a:4093:b0:78d:641d:3db2 with SMTP id f19-20020a05620a409300b0078d641d3db2mr1285915qko.2.1712501135248;
        Sun, 07 Apr 2024 07:45:35 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.134.36])
        by smtp.gmail.com with ESMTPSA id j7-20020a05620a146700b00789f5cf990bsm2311262qkl.36.2024.04.07.07.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 07:45:34 -0700 (PDT)
Message-ID: <50d1fcab-ba94-405e-896a-5bbae128998b@redhat.com>
Date: Sun, 7 Apr 2024 10:45:33 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nfs-utils' .service files not usable with nfsv4-server.service
To: Matt Turner <mattst88@gmail.com>
Cc: linux-nfs@vger.kernel.org
References: <CAEdQ38GJgxponxNxkcv+t8mhwRPzOjan58MTBgOL8p9tY=rvTw@mail.gmail.com>
 <79c69668-4f8e-448e-9f50-6977cda662fc@redhat.com>
 <CAEdQ38FOP0_g0FK5DYz954OwfJjLUf2pjQL1CX=VNC60kd8HEw@mail.gmail.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <CAEdQ38FOP0_g0FK5DYz954OwfJjLUf2pjQL1CX=VNC60kd8HEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/6/24 6:26 PM, Matt Turner wrote:
> On Sat, Apr 6, 2024 at 4:37 PM Steve Dickson <steved@redhat.com> wrote:
>>
>> Hello,
>>
>> On 4/5/24 10:29 AM, Matt Turner wrote:
>>> Downstream bug: https://bugs.gentoo.org/928526
>>>
>>> In Gentoo we allow disabling NFSv3 support, which entails nothing more
>>> than not installing `nfs-server.service`. This has uncovered an issue
>>> that many .service files reference `nfs-server.service` explicitly,
>>> making them unusable with `nfsv4-server.service`.
>> Very interesting... not supporting v3... Just curious as to why?
> 
> I don't think there's a particularly compelling reason. I guess it
> lets you avoid a dependency on rpcbind.
And the other baggage  that comes with v3... but
I think it will be difficult to deprecate it.

But it might be fun trying :-)

> 
>>>> server ~ # grep nfs-server.service $(qlist nfs-utils | grep service)
>>>> /usr/lib/systemd/system/rpc-statd-notify.service:After=nfs-server.service
>>>> /usr/lib/systemd/system/nfs-mountd.service:BindsTo=nfs-server.service
>>>> /usr/lib/systemd/system/rpc-svcgssd.service:PartOf=nfs-server.service
>>>> /usr/lib/systemd/system/fsidd.service:Before=nfs-mountd.service nfs-server.service
>>>> /usr/lib/systemd/system/fsidd.service:RequiredBy=nfs-mountd.service nfs-server.service
>>>> /usr/lib/systemd/system/nfs-idmapd.service:BindsTo=nfs-server.service
>>>
>>> The only service file that depends on nfsv4-server is nfsv4-exportd:
>>>
>>>> server ~ # grep nfsv4-server.service $(qlist nfs-utils | grep service)
>>>> /usr/lib/systemd/system/nfsv4-exportd.service:BindsTo=nfsv4-server.service
>>>
>>> How should `nfsv4-server.service` be used?
>> The idea was to make nfs-utils have a smaller footprint for containers.
>> No rpcbind, lockd, statd etc.. exportd is to replace mountd
>> and only accept v4 mounts.
> 
> Seems like we would just need to modify the build system to not
> install `nfs-server.service` and other NFSv3-only service files and
> modify the remaining service files to reference nfsv4-server.service
> instead?
Or we break up nfs-utils into 5 packages... nfs-common, which would
be used by nfsv3-client, nfsv3-sever, nfsv4-client and nfsv4-server.

Not clear other distros would be happy with that.

> 
>> Unfortunately the idea of having a nfsv4 only server
>> did not go over well with upstream.
> 
> Which upstream do you mean? nfs-utils, Linux kernel?
The NFS server maintainers... they didn't push back hard
but the didn't it was necessary.

> 
>> But, I will be more than willing to work with you to make it work.
> 
> Thanks!
> 
We have a virtual Bakeathon [1] coming at the end of the month
Maybe this would be a topic for Talks at 2pm [2].

steved.

[1] http://www.nfsv4bat.org/Events/2023/Oct/BAT/index.html
[2] 
https://docs.google.com/spreadsheets/d/1-wmA_t4fp7X5WvshYPnB-0vHeMpoQMohim2Kb7Gx9z0/edit#gid=1920779269


