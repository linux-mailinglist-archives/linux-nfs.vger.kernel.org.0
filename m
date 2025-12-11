Return-Path: <linux-nfs+bounces-17030-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEDECB54C6
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Dec 2025 10:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC51030014C4
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Dec 2025 09:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD22D202F65;
	Thu, 11 Dec 2025 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gA/txvVO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D591D256C8D
	for <linux-nfs@vger.kernel.org>; Thu, 11 Dec 2025 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765443882; cv=none; b=jwYyumWW5uK+XFNZK6yY4xf3qTYQovrlcDg6Omi3ORfsqUtmmwamjR4JBSTCTGlkPhYdjPJg18dfonESfZCw3eX8WbaGwwAHD3MBOIGAXf0+0VG3aq7EZcNPlKjXXOhl7DmUGGhlvlpDKFSh1vaUq93P23lP/jrP7Nd56JAXmwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765443882; c=relaxed/simple;
	bh=UCIIXv9G4yVCDOpbXiC6JId9Thqzla0/Ovck4dx+7hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GR+GlpF2DxxUNL+SN6XS0lXS9fA8npsRiKBX4IUgPIH+Y2v3+ZcUfo5ofuAhxmfvVhGOnbwzzHbLPoc27QRtr+pA98nIH1+FfBkQNUD6yl/pv4FMV+RiKwTcLpzchWLCLatw7TYfQy0pvDupvw7k2bB+rGiFguXuzZNL8L+ia3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gA/txvVO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29558061c68so9345405ad.0
        for <linux-nfs@vger.kernel.org>; Thu, 11 Dec 2025 01:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765443879; x=1766048679; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5qXNOg66QNlCh/5oLojujcd3gpQl78YkarRtsp6bjLg=;
        b=gA/txvVO34SoYqggLQlRNIO3a4ZmaHaFam3EObGtKcFZk8CkZlRn3JfhkOGJ9t9Uqs
         Eb4Bhm9IYeT4ksrJLs3crHePQ9USOu5d6d1IxP6M2GiiZsBxKiofd7OW4PBAWyr8dwg4
         FDcSBLh68n2ks+CVG5hLGF42GHWd+6sPuwB8km1ORFKzimEZ+dBaGh274A3GGD5HnUcI
         OOdW93obJ7vdrTmpjiWUnUY2grqhsQtwABYK4QOSSs2fqcM7O5eGC5t7d5qTb/9a3+Vh
         9w494ZOBBdr44i4Tam8UpGQL5k+Mj/IqU/L+v790QM9KHH2WFGejoM3Nu4UfwIripoqB
         osZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765443879; x=1766048679;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5qXNOg66QNlCh/5oLojujcd3gpQl78YkarRtsp6bjLg=;
        b=Pz/SL7jphATRqAmhbzK/WdwVgwPceHRRIv/KARzvmAmD2pi+EgHVMGOUGfyIqHzJnN
         lr0w9pE7j2ZTyrdarmNYpzKW089YhDfpKPszhi2l6jetEB0QyjJz5aoPB7gbvCJREjQT
         4xdRDb+FqTog9n7vqzheUXXn7GBw4CCGdwmXkTll5ZNZAjAC8rTOARMX6ProNuRFJNAP
         4xLKZT1Ug713AAbCF3lAD/J2LtCfe4KAlzfHvJo/dw5WXcrYVZfec08rRFQzWnDgcGwG
         xMJ8lz65gzchlWVj9/LhElYN0YwmgU6BDqTrB7jQXvqUVRluCRISM+E9vo9BwUfhg/JN
         8VdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/qtvK4R+502XMihRKktK/TMP9jTPNL6QQciHKgiCgg7jwHAls+UEnAHrqZKL+f4aDGEVujs5b2r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXqTsjQWSpgAru0kXFRAzC2xzJf0lkJEk28nCxzjhOpxqgNs/b
	wdKb8f+mksKF/FleFyM1zM6eb4JhWYqQJ9Yrs8bhKyLA+2t0re2wBd/B
X-Gm-Gg: AY/fxX70XW7Fpxo+ga4z2yaQaQnkPPL+PRZ+c7D0YiFdVT/2/SuJz8uKmltrZvaF3DC
	cBv2lEqrwt8UNFf30PgcPCYmGjw1uMadLYmSaVM1pfD1s+WxpUfvtCM/7aPo6Wrsfg6WL0uxkAU
	yjLL6oFNiUAMiEwjApVh1cLFNXJRYs/QVD6SzlxG25txTSMsSVITJeo0quIZNsqJjQS6KL6YB2b
	CZe8wH8IbMfRdmDBTp17zptlWnkm8RrGsL+UBzea5/nfsNAYUHhm312XyjLl0agMzowod3kv7+L
	eIb0U6NOhrLU0XZnUK58HpmUKkucsfC7hsvt1dksAtNX3w2Wo+zm36ZNcAF9MFbZDRIAP2gCfd5
	pgBN+hJ2NAV3fqgBOkvc8nh8dSLCMxzzxUwQZrR6opYBdfoaBImH6aIf8Gk2V+dOLr+HEZh3m0Y
	lgrvHYGIa1T6rnw8tXf8Y=
X-Google-Smtp-Source: AGHT+IGCIvgH536sa8ZV4DbAJX/s5vEFxJM+ew5WoYn8m0d0rXmMd2jOunltk7ifFr/oYi+OG6pi/g==
X-Received: by 2002:a17:902:d4cf:b0:298:29e0:5f32 with SMTP id d9443c01a7336-29ec26b5217mr53020435ad.15.1765443878921;
        Thu, 11 Dec 2025 01:04:38 -0800 (PST)
Received: from google.com ([2401:fa00:95:201:8739:3cdd:8fc7:3115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9d36bf5sm17779355ad.24.2025.12.11.01.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 01:04:38 -0800 (PST)
Date: Thu, 11 Dec 2025 17:04:35 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Pycode <pycode42@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Removed unused variable
Message-ID: <aTqJI8CGTOkzNE2A@google.com>
References: <aTnfSQJ4QsfwTSf0@raspberrypi>
 <ca38feb0347cc38fd2fe3753628f7644a91aaa7a.camel@kernel.org>
 <aTpdYqy0Q5gGfr3p@raspberrypi>
 <aTpqizefLFrDlxbS@google.com>
 <aTpzbSVFCSgx7HJp@raspberrypi>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTpzbSVFCSgx7HJp@raspberrypi>

On Thu, Dec 11, 2025 at 08:31:57AM +0100, Pycode wrote:
> On Thu, Dec 11, 2025 at 02:54:03PM +0800, Kuan-Wei Chiu wrote:
> > On Thu, Dec 11, 2025 at 06:57:54AM +0100, Pycode wrote:
> > > On Thu, Dec 11, 2025 at 08:10:25AM +0900, Jeff Layton wrote:
> > > > A more descriptive title is preferred: "Remove unused variable from
> > > > nfs4_ff_alloc_deviceid_node()"
> > > > 
> > > 
> > > Thanks for the advices!
> > > 
> > > > On Wed, 2025-12-10 at 21:59 +0100, Pycode wrote:
> > > > > Signed-off-by: Pycode <pycode42@gmail.com>
> > > > > 
> > > > > Removed the unused variable ret in
> > > > > fs/nfs/flexfilelayout/flexfilelayoutdev.c
> > > > > 
> > > > > (Disclaimer this is my first patch, be sorry if I have done anything
> > > > > wrong!)
> > > > > ---
> > > > >  fs/nfs/flexfilelayout/flexfilelayoutdev.c | 4 +---
> > > > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> > > > > index c55ea8fa3bfa..9cd04e85d52f 100644
> > > > > --- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> > > > > +++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> > > > > @@ -53,7 +53,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
> > > > >  	u32 mp_count;
> > > > >  	u32 version_count;
> > > > >  	__be32 *p;
> > > > > -	int i, ret = -ENOMEM;
> > > > > +	int i = -ENOMEM;
> > > > >  
> > > > 
> > > > No need to initialize this.
> > > > 
> > > > >  	/* set up xdr stream */
> > > > >  	scratch = folio_alloc(gfp_flags, 0);
> > > > > @@ -88,7 +88,6 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
> > > > >  	if (list_empty(&dsaddrs)) {
> > > > >  		dprintk("%s: no suitable DS addresses found\n",
> > > > >  			__func__);
> > > > > -		ret = -ENOMEDIUM;
> > > > >  		goto out_err_drain_dsaddrs;
> > > > >  	}
> > > > >  
> > > > > @@ -134,7 +133,6 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
> > > > >  			dprintk("%s: [%d] unsupported ds version %d-%d\n", __func__,
> > > > >  				i, ds_versions[i].version,
> > > > >  				ds_versions[i].minor_version);
> > > > > -			ret = -EPROTONOSUPPORT;
> > > > >  			goto out_err_drain_dsaddrs;
> > > > >  		}
> > > > >  
> > > > 
> > > > What about the dprintk() at the bottom of this function? Does this
> > > > actually build?
> > > 
> > > There is no dprintk() at the bottom that used the variable.
> > 
> > At the bottom of this function, there is a dprintk call that refers to ret:
> > 
> > 	dprintk("%s ERROR: returning %d\n", __func__, ret);
> > 	return NULL;
> > 
> > This causes the build to fail:
> > 
> > In file included from ./include/asm-generic/bug.h:31,
> >                  from ./arch/x86/include/asm/bug.h:193,
> >                  from ./arch/x86/include/asm/alternative.h:9,
> >                  from ./arch/x86/include/asm/barrier.h:5,
> >                  from ./include/asm-generic/bitops/generic-non-atomic.h:7,
> >                  from ./include/linux/bitops.h:28,
> >                  from ./include/linux/kernel.h:23,
> >                  from ./include/linux/uio.h:8,
> >                  from ./include/linux/socket.h:8,
> >                  from ./include/uapi/linux/in.h:25,
> >                  from ./include/linux/in.h:19,
> >                  from ./include/linux/nfs_fs.h:22,
> >                  from fs/nfs/flexfilelayout/flexfilelayoutdev.c:10:
> > fs/nfs/flexfilelayout/flexfilelayoutdev.c: In function ‘nfs4_ff_alloc_deviceid_node’:
> > fs/nfs/flexfilelayout/flexfilelayoutdev.c:182:55: error: ‘ret’ undeclared (first use in this function); did you mean ‘net’?
> >   182 |         dprintk("%s ERROR: returning %d\n", __func__, ret);
> >       |                                                       ^~~
> > ./include/linux/printk.h:484:33: note: in definition of macro ‘printk_index_wrap’
> >   484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
> >       |                                 ^~~~~~~~~~~
> > ./include/linux/sunrpc/debug.h:36:41: note: in expansion of macro ‘printk’
> >    36 | #  define __sunrpc_printk(fmt, ...)     printk(KERN_DEFAULT fmt, ##__VA_ARGS__)
> >       |                                         ^~~~~~
> > ./include/linux/sunrpc/debug.h:42:17: note: in expansion of macro ‘__sunrpc_printk’
> >    42 |                 __sunrpc_printk(fmt, ##__VA_ARGS__);                    \
> >       |                 ^~~~~~~~~~~~~~~
> > ./include/linux/sunrpc/debug.h:25:9: note: in expansion of macro ‘dfprintk’
> >    25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
> >       |         ^~~~~~~~
> > fs/nfs/flexfilelayout/flexfilelayoutdev.c:182:9: note: in expansion of macro ‘dprintk’
> >   182 |         dprintk("%s ERROR: returning %d\n", __func__, ret);
> >       |         ^~~~~~~
> > fs/nfs/flexfilelayout/flexfilelayoutdev.c:182:55: note: each undeclared identifier is reported only once for each function it appears in
> >   182 |         dprintk("%s ERROR: returning %d\n", __func__, ret);
> >       |                                                       ^~~
> > ./include/linux/printk.h:484:33: note: in definition of macro ‘printk_index_wrap’
> >   484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
> >       |                                 ^~~~~~~~~~~
> > ./include/linux/sunrpc/debug.h:36:41: note: in expansion of macro ‘printk’
> >    36 | #  define __sunrpc_printk(fmt, ...)     printk(KERN_DEFAULT fmt, ##__VA_ARGS__)
> >       |                                         ^~~~~~
> > ./include/linux/sunrpc/debug.h:42:17: note: in expansion of macro ‘__sunrpc_printk’
> >    42 |                 __sunrpc_printk(fmt, ##__VA_ARGS__);                    \
> >       |                 ^~~~~~~~~~~~~~~
> > ./include/linux/sunrpc/debug.h:25:9: note: in expansion of macro ‘dfprintk’
> >    25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
> >       |         ^~~~~~~~
> > fs/nfs/flexfilelayout/flexfilelayoutdev.c:182:9: note: in expansion of macro ‘dprintk’
> >   182 |         dprintk("%s ERROR: returning %d\n", __func__, ret);
> >       |         ^~~~~~~
> > make[5]: *** [scripts/Makefile.build:287: fs/nfs/flexfilelayout/flexfilelayoutdev.o] Error 1
> > make[4]: *** [scripts/Makefile.build:556: fs/nfs/flexfilelayout] Error 2
> > make[3]: *** [scripts/Makefile.build:556: fs/nfs] Error 2
> > make[2]: *** [scripts/Makefile.build:556: fs] Error 2
> 
> Sorry, I didn't see that there were more returns because of the jumps. For some reason, it compiled without any problems for me.
> 
>
My guess is that this build failure only shows up with the debug config
on, which you don't seem to have enabled.

Regards,
Kuan-Wei

