Return-Path: <linux-nfs+bounces-7422-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 951DC9AE5CC
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 15:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39D41C20B15
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 13:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7474E14B08E;
	Thu, 24 Oct 2024 13:15:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA2514A0AA
	for <linux-nfs@vger.kernel.org>; Thu, 24 Oct 2024 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775749; cv=none; b=hr7/3XrR/csxrye/8/8D07SgAJDFluiuYLL+fEm6C5DNPRyjBb/TbZVFWUXBtrd71ulqldaJOAnrwDo7zbBNDtnirjBQ69C5K0QPJeZUC64gLj+yOk6CyYVxxi2vd0+ycs5MTCV2GdOJmh1zEmaXj62OV9kdvCwfEycN/VoLNkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775749; c=relaxed/simple;
	bh=9EN1Vxmzm4TeESEg9nKEl5wymJisTc+Br/csxzDYWWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNgDl14QyM8BQLOTpk9Ap6VmkK4iSrcsi0dNbm0esTMb634Rhjvx5MECdv5wZf1Fwh7GY4v5XchbXusHkabZy7ur6fi+P4P6uWnYaBob45Yg594qR+BjrDwhrBAK7IRgBBHSdRr5mFG4sbyZ8tyN2rOMFFaNh6SvZRsq8pBUJJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAB0C4CEC7;
	Thu, 24 Oct 2024 13:15:47 +0000 (UTC)
From: Chuck Lever <chuck.lever@oracle.com>
To: jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	Yang Erkun <yangerkun@huaweicloud.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	yangerkun@huawei.com,
	yi.zhang@huawei.com
Subject: Re: [PATCH 0/3] bugfix for c_show/e_show
Date: Thu, 24 Oct 2024 09:15:30 -0400
Message-ID: <172977514997.2386.3061953100068758789.b4-ty@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241021142343.3857891-1-yangerkun@huaweicloud.com>
References: <20241021142343.3857891-1-yangerkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=879; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=9EN1Vxmzm4TeESEg9nKEl5wymJisTc+Br/csxzDYWWQ=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnGkh2ULgR3vyA7S4mzdtQBtLhb9g0krBFc+QRE hyorOF4GhyJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZxpIdgAKCRAzarMzb2Z/ l/pwD/0YEXjDjjEMZeGlcEOEjW26cJJPPmQ8ZZpJ9cemGJBs+UtAfnVOjuo1/DCJW3lyk8CeXrZ Oan5kP7I5OjRtf+HQ3ELz1IaMjdut+MN6yYlBwH86IPnHbnteMXEfMjtQSJoTaFNCHPDs6i93SH xumFQF3qHT42P++uhlLQLVWPpddlGaL6HzPLF14Kg1TK8KLPLdOSbTkYwvwS4f4UNiSkpeUvxxx IH2xuAfyE4p8MSuoqb/xvwlvibUcBx1SGuoIOCLdyTXmVFxH8Qgy/ZMgT4JnIQdd78D8lWVbz8I xvvhU3pHQvcHMNtw6NIcfHh7UJrgOG3SxhuucUwpaBXmC3LMWU45Klaob2STHc1SWn7uiofG8hh LBzJgfPSTk/z7BLDrvWZW9GmqxtIZiHozFuMEBBRRdxeI231aPO1WPN0JIj38kwgxERuPADdO3n G41qLJbOqdx+endDmW6SajcWHWpDw1vdazqJnNnOK6qzKY9JvTgfDOV2LxTcaLSBwAFhwKrmST+ jsBfRltcZyu9wdQOpqqgezQvU0j4VhmXPDSYEutqHwKhzU0oRxTedHpqpleP76ztc6KP5+w1/e3 lNT0tfD99KXaGkomcF81w/22VF2o7vbMEyFNjgjBpzgcrjzKjZLuE7sa0xiYxcengux3ITCWGwG HdPSpTR
 865zRxNQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

On Mon, 21 Oct 2024 22:23:40 +0800, Yang Erkun wrote:
> Yang Erkun (3):
>   nfsd: make sure exp active before svc_export_show
>   SUNRPC: make sure cache entry active before cache_show
>   nfsd: release svc_expkey/svc_export with rcu_work
> 
> fs/nfsd/export.c   | 36 +++++++++++++++++++++++++++++-------
>  fs/nfsd/export.h   |  4 ++--
>  net/sunrpc/cache.c |  4 +++-
>  3 files changed, 34 insertions(+), 10 deletions(-)
> 
> [...]

Applied to nfsd-next for v6.13, thanks!

[1/3] nfsd: make sure exp active before svc_export_show
      commit: 41bda61ef8e915a6c93eab7bee8d2b4ee11a618e
[2/3] SUNRPC: make sure cache entry active before cache_show
      commit: 1ec5e108acbfbb79e9f2ab3b516d5a29ffb554ae
[3/3] nfsd: release svc_expkey/svc_export with rcu_work
      commit: 9998b0dcb4f2dbba2f084376a58c7261b6d5a541

--
Chuck Lever <chuck.lever@oracle.com>

