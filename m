Return-Path: <linux-nfs+bounces-16136-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38254C3C64D
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 17:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723B63B437C
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 16:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4DF2C0303;
	Thu,  6 Nov 2025 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GARey9jq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FF8242D7D
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445650; cv=none; b=a+6NFZcHd1HZXjjFXcMpPDJnytYXIvfFRMXH8AwzeNw1y3RI13kSp5zYdtJgfwI3v7gvrfEt/uzc9NCMNjCe5uVQUlN/C3pVedcyzF/7BN7lZMLhRXoC9zJ0apVxTRJ4xrDhZDE4+NpnXhjKf+/jSjVjDryBxsedUs6HpyrL75Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445650; c=relaxed/simple;
	bh=//ygh+Lnh6YkRKsfaSoeDDoyLhqJV/sfeYnGCaSlp3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGPmzYSO6EgmBhXh1TYsSZ2ovoqf23twOgUNGS9rQwaw0s6GBUDaalS71Hs0CnDfFcjjo4Xf7PrHh1JNP1c44dxHilNwkyf9IjESNtDKsIpHPsneeGRk8sI5tqZSREvy0a2DL0VTS1i2tD+wVqUid4SAjHa8fxlJAHhDYIlVyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GARey9jq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCFCC116B1;
	Thu,  6 Nov 2025 16:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762445648;
	bh=//ygh+Lnh6YkRKsfaSoeDDoyLhqJV/sfeYnGCaSlp3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GARey9jq9HrU0FZpzadqa0VUB8qQ77pEkL12Ubfv+XiwIqOoLU2Ve2y6prcJmGQXi
	 rm6DcBHUV5k2mD4tkoQ5b08p8YOxQW6Y66SG3k7Jo+WwzNOlozE5S0EZHWQoQSvdnl
	 1d8yjDF+WHxUD76eYIhWgvYVN+NGriYYxpu/B50Z5+wfRCkp2KR+E/9nRZYWv4i6vS
	 hD2ny4OXFrptMm/C+nnYQfWulpVQJSYAAs7I6JIcgqyo4bdZp/jMoHVfQQADrZPz30
	 Ssij+r/K6bF6AquMtmjKuG/w7EEhcHrMO4390r67QF+vz1lO4e396bfycV7zis3fAA
	 rFziWuNItlZZw==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	neilb@ownmail.net,
	okorniev@redhat.com,
	tom@talpey.com,
	hch@lst.de,
	Dai Ngo <dai.ngo@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 0/2] NFSD: Fix problem with nfsd4_scsi_fence_client
Date: Thu,  6 Nov 2025 11:14:04 -0500
Message-ID: <176244563600.14191.2482065659966696646.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105204737.3815186-1-dai.ngo@oracle.com>
References: <20251105204737.3815186-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 05 Nov 2025 12:45:53 -0800, Dai Ngo wrote:
> This patchset includes the following:
> 
> . Fix problem with nfsd4_scsi_fence_client using the wrong reservation type.
> . Add trace point to track SCSI preempt operation.
> 
> v2:
> . drop patch that skips fencing on NFS4ERR_RETRY_UNCACHED_REP
> . add namespace number in output of fencing trace point
> 
> [...]

Applied to nfsd-testing, thanks!

[1/2] NFSD: use correct reservation type in nfsd4_scsi_fence_client
      commit: 7069b8dfa5a9ddd3e5c79e4d34e0b12ed0481a97
[2/2] NFSD: Add trace point for SCSI fencing operation.
      commit: 7af6ee667f4bbe500f1f4eac62ad1aea09716c79

--
Chuck Lever


