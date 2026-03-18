Return-Path: <linux-nfs+bounces-20256-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC9JA6i3umlWawIAu9opvQ
	(envelope-from <linux-nfs+bounces-20256-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 15:33:12 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FC32BD322
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 15:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD8073017DF1
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 14:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79413D3CEF;
	Wed, 18 Mar 2026 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="un1V4RYn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32C426B2CE;
	Wed, 18 Mar 2026 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844349; cv=none; b=owsqlllp++9rvOBpd1yoPmoDk83x3AZeIPjRooK8ksQGOuaIh4gHdhjlLSPEgSjrAsnnKjSdzndFG/H0N3F3L8RIA61u1jaYN6TSHolMJxwA44rdgpuqJo+8+P0ae6k6V7aKABhqTQ/6RjozCRvurIvfILLYNUoKWwjn14OUhNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844349; c=relaxed/simple;
	bh=BFLH9MG6O8BjoyXkSjBPGPGjZPG0kogd7pgludm/72o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmB5q83/Nu17DqvHEtEM33fnFZ5wqKp5t1PuEyR4aF2HyXv70jvW2zCcagqUAfQts+xdgXDW0J2G8n57CMHHHMLPhXXnoNiwKIz3Zxs+vqI2ZRyk8WwoGnwtLbvS+Gfc+nH+0uyWQVYZS60p1Kui5at1RhNNSmkOsVkGEgKfr70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=un1V4RYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9EAC19421;
	Wed, 18 Mar 2026 14:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773844349;
	bh=BFLH9MG6O8BjoyXkSjBPGPGjZPG0kogd7pgludm/72o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=un1V4RYnKiJ5Y6ZmOKrrGfcK9MjgK6PBQcCshnV8j8RCPkkkjjFTUFhcpKqYRSDfS
	 p2t164W2L9twF03tg3vAy1F4h4Wo/GYlFYDvVMTmdat+HjDkxxCdJRy2oGoprC7b7T
	 CjesFUt76JfCgJDJu1xaA6fzJr9RQ/n1o0T085jvhoak9ScSQhuxrk3go8s4xxavxq
	 AjVVgX61yVhYiLnIYjqK2kF1PKCHExkR1Qem09Quwx7M2bWyZ0Cbr2Lqjauo/o/OLj
	 n379hEcB+ESqSvOHFfmQ5nnGgderCvlVn6CL7d67vWfpdKFu4POTgkgBjXjOlYLlFn
	 67mv/VOvmeMQA==
Message-ID: <9ea5b835-5e91-458c-9929-c1df7e6df25d@kernel.org>
Date: Wed, 18 Mar 2026 10:32:27 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] NFSD: Add NFSD_CMD_UNLOCK netlink command with ip
 scope
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20260318-umount-kills-nfsv4-state-v4-0-56aad44ab982@oracle.com>
 <20260318-umount-kills-nfsv4-state-v4-2-56aad44ab982@oracle.com>
 <33d42b3de7a2c7cd61bdd01bae04a2e082755f95.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <33d42b3de7a2c7cd61bdd01bae04a2e082755f95.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20256-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: A5FC32BD322
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/18/26 10:28 AM, Jeff Layton wrote:
> On Wed, 2026-03-18 at 10:15 -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>

>> @@ -227,3 +249,13 @@ operations:
>>            attributes:
>>              - mode
>>              - npools
>> +    -
>> +      name: unlock
>> +      doc: release NLM locks by scope
>> +      attribute-set: unlock
>> +      flags: [admin-perm]
>> +      do:
>> +        request:
>> +          attributes:
>> +            - type
>> +            - address
> 
> I wonder if we'd be better served with different commands instead of
> passing a type value to a single command? Different types are going to
> require different attributes, and it'll be easier to validate those if
> they use different commands.

I was following your philosophy about the THREADS command. But it's
correct that the YAML/netlink infrastructure struggles a bit when the
arguments for each of the subcommands are so different from each other.
I don't think it would be difficult to break UNLOCK into three separate
unlock netlink commands.


-- 
Chuck Lever

