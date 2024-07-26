Return-Path: <linux-nfs+bounces-5065-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C588E93D2E8
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 14:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF39DB21E64
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 12:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6579DE57E;
	Fri, 26 Jul 2024 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bK+vOWr9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757C82B9BB
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996574; cv=none; b=iydcxIgKqXyHLPr5mN/QiKe1x/Ba+wz1uuVhjinl4tiLPnDkTzpZ1Ps0jAG/qgP9ICtFF+JUHhlNploBHHWCVe/de7HO/wD5Rc/zUC7Ts/exZaxzduPs2PeaFzRmO+rPfiSxSiXR84XTbYuC2ZmdaZtfBC9plluV8Nu4v2kWPZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996574; c=relaxed/simple;
	bh=QJaAv3lq3MC/j2m38lm7+5wbe426G2T8i8t8FuU8n3c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=RTaRNkKAXGSCx2f5yTc5GGMvyRL5YEr0tsktDAc5pBy8EEPCTvyiyUvgT5GaerGUbKXAj9Y2SQ3ry8vzS+ML67YwBvi1xgQUDu5RcJTc3LOsUqaNmDIJ6gepJhDE7qucN4a5cDekWxhy2ZTV+WmPh8rZuzN++euT7uc4cHwXETY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bK+vOWr9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721996571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FhxmkvEQvlayOEIY5pj4zDZOLKLGRto1XEMwjF/Etf4=;
	b=bK+vOWr9s5QfkHSaPoYSM0aeDDWK2aP57+GJzMgnDrINdBOItdSYBJeyN0FreFwN5WZBwN
	Qpce9m16355WZGJQHdKR+B36fxGyaCVWTSGjuoVpKBm5O3WKFoGVH1yX4z/QFhYt8hqXWC
	5BxyQ0oUeWhorhqAsjwyH61rOFKcVf0=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-z3hMNMt5Pqq_ELlnC4yYzA-1; Fri, 26 Jul 2024 08:22:50 -0400
X-MC-Unique: z3hMNMt5Pqq_ELlnC4yYzA-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-492a80ad67cso141003137.1
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 05:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721996569; x=1722601369;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FhxmkvEQvlayOEIY5pj4zDZOLKLGRto1XEMwjF/Etf4=;
        b=BmtfR3g/Wxyf3X7J1JnDXuRklcVOUPMmGnPF9kg9M5hDzjMELReLIsr7PtM8cVcz2m
         BR+/BEO0d2I6O0xdmLymPR60HW/XDZrZ2PJBHbUa05P1haVtPj2LEwqQXvGFvPV4pQp1
         3UKglJRy/vIHgDYk8nHfYiOIQtzptfbbfirE5WRJ0jLjHKaJYUUIFvN1XpSHijTczF9I
         s5XLrh/1jj7bUtYctWT129NoIw/I+7k3p+D/+PNhenm7L2RqqwS4l+FWaHJobYTp+teQ
         /d+pOlPe/g+zWHYTT80dxeJ+oEPjHGxkFsK5CHMJUpNd/551RibSlhgE/gcUfODdqqOz
         13eQ==
X-Gm-Message-State: AOJu0Yz42KeQOkwRd2N3SP3+3aSgYhMxWKPx3yhUvf0T88B4KeZ3Xf9T
	wR+btgxuf7JzNOYTHBG1vWkiXmvFdC9oK7aHi47SHc8HvgDtoEaTRhuzP2gUV5CIqp7xIelzG0w
	cCNewTZlLdib8U+d4Xbkdlr37WE1BnoFYhhGbGwczYFv8zMIxr0GAVdJjXg==
X-Received: by 2002:a05:6102:6d4:b0:492:96ce:aaf with SMTP id ada2fe7eead31-493d824907dmr3676678137.2.1721996569529;
        Fri, 26 Jul 2024 05:22:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPbqRAPYiEjhEucl34huAglQR4Gr/CMH1wIYM2OcPYbt4n09y6uJ7joFrGWZB7v5rshsBiiw==
X-Received: by 2002:a05:6102:6d4:b0:492:96ce:aaf with SMTP id ada2fe7eead31-493d824907dmr3676665137.2.1721996569202;
        Fri, 26 Jul 2024 05:22:49 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.163.123])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe81265e9sm13240701cf.15.2024.07.26.05.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 05:22:48 -0700 (PDT)
Message-ID: <44f832d3-922a-4658-8b8b-bd6632be5de6@redhat.com>
Date: Fri, 26 Jul 2024 08:22:47 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: rpcbind-1.2.7 released.
To: libtirpc <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This release contains:
- rpcinfo: try connecting using abstract address.
- Listen on an AF_UNIX abstract address if supported.
- autotools/systemd: call rpcbind with -w only on enabled warm starts
- rpcbind: fix double free in init_transport

Both the tarball and change log can be found at
   http://sourceforge.net/projects/rpcbind

The git tree was moved to:
    git://linux-nfs.org/~steved/rpcbind.git

Please send comments/bugs to linux-nfs@vger.kernel.org and/or
libtirpc-devel@lists.sourceforge.net

steved.


