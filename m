Return-Path: <linux-nfs+bounces-6985-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05206997504
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 20:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52600B213A3
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 18:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A6B1A2651;
	Wed,  9 Oct 2024 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcHKaaHd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409DA15FA74;
	Wed,  9 Oct 2024 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499326; cv=none; b=hcWIWPiQoygBPhII3hmDPc9MjmvQkKzUC10Eo56i0tOuMqArHaLeqKMIj7sSrqWKlbOES6UyvKGzqFPWXddFqFr6VtGdYt8TSzs4g0MRBWPxJgQnV2/CLrSHWylmdTxvEVbo/uey8epsEffc55iNKD/m0iNeJB0xm/5yVJQtqdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499326; c=relaxed/simple;
	bh=OXC/yw290+GsFGnhcDmVROOAbrlCmNqcxb2gdUjaOpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tajiddtbvM4MlV4EYVC0BCIHGNyFUwWT2kOxgzOrfPxANfKj6lWgXwCnLNJJ7HXk7v6k9lL7txeo96n8mFfIJf+fDInLAye25zUhBaceJZk2WN1TUU6gGzj5pAhIUW/UNOZ5zjSjMlM4osWAy/joUqaq1GWg77baS4Q91UD78jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcHKaaHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B71C4CEC3;
	Wed,  9 Oct 2024 18:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728499326;
	bh=OXC/yw290+GsFGnhcDmVROOAbrlCmNqcxb2gdUjaOpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qcHKaaHdmK/9hGI4nP2oYn+K1tBzX7Dg6HksSQiYZlyNrSXxXt9ftVG94wu+FzSdx
	 Lr5/2s0GQ28K+6cjMXsOXIrBYOOBMrO3fmMoxJOgjO/49bV+iaSKv+pItizjUGDasf
	 clC5/aVfmq2jnDWmYP06RY6dMztJI3xwYeTNYOXcfNS816QDJurtuBxUcXPz8/uTSJ
	 zFZLPkt45beQDQ4zKMIHCtatQCCFms4/BwkQLmMEgoMCCM/mjJ/6YtlJKZzfcNLTvQ
	 0UWahfVw1GJQPsG62/1XSAQOD9ijb6CGLAVd1zAcKV/FlKCnTZenbJAzKBXI5yfLfQ
	 CifdjihdI+VAg==
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
Subject: Re: [PATCH v2] nfsd: Fill NFSv4.1 server implementation fields in OP_EXCHANGE_ID response
Date: Wed,  9 Oct 2024 14:41:58 -0400
Message-ID: <172849928288.133472.1345724004484528154.b4-ty@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005183349.21845-1-pali@kernel.org>
References: <20240912220919.23449-1-pali@kernel.org> <20241005183349.21845-1-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=mfcxu42LlX7iMikH1xAnioA50Jmc0ys+HhST8HZmfic=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnBs54AbAyCfqYrJlV3na7Y3FaeLzTklyZuK89m WQC3QzyKVKJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZwbOeAAKCRAzarMzb2Z/ l9oTD/9NjrxckbbqH2tUaDjUD7Vc/8Whh7Ub4cBzX6zheXwcKrLCDVmGkMHKAeklzQZBKX0fCCN TtJprtdckf5FlNiAXuWXe3gCOQ1p69HJgm4PD36HmvKhIdOBCDUcWcOJDq/9zU14XaSV/ptjLFj 8/gT+L9NTIQC3o6iCJS0PmfiPjbqpTGeG2m8TPp8H2F5TmjRVQTvWCqRw+UVzzE5mUmSxtqcyew VOsCpcUe4xofmXCChU+UcH1enLXYOAP7xRPyIcgluT6/b/bggRB1hYiiB0YB9fvBCsQC/tBAeav jBrISGNlSrXbYsp1X0978BogT7RCBu3pthXSH8m6o7nB9lYV/ZENumtJSkpqPS6em1z7zQTGM0j aBVk7iWj99sI5afchwSfHdfEEgD6tCD1adjxx0oVj8qDk4GI10NKPb2P1wGn4X1grd++RRbW/ei Laow3nuj1yq7bf7r/K/Hs8CTgdJfIKjO8acsxBE1D0OGe4saqYVySvqMjwyCxPcApOM2Gi2aFj5 MpS/n9Vlt051P9hBoVrB8lT1HnjKVCl7MuKPY5XCnZ/lxhXPPY10213mOAjSEJQ7ZaxmnaV4Ely ng/FJm/nVDeNnNrFFMY/u3KD6oUP1OiBpfeXq9FAUxsoZFgY0cjGYVn04+52QQpH1Kf9R/bd/M1 Z/Vs3L
 pEpAk/uAQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Sat, 05 Oct 2024 20:33:49 +0200, Pali Rohár wrote:                                              
> NFSv4.1 OP_EXCHANGE_ID response from server may contain server
> implementation details (domain, name and build time) in optional
> nfs_impl_id4 field. Currently nfsd does not fill this field.
> 
> Send these information in NFSv4.1 OP_EXCHANGE_ID response. Fill them with
> the same values as what is Linux NFSv4.1 client doing. Domain is hardcoded
> to "kernel.org", name is composed in the same way as "uname -srvm" output
> and build time is hardcoded to zeros.
> 
> [...]                                                                        

Applied to nfsd-next for v6.13, thanks!                                                                

[1/1] nfsd: Fill NFSv4.1 server implementation fields in OP_EXCHANGE_ID response
      commit: 5d063672154b3d2d3f9bc3426e0ee4e42ab0e811                                                                      

--                                                                              
Chuck Lever


