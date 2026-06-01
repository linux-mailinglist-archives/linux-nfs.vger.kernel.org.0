Return-Path: <linux-nfs+bounces-22190-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKQAJZvfHWpsfQkAu9opvQ
	(envelope-from <linux-nfs+bounces-22190-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 21:38:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 113C4624B57
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 21:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D6D0300A114
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 19:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB96837D10F;
	Mon,  1 Jun 2026 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLnQ3VbW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23A735AC3C
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jun 2026 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780342679; cv=none; b=qK8JKNKI7t436M8FL5PozhEW+UFshh8SCEsk6yGnFDVvQdECzZS5ruNvB2bmG0cNYutMhAiQw3buID0YD+GgLVL7t85GMIxzU9L0B504wIma2Rmnxz6l4jRvBChgKysY5Z8kP5mD4+U7Z7jbS3cr7cqY+AnZ5Nf/o6NzAi6g3yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780342679; c=relaxed/simple;
	bh=RZwfx2Cy8waa2CiHzdx6e4LQ7j8PBgK4eRmLFoiWfdw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LRQkQqwFaGQcFJXObHIF5ex79xNl8QgJ3U6vAnHkZZETLYXOnjSbOixqFPrWnc6d3v+ryPgozlXj2PdswdlLwg4q9HxqjxvQwJuG+gsr9EwlkdJvIX/OGMxlpW7c6EGgUs9NXfYv5eJIvY8ArIspj0KVllsEvQ97MHS3+KWcF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLnQ3VbW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621E31F00899;
	Mon,  1 Jun 2026 19:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780342678;
	bh=cTwQTuxteOCW47yBfAymiKdO4MdtIGqY81dtB3SfFbM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=jLnQ3VbWUKQNmHI+bMFlRW9gsxqY7G9q7uMyfVd9RNS2GQUOrRA2nVvHJufHa2r7V
	 saysnqU2fBQjSn0VyNN42vs5QiRTskXqSE1C4PPdYPBejSzYBHTSNGdflrobRze09s
	 nh2u/ACsdGjB5as+y8aQc5WShkrGrmBkNL7Fz77OV3JdK5adc7Vx60XdegC9RHNmLe
	 pLJSgasO/hdFL8D/E0Aqdn54P9iZgtB8da4ImDfhBVQi8OB27GSIlWNBT3shlw8kHu
	 q0DZnj1zxzQmer5i6HfCh2NzQs6pa0HryE/9LzwxRokKZqpaGihk4cywrKanRomNya
	 7wfS+zrxbhZ3A==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 66658F40076;
	Mon,  1 Jun 2026 15:37:57 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 15:37:57 -0400
X-ME-Sender: <xms:ld8dapnPHGWHv6sKYuj2gihShGQa7O7CfxzLIudZ6iKXlO9H2w0liw>
    <xme:ld8davqtYtq9GNH93bJNb0hsNbv-o10MyzcqDjXZ-SuOkhlwTHvcB9rNINC6gnJt7
    eLNeGnbFAirDlfSKEb2NpiO2AGxlA21GL5gcxX89KwJBVitSfxju_E>
X-ME-Proxy-Cause: dmFkZTFdherPbTLRdGkkaNKQCTWX2LyVjQI28CB4If2Nui3jmvKdLBbq81ieJAjRNIug63
    GUXyteG9ShDxUy8hzHIVn4uRWAxp4nY8xqkNQlFHwyaRhaKcN0OyOlcLziN4FeeuYuc6Kx
    wz29rm+/9FTICrtgNYVcGfpOu1Hs0SMi24URpbG5hnT0LD10swTSXSk/OAZ4m5807B94sT
    pJtrC95ifdisgRrdmagx8idZnW4CHTpJ67lJHtcjdzxFo0GUYJmFB04WSzYyo8m4BrijmF
    wh/W99Am0TDi/ajchij3vFbJ/dPc5msio1iaGVirEvm/GBzuAyR8ckaXb7jlTKGm+VSBL/
    fbwfXtf9PCVvygrvz8CsrK4VZe7pwxPJnrEj4/ZexH0fZG4fi+2QRbkniYOzvwf0TbtOHU
    vQ5Mf5TuqRPQ1rOtPv6bOtP93f4sK+82c2csPQjCDMSkV5AARiENdmilqwZ2tTr8bAuKn7
    7WiMLJt8nG8Y+RtJtoywUX629a9fqiKbUArkuRZzm0qVGPg7K1JDvqG1ygJ51ZydnvWVAl
    rRz8UYc8Us/ZtyXWVppWHcu0+BKkwSuAnZ6NhlcO5RVBHZeiHIykL4w2Efx23KRLVVmtV3
    jIrNXkWmKQnbaA8J16Vsd9yQhJNwLs1aKPYpc/ijwigrixl/N1+Q3nFWVVkA
X-ME-Proxy: <xmx:ld8dasu0g--GI4lPCw8Giahcrc4y3SS4YaBuIqlSxd9nIbJPnqC0dA>
    <xmx:ld8dak6qPFOjCpV_pcT4_up2UrfuUkRkHR3KBRfnRLTXtoKa5NqfKg>
    <xmx:ld8darSqqR07RHJBtv4xiyb8NZ4GnLFBa4q5KWlfwsqtzf_Aw8iSQQ>
    <xmx:ld8dajpNuKE7xP270WjNqLLuv9I2n6eyzm09IUrFl-IbYXUSh5MAzA>
    <xmx:ld8dapKQZZFxPkRTsmfkpGGuc7RfgNnhusw7ulj0SuOKbY-D--41mfxs>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 49449B6006E; Mon,  1 Jun 2026 15:37:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZZdtypb3CBF
Date: Mon, 01 Jun 2026 15:37:37 -0400
From: "Anna Schumaker" <anna@kernel.org>
To: "Chuck Lever" <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <e839b7ca-33b3-4818-925e-3112fdc59ab7@app.fastmail.com>
In-Reply-To: <20260601175413.29544-1-cel@kernel.org>
References: <20260601175413.29544-1-cel@kernel.org>
Subject: Re: [PATCH 0/2] follow-up to "Decouple req recycling"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-22190-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 113C4624B57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Chuck,

On Mon, Jun 1, 2026, at 1:54 PM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Here are a couple of trivial fixes to the recent "xprtrdma: Decouple
> req recycling from RPC completion" series.

Thanks for the extra fixes! I've added them to my testing branch
which should be pushed out by the end of the day.

Anna

>
> Chuck Lever (2):
>   xprtrdma: Fix I3 invariant comment in rpcrdma_complete_rqst
>   xprtrdma: Remove tautological I2 assertion in rpcrdma_reply_put
>
>  net/sunrpc/xprtrdma/rpc_rdma.c | 4 ++--
>  net/sunrpc/xprtrdma/verbs.c    | 4 ----
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> -- 
> 2.54.0

