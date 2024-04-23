Return-Path: <linux-nfs+bounces-2942-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286BD8AE33B
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 13:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C851F22A22
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 11:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3841D18645;
	Tue, 23 Apr 2024 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8hZM6qD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAEC101EE
	for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870022; cv=none; b=j3zBB/92zoXhzsB/Wa3rmjWHg4FpkJl8niEZr49K8ykqkuigGcV0pQq0hwy3FjeSKdDv6sb3iTuaXwonQ8wJ2Ea4Wl3wRamLcs9tUTdqBaTeKTF/F6fIq7CaJ/J5/sgOFZN34nyttG5T56cBX9W7YcL44AtxuYaArNRLUMaadIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870022; c=relaxed/simple;
	bh=bkhyIxsPfkLTH4djuOHIwSCuppns5Bi/nGqCBjcyfyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5CvU3ccrvynJn0Dz7kvdjGdZCQMDnRcxqYybgRo8kZcfz/HZbagGvG0tfTY/KXUp13sw4b2boylXFOqoZu99f0TKCcR9pjgC8KZk7EdrxK8XUlOzMwdjvRQpIbXOgEX11IMYdCzQsxOsgqvO1NGtQdRJUu+Ei6/BTaCCmoBgSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g8hZM6qD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713870019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fdt5E/yf4lR6lW7uAMb8A4HSxdTHeNatG0BvyRnH+ew=;
	b=g8hZM6qDI89M2DYvYR1+QqQ3TBDqjRRBkB5i8UywZWygM6sSPq+sY0rRJuoKTtdS/MpVzc
	HB1VHcvRiOGJQin4vagVWL6ehVjj2scbjYMn4l3jKQWl28enOtR+1rFd4ZCumiVRTqbasj
	pVryL1Enmjkh+B2hJi8wL7dkR954CJs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-qogDM_HwOQ6R37L3t3m2Bw-1; Tue,
 23 Apr 2024 07:00:17 -0400
X-MC-Unique: qogDM_HwOQ6R37L3t3m2Bw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C07CD1C3F0EE;
	Tue, 23 Apr 2024 11:00:16 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-6.rdu2.redhat.com [10.22.0.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 51FB4581E2;
	Tue, 23 Apr 2024 11:00:16 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Robert Ayrapetyan <robert.ayrapetyan@gmail.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: NFS server side folder copy
Date: Tue, 23 Apr 2024 07:00:15 -0400
Message-ID: <D635B005-5EF1-44A0-8136-0823EDECAD39@redhat.com>
In-Reply-To: <CAAboi9s9=h-ULoTJ4kcTi3S297RWou0JfBz5nTQP90pVpA37bA@mail.gmail.com>
References: <CAAboi9s9=h-ULoTJ4kcTi3S297RWou0JfBz5nTQP90pVpA37bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 21 Apr 2024, at 13:37, Robert Ayrapetyan wrote:

> Hello!
>
> Attempting to understand the implementation of server-side copying of
> folders mounted via NFS 4.2.
> Currently copying an entire folder (cp -r --reflink=always) produces:
>
> newfstatat(AT_FDCWD, "/mnt/source_file", {st_mode=S_IFREG|0644,
> st_size=2466, ...}, AT_SYMLINK_NOFOLLOW) = 0
> newfstatat(3, "dest_file", {st_mode=S_IFREG|0644, st_size=2466, ...}, 0) = 0
> openat(AT_FDCWD, "/mnt/source_file", O_RDONLY|O_NOFOLLOW) = 4
> newfstatat(4, "", {st_mode=S_IFREG|0644, st_size=2466, ...}, AT_EMPTY_PATH) = 0
> openat(3, "dest_file", O_WRONLY|O_TRUNC) = 5
> ioctl(5, BTRFS_IOC_CLONE or FICLONE, 4) = 0
> close(5)                                = 0
> close(4)
>
> sequence of operations for each file within the directory on the
> client side.  Notably, the actual file copy occurs on the server side
> and is instantaneous (BTRFS_IOC_CLONE).
> But for TTLs around 50 ms (such as within intra-regional connections
> like US West/East), copying a 700MB directory containing 500 files
> takes about 4 minutes (while "true" server-side folder copy is almost
> instant).

Hi Robert,

Looks like `cp` is serialized?  Is there a way to send COPY/CLONE in
parallel?

> Exploring if there exists a Linux mechanism enabling the copying of an
> entire folder without individually accessing each file within the
> directory for server-side copy operation.

The NFSv4 protocol doesn't have an operation that can do a server-side
copy/clone of a folder and all its files.  It'd be quite an interesting one,
though.  The failure and recovery cases would be sprawling.

Ben


