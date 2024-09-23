Return-Path: <linux-nfs+bounces-6601-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3000497ED4C
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 16:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25A5281A03
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 14:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A578D1465BB;
	Mon, 23 Sep 2024 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6uvxNxy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8154B7DA7D
	for <linux-nfs@vger.kernel.org>; Mon, 23 Sep 2024 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727102740; cv=none; b=FyxAUgVsL1x+7LZM3MdcwnNiAv5dKSyHs6jcJoUnG9lydtpHJRsid18z2/kjXv15kIV59IIvIXi7Mk4h//XLJ5kpYwjAVJqS387AMkKLJaC1Wj+ImQHNZGq8Yi+WBqI0D5rNiDC5ivM2CZz/D/TZBnmS6tWlg4NHJSGPr0cx4ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727102740; c=relaxed/simple;
	bh=VG1ueXOLJDETXigQ6G8MOP9GhRX5/AIZBBaXhQbwIcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+AgSGaC7J4hodPEbBbS81+n5ZlBWfHiOn7t1hy0lxcULj9rm6DY/wMc5cZ8Gdw71FD4bdchBfn7oypDPTmA2lx9nWcV82jtxwFvGf2lM4r79aJWblBSwHC3oBsvSZTw8r6yiHU5KE79DUeGSK8/sUdvhWMgjxotflUtbxv7i/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6uvxNxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B99C4CEC4;
	Mon, 23 Sep 2024 14:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727102739;
	bh=VG1ueXOLJDETXigQ6G8MOP9GhRX5/AIZBBaXhQbwIcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6uvxNxyT8trR1/IBgZoJ2FXxG2ar3UcTXFaIPgPdV+438+nyAGejo9WUZVQIVLUo
	 9bRHJWYwrPuGVPUQt194Dup3k/QhX/OX/O+LL90T3liu5q9GVnDZyOuwiP85CBrT9Z
	 b7QvxO4UgQ6n/ZTsWaEV/vQVi7hehVkbpuDK6BjTU8bVUQ9cuPMKVKNookfJGuJYcr
	 epKhzb3xL9la/vFp+6Z8+AowKXMMJPv3+kehlkBPg2ipiQwkFDzWcV2Dz8N9UP64fu
	 Ec3WT9qbxzHPwHfjm63/nhrYbXIEC3d/yxfFuqnMaDfjP+xbLFqkWdcC4x7fxf7swK
	 ET4I1Vh5I+8ag==
From: cel@kernel.org
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: nfsd_destroy_serv() must call svc_destroy() even if nfsd_startup_net() failed
Date: Mon, 23 Sep 2024 10:45:29 -0400
Message-ID: <172710268500.697637.13817768502526392491.b4-ty@oracle.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <172704876504.17050.1958700732037877952@noble.neil.brown.name>
References: <172704876504.17050.1958700732037877952@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 23 Sep 2024 09:46:05 +1000, NeilBrown wrote:                                              
> If nfsd_startup_net() fails and so ->nfsd_net_up is false,
> nfsd_destroy_serv() doesn't currently call svc_destroy().  It should.
> 
>                                                                         

Applied to nfsd-fixes for v6.12-rc, thanks!                                                                

[1/1] nfsd: nfsd_destroy_serv() must call svc_destroy() even if nfsd_startup_net() failed
      commit: 53e4e17557049d7688ca9dadeae80864d40cf0b7                                                                      

--                                                                              
Chuck Lever


