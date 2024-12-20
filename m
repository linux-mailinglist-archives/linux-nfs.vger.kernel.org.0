Return-Path: <linux-nfs+bounces-8683-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EA89F943C
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 15:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1941A188C362
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 14:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37832215F68;
	Fri, 20 Dec 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjDzTtub"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B5C1C4A05
	for <linux-nfs@vger.kernel.org>; Fri, 20 Dec 2024 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734704788; cv=none; b=Tzz0dmBm+rFXIUPQI1YeEU0qcdqtbm+gWj77KieIhwccJB7X9/UiCWoxIKqOnHpuHevHvoN4//OsCsmDEktsMQJMdtSbggNcRO3uhca56bAUMzOmYosBQbNPsxtty/zqwCwBuATivtiMiiXEbZQtEU+1j77yjpucOJeVP9UmD88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734704788; c=relaxed/simple;
	bh=AZDGPIy189StlphR8xNnOpYyuE9fX86ixDPtWashtTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1EIlsy6wo+WQXlISmfMG0IlkweTQkIYnPhBwlzfqZJFKlt4DRZHWfuq1/mQ8n2DlZH7aMY0yw7eRAkMYBGJnXs5OR7m3rEgSWFkLxuCaQ4Q4vpTBDPp56ZacTu25fwVYTXvDCoxgPfUGeNXYP8h5+2eZpATUx4mKeGIS8LEiJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjDzTtub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34732C4CECD;
	Fri, 20 Dec 2024 14:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734704787;
	bh=AZDGPIy189StlphR8xNnOpYyuE9fX86ixDPtWashtTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qjDzTtubAp8jPe8WhiIyOoawUx4IRJR6Nfus5ww5fM76XkiEN6E3YaQJBDGXsk/zU
	 yAUTzCCYNbTssGKqOvtR0Pb8kzdkodnx7EewSYEd85XNxlSfEL1WF8SBSqOohdZzbS
	 KwQDA0BqVeDpoVlalSjEE7H5E7mNOuGNeiNxApEtPDacipMGkOaWZdl8VStfc2JV/S
	 uS8RViKJZoMykgEACK+1H9/0/pFB0WDPGKjfwFBddXIqIiLJWi6g+0y2z7XJ45g9xD
	 OZ1W09K4+3BwL67B1/AwHnDBJZnJRyvIZzUWlXMqOEwgalypAdeFzWr0ay4i/y1Rpo
	 FlBT2+PL1HPSw==
From: cel@kernel.org
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: restore callback functionality for NFSv4.0
Date: Fri, 20 Dec 2024 09:26:18 -0500
Message-ID: <173470472592.15635.17645508183089270355.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <173466889807.11072.9460940011488391036@noble.neil.brown.name>
References: <173466889807.11072.9460940011488391036@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=3w25TGG7P4J0Rr1y+eEsUyUA6GAW1oJOXhA4UeQaT+Q=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnZX6L4+ourI2EYkUGu0cQ5wrmgHqRxbFRya/Z5 5ktDUqes4+JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ2V+iwAKCRAzarMzb2Z/ l3TPD/kB1T2zX/HOKKntIpYzbEv2TgUSU6LZFGAm0/HeCOh/Adry9HEkuqRIDoleGavJ57uqaOE OdXnyapu2/6T1FBReWC20l6m0UEfoKui9nhdDzEDkzsLXvrusBLjcGptMuPcujS+q2x4Dq5IvYr I9qnDNe2wodKJlLRmLQFOgxhXwmrb+LGV4BgZz4crENzJbMIguDDx1SVK4AXZZHGYLgjN3O/Gqc DeYd/Ql62YjUSuux+LL6LeP2PlJFenpc/JlcD3UHlP7a5580LzIkTTCv1JvMUlFvmqDTTmz4DGJ qbxn6EUd/XKSlIEQwGN09Lc1HtTJBbF4UgAfraXD7Yq2ijf2HXN+MSQbFTpdmLper41ECCDB4iD rsFIydT460qnURpnHAx7ErKPOUsxceFa2Z7p3fRk+BcR0CzXSr9QN9ZiujFtWW5emBpjVOlw85E F/+aZckCYzQl2McUrgmtesZMZBUOXFza1SK1X9PBXRHEg3Jne5YYxWGqmKsj1PkmRzcOkg9OLsy yRmwLPrYcKloA29uF039+BFaBgyPdds6dJPE3Z3Zj+m4HawovTm9qzCwn035Z+NMBpFgQDF8jfG CuYmOglTGKvH8dWUWlnLm59yAFHAsIhrxSN0VFL62u/DJwQXBvEFx5z/mRkUNIeWfvzwo69qJPi OGsRNEv
 ZWrxEA2g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 20 Dec 2024 15:28:18 +1100, NeilBrown wrote:                                              
> A recent patch inadvertently broke callbacks for NFSv4.0.
> 
> In the 4.0 case we do not expect a session to be found but still need to
> call setup_callback_client() which will not try to dereference it.
> 
> This patch moves the check for failure to find a session into the 4.1+
> branch of setup_callback_client()
> 
> [...]                                                                        

Applied to nfsd-fixed for v6.13, thanks!                                                                

[1/1] nfsd: restore callback functionality for NFSv4.0
      commit: 7917f01a286ce01e9c085e24468421f596ee1a0c                                                                      

--                                                                              
Chuck Lever


