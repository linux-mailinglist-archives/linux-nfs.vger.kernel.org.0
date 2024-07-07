Return-Path: <linux-nfs+bounces-4692-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1F99296D2
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2024 08:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD1028247D
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2024 06:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98442914;
	Sun,  7 Jul 2024 06:32:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from outgoing.selfhost.de (mordac.selfhost.de [82.98.82.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA5A4A32
	for <linux-nfs@vger.kernel.org>; Sun,  7 Jul 2024 06:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.98.82.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720333938; cv=none; b=etqPsQMWTVeeWhzf4PvupkNJlBdwAHe3S3vdZx0N5teDM6AyJDE4OgzZ4sFDBW5P0SjBbYNNh4jV3tI4qDSqxFrRJ1FMicDAQ4D3+i2PNFxhg5ly2BKcU29UA4vfYScEGhX3GSY7Bcb1YroYp08q9viZECTvmzy7jzAwiSF37Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720333938; c=relaxed/simple;
	bh=uo5dGB9+NRsOxGrxG9GMod9a+WurdHHEHZffRN55kcE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=dtKDKRIZyleirtgPuqwZHxYFuhTQSQAFghsuFdgxiaYhLBHif6n26kA7BTzBYfGgvCsNXi0MAjc58nNInjlxMVADJSjN1JYX7l0kKQIuA8DgoBSdVaS+zKJM74/EHsyBkAjSgVs/Wqtq364OOZIGu1H5Xtuw+da2XVtl1QH3B7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de; spf=none smtp.mailfrom=afaics.de; arc=none smtp.client-ip=82.98.82.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=afaics.de
Received: (qmail 2699 invoked from network); 7 Jul 2024 06:25:31 -0000
Received: from unknown (HELO mailhost.afaics.de) (postmaster@xqrsonfo.mail.selfhost.de@79.192.206.34)
  by mailout.selfhost.de with ESMTPA; 7 Jul 2024 06:25:31 -0000
X-Spam-Level: *
X-Spam-Report: 
	*  0.5 HELO_NO_DOMAIN Relay reports its domain incorrectly
	*  0.4 RDNS_DYNAMIC Delivered to internal network by host with
	*      dynamic-looking rDNS
	*  0.0 DMARC_MISSING Missing DMARC policy
	*  0.3 KHOP_HELO_FCRDNS Relay HELO differs from its IP's reverse DNS
Received: from [IPV6:2003:e3:1f3a:9302:68fd:ffff:fe6f:e76] (p200300e31f3a930268fdfffffe6f0e76.dip0.t-ipconnect.de [2003:e3:1f3a:9302:68fd:ffff:fe6f:e76])
	by marvin.afaics.de (OpenSMTPD) with ESMTP id 125abadf;
	Sun, 7 Jul 2024 08:25:30 +0200 (CEST)
Message-ID: <8f4b1a41-0e35-43dc-a62b-1e9239df9b45@afaics.de>
Date: Sun, 7 Jul 2024 08:25:30 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
To: linux-nfs@vger.kernel.org
From: Harald Dunkel <harri@afaics.de>
Content-Language: en-US
Subject: is nfs-utils aware of cgroup memory limits?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi folks,

I wonder if nfs-utils should be aware of the limits set using legacy or unified
cgroup?

Reason for asking is, I am running nfs exports in an LXC container (using
legacy cgroup). Sometimes nfs gets stuck on the host, and one of the symptoms
are messages about out of memory inside the container.

"cgroup" cannot be found in the code or git log of nfs-utils 2.6.4.


Regards
Harri

