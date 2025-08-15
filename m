Return-Path: <linux-nfs+bounces-13678-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B279B283C1
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 18:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF10E5C0B12
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 16:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A6E1EE7DC;
	Fri, 15 Aug 2025 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVCrpc1C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED411227B9F
	for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275002; cv=none; b=nPbbJsf4G3J00E8A6FzbTaLdVQ2fqTJzX+Hl9M124TN5QO8ygVQGSW37R0i5xj/inZqZSWDkOn7YUKI0A+W/sCfe09KUAXkUFll1ot7t+xKAquVCNtpY7c398fzsDfurQoV6SkH5fy02a6dZHzHoBojdSUwnRAI1RBKLanoU0LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275002; c=relaxed/simple;
	bh=jspMvQ1kpvYiRBeRmegWBKyH0g1bnT7TRjpUNBzRRvA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=XgYoAdVKpWrL8FFTGRc1frqS9JAIKaX4Vg1r47N2sf1nqkVwtuIetOayy+r0eS8HiK4Iexzcwe36619QjzwED8mptP0rw6T2N0NbvLiRAaEKHFBStnRUl+18R4KUGBZvAZ118uPMSwji/vSy4xtZOkh4GLsXX3Z+/Vp9gDdndeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVCrpc1C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755274999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4kl0pvKbHNDKaiTbluQzTJQoKkEPOzfEQpayor54VSU=;
	b=eVCrpc1CXtVrZOaoJOtF9datD2Enn8S3/eBJDt9OH35ywX1EQ67Ax4KYyUSme03/4auyFq
	eTiyldIU61rFF4VqlsOFaXysaqpGNwroXbLJxq/2FE6IllpLkGSBQuxjftWx5m4gjVlimX
	oQZNz7H0czGpAF8XfgIovipcvy8n74c=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-_N5AtEl5OOuhYdxyWa-Ylg-1; Fri, 15 Aug 2025 12:23:18 -0400
X-MC-Unique: _N5AtEl5OOuhYdxyWa-Ylg-1
X-Mimecast-MFC-AGG-ID: _N5AtEl5OOuhYdxyWa-Ylg_1755274998
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b1292b00cfso140371cf.3
        for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 09:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755274997; x=1755879797;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4kl0pvKbHNDKaiTbluQzTJQoKkEPOzfEQpayor54VSU=;
        b=D1QGajORazbSGYZj//WjF6KJjLJj710vr3XLAQ7HTE7VbN6y7cGJcZABWCdBzMf9w8
         feX+Q6p639lZnj3Ir4QjUk0jSyW9UOVPLunD4buqn14fcmSOTD1F6fKycwtkr/QqCRQa
         Fh9HxfL7nvO0GdvN9qronPrbm+jYAJgMH18ycOzQAudhiB4V9CdLrUHU3oFQi3HdnI73
         Z5KpOZSZ/BgTrRfFqrJEXq2muAffLU8FGhMSlWRa/nhCjs+pdQP5LttsLQcpU9SKm3er
         66lt4qIMN5sW2SIwJX8PnLo58M4frDPrv1ZE5QYumvgerGOhikG9Yz/lBMTV5y2y7qnj
         zicw==
X-Gm-Message-State: AOJu0YxOmv/0UFaAhC9KNuzcZEglP2pi287BJB+0s/mqp3FpHaaJTmBI
	CeVtPscpjXP4ETJBp14E4uuPYEifGh5AS3iTndINKXsiiV7qSHRgUUhD9piZduWSg4koY76jic8
	Rkqz5S7c6ReoLLiyqcdZxRx6Kobg7V0i/w48rNpfdwD9dGhFZZIl+bdZLSXGcMZ/xvDE1pw==
X-Gm-Gg: ASbGncva/vxPPSIqu3I5OwatuFy1lqFe3zV5b5HZ3IWZIYt9H7gaLT1utltUoouGpNt
	9dPIgCB3pHpCo2ZZrtmKskVE2IwxFNOo3agdJVTRC/MCGemt8zViReVE1Ac+h63aPMVRVzJAVAn
	IZb67CwAzZpRrwlDo8pDlIC7UCQyOGswgU7CHgrlDD/7r/M9eZQFf4UoB7hBEDC2nsxR6MefiJC
	88w1xjqqGcVtmYLj1FuE0qTaiFet/NqthlSnLI+4BS37JcCDb1CD6E0NUVW3u583ZA3wYjTXuuD
	8dSh3m4m3WDqV+haHpVvpslkyybFteN4ELcT1LCs
X-Received: by 2002:ac8:5aca:0:b0:4b0:7b0a:8985 with SMTP id d75a77b69052e-4b11e12186cmr38330261cf.22.1755274996640;
        Fri, 15 Aug 2025 09:23:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExrSt4umKeBc3xstkG2AgKwL0TAS2fdHZgRacL9a5PV4EJhdI/7oSqzBCxDk/vo5jiMnn3WA==
X-Received: by 2002:ac8:5aca:0:b0:4b0:7b0a:8985 with SMTP id d75a77b69052e-4b11e12186cmr38329881cf.22.1755274996185;
        Fri, 15 Aug 2025 09:23:16 -0700 (PDT)
Received: from [172.31.1.136] ([70.105.250.115])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11de1a63esm11428661cf.47.2025.08.15.09.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 09:23:15 -0700 (PDT)
Message-ID: <482e394f-67bc-48bf-88e4-3808f508737e@redhat.com>
Date: Fri, 15 Aug 2025 12:23:14 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: libtirpc <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
From: Steve Dickson <steved@redhat.com>
Subject: -Wold-style-definition warnings
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On the more recent gcc version (15.1.1) the
-Wold-style-definition flag is set by default.

This causes
     warning: old-style function definition [-Wold-style-definition]

warnings when functions are defined like

int add(a, b)
int a;
int b;
{}

instead of like this

int add(int a, int b)
{}

Now I did fix these warnings in the latest rpcbind
release... But libtirpc is a different story.

I would have to change almost every single function
in the library to remove these warnings or add I
could add -Wno-old-style-definition to the CFLAGS.

Now I'm more that willing to do the work... Heck
I'm halfway through... But does it make sense to
change the foot print of every function for a
warning that may not make any sense?

Thoughts...

tia,

steved.


