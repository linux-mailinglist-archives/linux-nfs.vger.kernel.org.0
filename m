Return-Path: <linux-nfs+bounces-3129-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D618B9DDB
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 17:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF381F21187
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 15:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8DC1586D5;
	Thu,  2 May 2024 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y71Dh/yc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B481F5F6
	for <linux-nfs@vger.kernel.org>; Thu,  2 May 2024 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665290; cv=none; b=rvTKzs7R51DoepVHcxeau3szEG//Rj1FzKscSuCDGxienk/7td1h+29/0CbQwBFQrWzLDB+b8ghP3/42VlfF/wOZrWXDdsJvHJiXpg+IDa5cOhD9jsxKK9I73m8phaJ+iB4GLsgv5Kxw9DfpEKJmfb8wAu07iuV1tXi3ZRehyDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665290; c=relaxed/simple;
	bh=A5tgS/V77GNo7KieoxF77gNWbmfz8lpChnsdCWq7cZ4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VhAIhk5MKYAvHLrTjIZVCjKEevFzv7SXy7k/2XBuETyiNC+dJF6tpVT+EdMYWte+V+JAztA07slnTTzw6K9QyAFVEi/vb+QCEbrdRUNFPkWnOtJpuWrXlDK8EQyn1B416GRcCqL2AYSboqs3UxUist4AqF8Wnx5KvDky7racw5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y71Dh/yc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714665287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=bOTBYOSdNi7Ujnf5SdkGoE4cVy/D+f7QXqPt2BcgLH4=;
	b=Y71Dh/ycUyEDrGKdZlAucESxajv3J0JH9n4IsUWdGc1OVEf6SAcwazAAA75RuV2KicEvFq
	xtjLSM4D+YpdExvhYqZLeOdHE5O9LHMxyht1bVnMvKV7GNBolJq2wBPQtTJ5HbytAuRQiQ
	OUQ8n30ozKjG0M2YzTRLC23fVMr2xo8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-YfyJMfDYOBaMIlT1pGg9ew-1; Thu,
 02 May 2024 11:54:44 -0400
X-MC-Unique: YfyJMfDYOBaMIlT1pGg9ew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E52371C05AA2
	for <linux-nfs@vger.kernel.org>; Thu,  2 May 2024 15:54:43 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.16.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D8F72EC680
	for <linux-nfs@vger.kernel.org>; Thu,  2 May 2024 15:54:43 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 8139514A062; Thu,  2 May 2024 11:54:43 -0400 (EDT)
Date: Thu, 2 May 2024 11:54:43 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: linux-nfs@vger.kernel.org
Subject: NFSv3 and xprtsec policies
Message-ID: <ZjO3Qwf_G87yNXb2@aion>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Red Hat QE identified an "interesting" issue with NFSv3 and TLS, in that an
NFSv3 client can mount with "xprtsec=none" a filesystem exported with
"xprtsec=tls:mtls" (in the sense that the client gets the filehandle and adds a
mount to its mount table - it can't actually access the mount).

Here's an example using machines from the recent Bakeathon.

Mounting a server with TLS enabled:

# mount -o v4.2,sec=sys,xprtsec=tls oracle-102.chuck.lever.oracle.com.nfsv4.dev:/export/tls /mnt
# umount /mnt

Trying to mount without "xprtsec=tls" shows that the filesystem is not exported with "xprtsec=none":

# mount -o v4.2,sec=sys oracle-102.chuck.lever.oracle.com.nfsv4.dev:/export/tls /mnt
mount.nfs: Operation not permitted for oracle-102.chuck.lever.oracle.com.nfsv4.dev:/export/tls on /mnt

Yet a v3 mount without "xprtsec=tls" works:

# mount -o v3,sec=sys oracle-102.chuck.lever.oracle.com.nfsv4.dev:/export/tls /mnt
# umount /mnt

and a mount with no explicit version and without "xprtsec=tls" falls back to
v3 and also "works":

# mount -o sec=sys oracle-102.chuck.lever.oracle.com.nfsv4.dev:/export/tls /mnt
# grep ora /proc/mounts
oracle-102.chuck.lever.oracle.com.nfsv4.dev:/export/tls /mnt nfs
+rw,relatime,vers=3,rsize=524288,wsize=524288,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=100.64.0.49,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=100.64.0.49 0 0

Even though the filesystem is mounted, the client can't do anything with it:

# ls /mnt
ls: cannot open directory '/mnt': Permission denied

When krb5 is used with NFSv3, the server returns a list of pseudoflavors in
mountres3_ok (https://datatracker.ietf.org/doc/html/rfc1813#section-5.2.1).
The client compares that list with its own list of auth flavors parsed from the
mount request and returns -EACCES if no match is found (see
nfs_verify_authflavors()).

Perhaps we should be doing something similar with xprtsec policies?  Should
there be an errata to RFC 9289 and a request from IANA for assigned numbers for
pseudo-flavors corresponding to xprtsec policies?

If not, this behavior should at least be documented in the man pages.

-Scott


