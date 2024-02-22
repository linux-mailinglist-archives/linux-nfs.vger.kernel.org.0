Return-Path: <linux-nfs+bounces-2048-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F76885FBA3
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Feb 2024 15:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6178B1C216C1
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Feb 2024 14:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F6912D773;
	Thu, 22 Feb 2024 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b="W51mdK4P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpo69.interia.pl (smtpo69.interia.pl [217.74.67.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BBE1474C2
	for <linux-nfs@vger.kernel.org>; Thu, 22 Feb 2024 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.74.67.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613676; cv=none; b=TwJgI2m8SktqwYRnb/4w+iu7FOeSjc+WJF19hs2aqfNvaTcCWNcr0F4rbdNnIvOArC2VS1YvO/KL0kQuWclTR2ZyJaGx7Udljg5Rpu1ULPdz3u1BmS1fsgqjzKMRHTVydku9/tRmAnt+6DCdKskp5sja+j4A7coHHN0WUAcL35A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613676; c=relaxed/simple;
	bh=xYWAVpd9Cc6WP3xWFyNsRtBkl6jURusWh74oDuQxeos=;
	h=Date:From:Subject:To:Cc:Message-Id:MIME-Version:Content-Type; b=TO+ZlyE3nkhHCAkLCjgeNZtEwpx2RpepZO93Wz6xZE48EJF4GBfIQPL9WqrMVPq+u0bQf8TnF/9cIWplaMQXX7LfhTY5XVuZjTpP4jElOc/wJSEkDpxk07VL1SEAYWU9h93ap0Y679+ny857myum1s3Z44szb8Y+eQ9y/IMy2K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=poczta.fm; spf=pass smtp.mailfrom=poczta.fm; dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b=W51mdK4P; arc=none smtp.client-ip=217.74.67.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Date: Thu, 22 Feb 2024 15:54:26 +0100
From: Jacek Tomaka <Jacek.Tomaka@poczta.fm>
Subject: NFS data corruption on congested network
To: trond.myklebust@hammerspace.com, anna.schumaker@netapp.com, neilb@suse.de
Cc: linux-nfs@vger.kernel.org
X-Mailer: interia.pl/pf09
Message-Id: <ujvntmhlfharduyanjob@tgqn>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1708613670; bh=igZEZiYHQbPwrwUgPmRPmdTd2wHkWHKalOw4oRzlFi0=;
	h=Date:From:Subject:To:Message-Id:MIME-Version:Content-Type;
	b=W51mdK4PRrf4K+ohFh3Tny8H9DYBJe9VZijH9PoCbTR4w4qg6/1mViriCn5JTukBD
	 RSrxJ0VD3c0TWeczBNIJ6Pg3Uc9Z3krzf2gvAz+dm2mQpXJAXgvGL1+PAhlVwnT/WD
	 xfvf/Js45a3j+BitCu4sVAFw2ZtXBTvKDdGQSVOI=

Hello,
I ran into an issue where the NFS file ends up being corrupted on disk. We started noticing it on certain, quite old hardware after upgrading OS from Centos 6 to Rocky 9.2. We do see it on Rocky 9.3 but not on 9.1.

After some investigation we have reasons to believe that the change was introduced by the following commit: 
https://github.com/torvalds/linux/commit/6df25e58532be7a4cd6fb15bcd85805947402d91

We write a number of files on a single thread. Each file is up to 4GB. Before closing we call fdatasync. Sometimes the file ends up being corrupted. The corruptions is in a form of a number ( more than 3k pages in one case) of zero filled pages.
When this happens the file cannot be deleted from the client machine which created the file, even when the process which wrote the file completed successfully.

The machines have about 128GB of memory, i think and probably network that leaves to be desired.

My reproducer is currently tied up to our internal software, but i suspect setting the write_congested flag randomly should allow to reproduce the issue.

Regards.
Jacek Tomaka

