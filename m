Return-Path: <linux-nfs+bounces-7748-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6F99C1E30
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 14:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0431C210B2
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 13:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7325F1EB9F5;
	Fri,  8 Nov 2024 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PK59P0rR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9E61E907A
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731072882; cv=none; b=EdrtHJKl8aDUI119Iwrr97ALo67fRoVoBj+Sh39SspbITwOPNSHOWULtxwzf5/+r3uU4NowKcpIlw3XcUe5jgb3rRG3ra6eVP5Cem8zV/FkfQs1iwVhdZXVjC/tFVLT0Sy/9LngO1BVQZq/o3QNTBndPkiCQpVuJHiRzA8drR3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731072882; c=relaxed/simple;
	bh=VUxl82bl58ZjrW4h+yriFgmQuuGfaIRJEZRRi1SpZSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2i+qL08W1DdqEN2rQaLPog/8edT27doZvZKrDv37FXVczHIiBDwDqvXQx9c2m0aa81vqXu9gATDsrLE6WQAEaBF8AupwWnan0IXVX24oaMQ5hoN7kZWHogqTyiJxIrDjcYX+SlspfLbdYDbn8hbxTfaP12rudBR/zfDiiHk0tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PK59P0rR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4024C4CECD;
	Fri,  8 Nov 2024 13:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731072881;
	bh=VUxl82bl58ZjrW4h+yriFgmQuuGfaIRJEZRRi1SpZSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PK59P0rRfA1Ho1hFbOIMG7awqYVHRhijSj6dw0a46VnM1NVoe9VQfO+x/asDPu17N
	 bPDz+K1+9clVeikbZv5e8O9OaTz4KARKqdl9gvLcvowOsJ/zL6Wuiwrov24FeCtjR+
	 WrWNVaRuPmhUIoe7pih1VhEJTLkoChY+vua+wJS8NmFRGWeVyye27M5NSXgJ8K+4Ad
	 SWZrhn5/aWDLxKy00LtNZz6GSu8uir7cWbJmvbh3ZiUoKbGSOb4wWKVN44FfFw98VJ
	 /qju5jMufTKWK5XbCbbmkLFIOvrXDux6z6sjXJXk0KzN5mq+cFX39rYqMcuPeKQyuF
	 OAMGGm3u5IkCA==
From: cel@kernel.org
To: jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	Yang Erkun <yangerkun@huaweicloud.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	yangerkun@huawei.com,
	yi.zhang@huawei.com
Subject: Re: [PATCH v3] nfsd: fix nfs4_openowner leak when concurrent nfsd4_open occur
Date: Fri,  8 Nov 2024 08:34:30 -0500
Message-ID: <173107266299.128364.12910305911313577633.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105110314.2122967-1-yangerkun@huaweicloud.com>
References: <20241105110314.2122967-1-yangerkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=uhmWmQJugE4/pEA51rXyX64Rw0mHr6qUKONjrGUG8lY=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnLhNoOrrLSv6Qw6c6XfekVOBN7PKI/bIJyZmc8 QKkbznhY0+JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZy4TaAAKCRAzarMzb2Z/ ly4pD/9xFhyVKJAVfF/9qIFXS8O06ExFVNWoMlGhXXCktznwbCz5nGLd8lal9RHsyLu6TuMlXW6 byrtTfVjPdKb2k3OB320ShqzB4LntHT1bP2+TYceQ/oFhXxFhq05EXXGuw+vVBm7C/zzSJ6Xvi7 /A4dKHwUparAHcsLTioKWwZQXT88aofm/Yy0DdLvR8CiNcSdNds2Xlu6uwydx3RvfmLxXz1gyq4 qeeeSMOO8XWYHwuI/L7E7ZLWmiMmncLcbSKQolPHGYuv7NsjqKPrwG0Y4ySJg8rdaDDeOcMn1Sg 7xKfEi4ju0Y6T5cgJATQCZk/7ec1wo4JROozLelc34++vNs2ryYuuc8pr4cCt+8TIDrxD4MnMWp Gc/inxLtjK94cKDIZJHdLhWdqe2zatw6dEKjvZmuEcQdYjHGwjLmOBjwu/cfvvK6q6biF3EO3c4 cyH1fxByBzLZPe/eXrHQRRP9pjLiRP+TJqyCwnWdKP0zm7ueX4OUDrj/pyQiLAZUR1cKiMTxjEX MIBO/uLjmTK1NMjUClVky5NAx0FSqx7ffavZiEV4m6Wh56nJufhS52CiWXQwqXlWEdjtDMSq/fR ttBBbIXmEUYhD46LDTpOyicJ9JSbBp6ZNsDnX4bNvv5hGcJdGnzc0zR8FcvBGrV6taOQswpPx+J 1sGEAS
 SJaIWehlw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 05 Nov 2024 19:03:14 +0800, Yang Erkun wrote:                                              
> The action force umount(umount -f) will attempt to kill all rpc_task even
> umount operation may ultimately fail if some files remain open.
> Consequently, if an action attempts to open a file, it can potentially
> send two rpc_task to nfs server.
> 
>                    NFS CLIENT
> thread1                             thread2
> open("file")
> ...
> nfs4_do_open
>  _nfs4_do_open
>   _nfs4_open_and_get_state
>    _nfs4_proc_open
>     nfs4_run_open_task
>      /* rpc_task1 */
>      rpc_run_task
>      rpc_wait_for_completion_task
> 
> [...]                                                                        

Applied to nfsd-next for v6.13, thanks!                                                                

[1/1] nfsd: fix nfs4_openowner leak when concurrent nfsd4_open occur
      commit: 519cdbfe501ddf4a29b9c72b6961c58a33afb041                                                                      

--                                                                              
Chuck Lever


