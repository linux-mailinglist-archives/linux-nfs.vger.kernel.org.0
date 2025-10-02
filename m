Return-Path: <linux-nfs+bounces-14906-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821D8BB397E
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Oct 2025 12:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40AA516C288
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Oct 2025 10:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE51B2FE56C;
	Thu,  2 Oct 2025 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBIQ0BSz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDBA2D29D0
	for <linux-nfs@vger.kernel.org>; Thu,  2 Oct 2025 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759400301; cv=none; b=SMFlb7qELuI6A2MDePpKpEpieq5QfcyEAUq6GqwjeGpmQdqqxg9SywEY5uNs0xY6bPidBb0mpJ8cZ4WY6t8WdFIjhALLDOyhGHFb607vJyG0HaoA4uL6CRrzl4RDsSjveq5WgBiGVaYhLN6WpnGEouGMIjyBpBDXaQs0sAPobeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759400301; c=relaxed/simple;
	bh=roICASMlBVutPPDVtDQStCswx1AIGoJu+bl7+4WaWOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhVIBsAIrQSyywSCg3o3/LcMaDvsiKG5hJS9jx3iHauZnJ8X83B0xhauKbpFcNGEKY8zQatRYVALamhpr5Jy67Vw4/KnK0WEk6oyaNlQyMayF+XcbbBdfkiNOxPQhVlA+Yec7BPP0LruNl9LH4L0HguMg3lgAy3zlS80XRx4LRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBIQ0BSz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759400298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yLquKRNpeSlm5pL72sPDMlfr0emfUtn8cSf6rRXZz9c=;
	b=aBIQ0BSzDCSvP7KK06vN5B662MWFDly2oJoCBgc9tEQOKTwHEcewqwxzAGS4u9hKJ9xgFz
	ruXyX7olElKGSz16YqIjazYU9hUZiZk/zosO7j0rvhmJQ7a5loqRJOW1cytqjdRGhOqRGm
	dLhEA4ahYpWB3Uk3oWkOUrsxme73qxY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-34UysZqGMTO0GOdgubv4ig-1; Thu,
 02 Oct 2025 06:18:16 -0400
X-MC-Unique: 34UysZqGMTO0GOdgubv4ig-1
X-Mimecast-MFC-AGG-ID: 34UysZqGMTO0GOdgubv4ig_1759400295
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D2A519560AA;
	Thu,  2 Oct 2025 10:18:15 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.8])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ECCF1955F19;
	Thu,  2 Oct 2025 10:18:14 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: =?utf-8?q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH v2] nfsv4: Add support for the birth time attribute
Date: Thu, 02 Oct 2025 06:18:12 -0400
Message-ID: <6CB893DD-FD4D-4379-A4B6-FD46A954DFFE@redhat.com>
In-Reply-To: <CA+1jF5rnz+VQS9CeEcXcTHoSdG275KAAROzcsb31bpe2kkJsKg@mail.gmail.com>
References: <20230901083421.2139-1-chenhx.fnst@fujitsu.com>
 <3461ADBE-EAD4-4EEF-B7B0-45348BCDB92C@redhat.com>
 <CA+1jF5pHpXHMOv_gRf_en2uX9jfwcCNhoDhYoq5butAFiiMsxg@mail.gmail.com>
 <CA+1jF5pWue5xoRWWecTa95Fuk-qTtBCsTSrVqp6D=_6YSO8+rw@mail.gmail.com>
 <E0D9CF60-9BC4-4C04-A28F-844296EC61D5@redhat.com>
 <CA+1jF5rnz+VQS9CeEcXcTHoSdG275KAAROzcsb31bpe2kkJsKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 2 Oct 2025, at 4:26, Aurélien Couderc wrote:

> On Wed, Oct 1, 2025 at 8:47 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> On 1 Oct 2025, at 11:42, Aurélien Couderc wrote:
>>
>>> What is the status of this patch? did it ever made it into the Linus
>>> mainline kernel?
>>
>> Hi Aurélien,
>>
>> It turns out that there was already posted (much earlier) work to implement
>> btime in the NFS client.  That work was refreshed:
>> https://lore.kernel.org/linux-nfs/cover.1748515333.git.bcodding@redhat.com/
>>
>> and has been accepted into v6.17.
>
> Thanks.
>
> Where is the commit in Linus's git tree?

ce60ab396478 Expand the type of nfs_fattr->valid
1c7ae2dd3f0e nfs: Add timecreate to nfs inode
4b5427414749 NFS: Return the file btime in the statx results when appropriate

Ben


