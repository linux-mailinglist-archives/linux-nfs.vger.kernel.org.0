Return-Path: <linux-nfs+bounces-2702-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B64F589B389
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Apr 2024 20:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED5428232B
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Apr 2024 18:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33CD3BB48;
	Sun,  7 Apr 2024 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAW2h3Mx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EE13BB27
	for <linux-nfs@vger.kernel.org>; Sun,  7 Apr 2024 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712515014; cv=none; b=S/9fUu6wZ7eSdVmNyCB+uzYHOAiwwzG17Jz35PkLODPAz6n11AkahJpIq9xNECS8kAdd5mWFwvXx0CZvvy8K+GGTcMGkaFAaPzrBzD66tHEcWjYbLotpGaoc/g4MY0Bbz2KWnf8mKcqSqQ+KbUW3jXBmbZnyUpMoxn3uoESQw9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712515014; c=relaxed/simple;
	bh=VLiJmMRFwr4iK7LAAzLVNjbOsWJmlKfkWoeXZOlYOCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBLp2GXONLL/74eLr8wi90kC8YteSI/9vAHDZtYKNGp1mREippQC6J71g14vXoahYXFfpg3YqyfHSNUoyNr4uq9kB/vdEZkwVUmyAA8+B3BcqyQdm48StDX90GeOeFJf3fCGV7QrKa1b3A1MX3gY6APUb+xebUs54RmAkp7DN5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAW2h3Mx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712515011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wt+cLJW4rOg2rtvU2N82bPWOGBhlRILCC8Oj4q91c8o=;
	b=cAW2h3MxbyKw7iUVys07MeNlQBQWNpEye9mtFtxim9NXKXZuhuJrU4lC0gUSH38+o93gx2
	4kB+cGe9o3QMCE5k+SxI7/yt5BYR8+stXqq9n4nZdTwaoDtRlqN7F2usk2iKSF+CS77B8Z
	Jf4CD5RpErS1/ci+lDKVMQ8T7fR8ZUc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-m6bH6L3ZNuupM5OxuJr1eA-1; Sun, 07 Apr 2024 14:36:50 -0400
X-MC-Unique: m6bH6L3ZNuupM5OxuJr1eA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1e2b39cb5a1so9882315ad.0
        for <linux-nfs@vger.kernel.org>; Sun, 07 Apr 2024 11:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712515008; x=1713119808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wt+cLJW4rOg2rtvU2N82bPWOGBhlRILCC8Oj4q91c8o=;
        b=VxcRY3Ec8Iv3b6gi/Z4sxjF/qub9nbrcJUMDCGOQAh3c4bJnMuoka5v/3F5QqUw89G
         G3KLqosVJ5/8Kd4NB2fmwsqxWCqkIv/FO7HQEGOplRq+UU6/T9wKh/2FFzmJwGZOfwV6
         bBFaTMnRu3C7piePN79xEimfgFfZ1I3q/9ZFZd2lOagdgC+rEwlLnzMK0eTHr4j6GvI5
         WSRyqDcqlXcPm4iPXpkllfe3SaftUoVg3/EDedfPvdmL37krMRFOl3ci0fV9Q/StcgFw
         YQXsvuofBhJfXF7CeVoOvjRfKXeg2R/ag/SpANaaawdMGUauKzrguBDryczgvADiYOx1
         0ZXg==
X-Gm-Message-State: AOJu0YyM992jDjWgp3b37lfPDIs7VWKi6onrkxurOgVOrJLr218g/q4O
	lDBVUjDy//lPJGgHZopEeS6CBmnNGjQP2RD1PeKAxpusK5D6bQudlqXbE4rjZp70qqQlGrkvkKp
	TfaIHwxx4YyVoOtnhZyDixYJ26PedplKe0HHmWe/nIOndNLLTKMaCldR/2H530k/4Og==
X-Received: by 2002:a05:6a21:6d95:b0:1a7:6a6c:3258 with SMTP id wl21-20020a056a216d9500b001a76a6c3258mr2162420pzb.1.1712515007876;
        Sun, 07 Apr 2024 11:36:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtdskfWue6rtY7lRCGaF48hLEuqcq82uuUTLxv1j+xgF+LovaShP+e/MW72BfiM8qyyGfxDg==
X-Received: by 2002:a05:6a21:6d95:b0:1a7:6a6c:3258 with SMTP id wl21-20020a056a216d9500b001a76a6c3258mr2162404pzb.1.1712515007502;
        Sun, 07 Apr 2024 11:36:47 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.134.36])
        by smtp.gmail.com with ESMTPSA id x53-20020a056a000bf500b006ecf76df20csm4927336pfu.158.2024.04.07.11.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 11:36:46 -0700 (PDT)
Message-ID: <1521cdb1-db67-4e7e-9dc2-c463d9df53fd@redhat.com>
Date: Sun, 7 Apr 2024 14:36:44 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nfs-utils' .service files not usable with nfsv4-server.service
To: Chuck Lever III <chuck.lever@oracle.com>, Matt Turner <mattst88@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAEdQ38GJgxponxNxkcv+t8mhwRPzOjan58MTBgOL8p9tY=rvTw@mail.gmail.com>
 <79c69668-4f8e-448e-9f50-6977cda662fc@redhat.com>
 <CAEdQ38FOP0_g0FK5DYz954OwfJjLUf2pjQL1CX=VNC60kd8HEw@mail.gmail.com>
 <50d1fcab-ba94-405e-896a-5bbae128998b@redhat.com>
 <3138D81C-EAD9-41CD-A32D-DEA4AA002CEE@oracle.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <3138D81C-EAD9-41CD-A32D-DEA4AA002CEE@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/7/24 12:29 PM, Chuck Lever III wrote:
> 
>> On Apr 7, 2024, at 10:45 AM, Steve Dickson <steved@redhat.com> wrote:
>>
>> On 4/6/24 6:26 PM, Matt Turner wrote:
>>> On Sat, Apr 6, 2024 at 4:37 PM Steve Dickson <steved@redhat.com> wrote:
>>
>>>> Unfortunately the idea of having a nfsv4 only server
>>>> did not go over well with upstream.
>>> Which upstream do you mean? nfs-utils, Linux kernel?
>> The NFS server maintainers... they didn't push back hard
>> but the didn't it was necessary.
> 
> I'm sympathetic to some folks wanting a narrower footprint,
> but I think we'd like to have support for all versions
> packaged and available for an NFS server administrator,
> right out of the shrink-wrap. Currently, most installations
> want to deploy v3 and v4, so we should cater to the common
> case.
Which we have now... nfs-utils.

> 
> As I recall, the NFSv4-only mechanism proposed at the time
> was pretty clunky. If you have alternative ideas, I'm happy
> to consider them. But let's recognize that an NFSv4-only
> deployment is the special case here, and not make life more
> difficult for everyone else, especially folks who might
> start with an NFSv4-only deployment and need to add NFSv3
> later, for whatever crazy reason.
I'm not sure what you mean by "clunky"... The only addition
was exportd which mirrors the v4 code/support in mountd.

> 
> The nfs-server unit should be made to do the right thing
> no matter what is installed on the system and no matter what
> is in /etc/nfs.conf. I don't see why screwing with the
> distro packaging is needed?
nfs-server.service and nfsv4-server.service were never
meant to be compatible... One or the other... Maybe
that was the mistake.

steved.


