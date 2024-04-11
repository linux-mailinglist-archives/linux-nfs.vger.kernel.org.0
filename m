Return-Path: <linux-nfs+bounces-2759-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E408A1CB8
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 19:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F341C239BB
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 17:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EF93FBB2;
	Thu, 11 Apr 2024 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="J7fHRs4o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7FD127E3E
	for <linux-nfs@vger.kernel.org>; Thu, 11 Apr 2024 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853395; cv=none; b=ORLkQZHvW6meQJA5+rPPmIxBnML4er5M+MUpW3AgwfrnxVKg08eIxrRZM2A73HtURjgKJWpx8ZMMCceVZ+S4684221yYu5/qWRpVIga5xzTbdL3mM1C8g+en3OEfhd4UObs5l2BFV1LBEEsO8BioB6HSgTn9sZ2DRu6G9IvoRK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853395; c=relaxed/simple;
	bh=Zi1+irZQ0zTzcJA9dVgM68oZG0DkpVuWDsRWLSLSY2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qK9KlF4AcHyLFFwsPOPr4QSgHD/P3VI0kU8+o5pYjmNeELgbXo7hX81cNivdhesCpZ3TuW9xuYHQjVRtr5AMkqwlnPM7D8LZrBZzpSlX8w5rtLfjdpvrwY8ReIDXyIpJwNWKIVe6Zrxme8ApWUx1enzdP1SGv66vw1ZHohqvsrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=J7fHRs4o; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3465921600dso1960883f8f.3
        for <linux-nfs@vger.kernel.org>; Thu, 11 Apr 2024 09:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1712853391; x=1713458191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AMOPJIXcqYBB1775oC8vFGEZ7mBsWQHfc0E4/OuVMJg=;
        b=J7fHRs4oFFVqAw99y1Ty5T+lJGTagpjcvcmte2oiPMqNFad5Ui0cUD7mXK2XfZahNy
         tCrOZCqZ2+rgSNxe8CKWwvh/J3BZAGlLx6eh9PXIgslT3F9ryAuFjgUW6bFZwzeU/3tL
         zCq9ylhnamafhHy2B5ywzmMB9RxblVNeRo2MtYOc0XftxF1W2XgxCugyUxaMXwv2vOQV
         5nApx2+56m/RYfkWBc+4u0XbGF4d4xyPqpJ2geWfhm84FAPgMfuwDdZrLzE5KqiBTxys
         ZKWgGdPIueDwqoqRbrG3PuacOHB9lNluCJcz4P78RhyKTAkxg5tpgyzuoifnrzi8lxMZ
         QHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712853391; x=1713458191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMOPJIXcqYBB1775oC8vFGEZ7mBsWQHfc0E4/OuVMJg=;
        b=Tphfh6CFQGHRCreeJq+rPSjFrzZiMGpAM+Wk6JXI6+kOP74EJmzZKZakZ0dmV4+ryb
         68rPKSiViVZaTXruqlcgAEcAg0DIWWckCKj++llV9ly+yZVDEfKEu4j6PIaw+9dGmcbl
         G5vehWvOL9H1XugC6ueon7bQuCOORfO+3xNrKnzD8FAz1xaJnGFdkOLGd2JDbuaft2g6
         P1kmfOODmVakUP0XvI2W8BpcQNLWgoPRKlaYaePMXxlJsv8QIH37YTRKZZUav00fJwjN
         /TZ5uexTaROyxPiYIYK88B6gtLsv+uZ6uIi/nS+pUr1o9FPBptp2BDl0GfOR4U1NL/EN
         Tx3w==
X-Gm-Message-State: AOJu0YyocyV+PRBUnYbxte13FxDXyOm1QxZ/cySuIYbFyT4HuFzWzpv5
	EpwR7IUOvVDfLdw+iDrozYti2pEczU7eAapWEg7VdjdyKgTuwCM/0yjQhoDTFGuSl+zmMf28GSn
	K
X-Google-Smtp-Source: AGHT+IElcxccHkP6ktRXSOPBRoxVky5WH7w5Fsw1zBaUD7H+c0wRpbtLEVYUL3ihGCVGPiL9cYhKtw==
X-Received: by 2002:a05:6000:1291:b0:343:8e85:dd7c with SMTP id f17-20020a056000129100b003438e85dd7cmr42852wrx.55.1712853391179;
        Thu, 11 Apr 2024 09:36:31 -0700 (PDT)
Received: from gmail.com ([176.230.79.119])
        by smtp.gmail.com with ESMTPSA id d8-20020a5d5388000000b0034335f13570sm2141488wrv.116.2024.04.11.09.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 09:36:30 -0700 (PDT)
Date: Thu, 11 Apr 2024 19:36:28 +0300
From: Dan Aloni <dan.aloni@vastdata.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: mount options not propagating to NFSACL and NSM RPC clients
Message-ID: <20240411163628.jtnhu3pxgcskvel6@gmail.com>
References: <20231105154857.ryakhmgaptq3hb6b@gmail.com>
 <80B8993C-645D-4748-93B3-88415E165B87@redhat.com>
 <20231129132034.lz3hag5xy2oaojwq@gmail.com>
 <8FDECCA5-80E0-4CB4-B790-4039102916F0@redhat.com>
 <20240410143944.srhfeq6owfvdxcci@gmail.com>
 <5D6491EA-53CF-488C-B1D6-A77A8CDFFDC8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D6491EA-53CF-488C-B1D6-A77A8CDFFDC8@redhat.com>

On 2024-04-11 11:20:14, Benjamin Coddington wrote:
> > So looks like the request is not being retransmitted. Just to be sure,
> > if I cause the nfsd to drop the regular NFS3 prog I/Os like ACCESS and
> > LOOKUP, I only get the expected 5 seconds delay following a successful
> > retry.
> >
> > Seems we only have an issue with the NFS3ACL prog.
> 
> It looks like the client_acl program gets created with
> rpc_bind_new_program() which doesn't setup the timeouts/retry strategy, and
> there's nothing after the setup to do it either.
> 
> I think the problem has existed since 331702337f2b2..  I think this should
> fix it up, would you like to test it?

Please allow me to propose a different change, which I already tested.

Looks to me that the 2012 change that I mentioned below is actually when
the problem started happening, when the `kmemdup` call was removed, so
since then we are simply just missing a field copy, and we are taking
the timeout from transport-based default timeout globals instead.

Also, I have a hunch that we need to do something different, because of
the following code in `rpc_new_client`:

    clnt->cl_rtt = &clnt->cl_rtt_default;
    rpc_init_rtt(&clnt->cl_rtt_default, clnt->cl_timeout->to_initval);

Only setting `clnt->cl_timeout` _after_ client clone does not seem to be
right if there are `cl_rtt_default` calculations that depend on it. So
may as well need to call `rpc_init_rtt` too.

--

From 55737f82a9bb3e490836d10491995c8082ebcf11 Mon Sep 17 00:00:00 2001
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

The simple fix is to copy `cl_timeout` and make sure `cl_rtt_default`
is initialized from it.

Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Benjamin Coddington <bcodding@redhat.com>
Link: https://lore.kernel.org/all/20231105154857.ryakhmgaptq3hb6b@gmail.com/T/
Fixes: 1b63a75180c6 ('SUNRPC: Refactor rpc_clone_client()')
Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 net/sunrpc/clnt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index cda0935a68c9..75faf1f05a14 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -669,6 +669,9 @@ static struct rpc_clnt *__rpc_clone_client(struct rpc_create_args *args,
 	new->cl_chatty = clnt->cl_chatty;
 	new->cl_principal = clnt->cl_principal;
 	new->cl_max_connect = clnt->cl_max_connect;
+	new->cl_timeout = clnt->cl_timeout;
+	rpc_init_rtt(&clnt->cl_rtt_default, clnt->cl_timeout->to_initval);
+
 	return new;
 
 out_err:
-- 
2.39.3


-- 
Dan Aloni

