Return-Path: <linux-nfs+bounces-15210-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 562E6BD7695
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 07:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EDED4E1052
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 05:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE2515B0EC;
	Tue, 14 Oct 2025 05:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Cbg4sF/a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NVBiqTAS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C8B86342
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 05:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760419495; cv=none; b=GcC4BpUQRX1taP9BXxlrp3IVjYOAhBppnrc0vplGa+wfu6mi7IQElDlzp+VGsgU8BfJqEqyLFmVZEaaAODZxuAL1fvSEWdq3j1wRhHkn7a7SIXzduQVMigC2BVZwpNMb+GxfYoNVhjDJdgdpWjWw1q9dIBmeyN7WmAvuvF/BkA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760419495; c=relaxed/simple;
	bh=h+F8aXlU2p6aoXLaNKVfCoBAZNXFvHUsu2ayZAXq7L0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=k827o0ij0Da4/B/ZgqCM4VisNKuDfgMUiQNivoswusOjpEhVuGQt9Bqr1ny5zHsrGgR1mUpTBD2+lApC5zD0LG9X3yj14qEuc7XUFm8eYAXAtefregJXdU8IXNF9cDm74O61AKOoH69q8CbdmLcqTWrxXujUq8VR6O9KKXFDPpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Cbg4sF/a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NVBiqTAS; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0FC931D00098;
	Tue, 14 Oct 2025 01:24:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 14 Oct 2025 01:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760419491; x=1760505891; bh=AQobTmHL06ZULPAuUXYLDcQvwt3IRrF7cBd
	fhpV8/RI=; b=Cbg4sF/azZBE/3XSmbGPYF565MhXrw/EXiYErr1G9+eOtmnJk3p
	tAIJFZ6D+ThiLAV73Q2mStZV6SLE4Y/hs7ILaiJ9E80Rv5XwGPd4v+l7wmdjHFSe
	Ul0uiUYu85e1nBfrawonaw41JeU5fBLrrCfwmCLQe9H+X/lQO4uwVLorVKDVuznS
	Vasv7MdMnNIltNISBx9ZTWA9QSaioEA/0sX2x8fhmmlobVD4lZ0mUYpeanDyYOe2
	QhD4sbPin7El9bvOxt8CPdVazAh7+UaBVFUInSXrkgEX5cvgYFDT2uj5qv+AW4MC
	t70m/XnrZoflJPkLpSI997RIIDUMOH7kv4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760419491; x=
	1760505891; bh=AQobTmHL06ZULPAuUXYLDcQvwt3IRrF7cBdfhpV8/RI=; b=N
	VBiqTASGV/EFTrCtIDllsrrTiCNkdAd9Bfek2Z2ZLc+ZwExPrnEJ6G9UCuTQEe03
	i7YvfgLMtZTmsG2uS74xcltodGR7xTtrTGZUMj+IplGoscYIwfGrNalW34dpaH60
	2ceqV4H1PN/cPWJr+cJ9WjmE/p2x4aqLQOyy+XWHVQFTmfPoMjOoU6jX4nTQsuAy
	wjVwEW2Y/10Y2YV6uovOH2KQUksqPXhXhXvyZEbuT2L6T4zI8FVl8YLxG/NjmdLx
	cMPUgLtQF8Cn4bNsYfE3XmTEKumAV2UUaqogths8LmsCgb7y3orInq2UxNtaCq42
	T+5/MV+1tXLr83YlfwqEw==
X-ME-Sender: <xms:o97taKOXVXtcIYmaPy2Gw1sjIesgCSUJSPzTX8sXRc0m1lgQAadWKw>
    <xme:o97taID9WhzBVY7xxGiOPRuB62P2HXOB5PNiSto04t6k_9eMSyoYXFVmc1BLhXEBo
    pv0RsRKrjSXxD-_9xgPW1jTqqAJPc8ofnbElYdr8e_AV8vmJQ>
X-ME-Received: <xmr:o97taHetCxjLJFbdEApP6Y4iZRePyw6Z1w93Kns1dbTt-w1gXlMU8vLl3Ms_Y8IHAXdb6tiyz_pImKs5AmbxDtcZ81jCJk4jninozuD867NX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudelieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepshhnihhtiigvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    hlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvlheskhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:o97taHPjbksEdnq_b3cZUg5VRiHuLTT1QU2xQ_0ZaX8wHN23jS6vzg>
    <xmx:o97taHK40k6CW-Z8CVfrznbdfulyNm23Em-MubLID3cAUH56NhcLPQ>
    <xmx:o97taHLyPqd_ZncMOvcjjpCiPjbYYkay-Gq0bvQECd0xAfHa5c49gQ>
    <xmx:o97taB73eqPHEKJIXXLcciNd_0w2BJzFsZX2mOo6syRni-1mTJIKiQ>
    <xmx:o97taDz2L3NvRwjYsEkPQRDoOH4U_WqGjbHt8gia0hofoYmRrsG9f2M4>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 01:24:49 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Mike Snitzer" <snitzer@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>
Subject:
 Re: [PATCH v1] NFSD: Enable return of an updated stable_how to NFS clients
In-reply-to: <20251013190113.252097-1-cel@kernel.org>
References: <20251013190113.252097-1-cel@kernel.org>
Date: Tue, 14 Oct 2025 16:24:44 +1100
Message-id: <176041948465.1793333.15559805826434795624@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 14 Oct 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> In a subsequent patch, nfsd_vfs_write() will promote an UNSTABLE
> WRITE to be a FILE_SYNC WRITE. This indicates that the client does
> not need a subsequent COMMIT operation, saving a round trip and
> allowing the client to dispense with cached dirty data as soon as
> it receives the server's WRITE response.
> 
> This patch refactors nfsd_vfs_write() to return a possibly modified
> stable_how value to its callers. No behavior change is expected.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: NeilBrown <neil@brown.name>

looks good and useful.

NeilBrown

