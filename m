Return-Path: <linux-nfs+bounces-22117-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMJnHE9bG2oiBgkAu9opvQ
	(envelope-from <linux-nfs+bounces-22117-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 23:49:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E614A613800
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 23:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E77F03027342
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 21:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328AE2BEFF6;
	Sat, 30 May 2026 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9w5eRkA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDCB1DDC28
	for <linux-nfs@vger.kernel.org>; Sat, 30 May 2026 21:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780177739; cv=none; b=cJcQ7qO2GFeU95KX8EHgVLYhaMu2EDm4duJCW3yhYPVB9MDN4IQ+EyX/1lj9nBitrbp/NjmA8W4LSihYXtvas1d+w3omzYMg9Go5eSJNVSHWrGjAG9meLhn0Jnhob8ipdZObywAiHPUwO8TlKgB0IeKtK0AVKvdKAo8mwDhaQcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780177739; c=relaxed/simple;
	bh=aHH73Wv9aJ4D7FAM+iFiB2n5fQl2tYFVTbHDn7p3rf8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BMRSFd1Arl9weE5a96W/3YUrmpJLuIxvKfqIXd0EZ2fyBMSt0VdE7CJ0o3xpI8fOin78fgKM5LWAPALkLW7hy2GMnURcG5Wvdb8jJfoX7umbcut0tkb8wmnco1/vFBcfe4K2j4OFy8dW5sATzMLlauA0xhasKkrJuJ2bdF6zH2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9w5eRkA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5EF1F00893;
	Sat, 30 May 2026 21:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780177737;
	bh=SPxoQmjY3c/dgP7L8KxJvFpxvXDEgYSpQ3lbQjK9tBo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=U9w5eRkAx/MMPEbGBQQA+Od+QrD01VhWGD/4foYQXsfZJe2tewdfcC4ojvIvTNFQk
	 GwkyjE9ZEEx6TtCONjnowXAb29mwCJFhTemjSQKJttmaRa1UyXfDJD2Rl8QvMF2nlO
	 FcYmJoJ68FNqqKBoYB7AoTeu+brTMHQFdAFPpq+SrHNwtojm5+WXx6thQBdS3lcX9B
	 h+4oC7lPNXyS8cYkrFg0mEHQMOBqGJlPO1Rlol7+fJzXUTOFu7LMd6nnc/pLLdx8n4
	 Y5HWJ65ZG1y2qf5gkNGn1UOkYOsInMjhisjv8NGxH4QO3wcyxeCyOor5+oTuJ4OMOi
	 HhkdaILoyI/ig==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8C627F4007C;
	Sat, 30 May 2026 17:48:56 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 30 May 2026 17:48:56 -0400
X-ME-Sender: <xms:SFsbar81NBHsWvk2IKFmdCF1zT9ql9cx-C_sNz8EaSLlVhPk02dtwg>
    <xme:SFsbaihQJ0XZfFq0mTsQRNY9keMQwJLiQiMP960C77tQxxk4yNWBhNgRDojWaIoPk
    j6uZz6ElDvuqzNI2bDPTeqWIh7Jm3eSeqMAoFuno-XaHWBdJ0zi0fs>
X-ME-Proxy-Cause: dmFkZTFkfI0uoB4cXUU3bWHZ2swD52JBaZBhich+oGcz6qEeH/0AdeSfD/ig23yMgp/U4R
    6j1xbrUC0WZpFS0sMLKMzedoVvXfqpbqFE2XGDn0FPoearLAx6P83oLKT3HfH7jC1CVsep
    7gThHYLpe9Ab/dsiwUoqP9bNwRTilpO9IAxw/XcUAzzZeu85Qsky5n1ZXMl9C3c5fpwZMk
    ZpNSocF9chGmPNu3NRF5QvyVXcxNZ8s3w9L/O+RdNJu2S3750Of8w2PA0UQ6pUJtHzynfl
    mswKq1FzDoAeBIbBLGSAypYyc8Zg7KFIQsgYX1GbvMf1WxrP2ty6g3N1DhFbCSp0U/0YOE
    i667K2avylqe4AaAs3v97y1b1QFTzNJi79ODZpocW9ukE0gLlVm9sGoXKtN8ojNNLziwg+
    KtSKri2WYPHL8+CNeCd4Q22l0DLXCaOUx1Rii1hIrzLS3yaDUXRbhG5O+pYhnt0ElYhq+7
    VNIseZqsqfcODm9cECkJyudjFnv3sZGuEuH0XYaYpjpZGC0OurVsTXJMnIsfzYUJ0N1kt7
    hQMBuXJ2u5blAU6ru25nbEDG4zS1yo35Yu3FUq92bqb2zsRVeWvv8YfXpAuBSR27u+7xDO
    GJ4TfvUc0gC78QGouvbL4nl2ztbAHwcKm2zvdIcvqZvNTnUWbl+xw/8NNu1Q
X-ME-Proxy: <xmx:SFsbarUrdDUxQ1pEjyYnieR68gOCV3zj8T6IxhdxyCXDh0AFd95wWQ>
    <xmx:SFsbakSoRvGUemZarMLWXkbLOBT32IlhGCXHLPBmBLGf3MyqdjOEPQ>
    <xmx:SFsbalmRp5RnMzdZpJxu3-_etw5fZI8vieFQLwwh5ImUsEGl6GH4PQ>
    <xmx:SFsbaq44SFZC1y-SIphZcTjhljqgI5E8d2OsjVRNFLV0IZ4dNjH_iA>
    <xmx:SFsbarjR7jePx3P-5qFC9i982LjuOJvykz0i9_OwaTQ__TJJCnf3O5cD>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 658D5780076; Sat, 30 May 2026 17:48:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: At30mA0xtDig
Date: Sat, 30 May 2026 17:48:36 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <89e89bd2-3054-443d-9852-c1a28d9d9ed8@app.fastmail.com>
In-Reply-To: <0b0a969d8c8dd4769faf8ea2f0589e5af5a9a0a3.camel@kernel.org>
References: <20260530-tier2-local-v1-0-fc294d34848a@oracle.com>
 <20260530-tier2-local-v1-2-fc294d34848a@oracle.com>
 <0b0a969d8c8dd4769faf8ea2f0589e5af5a9a0a3.camel@kernel.org>
Subject: Re: [PATCH 2/2] SUNRPC: Check svc pool percpu counter allocation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22117-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E614A613800
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Sat, May 30, 2026, at 5:45 PM, Jeff Layton wrote:
> On Sat, 2026-05-30 at 16:21 -0400, Chuck Lever wrote:

>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>> index ae9ec4bf34f7..aeb6e631848c 100644
>> --- a/net/sunrpc/svc.c
>> +++ b/net/sunrpc/svc.c
>> @@ -476,6 +476,22 @@ __svc_init_bc(struct svc_serv *serv)
>>  }
>>  #endif
>>  
>> +enum {
>> +	SVC_POOL_COUNTERS = 3,
>> +};
>> +
>> +static int svc_pool_init_counters(struct svc_pool *pool)
>> +{
>> +	return percpu_counter_init_many(&pool->sp_messages_arrived, 0,
>> +					GFP_KERNEL, SVC_POOL_COUNTERS);
>> +}
>> 
>> 
>
> Switching to this looks like a good thing, but it means that the
> svc_pool struct fields now have some strict ordering requirements. The
> percpu_counters all need to be snuggled up together.
>
> That deserves a comment to that effect in the struct svc_pool, so that
> we don't inadvertently break it later.

A comment or a static_assert


-- 
Chuck Lever

