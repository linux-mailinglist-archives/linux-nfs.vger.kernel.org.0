Return-Path: <linux-nfs+bounces-11119-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E61A86CED
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Apr 2025 14:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFFD8A84E1
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Apr 2025 12:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B391AAA29;
	Sat, 12 Apr 2025 12:37:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B6213AD1C
	for <linux-nfs@vger.kernel.org>; Sat, 12 Apr 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744461433; cv=none; b=VbnPWkuhmVT5Je9sNWVK7z63zKynpos9NNYD5yL/0k/E/YLsEHMBpbv2T3BUD5fQuQHg+AFc8T7QWOmJfnuOmCA1ejuSN6EGo6V2x9FE0obWtVXT4m6Il8VLL660maiDyHZtlRTgDdgfDjDtyDs16AfJykb4ukL7L/Z8vH3nuhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744461433; c=relaxed/simple;
	bh=FMdw0UxdIW9/YOOuiQKOzh2kmF+GXDIVzrvUYnVFgj4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aaT2ri+QwSlmUgSQypI4kgc1j0L8Un4caDUW0KXQwVDoCeuVsDPFQLD9H5MQakjyz2WLNgss6Fx+9ksSJOD7Hfg5ijZKHcgk48123siQv3ggNX9pQ6sKgzjvwwRhaaTaDvYJvue5TsP/9vEoQEXVtV/CJijJQbB/qpt8lfd1qCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07e9b7.dip0.t-ipconnect.de [91.7.233.183])
	by mail.itouring.de (Postfix) with ESMTPSA id 92D37B88;
	Sat, 12 Apr 2025 14:36:59 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 2570A601853A9;
	Sat, 12 Apr 2025 14:36:59 +0200 (CEST)
Subject: Re: Async client v4 mount results in unexpected number of extents on
 the server
To: Benjamin Coddington <bcodding@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <848f71b0-7e27-fce1-5e43-2d3c8d4522b4@applied-asynchrony.com>
 <3696A877-3C0E-4F70-9C7E-3FD8B9AD185F@redhat.com>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <8cb74904-331a-5615-6453-6ce8948236a2@applied-asynchrony.com>
Date: Sat, 12 Apr 2025 14:36:59 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3696A877-3C0E-4F70-9C7E-3FD8B9AD185F@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2025-04-11 15:29, Benjamin Coddington wrote:
> On 10 Apr 2025, at 8:55, Holger Hoffstätte wrote:
>> ...
>> Does this behaviour seem familiar to anybody?
>>
>> I realize this is "not a bug" (all data is safe and sound etc.) but
>> somehow it seems that various layers are not working together as one
>> might expect. It's possible that my expectation is wrong. :)
> 
> My first impression is that the writes are being processed out-of-order on
> the server, so XFS is using a range of allocation sizes while growing the
> file extents.

Thanks for reading!

Yes, that's true but not the cause of the re-ordering - the server just
does what it's being told. The reordering has to come from the client in
async mode.

Compare the following packet traces, first with a sync mount on the client:

holger>tshark -r client-sync.pcap | grep Offset | head -n 20
   148 6.349609085 192.168.100.221 → 192.168.100.222 NFS 1826 V4 Call WRITE StateID: 0x7cf4 Offset: 0 Len: 262144
   223 6.351592937 192.168.100.221 → 192.168.100.222 NFS 38026 V4 Call WRITE StateID: 0x7cf4 Offset: 262144 Len: 262144
   329 6.354313478 192.168.100.221 → 192.168.100.222 NFS 24994 V4 Call WRITE StateID: 0x7cf4 Offset: 524288 Len: 262144
   452 6.357495813 192.168.100.221 → 192.168.100.222 NFS 13410 V4 Call WRITE StateID: 0x7cf4 Offset: 786432 Len: 262144
   534 6.359567456 192.168.100.221 → 192.168.100.222 NFS 38026 V4 Call WRITE StateID: 0x7cf4 Offset: 1048576 Len: 262144
   638 6.362138118 192.168.100.221 → 192.168.100.222 NFS 26442 V4 Call WRITE StateID: 0x7cf4 Offset: 1310720 Len: 262144
   762 6.365241741 192.168.100.221 → 192.168.100.222 NFS 13410 V4 Call WRITE StateID: 0x7cf4 Offset: 1572864 Len: 262144
   866 6.367883641 192.168.100.221 → 192.168.100.222 NFS 1826 V4 Call WRITE StateID: 0x7cf4 Offset: 1835008 Len: 262144
   962 6.370450322 192.168.100.221 → 192.168.100.222 NFS 3274 V4 Call WRITE StateID: 0x7cf4 Offset: 2097152 Len: 262144
  1035 6.372527063 192.168.100.221 → 192.168.100.222 NFS 13410 V4 Call WRITE StateID: 0x7cf4 Offset: 2359296 Len: 262144
  1132 6.375268418 192.168.100.221 → 192.168.100.222 NFS 13410 V4 Call WRITE StateID: 0x7cf4 Offset: 2621440 Len: 262144
  1229 6.377913391 192.168.100.221 → 192.168.100.222 NFS 13410 V4 Call WRITE StateID: 0x7cf4 Offset: 2883584 Len: 262144
  1326 6.380523792 192.168.100.221 → 192.168.100.222 NFS 13410 V4 Call WRITE StateID: 0x7cf4 Offset: 3145728 Len: 262144
  1423 6.383116733 192.168.100.221 → 192.168.100.222 NFS 13410 V4 Call WRITE StateID: 0x7cf4 Offset: 3407872 Len: 262144
  1519 6.385729789 192.168.100.221 → 192.168.100.222 NFS 13410 V4 Call WRITE StateID: 0x7cf4 Offset: 3670016 Len: 262144
  1616 6.388442438 192.168.100.221 → 192.168.100.222 NFS 13410 V4 Call WRITE StateID: 0x7cf4 Offset: 3932160 Len: 262144
  1713 6.391023297 192.168.100.221 → 192.168.100.222 NFS 13410 V4 Call WRITE StateID: 0x7cf4 Offset: 4194304 Len: 262144
  1809 6.393621476 192.168.100.221 → 192.168.100.222 NFS 13410 V4 Call WRITE StateID: 0x7cf4 Offset: 4456448 Len: 262144
  1906 6.396189134 192.168.100.221 → 192.168.100.222 NFS 13410 V4 Call WRITE StateID: 0x7cf4 Offset: 4718592 Len: 262144
  2004 6.398795974 192.168.100.221 → 192.168.100.222 NFS 13410 V4 Call WRITE StateID: 0x7cf4 Offset: 4980736 Len: 262144

The offset is increasing linearly.

Now with the regular async mount:

holger>tshark -r client-async.pcap | grep Offset | head -n 20
   349 1.939181198 192.168.100.221 → 192.168.100.222 NFS 62330 V4 Call WRITE StateID: 0x9abe Offset: 0 Len: 1048576
   713 1.948199991 192.168.100.221 → 192.168.100.222 NFS 62330 V4 Call WRITE StateID: 0x9abe Offset: 1048576 Len: 1048576
  1078 1.957190498 192.168.100.221 → 192.168.100.222 NFS 62330 V4 Call WRITE StateID: 0x9abe Offset: 2097152 Len: 1048576
  1438 1.966163614 192.168.100.221 → 192.168.100.222 NFS 62330 V4 Call WRITE StateID: 0x9abe Offset: 3145728 Len: 1048576
  1781 1.974626188 192.168.100.221 → 192.168.100.222 NFS 62330 V4 Call WRITE StateID: 0x9abe Offset: 528482304 Len: 1048576
  2140 1.983642048 192.168.100.221 → 192.168.100.222 NFS 62330 V4 Call WRITE StateID: 0x9abe Offset: 4194304 Len: 1048576
  2499 1.992622009 192.168.100.221 → 192.168.100.222 NFS 62330 V4 Call WRITE StateID: 0x9abe Offset: 529530880 Len: 1048576
  2862 2.001627951 192.168.100.221 → 192.168.100.222 NFS 62330 V4 Call WRITE StateID: 0x9abe Offset: 5242880 Len: 1048576
  3224 2.010608959 192.168.100.221 → 192.168.100.222 NFS 62330 V4 Call WRITE StateID: 0x9abe Offset: 530579456 Len: 1048576
  3584 2.019595764 192.168.100.221 → 192.168.100.222 NFS 62330 V4 Call WRITE StateID: 0x9abe Offset: 7340032 Len: 1048576
  3951 2.028614348 192.168.100.221 → 192.168.100.222 NFS 62330 V4 Call WRITE StateID: 0x9abe Offset: 531628032 Len: 1048576
  4290 2.037056179 192.168.100.221 → 192.168.100.222 NFS 62330 V4 Call WRITE StateID: 0x9abe Offset: 6291456 Len: 1048576
  4656 2.046079372 192.168.100.221 → 192.168.100.222 NFS 62330 V4 Call WRITE StateID: 0x9abe Offset: 532676608 Len: 1048576
  5029 2.055044526 192.168.100.221 → 192.168.100.222 NFS 62330 V4 Call WRITE StateID: 0x9abe Offset: 8388608 Len: 1048576
  5399 2.064067160 192.168.100.221 → 192.168.100.222 NFS 62330 V4 Call WRITE StateID: 0x9abe Offset: 533725184 Len: 1048576
  5772 2.073040626 192.168.100.221 → 192.168.100.222 NFS 62330 V4 Call WRITE StateID: 0x9abe Offset: 9437184 Len: 1048576
  6142 2.082045031 192.168.100.221 → 192.168.100.222 NFS 62330 V4 Call WRITE StateID: 0x9abe Offset: 534773760 Len: 1048576
  6497 2.090504113 192.168.100.221 → 192.168.100.222 NFS 62330 V4 Call WRITE StateID: 0x9abe Offset: 10485760 Len: 1048576
  6868 2.099502093 192.168.100.221 → 192.168.100.222 NFS 62330 V4 Call WRITE StateID: 0x9abe Offset: 535822336 Len: 1048576
  7229 2.108506848 192.168.100.221 → 192.168.100.222 NFS 62330 V4 Call WRITE StateID: 0x9abe Offset: 11534336 Len: 1048576

Offset is all over the place, with a write at 504 MB after the first 3.

So far I tried:
- disabling the write congestion handling (client side)
- increased dirty writeback thresholds to unreasonable levels: >30 seconds,
several GBs

Except for bloating writeback none of this really made a difference.

I've been poking around in nfs/write.c and nfs/pagelist.c but unfortunately
did not really get far. Looking at the async case above it *looks* as if
multiple writebacks are initiated and interleaved, or at least their page
ranges. That's with vm.dirty_background_bytes=536870912 (512 MB) - could be
a coincidence.

If it helps I can make the client packet traces available for download;
I didn't see anything interesting or unusual in there. The server traces
match the client traces 1:1 wrt. to Offset handling, so they are not really
interesting.

cheers
Holger

