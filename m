Return-Path: <linux-nfs+bounces-5085-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 468CA93DFE3
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 17:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3DA21F20F86
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 15:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB191E521;
	Sat, 27 Jul 2024 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nh2.me header.i=@nh2.me header.b="cUhcwAXe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.nh2.me (mail.nh2.me [116.202.188.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD791741D9
	for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.188.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722092961; cv=none; b=itaNhQnoklLJqQikBKY+Fsrw1THBz02c9XABHMA5P4Bp9DUphVxwQu0Ylozf+r51HNY9HbNAdSf1LCjX3BB4ZF3oNbb+2uk49SSTfHoTrF/PP7l/n2O+6bBWn+sfUHjLl90B9W5cJejULBQQuxyWQoTyPGxchV9QXP/iHNZsl6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722092961; c=relaxed/simple;
	bh=cjA7t6cz9lIyGRjq0m/xaq3B+e42JUbi2SpWKCi7s90=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=EBHwuUfO32EMhjPNUCZUzjGFI/BPzAHdkq0O1DLy88nYmdkWClWQ6+ppwj2YDOXVsutQXTUNtKcAnloW+RE+JSF/WYqCFQPEFNWrOGa7TqLlyJ4R689vnkC9IHUofeNDNORmTqXAwbFGPQ2QnBX+euN3gnky7spmHbNZe/vI3BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nh2.me; spf=pass smtp.mailfrom=nh2.me; dkim=pass (2048-bit key) header.d=nh2.me header.i=@nh2.me header.b=cUhcwAXe; arc=none smtp.client-ip=116.202.188.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nh2.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nh2.me
Message-ID: <53701c8f-d3a7-4e34-b0ca-c8a8daec4446@nh2.me>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nh2.me; s=mail;
	t=1722092949; bh=cjA7t6cz9lIyGRjq0m/xaq3B+e42JUbi2SpWKCi7s90=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=cUhcwAXe9UpA0oE/gNn4NGdr25j0XlUxn2cum1i9aYQun+a2DWX9nzWCw9xluULu5
	 66Us64U3gDP8WTVKp/lW8fmDiZeXTkag/pSOcrvIGoOqja60CL7AK6RvuEwMIPscOn
	 qEez6WXlgMzV+ZevDWslos9o8t+XgKT4USpzWDrCnftsphgmEI/45WOI7t3flmtbHL
	 Z9N0Hp9mSTwanCdtNZnQuJqV2Hq0LD+MfWlZgOyAP9G8O5+5Wt5vFI/YgVRV8XBpbs
	 z7BQJFXp+s0+GlL6RA1NDiAjalSL3sRoXtqQelmBhrbiVPwbqU8HLWePZe2XVh9awQ
	 BvaWQDklQVhCA==
Date: Sat, 27 Jul 2024 17:09:07 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Can rpc.mountd NOT be hardcoded to listen on 0.0.0.0?
From: =?UTF-8?Q?Niklas_Hamb=C3=BCchen?= <mail@nh2.me>
To: linux-nfs@vger.kernel.org
References: <dfcca43f-0dad-4188-b092-0176cfaab2c8@nh2.me>
Content-Language: en-US
In-Reply-To: <dfcca43f-0dad-4188-b092-0176cfaab2c8@nh2.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I wrote a possible implementation of `--host` for nfs-utils's `rpc.mountd` here:

https://github.com/nh2/nfs-utils/compare/mountd-listen-host-option

(stable link: https://github.com/nh2/nfs-utils/commit/b77a10686fe042d3709bcde958edd0926d3e5f41)

Please let me know if that would be acceptable.
In case that patch is already good, feel free to pull it!

I haven't tested it in a real NFS setup yet, just compiled and started it locally so far.

Niklas

