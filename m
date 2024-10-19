Return-Path: <linux-nfs+bounces-7310-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D61799A4ED1
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Oct 2024 16:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B411DB25CD0
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Oct 2024 14:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16253186616;
	Sat, 19 Oct 2024 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z778nDCk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D814418C34B
	for <linux-nfs@vger.kernel.org>; Sat, 19 Oct 2024 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729349379; cv=none; b=DnRHlto10aJYYegPEGbejX1f6zL6lEBg1f2Rekg1v4Xq/Ggr/shJJ0/IzohUKIcDFXmozpv9pF8zzwpT+146G6+FHIwOQzlPAUXKzu8IGtdpnIYtR9+7Y2zOAkLLAi76viFEBRDriONpRDzNbN2orW/8Nfo3/baKEXXJpiHWH6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729349379; c=relaxed/simple;
	bh=2VLaJyQE9+9yrltFSTQ7B/5OgPjybfChXfU1tWjd6oc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Uoff4vyUZlBRA8eA88cpZjR+kU4rCdV9nwKlM3UP5JuxE2/8X5dk4hiCcVW4ABtEiv1kvW2hxDfpvQ0o5HXr0XHKjs7hrKggHuCNN7dmgaOZlAGNM2Y/pG1HLNm+dGpQojh/iW6RaKGnxV2szq1S7K2IVpS0ZvqE3iDdzQkZUv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z778nDCk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729349375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=httkPw+Y8CTgT3cQgVJq99l4VNeLqcFxUV61Rhrg63s=;
	b=Z778nDCk1NGkdD9se0mrAHuH8hK1kqXg4KVy5NTTssJInYIgrgKclZHdUfVK5SmQem/Mxo
	bQod5WqtpkAAAXkg+Z9RDv4SBGWnOboJk1nplWjAB9qQFwuqIpwrYMIZ77GS8WAdNcXkPZ
	0imiu+/asJbYq33a15Eu1Yuk4qv6Grc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-nmOllhfxNLeqlu0fkp1lcw-1; Sat, 19 Oct 2024 10:49:34 -0400
X-MC-Unique: nmOllhfxNLeqlu0fkp1lcw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cc10cd78e4so52517056d6.3
        for <linux-nfs@vger.kernel.org>; Sat, 19 Oct 2024 07:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729349373; x=1729954173;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=httkPw+Y8CTgT3cQgVJq99l4VNeLqcFxUV61Rhrg63s=;
        b=SV6jPaqIaQ7aZTmRLKDl+ScuUqPsyf9w37/uHngE1FEdHBuqssryAlrDZtz1UEffU6
         k7utXxg9vCAS7z78ode16Y1pywI8Z2hsuvEEUXdDckxIPh88ho5VmGeEX2DJoSZ2pMr/
         wobUd0cGtsxofK4j/HF/OMIZ/VEgBe1HRG12TrRWrP1IvWt97ON/lKktDN5pn2CINOt8
         PCUKFTOms4P3qIsTo3YebIHt51J3HkEYVWoyKPN2rE5AEmorWV9y6pwlWHfuvfCX9Hs3
         x6VhHzI8eYEw3uavv+tvqAdoCEYSHqGVxwjiFvc+ehLXwg8K39aEFEDwWfE/1mnEZW18
         nv/g==
X-Gm-Message-State: AOJu0Yy9PJAG/ixiLdQVdNNY4G5YaHl2LFj1/N5uBmLUWKNa9V25S9D3
	W+gbbSnHbvOEcL8vcS/t0jzDBUYE0FB8zE0kGdaPf1VZs+PTvtVPiv54DqwAb/PRhSTTGTkf4Op
	3kndk9quT0beaozKYYUxvqvEKdS4Be9HGw6noaI0vkKgmBelIU7nlj6AhNj6RXixw+JwUWzL+qG
	0PW3HVzLyD33XIeu+95TgSUyFWANrIAtwDHCE0AWk=
X-Received: by 2002:a05:6214:5b03:b0:6c7:c7ff:958e with SMTP id 6a1803df08f44-6cde150789amr83780866d6.18.1729349373350;
        Sat, 19 Oct 2024 07:49:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs0/A4OGrhXpZifxynAeUNjGSdw+2vmetaVhUZWMc0Uw9E5uAtlVKwqkMZCmTmzv1y1iWKGw==
X-Received: by 2002:a05:6214:5b03:b0:6c7:c7ff:958e with SMTP id 6a1803df08f44-6cde150789amr83780596d6.18.1729349372983;
        Sat, 19 Oct 2024 07:49:32 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.244.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde122cab3sm19541066d6.103.2024.10.19.07.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 07:49:32 -0700 (PDT)
Message-ID: <4a86eea3-973e-4535-8aa5-f3b8b5f7934d@redhat.com>
Date: Sat, 19 Oct 2024 10:49:30 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.8.1 released.
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

This release doesn't have a large number of patches
but a couple significant bug fixes and a new
method of starting the server, via the new
nfsdctl command, which is the reason I
bummed the version from 2.7 to 2.8

Also with the new nfsdctl command the default
number of nfsd threads is now 16 instead of 8.
Another reason for the version bump.


The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.1/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.1

The change log is in
    https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.1/2.8.1-Changelog
or
  
http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.1/2.8.1-Changelog


The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.


