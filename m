Return-Path: <linux-nfs+bounces-14588-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6814AB872BB
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 23:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403FC1B280E8
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 21:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC1D2FCBF9;
	Thu, 18 Sep 2025 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1h6j2MC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B25E2DAFA5
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 21:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758231721; cv=none; b=pXyKbH4qnNpBVKpGG9nn6pB1SqB1T52o4NTVuBVmifiCL9y1y/b8pN5Z/rpK2g/7UVoYhwXCj5bcXFQAB/Be7KEcoeX/yl6UqAQBnMrg+pudb31pke+b8i8T0tPtEubDDs1oAxIfFzrUcvyscrIsbXYbfWYNm4SjTh2kxj7Dz1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758231721; c=relaxed/simple;
	bh=mt/kKZtYhBk2/J5gJtnW5e7gEKoGdDQZidTmY3ShXYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqOdZqMZRI59x/P/FcGpX32p1thi5DWM537ibhEWvL6w3dBcXh5qUGkkyx5qS8PpUf5HIHMFHAl0YH+bnvoBYqk/t8yCc6k56u/PxgrGGABWus7BxXVB1JtXKJebYpxb6eEplJlMkos3uEwGy753q1yoLo6zyN7JH7Apwe4qZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1h6j2MC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6361CC4CEE7;
	Thu, 18 Sep 2025 21:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758231720;
	bh=mt/kKZtYhBk2/J5gJtnW5e7gEKoGdDQZidTmY3ShXYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a1h6j2MCQCJ4FdJV9wxZ+YS8tDaTWwpLKHXvnB5AKnUGMmeOyCHgNmEIoU2oz0le+
	 n3LYYNRCk/TE9x8ghPVHp4wFUxdqUUvqHj0rOvOxnBTZHB6zS0mkcOt1hSn4Trvu19
	 H8yQWX8wh66GOhAp1BPttBUABv7ElLkNzL34o5B2CUMnA1bqayuiUqxJnIfdG6UNzO
	 7O61zuKUenlRxi+A4ZZ+ZzSZvQnI+RRoDEtaDosqcX9yjpdBGUCp5BagTs2IoQQEyN
	 B19Z37AHIOnOSWpvvUhWhgnBHLAW+00z8PCF5/2/HKbDAep+19dMIiNDjb2GQSyCb4
	 8BNtaJrrK8EJA==
Date: Thu, 18 Sep 2025 17:41:59 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v10 6/7] nfs/localio: add tracepoints for misaligned DIO
 READ and WRITE support
Message-ID: <aMx8p5BesD_OhBtF@kernel.org>
References: <20250917181843.33865-1-snitzer@kernel.org>
 <20250917181843.33865-7-snitzer@kernel.org>
 <23118649-3dc6-443b-beb7-9360199e93e3@oracle.com>
 <aMxFhX-jHnfv1F24@kernel.org>
 <9d8fb1e9-d40c-4c00-a555-e37ac0d4f290@oracle.com>
 <aMxbtqugI2dhwsF6@kernel.org>
 <34a15201-e8bd-4269-9f18-e74394c63dba@oracle.com>
 <aMxpKagpCRll2Cjj@kernel.org>
 <aMxzimxm6ZahmY68@kernel.org>
 <de815f74-411d-49dc-bd3e-3d4e25270661@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de815f74-411d-49dc-bd3e-3d4e25270661@oracle.com>

On Thu, Sep 18, 2025 at 05:07:55PM -0400, Anna Schumaker wrote:
> Here's my .config file. Maybe it'll help reproduce the issue?

Using your config I was able to reproduce on EL9 with gcc 15.1.1-2

The key clue for me was:

  CC [M]  nfs2xdr.o
In file included from nfstrace.h:11,
                 from nfs2xdr.c:26:
nfstrace.h:1796:31: error: `struct nfs_local_dio´ declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
 1796 |                  const struct nfs_local_dio *local_dio),\
      |                               ^~~~~~~~~~~~~

This fixes the issue for me, please feel free to fold it in.. its the
same issue I had with nfs3xdr.c (I audited the other files that
include nfstrace.h, it seems all others include internal.h first):

diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index 6e75c6c2d234..9eff09158518 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -23,8 +23,8 @@
 #include <linux/nfs2.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_common.h>
-#include "nfstrace.h"
 #include "internal.h"
+#include "nfstrace.h"
 
 #define NFSDBG_FACILITY		NFSDBG_XDR


