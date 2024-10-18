Return-Path: <linux-nfs+bounces-7278-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0F19A402C
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 15:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BBE71C229AC
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 13:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87F01DB929;
	Fri, 18 Oct 2024 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fm2YFlq6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892D41D54D6;
	Fri, 18 Oct 2024 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258745; cv=none; b=bqGJ1TnButkKaSt/+JZf+/hoB/qHWrR52clc+Q+nAwOoK+7ikFMgeGDzeXKXmviieIqjTx32QCYHsymqRSNShU04Ujt5IBUj2/3hE7q90qtxx3k/yVaeav/XNwC5/KcwWEuLUfyjXmXTs2Qt/BTzp1lh5W8iVUXhRS2sJDAjoRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258745; c=relaxed/simple;
	bh=yBOQfALDR19eB8Q+FLAuKqep+QCINUZHvDLCifLDQ2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0W7HiKRyAyfp0dcm8xtGNIzjjzsIppgNaZILgOOOIiv4FUCbkRH0AIP+boYYx7m0eDtC/NxLbcIw1cf+unD8BynaumNy7ZBH5wdVHk6nSXhvOl7w3Xa1rGi2Q98uOsocefTD+htK46O5xSSiIdYpbhd8V7lKDCD1BjCAtRVHFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fm2YFlq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F038C4CEC3;
	Fri, 18 Oct 2024 13:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729258745;
	bh=yBOQfALDR19eB8Q+FLAuKqep+QCINUZHvDLCifLDQ2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fm2YFlq6MjWxR5z8djVF6X2xrgIeg6q/I7I+O/lJ6HO7xQ2BkeixvcCLlc7IGrHBB
	 xGAwwZSWzGWn++0Q+SQ475SOz8g/Um6P18q+rSszPHyvBlIJT2a2EQvqR5frrZ6Hka
	 Wcb0YoIk/klrLFoauBKft4vngc7pKwCIz/xceSXD/+uofIi3lQxwC0Lm+yS1LDd1eq
	 8/Ke/o2aJGxUSJe6xCfjSUjwwqI7zcwl9w2amsybH1Zg3sEfQwPfUlPzZoXle/VxmM
	 jJEdfihguZIBOPM9ABwBgP2DhTE8a6jJ+S3B67dTG3/VRCIWR5Tagy+z9+19Zisj5N
	 0ZisJTghD7DFA==
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
Subject: Re: [PATCH] lockd: Fix comment about NLMv3 backwards compatibility
Date: Fri, 18 Oct 2024 09:38:54 -0400
Message-ID: <172925869887.229855.13686777853029850318.b4-ty@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240912225320.24178-1-pali@kernel.org>
References: <20240912225320.24178-1-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=920; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=xFHV4cyFonPF4u+hAzXt9tNqKNaiADihATY8sWkZx5k=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnEmTvYVzhIU2kjDg9huHRwEdjwDtFq0JWvO3m0 gHC5OnDwFaJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZxJk7wAKCRAzarMzb2Z/ l/6qD/4qqREYQNHWiFGLh7QLUMYWG5z48rShfLzI2noWOauiMiJ3LoZzbohwk5KfP2uPQnE5Pd/ ugqSqJzBWNZ8cHlvZ2yc8wVQwR7Hrrk9pSE4efBZh99Ko+xsf5jDdYSpcnd9PmvOtrqMbURwATL RmGp5BJxgfWj/vy8uFUi7AC6LTPXJuCLadiIUSph5e1iJU6BBa2VC/3IvzI7WRsycrTbPDkoBjH SANzMheQTJ+tTyoCouOSHExtRjJwCDvmt+J9iyRyoWXN9p7q3+6lG1QXzIBUlnIhRSnWZ4OOorK 8xNFzqG6PQTYf97WEFaQ5yBx3iXsWSibXQLvhBz8LYjSoP1ymi6aapNhIJGA9CnbnU5f7fVV7FF bMDo2XjfcV4J5yKekTfdKVIU115fgawqgomLPHfUQjoV7mAUBav8VK70UR7Paj7ws61GP6e8LGU ZO+gQ3hZDSIPdzkc4hJN1/TOrsCo27fIgPUAvGP6h3pQkr6Wmm017cZVZ5PGbIG3wtWuTJUcRMx xAG+mXs/N40E51CVxDnT6WHC18v47uAtjmHLaU36AqA98s6y1NloUaLYabBPlAFMvQvKRCa7JpR 9gtUrmzc1eEcTipXW9D9TBKMN5mGpZ3CpM64vUcFp/SaWHvsZ6MwBm22mw/9nmZ0sAPy5ytkTWt 3qSGg16
 JU6S7nYg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 13 Sep 2024 00:53:20 +0200, Pali Rohár wrote:                                              
> NLMv2 is completely different protocol than NLMv1 and NLMv3, and in
> original Sun implementation is used for RPC loopback callbacks from statd
> to lockd services. Linux does not use nor does not implement NLMv2.
> 
> Hence, NLMv3 is not backward compatible with NLMv2. But NLMv3 is backward
> compatible with NLMv1. Fix comment.
> 
> [...]                                                                        

Applied to nfsd-next for v6.13, thanks!                                                                

[1/1] lockd: Fix comment about NLMv3 backwards compatibility
      commit: 6c64686e6bb8b5ec1e3cca4f495ba38341666745                                                                      

--                                                                              
Chuck Lever


