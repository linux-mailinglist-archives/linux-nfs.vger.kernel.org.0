Return-Path: <linux-nfs+bounces-5077-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A9993D8D1
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 20:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A670B1C20491
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 18:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B343218B;
	Fri, 26 Jul 2024 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrJh2sCK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AD52AF00
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722020304; cv=none; b=qvrGbOHgCEPq5SsVTIFD7KQHn4E4oCakNBqDMMt1kqk2FGArYlYAUuZda4pBAMHrDLMYRKPZnzu9tBZSUgZQqAqaPThUeLJm61Kj1ubqwqIpsPD9MDJbqtEWp1iM6qF20G9H1ksLm+RRVvQkQUU9vu9joFN5zkoNnKZzUrUxk1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722020304; c=relaxed/simple;
	bh=nUakbrJfg+QKYn1109X1cpcQVuiQJBOGGhPxuEbT67U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PZeE7mUTR9YLhKZUPCJXE5SID33HLKQ0uZePfZJLyYrzbQ6VKknLP/Sby+plPcxReddso3F+5du/U9BpWCUcbmv6pJITQSX7cJi/S75kbpbZOEvuQUjgEEL24IesPuEwq/ns8RMR5i8KgeyK46RxoD7GlH0PkcxcDk+vbpbhfN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JrJh2sCK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722020301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pp4TQ87L2TB+eAZRXMBcCzrJFST5ccSfuvIxMMg0kak=;
	b=JrJh2sCK/qtskObvlwKQM5imdQsnwd1JjWeq4cJPK5Ephx8SMa55O2tapflw1jh3SI3uZt
	RYwue7Y9+aQ9klBjmuLqoIEyvn/ztoUYhB0v+jMABhmja8QB7R4E/2bS0WW4dKQFCMCV8G
	CfeDewG1nH4egoLCGsTJJ4NKge2V5X8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-RKd8KCqqPAa164uEqFKR6w-1; Fri, 26 Jul 2024 14:58:20 -0400
X-MC-Unique: RKd8KCqqPAa164uEqFKR6w-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b7ad98c1f8so1951026d6.1
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 11:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722020298; x=1722625098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pp4TQ87L2TB+eAZRXMBcCzrJFST5ccSfuvIxMMg0kak=;
        b=vUfghx+11cGIeLJDI+MAzpcvt6ybt7cBsPbkms8qSLTtVUXhBGyQlhNr08jvlPgL9c
         taTYhY46Rl36U4+Vb9l/nsJbS2l6m6EQoF25AoxI/XnNS9Pl7biVaMqz0F3bK/WSG0vK
         9bXsNBbkfnyoVvqYKO5jkv1yO8eWLur0M5JWDaRxB0LLNtDo16r5FaR+pwrwRXnOfTuh
         2uqgO5nHspEfkkNyS6xntEpkAc7YWY0Et5l24xRB1yMOWca12+CQrDUQRNKhEKf+c/8N
         oHyyObhOGFTbUVpcO8QzbyBGRI6J+kV1J2SIDTpkLS4AFkBgxF32FB60c6BGpvj4O2ZQ
         hApg==
X-Forwarded-Encrypted: i=1; AJvYcCXxYkxvMc3ZblXF/ZQgccfWwA/UJQYUXnnnP6k8tx0jojriYPXAxUDJGEdU0GJJoqMr9eM9QQYxF70=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq9r9d7dM+UzaBvI0JPNhl4JimEpMjNDnONcnMlR7IxyWA5rds
	qVYcIDpznq3GS0vmMlA+LhcEj/uUlrxgdJ3kS4e7CwOywow7VPCnpIl/vVZZFPYujuXP5pnwN0o
	hHOZ4wx30FNJq8KsBuRB8d6SuRwrhiO4EDVtde/Q/79okV0Cs8Ss265C2eXN8S97ROw==
X-Received: by 2002:a05:620a:258f:b0:79e:f821:aaf6 with SMTP id af79cd13be357-7a1d68f611bmr456044685a.2.1722020298323;
        Fri, 26 Jul 2024 11:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKxW9tM6vASiJb3BVfLWlNYZbzadtLDgdjzLHRRp6FXKE04ghquTxld2GvVLlGb6KMr6etkQ==
X-Received: by 2002:a05:620a:258f:b0:79e:f821:aaf6 with SMTP id af79cd13be357-7a1d68f611bmr456043185a.2.1722020297829;
        Fri, 26 Jul 2024 11:58:17 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.163.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73b379csm202845485a.42.2024.07.26.11.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 11:58:17 -0700 (PDT)
Message-ID: <271e909b-1930-437e-bf0a-81b3d0dd6327@redhat.com>
Date: Fri, 26 Jul 2024 14:58:15 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch for small typo in nfsmount.conf
To: Matthew Comben <matthew@dockstudios.co.uk>, linux-nfs@vger.kernel.org
References: <CAJw_U8fKkq25Ft_82MasFA2WQLHh4Vv+8af7DfHFbH6R0KmF1w@mail.gmail.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <CAJw_U8fKkq25Ft_82MasFA2WQLHh4Vv+8af7DfHFbH6R0KmF1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/26/24 5:14 AM, Matthew Comben wrote:
> Dear NFS maintainers,
> 
> I found this small typo (and appreciate it may seem like a waste of your 
> time). But I've prepared a patch to correct (as I currently interpret 
> the comment), if you are interested in it :)
> 
> Apologies in advance if I have prepared this patch incorrectly - I did 
> no see any specific information in the "about" of 
> https://git.kernel.org/pub/scm/linux/kernel/git/rw/nfs-utils.git/about 
> <https://git.kernel.org/pub/scm/linux/kernel/git/rw/nfs-utils.git/about>
> 
> Many thanks
> Matt
You got everything right but in-lining the patch
which I'm doing... next time use git format-patch to
mail the patch.


 From c9914069f4e39f28d9f6805b2b3bd8a2eac41466 Mon Sep 17 00:00:00 2001
From: Matthew John <matthew@dockstudios.co.uk>
Date: Fri, 26 Jul 2024 10:08:30 +0100
Subject: [PATCH] Fix typo/syntax issues in nfsmount config comments about
  noatime and fix minor whitespace changes

Signed-off-by: Matthew John <matthew@dockstudios.co.uk>
---
  utils/mount/nfsmount.conf | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/utils/mount/nfsmount.conf b/utils/mount/nfsmount.conf
index c498eb80..d8e685aa 100644
--- a/utils/mount/nfsmount.conf
+++ b/utils/mount/nfsmount.conf
@@ -130,15 +130,15 @@
  # Server Port
  # Port=2049
  #
-# RPCGSS security flavors
+# RPCGSS security flavors
  # [none, sys, krb5, krb5i, krb5p ]
  # Sec=sys
  #
  # Allow Signals to interrupt file operations
  # Intr=True
  #
-# Specifies  how the kernel manages its cache of directory
+# Specifies how the kernel manages its cache of directory
  # Lookupcache=all|none|pos|positive
  #
-# Turn of the caching of that access time
+# Turn off the caching of access time
  # noatime=True


