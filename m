Return-Path: <linux-nfs+bounces-18881-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHtNBWhdjGmWlwAAu9opvQ
	(envelope-from <linux-nfs+bounces-18881-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 11:43:52 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B495123890
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 11:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56D58301ECE8
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 10:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DD6350D55;
	Wed, 11 Feb 2026 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="YNtdMdd6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA2336923C
	for <linux-nfs@vger.kernel.org>; Wed, 11 Feb 2026 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806412; cv=pass; b=e0YrQX7pOnD4sgiFEe8Y4fCiT1BMmSt5JEwkPDVpQRLtIfzxv4PdAOQh1jZLKwTgRwK2q/6XvtsMCcuhigdmRIWAaWLjRha528Z3tM5qOlLol2R92AvFkLfb3+YUxYyShRgnjtntIPRIaFVNSa1qGOVrVa94zYOFlRQo9e83NJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806412; c=relaxed/simple;
	bh=+PVZWfyJIUEQH9lyjVtGt+MNAcBL4BJMJmk8FffsVnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqlHRNfA1rPWC/a5LvY7jHRhVTM6CSV9pJFtLC2vckv5EIxYTLosEQozf2SdeB1R9CXO9h4gBJy3hWvPEzUQPqqVkUB5keD9At307eSuGFNOPC5t0yCC0YB0Rch8ZzXQf/x+Imx4QxPDy6Jak5Cac4IlFpbiEyGW/GDfd2SHCTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=YNtdMdd6; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65815ec51d3so8033857a12.2
        for <linux-nfs@vger.kernel.org>; Wed, 11 Feb 2026 02:40:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770806409; cv=none;
        d=google.com; s=arc-20240605;
        b=NPEakAbCZ5LuWyHTXRFYzNRhcqvwPUe6CQAS0MfN61G4pv6EklbOMhK008p7S2nM6v
         OrddGgBe3mSGtswEhr0xW0+gdAFJsMxP+WEvwUeTGa6dscqRwlTzyG+deB9ljeXvaldy
         s8JyF3OkskOadDwPuIhuNtCuSOGt1IhXTsMitTj2Ga2IXtxV4mRvpbZ+rMG9ApHU7Dbw
         HlfqDUmiwSE2m89PNpRdA4bOZG5rxvtJJTPV+LsyUCsbMrPpocm0YQGqPQe6d/na8sVu
         +PAEuTBuEPEW4BFKLImK2ZiAhkI2KxZX8xd4VISAupQnTGCnjc6cg4gyhCNoQ8Ol18y7
         XN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+PVZWfyJIUEQH9lyjVtGt+MNAcBL4BJMJmk8FffsVnw=;
        fh=fHHF/Ols5kY+nXCl9h0bqkW/1GiNipAqlLa1h6uk2iA=;
        b=VTb2PwRu8ODqoquHyukbymLoHJjs5TV45opeHWxqu8t4VmC8CCLLhdSYQKPo9EVvoj
         Utm5MNEXG0Ve0VyFP9aYJYUBvuetCqlgURqomvSIxWSEzi8QTc+Bv/MBZ1DpOUbGa6k3
         p/3VvWlJh0oMgOhcQjlmWIbijWxhPeSVX/zdChI9m3YizKTfdFP7YUnm4BoxzkCd9k3C
         Jt9D+0yvkIxxqWLW8xfOu6qSSRNiqYKzf7fEBhUZT5bgzy5gfWv5Za4u68e86vLJhXIb
         s4QyW8wa0Yd0gc2iRVMxQiKn4nlzYUwaZgdd7j+wnCwL2PeFYCkg4dyCV6cfRlD+r9pC
         aUWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1770806409; x=1771411209; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+PVZWfyJIUEQH9lyjVtGt+MNAcBL4BJMJmk8FffsVnw=;
        b=YNtdMdd6jkT2aXxFznyZBDTbw8J/C5QPB4LG+o3OOsuyz9Dl/c2JlvkW/nXTITTm2R
         ucrDiZQOdF6q5QA66+LMTBnvrVgEXM0t/6KjsnkN9Bj+YbZavYKUQ5hpVlq0EeOIiQZg
         Rbqu3D04r/DNuS7UlCzA+oDmHTy4bZl9zcoSb391MxVjeWlnFED7l6krXlIJHQ1IOSel
         MxD5kXUgb0dOUbXHi6QNDmvVwEJSR/UphGhm5Ye0zSKum4BaUThA6EzfQHWurbkX0NtZ
         pyjJNiFLL6j/CRM3rou2pkNTgh39g0ILHEN1cAYt0HXRulwZU3sdens8XonUnxWBbbm6
         9+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770806409; x=1771411209;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PVZWfyJIUEQH9lyjVtGt+MNAcBL4BJMJmk8FffsVnw=;
        b=L3wqL0xpO6+3g6DO52R9ufcLkGTcbV4/VSaNlyDufdmI/nnbkrqGVSdB49Le6VsM8N
         m1oDYZX5OoN9HkxpvXd5Alp1VtZQxo0Z6rOB/DgLLQUdT2r1m80ztdYIeYCv2yoNF2Ln
         opAYWrg2oVoYMGNAUsiBNlgm4iM7UWwDl83LzqbwHhZra2Yex0fWeP9ZE1+hoIAOMupQ
         yAqCTNfdUfSk74XoujslxZ8R0UZoqHj8Ig+h1sr51C9EsGNO+08OsD8RFxumphXB/C/0
         9sKWIKWjqu+pbdXmj/5AGZO4W142ko+FXNRcyMHLW/fRx5i7tdbjfxVS3bi1CfqX2BjC
         7mlA==
X-Gm-Message-State: AOJu0Yy25SxWeSvyAaiv+g5r6zVsple8+HedG4rjzYtacHsYIS4itQVB
	4gB6rvl2492Tcl2Vw3HGMSivYxBb9ruBMkQ3cRnG1CvEPapNp/SOKneaevpDpKXvbUTF64hoLUf
	oXA7wgCasDJXZgrZsvG7qfNTaWC193C25YwySZSY7HR5HHT6s6IfR2ZhBLQl++iQ=
X-Gm-Gg: AZuq6aLl8XgRI/dZTMi9bCVA4Ulct2hhaTg6wq+7fRnpg93bhxX8gINcw5ZFME330r3
	k0vaaPoo1ysNeRva/aftB3eD98ODSrrTRV8F1CeJ2w9dF3NgeChh+pCl0f/KBgcTokWWXZ+LkiL
	TyT0EWe+lX/zmCAwM0uxfvbCujKIKJVLqcR35A28VYNI6iRkawROWy15dbHWV6dAZKfcbxw/4Z5
	+OsmSxb35PmOFYrojX9T8AvMKgewvFESQIr43YBeG0yeThnq+k0tl8fSct70yRmS1K3pFrDcz4c
	iTlFaA==
X-Received: by 2002:a05:6402:2345:b0:658:1421:b569 with SMTP id
 4fb4d7f45d1cf-65a39b034aemr1120914a12.14.1770806409395; Wed, 11 Feb 2026
 02:40:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPt2mGNAGaO8hP9u4M+oH0_w0dbSNAmDF=g0jyb26ED5R_mhOA@mail.gmail.com>
 <a1b6c46f-e49d-4ae6-ae5e-3c08ed40e359@app.fastmail.com> <CAPt2mGNL4neF1NX7_1=9svnNz_iXhadHw0AEjZ_B-50-vwNtUg@mail.gmail.com>
 <723418cf-cec6-4afc-906e-b93a55e85fc9@app.fastmail.com> <CAPt2mGNkGbWujzTzxoTGTvAWoOL9aUUhN93SEJQYJTQyV4xu7Q@mail.gmail.com>
 <d9926f9e-50bf-46e7-9109-21b30dd695c1@app.fastmail.com> <CAPt2mGNbZm9YDjuCUwJHiJUQUUnKQtbf1ggYPzAytgWjMp68LA@mail.gmail.com>
 <CAPt2mGOsCLrG30s7mrOvd3N5t018T+gJhGWd88pw0WbOnagO=A@mail.gmail.com>
 <110b6190-ed55-41d0-a3ca-580ebc38c1e5@app.fastmail.com> <CAPt2mGPMvQMyMcNUnznqU=0pSZ4xVDB32Q61_gTkL9TvHyKXrA@mail.gmail.com>
 <d97b4a81-7fbe-405e-b5dd-82e74630c9d9@app.fastmail.com>
In-Reply-To: <d97b4a81-7fbe-405e-b5dd-82e74630c9d9@app.fastmail.com>
From: Daire Byrne <daire@dneg.com>
Date: Wed, 11 Feb 2026 10:39:33 +0000
X-Gm-Features: AZwV_QiFmrPWNsxLc6PjLsprfHA_mV1sL8yYAyYJn3UANmCNO6FNy1jW_PYb0WA
Message-ID: <CAPt2mGNVMthai4J0QRSaJdWHP4X+K_mzqBxWQGUzdOihMyU_KQ@mail.gmail.com>
Subject: Re: knfsd read iops limits?
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[dneg.com,quarantine];
	R_DKIM_ALLOW(-0.20)[dneg.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-18881-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daire@dneg.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[dneg.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,dneg.com:dkim]
X-Rspamd-Queue-Id: 3B495123890
X-Rspamd-Action: no action

On Tue, 10 Feb 2026 at 21:21, Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Tue, Feb 10, 2026, at 1:34 PM, Daire Byrne wrote:
> > On Tue, 10 Feb 2026 at 16:53, Chuck Lever <cel@kernel.org> wrote:
> >> On Mon, Feb 9, 2026, at 6:43 PM, Daire Byrne wrote:
> >>
> >> > Anyway, the attached lockstat is consistent in both cases - the nfsd
> >> > threads are using all the cores of both sockets.
> >> >
> >> > I don't see much difference in the patched and vanilla cases. I will
> >> > triple check that the patch series was applied successfully and I
> >> > didn't mess up the install.
> >>
> >> The lockstat data shows that the patches are applied and that flat
> >> combining is reducing xpt_mutex contention, as designed.
> >>
> >> This time, the lwq spinlock in the thread pool dispatch path
> >> shows very high contention (246M events, 54k seconds total wait).
> >>
> >> Could you collect "perf record -a -g -- sleep 30" during the same
> >> workload? A perf profile should show whether that's the throughput-
> >> limiting factor or whether nfsd threads are spending their time
> >> elsewhere.
> >>
> >
> > Sure thing. I have attached a perf report of the workload with one of
> > the nfsd threads expanded.
>
> Thanks. The two significant contention areas are the lwq idle
> list in the SunRPC thread dispatcher and the group sort in
> nfsd_setuser. I'll post some patches to test in a day or two.

I'm not sure if it's relevant to nfsd_setuser, but we do use
--manage-gids and have lots and lots of users and groups that the
server needs to parse (sssd -> AD).

For this workload, on the server, I am a member of 737 groups....

Daire

