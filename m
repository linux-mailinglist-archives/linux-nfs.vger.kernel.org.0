Return-Path: <linux-nfs+bounces-3214-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B808C0444
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 20:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD96E285965
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 18:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCAD54FAA;
	Wed,  8 May 2024 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fkbu2wWt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2053212BF28
	for <linux-nfs@vger.kernel.org>; Wed,  8 May 2024 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715192642; cv=none; b=GuAWBUQ1A2Og64W6komJY1+1JO3IWBR005wm4yhe3DWPMZcrvcp3VzUakZjv08yQpBSE3l5a0BTSdmY4CCDQ/5MDEzsEdMBvwBMWEoSrfFojES3wxXIssDaHhO5DLovmw+hcvff+zcRrCAHIuT8wbFQJFJzwppIkfr5qck9xSYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715192642; c=relaxed/simple;
	bh=IKBLm8O8d53V/J+TVXYVFPovT9P03ZaeOvIXagq2Ug4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSe0Bc14NXLA2ZA6qujk9YEbJKyt21AIPEdTf+FR4gwohc0hH7MA45OVNppQvIx1oG5l0ffN7f7723Uqm0PGEL0PKEpdydmkFYn0l0gncsPcw/+TEeNyYMp78Ko7rKDSk4DW9O66YV5SgXOlaHkbNfFvlNJzhdRHkp7e7toXUdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fkbu2wWt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715192639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1S3R740rKakNjUBqiywEHAg3serFYHJeFyt5wHtOCE=;
	b=fkbu2wWtjuVG8CbDYJxuUX5LQPGsJLQLY3YvbOOO2L8CjRq5PsB8arKdaIirfU7ZNXR2Zt
	+sNDeNGUlgeTH9kB9g0zG4DYcAjVJc7zJOrEw+lmTt1bOlWmY0S3oB/dQrPqvaz/QiuZn9
	qmvvl6+6nv5JAUPcJlDG+YNC7K5whMY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-dXaJTNtgOjatqiZFzJaxsg-1; Wed, 08 May 2024 14:23:56 -0400
X-MC-Unique: dXaJTNtgOjatqiZFzJaxsg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28FC88007BC;
	Wed,  8 May 2024 18:23:56 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-6.rdu2.redhat.com [10.22.0.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 413B51C060AE;
	Wed,  8 May 2024 18:23:55 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc: trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] pNFS/filelayout: check layout segment range
Date: Wed, 08 May 2024 14:23:53 -0400
Message-ID: <33B5E0C2-9B94-4C54-BD6F-475E4AC0EB75@redhat.com>
In-Reply-To: <CAN-5tyFWrqihMv8UwvAmrcxuFdM6S5qMvnZgWkJqWXm6iFJeVQ@mail.gmail.com>
References: <20240507195933.45683-1-olga.kornievskaia@gmail.com>
 <9D9DB9E5-E772-462B-BD38-7F703459A0FC@redhat.com>
 <CAN-5tyFWrqihMv8UwvAmrcxuFdM6S5qMvnZgWkJqWXm6iFJeVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 8 May 2024, at 13:52, Olga Kornievskaia wrote:

> On Wed, May 8, 2024 at 10:50 AM Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> On 7 May 2024, at 15:59, Olga Kornievskaia wrote:
>>
>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>
>>> Before doing the IO, check that we have the layout covering the range of
>>> IO.
>>>
>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>> ---
>>>  fs/nfs/filelayout/filelayout.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
>>> index 85d2dc9bc212..bf3ba2e98f33 100644
>>> --- a/fs/nfs/filelayout/filelayout.c
>>> +++ b/fs/nfs/filelayout/filelayout.c
>>> @@ -868,6 +868,7 @@ filelayout_pg_init_read(struct nfs_pageio_descriptor *pgio,
>>>                       struct nfs_page *req)
>>>  {
>>>       pnfs_generic_pg_check_layout(pgio);
>>> +     pnfs_generic_pg_check_range(pgio, req);
>>>       if (!pgio->pg_lseg) {
>>>               pgio->pg_lseg = fl_pnfs_update_layout(pgio->pg_inode,
>>>                                                     nfs_req_openctx(req),
>>> @@ -892,6 +893,7 @@ filelayout_pg_init_write(struct nfs_pageio_descriptor *pgio,
>>>                        struct nfs_page *req)
>>>  {
>>>       pnfs_generic_pg_check_layout(pgio);
>>> +     pnfs_generic_pg_check_range(pgio, req);
>>>       if (!pgio->pg_lseg) {
>>>               pgio->pg_lseg = fl_pnfs_update_layout(pgio->pg_inode,
>>>                                                     nfs_req_openctx(req),
>>> --
>>> 2.39.1
>>
>> Looks right, less duplication to just call pnfs_generic_pg_check_range()
>> from pnfs_generic_pg_check_layout() now.
>
> filelayout.c is not the only caller of pnfs_generic_pg_check_layout().
> flexfilelayout has a wrapper around those 2 functions and calls that.
> however, the argument about duplicated code frustrates me because
> currently the code has 4lines. but if we were to re-write the same
> with a function, it would be more lines used in total (flexfiles has 8
> lines for it).

sorry - not trying to frustrate.  Since everyone is now calling both
pnfs_generic_pg_check_layout /and/ pnfs_generic_pg_check_range in the same
place, I thought you could just put
!pnfs_lseg_request_intersecting(pgio->pg_lseg, req) in the first test within
pnfs_generic_pg_check_layout(pgio, req), making that function do the work of
both.  Then you can delete pnfs_generic_pg_check_range entirely for
everyone.  The name still makes sense.

Ben


