Return-Path: <linux-nfs+bounces-2446-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13260886FA8
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Mar 2024 16:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442351C2228E
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Mar 2024 15:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582C44D134;
	Fri, 22 Mar 2024 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="sKaRPkDZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589073C17
	for <linux-nfs@vger.kernel.org>; Fri, 22 Mar 2024 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120532; cv=none; b=RU88EjnOWaeMhgt/SufyFs1hXd+Cl3bXhcCQoCuY6JT892RY5hK1hXZW5Fm1p6wocZ49ZARrjtXpkbihURgoXP/DGj2wZAVHGrDH+AE0aqiDaCGhMu/gsBhSUsvYIyHdQyA45TN0n0gvo5z1lPChyTltRw7Bl2qE8EB9z5q+lhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120532; c=relaxed/simple;
	bh=JGUDGPE4hhNxmN7jBYQ45M/WYMEsQIE2W1GGmTd3Cjs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HIY8pIz5s+kCF6RWkUoMVQSKhHZzKvN4LNvgXMfQG4bRphcuJFTmbVeSjrQDd24NwYdhEy+h1eHvYx6kcbkkoq15ZnEpLIUKv+XybtAm9pcIhcXHSjE6C1VPT92i3UIYnBxGn0LxWCR3V53ED7G1kjvlBnK65VlW61lMXi5tIZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=sKaRPkDZ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1711120527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JGUDGPE4hhNxmN7jBYQ45M/WYMEsQIE2W1GGmTd3Cjs=;
	b=sKaRPkDZZugChjK5bhNpnoL/K9FPUDwgH9lCPbKRuCnSZHnGqjzmJ86rlipuotFbRaMpan
	ZRNKpnF6OEorS/FlaJMaI9DNl6uZX30BzPQcNHg8keD3TiAsLvIk8rW+VWvpV7jPcyzVpk
	i0HdeabbIQAiToktYwlIsy6tic+49uY=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, rsbecker@nexbridge.com, Jeff King
 <peff@peff.net>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] reftable: fix tests being broken by NFS'
 delete-after-close semantics
In-Reply-To: <8ac5e94a3930cdd2aee9ea86acda3155674b635c.1711035529.git.ps@pks.im>
References: <ZfBwZTL9zqDsac5m@manet.1015granger.net>
 <8ac5e94a3930cdd2aee9ea86acda3155674b635c.1711035529.git.ps@pks.im>
Date: Fri, 22 Mar 2024 16:15:12 +0100
Message-ID: <87frwiuwlb.fsf@to1.studio>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Fix this bug by skipping over any files that start with a leading dot
> when counting files. While we could explicitly check for a prefix of
> ".nfs", other network file systems like SMB for example do the same
> trickery but with a ".smb" prefix. In any case though, this loosening of
> the assertion should be fine given that the reftable library would never
> write files with leading dots by itself.

I'm fully supportive of this, as this will also fix any issues possibly
caused by .DS_Store files created by Finder on macOS, although it's very
unlikely they will be created in these tests.

--
Toon

