Return-Path: <linux-nfs+bounces-22791-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q92hBGeROmpHAQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22791-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 16:00:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC476B7B15
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 16:00:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=NUarxjTB;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22791-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22791-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD0203006B46
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 13:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB0137F8D7;
	Tue, 23 Jun 2026 13:59:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3B637F8BA
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2026 13:59:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223190; cv=none; b=L/MQGu3czBG5YRdQ4gshCGaRQ07zxIeamz1Dz3jrNuKrKvKVcfewpDuY5+8dpV8sLcjxeSmZVS8KPkoQDQXEDLvMorryNRJSAPi2Th5zK6IKRBfH7ap03VJ97vCzFqbFFMMyW5xs7WpPhzGkX+DkAfluRNY2doWM1GVE5OVeDxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223190; c=relaxed/simple;
	bh=sETkBxAMUgFglk41jpuAi935izjuI2RDzMe0WRsECzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ev3reeai9kJh3ahMulwXsdnoNXVAYXjRGvrxAYbO+xDbSr5QZH12cylXCHpBZdRgghq6C2grXMgsisi2P/f0Mz1sDPSoysU2vp4Z04/4UfOihIkHwymnSl2Da9Kwm/iQV6CS9fjUxdkxGlNBXiO1e8L1alK3C+PxFCMwNMx2m/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=NUarxjTB; arc=none smtp.client-ip=209.85.210.41
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e92c443cbcso3144768a34.0
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2026 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1782223186; x=1782827986; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JCayOXrkqLYnm73GMKFy8IEk0cbRPMOQ7G0L2wqUF/g=;
        b=NUarxjTBWlfHNm9mhpHpP9UDDv9Y/5BAVTcISWlhMYJIhnmDGNP/E21OYQGDEAPKwF
         Fn5IsI4Zx0UPpND9w8jd6N1OJTSr194uobhGtpOFHESOlzDKZAxSE8z/2OPhxVwPrdud
         l9A9QiF5fNujIu/PYnFGLJmyoUjhweNTsuvSiDwLthecnp9RyCi10pvTJTad5ki2RxxO
         9G5v/pfw2jteyCqY1LDlkSoTGVRLdre+bI4a0H/tGuBIsvBJILJyr6h/1Iot23748sa/
         VBJsrdyInkHEMZkz/ijDUiSRpAk34uCEapaQcM4HMAx1TkG6iLw93z0YAJ9feqw38aHj
         W5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782223186; x=1782827986;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCayOXrkqLYnm73GMKFy8IEk0cbRPMOQ7G0L2wqUF/g=;
        b=YZpvR5hwp29as5Be9svJd1ErgkaAQK0SZfpRJeerj2vYyAZciMf7dXBYLZDccYnG37
         iB6Hmu30fY3Sw5IoEzwbvHk79hpKk3KtVsXFoS+nt+UWWAn/OeRp5IiUNCW7/0GXqU0z
         vCOUVz4FwO+0kDWNJ6V5AFjOrXhO5M55SFQrwIfgUcwOr+RyINA7+UMzi4k5f4135eAg
         bWjmUiUJwvli1PV3DHsQ3BOECRiN12d7XzyUhLs40O6sjIQUvcb5c3qCu/YnKImuvVIv
         hqrPEXio16PzVD90rHOtHnpruV9vyB5CjFIZaPxFXmItm0+z5Ruf8nwYo83J7zfXawIb
         sYsA==
X-Forwarded-Encrypted: i=1; AFNElJ95+6PiWhMP+RJ2a01nnduECDA7A9yADOLgn3T+mlYpTDns6B9mpnRrC1Y/LGlUYT89C4b6pcWXvMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJVjwBaJzQM0PsWn4wxXZIJHGb84P40DccYqdYaCnYCdCPnxzO
	jf1Qv6JIGZxsTY0Ne1nPAyol/zgTO+iV4XgsAQz44lkKI7X/KkIJwDRn8NDRGgKVTvM/dt08MMc
	YVCuw
X-Gm-Gg: AfdE7cmb6WnwWMpje3pD2iY8Or40Pj/g8eflGscowd4AeuYYp67lICcbNn1kDiDUyKB
	qUwxvRQ5bL9ANgRjFQidpao8d8Wq0W9dUbQM1YpK0Jg3VWDg1ysstQixUGOd6Rvb42bhmRECxqf
	Sm7EYu+QB/92Z6Rc9EeWbMcVmW45otRRwMjyJV7KcspuK1Jfuqq4E/95WSLH5icyIvVblZrDZ1w
	5vCjgUJ4BYUoJG6X+PcmFgNu3al69Qgsa7XCLe5WXB89yHpckl2zqa6lrf+9yEtLwshj6/o23vK
	EASN/gL6pmyDrp9uCJChu6zKD7iMG07HwU65SMqVunwau+hy311LMjUb2M2lXHaCXHRiVBw5LAK
	a8SN77UVt9UYTZZrUu2s0XfD1J3PXyE2VEJsgP9TcktZVFmtfmxfv7e3CMnzbM/Xxduo0b6eg4E
	JKYIkkZ6yZoAi7s6MUOOlV9VLATqEa7WpH
X-Received: by 2002:a05:6830:43a9:b0:7e6:50c0:87a6 with SMTP id 46e09a7af769-7e979743aacmr1881554a34.8.1782223186130;
        Tue, 23 Jun 2026 06:59:46 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e94424f186sm8769941a34.13.2026.06.23.06.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 06:59:44 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
 "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>,
 Piyush Sachdeva <s.piyush1024@gmail.com>,
 linux-nfs <linux-nfs@vger.kernel.org>, Chuck Lever <cel@kernel.org>,
 trondmy <trondmy@kernel.org>, sfrench@samba.org, sprasad@microsoft.com,
 vaibsharma@microsoft.com
Subject: Re: NFS delegations behavior analysis
Date: Tue, 23 Jun 2026 09:59:42 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <C21821AB-720B-444C-852F-CA492DFA8914@hammerspace.com>
In-Reply-To: <509e5aecbccb57cd7cd033d45a0c28db8ba8b52c.camel@kernel.org>
References: <m2qzlx7eye.fsf@gmail.com>
 <0b39c1e01a92f99fe456c76523ec7f3aa5dc1a81.camel@kernel.org>
 <455619640.1622514.1782212671358.JavaMail.zimbra@desy.de>
 <227140ce94ebe4186d02b081489a58f32b878ec4.camel@kernel.org>
 <4323491E-64A0-4883-8343-5EB569A0D81A@hammerspace.com>
 <E86DDFB0-6E5E-40CC-8DFA-7233793D25E1@hammerspace.com>
 <509e5aecbccb57cd7cd033d45a0c28db8ba8b52c.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[hammerspace.com,desy.de,gmail.com,vger.kernel.org,kernel.org,samba.org,microsoft.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22791-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:ben.coddington@hammerspace.com,m:tigran.mkrtchyan@desy.de,m:s.piyush1024@gmail.com,m:linux-nfs@vger.kernel.org,m:cel@kernel.org,m:trondmy@kernel.org,m:sfrench@samba.org,m:sprasad@microsoft.com,m:vaibsharma@microsoft.com,m:spiyush1024@gmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BC476B7B15

On 23 Jun 2026, at 9:40, Jeff Layton wrote:

> On Tue, 2026-06-23 at 09:32 -0400, Benjamin Coddington wrote:
>> On 23 Jun 2026, at 9:11, Benjamin Coddington wrote:
>>
>>> .... er - so with directory delegations, can we simply re-hydrate the dentry
>>> cache from the directory page mappings if the delegation is still valid?
>>> Does the directory delegation pin the mapping?  Clearly I need to look at
>>> the code..
>>
>> .. right - we don't keep the file attributes in the mappings today.  And,
>> more to the point - the directory delegation doesn't protect those file
>> attributes either.  We'd need NOTIFY4_CHANGE_CHILD_ATTRIBUTES implemented.
>>
>
> Which I think could be done, at least on the Linux server. fsnotify
> does support watching for child attribute changes (FS_EVENT_ON_CHILD |
> FS_ATTRIB).
>
> That could be very chatty though. We would need to do the work to make
> nfsd send callbacks >1 page in order to keep up, I imagine.

I agree - it could easily end up having the opposite effect of optimizing
performance by amplifying op counts for information the client might not
actually use.

Ben

