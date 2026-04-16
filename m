Return-Path: <linux-nfs+bounces-20930-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDRRGG1W4Wl5rwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20930-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 23:36:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7285B414FC0
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 23:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97DCF301C5AA
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 21:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF88374E59;
	Thu, 16 Apr 2026 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="mVbaoHD6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C32358376
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776375397; cv=none; b=fNhVubtombck8ZLM7N9xQGdjP/U0zUyBMn1qIpFPwSzqpgiX/6/AdXOptFSYqD5u+v1/CNvCraUf02QsLF1wCtrkWzhiKj0WHJLm5PAHBATBARnWBAHzai7yl872/PQYFCiKsL9qmEtbxocswqgIRVNfK5e98xh+u2Az3c4WmHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776375397; c=relaxed/simple;
	bh=jKmGfrTxgv5Nzlz5bG0/V1+paVSZPlZlHvQ4Koh/BtY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=TCuRjLavNtfhZ3bpNG3e09B5urcbJImbWt1gCCZcTm23Lxf8JgCCMUTyFr9ikQAIO+nsd3bgvrdGXryZgRwb3511wR5RriSa8fvny4cBZqvLBi3KBhus4/gayVYf3WtFBlrchOVvDLkW7RXD1XVxSiV8cqTJnL9skixM6O5qctg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=mVbaoHD6; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 55b4a78a-39dc-11f1-89e1-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 55b4a78a-39dc-11f1-89e1-00505699b430;
	Thu, 16 Apr 2026 23:36:31 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 55b55afc-39dc-11f1-b5d0-0050569981f5;
	Thu, 16 Apr 2026 23:36:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=A0ZJnX7li7I6jRx+BpBjuz1TE53b3BpzgUYmmyhPmRQ=;
	b=mVbaoHD6W3jBI/UR7fZd3Uc0n+R+d0DLz3ZSMxUxJsvb4EITVIFQkms9MZL3Db9BAVLS2o8cv/dTX
	 /5ZSDNuwqcKbl9jWqEZJLZXzVC7tZQGTVAv8mXA6NqsVs3hgV1B6CWvZrgtedjx9vkg7PP0TlAgI/t
	 Z51GHR+tgWMurXSkBtEO3yRDNnBdJju5yn1ENwMmI56ScwZICAhLHRPNqF9ohiZPG5o4riAYEd3Jgj
	 S0bBHoQHG7rF5RcFRoyXEL9DbphtH/AwPBVqeERfrO87unuNMKdmp0TKLrXvWzCqqCqXyy80gwB894
	 ajuAqtQ+aQj78lhLARGjaT+dGSCt4Yw==
X-KPN-MID: 33|7vi6wAcTxLhnlcXV5bPS/elamfhtfRWYm/UV0z2B4o2PwwULSy0l0rmaam6eAl2
 1cwMwFHYd61Bx4F4EKfpDODrGcPs8rxAikHNnXDUzW5s=
X-CMASSUN: 33|3/aJ3D2OCmHajC0ZevX+EDdRCOA+SKZCNjgTYgI7wSgzIfzE+LI8baffU3Xbeyv
 Ny3c4duY5SQnT/0aED7RZFA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh02 (cpxoxapps-mh02.personalcloud.so.kpn.org [10.128.135.208])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 55a756fa-39dc-11f1-b8d7-005056995d6c;
	Thu, 16 Apr 2026 23:36:31 +0200 (CEST)
Date: Thu, 16 Apr 2026 23:36:31 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev, linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de,
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com,
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com,
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com,
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com,
	idryomov@gmail.com, amarkuze@redhat.com, slava@dubeyko.com,
	agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org,
	sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com,
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com,
	shuah@kernel.org, miklos@szeredi.hu, hansg@kernel.org,
	Aleksa Sarai <cyphar@cyphar.com>
Message-ID: <850388882.378351.1776375391778@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260416-aufbau-sorgenfrei-cfa87c9ddc11@brauner>
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com>
 <aeDpIgfDaIKEaBcL@lt-jori.localdomain>
 <CAFfO_h6pkyX=uN5uoXda6toTtT6KsahfBNBLom9i21HdZ7JOmQ@mail.gmail.com>
 <1714293523.333222.1776351806025@kpc.webmail.kpnmail.nl>
 <20260416-aufbau-sorgenfrei-cfa87c9ddc11@brauner>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20930-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	HAS_X_PRIO_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[44];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,kernel.org,oracle.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu,cyphar.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,xs4all.nl:dkim]
X-Rspamd-Queue-Id: 7285B414FC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> Op 16-04-2026 17:15 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
>  
> On Thu, Apr 16, 2026 at 05:03:26PM +0200, Jori Koolstra wrote:
> > 
> > If I recall correctly, Aleksa has suggested we might also want to add
> > O_EMPTYPATH to openat() instead of only allowing this for openat2().
> > I am waiting to see what Christian thinks of this.
> 
> We can do that, yes. For O_EMPTYPATH that is workable.

All right, then I'll update the patch this weekend.

> 
> I don't mind too much if we leave OPENAT2_REGUALR in the 32-bit flag
> space. It'll silently be ignored but the flag name should give it away.

I would also prefer to have the bits separated. Although it is unlikely
that we will add so many O_* that we will ever run out of space, it just
seems cleaner, and at no cost. But it's not too important.

Thanks,
Jori.

