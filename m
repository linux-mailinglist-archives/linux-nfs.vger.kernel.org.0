Return-Path: <linux-nfs+bounces-21384-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKpwJ4UZ+Wl85gIAu9opvQ
	(envelope-from <linux-nfs+bounces-21384-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 00:11:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA1F4C451C
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 00:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E063D302D524
	for <lists+linux-nfs@lfdr.de>; Mon,  4 May 2026 22:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE79C37BE8C;
	Mon,  4 May 2026 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="FxH2dMyh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E5137B41F
	for <linux-nfs@vger.kernel.org>; Mon,  4 May 2026 22:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777932591; cv=none; b=ZfYmEy0cg4zHJizyJHI60E52dwnAqUlT+PuNbx7wzvCPReOoHtuEwXjPrxzWCllE6vw/1NwK/mEbSflx270mlRphpJGNZ3v1UQciYY9ZnRhEEnGs/sNy7iGcsLJKuraSqfCYQPpX4+FyL1h+oqUbwfscACMyTyoot/fhdpCgu60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777932591; c=relaxed/simple;
	bh=UYPmhUYyotyIPNWmUW+Pa0VVh8tyGqfbMzdc0YBYbPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6+3zGjagf3bLPFh/i3EnHoOnzuEjCa8gYlPsqN9HMoKgf8Fi7ZJWxD0d8+w06ttx2Kc8QJt6VPUj2o8jiRp/2d3MQQcjqKJD8Uj06GlHgyqt2wWsTPInMn1OhfsvZUR+biTtvRw3rl52fGZniNaKuWsI62mQgKMIbBn9PIBBZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=FxH2dMyh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so36691755e9.0
        for <linux-nfs@vger.kernel.org>; Mon, 04 May 2026 15:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1777932589; x=1778537389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Csk4okvNKN3/xj8lV9OUyAM+tViLs/sghbkkBWIUC9Y=;
        b=FxH2dMyhWxRZhKHyszAqKUozLu7kvhuY5fbrsKPgXLGch7Wi5UVUpWwxluM3W0i5tE
         HvdT1m0+FOKXjkMGpVFOGMaSjXDAiE8pZ3cIDBDN7zQolUToBBAyPYfoOLIjRKYhQEsj
         c5IcCyzTOU9TGZ6WS9mFecUV3qjxz66LrNJUNwjg98W5dErlO3hWtypoFrpbFwoR9svI
         bA5FfZ/+jdqr5FEZ7f9fGj8TNiRaxE3na6rCmvBh78PeBHO2BS8rRf3yEFTwl+9KGIJB
         vran6Nna6rrYAN+m7SUXoE/1baJv8B0Iqie6HV+naZzmWqiH4IVwylzKOKdoZxGgpjwO
         gecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777932589; x=1778537389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Csk4okvNKN3/xj8lV9OUyAM+tViLs/sghbkkBWIUC9Y=;
        b=ggyTFWOMGjTCR3qUsBnpSSbh7mar7asOzJEuK5IiltYslPUbOX5/CsbmRv6aPHofWu
         NQMKqQ3x9CNAsnzwo8gtZOvSsfbmjA8l4Lstl2mftTVEy2rM9M0xO7zTidxEvSQQYJIj
         VnS9+XAPZtgRghEkkrfOT25Xi429kOLlBGCtosam0HBsWHF4QSEnAMhCMWUv00BynwkH
         udDw9NKPxYiRRP+6sbP1kmadSkRFVWVryhBv4Pupun+xpYpOFGWOQswQzgCWKCpYvbpc
         v5EkZ55E6zJOjOy8KqYv4MQlLOinfWnjXU6/qQz4lsJrtuGZQy5KvLgL9z4d9KytPCri
         ogrw==
X-Gm-Message-State: AOJu0YxdMwwtZspj+VBBwUfDlDz5eN8vClJCDZZ3nCEk8nn1vqXrto45
	jGnAbZyC3/+l0PGxT+GoZvRN+/b/WLX52/bYegNt+8/hqt4ucNLOcfqqM5JKNefs5A==
X-Gm-Gg: AeBDies6VZ8Sapp0mbBizx6Io0KXEvGPZDt9WmdfFAwSw3ek+eFYm32g0pmgLPzQWyc
	Nt0qMIVgdHE68LjwkyEJ1BoF9gk/aZVUnIC6WKZlEHCT7nmibPGOZPLec+2UO5VTOp74E/F/qG+
	/h6v3kdo/W0+JyMxgFV29ftKQkRgfS5G4j5deKOpED25V3MNPpUFMvBvLn3Rcpn6R01jpcmJJW9
	K4JCG1EdidgfNQIrFJ+U1kYiZFKm5+Jd14GDO89RLiUprrUsNbox/Ude0VLPLOgJ2S9COTU4mTf
	KIOqbORdsyBPiEPu+LB2JtFCzrT05hnpMcbpjk31BfT2fYu/1tKG96NgVK1qbtsybq+0ZguI6r+
	PyCzdynCVP6NkEFBUaxJcc540cBexBEdkm3d4i9IY9yzf2cU5cCZnZaYMsBvwqxWaRZ+qzFlfWH
	4DKBXXVSCmYQH5DtZNtUZObmBiKQd4IhESplk0fO9j0ZAj2zD27bV1WVMW4KKZZywNn3OERAlTL
	DE5CFdSnqIS9R5nBuM6hquDXCdy1A==
X-Received: by 2002:a05:600c:3b02:b0:48a:6fd4:d3d4 with SMTP id 5b1f17b1804b1-48d18ceff2dmr5101405e9.29.1777932588823;
        Mon, 04 May 2026 15:09:48 -0700 (PDT)
Received: from [192.168.50.79] (46-116-175-134.bb.netvision.net.il. [46.116.175.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d14d1b4f6sm4061965e9.12.2026.05.04.15.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 15:09:48 -0700 (PDT)
Message-ID: <37b7692e-5b0f-42fe-b052-84a11370efcd@vastdata.com>
Date: Tue, 5 May 2026 01:09:46 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix a few memory bugs in RPC-with-TLS
To: Chuck Lever <cel@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20260504-sunrpc-tls-clnt-pin-v1-0-197f359c6072@oracle.com>
Content-Language: en-US
From: Michael Nemanov <michael.nemanov@vastdata.com>
In-Reply-To: <20260504-sunrpc-tls-clnt-pin-v1-0-197f359c6072@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1BA1F4C451C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[vastdata.com,quarantine];
	R_DKIM_ALLOW(-0.20)[vastdata.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[vastdata.com:+];
	TAGGED_FROM(0.00)[bounces-21384-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.nemanov@vastdata.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vastdata.com:email,vastdata.com:dkim,vastdata.com:mid]



On 04/05/2026 13:28, Chuck Lever wrote:

> Patch 2 fixes a use-after-free Michael Nemanov hit on an mTLS mount
> whose client certificate the server rejected.

Reviewed and tested both patches. 
Confirmed 3-sec delayed work was happening multiple times without UAF.
Thank you.

Tested-by: Michael Nemanov <michael.nemanov@vastdata.com>
Reviewed-by: Michael Nemanov <michael.nemanov@vastdata.com>

