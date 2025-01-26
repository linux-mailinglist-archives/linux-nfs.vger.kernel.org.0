Return-Path: <linux-nfs+bounces-9636-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF01A1CDF1
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 20:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460921670F1
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 19:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E49578F39;
	Sun, 26 Jan 2025 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SESiIrTn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC90625A642;
	Sun, 26 Jan 2025 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737918085; cv=none; b=jh+KWBLB0SW96UWJo0XymR9CvuNnMP4PDlZu8C8vvln5lOjsi5cDT0VjO8+hb5QBWz4fdQ1hVIb7RtHh+bJW67IiKSh9uDYDxU/ZunNfxea2ML97MOg4pQ+O1qkLh+KYgnl37wpoRb4GafSlPPFhkUmwToTG+Ph+aVUzkJmvEu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737918085; c=relaxed/simple;
	bh=2xD+V1RDFdK8SXjTuGmdj4ZpsgJui3hYsoLaYZXolj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQNOBPV+4ZG6XD/EBsT9DzRD83FmbNmZdKfmWuJCfCJPcl5zU7dG+RJn9VBhQKmk2WigxksyF6vkhn3vXm4c1AWo7bu+4PyTKI/ME4mNRfmlWn7xnxArcZTy51O5RUcPQwidB+uVFAG5XXtA78U8Si8mlu20ie60cAe7agRRC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SESiIrTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D91CC4CED3;
	Sun, 26 Jan 2025 19:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737918084;
	bh=2xD+V1RDFdK8SXjTuGmdj4ZpsgJui3hYsoLaYZXolj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SESiIrTnDTNg4EJUGkM2/4xPLZpI/2xr0XPjYI3CWI1f+cdrRJIilS8RUkW2hGdW7
	 zs6P1npnuTFKes5GcMEh+UAdWW+1HSfw+AzLa4tmSTRGdxINea6A71f7zegg6+w5La
	 mnjaeM2POhYp4b20ThCvP6XjuxdjLnJnY/T87OsDwqezoDeuBY4YdXRPs1DXc/rT1p
	 YUIuHLyB0RaLahPPOZeoVpu8dyrmALjo87G9180YcdzvphqJlB2r0QB/hOGI92nQNz
	 6K497B71C9nW8nJR2xyOR06XZjCoN/jli4CQYJ+/biCh5cubODUfH6EmLvisGgvxOL
	 pPJ9J38UItm1g==
From: cel@kernel.org
To: jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@hammerspace.com,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Lingfeng <lilingfeng3@huawei.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	yukuai1@huaweicloud.com,
	houtao1@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lilingfeng@huaweicloud.com
Subject: Re: [PATCH 0/2] nfsd: add a new mapping and remove the redundant one
Date: Sun, 26 Jan 2025 14:01:20 -0500
Message-ID: <173791796713.1760.12012787885477599476.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250126095045.738902-1-lilingfeng3@huawei.com>
References: <20250126095045.738902-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Sun, 26 Jan 2025 17:50:43 +0800, Li Lingfeng wrote:
> Add a new mapping and delete a redundant one.
> 
> Li Lingfeng (2):
>   nfsd: map the ELOOP to nfserr_symlink to avoid warning
>   nfsd: remove the redundant mapping of nfserr_mlink
> 
> fs/nfsd/vfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Applied 2/2 to nfsd-testing, thanks!

Note that the address kolga@netapp.com is no longer in service.
Please do note include that address when posting NFSD patches.

[2/2] nfsd: remove the redundant mapping of nfserr_mlink
      commit: 6e6e2d282d6b18e629f35688a658a1e454dc3640

--
Chuck Lever


