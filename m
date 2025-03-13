Return-Path: <linux-nfs+bounces-10597-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3CFA5FC9D
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 17:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5A817DE60
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563DB26B08D;
	Thu, 13 Mar 2025 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oh4ory85"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A93026A1C5
	for <linux-nfs@vger.kernel.org>; Thu, 13 Mar 2025 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884676; cv=none; b=tVO//cQIsVb6fo1yUK/HmaCUKSekf8cg2EQ4HIWaBnkyvO6L9GKEFsvSo7eV5iYGHN2konwnMltXMy+ruqMiPH8UKBrg+RM4JNsacffnad1O0X7DfaqhXBH0mQRJh16rxjreDyyJbi3+xPPm5Lb8hMTj3gLdtv+K5UYXNU4Z6OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884676; c=relaxed/simple;
	bh=wEgPtpgRVwmxlMsZvbOtuCxSmZPlPBg5C513vZl7Ok8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tedTmjUd0uiDRIXCUmKiX5qJqOTwojs0nH1h5a6OD0gYRO/onL1KrlIjbceqjPomyDnefOgHtzQ/wqZe2sRwwkUxlwPAfJTA1sUMscTazfbkEQ+l5jvpBl2HsAKBDuvwItPRj7i/lOV7rPwKfWERR9SoDmzW/vPEwDm4fxEevyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oh4ory85; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741884673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3LbeFY2b1mF36iGRwPeSA4U1dVOSpZ/nfiTLlLe9OQ=;
	b=Oh4ory85IjGUoxMHZu9ZmvKv9nyuL6j4NNeiXrPvf53Yw/wX1qe40talnGOrDmf+vy1w43
	eWOEi3blPeuEtqRCrhZ5q6kwS5xVe8M4uyu2lF5ApAgjUdnSb5yOPHoufb6tyWwvF9sGiS
	AgY50b+HJy7+mpnQcTfTtZAAFnDnLcI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-EneSeOBiO66GCC0PP8LS6A-1; Thu,
 13 Mar 2025 12:51:10 -0400
X-MC-Unique: EneSeOBiO66GCC0PP8LS6A-1
X-Mimecast-MFC-AGG-ID: EneSeOBiO66GCC0PP8LS6A_1741884669
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B41B180025B;
	Thu, 13 Mar 2025 16:51:09 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.7])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7BBA1828A83;
	Thu, 13 Mar 2025 16:51:08 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 1/1] NFS: Extend rdirplus mount option with
 "force|none"
Date: Thu, 13 Mar 2025 12:51:06 -0400
Message-ID: <CC12FA15-DC88-4A43-AA2B-36563C1D4641@redhat.com>
In-Reply-To: <5b2abbe2d387f7d68d41d4786655fa51a9a9ddbb.camel@hammerspace.com>
References: <cover.1741876784.git.bcodding@redhat.com>
 <8c33cd92be52255b0dd0a7489c9e5cc35434ec95.1741876784.git.bcodding@redhat.com>
 <5b2abbe2d387f7d68d41d4786655fa51a9a9ddbb.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 13 Mar 2025, at 12:34, Trond Myklebust wrote:

> On Thu, 2025-03-13 at 10:43 -0400, Benjamin Coddington wrote:
>> There are certain users that wish to force the NFS client to choose
>> READDIRPLUS over READDIR for a particular mount.  Update the
>> "rdirplus" mount
>> option to optionally accept values.  For "rdirplus=force", the NFS
>> client
>> will always attempt to use READDDIRPLUS.  The setting of
>> "rdirplus=none" is
>> aliased to the existing "nordirplus".
>>
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>> ---
>>  fs/nfs/dir.c              |  2 ++
>>  fs/nfs/fs_context.c       | 32 ++++++++++++++++++++++++++++----
>>  fs/nfs/super.c            |  1 +
>>  include/linux/nfs_fs_sb.h |  1 +
>>  4 files changed, 32 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>> index 2b04038b0e40..c9de0e474cf5 100644
>> --- a/fs/nfs/dir.c
>> +++ b/fs/nfs/dir.c
>> @@ -666,6 +666,8 @@ static bool nfs_use_readdirplus(struct inode
>> *dir, struct dir_context *ctx,
>>  {
>>  	if (!nfs_server_capable(dir, NFS_CAP_READDIRPLUS))
>>  		return false;
>> +	if (NFS_SERVER(dir)->flags && NFS_MOUNT_FORCE_RDIRPLUS)
>
> Bitwise and?

Oh crap - my tests are junk.

Ben


