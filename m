Return-Path: <linux-nfs+bounces-11603-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5753AB0188
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 19:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C2E4C6C9E
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 17:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E275214234;
	Thu,  8 May 2025 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCwMg4S4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FAF213E8B
	for <linux-nfs@vger.kernel.org>; Thu,  8 May 2025 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725863; cv=none; b=YLOKkWp1sdQyG/csMsd05cd0ALAGLfTRxeI+ZBFZ6oYPY6XEwDhpYcJ/E3mw0SCK6goyI/045ZDPts6tBsdfBH/k5jRsZyJS6o/IZMKRTjzJBQsRjYMhHJySkso17EzY52eYgQ/GI53B4ZcuytnteSirU9Tq65JXgw2FAusiUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725863; c=relaxed/simple;
	bh=zN1UcdcrB9bpjHjxRoFISF/zHouFErlHa26uO+hIAus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sd+Vlv6rFZZmXvZBOOM+GC9wtrNiQdYDs3NXHOWT6O6TF33zEGup8AqAex3VGoZHI5OP5FPre1I3KWI4dyAZ7+U/RKZHJ4G7yyuNPPklb0BbYeomG7SbrtC25W2YFUp5EmAQGrrWj4MzxOPpcX9DpdCpXWiXgKtX53j9gBszx0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCwMg4S4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA97C4CEEB;
	Thu,  8 May 2025 17:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746725862;
	bh=zN1UcdcrB9bpjHjxRoFISF/zHouFErlHa26uO+hIAus=;
	h=From:To:Cc:Subject:Date:From;
	b=MCwMg4S4ZmJyNnh0K+KG2zvhD8ziCNGSymrfpgU1oigPSo1iuxJWcdeVTUdco/3a6
	 /dln77Ee9XTuf0wBsvAPlhTAm0OpxpLMDenaVVF83nnxtNGqha1H3RS3tgppHJNLJ3
	 GSQZr5fA0QjUyqPdTgnEhhQ4lqtTat6i1B5o+RtT6CvZHVXhmyqCXjMeJQ462IOthF
	 uIpfaq0gRk3AXLBG39lm/Or4E3Q8pCd4l+JhjusC6D30NnGzLzU54MrM7ge6xYpcdu
	 LsKy2KXhaQjzKjJASrzNiLuzMn85EBf9GRNGGWUlYBrfXSzIpcRXGlmySv+TUA49Xz
	 iESIc6x+wP87Q==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/6] Remove svc_rqst :: rq_vec
Date: Thu,  8 May 2025 13:37:34 -0400
Message-ID: <20250508173740.5475-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I expect this arrangement will not be permanent: the end-goal
might be folio queues rather than bio_vecs.

I intend to insert these into the series that expands the maximum
r/wsize, once this series is reviewed.

Testing has shown no correctness issues. There is a consistent and
measurable performance loss on NFSv4.1 with the write path changes.
I've mitigated it somewhat in this version of the series, but I
still do not understand why it happens (it also happened when the
series used svc_fill_write_vector()).

Chuck Lever (6):
  NFSD: Use rqstp->rq_bvec in nfsd_iter_read()
  SUNRPC: Export xdr_buf_to_bvec()
  NFSD: De-duplicate the svc_fill_write_vector() call sites
  NFSD: Use rqstp->rq_bvec in nfsd_iter_write()
  SUNRPC: Remove svc_fill_write_vector()
  SUNRPC: Remove svc_rqst :: rq_vec

 fs/nfsd/nfs3proc.c         |  5 +--
 fs/nfsd/nfs4proc.c         |  8 ++---
 fs/nfsd/nfsproc.c          |  9 ++----
 fs/nfsd/vfs.c              | 65 +++++++++++++++++++++++++++-----------
 fs/nfsd/vfs.h              | 10 +++---
 include/linux/sunrpc/svc.h |  3 --
 net/sunrpc/svc.c           | 46 ---------------------------
 net/sunrpc/xdr.c           |  1 +
 8 files changed, 59 insertions(+), 88 deletions(-)

-- 
2.49.0


