Return-Path: <linux-nfs+bounces-20810-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNI1Hxoa2WnfmAgAu9opvQ
	(envelope-from <linux-nfs+bounces-20810-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 17:41:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D913D984F
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 17:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 185C23111BB7
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 15:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813463DA7E2;
	Fri, 10 Apr 2026 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="JqpLazwN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com [209.85.160.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DC43DFC6A
	for <linux-nfs@vger.kernel.org>; Fri, 10 Apr 2026 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834616; cv=none; b=AyCVcc7ZmHZPl1/0Ho9QYQu1HtibOoLwuR5ObowosLtrhZiwphggUwoc7qj9hHU3cgBn7aI1/kTBi38I7x9V4V5Kdorbetu1kLzPmHJm6yLXkedt3Wvny/mZFxz4m+CspOQ13K/2HIVxGI8GZaVve3hEIBWrzy1GWocgsc0oyE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834616; c=relaxed/simple;
	bh=CX/afSL3JndHOadfCDz6NirV/Ipq9GJ1Gx/oudX9N1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okNVAYdWnbDA391lLcZmilaZbWa5TBMHQEnANBnzesfKAJIu/qPuGqUpfAOL0w0T8aC1R7Ewe4LlDwbJab9FPu07Qo9iQv0TqduMM+AIQ+/Wvsd0zWtaOvOgyfaWf9BUjv68h/3CVI4YN70+xSEd713IijHLdmE4FbUy/hUHi+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=JqpLazwN; arc=none smtp.client-ip=209.85.160.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Received: by mail-oa1-f66.google.com with SMTP id 586e51a60fabf-41708f6c3feso1247932fac.3
        for <linux-nfs@vger.kernel.org>; Fri, 10 Apr 2026 08:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1775834614; x=1776439414; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fIc2HwqWPzjUPuL2nhb2eQ8tXBlv10wG3oq+cPrw4L4=;
        b=JqpLazwNKIPmEjk150Sn726iocN/UzH2Bqyv/VdIYp6/AKqQ8mKQWpPgQvWVebgAqG
         ETJ+OR8Fy/Kc6TgdtbE8zvlb5cdyqySq01M9kmSg1SvqVTliGX0tyVd9o6oVIQ2kP6+u
         BazFIVM+Re/Jotjcq0zwCsmcOXDlnibokzksPDgUNv0j7E69u1TZkxYodaInM+DmTUSA
         UAbaasFKvuf9aYzFeFfBd7OjS8KXVjnew6FSkjUrBwIFJg22OoJPFR/2TqCAFDPvvidx
         WlRCbOocn94LrTEEdjJnJnMdHBEmF/Ay7s+O+kOmbjytVk8ACl4J6ob/u1p3vutCWu2T
         GcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775834614; x=1776439414;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fIc2HwqWPzjUPuL2nhb2eQ8tXBlv10wG3oq+cPrw4L4=;
        b=owKxmH0JYCGFzxvz3NvNFAcciXMYiTp2NFIkWtfhDNee8ca0uKdpW2zXSgI9JkS/Da
         +oWtZzws2bl6LZd+lbQX/2VCPdIzMFvICwvAHCjQgEDSQrz0PDQENcUpcjP+GOKh9wYw
         Xx44TCfvGlj6hxrGs1ZQ5s4QUgoQTpfxrAQg5y5K8g90WhTTXW40YCwhJRpR0oVlYx+x
         lpfFyjYOw1PT6MuYsvJMZ2BGRYzSrjvn9+iacGdQi9zgLb8QolqBe6kHeo9p9nGheGP5
         fzb3mptWVNaMWDRkpmr0wfp3S05FWh2Hj0gdFFcFW/sPpN6vp4LwbzPGh1VuMPsu/BJo
         BGXw==
X-Forwarded-Encrypted: i=1; AJvYcCWJpWeGo17+EheqEbTOmhB9TfXO3QQZEdSPLmPfAn/G2WSsFEFONHpsk+eaF16a2/BgVIOct7adqpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzVhPdxtDIyLAXf0DIkq5iAjojEbAXAhaF1vCQicN5cyCkkBeG
	sD/s2j9Gx+MV00va44Nz1HbfgPYnHwnp+X1Bi6ZfOp/E21GAdWk9oBFFYkB/mhBglRA=
X-Gm-Gg: AeBDieuIAOQo9IwclW9A1o5sz2YyJrnvvedOue9n3/9eOyyTSgiE+/raZvN22g7B6Uj
	98IOys2xgzHN3PCNLvld0YplEpLkbuaJW4WywxY/Tl18NHmqfzXH5IW0xoU4YHGVm5kmtm2v9u2
	LLnAMQ7oZCrCLXifB53zxFkPM3+HCvzCfugoDurrIpfAzipJzW+rN0xPGIZGNo9Hl1CEG3tuvct
	cTimxwTd9mUeVquoE2k1pgTXpVFnLlrMu1E4ovtXOMJ/EPJGJus7QgeDl2tApDY0x8WoGSh9iAQ
	ASkjM+YvJFKRrcb1wvtEYxqKbIW/spNUgEuwWOfwwGibwEVtGAalUGz48EdrSf5nDcH/NL0o7vh
	+ob/yd5I3ZumYbZcU6axCEff/pFM5GC6DjD+eSU6gKgRwwoIDd6fVKpKxJgL4eo56o5xwgToXz0
	lA3GPYrBfJQdpmD8qxzimjsPBtKddkSCqA0iY8l2GaZew=
X-Received: by 2002:a05:6870:2417:b0:41c:890d:d776 with SMTP id 586e51a60fabf-423e0e6f333mr1927283fac.7.1775834613958;
        Fri, 10 Apr 2026 08:23:33 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423ddb23a9asm2398566fac.10.2026.04.10.08.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:23:33 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Sean Chang <seanwascoding@gmail.com>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v1 2/2] NFS: use unsigned long for req field in
 nfs_page_class
Date: Fri, 10 Apr 2026 11:23:31 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <F701DA6B-3D88-4EF6-AD22-5B93B7809E6B@hammerspace.com>
In-Reply-To: <20260408161428.155169-3-seanwascoding@gmail.com>
References: <20260408161428.155169-1-seanwascoding@gmail.com>
 <20260408161428.155169-3-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20810-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:dkim,hammerspace.com:mid]
X-Rspamd-Queue-Id: 37D913D984F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sean,

On 8 Apr 2026, at 12:14, Sean Chang wrote:

> The nfs_page_class tracepoint used a pointer for the req field. This
> caused Sparse to complain about dereferencing a pointer marked as
> __private within the trace ring buffer context.
>
> Change the field type to unsigned long to store the address of the
> request without dereferencing it. Update TP_printk to use 0x%lx for
> consistent hexadecimal output, allowing for unique identification of
> requests across the trace log.

Probably we don't want to bypass the %p formatting because some
configurations use it to obfuscate kernel pointers.

I think in this context the __private annotation is incorrect.  We deref the
nfs_page pointer only in TP_fast_assign() which runs at the call site, and
the TP_printk only outputs the pointer value.

cc: Jeff

Ben

>
> Signed-off-by: Sean Chang <seanwascoding@gmail.com>
> ---
>  fs/nfs/nfstrace.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> index 9f9ce4a565ea..4150bbd99cfa 100644
> --- a/fs/nfs/nfstrace.h
> +++ b/fs/nfs/nfstrace.h
> @@ -1496,7 +1496,7 @@ DECLARE_EVENT_CLASS(nfs_page_class,
>  			__field(dev_t, dev)
>  			__field(u32, fhandle)
>  			__field(u64, fileid)
> -			__field(const struct nfs_page *__private, req)
> +			__field(unsigned long, req)
>  			__field(loff_t, offset)
>  			__field(unsigned int, count)
>  			__field(unsigned long, flags)
> @@ -1509,14 +1509,14 @@ DECLARE_EVENT_CLASS(nfs_page_class,
>  			__entry->dev = inode->i_sb->s_dev;
>  			__entry->fileid = nfsi->fileid;
>  			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
> -			__entry->req = req;
> +			__entry->req = (unsigned long)req;
>  			__entry->offset = req_offset(req);
>  			__entry->count = req->wb_bytes;
>  			__entry->flags = req->wb_flags;
>  		),
>
>  		TP_printk(
> -			"fileid=%02x:%02x:%llu fhandle=0x%08x req=%p offset=%lld count=%u flags=%s",
> +			"fileid=%02x:%02x:%llu fhandle=0x%08x req=0x%lx offset=%lld count=%u flags=%s",
>  			MAJOR(__entry->dev), MINOR(__entry->dev),
>  			(unsigned long long)__entry->fileid, __entry->fhandle,
>  			__entry->req, __entry->offset, __entry->count,
> -- 
> 2.34.1

