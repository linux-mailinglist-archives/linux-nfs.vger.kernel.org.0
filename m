Return-Path: <linux-nfs+bounces-7927-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0B09C6DBE
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 12:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3571F21836
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 11:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106E51FA279;
	Wed, 13 Nov 2024 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="KSrjYsXu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F651F80AF
	for <linux-nfs@vger.kernel.org>; Wed, 13 Nov 2024 11:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731497021; cv=none; b=rJnAmXgjiwhWoELtf0fZSRYlm2X89ce3ftR1B0lA8VBy8pn3oubbWz+cl2V69Nc6fq6nEFpoYgSGaQ1DLxnm/LbeDjEizR/tjPYvXwrwqAH9pVtySAyhkMBk+kF0wSdDPhT2HW61cctCnMtVsycoG4jRmZfHTSUGYA0Kc02TuVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731497021; c=relaxed/simple;
	bh=DoDyDFh3IS9W0P3fDHq34pt1Lsz6RYHMqRRXaxa8yx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwelTK7nW3FqNuhn44Ojaj+djDQAe468zmj7hvmL6VDyltG+WZ15Sf3yQFxibW+ogpamIKK8wfu+1Aqg/Ad1HYPrC+tix2bkXL3g2Pdduc6A5eIhHbCw3s7Bfm35u8ZslRLp2stT9W20UHc0xSr4UWNW10zTHmNXldJLgyv4TmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=KSrjYsXu; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cebcf96fabso8300900a12.3
        for <linux-nfs@vger.kernel.org>; Wed, 13 Nov 2024 03:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1731497017; x=1732101817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4woUHqrhDGo3dMh8EuRiSy5Xkw1eGcTvLo6PcjwYnd4=;
        b=KSrjYsXuTRk2QrrQbb0iQO1pT87CKyOEvO3VgksV6FEDwtnVnxjRduwjr/hzZWf6nc
         o9hHz+Fvet0sj+J81mAsacQacNVZgZ02WqQhzZvrxIh5/mUudWxjne+5fqG1jSs3MoAc
         auZUdmMtTaro9kQ4VHUePaBpaJdQHJ4UJdjDEwlSejSTwwggJvkyjEzLd+dfPfxDNs7g
         pNljdQu0rA77/TIlDqn5ob5FXz3eoAaEhmOUmnwb3Eqkjnv3088oZEI5B6QD2hKKGFkX
         K0viUx0Up7EpRw+T+E/66LYMvt6N9PL78gzGyhXuhqmUzX0Hh93Ons6jytNjjAsX/Ii1
         0O9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731497017; x=1732101817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4woUHqrhDGo3dMh8EuRiSy5Xkw1eGcTvLo6PcjwYnd4=;
        b=MbkWTmhTTtnbd1Mwb69Kp/epfIIAMXEk/0fGDZcIHJ52W+h6XQyyo+NrOxUzzY0NT9
         to+WO+Oc0UKddsr/qmWEnpcTaUxrxaRIX+xMi79UPpeHiy6rH/1taC69Du7rep4JUrp/
         /G7hNt18JkEQ0bC1Gv9oPPHal4pucd/NneQkEySaDAqboL1w5lkou3/yPMHv5F6knldd
         spU+JXXMlgstt4Fwe5uVsYSrGIFKLlGd4ab7Vm7H1jj523zFLu6h/EN16zDts8tc91xG
         FDk5cCGwW+f6/4k2Hr8EQqSdo/ndmU3t76iw/hBELuP0cVhOsKstFfIYSNOjslpruxDY
         oVbA==
X-Forwarded-Encrypted: i=1; AJvYcCX+3BA4+Zavahd+LkvsqOsPUZS1sli34kgVQbdSl9wjhDdjLxb4io7KOmRf0VZ3JZJpfeUngGVA2LM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlFicyQGQ5B7o2oIAnQnyaEK2d+/3UMtLPF13fF6HVHSoh9Wa
	ZdxHbZk9gnR1ZvfCoT3cjdGw25EL6YLnCxP4Ft7XXI4gkJnMgDYb1FN86IqWHQLhhfIWrLqeEYC
	ZlpiL29PnCYA2JG3pbMMiDXrcz4re0+9R/Zfleiz532xRmqpPHT/nsw==
X-Google-Smtp-Source: AGHT+IF00Gt9myofuxeh7Q1f5Oi1TlxJX2Yjjw+/P+N7poy6tXdYkxPnYOLWUZT6FLM2PnRq3d4sL0zSylECB8bmXOc=
X-Received: by 2002:a05:6402:90c:b0:5ce:fb4a:6aaf with SMTP id
 4fb4d7f45d1cf-5cf630c505emr1911486a12.20.1731497016749; Wed, 13 Nov 2024
 03:23:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113055345.494856-1-neilb@suse.de>
In-Reply-To: <20241113055345.494856-1-neilb@suse.de>
From: Daire Byrne <daire@dneg.com>
Date: Wed, 13 Nov 2024 11:23:01 +0000
Message-ID: <CAPt2mGN7is0xOqBxy62WwJ_iPXQ0fjvpv2MVEEwYqxvZSFY30w@mail.gmail.com>
Subject: Re: [PATCH 0/4 RFC] nfsd: allocate/free session-based DRC slots on demand
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Content-Type: text/plain; charset="UTF-8"

Neil,

I'm curious if this work relates to:

https://bugzilla.linux-nfs.org/show_bug.cgi?id=375
https://lore.kernel.org/all/CAPt2mGMZh9=Vwcqjh0J4XoTu3stOnKwswdzApL4wCA_usOFV_g@mail.gmail.com

As my thread described, we currently use NFSv3 for our high latency
NFS re-export cases simply because it performs way better for parallel
client operations. You see, when you use re-exporting serving many
clients, you are in effect taking all those client operations and
stuffing them through a single client (the re-export server) which
then becomes a bottleneck. Add any kind of latency on top (>10ms) and
the NFSD_CACHE_SIZE_SLOTS_PER_SESSION (32) for NFSv4 becomes a major
bottleneck for a single client (re-export server).

We also used your "VFS: support parallel updates in the one directory"
patches for similar reasons up until I couldn't port it to newer
kernels anymore (my kernel code munging skills are not sufficient!).

Sorry to spam the thread if I am misinterpreting what this patch set
is all about.

Daire


On Wed, 13 Nov 2024 at 05:54, NeilBrown <neilb@suse.de> wrote:
>
> This patch set aims to allocate session-based DRC slots on demand, and
> free them when not in use, or when memory is tight.
>
> I've tested with NFSD_MAX_UNUSED_SLOTS set to 1 so that freeing is
> overly agreesive, and with lots of printks, and it seems to do the right
> thing, though memory pressure has never freed anything - I think you
> need several clients with a non-trivial number of slots allocated before
> the thresholds in the shrinker code will trigger any freeing.
>
> I haven't made use of the CB_RECALL_SLOT callback.  I'm not sure how
> useful that is.  There are certainly cases where simply setting the
> target in a SEQUENCE reply might not be enough, but I doubt they are
> very common.  You would need a session to be completely idle, with the
> last request received on it indicating that lots of slots were still in
> use.
>
> Currently we allocate slots one at a time when the last available slot
> was used by the client, and only if a NOWAIT allocation can succeed.  It
> is possible that this isn't quite agreesive enough.  When performing a
> lot of writeback it can be useful to have lots of slots, but memory
> pressure is also likely to build up on the server so GFP_NOWAIT is likely
> to fail.  Maybe occasionally using a firmer request (outside the
> spinlock) would be justified.
>
> We free slots when the number of unused slots passes some threshold -
> currently 6 (because ...  why not).  Possible a hysteresis should be
> added so we don't free unused slots for a least N seconds.
>
> When the shrinker wants to apply presure we remove slots equally from
> all sessions.  Maybe there should be some proportionality but that would
> be more complex and I'm not sure it would gain much.  Slot 0 can never
> be freed of course.
>
> I'm very interested to see what people think of the over-all approach,
> and of the specifics of the code.
>
> Thanks,
> NeilBrown
>
>
>  [PATCH 1/4] nfsd: remove artificial limits on the session-based DRC
>  [PATCH 2/4] nfsd: allocate new session-based DRC slots on demand.
>  [PATCH 3/4] nfsd: free unused session-DRC slots
>  [PATCH 4/4] nfsd: add shrinker to reduce number of slots allocated
>

