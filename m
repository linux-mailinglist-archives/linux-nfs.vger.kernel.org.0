Return-Path: <linux-nfs+bounces-10954-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E6BA75782
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Mar 2025 19:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE5C188E6EE
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Mar 2025 18:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7F91B3927;
	Sat, 29 Mar 2025 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="wqmKwHx0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F4F1EA73
	for <linux-nfs@vger.kernel.org>; Sat, 29 Mar 2025 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743274541; cv=none; b=fVv41Q7oUjsP8obp2im6H1eYWJM3EzXALl1NRXKS+DMEC8khunrJvRS+gOy/q2Wnfea3iE0Rp/VXFs1rf9E59J20kq/g/JyHEjTzBCZvDRwuDnnGQ4p+mNT8HdXdQbjp+k5kjJsxtoe9hJZPmwSTsgY+Sp/NerZ0SXLivRObOFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743274541; c=relaxed/simple;
	bh=2FBu+CynXlGoplFO7tbqMUpJ7TytLbcdVJFx2pUpmlc=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=tP8jDW3DOMcqyYzsu2ezZxo+ZlqSutLGorv/SChjMdpe0tuYgVHQ2SEE07Co6WyDe6K43aJ17dfDc4ir36Yhi21va/b2oVWlKhw02T0KwLmoszcUBvCbMRo/lQSWf0LyHumnEhabn9F9F62AGk07pgu5+cmjs7G5VBaxeZ1akq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=wqmKwHx0; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 1F54C13F647
	for <linux-nfs@vger.kernel.org>; Sat, 29 Mar 2025 19:55:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 1F54C13F647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1743274529; bh=2FBu+CynXlGoplFO7tbqMUpJ7TytLbcdVJFx2pUpmlc=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=wqmKwHx0TVp2PBIx5G79sVKQTEaYtDkZ7ooi0YtKhfIxhk8jL3az4gSCcUnFxfPx+
	 i+s1omv8si98rVLe6agYVvlDMBVdBXx6+nvsd3QDH6vTzBP3hrGaG2oU5VU4xF8zD+
	 A1Oplna/79uN+baCf9aj3ZOZJIxFzxpa/Efm7/+M=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 15ADD120043;
	Sat, 29 Mar 2025 19:55:29 +0100 (CET)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [IPv6:2001:638:d:c301:acdc:1979:2:e7])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 0D71C16003F;
	Sat, 29 Mar 2025 19:55:29 +0100 (CET)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [131.169.56.82])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id 74F6432007F;
	Sat, 29 Mar 2025 19:55:28 +0100 (CET)
Received: from z-prx-6.desy.de (z-prx-6.desy.de [131.169.10.30])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id 65B5C8004E;
	Sat, 29 Mar 2025 19:55:28 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by z-prx-6.desy.de (Postfix) with ESMTP id 5D6B52402DE;
	Sat, 29 Mar 2025 19:55:28 +0100 (CET)
Received: from z-prx-6.desy.de ([IPv6:::1])
 by localhost (z-prx-6.desy.de [IPv6:::1]) (amavis, port 10026) with ESMTP
 id K8M4ushmIZ9y; Sat, 29 Mar 2025 19:55:28 +0100 (CET)
Received: from [127.0.0.1] (pd9e55b03.dip0.t-ipconnect.de [217.229.91.3])
	by z-prx-6.desy.de (Postfix) with ESMTPSA id CC3242400AE;
	Sat, 29 Mar 2025 19:55:27 +0100 (CET)
Date: Sat, 29 Mar 2025 19:55:26 +0100
From: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To: Martin Wege <martin.l.wege@gmail.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: The (sorry?) state of pNFS documentation?! Abandonware?
User-Agent: Thunderbird for Android
In-Reply-To: <CANH4o6M-gG+e5saZO7LGPU66X8f5azRh78S6ECF-K=zw=J7wxQ@mail.gmail.com>
References: <CANH4o6P5mXTR6dpKCKHHrF4jcAL=wWoy3AWK6vateUHphSPvqg@mail.gmail.com> <e0930049-e97c-4cda-8cbc-8ad02cd5438a@oracle.com> <CANH4o6M-gG+e5saZO7LGPU66X8f5azRh78S6ECF-K=zw=J7wxQ@mail.gmail.com>
Message-ID: <4B139156-5AB0-46B2-BB30-C1A73BA7129B@desy.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 26, 2025 3:33:19 PM GMT+01:00, Martin Wege <martin=2El=2Ewege@gma=
il=2Ecom> wrote:
>On Tue, Feb 11, 2025 at 3:00=E2=80=AFPM Chuck Lever <chuck=2Elever@oracle=
=2Ecom> wrote:
>>
>> On 2/11/25 7:54 AM, Martin Wege wrote:
>> > Is there any up to date documentation for pNFS server support in the
>> > Linux 6=2E6 kernel?
>>
>> There isn't up-to-date documentation for NFSD's pNFS support=2E There a=
re
>> various efforts going on to improve it, but as we are swamped with othe=
r
>> more pressing issues, there hasn't been good progress=2E
>>
>> pNFS block is supported, but it's not straightforward to set up=2E
>>
>> pNFS flexfiles is supported, but the implementation supports only the
>> case where the DS and MDS are the same server=2E
>>
>> NFSD does not implement the other layout types=2E
>
>More questions:
>1=2E Clarification, please:
>Which layout types are and are not supported:
>LAYOUT4_NFSV4_1_FILES
>LAYOUT4_OSD2_OBJECTS
>LAYOUT4_BLOCK_VOLUME
>
>2=2E Is Flexfiles also part of enum layouttype4, or something different?
>
>3=2E dCache supports pNFS MetaDataServer (MDS), and NFSv3 Data Servers
>(DS)=2E Where is the spec for this? And why, WHY NFSv3 DS? Why not
>NFSv4=2E1 DS=3D
>

dCache supports nfsv41_files (rfc 5661) and flexfiles with tightly coupled=
 nfsv4=2E1 DSes (rfc8435)=2E=20

Tigran=2E=20


>Thanks,
>Martin
>

