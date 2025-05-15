Return-Path: <linux-nfs+bounces-11759-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D43AB903D
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 21:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6B04E46F8
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 19:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B719270EC5;
	Thu, 15 May 2025 19:54:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BF91E480
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747338881; cv=none; b=WL8tnHKBZ2etTrPPHT4O0AiTUits4Bh1PkaKCp4K3ctoxN/+3n+PeXQns44F/2WIdrJemB1ReNOyUeiIw9qPDDdSUcFYl5sGeE8YzuxSNEpLd3wOWK+y6KoXgzZ+u4I4JXOV/sHvMIqlZ25kZd1V1DQ/EhaJ7q7Uh9Sm3ipeomE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747338881; c=relaxed/simple;
	bh=RiKeMpZPsjC2OvQkX3vEb+8wDV/i9NdSxP3DwrldmTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ashGMc10HM82X4fTfy8+4jTNR+wPSSiLZojV1LFSLyPdErSXYSZCwI/leUn19VIAu9uIv3ewusv6omg31JvAEBJiG1MOkzvEh/K4Dw8BEx1ThxTbwjpoUcDubxrjebzvnUFCZKhEgM6WvpvMt+gslqHxsq2bicLK8RrRwK2rB5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C60C4CEF1;
	Thu, 15 May 2025 19:54:40 +0000 (UTC)
From: Chuck Lever <chuck.lever@oracle.com>
To: jlayton@kernel.org,
	okorniev@redhat.com,
	tom@talpey.com,
	NeilBrown <neil@brown.name>,
	Dai Ngo <dai.ngo@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	sagi@grimberg.me
Subject: Re: [PATCH V6 0/1] NFSD: offer write delegation for OPEN with OPEN4_SHARE_ACCESS only
Date: Thu, 15 May 2025 15:54:34 -0400
Message-ID: <174733874582.5411.16149870963112053711.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <1747152508-22656-1-git-send-email-dai.ngo@oracle.com>
References: <1747152508-22656-1-git-send-email-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 13 May 2025 09:08:27 -0700, Dai Ngo wrote:
> This is a resend of the v6 version of the patch that was reviewed
> by Jeff.
> 
> I will send the fix for the nfsd_file leak problem that Jeff discovered
> in the subsequent patch.
> 
> -------------------------------------------------------------------
> >From RFC8881 does not explicitly state that server must grant write
> delegation to OPEN with OPEN4_SHARE_ACCESS_WRITE only. However there
> are text in the RFC that implies it is up to the server implementation
> to offer write delegation for OPEN with OPEN4_SHARE_ACCESS_WRITE only.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] NFSD: Offer write delegation for OPEN with OPEN4_SHARE_ACCESS_WRITE
      commit: 4fd18336764aaf01a0b7d61a11c496c0dd58e0ca

--
Chuck Lever <chuck.lever@oracle.com>

