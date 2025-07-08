Return-Path: <linux-nfs+bounces-12952-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80122AFDA7B
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jul 2025 00:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA743A6EE4
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 22:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC30521D5AA;
	Tue,  8 Jul 2025 22:06:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3BA14883F;
	Tue,  8 Jul 2025 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012374; cv=none; b=OZk3aBQbXXcK8InyAjajO/BXOEuU10sgrnFE3nir3Joqog/q+fPQnpasRcNXKMo/kiHAh55/Jc6WLZwDfVJeROUShVyPy0VWfCzTCXJHlBWi5P/8OQlxH2782c2WxpgE87B5XWWaswt8OF3Hiq5yw/t+R0LZ7GlhWbCTS8UQ/pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012374; c=relaxed/simple;
	bh=/b+ZUWNHWouOcKyLa+SuNQckiSgPsMDdveFuJJ/OuYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkF0Z3EwbOYndONXwiPessU+YEhzyz0yyDP29rWr7jacqQ0Azku+haPOh2+XrnJ+dGJuBMYZVESF2SFg+abnAUAbTP+2bghdzvCd++A5SGIY7QmW6Wh3j/8526JezbvEx5bc2b4utNRY3KkSiCtUtjjvKxgsgmZMcaDpsGOhu7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7036C4CEED;
	Tue,  8 Jul 2025 22:06:12 +0000 (UTC)
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sunrpc: delay pc_release callback until after the reply is sent
Date: Tue,  8 Jul 2025 18:05:56 -0400
Message-ID: <175201221949.1993.13114894299620006783.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250708-rpc-6-17-v1-1-28c4d6079103@kernel.org>
References: <20250708-rpc-6-17-v1-1-28c4d6079103@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 08 Jul 2025 14:14:53 -0400, Jeff Layton wrote:
> The server-side sunrpc code currently calls pc_release before sending
> the reply. Change svc_process and svc_process_bc to call pc_release
> after sending the reply instead.
> 
> 

Applied to nfsd-testing, thanks!

[1/1] sunrpc: delay pc_release callback until after the reply is sent
      commit: 61d31be8f6efdaaf0df0ca25ce67a00ebbaec08a

--
Chuck Lever <chuck.lever@oracle.com>

