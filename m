Return-Path: <linux-nfs+bounces-13265-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45124B12F77
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Jul 2025 14:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FE8188AD31
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Jul 2025 12:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4622E212B3D;
	Sun, 27 Jul 2025 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCnDFuMX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA7220B7FE
	for <linux-nfs@vger.kernel.org>; Sun, 27 Jul 2025 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753619382; cv=none; b=m6UpCTxIcEdaAAYMCC/dthINB6g9H0iUiHIrHMVGRxgIr1lmPmqT7KHkl7Ngk3F7Mf5FRXv5HbP9JR9mN5BqDEkFcPj1niaw/lUInx3Fzy8z4pzdgNMrg7nl+M0YkMbBmRLEgb9Hql3pykIpBix2pgCWBt2fq1rpXjZ71UoXr2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753619382; c=relaxed/simple;
	bh=9RgZ4c0A1jwhqbJfZO4K5K2jFbG85pykJdcR+6p1O/w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Q40UCudBLMG8h77gQiA/eWBA+p1JuSB6hj3NpB6izEChCcvv/Szm40w4NjcV005RaZYhr4l3n9UGomd8Kl5hjFzEE8j5dAx0y6tc96DRBdCoput95Qv0O03xpCycI8nBBijov5HiF0qn3hGIBbHY2IbNIkpnLx8mFcsSwqURc0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCnDFuMX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753619379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xTtOU5sBjJweaBmskNdX/Q2AVfNzl4oGFuC+RoKRN0A=;
	b=XCnDFuMXP780vQ8BZdwuggq6OmwuNwNMWEFgXzhj1VScKkTRfo+Js76K/Fy9Xfha+1ji97
	UEQHa0gGr5wRejqaJMa3nKGe+JnC91ZHssaUbJF1XMl29GTErdygNpcnXk7Y6LzTA2lWzY
	C8yFoM+C7fk8e3QpmPEKjPtj0ho+wpI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-ipy_G77SOBWeGL371axe8g-1; Sun, 27 Jul 2025 08:29:37 -0400
X-MC-Unique: ipy_G77SOBWeGL371axe8g-1
X-Mimecast-MFC-AGG-ID: ipy_G77SOBWeGL371axe8g_1753619377
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70744318bdfso11303696d6.3
        for <linux-nfs@vger.kernel.org>; Sun, 27 Jul 2025 05:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753619377; x=1754224177;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xTtOU5sBjJweaBmskNdX/Q2AVfNzl4oGFuC+RoKRN0A=;
        b=W0s2o8trX5F64g2/cV3fvNac43WwiEIESqcU/93Yi3GDN2W+8Fqy5G+0Aw54BOvZCN
         H+IhJ2UeusjNsigzJB2eI+9zmK0FN57Y3LS/biU19AOyAvGBs2s2JRYHKCls8EfFXocC
         UbKUBCtxHPu+aInYcUX2mpIXTdcLZFNzcjRZoUqpatgPakqPWfQlEQlAEvjC/X9wTh1k
         DE6Ky/JgmK2is8wx+6PiRB8lOAYFonCY7MiPXQkXaNmfHN3w/5lqMH+nsNvU9qQ+zmOV
         yVhF+BkNnRAmV4AD9BBjcx7UOxBkvvmUqlQnLt/NgTLIA28oCBcV5qBF9T8eLsbWcxa8
         8tOw==
X-Gm-Message-State: AOJu0Yy9WAyzHo204+N4Rq2rWLbWnNZkfkYayXfqmLBs6Og91jStnoyN
	499xGPT817SbpEu7RwG2E0UiAF7iTaHhRmFEZVygS2f2Jfpo4vo1xKqWovjv+YEbFqE5z9lopjG
	le9ZrSDyWZSFRXq86Uj2Xd1XB9VhfxrT/Jo1Jnh8p4oyiXhLU9iulzE4ugqGBFQ==
X-Gm-Gg: ASbGncsjfapsnlPf7mJ8dDpqqTLwghlNUN7HC1WJBIImSSYK9wlbCMcvl2NiR7WPqFb
	FjAE4egaNCIrHn9hBdhbk3tIoWSwCVSRm43TzrzbuHlVZf8IMqYIHd62bMSVb3NJWc2vR3SV381
	p9gKiORJvCWONw56xRvsLeu52vUqACAHQTk060ufXdDg9H/buQ+RpQWBoQ/iBFZXIJ/pNtAgSRs
	FMEfykvKqNztoQ3Tw2MVwkYVF4MOFoY0T/dt/SytdUB+QsajyrkCj7Z2sWeRyzMWHhmYVHoccZH
	wOWXd2xh0+60u0dOG89oW8IiRQ2ucC9D6cUrPAH/
X-Received: by 2002:a05:6214:300c:b0:6e8:ddf6:d11e with SMTP id 6a1803df08f44-707205413ddmr123821906d6.21.1753619377050;
        Sun, 27 Jul 2025 05:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkb5z1if33aqITQk0CzAjrA6ko0KBrEMPbJD4mvgvUc48qeCyPSh6JiCuSsCL3yGB+F1+WTw==
X-Received: by 2002:a05:6214:300c:b0:6e8:ddf6:d11e with SMTP id 6a1803df08f44-707205413ddmr123821566d6.21.1753619376643;
        Sun, 27 Jul 2025 05:29:36 -0700 (PDT)
Received: from [172.31.1.136] ([70.105.240.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729ad99d0sm19894126d6.46.2025.07.27.05.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jul 2025 05:29:35 -0700 (PDT)
Message-ID: <b553cc5a-46eb-453b-80f0-cfe69ccb7b21@redhat.com>
Date: Sun, 27 Jul 2025 08:29:34 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: rpcbind-1.2.8 released.
To: libtirpc <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This release contains:
- Added in compile info to -v flag to show
   what compile defines are set.
- A number of systemd updates/bug fixes.
- A number of manpage updates.
- Moved rpcbind.lock and default configs to /run instead of /var/run
- A couple of bug fixes

Thanks to Petr Vorel <pvorel@suse.cz> for doing most
of the work.

Both the tarball and change log can be found at
   http://sourceforge.net/projects/rpcbind

The git tree was moved to:
    git://linux-nfs.org/~steved/rpcbind.git

Please send comments/bugs to linux-nfs@vger.kernel.org and/or
libtirpc-devel@lists.sourceforge.net

steved.


