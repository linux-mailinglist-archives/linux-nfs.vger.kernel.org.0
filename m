Return-Path: <linux-nfs+bounces-19858-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBG9GDJRq2npcAEAu9opvQ
	(envelope-from <linux-nfs+bounces-19858-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 23:12:02 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 840E5228392
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 23:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 530B23029E42
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2026 22:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65812BEC27;
	Fri,  6 Mar 2026 22:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CX836SW8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8xDKXOW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED2927A904
	for <linux-nfs@vger.kernel.org>; Fri,  6 Mar 2026 22:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835097; cv=none; b=XsOf4Jm9QdT0YT4a9QnIW0svFOAdtQ9bIcKpg5RXhXLHyM0T5lSmo+yih2t5eQRl+mW3rRuGuoQ4izTlX4c5m7C+kg+N5B11BhyajmbZU9hy9WeNSeKRcQWdhlJDCCkl63aYSijqayOodEsMiuOg2aNKeG4fPxuvNbvcXrz9eY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835097; c=relaxed/simple;
	bh=o02WzngUUpBgzFeOV3LF0qPW2mgcMruhw4GuDWjLUjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opd5riHD/Dw2oAvPhVqWocgj8CJJnLmripwxU9VL0wctvKkIjTLjdE6eLfdf2qvWS1ql6jw1nbyVQvVk1y11Y1h/CXRpYhI7jYBRbmZSM5AJydEjtPRfXm5EZbejYC8ui4f1eQBF+iLsAwgY5ZrFRouk0l1+myzrsWqVfm1eVOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CX836SW8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q8xDKXOW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772835095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEf8bnOS6awdETTBwiVMhjIxITF/Y8McIYuR7YRgc88=;
	b=CX836SW8I1D/TioESGJtoCmdyrIf+V/2baj062V4mNmNbLVYwFmccrrMCiMs3PoARcvz8r
	ghK6MKPRnSyBUjS2u4FVod8Yp+Rd/JNTQvrXUPpussKX+418Fsu0Z9Dj1jQalx8HzFud5f
	E2CdnsmlNlEcyUQsRVUe7E4C2FAa53s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-hprMhKQrNw6RAmhHsQLu8g-1; Fri, 06 Mar 2026 17:11:34 -0500
X-MC-Unique: hprMhKQrNw6RAmhHsQLu8g-1
X-Mimecast-MFC-AGG-ID: hprMhKQrNw6RAmhHsQLu8g_1772835093
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-899e76aa555so291919046d6.2
        for <linux-nfs@vger.kernel.org>; Fri, 06 Mar 2026 14:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772835092; x=1773439892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TEf8bnOS6awdETTBwiVMhjIxITF/Y8McIYuR7YRgc88=;
        b=Q8xDKXOW+1Z//MVyS5ZFNzOqXPlvPnuZCdRGD7Jzt2g/VTWMlsPIxgMPd3KKxh2+zW
         QggDl7MVu4es1qjKl0Gtpz8lJ5gdzCJ6NI/erncinjo1CVK/15ORebzEuf0QqU6xiSKI
         gnSRr2xCFPzqYxXPM7HoWrX2R22sl4FkFMv4r0oBg0mrJvHtwPVQ5JoHqYM3bL0CN9i/
         i1SlVLEjrVi71lVus8dZc5gvDs6mBI8H8XurXGa576tNXysl5N+PEn93Tv3TehAsgAbl
         qdX3cdzKGEqlFlYTGxAjRbhMHbjAe6zz16LmWI+FWHA3TIKD9IStri7rqdoeIWTf3pZz
         Jvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772835092; x=1773439892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TEf8bnOS6awdETTBwiVMhjIxITF/Y8McIYuR7YRgc88=;
        b=wiuWQMFvSBSaf3vqJYw5myPH1k8662W9yOpc1fWCxFdeeerleD44XfAPZ3qwU0Tzge
         Itd+USwEyikSBpmOPDGjDiJHzEcUhkeZuaZSpwtLEQQn3MPo1Y7YQhPS2Fn4adUqxwio
         qOlYayL7VEAcvW0vLt2C9kcBYoipwDMLFR0kRL6AfkcwrkvOq2VXEQ/jE2QwVR3e7BVm
         NPmVeeTUyKR9x20PAwU13qWMIKFn9GwfWBu+PR3MqJcAymoIahn8ds6PH8uOX3XSgdqJ
         2RVhuzK0JW+z4ijjR8LqU42mixKybncVYfaARNnNo+ildHC7z9vW5oYtg1jYJR2RGmbf
         YazQ==
X-Gm-Message-State: AOJu0YyYqcP4qxqY9UlzWK7xhTMNxTMSAC+tTwchnb8J9589X9MHWkjZ
	3EBT7Ksx6CDV0YDvSDpsnhWwkTTgRkDfo1CUPPGkDdJRnfPqlfk6Esl2RS291FtzJtqPE8a4mgo
	37aWqE7Gvsekk41RGDhuwzhGO5GfrU85nydw/WvGieekluvCspJlhvtvm+9nLW/NVRJRLqQ==
X-Gm-Gg: ATEYQzzWh/TgBlsooUepLfPMfx6qHs/II9eZn8+tcB1C0+wPxoTnJWf9y87LhU0c27y
	7x3EzioJoLBE8rVft8iteAENS0g45k+6VVLoETnv9EAaWO3tLnsIkVS6cLNCDBxRlI48JqkiuqK
	ftfmSOCTT4N+KDhq7fjaFUw+AGW/2dVJz96fNPQpSPwAHX05ei00X7yE5CmJVXZ2/Rmsa8wOgT4
	9x1HgiE4QoX40pUkl3nH9+9EoSJWL1lciIgSIiH0Toy2SjwFkyT9B+QncPsGC7lAR35p25lCGhX
	XJyXzN5ta6/sZiFiRyPGR5ytveN4+bORd4/YrOmmSl2vx3U7jkcmAZeTkjx9g0lcIj6kyO2m5w3
	hkOtFc1gd3U3o6GyRYxC+
X-Received: by 2002:a05:6214:d87:b0:89a:110f:894a with SMTP id 6a1803df08f44-89a30a20547mr53611866d6.12.1772835091921;
        Fri, 06 Mar 2026 14:11:31 -0800 (PST)
X-Received: by 2002:a05:6214:d87:b0:89a:110f:894a with SMTP id 6a1803df08f44-89a30a20547mr53611506d6.12.1772835091427;
        Fri, 06 Mar 2026 14:11:31 -0800 (PST)
Received: from [172.31.1.12] ([70.105.240.20])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a31431703sm19983566d6.12.2026.03.06.14.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 14:11:30 -0800 (PST)
Message-ID: <4ad019df-e024-4ecd-b7c0-a44b348dcdb0@redhat.com>
Date: Fri, 6 Mar 2026 17:11:29 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mountstats: Fix per-operation percentages with nconnect
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260228174654.129309-1-cel@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260228174654.129309-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 840E5228392
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19858-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.977];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 2/28/26 12:46 PM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Per-operation percentages reported by "mountstats --rpc" are
> inaccurate when an NFS mount uses nconnect.
> 
> With nconnect=N, the kernel emits N separate "xprt:" lines in
> /proc/self/mountstats, one per transport.  Each transport tracks
> its own rpcsends counter reflecting only RPCs routed through that
> connection.
> 
> The parser overwrites rpcsends on each "xprt:" line, keeping only
> the last transport's value.  Per-operation counts (READ, WRITE,
> etc.) are maintained in a single array per RPC client and reflect
> all RPCs across all transports.
> 
> With nconnect=3 and balanced round-robin, rpcsends holds roughly
> one third of total RPCs while per-op counts hold the full total.
> display_rpc_op_stats() computes (op_count * 100) / rpcsends,
> yielding percentages roughly three times too large.
> 
> Accumulate rpcsends, rpcreceives, badxids, backlogutil,
> sendutil, and pendutil across multiple "xprt:" lines. These are
> cumulative counters where the sum across transports gives the
> correct aggregate.  Per-connection properties (port, bind_count,
> connect_count, connect_time, idle_time, maxslots, inflightsends)
> retain the value from the last transport seen.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Committed... (tag: nfs-utils-2-8-6-rc4)

steved.
> ---
>   tools/mountstats/mountstats.py | 61 +++++++++++++++++++++++++---------
>   1 file changed, 46 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
> index d488f9e1c258..a6adab344d0e 100755
> --- a/tools/mountstats/mountstats.py
> +++ b/tools/mountstats/mountstats.py
> @@ -140,6 +140,38 @@ XprtRdmaCounters = [
>       'reply_waits_for_send',
>   ]
>   
> +# Counters that should be summed across transports when nconnect > 1.
> +# Each is stored in a per-transport structure in the kernel
> +# (xprt->stat or rpcrdma_xprt.rx_stats) and represents a cumulative
> +# event count or utilization value.  Per-connection properties (port,
> +# bind_count, connect_count, connect_time, idle_time, maxslots,
> +# inflightsends) retain the value from the last transport seen.
> +XprtAccumulatedCounters = {
> +    'rpcsends',
> +    'rpcreceives',
> +    'badxids',
> +    'backlogutil',
> +    'sendutil',
> +    'pendutil',
> +    'read_segments',
> +    'write_segments',
> +    'reply_segments',
> +    'total_rdma_req',
> +    'total_rdma_rep',
> +    'pullup',
> +    'fixup',
> +    'hardway',
> +    'failed_marshal',
> +    'bad_reply',
> +    'nomsg_calls',
> +    'recovered_mrs',
> +    'orphaned_mrs',
> +    'allocated_mrs',
> +    'local_invalidates',
> +    'empty_sendctx_q',
> +    'reply_waits_for_send',
> +}
> +
>   Nfsv3ops = [
>       'NULL',
>       'GETATTR',
> @@ -291,23 +323,22 @@ class DeviceData:
>           elif words[0] == 'xprt:':
>               self.__rpc_data['protocol'] = words[1]
>               if words[1] == 'udp':
> -                i = 2
> -                for key in XprtUdpCounters:
> -                    if i < len(words):
> -                        self.__rpc_data[key] = int(words[i])
> -                    i += 1
> +                counters = XprtUdpCounters
>               elif words[1] == 'tcp':
> -                i = 2
> -                for key in XprtTcpCounters:
> -                    if i < len(words):
> -                        self.__rpc_data[key] = int(words[i])
> -                    i += 1
> +                counters = XprtTcpCounters
>               elif words[1] == 'rdma':
> -                i = 2
> -                for key in XprtRdmaCounters:
> -                    if i < len(words):
> -                        self.__rpc_data[key] = int(words[i])
> -                    i += 1
> +                counters = XprtRdmaCounters
> +            else:
> +                counters = []
> +            i = 2
> +            for key in counters:
> +                if i < len(words):
> +                    val = int(words[i])
> +                    if key in XprtAccumulatedCounters and key in self.__rpc_data:
> +                        self.__rpc_data[key] += val
> +                    else:
> +                        self.__rpc_data[key] = val
> +                i += 1
>           elif words[0] == 'per-op':
>               self.__rpc_data['per-op'] = words
>           else:


