Return-Path: <linux-nfs+bounces-2958-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A52B8AEAF3
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 17:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80CA1F239A3
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 15:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BB913BC20;
	Tue, 23 Apr 2024 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAqqrjwr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EA3101D5
	for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885852; cv=none; b=fqz01K7lfFH0CS0I5YHuyT6SBDh82VIIog6Yh48iy71ol1f/DWZkP7BhwX+DPzhhwaBNaVGUV/jL7sNK7ljt+87jhqz0gfx+AvMPd26CL9B5A41grj720QK9fKLWKj5Z7m+fLrI/41nL7r2GQaFbcSi0fF5L6pcF2Cd/JBheSEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885852; c=relaxed/simple;
	bh=/8ESvb95h//sd0V4pE0ryTnsImWf1WzS7ZbyZKqypbw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=GYkZvLwgctNL84BmKLhZObJgf1mDGphgIuVVIYMx01GI+hle7EfTlkuvpWYfguvjxfExTeLXU6rmRTqe9W8cv8EDoXEqEPgq45ImtQxysnq1LujtYOpNMQ1lvT6KRBoA5SiI+y7bfqAXYXTMBwz6fnLPjGlKVN6WERUYv/g8YVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CAqqrjwr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713885849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2WEjxmocXX1KZ3zmIcakq4+Ou/8Gurk2HE7lGNvkio=;
	b=CAqqrjwrUWVJAk8PoCa8WDdwjC8ERjynBgqqdE/9Gi4Q9VGMVZPu4JXtnsorBpMtk0UXIH
	LZ9mGHGDa4mnv/sYHMjzVcE54C1tOXydDOYir5lccJH9ysQtgKZEVWBjf7u9foD+X1jtvi
	aETa1pSBxVrbRQVLrOld79Z5KNMyQdE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-hV_a4Vt9PxuHU0IKFLRNJw-1; Tue, 23 Apr 2024 11:24:08 -0400
X-MC-Unique: hV_a4Vt9PxuHU0IKFLRNJw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-436e2928e01so5214531cf.0
        for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 08:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713885842; x=1714490642;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2WEjxmocXX1KZ3zmIcakq4+Ou/8Gurk2HE7lGNvkio=;
        b=nzLXMTNtKJpS+daH+MmvdUgXm1JaT7QhhNEwSjwRbEZ4rmUmhGYMDBWzELfhh1Pvi4
         wAEe0fI2Lw/SmLzU7YhHbIb2pOdYDqw/IryQl7/+edFSWpWbDV+Qx6zY8jJOH8UXI2DV
         jImTYp0SgIXvPgRrPz2mfBNaqsRV+B6dfxai5suP63lWKST3jCcNh1pxx/jnojZ7QWEa
         g0rPp7N6eBHnDer/uL19eK2QCT3GwfE4+lXwjJULnYe30hlrXkWuDWUIZByh56XKx+rE
         KLgpyCU+B75yl7FezEcDERVQs0BYs07RnQkcJ50Vo9jgSx8rTZv/eJJd6Aq05hutiO4t
         96Hg==
X-Gm-Message-State: AOJu0YyILTVtvnVZ7VJ2shIARWixHptVJ00yLGEx3JMAAqmRkO9gBjRM
	5sssGeDGZOcBzWG5tBB/JVAvZMdvhFDjwrULEa0kRnqStLJVllccTjgmYRFDZbIXdAwCA5wl8p+
	C3cZiK+7lizvPgZ9rhwPlCso2aZbBtR1C3phPj0S1dlgTUryAarFzH5AZSyo0/OGBrCy7RXm/l7
	Qg8zt8m5qmYi2MvQazteL6s/gsYToqd2dypnNCMl0=
X-Received: by 2002:ac8:688c:0:b0:437:ca6d:13f1 with SMTP id m12-20020ac8688c000000b00437ca6d13f1mr11604651qtq.2.1713885842410;
        Tue, 23 Apr 2024 08:24:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEd0d98uvoXdQbpJkJ5o9WvxpMAlkOCZZGwXcqwT2PHljChQYugARfVysUY0Bi6sKmJ+t+CQ==
X-Received: by 2002:ac8:688c:0:b0:437:ca6d:13f1 with SMTP id m12-20020ac8688c000000b00437ca6d13f1mr11604622qtq.2.1713885841856;
        Tue, 23 Apr 2024 08:24:01 -0700 (PDT)
Received: from [10.19.60.48] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j23-20020ac84417000000b004343d021503sm5218679qtn.67.2024.04.23.08.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:24:01 -0700 (PDT)
Message-ID: <fcee8bd6-f9b3-4ad3-9d03-6e59fc24dc17@redhat.com>
Date: Tue, 23 Apr 2024 11:23:59 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Update: Bakeathon: Talks at 2 (EST)
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <88cf691a-0f47-405e-acc8-91b3a05e8940@redhat.com>
Content-Language: en-US
In-Reply-To: <88cf691a-0f47-405e-acc8-91b3a05e8940@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Updated meeting link
   https://meet.google.com/bxz-fzzs-bme

See you at 2pm EST

steved.


On 4/23/24 8:16 AM, Steve Dickson wrote:
> Hello
> 
> Today we are starting "talks at 2" [1] during
> the ongoing Bake-a-thon [2]
> 
> The talks are open to everyone via google meet [3]
> 
> Today: The future of V3 (no slides... very informal) Just looking for 
> thoughts
> 
> Wed: kdevops BoF: How kdevops is used for testing Linux NFSD, next 
> steps, open discussion
> 
> Thur: nfstest BoF: Q&A, what's in the pipeline, enhancement requests, 
> open discussion
> 
> steved.
> 
> [1] 
> https://docs.google.com/spreadsheets/d/1-wmA_t4fp7X5WvshYPnB-0vHeMpoQMohim2Kb7Gx9z0/edit#gid=1920779269
> [2] http://www.nfsv4bat.org/Events/2024/Apr/BAT/index.html
> [3] https://meet.google.com/gyu-kmxt-rke


