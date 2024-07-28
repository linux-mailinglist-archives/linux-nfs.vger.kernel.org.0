Return-Path: <linux-nfs+bounces-5106-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8AF93E4A0
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 12:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9211C20A11
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 10:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF9D1B86E5;
	Sun, 28 Jul 2024 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="RJ4B52ZZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A432570
	for <linux-nfs@vger.kernel.org>; Sun, 28 Jul 2024 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722163212; cv=none; b=be0ZJSa7WNe/l8DLCraEZW08SC+muInJBP7Qzwl7Ai67BfyITb42wK/voElI00k6TqWvisvQx/RBYf1iVA73rlMc6B9ua9y5CEJuDEShIu9YhXTqytC2YkuMpuHNMQlPGpTA0UOIUBK0K+epPNCvTcBuH9h/paxDUc2N58uhJTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722163212; c=relaxed/simple;
	bh=WrEvQRnmhw78Opb8lYnsf/tlN/H0vZSnb2FglRVeaJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HrCl2r5j5xLblYvUBRqYqfEvBe4g7ZI80QicM7dSK/SazlO3R2jy1Kmsp4lgNCF121cKxirSeRDXN+E7FwaxWm/dNF6irsIScqtRALVv3QGHN+fREcOW0dkh3dUAP6a73eJA/RO27/57o8jScpAFML6LPj9JFvo2AqCTXxFVbyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=RJ4B52ZZ; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from [IPV6:2a02:1368:6200:11f8:5c1d:85b4:55b7:d407] (unknown [IPv6:2a02:1368:6200:11f8:5c1d:85b4:55b7:d407])
	(Authenticated sender: blokos@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 3715078050A;
	Sun, 28 Jul 2024 12:39:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1722163201;
	bh=WrEvQRnmhw78Opb8lYnsf/tlN/H0vZSnb2FglRVeaJg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RJ4B52ZZg25/+ihk4Z4xynUY20C6I8JqHacQ5/XCXe35BJvZSe8xoFDC9vd4oNcAJ
	 xt+ioSoZ2OhuO+IfgULVrvcYTztFmRk70bv7NAVqr31HETPRiRVh/a6kq7s+O6ptuU
	 YcyoNxegf3UJRYl+G4ZcQIHwN+J20BX5BuM+rcdS65ooUroFAVeI/JvJT5rYNiTu0Q
	 9ShktBIyuHs0Vn2hYAss7KrCWdb4Vei0uIU77xDqU8JKpS5cdNlzDC4KHzxmJJDeX9
	 p94m3z5r4th31aBOpeQpW0iOwCW7VviYclhDZV6T2Z2QtkEzmcxhSg1Hu/dc9h8TAt
	 HFOufXXvak1+w==
Message-ID: <72597ba7-2950-4c61-bb77-8c82e573710c@free.fr>
Date: Sun, 28 Jul 2024 03:39:54 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel 6.10
Content-Language: en-US
To: Dan Aloni <dan.aloni@vastdata.com>, Hristo Venev <hristo@venev.name>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
 David Howells <dhowells@redhat.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <b78c88db-8b3a-4008-94cb-82ae08f0e37b@free.fr>
 <3feb741cb32edd8c48a458be53d6e3915e6c18ed.camel@hammerspace.com>
 <zyclq4jtvvtz6vamljvfiw6cgnr763yvycl3ibydybducivhqh@lj2hgweowpsa>
 <3bd0bfc1fced855902c8963d03e8041f4452b291.camel@hammerspace.com>
 <47219e1df5edbfaf7e8a64ebf543a908511ace85.camel@venev.name>
 <5412f22e497b11c1cd3fc8b8d8f30d372b68cd03.camel@venev.name>
 <sl7cfmykqthhjss3qxeg2aweykff2gurcjqczfry62ne6edrfa@oocwcci6im3o>
From: blokos <blokos@free.fr>
In-Reply-To: <sl7cfmykqthhjss3qxeg2aweykff2gurcjqczfry62ne6edrfa@oocwcci6im3o>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/28/2024 1:33 AM, Dan Aloni wrote:
> On 2024-07-28 02:57:42, Hristo Venev wrote:
>> On Sun, 2024-07-28 at 02:34 +0200, Hristo Venev wrote:
>>> On Sun, 2024-07-21 at 16:40 +0000, Trond Myklebust wrote:
>>>> On Sun, 2024-07-21 at 14:03 +0300, Dan Aloni wrote:
>>>>> On 2024-07-16 16:09:54, Trond Myklebust wrote:
>>>>>> [..]
>>>>>> 	gdb -batch -quiet -ex 'list
>>>>>> *(nfs_folio_find_private_request+0x3c)' -ex quit nfs.ko
>>>>>>
>>>>>>
>>>>>> I suspect this will show that the problem is occurring inside
>>>>>> the
>>>>>> function folio_get_private(), but I'd like to be sure that is
>>>>>> the
>>>>>> case.
>>>>> I would suspect that `->private_data` gets corrupted somehow.
>>>>> Maybe
>>>>> the folio_test_private() call needs to be protected by either the
>>>>> &mapping->i_private_lock, or folio lock?
>>>>>
>>>> If the problem is indeed happening in "folio_get_private()", then
>>>> the
>>>> dereferenced address value of 00000000000003a6 would seem to
>>>> indicate
>>>> that the pointer value of 'folio' itself is screwed up, doesn't it?
>>> The NULL dereference appears to be at the `WARN_ON_ONCE(req->wb_head
>>> !=
>>> req);` check.
>>>
>>> On my kernel the offset inside `nfs_folio_find_private_request` is
>>> +0x3f, but the address is again 0x3a6, meaning that `req` is for some
>>> reason set to 0x356 (the crash is on `cmp %rbp,0x50(%rbp)`).
>> ... and 0x356 happens to be NETFS_FOLIO_COPY_TO_CACHE. Maybe the
>> NETFS_RREQ_USE_PGPRIV2 flag is lost somehow?
> Seems NETFS_FOLIO_COPY_TO_CACHE relates to fscache use, you are
> activating that, right?
>
> Also in addition to my suggestion earlier, I think perhaps we need to
> use `folio_attach_private` and `folio_detach_private` instead of
> directly using `folio_set_private`, for which the NFS client seems to be
> the only direct user.
On my side Yes, fscache is used

