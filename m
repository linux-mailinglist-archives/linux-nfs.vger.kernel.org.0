Return-Path: <linux-nfs+bounces-913-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E08148239EC
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 01:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654AE287D5F
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 00:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CB829B2;
	Thu,  4 Jan 2024 00:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KamHLNKK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7E92586
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 00:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704329859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/R3b3pbb8HNDlsjuZ5FavV7KpYSD08MEU0lwcW8jcwA=;
	b=KamHLNKKJLRK1zwrfn8E+VjFjm5JefMPw7+vhVAUytjXIcw1Y6eprl4KmTwkTn7sL3uzcJ
	dvcx1jVymKkCbdCwdW4vrP8sFWIFjl4oJ9irew8kBC5Uurrq4MV+bmA4B+wygRObs2SpwV
	+drB4jyihFi4y/wS4cklMnQzIWax4IY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-DlZMIdtfNG-jwjZw908xrA-1; Wed, 03 Jan 2024 19:57:38 -0500
X-MC-Unique: DlZMIdtfNG-jwjZw908xrA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-680b74cba78so12106d6.1
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jan 2024 16:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704329857; x=1704934657;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/R3b3pbb8HNDlsjuZ5FavV7KpYSD08MEU0lwcW8jcwA=;
        b=DQvRs8ihTV0aLJysv23E9QSymGu3YqyDZPDdOcAuWnuohrRuAlukCZOb4PiXz1vs/w
         9FQlKsFy5OLdXLSaAoc9s9VPmddnuUGHkBin+Af1HKixh8V/HJLioggUhvlsF1m+nnrb
         FCDPPK9SGRigRtPbxVQtHl2KdDs+EnSWNoRgpeuo9A79pjEc/smMH6npRtRv+7WOl7EV
         Fda6fYTKD0d+ztn+f0eD1eSZxK1p+yBm02jq0PIKBspkRaA5TuPswlMhuoXXTW/LWc9H
         ulWqCoJrz1aQN6XOKn1ZWd8shX366f+JMLvRAT65vzDfhL7ntQoqY+LLblyLqLivcG5X
         wtCA==
X-Gm-Message-State: AOJu0Yyyk3xIPWDdRIaNns17EK3azVe4rq0FZOYI5BCHc0gX21c+i7Q4
	czXDLvoaYs0u3+Sjx9Lb2RzSFFdriMLyCJ6+Q7okZMC9fsdbtI1BBL8P9mg6vjEwG/EvrAMGoJu
	DzlBSvKkq/V5osz87TGzoMnLSpFe6muKw5khm
X-Received: by 2002:a05:6214:5182:b0:67f:458f:bd5e with SMTP id kl2-20020a056214518200b0067f458fbd5emr40082203qvb.1.1704329857430;
        Wed, 03 Jan 2024 16:57:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3jmRRWKyowjLcEbuuVAzF9WwMFgaHbND0DktLcUWf/1q7qeuj41wG6YxbFity/pByXX1obw==
X-Received: by 2002:a05:6214:5182:b0:67f:458f:bd5e with SMTP id kl2-20020a056214518200b0067f458fbd5emr40082193qvb.1.1704329856964;
        Wed, 03 Jan 2024 16:57:36 -0800 (PST)
Received: from [172.31.1.12] ([70.109.152.76])
        by smtp.gmail.com with ESMTPSA id dp15-20020a05621409cf00b00680d2247031sm571253qvb.81.2024.01.03.16.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 16:57:36 -0800 (PST)
Message-ID: <309b84e2-4144-4ba4-abf4-f377da5c9ad2@redhat.com>
Date: Wed, 3 Jan 2024 19:57:35 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Typos and documentation fixes
Content-Language: en-US
To: Gioele Barabucci <gioele@svario.it>, linux-nfs@vger.kernel.org
References: <20231217145539.1380837-1-gioele@svario.it>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20231217145539.1380837-1-gioele@svario.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 12/17/23 9:55 AM, Gioele Barabucci wrote:
> Hi,
> 
> the following three patches fix a few typos detected by Debian's QA tool
> lintian. The last patch also adds Documentation= options to various
> service files.
> 
> Regards,
First of all thank you for doing this work... But
the first patch does not apply and there are no
Signed-off-by: Your name <email@address> on any
of the patches.

Which is the reason I didn't include them in
latest RC release. I'll be more that will to
take them but I need them to apply and have
the Signed-off-by line.

Thank you again... Looking forward to V2

steved.
> 
> Gioele Barabucci (3):
>    Fix typos in error messages
>    Fix typos in manpages
>    systemd: Add Documentation= option to service units
> 
>   support/export/export.c           | 2 +-
>   support/export/v4root.c           | 2 +-
>   systemd/nfs-blkmap.service        | 1 +
>   systemd/nfs-idmapd.service        | 1 +
>   systemd/nfs-mountd.service        | 1 +
>   systemd/nfs-server.service        | 1 +
>   systemd/nfsdcld.service           | 1 +
>   systemd/rpc-gssd.service.in       | 1 +
>   systemd/rpc-statd-notify.service  | 1 +
>   systemd/rpc-statd.service         | 1 +
>   systemd/rpc-svcgssd.service       | 1 +
>   utils/exportfs/exports.man        | 2 +-
>   utils/mount/mount_libmount.c      | 2 +-
>   utils/mount/nfs.man               | 4 ++--
>   utils/mount/nfsmount.conf.man     | 2 +-
>   utils/nfsdcld/nfsdcld.man         | 2 +-
>   utils/nfsdcltrack/nfsdcltrack.man | 2 +-
>   17 files changed, 18 insertions(+), 9 deletions(-)
> 


