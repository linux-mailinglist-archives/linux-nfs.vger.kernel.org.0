Return-Path: <linux-nfs+bounces-7218-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5C29A1CDF
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 10:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB08283E94
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 08:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451821D27BA;
	Thu, 17 Oct 2024 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jS4p8cqu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2326C1C2447
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152908; cv=none; b=UDGyPRN8/Ik0pGEjUM5kicDB1W6Dn6TDY6sBI1uKL1e9GVvWM5VXdvuLIMOJ4yoc3cfHP/DjX3WjsVny3H+A/01F/J67Rgmkdco+bnCPKnXhsecHx04uBCRT1g5nz07/s0Nt+cCZCS660+1wnOfuNyoLplHBr7I+3O74KxtZdps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152908; c=relaxed/simple;
	bh=+Xqi+WLwaR9oJERKb7atDiFoHpyxO2mxGEAKS7vzKuU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=cLMG5+f0m7oHA5WAh43GTOzaMCl2caSFuGSGVjPuL3xWmOVGaHeNMTVBFvpTU+IbAk0QgLfKdYZfDlfHXIQQyywl+OfI7Bw/dFlG+MtITMnWmH4SbQsFIpg7VVH/DQOgN+FV93cKOQ/gpTiRqUDZY9m811GptiDH1JEII9Cbv00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jS4p8cqu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729152904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WRw5eiYVYVuiU/gn9bnnVEXSieCmXb3bd2lkMP3kTGM=;
	b=jS4p8cquOWP8xd40M9G2pcGcru2qzEMxU9xEaiytXoizibrDwLI+XmxH/cgajbMorXjxXP
	K22dAodkQLN5z6FAPqSwqengsQzR1KJXkn2KdVz/9hpNKfqCw/AZT0UQxPef2O8+RHTLc1
	Vb8auBv504L1PSA2MSZ13WDxMAU3cT0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-1xYggoP6MsmevKdvC7fzqw-1; Thu, 17 Oct 2024 04:15:02 -0400
X-MC-Unique: 1xYggoP6MsmevKdvC7fzqw-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-690404fd230so13651047b3.3
        for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 01:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729152902; x=1729757702;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WRw5eiYVYVuiU/gn9bnnVEXSieCmXb3bd2lkMP3kTGM=;
        b=LV73pP87vRE7wx8ih8/0YPM1LjCewPe2MNx3MC9uwkTca0mptsJDReC88yI2CJF5a8
         uAThvbgQzGmDb3ca2fT0zD8gdLdYLZVRQONEvl+IGeVltKt9UeWN+VV/rMg/s72WAvJT
         AZAEjtTYGutjs5V4K8hwaX0klb69t+X8S/5/k2eMu0tVJQAbc5QhljEbVGjPzm0rnLvu
         oWmYfjldej8zcuQRbsV3RJkh6SvKusWahGP9W1ec8oyZigpWN3CtuvlZXSwPa8l+1wBw
         6m1dDZXSSDDBAl0vc+Dfd5UcIqh8NlX3qYUy10GCShy6dL5NAV8Xk5H3Nvjp65bVZUqm
         1DLg==
X-Gm-Message-State: AOJu0YxlqABgOo2CMYwp2krzGQOzdgbPAxS7vGCkRZdV8kjSx55HQtmM
	69wg7eS/c1gKE9wCKBTpWpSgLos2OfA3M0AXSFSxBsAxfli+DFFL1zUuTXvrqKp3jyyKw7fHF7y
	LfMKNVonpaJjwrWodU4T21eGEmAFGQylmzq/fBdWBEA3w9+gd9gE0rZ01NA==
X-Received: by 2002:a05:690c:dd1:b0:6e2:1467:17b4 with SMTP id 00721157ae682-6e3477c0195mr169229267b3.9.1729152902292;
        Thu, 17 Oct 2024 01:15:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFRIzpL9NWORnsXcpDTn85CPCK3flf6nxkWebVnb03wLauEXl9EcxjZNV5ouUELCEI936Gog==
X-Received: by 2002:a05:690c:dd1:b0:6e2:1467:17b4 with SMTP id 00721157ae682-6e3477c0195mr169229207b3.9.1729152902044;
        Thu, 17 Oct 2024 01:15:02 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.132.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2f6121f4sm14362106d6.36.2024.10.17.01.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 01:15:01 -0700 (PDT)
Message-ID: <91ef3508-d0a6-48db-adfc-4f7831fba74e@redhat.com>
Date: Thu, 17 Oct 2024 04:15:00 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: libtirpc-1.2.6 released.
To: libtirpc <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

The 1.2.6 version of libtirpc has just been release.

Minor release... a couple rpcbind config changes and
a few configuration changes for macOS.

The tarball:
  
http://sourceforge.net/projects/libtirpc/files/libtirpc/1.2.6/libtirpc-1.2.6.tar.bz2

Release notes:
  
http://sourceforge.net/projects/libtirpc/files/libtirpc/1.2.6/Release-1.2.6.txt

The git tree is at:
    git://linux-nfs.org/~steved/libtirpc


steved.


