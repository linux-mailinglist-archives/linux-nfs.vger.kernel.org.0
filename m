Return-Path: <linux-nfs+bounces-6600-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 567A897ED44
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 16:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DFD1F220E4
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 14:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69B619CC20;
	Mon, 23 Sep 2024 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXjOiTw2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B3A1991D5;
	Mon, 23 Sep 2024 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727102492; cv=none; b=Xun3dahokcnfGbM7dpLaatdau1qCjDeK7GSHWUiX02FoXtgaWswD/Lx5WAxCmEz+9Nz/1HL996ElzePz6l19HGQIUi3I79amTv4L0FYsKmqmgYxP+dMTBjnJdc1KzSathlXIxtyr0IWme1UKyouzwv+nLaKAe8gHSCQLUKzkfEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727102492; c=relaxed/simple;
	bh=BuXduiEEFviT5JCQICUaP5SqARziSEjtc+Wz/U6qdaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnZ/gk3E43XOHfG+/U6AW/3dXfRdZOnt/1sKQoK8XvZR5P0WT10HNK+qsB3dB0niRgaK6wzuY8sXnwB9HmySbGQTA9sF1fOs59ms5kT8XR3kL6+oEXtDMgZe8UWfJUG6t/4PN6GvFqloUt+mI+hOl9NIHZeacCEeQWrUqzChCYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXjOiTw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AA0C4CEC4;
	Mon, 23 Sep 2024 14:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727102492;
	bh=BuXduiEEFviT5JCQICUaP5SqARziSEjtc+Wz/U6qdaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XXjOiTw2RzEjJMkuL9OR7WHVWeG5FhfxVQ0IVjo7rFnHekGY3rzK/jOFS0Uwxkf15
	 wYELS1Wt1T/tDiuUMOyLM2h3rp+IQ03w2z3LDho/OJxU2idn06trclbQmUcI8P07wf
	 oIwyZu/rnhry4wqvBjbb6EswfyTLFgwXVued6msB6J+wUTGpLUpd27jrSjayU88nRI
	 i5ErGKBYEG9iBBO1VkkQyHCSei1ySnwyQ4U+/CWcsnielHJWHXEnczk8I74zmiCt7x
	 VexvHi9Hq1vU0bcNcbQ6EUopP55QRCwSI7jWWnMpGlTs6iCHlBGBqtwCkT45QwCIkl
	 UymDOBMCY5GXA==
From: cel@kernel.org
To: Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NFSD: Remove unnecessary posix_acl_entry pointer initialization
Date: Mon, 23 Sep 2024 10:41:05 -0400
Message-ID: <172710236323.697449.10204881147640507798.b4-ty@oracle.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923080546.230198-2-thorsten.blum@linux.dev>
References: <20240923080546.230198-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=720; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=q9ZXKGDKZb5ZH7JQAAby1bvX/sFY6cN40CXsWIaSj4k=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBm8X4Cuv7N6USrVCJZpqRjCsDriZRaXrcOlvqZA 2zOxeQUNaSJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZvF+AgAKCRAzarMzb2Z/ l43kD/9gNkXUuItNgvC2Gd0CbyLNgfrk/MNEyDzzhuvPyYSKJwfa09E1JXgbsSweLxsWX9ytQon ZytlyAGHpq9s1Ky+rmkIrSABEK3zP9XOZ43jU3h5d8CgoADzy+WKQ5fEERDZxu8mxuhuBygb8a6 sWXDympgRPOURDYz+ZmM/M7H09vwIGG2FS9Cv6BBhzzBgHxo7SfBzbOpjgEy/NKwBDCZ05K6O8M 4BvKkK/lKRC7exWB7mfjTZ1Z/s4LIoHC9npyn7wUYKkc//LvEDQIUzDD/KA8AWYk3RJPCdzzFOr 2ToBgWuNSnyT8iPqaje4hO8bZrcwcrYLpgtHtXkiwb0s5PYhp5EZh4NuKBlu+9HVeo/PWSo9L6r fbJEexve3Jna4Vz8FXb6KGwXjNONNRpC3VUdmbuJle3mdWwszsvBB0a0r5mI0XeZqoXCIVmEqS/ Kt89ohrRTn8tzDpPvPDzEi81Mwl2TEaxdvvQFtbn33kv9Zp7Qgm7qx48tzRfi4WT8ZM7DK8Ciyv f28gJKlIWsMgDKfuGG8GhN9S5c2OYobV4lgjoSBP9gJxPApb8H8cXW6F26IoT+ILtq93AN996Rm U9kLiYqFdqTwtwwfyHAnQf6gFs+sK29Bcgdgm74si4/UP09NmSrUoqYp5dAYEDFnP22/yeZL/+l dQY/68w
 YP144Lkw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 23 Sep 2024 10:05:46 +0200, Thorsten Blum wrote:                                              
> The posix_acl_entry pointer pe is already initialized by the
> FOREACH_ACL_ENTRY() macro. Remove the unnecessary initialization.
> 
>                                                                         

Applied to nfsd-next for v6.13, thanks!                                                                

[1/1] NFSD: Remove unnecessary posix_acl_entry pointer initialization
      commit: 45672c5446544da68e7f46079c7c3c7bebcc1d3d                                                                      

--                                                                              
Chuck Lever


