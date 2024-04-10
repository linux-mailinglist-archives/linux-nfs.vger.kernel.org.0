Return-Path: <linux-nfs+bounces-2740-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B9C89FA78
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Apr 2024 16:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18EAA288675
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Apr 2024 14:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498B115EFBD;
	Wed, 10 Apr 2024 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="dcvrfBEg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D79B15ADB0
	for <linux-nfs@vger.kernel.org>; Wed, 10 Apr 2024 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759991; cv=none; b=s2cWtikt3je9d6KTBFPK0b+JbsfWgBudE6tKJeyFfkM4k3soGMTHeVCiqwg7zajb1vwJD1FeKSObbUWctjLsevl75tMTKLn+NulRxOQTSg2TR38Z4ZV3M0UI9I5x2rC6CPctGnK7Mts8fFmDhCnW85Vb0Sogtzzv1g9DLbzaIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759991; c=relaxed/simple;
	bh=tBcXuYggu7BnBoxGeaYw5QHlFZIBnNzLsLf9jFcYv5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwwYJ99fjkhEO8wwMbjbUVuu0YFS9ZuLMuUerSbDrx7mxoHtJHo+kExf2zka3jKaGZ5Wug7KSbjsPFiL/jDYED1bkgYwlVNMpJkHJeCWWT0d7oOHYr/YJ9lOU59SD8JZtyjVjpGKC4P6hg50CIBE2CwEv+3+/PXU9gTdXyrPBco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=dcvrfBEg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4167fce0a41so17601465e9.0
        for <linux-nfs@vger.kernel.org>; Wed, 10 Apr 2024 07:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1712759988; x=1713364788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LMaOWhDW2JoqZtQfl6kBOhmssDpeUgIMrsUqhwgNXvo=;
        b=dcvrfBEgZQEn1IsUW9EVDQWpAbaBO/b+OEgvmXeKoP/4vrHmLJf5q/j4WWUw6aOojN
         xoKAZddcPf/Lm9JmpguL6AhKA7xUwXj8meyxGyA+1KukHkV/Y31N0Vdv2exuiSM83ioL
         GdyjNJXj3s1tiRXvAJwuU/8qcS1GclAhpSY+JrGNPF5iQ4jmc8Vvne59ftQgHi2NAulZ
         icVnf90xkYNhkfRl+cLR/mufNXs9PGLXyUog66Rc+NtMOpMPCkAH5eX1STqCiaGkraYQ
         CXqS4cPKhZ/cywhi3WmpkOLwZH4MaxJIFO8A26+yDe7Z3B71qX4i0SmvJSgWHrL7XbCD
         ZcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712759988; x=1713364788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMaOWhDW2JoqZtQfl6kBOhmssDpeUgIMrsUqhwgNXvo=;
        b=HiDq9hMqI+/ps1esboL1VRdlvKmyMKa9APbKqfsGKmTWit1CDcKvTcSS5/R8otCKYp
         2R3YhvAH3IThOH0C2SZDVXWHvIu/9+L5PRa62/n8o1PFMJC6vFDbKM2XXFL0RoVJBIxW
         tiG5TgPXb1C8dG8vAJekkKfy+5PtNEdh4IDZ/fENEezJ8zD77x43Vhkc1mNzP/0Vr74S
         le5JNNFU3G7qtV7BeWEd52EfG0MbTf3PHaN3BPTyeIY/Y3AMYGTciomfohf6K8DZS3jY
         igL7AenxAooSn0FrDA3p45am4lsSapObUQsq9yWYRgsZQlWIVDP0/085AJNKZkU7zCb/
         Gagw==
X-Gm-Message-State: AOJu0YxoBhZdccfu2dV8lfmH4hUggbwETVLbRqzlcRzZNkmwkeMjNWNT
	XSvH3VZsYLDwux1zcfa+lXsMA0dqrYkRpP1ktPQj4euHEV52bpxg3dhsfc3uv/g=
X-Google-Smtp-Source: AGHT+IFQaD/Hbwsz9UwnHeKI7w7ehdLnwl0SezaAP++P+2sNQUnMqQAUnTvc+jHw0NKirbT6SkxDkA==
X-Received: by 2002:a05:600c:524e:b0:416:8091:ba4 with SMTP id fc14-20020a05600c524e00b0041680910ba4mr2712037wmb.6.1712759987663;
        Wed, 10 Apr 2024 07:39:47 -0700 (PDT)
Received: from gmail.com ([176.230.79.119])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b004168efc77d1sm2463764wmq.39.2024.04.10.07.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:39:47 -0700 (PDT)
Date: Wed, 10 Apr 2024 17:39:44 +0300
From: Dan Aloni <dan.aloni@vastdata.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: mount options not propagating to NFSACL and NSM RPC clients
Message-ID: <20240410143944.srhfeq6owfvdxcci@gmail.com>
References: <20231105154857.ryakhmgaptq3hb6b@gmail.com>
 <80B8993C-645D-4748-93B3-88415E165B87@redhat.com>
 <20231129132034.lz3hag5xy2oaojwq@gmail.com>
 <8FDECCA5-80E0-4CB4-B790-4039102916F0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8FDECCA5-80E0-4CB4-B790-4039102916F0@redhat.com>

On 2023-11-30 09:30:52, Benjamin Coddington wrote:
> > Actually my concern is the NFSACL prog. With `cl_softrtrt == 1` and
> > `to_initval == to_maxval`, does it mean retires will not happen
> > regardless of `to_retries` and `to_increment`?
> 
> Possibly?  I'm not exactly certain of what should happen in that case.
> 
> > I encountered a situation where the NFSACL program did not retry but
> > could have had, whereas NFS3 did successfully. Not sure regarding NSM,
> > but it seems to me that it would make sense at least for NFSACL to
> > behave the same as NFS3.
> 
> I agree, but I could be missing something -- maybe its a bug.  There's the
> sunrpc:rpc_timeout_status tracepoint that might be helpful.  If you turn
> that up can you see rpc_check_timeout() getting called from
> call_transmit_status()?

Sorry, took awhile to get a test working while busy on other stuff.

So it looks really like a bug, here are the details.

Server: nfsd with extra fault injection code that calls `svc_drop()` only once
on a single NFS GETACL request.
Client: Linux v6.8, NFS mount with `soft,timeo=50,retrans=16,vers=3`.

I trace client execution with the following:

    sudo perf trace -e sunrpc:rpc_task_timeout -e sunrpc:xprt_retransmit

A simple `ls -l` gets stuck and shows an IO failure:

    [root@client export]# ls -l
    ls: file: Input/output error
    total 0
    -rw-r--r-- 1 root root 0 Apr 10 10:02 file

I get a single event out of the tracing above:

```
kthreadd/7926 sunrpc:rpc_task_timeout(task_id: 203, client_id: 6, xprt_id: 3, action: 0xffffffffc0accc60, runstate: 22, flags: 35456)
```

So looks like the request is not being retransmitted. Just to be sure,
if I cause the nfsd to drop the regular NFS3 prog I/Os like ACCESS and
LOOKUP, I only get the expected 5 seconds delay following a successful
retry.

Seems we only have an issue with the NFS3ACL prog.

-- 
Dan Aloni

