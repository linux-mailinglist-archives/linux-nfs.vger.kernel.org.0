Return-Path: <linux-nfs+bounces-20510-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIYWKQGRyWmUzQUAu9opvQ
	(envelope-from <linux-nfs+bounces-20510-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Mar 2026 22:52:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBCC354135
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Mar 2026 22:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF5A0300D142
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Mar 2026 20:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CBE38228B;
	Sun, 29 Mar 2026 20:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VP3AkJM3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lQkEZ1hk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD2F35B63B
	for <linux-nfs@vger.kernel.org>; Sun, 29 Mar 2026 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774817528; cv=none; b=aV6o30Zf3XgFIytgS0DUI8UYAJV++hFLnMk2ALdEjlTN3OW2AgW+a0H/S2pvLc91AhvVZgEi2HNoA2xCBkvmVcTzdiGiAOQ56TFaY5XUynJneFFNfPbH/KxYJlRfI2KWSpdVBLwYGJqtYdEqqZlNKX1rjQ1BOHf/sdx8naxTiyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774817528; c=relaxed/simple;
	bh=/3r8QJtnkKlAnqJscDm2xlpL9IjJl5zghjdL4PHEUTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jrep2HuBFM011DFMhdTwdkYwdZYlffEtzy0e+qAbd8mE9acBtnbxJ7Ukn2ZyT+Y/SKUquQsa9KpEai1ZNxS6MSjXmxLCYLCIZPKps496VwgUz5poite63hCsSaRY55JIksTBQsk91xwVjMj2iIQ8YmjKUjG2Z4jME+uEopJrH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VP3AkJM3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lQkEZ1hk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774817526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKJmYIZo2wU0yHq4d3xhvjxC2kvbUMn69cTuKGECoxQ=;
	b=VP3AkJM3RpYYzoVBID3UA5D6rckiVPz/BjWuTbvPD6ZoOerv6J0uVm2LfMceQHohbRDygq
	x5eFpLZKB2VjnM8iL8Zxbxbxc+SDIc/fpJBwoNqUG7cwrjNjLQhcfn2yKqvADkqiwPqScf
	0PyQ2oWYgmGz6oz4GrG3HgON4MIXUyY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-omJcUx7FO-aG458hcrXrNQ-1; Sun, 29 Mar 2026 16:52:04 -0400
X-MC-Unique: omJcUx7FO-aG458hcrXrNQ-1
X-Mimecast-MFC-AGG-ID: omJcUx7FO-aG458hcrXrNQ_1774817524
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cfcebeb1f3so743146585a.0
        for <linux-nfs@vger.kernel.org>; Sun, 29 Mar 2026 13:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774817522; x=1775422322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aKJmYIZo2wU0yHq4d3xhvjxC2kvbUMn69cTuKGECoxQ=;
        b=lQkEZ1hk+oYeqbw1sWM6cbkMm06OZXZ+UvuH+HMTZ/m0P5eJnvCU6t4Z16chzTb5LF
         +OvFIFWMOai07yGf/3RCJfCc61wzH3M4KZ2fZLa6MZlIZlpXIXkdEXELCBbyzoTXIh86
         7u6bRLnBvxZM9IjaU/LUjVsyT10MixIpP8sqP+AQj+J3z/itucqe9uDf+QEBZ420s9qJ
         MgkNPT+nBvkFJ6u3+G6HYEsE1WnI4g+U721OxEVmO7zebxz40s44AEsXeWcq2fB7F8db
         GONwtWCGd6EXgRRHz07vsvZTt0dSDig+q6em6hOdfpdAXg3EXwaKrLZj5NxNauiE2pa1
         WDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774817522; x=1775422322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aKJmYIZo2wU0yHq4d3xhvjxC2kvbUMn69cTuKGECoxQ=;
        b=TsY/dyndSH5cZgSqanF6DAykZbNyRdMc8AsBRjoM5B2QkV29LKq5cLWpI8u0v7XnTF
         n7t8vCLxCRhUDwjdrq9ho25+CZ2h//V4e7e46HFFCP8wUW1ijxj8Q38Em1u7UcrnOn5w
         g4iZnnwkX2v5kgWWZ/6CDfv95dF6RI1HxwsJ9rALqVcb6USCgsOqzH/MgmVD5eCjTaSs
         JD87IdstZTU+0MQefxj32svotu7puaYkbAJuHWA5swyLQxTp7/5DGchzV+SfBAylkbRX
         pafRTaYoLHdqLdZG+pxO3nY05sKvWRYtLi9HJHnkENm8mz3MC7qBp4KdwS6EH9ZYDxia
         MyJQ==
X-Gm-Message-State: AOJu0Yy2j/e++QC+SOhTLNA1eWcGGrkMDQ1WwqFJXeUALUWkbFIMCW9O
	dXKBrt8zVEzdYMj1PLIpSmkbj5llQzwtrNVjoMmjGLp2b8CtetO3g0FHZLr7r7TQBNoSHjNxXeU
	5tmjDL182pUuLfKvG/IituD2R9kPBjhszL89yvO5Dvy9M7it2hWcpINvwgTdN4nJImYMkHg==
X-Gm-Gg: ATEYQzyFwrG5wbqVzpi3BDE8tQu3TZs2Ibmi4L4PKsl5uZk+37/TXGFTbDwqprpwjvg
	igxhDBMwcnn/TCJf891b8TxKiw3bRpbOkyL+5bLqy6i2g2zVGmE9/BKlXYbxvYbt6G1R4t+lHWp
	nKylEGaiDuAyGs3Qz2y06+EfaaReS+XPjfPMVckNpJIVFwq32zY2bq5CAxN/0fMY8+DBGtqVjAm
	WedPfVBiExrvvYwZhMn0Dvl6RRob0ykp8iYkTqa0/6gfKMcLWGmlHDeox8q44KWSakN4XP+CxLt
	y9U+udnsK6umVNT+M6pvio3+Dsfv80fHSesq8DX9vqEOU/0AAnQK699SOcugVZ8XBxKW3UxIKW/
	3N4jLbv9VCyBvR9AeT6D9
X-Received: by 2002:a05:620a:7109:b0:8cd:b71d:b1ca with SMTP id af79cd13be357-8d01c7fb0e6mr1292795485a.63.1774817521935;
        Sun, 29 Mar 2026 13:52:01 -0700 (PDT)
X-Received: by 2002:a05:620a:7109:b0:8cd:b71d:b1ca with SMTP id af79cd13be357-8d01c7fb0e6mr1292793585a.63.1774817521450;
        Sun, 29 Mar 2026 13:52:01 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.240.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d02803f2c9sm445806285a.23.2026.03.29.13.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 13:51:59 -0700 (PDT)
Message-ID: <d00a2f97-73ff-4832-b989-b0785dda3e22@redhat.com>
Date: Sun, 29 Mar 2026 16:51:57 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs.conf: nfsd: Reflect disable v4.0 by default value
To: Salvatore Bonaccorso <carnil@debian.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20260323214113.3336878-2-carnil@debian.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260323214113.3336878-2-carnil@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20510-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2DBCC354135
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/23/26 5:41 PM, Salvatore Bonaccorso wrote:
> In bb3f98c848a0 ("nfsd: disable v4.0 by default") and 27b9d85dbc30
> ("nfsdctl: disable v4.0 by default") v4.0 was switched to be disabled by
> default. For consistency reflect as well the 'default off' change in the
> commented entry for vers4.0 in the nfsd section of the nfs.conf
> configuration file.
> 
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Steve Dickson <steved@redhat.com>
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
Committed.. (tag: nfs-utils-2-9-1-rc2)

steved.
> ---
>   nfs.conf | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/nfs.conf b/nfs.conf
> index 18a1b319a524..3628b2f2d540 100644
> --- a/nfs.conf
> +++ b/nfs.conf
> @@ -71,7 +71,7 @@
>   # tcp=y
>   # vers3=y
>   # vers4=y
> -# vers4.0=y
> +# vers4.0=n
>   # vers4.1=y
>   # vers4.2=y
>   rdma=y


