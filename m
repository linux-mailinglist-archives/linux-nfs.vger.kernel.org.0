Return-Path: <linux-nfs+bounces-21053-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJbZJtxX6mkhxgIAu9opvQ
	(envelope-from <linux-nfs+bounces-21053-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 19:33:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5851245589D
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 19:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC04330015BD
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 17:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22F83A6F06;
	Thu, 23 Apr 2026 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEPExy6f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFABA3A7831
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965214; cv=none; b=meaZggH0/xScJmAwId/5hq/cWFNPrNQnQa+qQOLORapJrPUsTMZ4K5UetmlXAmI+YbbFwV63dTv6AOHBkGrlW4TKNFU3m7t5bcHkbOHFGyFwsQgD0nERIXqB1VNO/Ehsqj9ky1HqxUSm3VC+79zgzvjNU8XbRwxmd8iOwwZ5MRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965214; c=relaxed/simple;
	bh=dr+GNM9G7gB9AckXDFpmrjv7oY9xSK9S71BPvvX7yxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaGOMOg2/aU9Y8iAxOKG38U1n4htQKv9s2mwrqeTe4zV68m0O8Y8gYAaoeHVCykS7To4Qz4wl6XyfjGGBWO1OwRHwGKZPYbmnDOQBR5hGBQvnIqgLawNa70A2VtaDnyqm+d99DRMzOr66B0H0w4/I1cAhaOMXf6WubZvqZNIyLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEPExy6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A44C2BCB3;
	Thu, 23 Apr 2026 17:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776965214;
	bh=dr+GNM9G7gB9AckXDFpmrjv7oY9xSK9S71BPvvX7yxc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TEPExy6fCtUjk+WMOQowg/FEdn9EIJ5M/z9pNINSIwmXVNZk+G8muQg22zOE9dJAx
	 PG6rCfBGSYfMbpLdpA4/la9K1vI9KmP7tNm/xWrkh08qZXXev6RF+dMgMXtNmgfEQa
	 eOl4VU1c7I60m4bOKQeKaZw7g0NKD1EamexWRV6MwwJ00J2Pti+/wL3f++BW3GHaaS
	 fYqTFefTqoTWVMn8B9A7k0cIJqFnaGZHaMCBeMb6IyuSeuDlJW2FyBMrb0Onwb+WxC
	 4UxbrdU4HciZoQtl9VIx6Eu4xPTeJHrOQTWsGIh1sFFXqCHN50/2MVwp/GCQ7Fh0pz
	 l9QSVO+UjcDXg==
Message-ID: <13219731-89be-4c49-8842-69935c21eb2f@kernel.org>
Date: Thu, 23 Apr 2026 13:26:52 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSD: Put cache get-reqs dump attrs under reply
To: Thorsten Leemhuis <linux@leemhuis.info>, NeilBrown <neilb@ownmail.net>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260423171732.322623-1-cel@kernel.org>
 <ffdac7ec-2a0c-48fe-915d-cb9e11b73d7a@leemhuis.info>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <ffdac7ec-2a0c-48fe-915d-cb9e11b73d7a@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21053-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[leemhuis.info,ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,leemhuis.info:email]
X-Rspamd-Queue-Id: 5851245589D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/23/26 10:24 AM, Thorsten Leemhuis wrote:
> On 4/23/26 19:17, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> The new get-reqs dump operations added to sunrpc_cache.yaml and
>> nfsd.yaml place the "requests" nested attribute under dump.request.
>> A netlink dump carries an empty request; its payload travels back
>> in the reply. Because the spec names no reply attributes, the YNL
>> C code generator synthesizes a forward reference to a
>> <op>_rsp struct that is never defined, breaking any consumer of
>> these specs.
>>
>> This first surfaced when Thorsten Leemhuis built tools/net/ynl
>> against -next:
> 
> Thx for the quick fix, this makes things work. In case anybody cares:
> 
> Tested-by: Thorsten Leemhuis <linux@leemhuis.info>

Thanks! Applied to nfsd-next.



-- 
Chuck Lever

