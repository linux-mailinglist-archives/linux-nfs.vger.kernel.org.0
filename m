Return-Path: <linux-nfs+bounces-13086-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D25B06407
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 18:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94403A7D37
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 16:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E859B248878;
	Tue, 15 Jul 2025 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeclaqkL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF28C2A1B2;
	Tue, 15 Jul 2025 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595919; cv=none; b=meWqlSQS4IkYNeF+hHz2+Q/qrVG6fm5Y486T0R/R8G+0qR3k/t++FwrREa6t4LLZLiYGi72f+eJhM9kGTsiwrky7UDoS5gC3hgo1Zy0EH6EMyuygrCSVU55jceBeYRRZ89bEjxLCVGeoF9H/RxqZiDcOfhr62nSYjLJVSdIf+4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595919; c=relaxed/simple;
	bh=0ROB6urjsmdYa0Uf899KcuQPEIvoVOCps/l1H4OysEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+ByAegHiMMCe/gRhlNBJaGOGJqb08nU+kieA/MD8+qTPM+7+LWLrVlqWbqUmtfFAwyPXuS1w1de7y94nppMWT/c1Pj6WzJkZli1jrMkIWq5SHN939yvwDLHJPMpgQ5aYY3U9a11bBx+eXStGlMb8+n24ObECnEuWIELzC6IpAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeclaqkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A61C4CEE3;
	Tue, 15 Jul 2025 16:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752595919;
	bh=0ROB6urjsmdYa0Uf899KcuQPEIvoVOCps/l1H4OysEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TeclaqkL61HX02624wASYx6ooDlu43nU1LDXGnfKWoTPDrvuHrHWpfZV/DQSVtScV
	 QgcjvwaE7rqeLr8WgKV+brOWF6oVjycOre9+zZ20rmviM/zh+FBOL6SABkdpHRIdTj
	 S8PjjD6m+4rnDg5DuhNMXiSYCee+oomPjyTXfTsMAbuhFQ58yUdXkXkHpMsBZ6Hm/m
	 YyNQlqS6pathZUC+cVteZCMbddisbGl2p+clBhWus68vRHC5MZ+NJ6oc7rXI1C7raL
	 xVOuscJYn9rahH1xsI0t0JMQBzxXvv5adwm/JmZlmhnFgLcn9KTRTDyTRGlfTyCQCm
	 AZgaVrLF/4SFQ==
From: Chuck Lever <cel@kernel.org>
To: Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH v2 0/3] NFSD: Fix last write offset handling in layoutcommit
Date: Tue, 15 Jul 2025 12:11:55 -0400
Message-ID: <175259589759.1098243.8103535218198277847.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250715153319.37428-1-sergeybashirov@gmail.com>
References: <20250715153319.37428-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 15 Jul 2025 18:32:17 +0300, Sergey Bashirov wrote:
> These patches correct the behavior of the pNFS server when the client
> sends a layoutcommit without a new file size and with zero number of
> block/scsi extents.
> 
> Tested manually for the pNFS block layout setup.
> 
> 
> [...]

Applied to nfsd-testing, thanks!

[1/3] NFSD: Minor cleanup in layoutcommit processing
      commit: 2c704299249eb847d0973e8f70e8e8002b805474
[2/3] NFSD: Fix last write offset handling in layoutcommit
      commit: c2c45de297adf669b306f41b0ea11ca7493b63af
[3/3] NFSD: Minor cleanup in layoutcommit decoding
      commit: d3f1ec60bc13851e19876205158a0107d998258d

--
Chuck Lever


