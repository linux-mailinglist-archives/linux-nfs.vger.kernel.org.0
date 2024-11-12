Return-Path: <linux-nfs+bounces-7901-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 380EE9C5A59
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 15:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C6A284272
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 14:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A851E1FE11C;
	Tue, 12 Nov 2024 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+0wVCWK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C41FE0EE
	for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421674; cv=none; b=Ds7INC8dmJyL5x1GvGALJ97j9hgu8x9qtn7KcZM5e7XdWTe7yKVTDhkYezu0DBUQgFRdprQ8784OkItUFu1zg+VqaqSkfmxx8RB8rUx2KeDvXlL/vOGAwwdEVRBEMDmGqg6235FhVzsw1IcBy5GKARkcoSRBPU/t44+BAGGlCqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421674; c=relaxed/simple;
	bh=y3P/6r6sEGeznZVIZp/oPHOO1KyKu/mTAYtictLspAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZW6LjS9H9wO9sKYvD/EB3k/TBqsVe/nlxiosrjRMVERMnLtOvswtz+5wc2strZ9UKuIwrAdnQq8U7mk/96ywrmCqzXMET99AEZMnubbsTxmcSFEOdwehlyL3fg7ncqkjcsfq+tvk3s2Sc7tPjJl4c1xnUphYZO8DU77kOm+LopE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+0wVCWK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731421671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LOQEfq/vX4Q3hU0hBhJbj/jmxhIvNDRob3OXkZQ60HM=;
	b=Z+0wVCWKGvhQgfCYNqjl1aitVhmKs24tDIafaci4CcHsMhFMwFjgT8ae97JtwjAZB0T6Ic
	Y7o/GcO4zWzjJuyPSkdHXpPJGdUPCzT0bjEJwtSnMLH7TQFcrxtblGQS1FtEMsVZVXtTvn
	AOC7mKNb4FP3QND7fxnrzLB2wCfAnK8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-t_YcUos8Nn-218Lj_51wmQ-1; Tue,
 12 Nov 2024 09:27:50 -0500
X-MC-Unique: t_YcUos8Nn-218Lj_51wmQ-1
X-Mimecast-MFC-AGG-ID: t_YcUos8Nn-218Lj_51wmQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22C06195419D;
	Tue, 12 Nov 2024 14:27:49 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44E4630000DF;
	Tue, 12 Nov 2024 14:27:48 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Philip Rowlands <linux-nfs@dimebar.com>,
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: Insecure hostname in nsm_make_temp_pathname
Date: Tue, 12 Nov 2024 09:27:45 -0500
Message-ID: <192D38BE-BC46-4C8F-8C01-89EED779E77B@redhat.com>
In-Reply-To: <6296a7d4-64de-4df0-893e-8895e8ec36d0@app.fastmail.com>
References: <6296a7d4-64de-4df0-893e-8895e8ec36d0@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11 Nov 2024, at 17:49, Philip Rowlands wrote:

> If a host dies after nsm_make_temp_pathname but before rename(temp, pat=
h) we may be left with paths resembling .../server.example.com.new
>
> Some clever person has registered and installed a wildcard DNS record f=
or *.com.new.
>
> $ host server.example.com.new
> server.example.com.new has address 104.21.68.132
> server.example.com.new has address 172.67.195.202
>
> You can see where this is going...
>
> Our firewall scanners tripped on outbound access to this address, port =
111, I assume due to NSM reboot notifications.
>
> Suggested workarounds include:
> * explicitly skip over paths matching the expect tempname pattern in ns=
m_load_dir()
> * use a different tmp suffix than .new, e.g. one which won't work in DN=
S
>
> Steps to reproduce:
>
> # cat /var/lib/nfs/statd/sm/server.example.com.new
> 0100007f 000186b5 00000003 00000010 89ae3382e989d91800000000dc00ed00000=
0ffff 1.2.3.4 my-client-name
> # sm-notify -d -f -n
> sm-notify: Version 2.7.1 starting
> sm-notify: Retired record for mon_name server.example.com.new
> sm-notify: Added host server.example.com.new to notify list
> sm-notify: Initializing NSM state
> sm-notify: Failed to open /proc/sys/fs/nfs/nsm_local_state: No such fil=
e or directory
> sm-notify: Effective UID, GID: 29, 29
> sm-notify: Sending PMAP_GETPORT for 100024, 1, udp
> sm-notify: Added host server.example.com.new to notify list
> sm-notify: Host server.example.com.new due in 2 seconds
> sm-notify: Sending PMAP_GETPORT for 100024, 1, udp
> # etc.
>
> tcpdump shows the outbound traffic:
> 22:42:31.940208 IP 192.168.0.131.819 > 172.67.195.202.sunrpc: UDP, leng=
th 56
> 22:42:33.942440 IP 192.168.0.131.819 > 172.67.195.202.sunrpc: UDP, leng=
th 56
> 22:42:37.946903 IP 192.168.0.131.819 > 172.67.195.202.sunrpc: UDP, leng=
th 56
>
> The client statd was artificially placed for the purposes of showing th=
e problem, but I hope it's close enough to make sense.

Makes sense.. yikes!

Maybe we could just prepend '.' since nsm_load_dir() ignores those - Chuc=
k, you were in here last any thoughts?


diff --git a/support/nsm/file.c b/support/nsm/file.c
index f5b448015751..eaf19cd4963e 100644
--- a/support/nsm/file.c
+++ b/support/nsm/file.c
@@ -185,9 +185,9 @@ nsm_make_temp_pathname(const char *pathname)
 {
        size_t size;
        char *path;
-       int len;
+       int le;

-       size =3D strlen(pathname) + sizeof(".new") + 2;
+       size =3D strlen(pathname) + sizeof(".new") + 3;
        if (size > PATH_MAX)
                return NULL;

@@ -195,7 +195,7 @@ nsm_make_temp_pathname(const char *pathname)
        if (path =3D=3D NULL)
                return NULL;

-       len =3D snprintf(path, size, "%s.new", pathname);
+       len =3D snprintf(path, size, ".%s.new", pathname);
        if (error_check(len, size)) {
                free(path);
                return NULL;


