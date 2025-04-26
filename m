Return-Path: <linux-nfs+bounces-11297-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E81A9DD10
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Apr 2025 22:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A574846320A
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Apr 2025 20:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46929208D0;
	Sat, 26 Apr 2025 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WucHg92Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220451E1308
	for <linux-nfs@vger.kernel.org>; Sat, 26 Apr 2025 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745698667; cv=none; b=f+a+71JKnuYUMxIdv45RtbOwMO8YQAeQiXQHd5Fd6/zPjQps3SxHRsS0pY1MWW8gT2C9Dvs5OWilRE45HvzzQYAPMkysre21KwwWLwb/sIS69Y+6HcY5EgzymkMZqad2q5PGU8dcO1FCP/o2Z5YVSj5CnkHk+CPBloGQaHGn0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745698667; c=relaxed/simple;
	bh=baTy+CRjFr9atA2o0vFk8tZAXPsxlLnGPe9/gvJstDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTE8CLz4YAvfgJTEGis6jJWMJ2dRw02OHuSLnP6IUr3TPqCFlFHaTuC37ouahj1b+0s4mgNrwjVGxV8BCFdDqXsPVoTNHM0SSwmu26u2ShcVuEgKiUQrGtYF7zwDKurTxLLSbM82OVjvcwe1MWL3TBrq7bunPEkPnFSJUFHWhRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WucHg92Y; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3913b539aabso1926479f8f.2
        for <linux-nfs@vger.kernel.org>; Sat, 26 Apr 2025 13:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745698663; x=1746303463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKEM/y7M4LOZuWsNOEs+yu9ipSps8OF6zqHS5ZoQopE=;
        b=WucHg92Y3Lca/ltLEqbJLODMpC/6zMR5Q/ZTVvHUuVlxaTVUbD201Fs4SgOg+C5cdm
         Qj25Cv5RHwrZVZQl8gfZcM9pIP/TD3AjtrOnqk3o1twH/N7TBrg4ZSyKvuHIFzGSnRgg
         6AmMl4UlqLRfxn5S75aEAEgVRL1ZLYL1Vy24JW2EP1aLcI4vFitE1gvqarckc2O5UYku
         pyZnI3G4dbI2NcvE/kXc9892c92xBUCUfBxrOoPI39MG/RY1ElNu8rLX9oMuvs6lr5V9
         Q1VBb9360bGMAej3P/RoT0OA/cdE2NxBsDbTC4flCMVu4mpo3mxRPBztxhGdJfZ7/Rw2
         iuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745698663; x=1746303463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKEM/y7M4LOZuWsNOEs+yu9ipSps8OF6zqHS5ZoQopE=;
        b=oJzkqhQKsEZ9Qzdv+AFV5lgikfaqcasUbVpN47x25J1T78aZNL0YO+hNk4PT7h9uYc
         BBezK44tU8VoNua2aLBJV4r78jq12aqB8WoKx94esyzM3x0V3YFqMnxPFWD/Tx4nC3+g
         plctuuCbZ97x03Xe4qhL6yKe05JNCD4yeVCwqZucGgF6bi7c+oOkCEjQ/tGf8CnuUnXw
         i9aHNZwtStcsCbvOFPUa75bKyav672Ww7G2+DLxH29Ds7MHDC855APS05sHhbWjp9AxT
         eXv2rfLdLXn7C9R6jte8cJYawx2UfsNfftmU3hW0E1dgCjPWuD/6jXyE2Mw37qZFaG83
         dvCg==
X-Forwarded-Encrypted: i=1; AJvYcCWr0JPDDuxqowVlWa+fEnvLG4VbaUE/gnf24DH+Ldbj/sfvrPOyl/Fofs8nv/LGP3cANoqkempQJnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztPqhrHL66aUREN7dFXmli6WyZgq8d33Knf/+WBJj4bDnz4OI9
	teN/U0YjGwFUWW4hMNbwTFNZL9GIAmUoDIgY/S9/wYvwze+fBDlZ
X-Gm-Gg: ASbGnctBQpe72n3AUlnwHn7Zdbc7gpABRETFRgg/L/UzL1Fq0mLAZOoIG1JCQ3J1+lx
	QcQEEodiQBPQFN5oPaPEx+i74xQlBmZlyT8cKJbHLw2YPc+5z7Pvz2crsF7wBZxd1wFeEBGXNOT
	zb0D4Ez9ZwTgJ/1McDcQXO2bzFNDv2bgwrKyWW5OsGAB2spOsPXxQVmPNn+H1WminP+w2Mghysc
	YLnAjBpfsTI4Mdj92XpWkHXCcrm/dPKKfg7M7eZR0gklEiS/KG/E8NYMxsn67SJld9Bp5IQUr5y
	Wt6SU1nLhx6stc8ffgeUtS6ePK97sEM3OeeMbQajLnEI3bCMG3ws0NTydjOeR/HbE/1RcfeI1g=
	=
X-Google-Smtp-Source: AGHT+IHOkaftGjBLxYV42+A0J8lT57ZQ8dgM5ldCpBk2GAGiNpydf0VtX055W2iSJu4W4fqz/om++g==
X-Received: by 2002:a05:6000:1a86:b0:391:49f6:dad4 with SMTP id ffacd0b85a97d-3a07ab85d74mr2691046f8f.41.1745698662918;
        Sat, 26 Apr 2025 13:17:42 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5c68esm6424643f8f.82.2025.04.26.13.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 13:17:41 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id B3DCFBE2DE0; Sat, 26 Apr 2025 22:17:39 +0200 (CEST)
Date: Sat, 26 Apr 2025 22:17:39 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: nfsdctl: lockd configuration failure reported after updating to
 nfs-utils-2.8.3
Message-ID: <aA0_Y__aFKua1LZn@eldamar.lan>
References: <aAyVdfJT4uMUeA6s@eldamar.lan>
 <351c3498e26be45d139137dade13c4c63798f637.camel@kernel.org>
 <aAzJLb9-eweYSXVK@eldamar.lan>
 <a99a35da06712b9337913bb90e647447fdfefe51.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a99a35da06712b9337913bb90e647447fdfefe51.camel@kernel.org>

Hi Jeff,

On Sat, Apr 26, 2025 at 08:49:36AM -0400, Jeff Layton wrote:
> On Sat, 2025-04-26 at 13:53 +0200, Salvatore Bonaccorso wrote:
> > Hi Jeff,
> > 
 
> > On Sat, Apr 26, 2025 at 06:55:42AM -0400, Jeff Layton wrote:
> > > On Sat, 2025-04-26 at 10:12 +0200, Salvatore Bonaccorso wrote:
> > > > Hi
> > > > 
> > > > After updating in Debian nfs-utils to 2.8.3, a systemctl status
> > > > nfs-server.service shows:
> > > > 
> > > > nfsdctl: lockd configuration failure
> > > > 
> > > > For reproducing the case the nfs.conf is kept to the default
> > > > (commented) section. 
> > > > 
> > > > In Debian we do not use the system linux/lockd_netlink.h (where the
> > > > changes only seem to have merged upstream in 6.15-rc1) and use the
> > > > shipped copy in nfs-utils instead.
> > > > 
> > > > I do not see problems with mounts, so I suspect the problem a user
> > > > reported downstream in https://bugs.debian.org/1104096 is just
> > > > cosmetical?
> > > > 
> > > > nfsdctl nlm reports:
> > > > 
> > > > nfsdctl: nfsd not found
> > > > 
> > > 
> > > The errors are harmless. They just means that you're running a new
> > > version of nfs-utils on top of an old kernel that doesn't have the
> > > netlink control interfaces for knfsd. The systemd service will fall
> > > back to starting the server with the legacy rpc.nfsd program if that
> > > fails so everything should still work after that.
> > 
> > Thanks for the confirmation. This aligns with what I found while
> > experimenting, and yes for me all works still after that on the system
> > with the exports.
> > 
> > We are running 6.12.y in Debian trixie, but having 2.8.3 available
> > already, so yes this has not the new interfaces.
> > 
> > I wonder if you will still count that as regression as before in 2.8.2
> > a nfsdctl autostart would bring still up the nfsd's.
> > 
> > With 2.8.2 and the 6.12.y kernel:
> > 
> > root@sid:~# ps -C nfsd
> >     PID TTY          TIME CMD
> >    1842 ?        00:00:00 nfsd
> >    1843 ?        00:00:00 nfsd
> >    1844 ?        00:00:00 nfsd
> >    1845 ?        00:00:00 nfsd
> >    1846 ?        00:00:00 nfsd
> >    1847 ?        00:00:00 nfsd
> >    1848 ?        00:00:00 nfsd
> >    1849 ?        00:00:00 nfsd
> >    1850 ?        00:00:00 nfsd
> >    1851 ?        00:00:00 nfsd
> >    1852 ?        00:00:00 nfsd
> >    1853 ?        00:00:00 nfsd
> >    1854 ?        00:00:00 nfsd
> >    1855 ?        00:00:00 nfsd
> >    1856 ?        00:00:00 nfsd
> >    1857 ?        00:00:00 nfsd
> > root@sid:~# nfsdctl threads 0
> > root@sid:~# ps -C nfsd
> >     PID TTY          TIME CMD
> > root@sid:~# nfsdctl autostart
> > root@sid:~# ps -C nfsd
> >     PID TTY          TIME CMD
> >    1874 ?        00:00:00 nfsd
> >    1875 ?        00:00:00 nfsd
> >    1876 ?        00:00:00 nfsd
> >    1877 ?        00:00:00 nfsd
> >    1878 ?        00:00:00 nfsd
> >    1879 ?        00:00:00 nfsd
> >    1880 ?        00:00:00 nfsd
> >    1881 ?        00:00:00 nfsd
> >    1882 ?        00:00:00 nfsd
> >    1883 ?        00:00:00 nfsd
> >    1884 ?        00:00:00 nfsd
> >    1885 ?        00:00:00 nfsd
> >    1886 ?        00:00:00 nfsd
> >    1887 ?        00:00:00 nfsd
> >    1888 ?        00:00:00 nfsd
> >    1889 ?        00:00:00 nfsd
> > root@sid:~# uname -a
> > Linux sid 6.12.25-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.12.25-1 (2025-04-25) x86_64 GNU/Linux
> > root@sid:~#
> > 
> > But after updating to 2.8.3 not. I wonder if the new interface can be
> > made at runtime be used if a new enough kernel is available and
> > otherwise fall back again to the 2.8.2 behaviour?
> > 
> > What do you think? (I can as well ask the same just on the public
> > thread if we want to have a public record on linux-nfs list).
> > 
> 
> Sorry about the private reply. I just mashed the wrong button in my
> MUA.

Thanks for confirming, since nothing private will include the public
list again to have the answer documented, thanks a lot again for your
insights and explanation.

> Actually this is probably a bugfix and the earlier autostart
> functioning was a regression. The older nfsdctl version just ignored
> [lockd] parameters in nfs.conf and wouldn't configure it properly. So
> it started nfsd, but lockd wouldn't have gotten the right port settings
> or the configured gracetime.

Ok so likely not a regression from 2.8.2 -> 2.8.3 but actually a
bugfix.

> If you don't have any [lockd] settings, then nfsdctl should still work
> with no fallback to rpc.nfsd.

Actually it contains only the emtpy [lockd] stanza, but no explict
settings so just the defaults. But you are correct, if even comment
out the '[lockd]' from the default (as shipped upstream) then nfsdctl
autostart works as expected.

Thank you again for the swift replies, very much appreciated.

Regards,
Salvatore

