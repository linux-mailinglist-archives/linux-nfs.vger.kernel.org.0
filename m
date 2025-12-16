Return-Path: <linux-nfs+bounces-17116-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3C1CC4191
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Dec 2025 17:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80A153007192
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Dec 2025 16:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8F421D5AA;
	Tue, 16 Dec 2025 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+b6Aw5m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C1C1E5B7B;
	Tue, 16 Dec 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765900968; cv=none; b=MxSXFJdbb/9IDX3so/wJz/9Eb9iBm+migjLgbWon0XP/TZagB/FjhQxiv50T8rNyc9sv0ZwYt0rT1K82vPDP+j8ZVHdeWIFC26Tk4dmEarpGAdDYgwYjBw/1aG9Zn6/E/RBIIkjQpKdqprK1FVk3kwv0K0eagIQJ6zFQBjwbsQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765900968; c=relaxed/simple;
	bh=BBjVg2vBCOu/wsJSmWTJlK5yppVqImK3dSQAVa9jIhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=muTDBQRdbS0J51jm4VI3PZuuSphMpnMiEXVpcnaap4v44/8eRgOfEGRxR+LBvjWkkYFSJZWy+fx8tpJod+jhJZyKlgl6t2XUQgaRIkdsh1aAOrBrdm+0fOW9m8sfQkWLgavhnA7eTPdBor1kZhCUs7oWsaf9ygPZllTG84AONUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+b6Aw5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E2EC4CEF1;
	Tue, 16 Dec 2025 16:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765900966;
	bh=BBjVg2vBCOu/wsJSmWTJlK5yppVqImK3dSQAVa9jIhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t+b6Aw5mWnE3X/e6OGmzktLzdL2PMFIJzrTsbs7vCDsCU7tDHKNTinJtnj5gj8HoG
	 rNXegQ9a+9jf2kBGnCb+UbU8YUyYuASJCuYTOAwiWC8jjGgDV9q7e1OfcLocdI4jI3
	 AuIkW/n8D4WhcSbXk0+epDDI9vhC2SwAV32fPYWC7uG5vSi+isxVEHLac6zgPpZUP/
	 GRR9rFZ6u7MqbBC6yzDIFIq2VM4zGrp0WDQzhbbkpgph4ACoOOOpv8O3oDk58tyIwr
	 +9XuIMELzGyaxBsMuH3qJVif3+yJ9QC8xfGiBhJCo6u1FmoaN2FkbLLQWQy+EMFs/j
	 GIDVVV1Yos+pA==
From: Chuck Lever <cel@kernel.org>
To: syzbot+6ee3b889bdeada0a6226@syzkaller.appspotmail.com,
	Edward Adam Davis <eadavis@qq.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Dai.Ngo@oracle.com,
	jlayton@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	syzkaller-bugs@googlegroups.com,
	tom@talpey.com
Subject: Re: [PATCH] NFSD: net ref data still needs to be freed even if net hasn't startup
Date: Tue, 16 Dec 2025 11:02:43 -0500
Message-ID: <176590095548.1010059.13663778125624320848.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <tencent_4DA6D7B3792370296083BAC4525778776405@qq.com>
References: <69410b4b.a70a0220.104cf0.0347.GAE@google.com> <tencent_4DA6D7B3792370296083BAC4525778776405@qq.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 16 Dec 2025 18:27:37 +0800, Edward Adam Davis wrote:
> When the NFSD instance doesn't to startup, the net ref data memory is
> not properly reclaimed, which triggers the memory leak issue reported
> by syzbot [1].
> 
> To avoid the problem reported in [1], the net ref data memory reclamation
> action is moved outside of nfsd_net_up when the net is shutdown.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] NFSD: net ref data still needs to be freed even if net hasn't startup
      commit: 339bafeb9942cb3f42c34ed5fcf1fbe377a492da

--
Chuck Lever


