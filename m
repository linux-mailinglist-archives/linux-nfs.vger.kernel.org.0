Return-Path: <linux-nfs+bounces-20426-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDreBSwqxWnb7gQAu9opvQ
	(envelope-from <linux-nfs+bounces-20426-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 13:44:28 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E1F335685
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 13:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7C9B30151F7
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 12:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B9A34C81E;
	Thu, 26 Mar 2026 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0u7DZNe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5AC2D1303;
	Thu, 26 Mar 2026 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528656; cv=none; b=MCxdpo/B+Mjq2+jvwgTsvkzJvRBQFvDU53OA62XScQzdF4Epq46BORX/LieBTwB3RveTLg7wOYm2kLE1GriHacIe6QIANin08pLg4wO2IrOnj3et3PHJGa+3QHPAt1+7zn76sC+wIw27aUFIWTkfcKi2xv1HIiG7sczZ0k09gs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528656; c=relaxed/simple;
	bh=0VYsN61u1J8fd4QXa81OD6Du1W1YTcyl+e9uIPPdeI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYpPgsfV0aFkzsdm3ZaUILKxutnWwre2TxMs+66LFUXsAB4qODuaKTCnDnb4FCvbcPsk68wG/j1xWx+ZNk2EYi70MFTJikYl0ANGOL28O3/Z3unPH5DbwaL1+oPQ6mrLMyqGt1JwXOo0ydkJtfhaWhd5QPThAOj2psOM208Wajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0u7DZNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BA9C116C6;
	Thu, 26 Mar 2026 12:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774528656;
	bh=0VYsN61u1J8fd4QXa81OD6Du1W1YTcyl+e9uIPPdeI8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q0u7DZNe4dhAIlCn5oT4MRnI2vdLQBpzorFBsiF9Vo+CeF4EUZn9JS6oViPnCnJqM
	 kXVlt2qZV0e6wgbKZevL5vwVWSciIYKq4vnWpmFCj5moeD/xxswxLy2RESJugkuLYm
	 vRu6QyjHt2e9QqnlcHNZA45/Vzmgf6n8qFcDqqJoeLtZKiuyoJGk4oKy8NQQmZnE3W
	 SCbBmpyPOFgBBXA7iilQoDBU3KT1zg1NMh3UayOzeCZ4B9Wn7s5TRsLsJALvDCxpnu
	 AVtaVvkY/QbUSBPj2ynop0ewHDSBKHSgGcAlpUz3NfPPs/aErfuebmnAMW204uWfot
	 AecwV7S+8zV9g==
Message-ID: <5ff9bc59-f579-4b7a-bc7a-eef411b8e31e@kernel.org>
Date: Thu, 26 Mar 2026 08:37:34 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] nfsd/blocklayout: support GETDEVICEINFO for multiple
 devices
To: Christoph Hellwig <hch@lst.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Carlos Maiolino <cem@kernel.org>,
 linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260323070746.2940140-1-hch@lst.de>
 <20260323070746.2940140-6-hch@lst.de>
 <736ddc8a-7a28-4900-b3c1-0368cad24085@app.fastmail.com>
 <20260326053828.GC23157@lst.de>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <20260326053828.GC23157@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,gmail.com,brown.name,redhat.com,talpey.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20426-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73E1F335685
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 1:38 AM, Christoph Hellwig wrote:
> On Mon, Mar 23, 2026 at 09:53:33AM -0400, Chuck Lever wrote:
> 
> [full quote reviewed, can you please trim your replies to the relevant
>  parts?]
All three of my replies to this series were trimmed. I find your replies
so aggressively trimmed that I lose context. It seems to be a matter of
taste.


-- 
Chuck Lever

