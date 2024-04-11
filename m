Return-Path: <linux-nfs+bounces-2770-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FAE8A1FB3
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 21:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F8228323E
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 19:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0868205E39;
	Thu, 11 Apr 2024 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="VEPL5QRB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52C9205E11
	for <linux-nfs@vger.kernel.org>; Thu, 11 Apr 2024 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712864796; cv=none; b=ghTK+ILvztf6WIr/E8++akml/qP3ihjGLI9WFf6Q+f+x8JfohnplBTlixFexRWQ1883PcwvuSbXZicwLKbkzShGeq24XEJLGcTFl46O5dY0J3gL0IfPoQ9VSoM9OfUJ6+8fCVzIkNXXsUQNjkaNRodDHrQyFX4eYh/ZD675dGMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712864796; c=relaxed/simple;
	bh=MmwMn+R3jGuTNkftGdjHjZrXI8sqNmI33W4Sd365Dm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxrU08eYFdW1Fs1U2vz8rP7ubItemdwet8QGCXvxnYnw/+xwdiHLJkVmBUQuKTMTJvSO6HsHZFB4Xa3oosQBNGybXlNi6BM1o2hHOk64ZMWFPLI6qpqKWUL/U1sE4Bs22TQzlfjmTIXs+9KBDiMiYedMIfYX852owJifhpD44oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=VEPL5QRB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-417d092f2ffso1663325e9.2
        for <linux-nfs@vger.kernel.org>; Thu, 11 Apr 2024 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1712864793; x=1713469593; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aOhM2dvsCDLmjEZ28bJiL7x6f9hWgevBgvmJdQBjiMI=;
        b=VEPL5QRBkDrLoLJ+zG//FW8HUGJxOTjB6WK/VZaB56oYyVU2go30qvEjYuzBhGHmhE
         jzL1EQAPDwJBGzTrh6nzyc170DYIo/wPJw3agozgY0yMZp6FLztOGNbVkW127/uMtfY6
         S7eIbEVRs2gaTub4SWdoBNwKTlfpBY2OhQXbiuyReHYem2UekKVh1vAhTPb4INxL/F8a
         H0kd9ESPjzc68o5UHwAX6XcIyJFI51b7MZLJfkiIazJ7Gd4iC7kqXsBM1pZMyNA0axvQ
         ruC/i00VKQJuCVXjI8hQDQvFUJicQ1Ld8oKA+f6RROucheZGHFJsUCv3SAKtsk7JOllV
         6Fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712864793; x=1713469593;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOhM2dvsCDLmjEZ28bJiL7x6f9hWgevBgvmJdQBjiMI=;
        b=STNnFZ7zmGJ0Etyi0GW1x0qiB+9BHdNC2VaweJ5kqIjP8y0mf6/wwo7nZQnZ3f+Ezm
         5BlE0jR61TQUgOi4O8NwYFDW0xGxEf8cV3AgMAK8/8sQgl1m/0SY+OrsgT/U284v9upO
         UkqLLeoFE7M1KP5GuoVI4RJdbT99Y+eOrUrrLVXTtpalm+pt/sQWRjl8KqSYA2uJ0u73
         3QVIQ/kgVhgPBDxIWhm9Wh2Hc3ZJNKjBD7bONeINuU1eWaDeSz+ZPhvu7qxb0DqQDXIv
         aAcDtKBELQcqlZw/7/bJh8aPbap0n7zaAQYcEzFIljPon9Bv5M6tbCJIdrP4IWoG/vjh
         857g==
X-Forwarded-Encrypted: i=1; AJvYcCUzE+Nhb2WFraZ1ckdt/h3Vu5xVO9zXLCcw/nXLHb93d52t25KL1aoXPj6YLBpPSPfD/72PrXuscG/jk99pIM2DoUCuFSBekLRw
X-Gm-Message-State: AOJu0YwIbAtiV9qJro5F/GMK2JP+gFgfGWDteroIiOOGyDiVVGHALVma
	RrOKdG0/455Lo8+Of7v2NygOPGvSqobIsUcLCehpwf7fDC8L1OAIzljvCXGa7tY=
X-Google-Smtp-Source: AGHT+IE37iH2WSYkywOj9Lc95SgVke1gf755a6B7h8FxB0Dt8bkZ7yriQ4LP+nLs1E/NxN0Knzh7bA==
X-Received: by 2002:a05:600c:4e15:b0:415:6d51:8f8f with SMTP id b21-20020a05600c4e1500b004156d518f8fmr464995wmq.15.1712864793049;
        Thu, 11 Apr 2024 12:46:33 -0700 (PDT)
Received: from gmail.com ([176.230.79.119])
        by smtp.gmail.com with ESMTPSA id jh4-20020a05600ca08400b004147db8a91asm6291716wmb.40.2024.04.11.12.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 12:46:32 -0700 (PDT)
Date: Thu, 11 Apr 2024 22:46:29 +0300
From: Dan Aloni <dan.aloni@vastdata.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "bcodding@redhat.com" <bcodding@redhat.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: mount options not propagating to NFSACL and NSM RPC clients
Message-ID: <20240411194629.mmrl5nrmkzffwgfq@gmail.com>
References: <20231105154857.ryakhmgaptq3hb6b@gmail.com>
 <80B8993C-645D-4748-93B3-88415E165B87@redhat.com>
 <20231129132034.lz3hag5xy2oaojwq@gmail.com>
 <8FDECCA5-80E0-4CB4-B790-4039102916F0@redhat.com>
 <20240410143944.srhfeq6owfvdxcci@gmail.com>
 <5D6491EA-53CF-488C-B1D6-A77A8CDFFDC8@redhat.com>
 <20240411163628.jtnhu3pxgcskvel6@gmail.com>
 <8357f330100e840094b0193dc5e324e1d1b25a7e.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8357f330100e840094b0193dc5e324e1d1b25a7e.camel@hammerspace.com>

On 2024-04-11 19:08:13, Trond Myklebust wrote:
> > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > index cda0935a68c9..75faf1f05a14 100644
> > --- a/net/sunrpc/clnt.c
> > +++ b/net/sunrpc/clnt.c
> > @@ -669,6 +669,9 @@ static struct rpc_clnt *__rpc_clone_client(struct
> > rpc_create_args *args,
> >  	new->cl_chatty = clnt->cl_chatty;
> >  	new->cl_principal = clnt->cl_principal;
> >  	new->cl_max_connect = clnt->cl_max_connect;
> > +	new->cl_timeout = clnt->cl_timeout;
> > +	rpc_init_rtt(&clnt->cl_rtt_default, clnt->cl_timeout-
> > >to_initval);
> > +
> >  	return new;
> > 
> 
> That ends up clobbering any timeout value that gets set in the
> rpc_create_args, and open codes something that is already being done in
> the call to rpc_new_client().
> 
> IOW: I'd much rather see us default the value of args->timeout to that
> of clnt->cl_timeout.

Makes sense. I confirm the following fix works for NFSACL and preserves
the current hard mount behavior for NSM. Other callers to
`rpc_bind_new_program` are unaffected by this.

However I am not sure if restoring this behavior is desired for the
other call sites of `__rpc_clone_client`, which seems to be NFSv4.x
users, so I left that part out. Should that be done in separate patches?


From 8715ef1d574970176e9ac87a7e826ad74f8b910d Mon Sep 17 00:00:00 2001
From: Dan Aloni <dan.aloni@vastdata.com>
Date: Thu, 11 Apr 2024 18:30:56 +0300
Subject: [PATCH] sunrpc: fix NFSACL RPC retry on soft mount

It used to be quite awhile ago since 1b63a75180c6 ('SUNRPC: Refactor
rpc_clone_client()'), in 2012, that `cl_timeout` was copied in so that
all mount parameters propagate to NFSACL clients. However since that
change, if mount options as follows are given:

    soft,timeo=50,retrans=16,vers=3

The resultant NFSACL client receives:

    cl_softrtry: 1
    cl_timeout: to_initval=60000, to_maxval=60000, to_increment=0, to_retries=2, to_exponential=0

These values lead to NFSACL operations not being retried under the
condition of transient network outages with soft mount. Instead, getacl
call fails after 60 seconds with EIO.

The simple fix is to pass the existing client's `cl_timeout` as the new
client timeout.

Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>
Link: https://lore.kernel.org/all/20231105154857.ryakhmgaptq3hb6b@gmail.com/T/
Fixes: 1b63a75180c6 ('SUNRPC: Refactor rpc_clone_client()')
Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 net/sunrpc/clnt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index cda0935a68c9..07ffd4ee695a 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1068,6 +1068,7 @@ struct rpc_clnt *rpc_bind_new_program(struct rpc_clnt *old,
 		.version	= vers,
 		.authflavor	= old->cl_auth->au_flavor,
 		.cred		= old->cl_cred,
+		.timeout	= old->cl_timeout,
 	};
 	struct rpc_clnt *clnt;
 	int err;
-- 
2.39.3



-- 
Dan Aloni

