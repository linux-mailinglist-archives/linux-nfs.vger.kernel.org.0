Return-Path: <linux-nfs+bounces-13591-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B90AB23A2A
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 22:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF82F68811C
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 20:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB1F2D7381;
	Tue, 12 Aug 2025 20:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a98G1A/I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F442D6E63;
	Tue, 12 Aug 2025 20:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755031568; cv=none; b=qrUJgljlAu0TauBrswqqKT663a9mvjwXkyGjX+BtpINartPO3UsrhhlXvL/0l+he1QvhZ0TnihW8e0PvdjLvhCoelOYkmJUfbkpELcBj9FyLaTW1/vUCBTXm3bz0ZCtnNvWCqsU9fVqnw0gn4Sjl+UesyKYwhUfE2sS8dLQE8T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755031568; c=relaxed/simple;
	bh=ywQwwRn2wVPvR+yOSHfJeDNXLEHdb3olJpBeCpKYi3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTrub91kGQXAoxDEmOVevc79xkOqNSGXkO5l7Q5cz8eih3LUHpzLcyqCEJh8HUysHmvovUixM8WNXezJxzMC/WeEpPsiM+lMVhWP8Zubs9SGL6W8h49TAeq5U/R8BOBNpUdftxncg5AUlWqL3uL/9ElvJ25feBVyvttjN5aKZ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a98G1A/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5A2C4CEF1;
	Tue, 12 Aug 2025 20:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755031567;
	bh=ywQwwRn2wVPvR+yOSHfJeDNXLEHdb3olJpBeCpKYi3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a98G1A/I59cu4G75S5u+1h23ZaZWY5qqG4dx8Edz4Eawf9NMxi03Td3it8ZY22tTI
	 bdnnZmOBfTOfJRw10aCt6mLXccrw4Oqp3+hg5fFo9a/kPnnrxYVPucTWUn5rTsXDKK
	 i3cfDhIR0JRe9CA8p7F9RIiH/WuvsPv2atujIdl1vdC2Gu+UOZDnFP9mfn7nWeHThE
	 OXsHigDT15SSYcMkTca4FhOW00KufmuntuGEhQg43Zx21CZG1z579a9zSVxttrQ4Rx
	 fZawUFIRUdq+AYV6zexnEpaAoWNN17EVIsNvEajApk4iYIgCA7+9PtWIPtzuOcmQEU
	 e/6JQSIZcRc1w==
Date: Tue, 12 Aug 2025 13:46:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: Xichao Zhao <zhao.xichao@vivo.com>, trondmy@kernel.org, anna@kernel.org,
 chuck.lever@oracle.com, jlayton@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, horms@kernel.org,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sunrpc: fix "occurence"->"occurrence"
Message-ID: <20250812134606.4f1ad614@kernel.org>
In-Reply-To: <aJuAo3lfY9lRB-Oo@MacBook-Air.local>
References: <20250812113359.178412-1-zhao.xichao@vivo.com>
	<aJuAo3lfY9lRB-Oo@MacBook-Air.local>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 10:57:55 -0700 Joe Damato wrote:
> In the future probably a good idea to add net-next to the subject line so it
> is clear which tree you are targeting (e.g. [PATCH net-next]).

net/sunrpc/ change usually go via nfs trees, FWIW

