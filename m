Return-Path: <linux-nfs+bounces-7985-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5570E9C9018
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 17:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FF90B3400C
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 16:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B752B76026;
	Thu, 14 Nov 2024 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N41qkN5Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929563FB0E
	for <linux-nfs@vger.kernel.org>; Thu, 14 Nov 2024 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600864; cv=none; b=o8QW4MGgcjTZ7gGF2+aW3f0I3oUCzFjT1OejhubkdUpCV4MQpvVsDVv1NxmLfn3B+7fiYLMAQ/mwwSyVOyyloik4QQKKkiHmypZ6ljl1IwSRNzMi37GnARJtahe+V4mTE04q5yN7+HtV5APGOMHUkNLCfpFZTQ5G6vij1GzTfak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600864; c=relaxed/simple;
	bh=FnUCQiKq7REPDAvoRq+2C4kDM+R0PM1sVZ0ijR0dSOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AG5u/cpwQu12di9adgWoL4wtifwFd0NDBcL+Ru+GxcvhHmdGFcuJNHJV4RZfZCPHOBK3jsLW62nS1TPyA/yJHWSfQ/uTF7WPELU/RgzY3/Zs7F2bR2m+jjTqj4pnG36xdKTUnAndthxgefHmPfb8zzwE6Gaauyet8WJcQKAnPzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N41qkN5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CBEC4CECD;
	Thu, 14 Nov 2024 16:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731600864;
	bh=FnUCQiKq7REPDAvoRq+2C4kDM+R0PM1sVZ0ijR0dSOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N41qkN5QtbbDaLVnGz3hARAgmvmkSByepPqZpoUhsfoSGEflXd6/MC13vLcnJPKP+
	 KCJDZEr3Q3ux8fqZOG77iM1oZQ4pmDmtaFUS6HTS1YG8mAggnGwfgfV5tPIWuAVWe3
	 Zqo0M9fcZnJESkEDLnKMrjfyLShYgG+DifT3ukFFlhDDbtbUkV4FcYnJmMEUYtJkyN
	 EFDT6z5D9ZpZdVozuIMffb1WQkRrEMnUWAltFvtzKq7GhBsddIoYvloqYvxIWlSpnK
	 k9VG0dTiyRgR/fT1lwjJMLuOXPw8bJaqXEz2ODxd8l9oQLslsVAbm7LSU148ywI1cL
	 vxK3ryAx1i+hQ==
From: cel@kernel.org
To: linux-nfs@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: Re: (subset) [for-6.13 PATCH v2 00/15] nfs/nfsd: fixes and improvements for LOCALIO
Date: Thu, 14 Nov 2024 11:14:14 -0500
Message-ID: <173160076938.20947.10601589852633921990.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114035952.13889-1-snitzer@kernel.org>
References: <20241114035952.13889-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=891; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=mZEJTF62LFGBZlqI+MtJRVV3EXZ5WdVRbKm5LUqhmvU=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnNiHXP6LDsMfUhb88TKceTlEFdZ+Yw0WfnL561 EAdhQKusLCJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZzYh1wAKCRAzarMzb2Z/ lzCKD/4/hswMflP7s4x73+mkOhMFywdnUVZ2q8s/VZdIICssIMfXqWvcIu4KYC/DCICogTgQ4Mu 11rElB6lUilic23aDAq7Qgo2iVN5uXJIauRskNuSxcp+yJafvb54bZ3CzT2810dvwnLzLrvw2jI XltdEOPOF5asAoF7isxwc0X+oEUNhb9TtNHj1CfREToxIKjQ/W7Ygab7vDUnAUjfr6EYwB1ObZs VedAP7F9rC/p5wgqjtmg9jHWVC9GAv555ddX7f8dMU8CJf9xWfdcDWrWglre8Enp9RJMEK8XT6E wNQA5qDg6wfdGu1zTIf6DV4oVL5RByEegl/kKy2s5J1DCDl/5VOjvRLkZ6NSYDfI5v9p69Gz/dc kQVALugVi00EoFNVTn5kHLrFRY5kgwkRTb63PAeifpDAV4N0QZaZQUZAgCjmBYydqSkAW9LbMAj raeUVMtQEfRRRNDqKxRUyUEHiGRrhjBLmIKT18SIfnE6QWkuVdxyGMES5nI8NbSnBJw7i0vecTH vniqxOVSvM8A1yfVD/IrjuWhB8FamlklrBqnnIvsEPp25XHqD+k5+pUFnT+8YuKPm0+51YoHtL8 GB/YNzhZXzgaE5pkFhboSN+yGtSo99YLuWr2RYCCj5xFEx3IyRYe4N12qZ0y+Sr/GbAE/S4lRh5 WiqQ6GQ
 7H3fUGoQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 13 Nov 2024 22:59:37 -0500, Mike Snitzer wrote:                                              
> Move holding the RCU from nfs_to_nfsd_file_put_local to
> nfs_to_nfsd_net_put.  It is the call to nfs_to->nfsd_serv_put that
> requires the RCU anyway (the puts for nfsd_file and netns were
> combined to avoid an extra indirect reference but that
> micro-optimization isn't possible now).
> 
> [...]                                                                        

Applied to nfsd-next for v6.13, thanks!                                                                

[01/15] nfs_common: must not hold RCU while calling nfsd_file_put_local
        commit: f055a6cafaea151c2df2a75f31c3ecfaa8b90b9e                                                                      

--                                                                              
Chuck Lever


