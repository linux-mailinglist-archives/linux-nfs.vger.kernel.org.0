Return-Path: <linux-nfs+bounces-7423-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4AB9AE5CD
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 15:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839D31F23E0E
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 13:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB28014A0AA;
	Thu, 24 Oct 2024 13:15:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B961D220E
	for <linux-nfs@vger.kernel.org>; Thu, 24 Oct 2024 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775752; cv=none; b=E2euIlybtMdERQePFHu/SyRFPbNGVqz4yK31DE4S5gFQ6zZdOv56ofHr9AFkzcG2TAylDb4ZGZX/oB2lZYveDkRFtxz5EfuUC3BtcKjqjNMi060lxbWpm6MP3XnPlJvzlQ0k4zhE7MQ8Xgeb+2NHvGBtihOVhJKAk/0ZL6mgr1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775752; c=relaxed/simple;
	bh=/if2SRA8cfotDwlv8nvTPfk3qtV5+m6+7HsVRS0Y2bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozC5ayoDKsdAOpdKaFbl5cRci3JyeDu68upPO+YMGwXXghwHRX6239+bGJX38+87HJ3YjlSljcmqwmdoqG9kOmYtpPsSLq+jDFbomC3UauCTcPmE1EukPa3/EWsQlNpU4jfK48kKI69r2FvyZMn0y6HQY0Jg6M0a4hroutYaNVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8F5C4CECC;
	Thu, 24 Oct 2024 13:15:50 +0000 (UTC)
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
Subject: Re: [PATCH] nfsd: cancel nfsd_shrinker_work using sync mode in nfs4_state_shutdown_net
Date: Thu, 24 Oct 2024 09:15:31 -0400
Message-ID: <172977514996.2386.13476022308824251529.b4-ty@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241021082540.2885014-1-yangerkun@huaweicloud.com>
References: <20241021082540.2885014-1-yangerkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=700; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=/if2SRA8cfotDwlv8nvTPfk3qtV5+m6+7HsVRS0Y2bg=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnGkh8KTejB6HHhyiRRduTWPzCWctxBihQLxFyA zcGrVtTtIuJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZxpIfAAKCRAzarMzb2Z/ l+iED/9/hjJWj5F753utWrUJXdsxQXFUQzVf2egqG8VICS43wZiM/3TfkD+SMmFgn60ZS3RcgYb UfImtP4uwrt9H54SDG3xPFSFS9k08259rqChnqyBSn8Uai0ONYoMsoHV8EwpUI8XWK9pBjbErNL 6jLXuYSAKIx73VLFAy42LPQ/b3w8+RdJjIx0S5aW2zVgStdNkJ46LFxgjGwb+zlzVhvvy8mRrKX zKI6uBBbq4jqoxHrrOpeMxMyXWgz9+8NAggYAKZ6e3YWpxRGx+M1YFJDnrfre6wv5pdQ2ubadzb lA6Y6GKJJ++wW7ssusb2l73Xr3+FMDsvIo61upLZjpZoboSxGqjqrCCalAnXJmwgQk/DdX+qVHL twxke9yzrMpSrGYHzVqVOmmAFlteYDo8JkmEy15P8jPmaFYRjlDN2qaP01cKdCuGg3Ex7UzMMTs O0jo/teBwp7iAYODxu+nr55d8KrCyNYsrYoPTeYg0rcpiP6py0ZCr+pSOK3J/YoIUzADjUyHguS qOZmSnCJ8xrAKE845ULnV1Q1UvbbS/EbTpzIxPVEegW3OhPuWHzqOIb9Lb3mBFaUQILCWlTvBxz NBbqIpjmW/8buM1+XY26KvXWm3mTQSwJLzwLwvJkvxSN5yC3bz4ao+d9OqO7N0/LmXIhGFgESAO c9Dije7
 skCyhVEg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

On Mon, 21 Oct 2024 16:25:40 +0800, Yang Erkun wrote:
> In the normal case, when we excute `echo 0 > /proc/fs/nfsd/threads`, the
> function `nfs4_state_destroy_net` in `nfs4_state_shutdown_net` will
> release all resources related to the hashed `nfs4_client`. If the
> `nfsd_client_shrinker` is running concurrently, the `expire_client`
> function will first unhash this client and then destroy it. This can
> lead to the following warning. Additionally, numerous use-after-free
> errors may occur as well.
> 
> [...]

Applied to nfsd-fixes for v6.12, thanks!

[1/1] nfsd: cancel nfsd_shrinker_work using sync mode in nfs4_state_shutdown_net

--
Chuck Lever <chuck.lever@oracle.com>

