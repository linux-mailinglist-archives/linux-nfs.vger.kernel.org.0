Return-Path: <linux-nfs+bounces-16476-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 374ADC66867
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 00:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD6EB356202
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 23:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A1D2C0296;
	Mon, 17 Nov 2025 23:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Om60ZCjO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E68525A2C6
	for <linux-nfs@vger.kernel.org>; Mon, 17 Nov 2025 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763420730; cv=none; b=QcXwgkp6lwQilQ9Julu2yJ8QKP01Cl4g92em9tIZYzELJySiMw/85b6dOGGXrgEtiwZe9v+7Q42ViOXaOmRn0x4VzonRdq130YwHSIeQ/2Ub72j5XFDHGp6xkJlJ39orqTwxG02eN0hp7nqQN3G47Nw8rL2NV6zg7UIe5opUcVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763420730; c=relaxed/simple;
	bh=FaRxgRwdMzFooAt7LHk3DQ9uc3JtOeJK8A8SgfWrESU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGs49VXS3K5wk0DASky4vwp170RX9Ot7i16Rvhm1CcOgHTpVLWlawc+wuZlJSKA+3kfXw0bFP9W43QVNwYzy9W0nqpUFj5cn/9D5uUcUt5AnZRty6ZRa6HsPQUS+Dkg7zrKqt0I+FD3NH4xFeh1SRtvrkJckDENdlKKlfv0qmJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Om60ZCjO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763420728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mc4UvANXmwZYJ80+eij7Ig7TFddWxM5fSY0xiISwzEE=;
	b=Om60ZCjOt3qelX6lJOS7pY4W7xZ1omfyd2uBb3/CSYU7iD5qeRd/K9ZBqbs04KPDuOHWHp
	CGDZ0PQaQ8yRSVVZSc0NnmowLS/YvEP3wfE5ppQTUNZ4Hukx9yNeyy+1IEMGP6s12uTJcI
	lYiJTlma+8v8ao1NZLh3rjgktxGli98=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-qIs0-poAPIu83yXeqHRSpg-1; Mon,
 17 Nov 2025 18:05:24 -0500
X-MC-Unique: qIs0-poAPIu83yXeqHRSpg-1
X-Mimecast-MFC-AGG-ID: qIs0-poAPIu83yXeqHRSpg_1763420723
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9090319560A5;
	Mon, 17 Nov 2025 23:05:22 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.81.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D155919560B0;
	Mon, 17 Nov 2025 23:05:21 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id C8C1D505609; Mon, 17 Nov 2025 18:05:19 -0500 (EST)
Date: Mon, 17 Nov 2025 18:05:19 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: "Tyler W. Ross" <TWR@tylerwross.com>
Cc: Trond Myklebust <trondmy@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	"1120598@bugs.debian.org" <1120598@bugs.debian.org>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Steve Dickson <steved@redhat.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5
 NFSv4 client using SHA2
Message-ID: <aRuqLwKjTOxWbK6t@aion>
References: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net>
 <aRZZoNB5rsC8QUi4@eldamar.lan>
 <de44bf50-0c87-4062-b974-0b879868c0f5@oracle.com>
 <AVpI5XolCCA38sGzxlfk6azQI9oUAxafUVl9B7B1WgJEmGgSAQq5nvulQO6P_RQqjBp3adqasHFsodhAAxai0dcp5scRMJk0dLsGMQeSiew=@tylerwross.com>
 <fVv3cF7Ulh3cKUP17C98gh_uOv9BcMlMpsIh1Nv5_0tdw-75PKiPJgIEP5o2jBVry7orwz7jeiGQenfCbuUxyj5JFstbx3RTFYr223qDmV0=@tylerwross.com>
 <a6d1435b-f507-49eb-b80c-4322dc7e1157@oracle.com>
 <Y79HV0VGpScPYqI_dDxeItkX2UZwSdReaUOpIeMeZXq2HLsHf5J_PTQqr7HrBYygICRsn-OB89QPrxPzjgv2smuzTThUPy_3fq_N1NprlUg=@tylerwross.com>
 <4a63ad3d-b53a-4eab-8ffb-dd206f52c20e@oracle.com>
 <902ff4995d8e75ad1cd2196bf7d8da42932fba35.camel@kernel.org>
 <ji2_uZ3RNtBdATHSokoxSrIXMAi4zh2jZXEd0WownMtXo_WNIseAeeDZoBFjT54nCE1Iw0PcGgfORC5p39CP9KGqjY6T2wqeBRGonjIjfXM=@tylerwross.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ji2_uZ3RNtBdATHSokoxSrIXMAi4zh2jZXEd0WownMtXo_WNIseAeeDZoBFjT54nCE1Iw0PcGgfORC5p39CP9KGqjY6T2wqeBRGonjIjfXM=@tylerwross.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, 17 Nov 2025, Tyler W. Ross wrote:

> Weird behavior I just discovered:
> 
> Explicitly setting allowed-enctypes in the gssd section of /etc/nfs.conf
> to exclude aes256-cts-hmac-sha1-96 makes both SHA2 ciphers work as
> expected (assuming each is allowed).
> 
> If allowed-enctypes is unset (letting gssd interrogate the kernel for
> supported enctypes) or includes aes256-cts-hmac-sha1-96, then the XDR
> overflow occurs.
> 
> Non-working configurations (first is the commented-out default in nfs.conf):
> allowed-enctypes=aes256-cts-hmac-sha384-192,aes128-cts-hmac-sha256-128,camellia256-cts-cmac,camellia128-cts-cmac,aes256-cts-hmac-sha1-96,aes128-cts-hmac-sha1-96
> allowed-enctypes=aes256-cts-hmac-sha384-192,aes256-cts-hmac-sha1-96
> allowed-enctypes=aes128-cts-hmac-sha256-128,aes256-cts-hmac-sha1-96
> allowed-enctypes=aes256-cts-hmac-sha384-192,aes128-cts-hmac-sha256-128,aes256-cts-hmac-sha1-96
> 
> Working configurations (first is default sans aes256-cts-hmac-sha1-96):
> allowed-enctypes=aes256-cts-hmac-sha384-192,aes128-cts-hmac-sha256-128,camellia256-cts-cmac,camellia128-cts-cmac,aes128-cts-hmac-sha1-96
> allowed-enctypes=aes256-cts-hmac-sha384-192,aes128-cts-hmac-sha256-128
> allowed-enctypes=aes256-cts-hmac-sha384-192,aes128-cts-hmac-sha1-96
> allowed-enctypes=aes128-cts-hmac-sha256-128,aes128-cts-hmac-sha1-96
> 

That doesn't really make sense.  You should only need to use the
allowed-enctypes setting if you're talking to an NFS server that doesn't
have support for the new encryption types.

It basically works like the "permitted_enctypes" option in krb5.conf,
except it only affects NFS rather than affecting your krb5 configuration
as a whole.

Can you go back and re-do the tracepoint capture, except this time
umount your NFS filessytems before starting the capture (i.e. perform
the mount command while trace-cmd is running).  I'm curious what values
the rpcgss_update_slack tracepoint shows.

> 
> Is this gssd mishandling some setup/initialization?
> Or is there a miscalculation happening somewhere further up?
> 
> 
> TWR
> 


