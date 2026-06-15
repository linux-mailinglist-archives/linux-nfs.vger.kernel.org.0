Return-Path: <linux-nfs+bounces-22561-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X94BG9goMGruPAUAu9opvQ
	(envelope-from <linux-nfs+bounces-22561-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 18:31:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFAB688664
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 18:31:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=EYnOf7Im;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22561-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22561-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80B5C3005AA6
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 16:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA2B40B6D4;
	Mon, 15 Jun 2026 16:31:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4D440BCCE
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jun 2026 16:31:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541073; cv=none; b=gLhj9e7imIgpTfinv2c8MZ90P85Xfy5JxYUgazmmJzlgGe1SzG3V+Hq9X5uT8vMbchLv6Yd2VNT0e80o3zpYaTl7XCzkJmGzSVauTJPuBPjrmyjOFthrDnFg8mKHxQitxv//kZ6rpXOE93pYicMlGOL5oM+e9EQXOVCkvj/OVcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541073; c=relaxed/simple;
	bh=cVDmYfEGVssheWJhSWK27re/UJwlUSsyp4HfA5hfVZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qwGoHOkMimg+pqRMnll4j9SKzI7VaKA0tiP3APAQIlHTztI07WSw6TPw+gOVb3D71YF8uwTlpDC1vn0KxTvZnj2KkFHpe/bJIkx0vSPsGmSqsNAgdDHohvxswAxELZELA807NEujX4qWjvGLjqS5mgyCS+SUu5R0l3zevTm5GfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=EYnOf7Im; arc=none smtp.client-ip=209.85.210.52
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e701435806so3180279a34.0
        for <linux-nfs@vger.kernel.org>; Mon, 15 Jun 2026 09:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1781541070; x=1782145870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOLT+Cx7rygGAhn5fXHgsIZ/7VbjcLS51e8cpTmCJU4=;
        b=EYnOf7ImRSIeVOob09eya/512O40q+YTOTJJySghw8ajbFgHUjGUsPbaY6QPJETmyp
         JpZL82wU1Ac7/ekeczyPUS/+nkProPfj3IPJFjTnBuObcqrJrT9tYWlwf2aS3y92x5ex
         GGc9Dog7SemCOdS8jXz75jvz09VksXbVMesOTN7mmGGf6qupaAEtV2oowhqTo37tUokc
         LZO17zNuqYOFNZ9aFGVwGSxiqTu39IewuRWHZgcWplFaz+Ic3iwTGb2naauQmVj36eeR
         LWtOSlUpNdHyAIWKtpvMoaaANDfpIC1PrS7M/MIAM5O87zokoFetcYBMYtAuoj+6WZmM
         15IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781541070; x=1782145870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tOLT+Cx7rygGAhn5fXHgsIZ/7VbjcLS51e8cpTmCJU4=;
        b=CsvR+RtnwptCc/tsPoXVUY6vQEfjfA2GLrL5OGhB7JDNcCT7SWKzh8LQMNX5aC6bk2
         xCC9IHOfYqSWp+rzrMENUq/OKD7v/baA2+7o5n0akcVAf4ETMP8y7CSZEs/Wn0PHomGq
         QG2qPPnwaLDt00hlqmngs4OW4fUfp7LQ9bNS2wWF3j+MaqoEt33XMdok/pWTG1k+yUtH
         /SxB90VfSMT3XnzZSG2xW5JAQAA/9ZWSxkYHGjCGrPTaMTCLYsVZ6v1Gp4odHPU4S0KL
         M4oGRagzKJAp9yy0tYm9YdvOAjtvYlSQNcJH6H872Dw027EPHNJuMZ62ahbu0qMhTnK+
         yRwg==
X-Forwarded-Encrypted: i=1; AFNElJ+AbMw0Dw4D006Tb4OZUepyOJDUrJFo2EWc+jv51OwHNEBw+h5IZn0DaRnDdUiQ7ySTl8KnkM4t478=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Vwvs6grr5xar0rg7YQGwipY2ZIPV2HYt0v3kapLISCsIQ9/t
	FpRSuR2PopLbcYGe4newLzps+LThLOoywkaRSMgU14FjDHnaMnLiWXtjs8QKp+qEw7Y=
X-Gm-Gg: Acq92OHwjUv/rMhIspXM0gSBefzcFAX+13AI+ayPEUfAsYrzOd5yn07EfAIaYBv58Wa
	ODa4fqi/vs8CIGRsbBEEOsq+FGQ4mJ2e54QGh1tCmMoPl/YyHwFB46QPjb4No56JP/nW3wrP5EO
	AbBp+dUzBB7MMVD18BJKieunzTKqSUnyA+bt2sjqht6mXn6ZvYBBrEkpTiD79986WQLaq6UIM8j
	pbkM8Zo4a1IKvQcRGze95gMcYG+Op4u8QaqTFsUMEWcxKVQxHK/qDkSPYRU1kfxJsgEV5/6cm2s
	bNId+tmJI6fYGsPhUHHM8KQXhzLSr7wGvet4TzyNnj56F6DdzNceR1jE8QzwRjr8U+gR2fO331X
	QmDrDOxQYK5st8DQWQ4JvEhB97WdTVZHEQxVhGhuzdX0LqWqfafS60hx7gJloHXh/4c+X6N2+TG
	dr37IHUCBGsdSWGV6Yy1VIipPg5nFSoRmPDq7hUeXbhBjLUrK8o14=
X-Received: by 2002:a05:6830:3808:b0:7dc:3db6:f02 with SMTP id 46e09a7af769-7e78476a104mr10198138a34.9.1781541069904;
        Mon, 15 Jun 2026 09:31:09 -0700 (PDT)
Received: from [192.168.37.1] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a11efsm4416100a34.1.2026.06.15.09.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:31:09 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: NeilBrown <neil@brown.name>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [RFC] knfsd: per-client fair scheduling to prevent single-client
 starvation
Date: Mon, 15 Jun 2026 12:31:07 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <2B9A7409-C154-4F2D-B7C2-D31CAD795388@hammerspace.com>
In-Reply-To: <178131214982.3002522.3853010351245262459@noble.neil.brown.name>
References: <D33770A1-9098-4F1A-93EF-590E6C0B7638@hammerspace.com>
 <473e337b-fabc-4884-a6c4-0f04b6874d0b@app.fastmail.com>
 <3AB7EB6A-B207-4B91-A695-66C4704D0E31@hammerspace.com>
 <4c5dbb98-0209-4572-8eac-1578536bbd78@app.fastmail.com>
 <AED22AED-E97D-40E3-9839-BF8307EF8B65@hammerspace.com>
 <1a5c70d8-e7f4-4671-a29a-023be7c107fc@app.fastmail.com>
 <178044079821.2082204.6117918610145832039@noble.neil.brown.name>
 <561e9ac6-348f-4d6d-b896-38dbe5ede3bc@app.fastmail.com>
 <20555E8B-0E49-4328-8B31-0F73C3D286FE@hammerspace.com>
 <178060780940.3392745.3574880233025675236@noble.neil.brown.name>
 <83C74302-2A2B-48B6-B0F0-D5E8CB487BBC@hammerspace.com>
 <178131214982.3002522.3853010351245262459@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22561-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:ben.coddington@hammerspace.com,m:cel@kernel.org,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADFAB688664

On 12 Jun 2026, at 20:55, NeilBrown wrote:

> On Fri, 05 Jun 2026, Benjamin Coddington wrote:
>> On 4 Jun 2026, at 17:16, NeilBrown wrote:
>>
>>> On Wed, 03 Jun 2026, Benjamin Coddington wrote:
>>>> On 2 Jun 2026, at 23:44, Chuck Lever wrote:
>>>>
>>>>> On Tue, Jun 2, 2026, at 3:53 PM, NeilBrown wrote:
>>>>
>>>>>> Idle clients will get pushed back to 1 slot, active client will tend
>>>>>> towards a "fair" share based on how comparatively busy they are.
>>>>>>
>>>>>> This wouldn't help for v3 of course but I don't think we need these
>>>>>> advanced features for v3.
>>>>>
>>>>> Ben’s employer might disagree with that :-)
>>>>
>>>> Yes - v3 is pretty important to us here.
>>>
>>> Can you remind me why v3 is important for you?  Is it the lower
>>> state-management overhead, or something else?
>>
>> Flexfiles uses v3 in its data plane, and..
>>
>>> Is there some way would could improve the v4 implementation or protocol
>>> to make it comparable to v3 for your use case?
>>
>> I don't think so - the stateless nature of v3 gives it distinct advantages
>> (and disadvantages) over v4 for some use cases.  That property can't be
>> added to v4.
>
> v4 already has the anonymous stateid which seems perfect for a data
> plane.
> You can read/write with it just like v3 (i.e.  access check on every IO
> etc), but there is no state to recover.
> You still get client-state and session-state when can be used for flow
> control, but these don't need to be recovered so they don't impose the
> same costs as open state.
>
> I wonder if flex-files can be updated to allow v4 with anonymous stateid.
> We would have to enhance the Linux NFS client to have a "stateless"
> mount option, or similar.
>
>>
>> Also, because knfsd doesn't have different resource pools for each version
>> we're going to want to continue to balance the pool for all versions
>> exported.
>
> But it could if we wanted it to and had a coherent model of how that
> would work.  We could parse out the RPC program and version before
> queuing for a thread, much like we already parse out the TCP message
> size.
>
> We could even do that today: create a separate net-namespace for the
> separate pool, and add some iptables rules to redirect select traffic to
> that namespace.  iptables cannot switch on RPC version, but it could
> switch on source-IP if we knew which clients used v3 and which didn't.

Doable, but I'd rather not split the pool by version: the point for us is
that one shared pool stays fair regardless of which version a client
speaks.  Per-version pools just relocate the unfairness from "client with
N connections" to "version with N connections."

Ben

