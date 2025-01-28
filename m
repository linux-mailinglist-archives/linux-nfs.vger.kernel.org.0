Return-Path: <linux-nfs+bounces-9723-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D12C3A20F5F
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 18:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342ED188A67F
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 17:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAAD1DE2D4;
	Tue, 28 Jan 2025 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9VXEJKt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872F31B4239
	for <linux-nfs@vger.kernel.org>; Tue, 28 Jan 2025 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738083919; cv=none; b=oL2iL9ze5JeP+NEbHO4U6p8A1kIeuMjyTqBB9jUJDxd3B8Fh784vfflq7pulLXhlokjvfVM9CtAUfY3I4vqqmZi65VBc1cEwCHFZN98Xlb6ouDLt2gTVckP0XyuwvBPOST13Ozh04y2rjP58aih82kwFm/NtRk27Qy7fnLbf14k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738083919; c=relaxed/simple;
	bh=L8TsfbaiOsIIpUhbu0GGL4GlcWgftBFOj1mK6LjN7T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DqODzRF81+8xFj+vR52+RnFe+fpHz2TBebIUkdkTaka1/QNJDUkJBf/LKosNv9xSPYjczacvXLA+i0Y6nuMBEHbZUTdS2QHAZYADIiO68STjeK/aaunZKUvFpoK2J2HqroBOn0kN7+ddq04D3rGESQKowhrpqyxB+OworjyxiiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9VXEJKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A7EC4CED3;
	Tue, 28 Jan 2025 17:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738083916;
	bh=L8TsfbaiOsIIpUhbu0GGL4GlcWgftBFOj1mK6LjN7T0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I9VXEJKtLTO8kwidFpitvDNg7ypz64WbTH+EKpHmK4+r1+rAuvXA+BqfiZlc7wSzu
	 T91q58QljOQ5bIQMi1BspOiQv4eRW92H61UtoCYswuZlZrZV+/CGIXcoNXmMu5k7KL
	 E1Nj3iIlZZs9Vf9g6PP3FqPIMa7MC8Sxw9Ynw+UxHwEKkrzIXqoOiaWcAzqvsVdmss
	 2DWV6UYUFy6NOqXQHEIaGeAATkuVY200asoBpIFcIcz5QqPAp3N5piM5M+t5YdLmI4
	 B/V8pa5X7fOhSH9PHPvdmSDqp7WofopmlK4SKqMJFS9H77yIuZsFNbReSMTQknYXIT
	 wPHs88kZPC3kw==
From: cel@kernel.org
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	neilb@suse.de,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: Re: [PATCH 1/1] nfsd: fix __fh_verify for localio
Date: Tue, 28 Jan 2025 12:05:12 -0500
Message-ID: <173808388275.38945.4856648428454830704.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250128165806.15153-1-okorniev@redhat.com>
References: <20250128165806.15153-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 28 Jan 2025 11:58:06 -0500, Olga Kornievskaia wrote:
> __fh_verify() added a call to svc_xprt_set_valid() to help do connection
> management but during LOCALIO path rqstp argument is NULL, leading to
> NULL pointer dereferencing and a crash.
> 
> 

Applied to nfsd-testing, thanks!

[1/1] nfsd: fix __fh_verify for localio
      commit: 3c6a376bcbc815e3bdae0816b32e600c4c63599e

--
Chuck Lever


