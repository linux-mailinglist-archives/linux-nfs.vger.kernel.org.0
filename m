Return-Path: <linux-nfs+bounces-2424-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668728818F1
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Mar 2024 22:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF716284AE8
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Mar 2024 21:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B4680621;
	Wed, 20 Mar 2024 21:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Agvw3voc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820DD4F8B2
	for <linux-nfs@vger.kernel.org>; Wed, 20 Mar 2024 21:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710969082; cv=none; b=OUoV5K9aaE4P2Tlw0cUpPmNwiwRFfvodgQy6XGB0wUnqbVjvBLs9FqKcANQ3rHicjl0HmLbaehGDu/QddHukP+Mm2rJABs3Pqsb46MRRMiQbW/E82lD6Naye/OTqRgdqBsWNagkuazQBNAGw+75rd93z+CqHSKOnrcuCLlOBnNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710969082; c=relaxed/simple;
	bh=ob9gfySgwkdntIbrpa28fCiPAisG4euzNeID5EYgNFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YTMsKiFujUP3aruaz/oM1Aty4DtlD8ePmFN1cW0cNPvxDfp03zXags7/bjXQv50M0WFJuJpT94dwO3D4A7ssq6uwnNTyqJvRIVdBFWqPBB2Tt7dk9o+WZ5vbprn42HeZJeoWUBnWIs2u5Kl89zVmIGLnnu4PeTNO6gy0jaZmCNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Agvw3voc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64515C433F1;
	Wed, 20 Mar 2024 21:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710969081;
	bh=ob9gfySgwkdntIbrpa28fCiPAisG4euzNeID5EYgNFA=;
	h=From:To:Cc:Subject:Date:From;
	b=Agvw3voc6D2vSOSpvqNppGgSKmch2CaH8eMQlCis8GmUnFxuEYucNmQjU63D1LmLP
	 batq169rELPz5dW5dEHoTarIVGbw1V2mipyiQNoRYX78imFSo+HUiuUJ2JabhNjR/y
	 IZDLCNq7tFi/6QvnEiHNgOO/n8I+V+GCYMb0pqIGStO9DlytqYKbZEJWCc0cQyK1bw
	 +LSKnbf9XV4iINjlYaNvjZrJlCpW2D6wnrQI8S3XdrGM21T7upXJk9WBP2EwKvCNXi
	 YvIlJ4FAxhClh1e7uGn+aMxv8OrD7GIT3YsnU/x9s2BNBOqARxseDG69ZY+F+wlfi7
	 8aB5iweO4HidQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 0/2] pNFS/filelayout: Enable partial layout support
Date: Wed, 20 Mar 2024 17:11:18 -0400
Message-ID: <20240320211120.228954-1-anna@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

These patches are heavily based on Trond's patches from April 2020 that
added partial layout support to the flexfile layout. As far as I can
tell, the pieces are already there we just need to change the filelayout
code to be okay with partial layouts.

Thanks,
Anna

Anna Schumaker (2):
  pNFS/filelayout: Remove the whole file layout requirement
  pNFS/filelayout: Specify the layout segment range in LAYOUTGET

 fs/nfs/filelayout/filelayout.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

-- 
2.44.0


