Return-Path: <linux-nfs+bounces-10957-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA3CA75BF1
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Mar 2025 21:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F2D3A83B8
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Mar 2025 19:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBFC1B87D9;
	Sun, 30 Mar 2025 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dngWXG2/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E89578F51
	for <linux-nfs@vger.kernel.org>; Sun, 30 Mar 2025 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743363464; cv=none; b=rejRRbzbHqwsP2EM/kj6S7qTAn+LfAVTLR9bcJu9grIT9wTL1I4YAAgFTbZPMIxIASthZjnN/yQb6nns4doIx1R0VzedebaDLOaaizvxK2RB87xjf5zUst/PseYrl375w6G9ujMXf56PYzwFcFBY5AiGAJkQCDQ6/qofSB8aW+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743363464; c=relaxed/simple;
	bh=FdSZJ7yjYtp0hGeVBZHMwHht2/XdwjBnyuoka0/dhxs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=N3cRglDDClzrq0E72iMtBt0culz4oXJ/I7VQeOCtlhTCSPbdmwB+9I4nijJj/cUPGZNwC8xU/uGp4TYhfOwy38566X72JHriH6KVQXImjCUu5By5FhkSammqcvASNZGcC/T7vCO9YFmREQKPfIrilCtrqI8XdszzjYgrCiBTkK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dngWXG2/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743363462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g5Xk8LqCMuC0hbWLeWvLxITG+yRsd8228TYUU/9Egww=;
	b=dngWXG2/nvtSMOvrPYM0zDo1K1iD4Ud+ZnibjxI4emwTkK653IfdCV4TS5+0gawrA7JVnm
	ufCwQ3PJaR57vtUdazDFyBrQZN4ni35RfltPgEAMmE7hRjr1YD2nlPt4WP9cQf1I9sRF9f
	kvSWQNjG3iEIlIBjEqRHXX4IDRcBIMQ=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-pOi0TTo8N4OCUxLjG3ergw-1; Sun, 30 Mar 2025 15:37:40 -0400
X-MC-Unique: pOi0TTo8N4OCUxLjG3ergw-1
X-Mimecast-MFC-AGG-ID: pOi0TTo8N4OCUxLjG3ergw_1743363459
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85e6b977ef2so701068839f.2
        for <linux-nfs@vger.kernel.org>; Sun, 30 Mar 2025 12:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743363458; x=1743968258;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g5Xk8LqCMuC0hbWLeWvLxITG+yRsd8228TYUU/9Egww=;
        b=lZlqPSfXxCEg5OovnSMjViykypLIZugXdmwrSHvNq/QWeCOuM0SSBBqIrCxGu43Z0/
         sc3VKfK6TpZzw/uAOUrPxa/o16yJ1EoWUY1BqQDCIqbWPzyj15d8BUXAMAAb15TMVnbY
         RxXSsBCt/QC5xwY9CfV3N0qMbv9AFG9zm5gOrHQ0M9zUSzt+vaZVnIlezu++bmy+M/V2
         fol2iDC8QI3Ht8WROW3fPmfLzkiHQI+sYk6O8GIz9x3DtzPiDquvJ8GIHAsRczybr5kh
         KoeqpxPtwoSPJvpD+Ugams0tFLbI3nUV18Ys1N4ek/26vEJCaP4MBnnCtl0b1U5yE6N7
         GuQA==
X-Gm-Message-State: AOJu0YzK+Og8TTIfXsitTBgXVvfOJbk5FtiA5KEHuHQwvMLPwbyov127
	MtZlQHXWjFbcWXt3dpU/XH8CrQz5Uc5m6XjglkIIUtUolTU4yYL00bN+7IFBOyqcbuH1UF4JTOd
	lUCwrI3pwL5THScaiuWlp7LW+WhdQP8JvsLX2xWtXBxaD2pZ2+VicbzmjNQjdNJydivbojB2Lgp
	QsVA1xWqo2iPAmiJldb7VCNvQaoF+gBNEHdAW5ebs=
X-Gm-Gg: ASbGnctJL7Gqfog5fHEHMk/07R/19wmcWT8C/eLllagD39T3Pl6gzorOZVeJjiIFTQ+
	am3PD/OxaLH8hczo3kD73NdUtaz5XIbd2Qgxrym4Euvan020HouxJBhIBaBNitVKJQn96k90OXD
	wMDybpgDemAZ0kttUcjRgYMwRV3I05O3izY/yy6UYe85BHnFWYVoKJrQrDHKXhY3YR779gGRbzd
	mYcWOl5j1X4l+50qyA+H9+J5WBsrQ2+sBBAHNU1r+/UfNHaWIUBnj4fOGBg9bMF08x2jc4rDQiA
	wopaMguqpD36B8M=
X-Received: by 2002:a05:6e02:1a2f:b0:3d3:fdb8:1796 with SMTP id e9e14a558f8ab-3d5e08e988dmr74579025ab.2.1743363458234;
        Sun, 30 Mar 2025 12:37:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3WLRKEv2ZX784wP0IJWPmDZbDgTMMLUXHCoabKGYQvtdraGugN8X5U+NxP/NHUj6r1Pqwxw==
X-Received: by 2002:a05:6e02:1a2f:b0:3d3:fdb8:1796 with SMTP id e9e14a558f8ab-3d5e08e988dmr74578885ab.2.1743363457908;
        Sun, 30 Mar 2025 12:37:37 -0700 (PDT)
Received: from [172.31.1.159] ([70.105.244.27])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d5d5ae9d5esm17051095ab.44.2025.03.30.12.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 12:37:36 -0700 (PDT)
Message-ID: <64a11de6-ca85-40ce-9235-954890b3a483@redhat.com>
Date: Sun, 30 Mar 2025 15:37:33 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.8.3 released.
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

The release has a number changes in time for
the upcoming Spring Bakeathon (May 12-16):

     * A number of man pages updates
     * Bug fixes for nfscld and gssd
     * New argument to nfsdctl as well as some bug fixes
     * Bug fixes to mountstats and nfsiostat
     * Updates to rpcctl

As well as miscellaneous other bug fixes see
the Changelog for details.

The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.3/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.3

The change log is in
    https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.3/2.8.3-Changelog
or
  http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.2/2.8.3-Changelog


The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.


