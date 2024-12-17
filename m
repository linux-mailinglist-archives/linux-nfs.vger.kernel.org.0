Return-Path: <linux-nfs+bounces-8639-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D1E9F58D1
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 22:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4A1163B7B
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 21:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695261F9ED9;
	Tue, 17 Dec 2024 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rzxp9pq/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4346F1F8AE6
	for <linux-nfs@vger.kernel.org>; Tue, 17 Dec 2024 21:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734471471; cv=none; b=hPRKk+x8h1XsIJzv3lG9hAwsj9tRE09zip/it9ZuU9tKaY6vRQY4UfB1hqxkDPNnjTI7qxijgEgj70Q5KtF1ZKRSmN3WoOeVpOW4li/ncBqCASEp8epRQyOCAL7qaAb9JUS55Noy4FgwkiK5B5grtVFS3zhbhAzLKxNvKFSKVGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734471471; c=relaxed/simple;
	bh=hmmLHwIHhOMTADd1UPWeILI1PNqjUv5tlVfgy4DJibo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7aFtEGs1tgHd+QHWI2IaoJPfbhvNgst1srjzK544+vlWjDMGe3e19ySp3N1qPlQGjdGH4NeS6F7niysNBimo/B242xUnz4EZchnNEM0/Dqp5ijkxn5iAisYPB+Nr47N6VH/Y/wPOmkeImvP7/3xlnHwKxfHft3YFKDEND0o6cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rzxp9pq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC01C4CEDD;
	Tue, 17 Dec 2024 21:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734471470;
	bh=hmmLHwIHhOMTADd1UPWeILI1PNqjUv5tlVfgy4DJibo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rzxp9pq/8hRSOC40F+nono5bGcA2dIj/C05AHNxFGSbYtWsJqW+6XzGqpvR7n+GLP
	 L4TDIC4l67o12SjHtAeGFBdRh/mYRcDD/T6Tix4LLf117sbwOXFduKxvmYzW2IFUJ3
	 qddYIkSWSy9RWAW3XuJuOxo6+y7XAAvWefBV3QAtqNczG+HKuad9xoYHz0pdUkBpbg
	 UIPkOxxXdv/PkKSWU6Z3blACM+u2GUpcqQdiN+0FfJx9PU0cXglVpj2ZA/+/9KHJsZ
	 EF+NzCX95t863veZac2+RxzNSOFj7XnsvWCUjlPSxV4fqwxVKlJlRTpcgsMx1qhQwl
	 o8lj9xNC3xc8w==
From: cel@kernel.org
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] NFSD: fix management of pending async copies
Date: Tue, 17 Dec 2024 16:37:41 -0500
Message-ID: <173447143255.14086.10254765946615408431.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241217211812.98104-1-okorniev@redhat.com>
References: <20241217211812.98104-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1047; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=rBVDCiOHlFYncCXd8imdsm/gETPrkm1lM974UKRPETA=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnYe8mGVVpUNRAT0Pk3ZN/K9yzQs2DvN6a8xa2S XYH2fK89OuJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ2HvJgAKCRAzarMzb2Z/ l1C7D/4iFlOMb2VhGvA2xmi7o3NF8q9i8kUhWi+Wl/fl0JxKNQpK7sGCGHxtRqeQNiT/wytd7mi 3ldETQvz1rf5q2Jcva4rlRAGmYxH0OQ1fEI8Va7vM2AEEq7mkFaYHWmChaAconIQ5zw1/IDDMeT 7SKmxAJdWoLI2RNJ4j7MJpBHy6D5405bB4pLcu1YZHlKScal0qySkzvRtU7T5G30hdC8N9hQcVh HF+5satPnsfsxPImLlECjEVSCZDYEQ7WLjrWA3HzDtf9vCaFp71ZQc4SZlyx4n0chOuRHhqWX1Y t1jeMgn8qlihqvX8dAhLFPMMIyD8Xu+A9Yqs2U2uHkbiCvzB2tDi8+fCL11ZtsVB0fnfq24hucz HGJmTHewCBa36S4j+nlXW29XpqU5XxBHWTYscTTfFAWln8IpbgsZULckCXUxHyGRbQIriJaU8HI MVrHYlLlyPt9Pl2aGvRM4KLUde2uvpKRE44m41eTtUbFsglnDc9I06OstCB4Gc/XQlIyu4tI9bg GMAP4Wqwv9w6RqiGYg5mcsQQhVgudQ2RNHh1LPNvWVNb1ES9AOARWBHwbOPlMCPZasyhi4hwPLG 2bVaHknc//aFZ4eTHPSKCy5dRqzplNVQPLC2oKQMwQahCluRV0ZYbZgS+PFs/foCQqBYFUJmkHS KNL/vk
 o7j3TE6Iw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 17 Dec 2024 16:18:12 -0500, Olga Kornievskaia wrote:                                              
> Currently the pending_async_copies count is decremented just
> before a struct nfsd4_copy is destroyed. After commit aa0ebd21df9c
> ("NFSD: Add nfsd4_copy time-to-live") nfsd4_copy structures sticks
> around for 10 lease periods after the COPY itself has completed,
> the pending_async_copies count stays high for a long time. This
> causes NFSD to avoid the use of background copy even though the
> actual background copy workload might no longer be running.
> 
> [...]                                                                        

Applied to nfsd-fixes for v6.13, thanks!                                                                

[1/1] NFSD: fix management of pending async copies
      commit: 9048cf05a17a7bc26f0b8e2e53750b1237303970                                                                      

--                                                                              
Chuck Lever


