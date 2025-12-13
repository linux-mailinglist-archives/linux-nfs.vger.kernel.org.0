Return-Path: <linux-nfs+bounces-17071-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2279CBB236
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 19:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAF773042FC3
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 18:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D390F2E5B05;
	Sat, 13 Dec 2025 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6+56Esw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DFC15624B;
	Sat, 13 Dec 2025 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765650898; cv=none; b=AdsbzXBMwQvm5DCEz7Xvf+74+ULm6Ayfwm9dthEF0S66csi+XyIopkQtzD06p4kUOkif1NdR8dzly6f936lOfQn2Ppb+DrObbvg4uURkVLgW/rfbCaNUfk6igt/zPE2fShpO1UUHmYxJszFpYhn8a2UQHfux9XlBX7hZu1zej60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765650898; c=relaxed/simple;
	bh=9ZwQOKtBjSec+04I3oVKV4GYd68ewmRAiioUC+3d7Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmrIXut//kI5Jab1kDFo6UUmsoprLYgAMR20v0nKWWyyR2NUh22lMQVzfyfLE2wtD9MvXrTGCFdUHkG3nhznRPBsLSu2N+Uz1Z7RAxWcvlD/RTIbyffHFTmWZTLJFNmRywm5nkA6uoUhA4ViiTj2vYXZNNFXu0AdsxbvLxh3UJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6+56Esw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817E7C4CEF7;
	Sat, 13 Dec 2025 18:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765650898;
	bh=9ZwQOKtBjSec+04I3oVKV4GYd68ewmRAiioUC+3d7Cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U6+56EswufTrm926mkYXaXrzVmx32umZmXov8sYZ68GPgQSlZd3vmszYyxEHrLV0l
	 dI+BYhC8i4Ero9Zm/t8lLsT2DRgxmKmv8NGyFAtwqcyAkNRq9kTfFLR7wBTeMCWT3O
	 4LPq7wQ51r3jJClUGDarbHUj+wuBOlbxaT48mpEKuOJpLqn/YiPHGdhOtLtEXByxuV
	 MA14vrXuEersB5/dfIlLPG9UctUAc5g54tzHfncNmv08WT2COZCOFomVcUwfwAM2rh
	 89O8lmvrr26Y8LQI/dlPFvoY85O+PlePcI4D280mipWaxPxtUvVMGY+wgJkZixbfUf
	 7eddG4GdOw2GA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix nfs4_file refcount leak in nfsd_get_dir_deleg()
Date: Sat, 13 Dec 2025 13:34:53 -0500
Message-ID: <176564891602.581939.5245628213222165856.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251213-nfsd-6-19-v1-1-8af64b59c14e@kernel.org>
References: <20251213-nfsd-6-19-v1-1-8af64b59c14e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Sat, 13 Dec 2025 11:53:17 +0900, Jeff Layton wrote:
> Claude pointed out that there is nfs4_file refcount leak in
> nfsd_get_dir_deleg(). Ensure that the reference to "fp" is released
> before returning.
> 
> 

Applied to nfsd-testing, thanks!

[1/1] nfsd: fix nfs4_file refcount leak in nfsd_get_dir_deleg()
      commit: 08efc1ef9f6e574de433c4df4899ca07b251fe57

--
Chuck Lever


