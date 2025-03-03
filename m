Return-Path: <linux-nfs+bounces-10459-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F94BA4E40D
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 16:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC254242E9
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 15:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB4C27E1C5;
	Tue,  4 Mar 2025 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8Ncmeal"
X-Original-To: linux-nfs@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCEC259CB8
	for <linux-nfs@vger.kernel.org>; Tue,  4 Mar 2025 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101867; cv=pass; b=QPHDIwfLzI6wI5FI72fFbezFDd8QtB5frh26fi467lOMS0L43A10aaYPezUOeR4bg3WHueLOdc22eNu9d1zxlGL7RXXF5UyG0QfxCwHiAh+DNE6JF7//GZlr8IwwObBajoOHDqVtIgVmVUM/VIQgJVwPShlOzNHxLMpLhDGUt60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101867; c=relaxed/simple;
	bh=NIkjVShdKRa5sGBLlP+sLIy3qEWBWoHE4n488XDvYok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYteOfBjKFxrwiaC9YN5JT50pfmJ1HmLvxjoTo0lu69XEFdADrS7nsIkcqHqtRvC8fcLFA99YZnr0tcbRffBGuhysK880KPbyJdWR4qck18SFjGi7s7VAkEvv86BM+fORC0Ox2VteqAPd7UIGlOOn00faDcS9Oat9xBD8+2iJ0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8Ncmeal; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 77D2640D571E
	for <linux-nfs@vger.kernel.org>; Tue,  4 Mar 2025 18:24:24 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=l8Ncmeal
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fZt3WPTzG0BL
	for <linux-nfs@vger.kernel.org>; Tue,  4 Mar 2025 18:23:18 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id BBF984272C; Tue,  4 Mar 2025 18:23:07 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8Ncmeal
X-Envelope-From: <linux-kernel+bounces-541889-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8Ncmeal
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 6C5BD42070
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 17:13:30 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 060EA3064C07
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 17:13:29 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4A03A96AE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641C4213E6F;
	Mon,  3 Mar 2025 14:13:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8BF1F4183;
	Mon,  3 Mar 2025 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011182; cv=none; b=PfTVTHhgfCyZXBPen9v3a7wJd4H1QQlx5mdjkfLIkAMcxtOxd9cZNn1krmTx/tqRPAtANj33gZ8EmBtTq2KYULl23xqB6dyDh4+7d/4NziwIARonMu2zz75/J+ynkVQbD06IaM4SfeiALnt4cegqGqiUWoUHz+rwrYAbe+CMrOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011182; c=relaxed/simple;
	bh=NIkjVShdKRa5sGBLlP+sLIy3qEWBWoHE4n488XDvYok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6rx5m5lLMJRoiAyG/8MMqkZcQ1w4K95/tzmh6WTjIlR672xWuCMh1i6hN1I6b2UDRadIZRTmRBsLz5bLRYNkF+hs3I+oAjtZYkhJDIAl8PVInZCvSiiOHAUnsiT2MZIcqh22jpgG4kD+D0zc3pFG9mzayst8x1wkahlpWkTDw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8Ncmeal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC87EC4CEE8;
	Mon,  3 Mar 2025 14:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741011182;
	bh=NIkjVShdKRa5sGBLlP+sLIy3qEWBWoHE4n488XDvYok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8NcmealtKOCjMDYfhdGZsoBwszh/QDHSXXyO9AkgtlA0A7pTR7/xFaGW34rZnnaz
	 YHS0EwxYVDs1NFXN+N2tSljRNN13wZmGh6sFsfuk0zt3imQMkQesFDN2Lqx+2b2NeD
	 o+omZ99N4G9TItj/1aVbVqOJjMPEX5em5uEm2F2rrL0aPFH1m7ScVFAyKghAtBCOFP
	 XWRW5JwHnscbK0tsgpyf5q+RHj8aOk+pSlm6/pKcYUJWhFECMznnK4DWOzq7ABL6k2
	 zI2//1NZ2NEPGWYm67q76imjrJSJRgiJLYR2HsOEilvxHei1l7N4qtTuJH3LllhEjS
	 aPRRlbXzLvdyg==
Date: Mon, 3 Mar 2025 15:12:57 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: nicolas.bouchinet@clip-os.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	linux-nfs@vger.kernel.org, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Joel Granados <j.granados@samsung.com>, Clemens Ladisch <clemens@ladisch.de>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jan Harkes <jaharkes@cs.cmu.edu>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Bart Van Assche <bvanassche@acm.org>, Zhu Yanjun <yanjun.zhu@linux.dev>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 2/6] sysctl: Fixes nsm_local_state bounds
Message-ID: <42t2lpwwwihg4heu4ogudt4fe5uz7trg3y2lsoqvmjnzmhnjmy@pebnborzqodv>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
 <20250224095826.16458-3-nicolas.bouchinet@clip-os.org>
 <da418443-a98b-4b08-ad44-7d45d89b4173@oracle.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da418443-a98b-4b08-ad44-7d45d89b4173@oracle.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fZt3WPTzG0BL
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741706614.57003@F+9AIC10glL3P6GDl9Skuw
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Feb 24, 2025 at 09:38:17AM -0500, Chuck Lever wrote:
> On 2/24/25 4:58 AM, nicolas.bouchinet@clip-os.org wrote:
> > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > 
> > Bound nsm_local_state sysctl writings between SYSCTL_ZERO
> > and SYSCTL_INT_MAX.
> > 
> > The proc_handler has thus been updated to proc_dointvec_minmax.
> > 
> > Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > ---
> >  fs/lockd/svc.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> > index 2c8eedc6c2cc9..984ab233af8b6 100644
> > --- a/fs/lockd/svc.c
> > +++ b/fs/lockd/svc.c
> > @@ -461,7 +461,9 @@ static const struct ctl_table nlm_sysctls[] = {
> >  		.data		= &nsm_local_state,
> >  		.maxlen		= sizeof(int),
> >  		.mode		= 0644,
> > -		.proc_handler	= proc_dointvec,
> > +		.proc_handler	= proc_dointvec_minmax,
> > +		.extra1		= SYSCTL_ZERO,
> > +		.extra2		= SYSCTL_INT_MAX,
> >  	},
> >  };
> >  
> 
> Hi Nicolas -
> 
> nsm_local_state is an unsigned 32-bit integer. The type of that value is
> defined by spec, because this value is exchanged between peers on the
> network.
> 
> Perhaps this patch should replace proc_dointvec with proc_douintvec
> instead.
As Nicolas stated, that is completely up to how you used the variable.

Things to notice:
1. If you want the full range of a unsigned long, then you should stop
   using proc_dointvec as it will upper limit the value to INT_MAX.
2. If you want to keep using nsm_local_state as unsigned int, then
   please add SYSCTL_ZERO as a lower bound to avoid assigning negative
   values
3. Having SYSCTL_INT_MAX is not necessary as it is already capped by
   proc_dointvec{_minmax,}, but it is nice to have as it makes explicit
   what is happening.

Let me know if you take this through your trees so I can remove it from
sysctl.

Reviewed-by: Joel Granados <joel.granados@kernel.org>

Best

> 
> 
> -- 
> Chuck Lever

-- 

Joel Granados


