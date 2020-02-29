Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4F174850
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Feb 2020 18:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgB2RLV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 29 Feb 2020 12:11:21 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43795 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbgB2RLV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 29 Feb 2020 12:11:21 -0500
Received: by mail-pg1-f194.google.com with SMTP id u12so3177975pgb.10
        for <linux-nfs@vger.kernel.org>; Sat, 29 Feb 2020 09:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxace-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TqK34GZ24XFNJM/Ncs6QWbpG1bOx5K5MlXOOEm5aGq8=;
        b=k5CZ9H9e8LXPXKB+w2ZbqG3QsE526jzHxKAiiAWybQi/tHe5SffSlImhamD1T5uu4q
         N570LlnDB/c34DBYOOCqvag08ahc9zzziHpwFZ01smnjSFoZFTgoCUiDTImPSaK8DOjp
         cFRbzD+/ellSIDlAi3QfsVnEohMeIy/6pQDji+lapI0SHxR/43/Kd0sKJlOKO7rq2aIc
         FwZiG/T6a7Zc+FT26cKEPvZmiJdm1MrFmY57kuVUOPtlbVPDW2ih8iY9KZzkxqusM5iC
         vr6mTWMZAvTtQWnvbySj6wD6I2792h921/xnFb0VdOPcBHXoXRnI/lFGLNBWp1MBxXlE
         C27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TqK34GZ24XFNJM/Ncs6QWbpG1bOx5K5MlXOOEm5aGq8=;
        b=sHtlnBtM7CJHzq2SqTIkmPHG8seIUnuIbgZP+Z4vuVE0P5xVEtIzxTSUMVa9qnsNaG
         RQRg3ymnaDWd+ZcG+Z/qO7cRcE3woVVoBZ6sCLFI+mtx8xWYcLR5h291lufelkyKrvXI
         jI6IWPzrPVIgPRBG5cbCBft2Arv0GvMLJnpZGg6DlVh8IoJRoXyXRvzvfqN8RqGq1q2j
         rou5Bu2tDNt5RzOsw7OrgNFw9GAZN+k1Wx8q/DZSZ2w7pLkQ9ZcMd8MR6U582OXMaGCz
         MUKQRxCaE3nh6lz9nieqhpzMWx5KkOTS8ItlK8vZlWabLVXYpE7JQcMlrUPDyL+LsJRD
         d3sQ==
X-Gm-Message-State: APjAAAXdcmmJPFDHt0Sq6FUydYpTFkTfMxLbEFvvYCf64tGFFDbVg4P4
        Y/UV70bgXZDkxLKCaQdUBnV7LAnucY4=
X-Google-Smtp-Source: APXvYqx/S+cZqCljVQ7uxMTJ66LUUU5C0GeVPfLKPzugtwC8Lz4JTGCG/+zHyDczYx3FktlTpW4pHg==
X-Received: by 2002:a62:1a16:: with SMTP id a22mr10075047pfa.34.1582996280571;
        Sat, 29 Feb 2020 09:11:20 -0800 (PST)
Received: from home.linuxace.com (cpe-76-91-193-165.socal.res.rr.com. [76.91.193.165])
        by smtp.gmail.com with ESMTPSA id 1sm11404726pff.11.2020.02.29.09.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 09:11:19 -0800 (PST)
Date:   Sat, 29 Feb 2020 09:11:17 -0800
From:   Phil Oester <kernel@linuxace.com>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: NFS "fileid changed" errors since 5.3
Message-ID: <20200229171117.GA66753@home.linuxace.com>
References: <20200227023914.GC33510@home.linuxace.com>
 <CAN-5tyEN-3x-vEUXvch6Xv_e2x0us2XwVcZGpC4-0vsL2f9n7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyEN-3x-vEUXvch6Xv_e2x0us2XwVcZGpC4-0vsL2f9n7w@mail.gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Feb 28, 2020 at 11:29:24AM -0500, Olga Kornievskaia wrote:
> On Wed, Feb 26, 2020 at 9:39 PM Phil Oester <kernel@linuxace.com> wrote:
> >
> > When running on 5.3 or 5.4 kernels and mounting a Netapp filer via NFSv3
> > and accessing the .snapshot directory, "fileid changed" errors appear
> > in dmesg.  Reverting these 2 patches solves the issue:
> >
> > eb3d8f42231aec: NFS: Fix inode fileid checks in attribute revalidation code
> > 7e10cc25bfa0dd: NFS: Don't refresh attributes with mounted-on-file information
> >
> > Various condition checks changed around printing that error in these
> > commits, but I'm unclear whether the errors are spurious or something
> > I should actually be concerned about.  Thoughts?
> >
> 
> Hi Phil,
> 
> Can you provide a bit more about your Netapp setup? Netapp version and
> any kind of setup you have enabled (like are you using qtrees? have
> you toggles v4-fsid-change?) ,. I can't reproduce this on my setup.

Hi Olga,

The Netapp is running Ontap 9.6P2.  This particular volume has no qtrees.
Also I have not toggled v4-fsid-change, but as noted I am mounting the
volume via NFSv3, so this should not be related.

Some additional information I've found: the fileid changes also occur on
a 4.19.106 kernel, but on that kernel there is no error printed.  So this
again leads me to believe that this is a common occurrence, but the conditionals
which changed in 5.3+ kernels only now are causing it to be printed.

From 4.19.106:

[root@hq1-kvm9 (stg) poester] # ls -i /var/lib/libvirt/images/.snapshot | grep daily.2020-02-2._0010    
70566464 daily.2020-02-28_0010
70573019 daily.2020-02-29_0010
[root@hq1-kvm9 (stg) poester] # ls -i /var/lib/libvirt/images/.snapshot | grep daily.2020-02-2._0010    
70566464 daily.2020-02-28_0010
70573019 daily.2020-02-29_0010
[root@hq1-kvm9 (stg) poester] # find /var/lib/libvirt/images/.snapshot > /dev/null
[root@hq1-kvm9 (stg) poester] # ls -i /var/lib/libvirt/images/.snapshot | grep daily.2020-02-2._0010    
70566464 daily.2020-02-28_0010
70572864 daily.2020-02-29_0010 <=== Note fileid changed here

Nothing showed up in dmesg on that kernel, but in the 5.4.latest stable kernel
that would cause the "fileid changed" error to print.

Thanks,
Phil
