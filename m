Return-Path: <linux-nfs+bounces-4078-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F8090F549
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 19:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542721F2121D
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 17:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B77313FD83;
	Wed, 19 Jun 2024 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+hAWD7P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2776C1E87B
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818801; cv=none; b=amb23EaYEdCOf0ngeGGBEbppFG4PjWIhiKV+F9Hh99/jF642t0lJ2BNmE8T8riz19gBWhVBLmQUC8XaqtanGXAsD88ezUpT+lqtfyYbRmCM05/vVazwohjc4cWWXLEdHwhmSmBdRfHfhaSICkA5LKPiEP1rlCHYGDWP6CaiQL8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818801; c=relaxed/simple;
	bh=oYRQyo+GUNSeJ31+RLpnNF9e7E1GqgywHzaeeFuILUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UjLWvfRtGq1fnHEq+gfsg8+A+bTK934xh5/SeVwWeSqAVBs/xu7K2w1WdCrV5pOczDrJPzoOu+WxfPORFb1ONsGGL5q6ORruRCaIS087JfrrgVi+AGk3rHxV2dVIzURe7y+hANlKHbVQTEqWXCgvqVOb85Jq6kDBCweev24FbQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+hAWD7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99830C2BBFC;
	Wed, 19 Jun 2024 17:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718818801;
	bh=oYRQyo+GUNSeJ31+RLpnNF9e7E1GqgywHzaeeFuILUw=;
	h=From:To:Cc:Subject:Date:From;
	b=K+hAWD7P5J5lq8VxHVnGSvIUdPNMy3srpv1DZIH1F2yfcvUHar8b01UOJVBk7LuAT
	 TKEcPxg1NbZeB2UpYhA8S2FHCVzJXKIOmCk0kH5PuJHnMX1ZYKQLX0WUI74Ruya/Gm
	 X6zAsqL/NtMqqZqTIScAtZpOlW2ChprEcGf+VDb1N7gXXpcL3qeq9bnVydyG+b1wel
	 LCj14b+ztxJicJBJdRmPx1u2uP63gg7O8sIvW4St8pjF3RMS0BYl1DO8VkBfk2Ua/M
	 Ek9gImssiIulIAC4prDZdCYmBzvU+Cm6KVe0CUE+lRFpPxLexqpae1hAaDuLBzZ0mL
	 OkUYuBjBwVAGQ==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/4] Snapshot of fixes for SCSI PR key registration
Date: Wed, 19 Jun 2024 13:39:30 -0400
Message-ID: <20240619173929.177818-6-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144; i=chuck.lever@oracle.com; h=from:subject; bh=K91NKs+SI2I3iJSbKt9wGngyUDctsBA7c/rKGYr7Qv0=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmcxfRLyplWdffef4VxcxliEA6HkhirQJ3DILs5 lU8M2Su+7iJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZnMX0QAKCRAzarMzb2Z/ lyuUEACG9+OmghoVHXz5NMDyUhkzvazeR9DPucQ/YqXxW8JpTnsZVFEdLnjt3vpyqnSMfqUzMvu 3HoQf5wqi4BoqrE4/s81PUMMbylFIHFzHh9VYbLua5x3xhDXTy/BJdl2bStMHZqmDPL+AxPTQDo DRPZXq6UcCHWwcmdVxR2O8fbsEVHDGR4nc86dknKIdr90oFLAbzC0JZZLoR4MhIWoI1EuDqApyl ARLf8Q74Ptd5P39U8uNc9BfJk2RWmIxfFQC6bXwndClokzIGrYfr9SgIFsTpMzO7iXm2wbu84Ow rcrlDeBaWvvGAFT3sR6ak4KLJUGsrFFDT0Rmc23E5EaiH+7cqp2JpbtG5odtuTU/h2OBd1lnsku FFZE4SjS8SMUGu5MdrbRtW3FBVb6N4TGfs7S91QNbuNJQFc21v8MqczySJMI4wLIFTcZ2WmU+xw P+Fm48yHhnlViMKVQtC9CGYUeWmpWZz+v8oYTc6n13ws19ltPkDmdmQ3YkOHKGcChS15Frlc/dG aHrV4oiPuauLon4UOt+uz/8wN0YvcVmC/UqjjwGEfw90+cSX+uDBz542e4y4c/XBXb1PgPMeK6K 5873KqMbZT4ZMmlGDnFWoFMmUCAfFvz5RqLhKlJMOJPB4aCalPAQMvpIfppuX92UxsYJQzPF7At JmiIQhVqQER6CBw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

With "Fix premature PR key unregistration", generic/069 seems happy
now. It's kind of a brute-force fix, though. The race window narrows
significantly when "Use bulk page allocation APIs" is applied, which
suggests this issue might not appear in every environment.

However, I still see:
 - generic/108 throw PR-related block I/O errors
 - instances of double key registration and unregistration

Looking for comments and advice while I proceed with more
troubleshooting.

Chuck Lever (4):
  nfs/blocklayout: SCSI layout trace points for reservation key
    reg/unreg
  nfs/blocklayout: Report only when /no/ device is found
  nfs/blocklayout: Fix premature PR key unregistration
  nfs/blocklayout: Use bulk page allocation APIs

 fs/nfs/blocklayout/blocklayout.c |  9 ++++-
 fs/nfs/blocklayout/blocklayout.h |  1 +
 fs/nfs/blocklayout/dev.c         | 63 +++++++++++++++++++++-----------
 fs/nfs/nfs4trace.c               |  5 +++
 fs/nfs/nfs4trace.h               | 62 +++++++++++++++++++++++++++++++
 fs/nfs/pnfs_dev.c                | 15 +++-----
 6 files changed, 123 insertions(+), 32 deletions(-)

-- 
2.45.1


