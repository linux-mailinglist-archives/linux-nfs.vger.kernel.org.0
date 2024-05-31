Return-Path: <linux-nfs+bounces-3507-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3685D8D62BB
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 15:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E534E28B466
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 13:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08461158A1A;
	Fri, 31 May 2024 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Del8QPpA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F09339A1;
	Fri, 31 May 2024 13:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161366; cv=none; b=TLVQBVhm5qIeFpfR5cx1psYRYEt0T5grhI5v/wSUokhyfyHAJvYfsGsozeujtLBL/0lxSPAoGOO4B/XJBfFijdjwLpEJ1Eqwx8QGTNt4qVIOe1oDQemvBDXWZ8FAVzh/izzvbH6OkwDUCI7pxzikl1fl7OBFAya80MMWwbiwZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161366; c=relaxed/simple;
	bh=+qEskCWWVHweD7xwcnQ6XiXDD/FsdG2kkWJmAeTSeRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GuYOUs5qivlQFM3TN4KQ07al7AfxDgSGZI0hZOym1zWi1Sq1kZz/LGWYQy30EHuGSDHb4sM/+nBlix/DZLbJiyHNtZV/tNrr4qBf/+32YngoQy/2PUK+SBpiszukAcU22DqGGlhProWD1lnUOlNoDupRxYZh7dzyc0QVkk1S1jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Del8QPpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DB9C116B1;
	Fri, 31 May 2024 13:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717161366;
	bh=+qEskCWWVHweD7xwcnQ6XiXDD/FsdG2kkWJmAeTSeRA=;
	h=From:To:Cc:Subject:Date:From;
	b=Del8QPpAnCz1ub8tyuErQxJW2GfYkWfTnau8irRJxfM5ErrajuY0lBU/shRvCssHK
	 iUaTvKsUePAUH/lTsHDAEopwdiplzF48t1+/HPWmep0AoIy8L6l0eKb32H4vqTZcA/
	 x4sx2UnAWVNUDDSrH+8Lsgfo6sgmFnVweOxPQwplP5g8baAIhxJ9xNk5Ls+uNA/pK0
	 qMZQNpMaI5N6tJxKuRHeteY2ZktyD18bN2E/tNhMUH8GMJKc/DrhozpRc+P/FCmUnY
	 h1CTqC7TokdkFlD63F8Zi9lZ3bSiqme0tgA2aQ6n67sLbkzhCiwzYSDrNOQ1rGA1GD
	 ENMRXZTIx+qpg==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 0/2] Fix ADDR_CHANGE event handling for NFSD
Date: Fri, 31 May 2024 09:15:51 -0400
Message-ID: <20240531131550.64044-4-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=440; i=chuck.lever@oracle.com; h=from:subject; bh=MXera/6eGlKCuU5wjm0cZ2RlQwRR/54kId7cUbm6Eak=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmWc2H1dVeFw9G2yWXZHuN6u+q+dX8ukUDFvM65 lSMGVDFNBuJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZlnNhwAKCRAzarMzb2Z/ l/EfD/9+jd1YSSnCsTW/4MFfDJSUUev3AQHRtgT+b6jbP/CtstVTrmWwMAl1tjztSnLlxBK/JOP Fb/P60QW2ko4YDLcnFuWdKeUs97hLmwC65n0ygWRPdBMe+bG5Kx8Jdj70T3S2KsLSMLazxBZcRB QgnWvpBE6HrSN/HUyqA4m5ncAjdTOVg7UIN71uUCqRNll2ti7YAgyQ87iFAr0Gq4SPDyXSJrZLV NcuuY7/l2LE48WjcXhJVw2Ngq7KdOXdwPqgJROdo88wDm5yyPOjEArZyAzYg1CER8Y6JsG1N2K4 g8tGe2kJBf5w6E7QILzS9W6+KjJOC77CSwkUNCfcawS0JViTRikqKT4mO58JrMhrfUk/J0tCcj8 D2K8rHjhWayoTori19uzWUdMxyYFlVCBOYeyY1FbJZ0VH0zWk3IShIyYwgVOECpGCFmgu4dzE4e K31UJdp0VlVt6vvx13nuhQMWAEtIS9m+5RYD7TDbtmuteixI9lVJ8qc++sAeQ2Q2UGfyXbFmgbE EhS+WpkISJ9oJjr6LZ7m0MSRZvCo/ruAqfwAlGcRUf7HhFcLVvXz3t8DMSmUREWP/Rcgbz96FfD fNUmhbY8VSPtwW2phFiBLu5CI1lC9PKUoBnv8zeNnZiWY2jwW/iae99Sp1M9jveZ9QtHndnIbyN QO7yLtwtHzRfSWw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Sagi recently pointed out that the CM ADDR_CHANGE event handler in
svcrdma has a bug similar to one he fixed in the NVMe target. This
series attempts to address that issue.

Chuck Lever (2):
  svcrdma: Refactor the creation of listener CMA ID
  svcrdma: Handle ADDR_CHANGE CM event properly

 net/sunrpc/xprtrdma/svc_rdma_transport.c | 83 ++++++++++++++++--------
 1 file changed, 55 insertions(+), 28 deletions(-)

-- 
2.45.1


