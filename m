Return-Path: <linux-nfs+bounces-6986-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B47B997506
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 20:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F2D1F216F9
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 18:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2EC1E131D;
	Wed,  9 Oct 2024 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uvle0WSN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744931E1305;
	Wed,  9 Oct 2024 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499328; cv=none; b=WxafvXaAYavB+gAf/fvsMoAIsjjOMeF5elffNFI/Ep2OCT6zlkLR11ItbGi70KeIwBfbS39g0KpmgVcsfnRBmDUJWyeWhqcbVrJKteEbdeJVqGi3A6DH3FOVF6Ou/awHIMP2XCjOtafYF3Y6Tod4XUtqDt1tCNSKLrO3YC9jf9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499328; c=relaxed/simple;
	bh=Web/vzJs6TAHfjZ7w7xwKD5sgMRU+WqPuAd7fBBu/SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GjHbAhM+uaDEnFUQDR8QbkIHG9Ac9v+j+rn2E+bg7ON5dzlGcGRts6wEC9mFprhzjGD5P1v4WdswpwS/wdQZ0GlX1mjAqzMbHKPYAjbCZVWVaFvBth2ZzDfprULotziXw7fDkJezjPzXo+Cltwfa1Ei3UfGAEKVstnJwzQ3xOAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uvle0WSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9A4C4CEC3;
	Wed,  9 Oct 2024 18:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728499328;
	bh=Web/vzJs6TAHfjZ7w7xwKD5sgMRU+WqPuAd7fBBu/SA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uvle0WSNY/RFrRai07R5ZloqTaUo0dltQPqITOtJ5tC/tAOTZgIPbw3naWiXEFan2
	 +9nxhLSQyXFY70KIOp2q5yh/wgLMgRqFa1vN+1s9/5QMGZ0hBRrMlk3uHgm1jBuhOG
	 VmES8GJGtslz/624JO05ossYAk1ZAVMqubuCxW9Ez0jaRX/a/8a8LWCUaErsXUw6kT
	 E/98G9zD8v1iZCSKQsmrVngQnBcNFV3xVqQbaX5C3kdjEV7TSyW/C9uMboiFkyCdh3
	 7j/5nbpgSRbY3Yl9i405KCCXBjgeov1Jpqkb7/+u4UCFY34Xcg+x8KjAWEXfTSzboI
	 yHZlyNXb1e0Tw==
From: cel@kernel.org
To: Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: Fix NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT
Date: Wed,  9 Oct 2024 14:41:59 -0400
Message-ID: <172849928289.133472.12075054007922427149.b4-ty@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005164039.21255-1-pali@kernel.org>
References: <20240912221917.23802-1-pali@kernel.org> <20241005164039.21255-1-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=xN1cVXO6QNFhWDTcMECh4CmXeO9GRPH7p6UxiKg74wQ=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnBs558czY8vxF0VLjM12KTIoz1+jMBotPUZxaN 3LuL42uuUCJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZwbOeQAKCRAzarMzb2Z/ l8l5D/9ik3XpVCrsNRbgjVk9oMyHi6yqzu1HOPZme6c/GSoOIfDPCNChfhAJLdMnNlW+RIyNQPu G06qMxQDx0nAf99/jd6ZuwXaom+gqi49AqHU8pQ/2g7/sOgTc/3/HzdoXJCAFZ1m0Il5oWtMsm5 FAAOLKJEuom0LRKrGDhKM2iCyQx5hIdomeh4nE+bmHEppANG9Ps0vtCnX9JYqtodJryL6gYgupU EYWpOmUpIWW6CchxMwvuU8QOsbTN9yFVTtnbJ3zxV3bOWAYwFFTDqcvCcNRsIPBIA0A10yWLMzm PZntbvd5vil1isZFK5kJatGvCNg6L/HpXdfjf9uk7ui2Ni/YboBzg5NYwn9h2+T2f284v57f1P7 uk0T+faMIbYkWiP3K/zp8cim9kgfvleIFHeAS5a1KYxOPpYH35PaoTDn4seQCVVdRQRK2unAFYB 8Eok/1T/kySL12Qnd232zXMwdASRSyAZP4TRd4+TuVFFu4Y6+jPs3c/OHzbXTZL7aKtCHRolge4 V4dwwx2iDF5SgcZhhjODAuy1R7VdR5h7PIrBsQz3goc2vJoT9/JaoTxm9eNWwW3N1TQzRe5P9q+ Xptvj6w993G17j0fedcyzzis+5Q8inBxsFIDgeEX+F7/dowuBjsCz1C70ahe5I25oP1iapQYyze kLeff7
 vsqTXESpg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Sat, 05 Oct 2024 18:40:39 +0200, Pali Rohár wrote:                                              
> Currently NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT do not bypass
> only GSS, but bypass any method. This is a problem specially for NFS3
> AUTH_NULL-only exports.
> 
> The purpose of NFSD_MAY_BYPASS_GSS_ON_ROOT is described in RFC 2623,
> section 2.3.2, to allow mounting NFS2/3 GSS-only export without
> authentication. So few procedures which do not expose security risk used
> during mount time can be called also with AUTH_NONE or AUTH_SYS, to allow
> client mount operation to finish successfully.
> 
> [...]                                                                        

Applied to nfsd-next for v6.13, thanks!                                                                

[1/1] nfsd: Fix NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT
      commit: fa3d3ae84c5a6e9bd406c9ef75d3128a46cf1109                                                                      

--                                                                              
Chuck Lever


