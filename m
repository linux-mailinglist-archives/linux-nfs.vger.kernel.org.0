Return-Path: <linux-nfs+bounces-3564-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 737E78FC99A
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 13:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77E9283C4C
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 11:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313E3763F8;
	Wed,  5 Jun 2024 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cipixia.com header.i=@cipixia.com header.b="TzKPLspt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.cipixia.com (mail.cipixia.com [116.203.167.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974649639
	for <linux-nfs@vger.kernel.org>; Wed,  5 Jun 2024 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585297; cv=none; b=sYOepVKD4zW0wcjzo/bm85PxmMJZdTcCRjjc2+L93CBpZq/2ptWi9fnmQ4kacRKsF+YWSpgHDTBHYMBQNp+fce8lmhoznKJm25lEGgJBT9Ul1Uk3An7lvtRD8tc26sapx59EVvPZDT9GfpwtaPmij7UgStCL4RE0iOI4kxuUZ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585297; c=relaxed/simple;
	bh=GpKuaMzQBCfteEssMKGwTqd98dTns/3qDcjLenAuDg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjUHWgrcfKDprP0PIJ3t02PfeD1JlBTdhIdChe5FWm0tCRb7O8Qea7vnN8eKFTlOiO3tkVgEBUNflIh1mQ/t+CmlaivPzJE/2VjCAPaDw5PVOUjS19cIcLwEzOgHMElbuUJu4H/jJVl4N2PWGJb1bBfM1kyt4cBLgPqr3CfY1g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cipixia.com; spf=pass smtp.mailfrom=cipixia.com; dkim=pass (2048-bit key) header.d=cipixia.com header.i=@cipixia.com header.b=TzKPLspt; arc=none smtp.client-ip=116.203.167.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cipixia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cipixia.com
Received: from mail.cipixia.com (F36-nuremberg [127.0.0.1])
	by mail.cipixia.com (Postfix) with ESMTP id AE2BFFEB7C;
	Wed,  5 Jun 2024 11:01:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.cipixia.com AE2BFFEB7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cipixia.com;
	s=rsa2048; t=1717585283;
	bh=GpKuaMzQBCfteEssMKGwTqd98dTns/3qDcjLenAuDg0=;
	h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:From:Date:Subject:Message-ID:
	 Content-Type;
	b=TzKPLspti7DO80P/b6iVrChi94aA4NQCyecKJup0+qk1wXmPoZD8TA6jhW5O7r2ON
	 IQfOvYen3WRkLOVhBunpZgAp+kEvt46eYit15c67ufUC4SnboBjhdsXJertBjTSoBy
	 pL5sLM6pFcFeInToFLOq38tHKzaBpFJGEAQUMs4K7BCSf8KL56Naa/ex+HVD2v396k
	 9BLKrK6wfcrFmixQZSzzPJ2NCFOTxpYpfijDmDVby6XDzq0IAV36baAmPEfR3OcF9e
	 pqHo5Dm0UkXm9cZk/br2iAltw5vUaekQRve/4It0UT3yPnhG985UgK1BH58UNMurch
	 FewWJWiVgQveQ==
Received: from mail.cipixia.com ([127.0.0.1])
 by mail.cipixia.com (mail.cipixia.com [127.0.0.1]) (amavis, port 10026)
 with LMTP id 0T46BoMiTBbr; Wed,  5 Jun 2024 11:01:23 +0000 (UTC)
Received: from originating.ip.scrubbed
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(No client certificate requested)
	(Authenticated sender: matt)
	by mail.cipixia.com (Postfix) with ESMTPSA id F380AFEB7B;
	Wed,  5 Jun 2024 11:01:22 +0000 (UTC)
Message-ID: <34d9bb43-6fc4-4d8f-a29f-42c274b0ab89@cipixia.com>
Date: Wed, 5 Jun 2024 04:01:19 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: exports option "mountpoint" ignored in nfsv4, works in v3
To: Benjamin Coddington <bcodding@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <2c2f8e77-33c8-4836-b7e7-785938755e03@cipixia.com>
 <FF6EFB91-7045-42EB-B880-90F0B6933386@redhat.com>
Content-Language: en-US
From: Matt Kinni <matt@cipixia.com>
In-Reply-To: <FF6EFB91-7045-42EB-B880-90F0B6933386@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/24 05:56, Benjamin Coddington wrote:

> Its not that /srv/somemountpoint is always being exported, its that
> the v4 mount is mounting the root (/srv) and walking into
> /srv/somemountpoint.

But wouldn't this always be the case on an nfsv4 setup?  There is some
root folder that contains any child directories being exported
underneath it.

FWIW If I export the folder by itself and apply the mountpoint option to
it, eg. "/srv/somemountpoint *(rw,all_squash,fsid=0,mp)" as the only
export line, the mount command *does* indeed fail using -o vers=4.2,
however it doesn't fail with an error message - mount just hangs forever.

I feel like this is a regression compared against nfsv3 functionality
where "mountpoint" or "mp" can be applied to individual exports, and
generates an immediate error message for the client.  It seems with
nfsv4 the mp option only has an effect on the root export, and
accomplishes the deed by causing the client mount command to hang until
timeout


