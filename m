Return-Path: <linux-nfs+bounces-19137-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GfAHjdwnGmcGAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19137-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 16:20:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FBE178A58
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 16:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD27A300353E
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 15:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC862836AF;
	Mon, 23 Feb 2026 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdxdjRY1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4Y/09Ep"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC71C27A107
	for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860021; cv=none; b=B/d2kLAX+leDo7YULy230i3oLfp++5YJ7cRndpvrztNLFIA8F4gPhfnu19dLuXFkHAXXTQiH+Tui3AvWG3VGwF5zJh3bwWiFul6zqVVDyTiTbrd2KAtdQUN7OuRkNI1q03tp/HvBhEuwlZbPZ8bNbVfta01zmn0r9cozjbMIRt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860021; c=relaxed/simple;
	bh=KQeIpTH4XFKmXTJJWQj9qBNyee3wcFt+LCggcknfoU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ag0D3bS+3ig8cNaWR/UQx8FGLtJssKwOnmldrBe0B9R7DiOPmfijVt3Jy+h6JByC9DIhsgszI2x5bEHJy32vSXJBFonbYqPm0fXefEZqLY/KGbZmxRE8QT/i0O2eru0ZA/VGaeY8mYud21FQOnx+Vr9xT+c1xg8oXzp2EiJdn2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FdxdjRY1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f4Y/09Ep; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771860018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d23nj9aIDW4dh6WjNj0LFuDtS63/syDA26CT5iRWCJk=;
	b=FdxdjRY1UJDa0kA+q7hH0Ug/8tFZtTco8l/7evSfkh1L8jEm+eDI0tXgCUBKgBIpLHqt8I
	dl9mznUUmkWtoPUfXBwbuxoiDXGK/dfgK/tw9EtWimlY1cB48GjH2J8CQ9qDmlo0MzSjOr
	sPm1q//LorL25TO5i8/1OaH0zWRMeuw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-7FWuEb0bMsuk0fNmGCla_Q-1; Mon, 23 Feb 2026 10:20:17 -0500
X-MC-Unique: 7FWuEb0bMsuk0fNmGCla_Q-1
X-Mimecast-MFC-AGG-ID: 7FWuEb0bMsuk0fNmGCla_Q_1771860017
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-503915b0a88so187539401cf.1
        for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 07:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771860015; x=1772464815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d23nj9aIDW4dh6WjNj0LFuDtS63/syDA26CT5iRWCJk=;
        b=f4Y/09EpbrcziTNt1R75c2eBuCx7x+W6/uD6Y+fFauWmJyymj1fry6ZoncsF1KD3k4
         ioPtZTPUEErXeKGz+7z6pwyvhx9LnicJ+C1092PK291D/1nEWzFhDSUhnzL666rFuXRD
         bLQ17D4KOf4gAsaD6LrwOFYLZi+87HPgFadDbGyzTU/bt6QE1AZU2zNiLWM+Hc7ukDwm
         rTFDO3+QPdxKd1ycapF7tAGux38vq+GGd7B25knLruuj6JvjEAPEnoHe8z7eVD3/jh3w
         5ihn6Lc/9un26SxKglQQ7rmoiAWGLWsREieTwYQMMB/04o9AMwcWE5dqkdOUx35dOPz8
         bTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771860015; x=1772464815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d23nj9aIDW4dh6WjNj0LFuDtS63/syDA26CT5iRWCJk=;
        b=elXo+eD0hHhhnfTjtFAyXck0MGSh5SM7VL2ZE5+CuTfIrW7tQjvDM+JJuskwqp6qEr
         F8vwPAb1SfSk4S+GbzpNi6mtA4s/K1+OVh+bT6ebYZFw36QILweJyCK2OH817vLQarT0
         aIRXGtdumbs4fkrWsun850cEp5nwqCzThdnIy338pnr/FDL11qSq+j4ZlYlmi8POcSme
         lox+8J24Z4Z7HdGQmVmUbk6SxpCh2KC+CCnbMmKIcDKZOkbTFXb6V9Kna47mgS3sD/7D
         6ehWkRWMcd4hlM8xt2X1aStxkY4mDSgdhdSnKSiT61Bn3CZkuw0/gBtlEKyGalNFzEr3
         b7/g==
X-Gm-Message-State: AOJu0YxB2N3MbUluMEQFErhXhiQcBeAXNq2F8HGn8jbzYiJfbF74D/qK
	qP0stL1kGJXA1AY8vHQMHr2Q3+VgGXADx6olprkiIPCyxB1x4lVrwsr38hXmKBRSxORDWRzFre5
	b2ibwjNZ0mOlzy1+rTW7OL65zXheYT4oOhYTDSpG0FwbOR188Ftn5CFsUoZUGZGWAYaEVZA==
X-Gm-Gg: AZuq6aLWq+eYB0JmIVSiq6wiIYNzIGGf+i527F1Mk2iUSrzCHasSttk3OtuebhTWR9X
	vsw6S419Ske5LcwfF1NM7uyir4UQvvQSAYlVXTWeAOr16T90ekBZH1r7ae/fCIyMWn7eIuaSMOK
	MfQ4ZkXqRcXP7OgEYWWBkf4BUB3WN4f3R0mKK2oARv4aDsF62JB+Fra4CixYIV+pY4yPAhEWlGf
	uHzVM6okZvVw8HwjxH6r2lBGxrvInmegKfqDdfY+aA7MOl/cpoGSlLPZpbDrwSgeyTL3r6kNDVR
	LAE3j8q7SG/SDVhzUfXNWW3FzIsnediFsk0cXxB+jUH2zthvLCgfwCBsfk0d2v1eM+hf8PCrWT6
	lL2rUpe0H2eQC8s1AfiQf
X-Received: by 2002:a05:622a:14ce:b0:503:58c:1285 with SMTP id d75a77b69052e-5070bce8fd9mr130537681cf.68.1771860014824;
        Mon, 23 Feb 2026 07:20:14 -0800 (PST)
X-Received: by 2002:a05:622a:14ce:b0:503:58c:1285 with SMTP id d75a77b69052e-5070bce8fd9mr130537151cf.68.1771860014325;
        Mon, 23 Feb 2026 07:20:14 -0800 (PST)
Received: from [172.31.1.12] ([70.105.240.20])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e247b7bsm68813606d6.27.2026.02.23.07.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 07:20:13 -0800 (PST)
Message-ID: <beef3195-cdca-456e-9426-06a1f043b849@redhat.com>
Date: Mon, 23 Feb 2026 10:20:12 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsdctl: load modules on nl family resolution error
To: Benjamin Coddington <bcodding@hammerspace.com>,
 Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <09076517d782c31cc0a654563b42b78c846c5f38.1770236512.git.bcodding@hammerspace.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <09076517d782c31cc0a654563b42b78c846c5f38.1770236512.git.bcodding@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19137-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4FBE178A58
X-Rspamd-Action: no action



On 2/4/26 3:22 PM, Benjamin Coddington wrote:
> There's a precedent of attempting to load kernel modules for userspace
> functionality: rpc.statd will "modprobe lockd" and rpc.nfsd will "mount -t
> nfsd" which uses the kernel's internal module loading to load the nfsd
> module.
> 
> Let's do the same when nfsdctl's name resolution fails.  First try to
> resolve and if that fails tray again a simple effort to load the required
> module.
> 
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Committed... (tag: nfs-utils-2-8-6-rc1)

steved.
> ---
>   utils/nfsdctl/nfsdctl.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> index 2b01f705874a..6a20d180a81e 100644
> --- a/utils/nfsdctl/nfsdctl.c
> +++ b/utils/nfsdctl/nfsdctl.c
> @@ -458,12 +458,12 @@ static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, int family)
>   	return msg;
>   }
>   
> -static int resolve_family(struct nl_sock *sock, const char *name)
> +static int resolve_family(struct nl_sock *sock, const char *name, int loglevel)
>   {
>   	int family = genl_ctrl_resolve(sock, name);
>   
>   	if (family < 0) {
> -		xlog(L_ERROR, "failed to resolve %s generic netlink family: %d", name, family);
> +		xlog(loglevel, "failed to resolve %s generic netlink family: %d", name, family);
>   		family = 0;
>   	}
>   	return family;
> @@ -471,15 +471,25 @@ static int resolve_family(struct nl_sock *sock, const char *name)
>   
>   static int lockd_nl_family_setup(struct nl_sock *sock)
>   {
> -	if (!lockd_nl_family)
> -		lockd_nl_family = resolve_family(sock, LOCKD_FAMILY_NAME);
> +	if (!lockd_nl_family) {
> +		lockd_nl_family = resolve_family(sock, LOCKD_FAMILY_NAME, L_WARNING);
> +		if (lockd_nl_family) {
> +			system("modprobe lockd");
> +			lockd_nl_family = resolve_family(sock, LOCKD_FAMILY_NAME, L_ERROR);
> +		}
> +	}
>   	return lockd_nl_family;
>   }
>   
>   static int nfsd_nl_family_setup(struct nl_sock *sock)
>   {
> -	if (!nfsd_nl_family)
> -		nfsd_nl_family = resolve_family(sock, NFSD_FAMILY_NAME);
> +	if (!nfsd_nl_family) {
> +		nfsd_nl_family = resolve_family(sock, NFSD_FAMILY_NAME, L_WARNING);
> +		if (!nfsd_nl_family) {
> +			system("modprobe nfsd");
> +			nfsd_nl_family = resolve_family(sock, NFSD_FAMILY_NAME, L_ERROR);
> +		}
> +	}
>   	return nfsd_nl_family;
>   }
>   
> 
> base-commit: 8f54511aefe1455161a6c4406ed8c770139f61e3
> prerequisite-patch-id: b0d57152c98d360daa9a71e6fa9759b7eb9de348
> prerequisite-patch-id: 99680869954aef9f878c24ec9ee1302ab7f24b1a
> prerequisite-patch-id: 2ab31271461352d11bcce760e45573f9e6459553
> prerequisite-patch-id: 22c392c9dba2e63916af6cd8fbf4e9d6bce9d01c


