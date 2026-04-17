Return-Path: <linux-nfs+bounces-20941-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDqCGdBe4mlM5QAAu9opvQ
	(envelope-from <linux-nfs+bounces-20941-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 18:24:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F23241D144
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 18:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A13E630BDCAA
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 16:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEA03537DE;
	Fri, 17 Apr 2026 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="PSSGirqO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10712342C92
	for <linux-nfs@vger.kernel.org>; Fri, 17 Apr 2026 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442770; cv=none; b=SOGq2XHaRL6672y8kdr/hUx6u3xz7Hfx9P7dxVz9+7KteGk8U7ziZ25jPUXF0OFNg2TbET9js0a5h2EFnVc/eQ+Yb6GLdZzr1RmFePzo2D2jGqGb4mwB47pDsM9u7BkXWKBsRBZOKMMCLKrQRawCNyPFtPjLKewjJ+R6ksxiCeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442770; c=relaxed/simple;
	bh=ygQv38RqJKvh1SS+IgZEKCxGBxDC/Yqv4ap6i0tZ2WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dF92lugVb3A18prTjD2a/h+rI90w15EFhOmRoP3VDTkAgSY7k4P+uf1/NJAyG4vQ69QrwKsneIASZIWSYiR9MsUXd/VKlfVlWbF3+8qiD0zYcHSQ/Vazs4DKh066mrY5NcIoBZviWexy4fM2lxkvGL+13A19+8Tq5eTzclHO4jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=PSSGirqO; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-409de4132b5so558415fac.1
        for <linux-nfs@vger.kernel.org>; Fri, 17 Apr 2026 09:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1776442768; x=1777047568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAZj6q0GbSybVG73tUUfRCMNiF4vqq2mbMfOFb5td1w=;
        b=PSSGirqOqnIpfz6dH9gyxiL04OggjZU2vnXC/DVZ+zso8SwFi2hQSEaI6TcamVUEdu
         eJtamUd/Mj5g7RZNCvbGsqonJIe8lWkz2F03Yjm1xh+8Vzn+IQxT3scUSdCSvvkGneJh
         ydq8M01cNCLBe9JyrrW0Ll4Hw5/84jfiSJbue1i/3xiPkLmjZ8+REI7Gagi95OoiiepH
         bEf88qYsdBCP4YmIclmd6m9uYI2gbFi+jeWxf8DQf1JvhGHxCCrmGDcW6CJMawwX35oC
         bdJxJemUiyCkDteSTjEaCp+CP0zicNZ2DLe1VqHpg3ayoHRGQUgLdmjb56WMEJQk5YaH
         q6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776442768; x=1777047568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hAZj6q0GbSybVG73tUUfRCMNiF4vqq2mbMfOFb5td1w=;
        b=MDurN38XKZkmYnxLQMSpXOSSWFZI3iUhPv5tf05mHO1GP43Rn2CKz58sRvC26uy4Ln
         Mi9P0yhXssbR0uiQsK8erzmrMQa/QlL8henvvOIPQRP4tr4pHq1CpT+Djr5o7Pa0f+6r
         9K69gZ9Wt/FVLmhAZc0UWgPe/867RgfIF+iSwz7a9FGVKzQdSccJ6mJDhpcUdAORzsRB
         qsLdeG4jts8OrEL7sPnF6wuVPFLD+9DyWUpTUqPr8/OPcwUDEh7sw2tXyeSIXfruR03F
         iBiF5MsOq9DtV6oYZCDdpc+4ZH6tyGqm5+f0xPYdisew8Ywg8ADkkKMlQ/gXG9BDVNBr
         B7aA==
X-Forwarded-Encrypted: i=1; AFNElJ8i0rG7yMxK1JrlqX/e2sSHLY+4SN3tjys5SvAD3gPOUXu1YfSdxr1Kw7lrJsu8zd3uXkvOosHfjmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywor4izb+TkKIn+QnDIBxDAly95Ypnu/1uk19vo4MHfIt0B/D8d
	rxVXUR67QiU7Ip4W1OgR8bkUNfQUwf+BA/gHfUQ71el7QkIIC2yOxdCZO9wibIr+BYU=
X-Gm-Gg: AeBDieufX+nRAC8hYPdxyN7VFvr+bbs4XCab/YCKoOKKzNbTSV/jELI05Ov8sVAwLdo
	oB+LIsmXI42JI84m6FzL7Rfp9MgW8/Y50NExLPAQ3SfEftDmxq6bin9lwcpvI/2VURAmmdUT9o9
	hPUan7SovE5fNhmZvaBbbI8ADrePlno3DhiZtE5XepPmZrHSEzjNGPO62nB40SG/8pd22e1VXbV
	vZWQ9OXgwsA+QWz4H56L1gBfMj3d/nN4tiXynjG84IkDG6BtCFdNElDsT6bxDZUQVI9BCkfeKUo
	+8Qb1Bmz20VmWWRnVA5hNme9KYoKDOvwhWLA/BYpb+XXm9LnwpT9773fUOY22W+NlWrkB147aQm
	zsul/OxWfU8pubMn5WYOjcCOjeIK5mRJqSb+iwnkxE1iEXVAU0iw4mhMS0sFemNa1ZfSW+zlMuy
	n3LKA6vaBI/mZeGLhhUz2y6cvB5X7hSIwqqbDZGH2euQSNT9Srgg==
X-Received: by 2002:a05:6820:6ae3:b0:67e:313e:22c4 with SMTP id 006d021491bc7-69462f24f03mr1991358eaf.47.1776442767886;
        Fri, 17 Apr 2026 09:19:27 -0700 (PDT)
Received: from [192.168.37.1] ([216.9.110.1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b934a2dd1sm1782252fac.9.2026.04.17.09.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 09:19:27 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Ben Roberts <ben.roberts@gsacapital.com>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pNFS: deadlock in pnfs_send_layoutreturn
Date: Fri, 17 Apr 2026 09:19:25 -0700
X-Mailer: MailMate (2.0r6272)
Message-ID: <14A7BAF5-7D96-4C34-9FEE-CA929267A174@hammerspace.com>
In-Reply-To: <AM8PR04MB7764059A4CC2893C16A3180E8A202@AM8PR04MB7764.eurprd04.prod.outlook.com>
References: <20260408122534.537816-1-ben.roberts@gsacapital.com>
 <B8730746-9646-4416-8417-D73B24FAB79A@hammerspace.com>
 <AM8PR04MB7764059A4CC2893C16A3180E8A202@AM8PR04MB7764.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20941-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F23241D144
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 17 Apr 2026, at 3:17, Ben Roberts wrote:

> Hi Ben,
>
>> Did you reproduce and diagnose this problem on a recent upstream kerne=
l
>> version?
>
> I'm not able to switch the production systems to a more recent kernel a=
t
> this time, and don't have a reliable way to reproduce the issue in the
> wild without risking production systems back on an unpatched kernel. Th=
e
> best evidence I have that this patch is needed, is that we were seeing
> this deadlock occur repeatedly under high loads and memory pressure las=
t
> year before applying this patch locally. It was rolled out to all
> production systems in early Jan and we have not seen a single reoccurre=
nce
> since. The relevant code paths look similar between the modified EL9
> kernel and the current git HEAD.
>
> I've spent all this week trying to devise a precise reproduction (with =
a
> lot of help from an LLM since I'm not that familar with kernel
> development) on both 7.0.0-rc7 (9a9c8ce300cd) and 5.14.0-611.9.1 kernel=
s
> to definitively prove this patch is needed, but without success. The
> initial analysis suggested the deadlock might be triggered from a singl=
e
> process via a recursive call. This theory has been ruled out; all calli=
ng
> paths triggered by a single process are guarded in such a way that a
> recursive call does not happen. Revised theory for why this patch helps=

> is that the deadlock is subject to an inter-process race, where one
> process suffers a memory allocation failure, causing a second process t=
o
> become a victim of bad state, leading to an unserviceable RPC request.
> The timing appears to be very sensitive and hard to reproduce on demand=
=2E
>
> The LLM-assisted analysis follows, and to my non-expert eyes seems
> compelling.
>
> Thanks,
> Ben

The kzalloc failure is definitely a rarely-used/tested path, so its possi=
ble
there's an issue there no one has seen yet, but from what I can see it lo=
oks
like every call to pnfs_send_layoutreturn() first calls
pnfs_prepare_layoutreturn(), which already clears
NFS_LAYOUT_RETURN_REQUESTED.  I don't see how you can end up with another=

proccess seeing the flag.

There's at least one body of work in this area that your systems
don't yet have:
https://lore.kernel.org/linux-nfs/20240613050055.854323-1-trond.myklebust=
@hammerspace.com/

Again, I strongly recommend engaging RH support here.
Ben

