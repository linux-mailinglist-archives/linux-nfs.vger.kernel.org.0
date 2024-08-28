Return-Path: <linux-nfs+bounces-5841-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F216F961CFD
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 05:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6E328606D
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 03:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3571304BF;
	Wed, 28 Aug 2024 03:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VDLLivFs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D08264A;
	Wed, 28 Aug 2024 03:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724815325; cv=none; b=HiihKJ0jQcblyyz/uDmhsH5Ofma3HhdjQryTO6Pu9ms3ITMAkqYNli+zfO8sYftLZ/BbrVES+GyeGRxE6jJCR2BEShYpoiI5Gpdj0xVfrD2NVoc8QOzhSu3PPt//lCXgd7FTBFtTwZbbha5BJOF7A+9JJQ2X+uaFw1oj1NgPBJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724815325; c=relaxed/simple;
	bh=fHlyJ35eZVClM0QqaCWAspv3ePgLlC9CUj+DFPnZ10o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=E/S/8lY7vKjYxHpCZ9paXLPVV2fw7wGGvAzKM3POCVM7FoODsfmkPyRtbvEJ7MVL/tEatwAf0dFgLANoX1KyIdemcEZB8+4aqrXCOUhh43B1rYzXdYqvfndiZe71l9LEvOd38DDygLATQRV6p3RLREtoioAbSH2Q14DiVZDNwsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VDLLivFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0E6C4AF0F;
	Wed, 28 Aug 2024 03:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724815324;
	bh=fHlyJ35eZVClM0QqaCWAspv3ePgLlC9CUj+DFPnZ10o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VDLLivFsVLVyHuaPTqL7XSbOAh8R1qdmYIA5oCA71qf1zrjWwgfwMDY0cOnLC+4Mo
	 XrlkuR70OeBoI3b+2E1+afWj0JQkSEECIMSkxW2OZ/ZFNZqNVC85UMTQEQqUfRU5IZ
	 iQ7lFQKzsg8G0p7QJNTua/Gv4Hs3mDBxgav9YqRs=
Date: Tue, 27 Aug 2024 20:22:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: <kees@kernel.org>, <andy@kernel.org>, <trondmy@kernel.org>,
 <anna@kernel.org>, <gregkh@linuxfoundation.org>,
 <linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH -next v3 1/3] lib/string_choices: Add
 str_true_false()/str_false_true() helper
Message-Id: <20240827202204.b76c0510bf44cdfb6d3a74bd@linux-foundation.org>
In-Reply-To: <8d19aece-3a33-4667-8bcf-635a3a861d1d@huawei.com>
References: <20240827024517.914100-1-lihongbo22@huawei.com>
	<20240827024517.914100-2-lihongbo22@huawei.com>
	<20240827164218.c45407bf2f2ef828975c1eff@linux-foundation.org>
	<8d19aece-3a33-4667-8bcf-635a3a861d1d@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 09:48:21 +0800 Hongbo Li <lihongbo22@huawei.com> wrote:

> > This might result in copies of the strings "true" and "false" being
> > generated for every .c file which uses this function, resulting in
> > unnecessary bloat.
> > 
> > It's possible that the compiler/linker can eliminate this duplication.
> > If not, I suggest that every function in string_choices.h be uninlined.
> The inline function is in header file, it will cause code expansion. It 
> should avoid the the copies of the strings.

Sorry, I don't understand your reply.

Anything which is calling these functions is not performance-sensitive,
so optimizing for space is preferred.  An out-of-line function which
returns a const char * will achieve this?

