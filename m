Return-Path: <linux-nfs+bounces-5410-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0E89548F5
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 14:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D6A1F2515C
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 12:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025AF192B93;
	Fri, 16 Aug 2024 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kidgWAr1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF47416F839;
	Fri, 16 Aug 2024 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812153; cv=none; b=q9EYCy52aBoq3hV+wff9njk0A5OsTC4OkTSVV/GYyF62oKqxMx44fF1vDJ6YQCjnmYeiiJMqG3G+X6f2VJBI/LTRaxlQH5e51nyVJhhRyoHhg5+MmqffKy+QT/t2Ehx5C81E/GgoY8shUvM9oq4LkcWoAdwaoPtXhg8knMiKilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812153; c=relaxed/simple;
	bh=+ru+RPAUuulu0jmH4Fzkx3GT7ksvWqMG2TKyXNLGXl0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=As5Trd+UUBi4UhDaCYKn3lrPgMAkT6Rqz1hfhRHyGJOHEBtmWhUSLAZF9vFK9CVMNXG7X6FR5IxVQTjMPaZECCvs3JOr23ElWWazY69KeDrBMo9G0FwHWjq14Hk4lt/8qkv4soqBkbZlzuapocvK2NN7EDtyHL34J/CldgV/7Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kidgWAr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F3BC32782;
	Fri, 16 Aug 2024 12:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723812153;
	bh=+ru+RPAUuulu0jmH4Fzkx3GT7ksvWqMG2TKyXNLGXl0=;
	h=From:Subject:Date:To:Cc:From;
	b=kidgWAr178BPZRQ3uDwHDL0LAPNMVtMp1nXk9eYJElM0TmHMEEcMr7bDgEBbK6FkD
	 kka7U7AFeguJFWaONmbREMcB73s8gMSc6/FVGrgCrTSZ6grC5H45OE4T7KJZGnpCPZ
	 q0JWS5yzdiOo5qv49VV0Ya0HrFSdM8Z44yLy2nRKCcbtv9XBYGYqRMN/6aujIQgUTz
	 EE6fdVEbfEclsiLhtDqsoxHyvYLE1XpT1sWkAYehQ1OJJ/NZJq/gobw8WQ5Ne1PvjP
	 hHVqtSlwWTkRk6zkyPUePNxGKZ17JWvoJKdZ0EiwiNBTE+Hk2LfKfGpNdoIXWX4CkN
	 v6Bmx+QhaFArg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/3] nfsd: implement OPEN_XOR_DELEGATION part of delstid
 draft
Date: Fri, 16 Aug 2024 08:42:06 -0400
Message-Id: <20240816-delstid-v1-0-c221c3dc14cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB5Jv2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC0NT3ZTUnOKSzBRdS2MjSwMzS8PEFENDJaDqgqLUtMwKsEnRsbW1AAi
 8iMVZAAAA
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Tom Haynes <loghyr@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1589; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+ru+RPAUuulu0jmH4Fzkx3GT7ksvWqMG2TKyXNLGXl0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmv0kxTqKDXRkAwNjz4U90vjAQTVHNwkLYzx60F
 OJTOP0f65qJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZr9JMQAKCRAADmhBGVaC
 FbVaEAC/J2GP5mWAENPl5N/rrAjiHhtfb+rd/7hmMYHTXZ3o66u0LLXtR18yTWVrbGmdBa4Dhlk
 qgiShaG/2eOyszCyTEn7mIJ0BJgIX+6kSXe2wzZ+S8kZxKqO4EkAshPd52t2wVTIEH/BfRZiUGc
 u57syd+MLbgsdEKZKkZCEAErCkibdnsYZFhMgMZMQmAccHMxPy+YOh8UnWmq8q1nQ9Ik3UpwWRJ
 T1HCzqR4PI/SWQYGo3M/Rai2c9CROjnStYMYQcWq2XhBk9ttPUdALWViXlaaljF6vCMpBzDtHyX
 8uZ5XWunp4SyN9jj/fWKkV6vyTTDQAq3Y1GT/saosMbhHNeQxqQiEoEYoRLgqB4EETFofkscpOP
 Jf0kAm84w4/7mJsGI3ZaonTfiPnivsaE+RyPu9s3GVT/UHc2bWCXRos4RODLUt7wpSqY8BzXs/c
 K2rqh/ew+73Qa1Oo/Dcjaalicp7dyzi7pp5U+NPzPj3o25SXNXWYZeHNsbxx2YnZgbkerq9vbfA
 SAdY830EbnVTyH+EmlKaS1c3fcgnvhjm/zTsTA3vDGeWUjXbeVkW48WyNkUSi9MDc+Vozuqgugj
 AzUE+zt91RBGUdDDHkZOn9o9UOq/YWChxnLmFDXWKvtY9/YM5dR6XFVSop7+NisNXVF4ZfuJtse
 Ug9x/DkOrcQpGmA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This adds support for part of the "delstid" draft:

    https://datatracker.ietf.org/doc/draft-ietf-nfsv4-delstid/05/

Specifically, this adds support for the OPEN_XOR_DELEGATION part of the
draft. That allows the client to avoid issuing CLOSE compounds when it
holds a delegation.

For the XDR handling, I used Chuck's new lkxdrgen tool to generate the
relevant boilerplate, and then hand tweaked it in places to work around
bugs in the decoder, naming conflicts, etc.

I've left the encoders and decoders for the delegated timestamp handling
in the XDR patch, but I'm still studying that piece and it isn't
implemented yet. That may require some timestamp handling surgery at the
VFS layer. I think it's doable and may actually be simpler to implement
on top of the multigrain work.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (3):
      nfsd: bring in support for delstid draft XDR encoding
      nfsd: add support for FATTR4_OPEN_ARGUMENTS
      nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION

 fs/nfsd/Makefile          |   2 +-
 fs/nfsd/delstid_xdr.c     | 464 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/delstid_xdr.h     | 105 +++++++++++
 fs/nfsd/nfs4state.c       |  29 ++-
 fs/nfsd/nfs4xdr.c         |  57 +++++-
 fs/nfsd/nfsd.h            |   3 +-
 include/uapi/linux/nfs4.h |   7 +-
 7 files changed, 658 insertions(+), 9 deletions(-)
---
base-commit: 6d0cd2727ed2cf725b1f20dc4e2d0d138c1cf117
change-id: 20240815-delstid-93290691ad11

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


