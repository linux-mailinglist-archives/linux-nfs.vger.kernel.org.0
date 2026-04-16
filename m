Return-Path: <linux-nfs+bounces-20864-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP+HDxPq4Gl/nQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20864-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 15:54:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B105040F402
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 15:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32010302D5F3
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 13:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AA93D7D7B;
	Thu, 16 Apr 2026 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Bm77yj7r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333D63CD8D8
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776347569; cv=none; b=CjilG/Ev5a1O1PtHrKCP70oNQQ1GANrrj6GUUAP53L+nnMnANNM8GXQtT4mL7mDNopydH1h05ry4SePeRJ7T3C2KAl4o6Eo5nKaN4cjgMfFvYMJBIGGeQTaCh04txJ8SorfQjJp6WmGUT6HONv3Ijmb6M0y4WmSIF4f56gQSN1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776347569; c=relaxed/simple;
	bh=fR/tBoBER6gaLeI/7QI7VQve0Bl/0GNLwOyUMXYytLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTWWH2nSQp0YSVfWh06h19X1epRPeGodRjvbmhEAZsMCBaH7RKYvJyfjN4WcNqzFWeBuGNehcFo5/o2wIxb+i4Yd6uxErXkvWg3rzEwDiXw4IZ6zNmhF8nVjh6UE3bwH3nu4bE5I9kKjuCQ5nnx9q4HO1fleZZyAG3YRpnlVCDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Bm77yj7r; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 85cdf846-399b-11f1-8ff3-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 85cdf846-399b-11f1-8ff3-005056999439;
	Thu, 16 Apr 2026 15:52:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=RY3GV0svFcqA7cCPfaszOdrLtyZzjsraL0boACERiuo=;
	b=Bm77yj7rU+vFVFKmploFWuopQ4KP+9igOSdE0V5MOiwez+S33NTIsehbR1j0n6dXZu41MUPS/90DQ
	 YhiuMN1WLzUHU7KpmkEat0WYXoQzkIz8Og/kG5wSV2/5ImE1mxpiGGvI5aK76Tz7l80BRMAFs7nQ1d
	 CPy7X5zk9GXk51USXbyPp8KeSZ/XK3amZfb8WI4J3fSYe6UCbfx0iSIoOZXd3LiT/tBj6AwPFuYgQA
	 47Dytq6I7Yj7kQ4xjO4wXCZ2Nf5ipmHIPOVpcdHgNgLT53voKuqg0g3vuodBDCXAjAmrXvngNNtamV
	 eZk1FD/joeTHZPZTENk6OuS8hVJLjRQ==
X-KPN-MID: 33|SKts585cr2zFmJQ8YyKkgci4hPBI42ksYs/aslJTT0Xxn/5/EiobnXRqyHnOzvH
 sdJqHs49lRVAWOLYzfVfJBbhGeUXrowLvqdkHsEcuCm0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|EO0iyE5VadVg69F0c4xTu20RSvoYNTh4lUdRxSkFOravu4ka0cNe+tq1cWW2Zay
 NHnz46xH6R3GRJWVTZMYDPA==
Received: from localhost (142-169-144-85.ftth.glasoperator.nl [85.144.169.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 85299d3e-399b-11f1-9c0b-00505699d6e5;
	Thu, 16 Apr 2026 15:52:34 +0200 (CEST)
Date: Thu, 16 Apr 2026 15:52:34 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, 
	idryomov@gmail.com, amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	shuah@kernel.org, miklos@szeredi.hu, hansg@kernel.org
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
Message-ID: <aeDpIgfDaIKEaBcL@lt-jori.localdomain>
Mail-Followup-To: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Dorjoy Chowdhury <dorjoychy111@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, 
	idryomov@gmail.com, amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	shuah@kernel.org, miklos@szeredi.hu, hansg@kernel.org
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260328172314.45807-2-dorjoychy111@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20864-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xs4all.nl:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B105040F402
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 11:22:22PM +0600, Dorjoy Chowdhury wrote:
> diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/uapi/asm/fcntl.h
> index 50bdc8e8a271..fe488bf7c18e 100644
> --- a/arch/alpha/include/uapi/asm/fcntl.h
> +++ b/arch/alpha/include/uapi/asm/fcntl.h
> @@ -34,6 +34,7 @@
>  
>  #define O_PATH		040000000
>  #define __O_TMPFILE	0100000000
> +#define OPENAT2_REGULAR	0200000000
>

I don't quite understand why we are adding OPENAT2_REGULAR inside the
O_* flag range. Wasn't this supposed to be only supported for openat2()?
If so, I don't see the need to waste an O_* flag bit. But maybe I am
missing something.

Thanks,
Jori.

