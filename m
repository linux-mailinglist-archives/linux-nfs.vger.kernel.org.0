Return-Path: <linux-nfs+bounces-9034-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEF4A080A5
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 20:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC83167A2D
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 19:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EC31A239D;
	Thu,  9 Jan 2025 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrObyKMl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD46884039
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jan 2025 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736451610; cv=none; b=pXapak3+6az+TtLfN03TEXHj+GG4xVIcV+Rtdz/RF+olm1n4L8s7MeWoA1XxEmSXHXUVvU8cl/VZvIuhVivSP9Mu+RuBbIHajF00CpLVhxbcqhn7QIrA68s6YwlBVCSnSfZib9AgJC2oaTqW6kNZ4poeAQghScOYyne0AbFv00c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736451610; c=relaxed/simple;
	bh=AzGlgNYk/qUuzqYmAwGe5P7EIYQ4kZMwA0siNU2x4K0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s4Q/qkEcLzNrXHQE+3fLJuz8yUFSnlAcHbeyY13qb8WIj03l8DyD6Cc/3sh42W3upTLElovazLtjVItPAQtvpDZTiVAAXFFNuE6ktl1lwGkS0/l/Nbc5Gsja1W2I8NyUkb4lCV3I7m2T0qrwNtXWjQg/t+Jhw57cY9F4wFq6ZUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrObyKMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2787C4CED2;
	Thu,  9 Jan 2025 19:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736451610;
	bh=AzGlgNYk/qUuzqYmAwGe5P7EIYQ4kZMwA0siNU2x4K0=;
	h=From:Subject:Date:To:Cc:From;
	b=YrObyKMlJ1Qy/3wGevMmQOUluM0vehwMFhECo8w4Wxd2P4QkPspP0BQ22jDuIjQ2o
	 DPcPdybPsNLLIVW2ajmRoX6vI/6HuG7YywDoSp+40N/0t5g4Oil7gyM7+WF9RDl05R
	 XbV/sywTNH6QgN5omH8BJgd8umyZvMcYMnIwSEvyFvSktg4Xq06Ljj2MK4fYvKT8NF
	 VCjFKNIfze81vXB3wFa45Q6MujPamGabe/bQU0B5LIlyhk08MEiAPfnxwxhBeTYiF0
	 /AWMuJPH3Cmecqe06w1ED2vNw6ubCxlaqTcBlmPALrA1QroHsergAViRm6Q/TGA+aQ
	 HD1FasDqplvVA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/3] nfsdctl: add support for new lockd configuration
 interface
Date: Thu, 09 Jan 2025 14:40:03 -0500
Message-Id: <20250109-lockd-nl-v1-0-108548ab0b6b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABMmgGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQwNL3Zz85OwU3bwcXTMjc6O0RMtUi0TTFCWg8oKi1LTMCrBR0bG1tQB
 KNIV9WgAAAA==
X-Change-ID: 20250109-lockd-nl-6272fa9e8a5d
To: Steve Dickson <steved@redhat.com>
Cc: Scott Mayhew <smayhew@redhat.com>, Yongcheng Yang <yoyang@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=AzGlgNYk/qUuzqYmAwGe5P7EIYQ4kZMwA0siNU2x4K0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBngCYY8Ax1JJtAxQeEDsCyF6j0GU7gP6Y3Xby2J
 FMJGVFmSjqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ4AmGAAKCRAADmhBGVaC
 FTIOD/9MzQscRYAPyyW+FQ8B2qo0TQejDq/Sm+4WbjTHCqpCGzt/41RSM5mTc1DnCSIGxbISUCV
 Vfqy3n/1vXJ+57SCYAjMrqwASqdy4EewO15mAchZZxmYjp2FwE4d/OOCZVY458qxGAJCc0oBmxP
 Yk0v6w0e7gYaLrXhzJcuKp5rfpDEVdfyd/YuDRUtYQtiwFyRQlogRHtuDG3KWqMY5Gbi00h9AgC
 8Zv9PzOCa174/Pq9mR2ZDk0C6Yv2CJG4ZOjshJoZhXN/ZzMH5lwHa9zZ1ckL8L1cUsJymIm/GDU
 cTCu3yJj4yQW1D4hO26d54NuU1HlxLZm5pHcN/xxjyN7Z5vpN3JjSRdY4bi7qA71JA0cqYZ4uBR
 rK1gbEXR5CdQsFjBnNYXxf/C8eW9kgqBP00DltZkzAUD6tVhX1LGoP70tSQDg3cYsH1eTRlKvF3
 4zt9N7h3Du/WLHV7lQFD2MslxrozKt8wxvj1pECahyzFHyuYOuoydxEuXtQrwuwtvVTblCfqmg0
 YmwPOG8gO0WbdTphzwJJ8I0KpPzDurtUaa4WnCQ+5D5jNeRtVAGXE3MY+7kXgnFUNgfHn/sM6ln
 UL0Y9A9NXAEkvfNvG35mh/+YO5YWqaAsTkbN/rdm19KD8+SsR4tqPdadbh0sovlhhC1sc+yy3oC
 /mus85Qf8nuzjyA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This patch series adds support for the new lockd configuration interface
that should fix this RH bug:

    https://issues.redhat.com/browse/RHEL-71698

There are some other improvements here too, notably a switch to xlog.
Only lightly tested, but seems to do the right thing.

Port handling with lockd still needs more work. Currently that is
usually configured by rpc.statd. I think we need to convert it to
use netlink to configure the ports as well, when it's able.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (3):
      nfsdctl: convert to xlog()
      nfsdctl: fix the --version option
      nfsdctl: add necessary bits to configure lockd

 configure.ac                  |   4 +
 utils/nfsdctl/lockd_netlink.h |  29 ++++
 utils/nfsdctl/nfsdctl.adoc    |   8 ++
 utils/nfsdctl/nfsdctl.c       | 323 ++++++++++++++++++++++++++++++++++--------
 4 files changed, 301 insertions(+), 63 deletions(-)
---
base-commit: 3423eb18c80db7ac2bfebe10b1e2e9586b84679b
change-id: 20250109-lockd-nl-6272fa9e8a5d

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


