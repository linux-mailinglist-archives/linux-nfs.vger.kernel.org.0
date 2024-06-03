Return-Path: <linux-nfs+bounces-3527-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1F58D8302
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 14:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE351F20F5B
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 12:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC02912C484;
	Mon,  3 Jun 2024 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxchxBEp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1DE82D6C
	for <linux-nfs@vger.kernel.org>; Mon,  3 Jun 2024 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419404; cv=none; b=UqtXAkvN61xhh7PdS00i9ALlG7otaGBpX9UApYAOXJIaIUFMdpAy7GtbT/O822CqLrjpEzbOVLzPgnOCpC1fbHAmaynZigIkqruOGNx3E5L69+JNN5fJH6tNlyCBTpzO4PAQCE59B66Aw7J6Ocrt/tqhgTcbpFX1chVZ6yaaZQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419404; c=relaxed/simple;
	bh=3GRCmM/vB/KXdRs2ybPe8AMJWhrG3MVCc0uPOs+aX7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQfIHDG4TyXsUS/JiU9niO5VSDa8F7CZFw4JrxXn8vuc2pwPeYnN/veMh5Qt2Q947yxk0ChrObg6ANDJn5aCfgVRKk/ALiX4eCCD+5TP7x03qlpuYJ2uE10QTCVcLxRq5u64UlkuahAgjWMjcFNuhHQubHB5MwO/lrAEE7svAqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WxchxBEp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717419402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DRXt3f729TvReOfnmQEDstHnclXI87qyY7/2gd1mk/k=;
	b=WxchxBEptcOSsb+ydKMbyocMT+CQ2DWPBHHeKw233rOD6bYcsuS1Pqqs8GwzHupAImXEmF
	LIAwaHP+oWvrUZ+57fY5XmdvDsuFwqYnwIIV4Uvf/2b8GjF2e2WYKRMAt81pcabkB/JzjY
	uVJgaiItOypp9hWbkK7tVqn0/x4aoqM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-bjXAcLsPO3eAIcPDqbiUJw-1; Mon, 03 Jun 2024 08:56:40 -0400
X-MC-Unique: bjXAcLsPO3eAIcPDqbiUJw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 151D0101A525;
	Mon,  3 Jun 2024 12:56:40 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-11.rdu2.redhat.com [10.22.0.11])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AB2491C00A8E;
	Mon,  3 Jun 2024 12:56:39 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Matt Kinni <matt@cipixia.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: exports option "mountpoint" ignored in nfsv4, works in v3
Date: Mon, 03 Jun 2024 08:56:38 -0400
Message-ID: <FF6EFB91-7045-42EB-B880-90F0B6933386@redhat.com>
In-Reply-To: <2c2f8e77-33c8-4836-b7e7-785938755e03@cipixia.com>
References: <2c2f8e77-33c8-4836-b7e7-785938755e03@cipixia.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 2 Jun 2024, at 22:43, Matt Kinni wrote:

> Wasn't sure if this was a bug or just an outdated manpage, but the
> "mountpoint" option will _not_ stop a v4 client from mounting an
> unmounted server directory in Fedora 40 with kernel 6.8.10-300 and
> nfs-utils-2.6.4-0.rc6.fc40.x86_64, however it _does_ work as expected if
> the client mounts with v3 instead:
>
> # setup
> mkdir /mnt/nfs_localhost && mkdir /srv/somemountpoint
> chmod 777 /srv/somemountpoint
>
> # in /etc/exports:
> /srv                    *(rw,all_squash,fsid=0)
> /srv/somemountpoint     *(rw,all_squash,mountpoint)
>
> # in /etc/nfs.conf:
> [nfsd]
> port=20049
> vers3=y
> vers4=y
>
> # try mounting with nfs v3 while /srv/somemountpoint is a plain dir:
> mount localhost:/srv/somemountpoint /mnt/nfs_localhost -t nfs -o vers=3
>
> (cmd output)> mount.nfs: mounting localhost:/srv/somemountpoint failed,
> reason given by server: No such file or directory
> (log says)> rpc.mountd[5313]: request to export an unmounted filesystem:
> /srv/somemountpoint
>
> # so far so good
> # but now try doing the same thing with v4:
> mount localhost:/somemountpoint /mnt/nfs_localhost -t nfs -o vers=4.2
> (works without error)
>
> If I `mount -o bind /tmp /srv/somemountpoint` the v3 command works as
> expected, but the v4 command always works regardless of whether the
> underlying folder is a mount point or not.  Is this intended behavior?
>
> The exports(5) manpage does not say anything about the "mountpoint" or
> "mp" options not being valid for NFSv4, so I would expect the same
> behavior regardless of what "-o vers=..." is supplied by the client
> mount command.

Hey Matt -
I suspect think the option is working properly.  Its not that
/srv/somemountpoint is always being exported, its that the v4 mount is
mounting the root (/srv) and walking into /srv/somemountpoint.

If you're exporting /srv, /srv/somemountpoint going to be accessible.

Maybe we need to update the manpage to clear up confusion there?

Ben


