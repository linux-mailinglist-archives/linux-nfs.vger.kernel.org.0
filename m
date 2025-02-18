Return-Path: <linux-nfs+bounces-10163-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3100BA39EB0
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 15:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 271757A4C77
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 14:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C7D26A0C6;
	Tue, 18 Feb 2025 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfDI/4GV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C09269D1C;
	Tue, 18 Feb 2025 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888647; cv=none; b=hZHvDdhfihbY4ZKqROcgnyqM2pfvXHgRn/S/XtFLxGPrYoK23Tx4RCY8rK3YjJdosKEZS+ZlCjYWXourh92sIlM2iLO/WVsyZuU9dJlxJ7vFd9KwSFYUOa8f9yoFBa/bcZqUmp7CSD/qDXF3l1tWoi7nPi5dEat8oudyEQJIacM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888647; c=relaxed/simple;
	bh=dDBpyHV7r4dNBnXbMy4xwQYiMr+rKPAiB6hEJnpUW/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGra8n7GEf/XxMFgabcPFLDbFmLNQnwyZ2d57euHSxsT8ppw3a1FBW1iUx8mxsZm7nEvK51oxjmFMZRhEkjAFC9hLXb5FsBLt0mZ5LDO95WVDiXERnO4TQRulpI8X4w30Kp3MdNKe0aiNEYI1GN0QOKUQUFDmJxv2/Cus0KPjZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfDI/4GV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0D6C4CEE6;
	Tue, 18 Feb 2025 14:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739888646;
	bh=dDBpyHV7r4dNBnXbMy4xwQYiMr+rKPAiB6hEJnpUW/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LfDI/4GVeBpdyeZJcWjjsjhFlIpOsTo6F4+LcaNi0OOMzJbvw2dOcQTr1YuEr5Ytg
	 wpfji4ymDHMzT06RVjsKAs03GTGKiYLEYdxK02YZEMIzA1gtt9Q2ydFC9LIYVqqMWe
	 VDizYQwiHcwAUu1M1OSIe1ulHSyS4IgG0nEALeU5VV0JQ0NfCtWZ08gkHHaQ/Npngr
	 yfx4Q4SuKOpp/NWPI6WrOUZnpviSoBQDn8XyYXxFPLIgiDIOhbXHmuKBxeRXdcxpmy
	 PtAxK1IKXd+X2aWjy+TJ0sfWRalp+YLb5Sp4PKlDGq16W1bYH1LmX8oNuB+FJZxlr1
	 4h0YHxYN9MnhQ==
From: cel@kernel.org
To: jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Lingfeng <lilingfeng3@huawei.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	yukuai1@huaweicloud.com,
	houtao1@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lilingfeng@huaweicloud.com
Subject: Re: [PATCH] nfsd: decrease cl_cb_inflight if fail to queue cb_work
Date: Tue, 18 Feb 2025 09:24:02 -0500
Message-ID: <173988860071.5368.16253954106532190789.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250218135423.1487309-1-lilingfeng3@huawei.com>
References: <20250218135423.1487309-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 18 Feb 2025 21:54:23 +0800, Li Lingfeng wrote:
> In nfsd4_run_cb, cl_cb_inflight is increased before attempting to queue
> cb_work to callback_wq. This count can be decreased in three situations:
> 1) If queuing fails in nfsd4_run_cb, the count will be decremented
> accordingly.
> 2) After cb_work is running, the count is decreased in the exception
> branch of nfsd4_run_cb_work via nfsd41_destroy_cb.
> 3) The count is decreased in the release callback of rpc_task — either
> directly calling nfsd41_cb_inflight_end in nfsd4_cb_probe_release, or
> calling nfsd41_destroy_cb in nfsd4_cb_release.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: decrease cl_cb_inflight if fail to queue cb_work
      commit: bcf482e3b1f4e622c6a1bfa971cd8035227b8b56

--
Chuck Lever


