Return-Path: <linux-nfs+bounces-8499-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AE99EB08A
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 13:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D9B1606F8
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 12:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764401A2564;
	Tue, 10 Dec 2024 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnK1s2Uf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA11919F130
	for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832713; cv=none; b=b/qXbP1dDsQXiG85ZrQximFDNOH2Y8lPPAp+gXA9ZpYERbeqqWZ/srPcTYNHfojQRngsMZ2aQ59/tKCF53l6/MKJeYzPGHjotPz5NKwo23xhZ8O9tK6o1WHxDugUpoevVCOdciZ8p+bmPjq4wTiXLjIV224u3JI1MUj/vUtJYS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832713; c=relaxed/simple;
	bh=HUmY2kPM0nAHg3TA7pW2ZUjETTsIuW77Vd9Z5+dnY4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWnY64QRCKKvGh8z0E5Ntmbw4wdR2DKFgT5v3aPq0hph8iKnTmUMS6I6tTdU41qwPmejA/rzaTx4N9fJGfoXW5KPXinCsUsF4Qv7UmFeg2xjFRMz8jIU/DOI+bdVZ10oxA6JHvfJwDpzgoQ8hdYb6GEiNF++10rxvyFeT4WYhK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TnK1s2Uf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733832710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cwT0/V3w2W/4eO8RKn6hUgo/9eXz80uUyDXh2fGeSHs=;
	b=TnK1s2UfbYqSMXk1UDOHAjnOmmYlvEnxnf6r4eQw0MPgaQOGexG/yueElF+uERdiVZe2yT
	DycV38CkZCfBcyC2c17JIomiPbL/kpUr6GPjgiLP4oiouJHND13/b+O4fa14zXvPM0EqJX
	F7b6Z/Iai2aEppcXYl8hpj+LopWchXo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-c5MKeHa3PRiB-CUziHQIbQ-1; Tue,
 10 Dec 2024 07:11:47 -0500
X-MC-Unique: c5MKeHa3PRiB-CUziHQIbQ-1
X-Mimecast-MFC-AGG-ID: c5MKeHa3PRiB-CUziHQIbQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78BCB19560B5;
	Tue, 10 Dec 2024 12:11:46 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.7])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6075B195605A;
	Tue, 10 Dec 2024 12:11:45 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Nikhil Jha <njha@janestreet.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs: propagate fileid changed errors back to syscall
Date: Tue, 10 Dec 2024 07:11:43 -0500
Message-ID: <C71642EC-B9F9-4A7D-AD11-D169268460FE@redhat.com>
In-Reply-To: <Z1cra8/5H5HvJ5Sw@igm-qws-u22929a.delacy.com>
References: <Z1cra8/5H5HvJ5Sw@igm-qws-u22929a.delacy.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 9 Dec 2024, at 12:39, Nikhil Jha wrote:

> Hello! This is the first kernel patch I have tried to upstream. I'm
> following along with the kernel newbies guide but apologies if I got
> anything wrong.
>
> Currently, if there is a mismatch in the request and response fileids in
> an NFS request, the kernel logs an error and attempts to return ESTALE.
> However, this error is currently dropped before it makes it all the way
> to userspace. This appears to be a mistake, since as far as I can tell
> that ESTALE value is never consumed from anywhere.
>
> Callstack for async NFS write, at time of error:
>
>         nfs_update_inode <- returns -ESTALE
>         nfs_refresh_inode_locked
>         nfs_writeback_update_inode <- error is dropped here
>         nfs3_write_done
>         nfs_writeback_done
>         nfs_pgio_result <- other errors are collected here
>         rpc_exit_task
>         __rpc_execute
>         rpc_async_schedule
>         process_one_work
>         worker_thread
>         kthread
>         ret_from_fork
>
> We ran into this issue ourselves, and seeing the -ESTALE in the kernel
> source code but not from userspace was surprising.
>
> I tested a rebased version of this patch on an el8 kernel (v6.1.114),
> and it seems to correctly propagate this error.
>
>> 8------------------------------------------------------8<
>
> If an NFS server returns a response with a different file id to the
> response, the kernel currently prints out an error and attempts to
> return -ESTALE. However, this -ESTALE value is never surfaced anywhere.

Hi Nikhil Jha,

Will this cause us to return -ESTALE to the application even if the WRITE
was successful?

Ben


