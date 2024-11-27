Return-Path: <linux-nfs+bounces-8235-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E4A9DA0A9
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 03:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D8E280994
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 02:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701CE28379;
	Wed, 27 Nov 2024 02:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqK9Haer"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD801BC3F
	for <linux-nfs@vger.kernel.org>; Wed, 27 Nov 2024 02:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732674917; cv=none; b=ixeU2HRxCLcKNx+EGeFJVWaT2wGHNSikwcCMyyaSuwyIsPyYl6iKrc5PQLfJyHSXWW/IX3N8wzd/lqlYePuABpTeLY1dm0GPmwIpac6vFD8t9aW5N+6WX0ZyKUYheNOVluSP7vI3dbGGX+V5lDAWnCMW147c2VXDSPo/diyMtrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732674917; c=relaxed/simple;
	bh=nEacNsBoHQWoCbwYaSszzBA1/zVP2bxSP2KqtvqssTc=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=OFXG4NzFskMkjAClw/xb3DQHeUARQjP9bBZKpjHhkdIe+NwiJFLlX7Hwok9Am0m5MhjVEbFV5PkngpAkirDNNugyxeuBUE3GpOsT9gwDFOzJt7t3aPURxyBNQzQI9+9NfED/UUvifczOluTcr2UQuIGP7jNFcNUOMXfUl8P0Vk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqK9Haer; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1A4C4CECF;
	Wed, 27 Nov 2024 02:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732674916;
	bh=nEacNsBoHQWoCbwYaSszzBA1/zVP2bxSP2KqtvqssTc=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=TqK9HaerBM8vK69DVQdd3v7mGgpJvl8PGHXQSiyzMG5IPAe9+grxRyHRuYNIuDNlE
	 wtib+/TBLeXpXTTNkqKbRlFNSHX9Hv6/6mXNFR1/oNbaVh4cGILRCbMYCsJ1GEjhFl
	 VrkQSXfkCpQo5FmDB7EE4OtBeUe42zR8esUwQoNfMXmRhXzqpbfGanr2PUhQWIDghx
	 EwIU8+S4f+cwgVEb6+MeaUbIuv+o/Rt2AQhsXbPrT9kdhlqaowx9dMNX7f1Y0uHiJf
	 wgxPl0huQT+VJP7CA4J82NmVLY4FBeVvQzna5etjMtaTIcLYKynyNB4FMuQHYSBKtq
	 fu8DtUukQATgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2463809A00;
	Wed, 27 Nov 2024 02:35:30 +0000 (UTC)
From: Chen Chen via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 27 Nov 2024 02:35:14 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-nfs@vger.kernel.org, trondmy@kernel.org, jlayton@kernel.org, 
 anna@kernel.org, cel@kernel.org
Message-ID: <20241127-b219535c7-828e9c22296f@bugzilla.kernel.org>
In-Reply-To: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
References: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
Subject: Re: Possible memory leak on nfsd
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chen Chen added an attachment on Kernel.org Bugzilla:

Created attachment 307290
oom dmesg from kdump

File: vmcore-dmesg.txt (text/plain)
Size: 535.11 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=307290
---
oom dmesg from kdump

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


