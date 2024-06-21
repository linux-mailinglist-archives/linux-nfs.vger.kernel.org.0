Return-Path: <linux-nfs+bounces-4223-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FF3912CE6
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 20:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19AC1C21C37
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 18:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F806178CCA;
	Fri, 21 Jun 2024 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+tZOYWU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996E317623F
	for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 18:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993032; cv=none; b=ZnYrdRuF/t9PvA5DH86P5hFcpYKF6EX86TMr6Qp1E5r61ISWZ0DOxRRD3P4eLUtNM/yyR2CkSXufFF3Pm7Lhn4AKwLGXJWRLhMHGVk93Cj7ixw1K0kgiDt7Re3NJSFYJDZ+66YtHa86HKEJ8TxPgyVVGRzLaGX/kmrBJiXTYIIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993032; c=relaxed/simple;
	bh=wchtjQiDDASr8i4sUmmTK5iD632dJ9KR0QHklB6+8Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqpf+THhQnq25GOsyoJeXM4tyevCjRZ/X/MX9WmVXxCn/1GUDuZ9PbdbpzeaTKoFyv7wMWILVA/o+FFsCWfmEHFrDSbLi+EIwPuGp2GjYJunZeG7uiSjxN4NFkzoyGhXa5qZrbJUVXqpUvuTBPWIhcyxcnC3Jx9gkXz9FHPopuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+tZOYWU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718993029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vAClqQVqQX0+HA+aGo4p5tNCGcvT37WH+RA0wvVybik=;
	b=P+tZOYWU6rkTNjS1sptwSV49nJ5HUp41+6QctRbse02w5zXjJCqPO2g0KTfjhC3TrOF9UQ
	DPl9nmS/v5iItaC5pY9yJc4BIeS8PQrgHYK+iJJbHShPl+yhPP0IupecXc7LHQ5E+rFdMA
	ULI0J7MUmiOjsLkmpIu0KR1XU92zoWo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-xpu6rzfZPMWMAE_TTkCrkQ-1; Fri,
 21 Jun 2024 14:03:45 -0400
X-MC-Unique: xpu6rzfZPMWMAE_TTkCrkQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 982F819560AF;
	Fri, 21 Jun 2024 18:03:43 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B13F3000603;
	Fri, 21 Jun 2024 18:03:41 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 0/4] Fixes for pNFS SCSI layout PR key registration
Date: Fri, 21 Jun 2024 14:03:39 -0400
Message-ID: <3C66C470-F31E-4B17-BEBD-14176B83D613@redhat.com>
In-Reply-To: <20240621162227.215412-6-cel@kernel.org>
References: <20240621162227.215412-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 21 Jun 2024, at 12:22, cel@kernel.org wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
>
> The double registration/unregistration I observed was actually the
> registration and unregistration of two separate block devices: one
> for /media/test and one for /media/scratch. So, that was a false
> alarm.
>
> The complete fstests run shows:
>
> Failures: generic/126 generic/355 generic/450 generic/740
>
> unknown: run fstests generic/108 at 2024-06-21 10:13:58
> systemd[1]: Started fstests-generic-108.scope - /usr/bin/bash -c test -=
w /proc/self/oom_score_adj && echo 250 > /proc/self/oom_score_adj; exec .=
/tests/generic/108.
> kernel: sd 6:0:0:1: reservation conflict
> kernel: sd 6:0:0:1: [sdb] tag#30 FAILED Result: hostbyte=3DDID_OK drive=
rbyte=3DDRIVER_OK cmd_age=3D0s
> kernel: sd 6:0:0:1: [sdb] tag#30 CDB: Read(10) 28 00 00 00 00 00 00 01 =
00 00
> kernel: reservation conflict error, dev sdb, sector 0 op 0x0:(READ) fla=
gs 0x0 phys_seg 32 prio class 2
> systemd[1]: fstests-generic-108.scope: Deactivated successfully.
>
> These errors appear in the system journal only when the whole
> fstests series is run. I can see the "block_rq_complete [-52]" in
> the trace log. But the test output shows:
>
> generic/108       [not run] require cel-nfsd:/export/nfs-pnfs-fs-s to b=
e valid block disk
>
> generic/450 is also failing:
>
> generic/450       - output mismatch (see /data/fstests-install/xfstests=
/results/cel-nfs-pnfs/6.10.0-rc4-gd24c98202dbe/nfs_pnfs/generic/450.out.b=
ad)
>     --- tests/generic/450.out	2024-06-20 16:50:06.548035014 -0400
>     +++ /data/fstests-install/xfstests/results/cel-nfs-pnfs/6.10.0-rc4-=
gd24c98202dbe/nfs_pnfs/generic/450.out.bad	2024-06-21 10:44:02.600634341 =
-0400
>     @@ -8,4 +8,6 @@
>      direct read the second block contains EOF
>      direct read a sector at (after) EOF
>      direct read the last sector past EOF
>     +expect [2093056,4096,0], got [2093056,4096,4096]
>      direct read at far away from EOF
>     +expect [104857600,4096,0], got [104857600,4096,4096]
>     ...
>
> However this might be a bug that existed before this series.
>
> The other three explicit test failures are usual for NFSv4.1.
>
> ---
> Changes since RFC:
> - series re-ordered to place fixes first
> - address review comments as best I can

Looks good, I like the bitops over the bool for pr_registered.

For the series:
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


