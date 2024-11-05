Return-Path: <linux-nfs+bounces-7668-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E0D9BCCC4
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 13:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5821C21366
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 12:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84E91D3197;
	Tue,  5 Nov 2024 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJYfoeh1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0329C1E485
	for <linux-nfs@vger.kernel.org>; Tue,  5 Nov 2024 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809867; cv=none; b=uoNAspNLrkT8NuwsG9A7/GjSwihSxEMHHuyRvVdk3KqG9gYT/c+By0TQu1vXhycQR94/slW3+3Bkx/+KbAVeZiMrobcuncXzN3C7keY/ntsKphkY6igO4mF08B936Y7oYaQSzqktBeaKxlGKmStgNnZqE7kXtlT15eEO1zXdTyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809867; c=relaxed/simple;
	bh=ZVKoBwl134umizst904SYa6TKuMqrTq8Qrzvckt/LvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/Ux1t9VIxBW0msEmqF+9Kfv18J5lI/GAM07SzLhMnqwKdJuWj9Z0vJNfYBKmaN2pqv0C9Yl0N8jskXy43VB0vRdIb2pWjZ0j5nbkPQRBHoCGbHjGqyIUrhtj2NDH5bTN0+mKzfO+xBp8caYCX0cqniLgs6ubwTkbQT55ERf4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJYfoeh1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730809864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qS72k3xTu0s1okCCGzpHISwGaffSyCY0qwpREAG+PkQ=;
	b=VJYfoeh1edLW2QfoZ6VoKQomRcp0uJdn1iqvyjFf/fb53wob8cf6WjrpEGPSW5k9IKlrQ1
	TgwXXFmCG3Zu9Ct8hN7h32aF2+aN4QfBhQuW2+mgQ/NYbj3x3j1HISfz83r0+XxBZil0zP
	Scbr7xHG9zHwOpLQ5B5uI7z4/c9yKgw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-CcvIwhn9PXKyJeqMChfG6Q-1; Tue,
 05 Nov 2024 07:31:01 -0500
X-MC-Unique: CcvIwhn9PXKyJeqMChfG6Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54DAD19560BF;
	Tue,  5 Nov 2024 12:31:00 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.35])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 081331956052;
	Tue,  5 Nov 2024 12:31:00 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 3502121DF4C; Tue,  5 Nov 2024 07:30:58 -0500 (EST)
Date: Tue, 5 Nov 2024 07:30:58 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>
Cc: "'steved@redhat.com'" <steved@redhat.com>,
	"'sorenson@redhat.com'" <sorenson@redhat.com>,
	"'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RESEND] mount.nfs: retry NFSv3 mount after NFSv4 failure
 in auto negotiation
Message-ID: <ZyoQAgWdMawSn6ze@aion>
References: <OSZPR01MB77727651A22E3D89E72954DD88522@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSZPR01MB77727651A22E3D89E72954DD88522@OSZPR01MB7772.jpnprd01.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, 05 Nov 2024, Seiichi Ikarashi (Fujitsu) wrote:

> The problem happens when a v3 mount fails with ETIMEDOUT after
> the v4 mount failed with EPROTONOSUPPORT, in mount auto negotiation.
> It immediately breaks from the "for" loop in nfsmount_fg()
> or nfsmount_child() due to EPROTONOSUPPORT, never doing the expected
> retries until timeout.
> 
> [auto negotiation case]:
> 
> It breaks immediately.
> 
> # time mount.nfs -v 192.168.200.59:/exp /mnt
> mount.nfs: timeout set for Wed Oct 23 14:21:58 2024
> mount.nfs: trying text-based options 'vers=4.2,addr=192.168.200.59,clientaddr=192.168.200.187'
> mount.nfs: mount(2): Protocol not supported
> mount.nfs: trying text-based options 'vers=4,minorversion=1,addr=192.168.200.59,clientaddr=192.168.200.187'
> mount.nfs: mount(2): Protocol not supported
> mount.nfs: trying text-based options 'vers=4,addr=192.168.200.59,clientaddr=192.168.200.187'
> mount.nfs: mount(2): Protocol not supported
> mount.nfs: trying text-based options 'addr=192.168.200.59'
> mount.nfs: prog 100003, trying vers=3, prot=6
> mount.nfs: trying 192.168.200.59 prog 100003 vers 3 prot TCP port 2049
> mount.nfs: prog 100005, trying vers=3, prot=17
> mount.nfs: trying 192.168.200.59 prog 100005 vers 3 prot UDP port 20048
> mount.nfs: portmap query retrying: RPC: Timed out
> mount.nfs: prog 100005, trying vers=3, prot=6
> mount.nfs: trying 192.168.200.59 prog 100005 vers 3 prot TCP port 20048
> mount.nfs: portmap query failed: RPC: Timed out
> mount.nfs: Protocol not supported for 192.168.200.59:/exp on /mnt
> 
> real    0m13.027s
> user    0m0.002s
> sys     0m0.005s
> # 
> 
> [nfsvers=3 case]:
> 
> It retries until exceeding timeout as expected.
> 
> # time mount.nfs -v -o nfsvers=3 192.168.200.59:/exp /mnt
> mount.nfs: timeout set for Wed Oct 23 14:22:23 2024
> mount.nfs: trying text-based options 'nfsvers=3,addr=192.168.200.59'
> mount.nfs: prog 100003, trying vers=3, prot=6
> mount.nfs: trying 192.168.200.59 prog 100003 vers 3 prot TCP port 2049
> mount.nfs: prog 100005, trying vers=3, prot=17
> mount.nfs: trying 192.168.200.59 prog 100005 vers 3 prot UDP port 20048
> mount.nfs: portmap query retrying: RPC: Timed out
> mount.nfs: prog 100005, trying vers=3, prot=6
> mount.nfs: trying 192.168.200.59 prog 100005 vers 3 prot TCP port 20048
> mount.nfs: portmap query failed: RPC: Timed out
> (snip)
> mount.nfs: prog 100005, trying vers=3, prot=6
> mount.nfs: trying 192.168.200.59 prog 100005 vers 3 prot TCP port 20048
> mount.nfs: portmap query failed: RPC: Timed out
> mount.nfs: Connection timed out for 192.168.200.59:/exp on /mnt
> 
> real    2m10.152s
> user    0m0.007s
> sys     0m0.015s
> #
> 
> 
> Let's retry in auto negotiation case, too.
> 
> Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>

Should probably also have Fixes: a709f25c ("mount: Report correct error in the fall_back cases.")

Reviewed-by: Scott Mayhew <smayhew@redhat.com>

> ---
>  utils/mount/stropts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
> index a92c420..103c41f 100644
> --- a/utils/mount/stropts.c
> +++ b/utils/mount/stropts.c
> @@ -981,7 +981,7 @@ fall_back:
>  	if ((result = nfs_try_mount_v3v2(mi, FALSE)))
>  		return result;
>  
> -	if (errno != EBUSY && errno != EACCES)
> +	if (errno != EBUSY && errno != EACCES && errno != ETIMEDOUT)
>  		errno = olderrno;
>  
>  	return result;
> -- 
> 2.43.5
> 


