Return-Path: <linux-nfs+bounces-15271-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09385BDF8B3
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Oct 2025 18:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 542F14FE0E6
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Oct 2025 16:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E682BDC13;
	Wed, 15 Oct 2025 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K35E+vk8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642DA29A9C8
	for <linux-nfs@vger.kernel.org>; Wed, 15 Oct 2025 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544343; cv=none; b=sa8ieUS5li+pwoAvQbRtT7tkN9x4rbcb3uBcAEuwA0khGzR+Lzc8w8Xr/wNUs4ukws6MoJIxE5rgCPmbGKujm/DvZoWhpFc2LREQcPKDe3GxLWc9gIHytMlvqtsfzN0yZcbQBa3MglRqUQPrNOOJHZCLBpO+d38Luui6rER/bbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544343; c=relaxed/simple;
	bh=MZ0LoKbKTVCAa64gbHImfJDN3nspo9PTk559Xm19wcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eNrI58eZq0e0KPToorZYdu751BxAsv2/dRuVJTpbcd9l8DJOI2vkEZ1EyDnbF2TBn5tWvf8Fwpq92idchFDUZKQ7T1al89LunigsAgqmYBq8oyhkNYxc79ZxCNnM914Dsf7SqbMXaZKJGFf2flgxDICyewNKngdRPk546vdbwqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K35E+vk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62694C4CEF8;
	Wed, 15 Oct 2025 16:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760544342;
	bh=MZ0LoKbKTVCAa64gbHImfJDN3nspo9PTk559Xm19wcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K35E+vk8GOm0UbZ8ssMMGRNjDOjTpFvqUJuu7LOwGL0wvQpFS2+P+S4haUPHUgv9o
	 7plkytsfxKEjh5dUNhOWl1NrHgSfwY0HoNiOcR/AOz5nFC414diQePMDcsYaMLkKcz
	 oq1E53//Zq1DUMllSbVbpGDlwymZHJxLURBZtgY+YmVYDeEa0LAbiPTfjxHaioetZU
	 PkJhNAvl6a49RaWOwN0q6HyD11mlvkRMCEvrDO+INBlnkpL16BbwWNUzRh3XUqqcSe
	 PatYWrNKUW1RO+2Memzm3B1xhBfADJDamwa/cL8LK1/YBVT+VtKMfXUIhoEMg7alHO
	 uMUE4yv2LMGNg==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: Re: [PATCH 1/1] NFSD: free copynotify stateid in nfs4_free_ol_stateid()
Date: Wed, 15 Oct 2025 12:03:38 -0400
Message-ID: <176054420259.8034.1878833957866479119.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014175959.90513-1-okorniev@redhat.com>
References: <20251014175959.90513-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 14 Oct 2025 13:59:59 -0400, Olga Kornievskaia wrote:
> Typically copynotify stateid is freed either when parent's stateid
> is being close/freed or in nfsd4_laundromat if the stateid hasn't
> been used in a lease period.
> 
> However, in case when the server got an OPEN (which created
> a parent stateid), followed by a COPY_NOTIFY using that stateid,
> followed by a client reboot. New client instance while doing
> CREATE_SESSION would force expire previous state of this client.
> It leads to the open state being freed thru release_openowner->
> nfs4_free_ol_stateid() and it finds that it still has copynotify
> stateid associated with it. We currently print a warning and is
> triggerred
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] NFSD: free copynotify stateid in nfs4_free_ol_stateid()
      commit: 9389261508d497637058091ece5bb318e6703950

--
Chuck Lever


