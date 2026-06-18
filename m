Return-Path: <linux-nfs+bounces-22667-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dd4MBr+oM2orEwYAu9opvQ
	(envelope-from <linux-nfs+bounces-22667-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 10:13:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 648B469E5E4
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 10:13:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=N5yDe5cO;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22667-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22667-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D25ED302F0D5
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 08:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F80B3D890F;
	Thu, 18 Jun 2026 08:13:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054C93D8100
	for <linux-nfs@vger.kernel.org>; Thu, 18 Jun 2026 08:13:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781770414; cv=pass; b=CE7awZYfAwDh7LkTq5eGGWq8v3sQNfR44N3moCdcUnVC5KlLHTzXQTB5ZVBbhHc3oSzT490KwUZTN8TdYjs2ESu0jw+Nz/dS8QfkZTkxh+0zZ48IUo25ncdUXe+9ywa0/jqMD9hOsztAFpO+1PEjPB7BYzhlK78LVNNiPJa5oGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781770414; c=relaxed/simple;
	bh=tGFxgeufEKgpkwTjkS/YhE5VF73b157szUC1O8nnDWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pm/vLsBRfo7B9MXXz5mYHMcoqD1MrAXkC/AxvrNNpAzSGc6rypsSCh6if0PRKXn1w3mZZZGZPwSKsPpxbV6VTLtizKZ6SxzzGH7SCnGUuDe92GItGONOFci5KbonSV0blH1GOQ7Aipxo5DF8Vf1MyRHD771i3xhwajKeWU31h5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5yDe5cO; arc=pass smtp.client-ip=209.85.218.43
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bed2b9bfa02so82249066b.1
        for <linux-nfs@vger.kernel.org>; Thu, 18 Jun 2026 01:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781770411; cv=none;
        d=google.com; s=arc-20240605;
        b=YuABnj7yI4CMu0mh7cUD1LDLzm4zgT6u6m7fq3zj3aYRVwr9cylOsVG0cOKR4qfDVB
         Nd+d6DZM6Yz43eYzuboKU7OWT5XSugpLtQpSc7IMMsE4gaPJQLjann1//bfi18tZ9jt0
         szjwEjVjp0oybiBmHI80YpIxzYoEVJZg/dZD6cSIwVYo10g10dGWLpJvti8gvmuOGQMi
         8zW2f2Fk2Enm620tYDWAcZlxRP7S/cNRl3ouYrM/d94FuGItxlD8Xm/xkJgdTgWvd7DO
         bznAEMVQQriwrQb1kLgJ+7vmrOecv3FpnwIlybXz8+ZQx+vLmYJScPb8mhUvZ7ltH+qe
         N3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tGFxgeufEKgpkwTjkS/YhE5VF73b157szUC1O8nnDWc=;
        fh=HG5m93OzHBNggPCNqjZ4+J6PqoeonHotO3C3wMyQwhw=;
        b=Xa+ayKXRLORHbNrDHnqXaPSaH9/7gso4FXAemdIbcWAeLeqW6eEKYh/WQIZCIPSXuQ
         9oWP2IxJt96Rnj7bO7K2OMCmgsN6rUH8cOxrZ/OP6t4HKLZopjj1NqoeVCyzGU96Vgyh
         fNVcs5KIJNxbsCxpEugRVajET2b1V8ip2mgwRRbtdXB26tyIXOAwG8S+XCRhGIhP0JSm
         H7E7JhvB55OGu1EelpJuvXQRKGNEorG5qXdMAqu5/9HiDRTQtU3Ucv/qJ3eBRkI7Kwru
         ZsfpEqFErXF8wZkS0QawXFQzABFZk/1hpiDz6iQxcKfh1HXRslQ8w91QZ2OvHPBKO+A5
         +YSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781770411; x=1782375211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGFxgeufEKgpkwTjkS/YhE5VF73b157szUC1O8nnDWc=;
        b=N5yDe5cOcVEmgb4yrjZ7syypAspi05Sm0r4/mz5UNlr6D0K/SkkjWI55wqUj2Spwaz
         darH/eyNrhTBHlnESwetaiy1xln2/LR6a0saADwO97arKIcD5uRdZsJjwSwAZMGiMgKl
         HPrd58ySXxTk5Y6Q3QWIwvK82V34ucxEWLXc/+y56QM6RdpR2XwFfvguYfPsGxeF3jU2
         hdZGgxOhPggTHQquGBcHxSPd317SKK+Jx+QA07CG7TaxEoaapGEeFl+1rTFxDGRXUCfV
         oGb1OIcWWYho/7YAZ3mqKbovbJ5gRJA9oN6WiMdaL63EGsJg7vQQp/XCZBdtrbCiBVy1
         8efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781770411; x=1782375211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tGFxgeufEKgpkwTjkS/YhE5VF73b157szUC1O8nnDWc=;
        b=egPonsMmq9D5SpPx1wlMWQTuPOuhfMgNl/RQIDde39VItbz7P2bOfgFbQ3tt0GgOXS
         rFMwTawZ267Q8TkaO5TJHtN79BhCDJ2zmqWxR8rO4XBOUX0vl7eKRSebhv4p0hDZtNWO
         74s9/xowS4CGRNA4eyL9vJAzNBJJrNLIvzkqVPCQawkSXHd6zAQAvlbxr40cpdP3+1C5
         WazhPeuHygyxhLJsXn26GteoBx+ArRZNtWdCJJc5pO2JWr2sdFOvyeiOddbkeXP3QpZh
         oc1yqnvnLVuQUecHsCQgpd0bl3OZ3uhhNfyONDGLBIJPg7RAbgrdiHVC31Di/UE7gtbR
         qs4g==
X-Gm-Message-State: AOJu0YxmKHaENG/ESnk2kjFa5ni6OjgNqE2or+OD1BrDuIenifsuNg55
	ThRDMnDDEi7x/046zGioIf4CQRD/qomJqvY56YEb+MkPuFDe7SIlb7T6ioB9Ll/0IxtczkJs1/v
	+gpP2oxfgGRrkOO2OXN+Cw10+q/oJVjI=
X-Gm-Gg: AfdE7cnWirkIbZ+kBt82kGyP0xbyx4hQQHyu2SzVOO3Wee5GI6v5E55HopSY7MnNnt9
	MtSgg5N8uF3iVqg2vJR71+KKnvjuVUXGgCeOIJRuE3bdHsO0ORqk4RxV4BYBPa5c8U6t/mxtdMX
	Y5UPR/HtzW2bb1UeO7cSnVwGBPFUq+TVod1u/qTdl74evTWZuNqDdSkFqi7kui9cbtEEeGw5GtO
	AzYfVfkX1Qvmd2josrLmdbQC57EwIGkW0mukN1Zk3OUrUeheOecm+srMvLVFH1u7yKlFps=
X-Received: by 2002:a17:907:5ce:b0:bf4:1188:f288 with SMTP id
 a640c23a62f3a-c0749e741aamr122225266b.17.1781770411124; Thu, 18 Jun 2026
 01:13:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=py8E7Rnd4C-1vMHMw2_dMxS_Cshy3hcbOEXzaO1pVqLQ@mail.gmail.com>
 <9ec7f349-c7f5-4936-9750-1f14dad394bd@app.fastmail.com>
In-Reply-To: <9ec7f349-c7f5-4936-9750-1f14dad394bd@app.fastmail.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Thu, 18 Jun 2026 13:43:19 +0530
X-Gm-Features: AVVi8CeJWGxZFEtMACCXq5J2Jj1SWNQa3iJS7FPUwL7diGqxO-H0Aq7M1EvCFkg
Message-ID: <CANT5p=pdsjaqgPKD2wpzQRKoG0njmPuZgVzjbNSAcdex6+zi1w@mail.gmail.com>
Subject: Re: Status of delegations feature in NFSv4 client
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:trondmy@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22667-lists,linux-nfs=lfdr.de];
	FORGED_SENDER(0.00)[nspmangalore@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 648B469E5E4

On Thu, Jun 18, 2026 at 12:44=E2=80=AFAM Anna Schumaker <anna@kernel.org> w=
rote:
>
> Hi Shyam,
>
> On Mon, Jun 15, 2026, at 11:55 PM, Shyam Prasad N wrote:
> > Hi Trond,
> >
> > I wanted to understand if the file delegations feature on the NFSv4
> > client is stable enough on Linux to support it in production
> > environments? It looks like this feature has been around on the client
> > for a really long time now. We tried running some workloads and file
> > delegations offer really good perf benefits.
>
> Like you've said above, file delegations have been around for a long time
> and I would expect them to be stable for production environments.
>
> >
> > At the same time, I'd like to understand about the stability of
> > directory delegations feature on NFS (I understand that this is much
> > newer and only a part of NFSv4.2?). If there are gaps that exist
> > today, please let me know. I'd be interested to submit patches to fix
> > those issues.
>
> Directory delegations are still fairly new, and are used with NFS v4.1
> and v4.2. We have recallable directory delegations as of Linux 6.19. Work
> is underway for supporting the CB_NOTIFY callback, which will hopefully
> be upstream soon (I have patches written for client support, but I need
> to find time to clean them up a bit more before posting them).
>
> I hope this helps!
> Anna
>
> >
> > --
> > Regards,
> > Shyam

Hi Anna,

Thanks for the reply. These answers definitely helped!

--=20
Regards,
Shyam

