Return-Path: <linux-nfs+bounces-2300-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B7087CDD1
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Mar 2024 14:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802991F214EA
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Mar 2024 13:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8632E636;
	Fri, 15 Mar 2024 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOrOyOBW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3409B2E62D
	for <linux-nfs@vger.kernel.org>; Fri, 15 Mar 2024 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508292; cv=none; b=A9JHH/E2MtL/fnpsErqzYNOv8e37p8NgkR6btZI7U0tFFd3jS/rBPYGVR6O3gQaRsZDSUC/2TLhGB/zq8c5qFD5HHhgOoVNpu0NBlB/MQBn1SzGtXKXUEispDf3BL/8mBq6o4GwUvV/KEx+UNb7t81Lp2wBiegzlJcLnaq5CGlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508292; c=relaxed/simple;
	bh=kOYuYrODL1GXO0ovwsvGmmvaeKec+kFZz5thzbSeu8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGzRCOY+XQ3c4EQ3g4V6nVjyegkaoc89o2tCWexObBsZpLJUMbb9zpCEbsDA8bHG8tOeuE12DTDKZMnUN+4DVIszHnHCY+wQONgXDqSQ/5SvlTAFG6VDwNwF/ADWdlZNxTk45QO5LVTjrbNGCaiXzwbezLn44GrijHRuPY5JwKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JOrOyOBW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710508289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEG5tzwwmmlmljsn9YxmchudSfQWz7skLUcfz+CLUDY=;
	b=JOrOyOBW6Nx1SNyhBUjv71vxbZGp6Wnoi7laYi3GGUBiewOK7GK3NuZvkPKcVDHGZlaQfc
	IPiKS0kTPeJK7eLatiqScQNFw1kei7R7i5oJRb1Mlp2c6H8GW/4/FvD3daBl045NwPvULu
	XmUUHmggPnLgl8M2KAwjvBPiwgKs0lE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-BocG5Xx2O2OZi0j9a8WzhQ-1; Fri, 15 Mar 2024 09:11:27 -0400
X-MC-Unique: BocG5Xx2O2OZi0j9a8WzhQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6912513fc7bso11185776d6.1
        for <linux-nfs@vger.kernel.org>; Fri, 15 Mar 2024 06:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710508286; x=1711113086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eEG5tzwwmmlmljsn9YxmchudSfQWz7skLUcfz+CLUDY=;
        b=dNUf4UjP1y0flBCoPn2j65ZBKWnZns6FdjdJpXu48zSwIriKUAF8jP4pbEenawqHiY
         LDDRAn9k0SPLNtvuVk011+ojE4h9eWjO6SrZe3CXbKC4gmjLbILWb2MdxRnRx5Wn+d4a
         FovjcdFnc+qSZec1noCPFlwurUp2rhPxq4FzVtINfVgnTUVXxZSjUXNA+061w2Fws9iw
         tIT+qUWgnD7Jug2HqLfQ97QfhJfEIJ+mvBavD4xBpsVV3IGPqiErp4+cHm1Bgdb8Q5zN
         FTuasM8FwPhUTRYU1FAwAmkWH3rzaEB56BxFiv2RFXZVLj7WmhFNVkyiYQAyfgi73d9K
         R8tw==
X-Gm-Message-State: AOJu0YwIVz1/E1WtchJkPyCFE0BbEAt9lPzBXsbGso3bRIdqt2860yDe
	JdzaVQNbtZO42nJEGVJugagGk4A3BW3dmcLOnQ0ZHZKgUEK4o/U/0jk3F1/NYw2wusSwWIUUM69
	+qr5F3RB23Q7eQJtdeBKTqiMtVDdGDm5KPmSP2824/zBMjiWypPB3SPmanfuQPybn3g==
X-Received: by 2002:a05:6214:459e:b0:68f:1c80:d78e with SMTP id op30-20020a056214459e00b0068f1c80d78emr5111902qvb.0.1710508286409;
        Fri, 15 Mar 2024 06:11:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIRw1Pok3crahOPNj2HoTvYhJyfp18MklCxqRlE+nSsW0EbA6s8uVgi/s70KpnONL/Hok4rQ==
X-Received: by 2002:a05:6214:459e:b0:68f:1c80:d78e with SMTP id op30-20020a056214459e00b0068f1c80d78emr5111875qvb.0.1710508286076;
        Fri, 15 Mar 2024 06:11:26 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.251.209])
        by smtp.gmail.com with ESMTPSA id gy10-20020a056214242a00b0068f6e1c3582sm1939942qvb.146.2024.03.15.06.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 06:11:25 -0700 (PDT)
Message-ID: <8f246658-2131-48b0-90fe-404cb8f8097b@redhat.com>
Date: Fri, 15 Mar 2024 09:11:22 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] start-statd: use flock -x instead of -e for
 busybox compatibility
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, kernel@pengutronix.de
References: <20240228185644.2743036-1-a.fatoum@pengutronix.de>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240228185644.2743036-1-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/28/24 1:56 PM, Ahmad Fatoum wrote:
> busybox flock(1) only supports -x and not -e. util-linux flock(1)
> treats both -e and -x the same, documents them both in its man page,
> but lists only -x in its help output.
> 
> Referring to util-linux git, it seems both options were added between
> util-linux-2.13-pre1 and util-linux-2.13-pre2 back in 2006, so there
> should be no harm in switching over to flock -x to avoid confusing
> error output when attempting to mount a NFS on a busybox system:
> 
>    $ mount -t nfs 192.168.2.13:/home/afa/nfsroot/imx8mn-evk /mnt
>    flock: invalid option -- 'e'
>    BusyBox v1.36.0 () multi-call binary.
> 
>    Usage: flock [-sxun] FD | { FILE [-c] PROG ARGS }
> 
>    [Un]lock file descriptor, or lock FILE, run PROG
> 
>            -s      Shared lock
>            -x      Exclusive lock (default)
>            -u      Unlock FD
>            -n      Fail rather than wait
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Committed... (tag  nfs-utils-2-7-1-rc5)

I like that fact the lock is explicitly
set... takes out the guess work.

steved.
> ---
>   utils/statd/start-statd | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/statd/start-statd b/utils/statd/start-statd
> index b11a7d91a7f6..67a2f4ad8e0e 100755
> --- a/utils/statd/start-statd
> +++ b/utils/statd/start-statd
> @@ -8,7 +8,7 @@ PATH="/sbin:/usr/sbin:/bin:/usr/bin"
>   
>   # Use flock to serialize the running of this script
>   exec 9> /run/rpc.statd.lock
> -flock -e 9
> +flock -x 9
>   
>   if [ -s /run/rpc.statd.pid ] &&
>          [ "1$(cat /run/rpc.statd.pid)" -gt 1 ] &&


